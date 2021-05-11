Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C4237A045
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhEKHFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:05:09 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:34449 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhEKHFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:05:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620716641; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/3St8vspwlaMJv2fv4wvq0SBdS7FrQGyxt0HzhIqFZQ=; b=fTSHJVu/Fd+aVJ1CW4337WtU/U2dPY008ZyjQ4AIH+EuWso4gffo246gvt1IcOqhdQZ2feJL
 JJ6xKMR5fDN1BgpCN4H0vQxHlXOE5amZM0H8gVVJfFisaQ2q7CVVwKgoKkQDeNnY8CoP5FwC
 m/xHfe85Ydr/j7c7Q1ElLoTmJ2A=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 609a2c60da4b8b1332fca687 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 May 2021 07:04:00
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E8C8C433D3; Tue, 11 May 2021 07:04:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B40BAC43145;
        Tue, 11 May 2021 07:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B40BAC43145
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v2] usb: dwc3: gadget: Replace list_for_each_entry_safe() if using giveback
Date:   Tue, 11 May 2021 00:03:56 -0700
Message-Id: <1620716636-12422-1-git-send-email-wcheng@codeaurora.org>
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
        ->dwc3_gadget_del_and_unmap_request()- n+1 deleted[cancelled_list]
        ->spin_unlock

Fixes: d4f1afe5e896 ("usb: dwc3: gadget: move requests to cancelled_list")
Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
Reviewed-by: Peter Chen <peter.chen@kernel.org>
---
Changes in v2:
 - Updated commit message with context call stack of an example scenario
   seen on device.

 drivers/usb/dwc3/gadget.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index dd80e5c..efa939b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1737,10 +1737,10 @@ static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *r
 static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
 {
 	struct dwc3_request		*req;
-	struct dwc3_request		*tmp;
 	struct dwc3			*dwc = dep->dwc;
 
-	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
+	while (!list_empty(&dep->cancelled_list)) {
+		req = next_request(&dep->cancelled_list);
 		dwc3_gadget_ep_skip_trbs(dep, req);
 		switch (req->status) {
 		case DWC3_REQUEST_STATUS_DISCONNECTED:
@@ -2935,11 +2935,11 @@ static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event, int status)
 {
 	struct dwc3_request	*req;
-	struct dwc3_request	*tmp;
 
-	list_for_each_entry_safe(req, tmp, &dep->started_list, list) {
+	while (!list_empty(&dep->started_list)) {
 		int ret;
 
+		req = next_request(&dep->started_list);
 		ret = dwc3_gadget_ep_cleanup_completed_request(dep, event,
 				req, status);
 		if (ret)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

