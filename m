Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B0234B761
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 14:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhC0NWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 09:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhC0NWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 09:22:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19870C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 06:22:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f124so11777657ybc.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=f/DBLe4KTA9RqJn86/pzVqOe/xE6FrGxuCNjYapdtDU=;
        b=e6lIxx9x/ADMJsqALVlOjB0j26X5QE7RWxalBCt9e+lvBXenQFYFpVDgT/uR5baKRO
         duzmw5c+UBLud/zELDmpIFLr1UnfodDFCfMqyW5AkrDIxP7KCyoPfXv39iT/lEb0cR7x
         lDZnBdbLyt3CrPnh8jpocsmNy9t8W5Zbn0JylXB0ol4UndI3+DdmAJNJEmIXSeG8kc7U
         lR/lTHUhYDlVOUiJvom93SzMYf7hCsUUrqHWRWuSgMaCCXtTLnVlclhJ3TDqzjxFncAa
         5fagnRWb8SO62EISWIw97O2641AsLh+LsstUYulPOXr6EUFwo30aY1zL0Ln0uR7i4mOq
         WnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=f/DBLe4KTA9RqJn86/pzVqOe/xE6FrGxuCNjYapdtDU=;
        b=LAtPF4522wdwn5bn4bcpVRcc42agNHvpbXEx9j3FnAxJB2ik6BUEFLIRZAg1Tt7XJr
         jLFrqC5WhkjP/phV5ugSN5dWIjjf0MELk594ojx/w+gAbYgvkH16ceufbd5Tqg6R+jc6
         3AZNj7XH8Rqy4xYWKLtdBAI2TI+oIF7vQodbQikXmWP2Nmp2k05qxYcHH7KUCxyDqe3V
         rbgWq2eDjHg9j4G8iCxuh0lleDrEuue0+jkWPUH1v/AXu26LDUVylcETMubcYNq0/oHl
         mjSQKX5T4GqjuufbCU5ZNslmCm/SGxLvUmB7T3AatcQ79szDAhFz1pb/xaqVM1p+uq7B
         a6rg==
X-Gm-Message-State: AOAM531CMA96TuMFNfklaV6ppRg8xdTRbY6bleU+n5J3bUlEi+bZxE1i
        BTdgFmhJ/4rCcdyuQbcvfCw2QnJJ5jg=
X-Google-Smtp-Source: ABdhPJwm9ZqrPGU3UfTYgFqcHstQ12M9ZU0ah6gNTAwAmJXJXJ1qqhdJLRTKrgnhjUmu8eg33P4mVMJ3Q58=
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:dd96:b17f:940b:5260])
 (user=raychi job=sendgmr) by 2002:a25:ce13:: with SMTP id x19mr24310864ybe.235.1616851328101;
 Sat, 27 Mar 2021 06:22:08 -0700 (PDT)
Date:   Sat, 27 Mar 2021 21:22:02 +0800
Message-Id: <20210327132202.1759953-1-raychi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [Patch v3] usb: dwc3: add cancelled reasons for dwc3 requests
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
-ECONNRESET for all requests. It will cause USB function drivers
can't know if the requests are cancelled by other reasons.

This patch will replace DWC3_REQUEST_STATUS_CANCELLED with the
reasons below.
  - DWC3_REQUEST_STATUS_DISCONNECTED
  - DWC3_REQUEST_STATUS_DEQUEUED
  - DWC3_REQUEST_STATUS_STALLED

Signed-off-by: Ray Chi <raychi@google.com>
---
 drivers/usb/dwc3/core.h   | 12 +++++++-----
 drivers/usb/dwc3/gadget.c | 24 ++++++++++++++++++++----
 drivers/usb/dwc3/gadget.h |  6 ++++--
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4ca4b4be85e4..51a3eec2428a 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -908,11 +908,13 @@ struct dwc3_request {
 	unsigned int		remaining;
 
 	unsigned int		status;
-#define DWC3_REQUEST_STATUS_QUEUED	0
-#define DWC3_REQUEST_STATUS_STARTED	1
-#define DWC3_REQUEST_STATUS_CANCELLED	2
-#define DWC3_REQUEST_STATUS_COMPLETED	3
-#define DWC3_REQUEST_STATUS_UNKNOWN	-1
+#define DWC3_REQUEST_STATUS_QUEUED		0
+#define DWC3_REQUEST_STATUS_STARTED		1
+#define DWC3_REQUEST_STATUS_DISCONNECTED	2
+#define DWC3_REQUEST_STATUS_DEQUEUED		3
+#define DWC3_REQUEST_STATUS_STALLED		4
+#define DWC3_REQUEST_STATUS_COMPLETED		5
+#define DWC3_REQUEST_STATUS_UNKNOWN		-1
 
 	u8			epnum;
 	struct dwc3_trb		*trb;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e1442fc763e1..492086519539 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1402,7 +1402,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		dwc3_stop_active_transfer(dep, true, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
-			dwc3_gadget_move_cancelled_request(req);
+			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
 
 		/* If ep isn't started, then there's no end transfer pending */
 		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
@@ -1729,10 +1729,25 @@ static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
 {
 	struct dwc3_request		*req;
 	struct dwc3_request		*tmp;
+	struct dwc3			*dwc = dep->dwc;
 
 	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
 		dwc3_gadget_ep_skip_trbs(dep, req);
-		dwc3_gadget_giveback(dep, req, -ECONNRESET);
+		switch (req->status) {
+		case DWC3_REQUEST_STATUS_DISCONNECTED:
+			dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+			break;
+		case DWC3_REQUEST_STATUS_DEQUEUED:
+			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			break;
+		case DWC3_REQUEST_STATUS_STALLED:
+			dwc3_gadget_giveback(dep, req, -EPIPE);
+			break;
+		default:
+			dev_err(dwc->dev, "request cancelled with wrong reason:%d\n", req->status);
+			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			break;
+		}
 	}
 }
 
@@ -1776,7 +1791,8 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			 * cancelled.
 			 */
 			list_for_each_entry_safe(r, t, &dep->started_list, list)
-				dwc3_gadget_move_cancelled_request(r);
+				dwc3_gadget_move_cancelled_request(r,
+						DWC3_REQUEST_STATUS_DEQUEUED);
 
 			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
 
@@ -1848,7 +1864,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		dwc3_stop_active_transfer(dep, true, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
-			dwc3_gadget_move_cancelled_request(req);
+			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
 
 		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
 			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 0cd281949970..77df4b6d6c13 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -90,15 +90,17 @@ static inline void dwc3_gadget_move_started_request(struct dwc3_request *req)
 /**
  * dwc3_gadget_move_cancelled_request - move @req to the cancelled_list
  * @req: the request to be moved
+ * @reason: cancelled reason for the dwc3 request
  *
  * Caller should take care of locking. This function will move @req from its
  * current list to the endpoint's cancelled_list.
  */
-static inline void dwc3_gadget_move_cancelled_request(struct dwc3_request *req)
+static inline void dwc3_gadget_move_cancelled_request(struct dwc3_request *req,
+		unsigned int reason)
 {
 	struct dwc3_ep		*dep = req->dep;
 
-	req->status = DWC3_REQUEST_STATUS_CANCELLED;
+	req->status = reason;
 	list_move_tail(&req->list, &dep->cancelled_list);
 }
 
-- 
2.31.0.291.g576ba9dcdaf-goog

