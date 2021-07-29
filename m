Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF953D9E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 09:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhG2HdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 03:33:24 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:57715 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhG2HdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:33:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627544000; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4dgDA5U7bl0B0ZrmuX/lx0/KoPyld4ncHKTgBOfdJns=; b=Hl4w+fWyh1SWdKAwwqmF2v/LrMVLSzOu55pSZorEzVgfbm+oTZVuev+/C7rlSaXtyAwdb229
 MXsq7r4BpCI/FSPBGZdq0WCXqCRTGUkbsTYak9M+YM7uCQy1gmpUD2b+1dHiDgJAUVJe/esQ
 OFq6/2yugewZnMSgmZ2gNR/0mh8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 610259be290ea35ee6de35de (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Jul 2021 07:33:18
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 01AF7C433F1; Thu, 29 Jul 2021 07:33:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 968BFC4338A;
        Thu, 29 Jul 2021 07:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 968BFC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH] usb: dwc3: gadget: Use list_replace_init() before traversing lists
Date:   Thu, 29 Jul 2021 00:33:14 -0700
Message-Id: <1627543994-20327-1-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list_for_each_entry_safe() macro saves the current item (n) and
the item after (n+1), so that n can be safely removed without
corrupting the list.  However, when traversing the list and removing
items using gadget giveback, the DWC3 lock is briefly released,
allowing other routines to execute.  There is a situation where, while
items are being removed from the cancelled_list using
dwc3_gadget_ep_cleanup_cancelled_requests(), the pullup disable
routine is running in parallel (due to UDC unbind).  As the cleanup
routine removes n, and the pullup disable removes n+1, once the
cleanup retakes the DWC3 lock, it references a request who was already
removed/handled.  With list debug enabled, this leads to a panic.
Ensure all instances of the macro are replaced where gadget giveback
is used.

Example call stack:

Thread#1:
__dwc3_gadget_ep_set_halt() - CLEAR HALT
  -> dwc3_gadget_ep_cleanup_cancelled_requests()
    ->list_for_each_entry_safe()
    ->dwc3_gadget_giveback(n)
      ->dwc3_gadget_del_and_unmap_request()- n deleted[cancelled_list]
      ->spin_unlock
      ->Thread#2 executes
      ...
    ->dwc3_gadget_giveback(n+1)
      ->Already removed!

Thread#2:
dwc3_gadget_pullup()
  ->waiting for dwc3 spin_lock
  ...
  ->Thread#1 released lock
  ->dwc3_stop_active_transfers()
    ->dwc3_remove_requests()
      ->fetches n+1 item from cancelled_list (n removed by Thread#1)
      ->dwc3_gadget_giveback()
        ->dwc3_gadget_del_and_unmap_request()- n+1
deleted[cancelled_list]
        ->spin_unlock

Fix this condition by utilizing list_replace_init(), and traversing
through a local copy of the current elements in the endpoint lists.
This will also set the parent list as empty, so if another thread is
also looping through the list, it will be empty on the next iteration.

Fixes: d4f1afe5e896 ("usb: dwc3: gadget: move requests to cancelled_list")
Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>

---
Previous patchset:
https://lore.kernel.org/linux-usb/1620716636-12422-1-git-send-email-wcheng@codeaurora.org/
---
 drivers/usb/dwc3/gadget.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a29a4ca..3ce6ed9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1926,9 +1926,13 @@ static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
 {
 	struct dwc3_request		*req;
 	struct dwc3_request		*tmp;
+	struct list_head		local;
 	struct dwc3			*dwc = dep->dwc;
 
-	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
+restart:
+	list_replace_init(&dep->cancelled_list, &local);
+
+	list_for_each_entry_safe(req, tmp, &local, list) {
 		dwc3_gadget_ep_skip_trbs(dep, req);
 		switch (req->status) {
 		case DWC3_REQUEST_STATUS_DISCONNECTED:
@@ -1946,6 +1950,9 @@ static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
 			break;
 		}
 	}
+
+	if (!list_empty(&dep->cancelled_list))
+		goto restart;
 }
 
 static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
@@ -3190,8 +3197,12 @@ static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
 {
 	struct dwc3_request	*req;
 	struct dwc3_request	*tmp;
+	struct list_head	local;
 
-	list_for_each_entry_safe(req, tmp, &dep->started_list, list) {
+restart:
+	list_replace_init(&dep->started_list, &local);
+
+	list_for_each_entry_safe(req, tmp, &local, list) {
 		int ret;
 
 		ret = dwc3_gadget_ep_cleanup_completed_request(dep, event,
@@ -3199,6 +3210,9 @@ static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
 		if (ret)
 			break;
 	}
+
+	if (!list_empty(&dep->started_list))
+		goto restart;
 }
 
 static bool dwc3_gadget_ep_should_continue(struct dwc3_ep *dep)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

