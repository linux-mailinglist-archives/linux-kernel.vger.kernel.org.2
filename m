Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D490831DD35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhBQQVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:21:50 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:57779 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233128AbhBQQVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:21:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613578869; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=g6ScauTX2Wi/Zz8wHvhSihq2xKuqDUU1NLocqRH9Yi8=; b=cuVBodplEsJMMUyyxtE5R3b2CpKkg0IsWWpKAOhNIUReEyNIyEMqY1gSHVbt6EX40PgdF88l
 qQz4ImvEh75i4knStnkPYe8uLTKzqgpzPTo6RNsq8V/zdWJIH9rkmEkKjVm866tp6USgXRSf
 14g0A5jQLCEUi3Erq+8d8iaaROc=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 602d425297484ee2acb6df33 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 16:20:34
 GMT
Sender: jhugo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A5F15C43462; Wed, 17 Feb 2021 16:20:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jhugo-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67971C433CA;
        Wed, 17 Feb 2021 16:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67971C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org, hemantk@codeaurora.org
Cc:     bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2] bus: mhi: core: Sanity check values from remote device before use
Date:   Wed, 17 Feb 2021 09:20:22 -0700
Message-Id: <1613578822-18614-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When parsing the structures in the shared memory, there are values which
come from the remote device.  For example, a transfer completion event
will have a pointer to the tre in the relevant channel's transfer ring.
Such values should be considered to be untrusted, and validated before
use.  If we blindly use such values, we may access invalid data or crash
if the values are corrupted.

If validation fails, drop the relevant event.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---

v2: Fix subject

 drivers/bus/mhi/core/main.c | 81 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index c043574..1eb2fd3 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -242,6 +242,11 @@ static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
 	smp_wmb();
 }
 
+static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
+{
+	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
+}
+
 int mhi_destroy_device(struct device *dev, void *data)
 {
 	struct mhi_device *mhi_dev;
@@ -383,7 +388,16 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
 	struct mhi_event_ctxt *er_ctxt =
 		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
 	struct mhi_ring *ev_ring = &mhi_event->ring;
-	void *dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+	dma_addr_t ptr = er_ctxt->rp;
+	void *dev_rp;
+
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event ring rp points outside of the event ring\n");
+		return IRQ_HANDLED;
+	}
+
+	dev_rp = mhi_to_virtual(ev_ring, ptr);
 
 	/* Only proceed if event ring has pending events */
 	if (ev_ring->rp == dev_rp)
@@ -536,6 +550,11 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 		struct mhi_buf_info *buf_info;
 		u16 xfer_len;
 
+		if (!is_valid_ring_ptr(tre_ring, ptr)) {
+			dev_err(&mhi_cntrl->mhi_dev->dev,
+				"Event element points outside of the tre ring\n");
+			break;
+		}
 		/* Get the TRB this event points to */
 		ev_tre = mhi_to_virtual(tre_ring, ptr);
 
@@ -695,6 +714,12 @@ static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
 	struct mhi_chan *mhi_chan;
 	u32 chan;
 
+	if (!is_valid_ring_ptr(mhi_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event element points outside of the cmd ring\n");
+		return;
+	}
+
 	cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
 
 	chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
@@ -719,6 +744,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	u32 chan;
 	int count = 0;
+	dma_addr_t ptr = er_ctxt->rp;
 
 	/*
 	 * This is a quick check to avoid unnecessary event processing
@@ -728,7 +754,13 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
 		return -EIO;
 
-	dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event ring rp points outside of the event ring\n");
+		return -EIO;
+	}
+
+	dev_rp = mhi_to_virtual(ev_ring, ptr);
 	local_rp = ev_ring->rp;
 
 	while (dev_rp != local_rp) {
@@ -834,6 +866,8 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			 */
 			if (chan < mhi_cntrl->max_chan) {
 				mhi_chan = &mhi_cntrl->mhi_chan[chan];
+				if (!mhi_chan->configured)
+					break;
 				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
 				event_quota--;
 			}
@@ -845,7 +879,15 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 
 		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
 		local_rp = ev_ring->rp;
-		dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+
+		ptr = er_ctxt->rp;
+		if (!is_valid_ring_ptr(ev_ring, ptr)) {
+			dev_err(&mhi_cntrl->mhi_dev->dev,
+				"Event ring rp points outside of the event ring\n");
+			return -EIO;
+		}
+
+		dev_rp = mhi_to_virtual(ev_ring, ptr);
 		count++;
 	}
 
@@ -868,11 +910,18 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 	int count = 0;
 	u32 chan;
 	struct mhi_chan *mhi_chan;
+	dma_addr_t ptr = er_ctxt->rp;
 
 	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
 		return -EIO;
 
-	dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event ring rp points outside of the event ring\n");
+		return -EIO;
+	}
+
+	dev_rp = mhi_to_virtual(ev_ring, ptr);
 	local_rp = ev_ring->rp;
 
 	while (dev_rp != local_rp && event_quota > 0) {
@@ -886,7 +935,8 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 		 * Only process the event ring elements whose channel
 		 * ID is within the maximum supported range.
 		 */
-		if (chan < mhi_cntrl->max_chan) {
+		if (chan < mhi_cntrl->max_chan &&
+		    mhi_cntrl->mhi_chan[chan].configured) {
 			mhi_chan = &mhi_cntrl->mhi_chan[chan];
 
 			if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
@@ -900,7 +950,15 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 
 		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
 		local_rp = ev_ring->rp;
-		dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+
+		ptr = er_ctxt->rp;
+		if (!is_valid_ring_ptr(ev_ring, ptr)) {
+			dev_err(&mhi_cntrl->mhi_dev->dev,
+				"Event ring rp points outside of the event ring\n");
+			return -EIO;
+		}
+
+		dev_rp = mhi_to_virtual(ev_ring, ptr);
 		count++;
 	}
 	read_lock_bh(&mhi_cntrl->pm_lock);
@@ -1365,6 +1423,7 @@ static void mhi_mark_stale_events(struct mhi_controller *mhi_cntrl,
 	struct mhi_ring *ev_ring;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	unsigned long flags;
+	dma_addr_t ptr;
 
 	dev_dbg(dev, "Marking all events for chan: %d as stale\n", chan);
 
@@ -1372,7 +1431,15 @@ static void mhi_mark_stale_events(struct mhi_controller *mhi_cntrl,
 
 	/* mark all stale events related to channel as STALE event */
 	spin_lock_irqsave(&mhi_event->lock, flags);
-	dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+
+	ptr = er_ctxt->rp;
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event ring rp points outside of the event ring\n");
+		dev_rp = ev_ring->rp;
+	} else {
+		dev_rp = mhi_to_virtual(ev_ring, ptr);
+	}
 
 	local_rp = ev_ring->rp;
 	while (dev_rp != local_rp) {
-- 
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

