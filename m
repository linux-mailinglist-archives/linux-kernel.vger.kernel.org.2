Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20503372439
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 03:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhEDBWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 21:22:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61475 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEDBWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 21:22:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620091302; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=aYFnbLK3UhrNMVkVfVwz9H5JgxqxEAJnwmD+LtSWESo=; b=eHvNbG9Y+ONMARAYP1wiCqM5hP43jNSnVn2RrxF8JI3vAsQnfxBj+7WffCXgmr/nDU6shP3e
 NMR0jCqNO3YPfiZrVrGaF05QRh/e+TnHcX7vtXbXEwG0oJC1VG/rwP2Y0jVi8lmY2A7v/1RC
 iM4l1Ex/o3d4aWU/rbJkWtbLHHc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6090a19e8807bcde1d570d1b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 May 2021 01:21:34
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E53BC4338A; Tue,  4 May 2021 01:21:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C45F4C433D3;
        Tue,  4 May 2021 01:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C45F4C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thinh.Nguyen@synopsys.com, jackp@codeaurora.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request for queuing error
Date:   Mon,  3 May 2021 18:21:04 -0700
Message-Id: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error is received when issuing a start or update transfer
command, the error handler will stop all active requests (including
the current USB request), and call dwc3_gadget_giveback() to notify
function drivers of the requests which have been stopped.  Avoid
having to cancel the current request which is trying to be queued, as
the function driver will handle the EP queue error accordingly.
Simply unmap the request as it was done before, and allow previously
started transfers to be cleaned up.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
---
Changes in v2:
 - Addressed feedback received by making sure the logic only applies to a req
   which is being queued, decrementing the enqueue pointer, and only clearing
   the HWO bit.

 drivers/usb/dwc3/gadget.c | 75 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index dd80e5c..c8ddbe1 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -140,6 +140,29 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 }
 
 /**
+ * dwc3_ep_dec_trb - decrement a trb index.
+ * @index: Pointer to the TRB index to increment.
+ *
+ * The index should never point to the link TRB. After decrementing,
+ * if index is zero, wrap around to the TRB before the link TRB.
+ */
+static void dwc3_ep_dec_trb(u8 *index)
+{
+	(*index)--;
+	if (*index < 0)
+		*index = DWC3_TRB_NUM - 1;
+}
+
+/**
+ * dwc3_ep_dec_enq - decrement endpoint's enqueue pointer
+ * @dep: The endpoint whose enqueue pointer we're decrementing
+ */
+static void dwc3_ep_dec_enq(struct dwc3_ep *dep)
+{
+	dwc3_ep_dec_trb(&dep->trb_enqueue);
+}
+
+/**
  * dwc3_ep_inc_trb - increment a trb index.
  * @index: Pointer to the TRB index to increment.
  *
@@ -1352,7 +1375,26 @@ static int dwc3_prepare_trbs(struct dwc3_ep *dep)
 
 static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep);
 
-static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
+static void dwc3_gadget_ep_revert_trbs(struct dwc3_ep *dep, struct dwc3_request *req)
+{
+	int i;
+
+	if (!req->trb)
+		return;
+
+	for (i = 0; i < req->num_trbs; i++) {
+		struct dwc3_trb *trb;
+
+		trb = &dep->trb_pool[dep->trb_enqueue];
+		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+		dwc3_ep_dec_enq(dep);
+	}
+
+	req->num_trbs = 0;
+}
+
+static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep,
+				       struct dwc3_request *queued_req)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	struct dwc3_request		*req;
@@ -1410,8 +1452,23 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 
 		dwc3_stop_active_transfer(dep, true, true);
 
-		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
-			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
+		/*
+		 * In order to ensure the logic is applied to a request being
+		 * queued by dwc3_gadget_ep_queue(), it needs to explicitly
+		 * check that req is the same as queued_req (request being
+		 * queued).  If so, then just unmap and decrement the enqueue
+		 * pointer, as the usb_ep_queue() error handler in the function
+		 * driver will handle cleaning up the USB request.
+		 */
+		list_for_each_entry_safe(req, tmp, &dep->started_list, list) {
+			if (req == queued_req) {
+				dwc3_gadget_ep_revert_trbs(dep, req);
+				dwc3_gadget_del_and_unmap_request(dep, req, ret);
+			} else {
+				dwc3_gadget_move_cancelled_request(req,
+								   DWC3_REQUEST_STATUS_DEQUEUED);
+			}
+		}
 
 		/* If ep isn't started, then there's no end transfer pending */
 		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
@@ -1546,7 +1603,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 	dep->start_cmd_status = 0;
 	dep->combo_num = 0;
 
-	return __dwc3_gadget_kick_transfer(dep);
+	return __dwc3_gadget_kick_transfer(dep, NULL);
 }
 
 static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
@@ -1593,7 +1650,7 @@ static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 	for (i = 0; i < DWC3_ISOC_MAX_RETRIES; i++) {
 		dep->frame_number = DWC3_ALIGN_FRAME(dep, i + 1);
 
-		ret = __dwc3_gadget_kick_transfer(dep);
+		ret = __dwc3_gadget_kick_transfer(dep, NULL);
 		if (ret != -EAGAIN)
 			break;
 	}
@@ -1684,7 +1741,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		}
 	}
 
-	return __dwc3_gadget_kick_transfer(dep);
+	return __dwc3_gadget_kick_transfer(dep, req);
 }
 
 static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
@@ -1893,7 +1950,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 
 		if ((dep->flags & DWC3_EP_DELAY_START) &&
 		    !usb_endpoint_xfer_isoc(dep->endpoint.desc))
-			__dwc3_gadget_kick_transfer(dep);
+			__dwc3_gadget_kick_transfer(dep, NULL);
 
 		dep->flags &= ~DWC3_EP_DELAY_START;
 	}
@@ -2992,7 +3049,7 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 		(list_empty(&dep->pending_list) || status == -EXDEV))
 		dwc3_stop_active_transfer(dep, true, true);
 	else if (dwc3_gadget_ep_should_continue(dep))
-		if (__dwc3_gadget_kick_transfer(dep) == 0)
+		if (__dwc3_gadget_kick_transfer(dep, NULL) == 0)
 			no_started_trb = false;
 
 out:
@@ -3106,7 +3163,7 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
 
 	if ((dep->flags & DWC3_EP_DELAY_START) &&
 	    !usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		__dwc3_gadget_kick_transfer(dep);
+		__dwc3_gadget_kick_transfer(dep, NULL);
 
 	dep->flags &= ~DWC3_EP_DELAY_START;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

