Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE2134914E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCYLzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhCYLys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:54:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A54C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 04:54:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d3so1672067ybk.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 04:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ikLgmRAmctyhP9E2Kd6Mo/ZLj4wWce8h02FacFXyEtQ=;
        b=Vw5vnKK7UFsOz+6sl0VNdfUgwheXMGOl1X8NUTpPCok2o1MObp7k4SHZV6bZTbLMAB
         j7MoVHKqMG+cFUs7cZf94WlGctw2xWYaE6eMdEpH1UhDEDn3sraQY3114QQtrI08xfDj
         SE3U+TNIbINEuBGVqH3YrFYrs9g0iF4l6cqrqRFl6EwPyecfyd5mKvi8L6ONXfvsWDld
         OZHCUz8RN9LAX79m23TUWkGOUwef7SUgj1EAYFLDhmKJaWTUUvHfObxm/y75CNcckzxR
         7U0ivx5dnihGnOlVvicDOgh9yd8AEFHD8NNI5MfNZkoaU0pjRdTZ8sd25Vj8lpHoEeuq
         lacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ikLgmRAmctyhP9E2Kd6Mo/ZLj4wWce8h02FacFXyEtQ=;
        b=etfuPROkBW80J8AROGokluPu34ozzcfBAt26wkZ1Bdbf32kwTDmamzeuLZP4LlvISH
         fe/dp0prFn7sEunARO7eeKwFjmAbQ6/R184YQy03l0/3v1X6ZgvX5zPQ7D+P6eEcJXM0
         ZmmEWshUdthUhNsHJLR8z4fgwJ9pR1T+7FzQqO+1jsRW+DE1BnBxFtWMGQOYptW6606O
         JJqcqLDVxuKgUAIPO049AVn9BegeQinUvJokBvJLNtI6TpT8sPZI8rGjDHhIA9dOSXfD
         5WOWYfsGP7iO0M9aFBX76PBJfEW/oouv1Z3XXBFqTUn5H/08O9EXOEdSvA72Xe9idwUe
         WdIg==
X-Gm-Message-State: AOAM530PvXwRG4AnKcadzMwfTThXn/gQNSdAx5qMRbzZzQUKcemZKjGu
        /97oS7Qj7d45t/FUxCKsQemMTBrLNTw=
X-Google-Smtp-Source: ABdhPJyVNer/NremsS8yTd2Fa3OjjSiWRdmqEQyiWBmvb1b80EbvmlnoCSMZq7cLpUz1qgY6nlrJOgiOgek=
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:ce8:375c:966a:532c])
 (user=raychi job=sendgmr) by 2002:a25:16d4:: with SMTP id 203mr11317016ybw.80.1616673283555;
 Thu, 25 Mar 2021 04:54:43 -0700 (PDT)
Date:   Thu, 25 Mar 2021 19:54:36 +0800
Message-Id: <20210325115436.861299-1-raychi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH] usb: dwc3: add cancelled reason for dwc3 requests
From:   Ray Chi <raychi@google.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        albertccwang@google.com, Ray Chi <raychi@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when dwc3 handles request cancelled, dwc3 just returns
-ECONNRESET for all requests. It will cause USB class drivers can't
know if the requests are cancelled by other reasons.

This patch will add the reason when the requests are cancelled.

Signed-off-by: Ray Chi <raychi@google.com>
---
 drivers/usb/dwc3/gadget.c |  6 +++---
 drivers/usb/dwc3/gadget.h | 10 +++++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e1442fc763e1..cc65fc064078 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1402,7 +1402,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		dwc3_stop_active_transfer(dep, true, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
-			dwc3_gadget_move_cancelled_request(req);
+			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_DEQUEUED);
 
 		/* If ep isn't started, then there's no end transfer pending */
 		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
@@ -1776,7 +1776,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			 * cancelled.
 			 */
 			list_for_each_entry_safe(r, t, &dep->started_list, list)
-				dwc3_gadget_move_cancelled_request(r);
+				dwc3_gadget_move_cancelled_request(r, DWC3_REQUEST_DEQUEUED);
 
 			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
 
@@ -1848,7 +1848,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		dwc3_stop_active_transfer(dep, true, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
-			dwc3_gadget_move_cancelled_request(req);
+			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STALL);
 
 		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
 			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 0cd281949970..a23e85bd3933 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -56,6 +56,12 @@ struct dwc3;
 
 /* Frame/Microframe Number Mask */
 #define DWC3_FRNUMBER_MASK		0x3fff
+
+/* Cancel reason for dwc3 request */
+#define DWC3_REQUEST_DEQUEUED		-ECONNRESET  /* Request get dequeued */
+#define DWC3_REQUEST_DISCONNECTED	-ESHUTDOWN   /* Device is disconnected/disabled */
+#define DWC3_REQUEST_STALL		-EPIPE       /* Bus or protocol error */
+
 /* -------------------------------------------------------------------------- */
 
 #define to_dwc3_request(r)	(container_of(r, struct dwc3_request, request))
@@ -90,15 +96,17 @@ static inline void dwc3_gadget_move_started_request(struct dwc3_request *req)
 /**
  * dwc3_gadget_move_cancelled_request - move @req to the cancelled_list
  * @req: the request to be moved
+ * @reason: cancelled reason for the dwc3 request
  *
  * Caller should take care of locking. This function will move @req from its
  * current list to the endpoint's cancelled_list.
  */
-static inline void dwc3_gadget_move_cancelled_request(struct dwc3_request *req)
+static inline void dwc3_gadget_move_cancelled_request(struct dwc3_request *req, int reason)
 {
 	struct dwc3_ep		*dep = req->dep;
 
 	req->status = DWC3_REQUEST_STATUS_CANCELLED;
+	req->request.status = reason;
 	list_move_tail(&req->list, &dep->cancelled_list);
 }
 
-- 
2.31.0.291.g576ba9dcdaf-goog

