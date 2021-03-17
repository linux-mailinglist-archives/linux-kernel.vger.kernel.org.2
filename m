Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB3033F841
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhCQSj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhCQSiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:38:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBDEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:38:53 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y200so1742968pfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UAxYgTJ8xiP4XZVnDR92h/oyODoJt823YPaFX/5CcQk=;
        b=ioW0Mn1xhNkhgHjp4pzr50k54/EF8Enwpqtp1cEWvgnrcC+lNBwFe7qVqcWSFL4P2X
         0hSHDw2yhwOMJfPjbnV9lit2wJ7ErPE/NVEfJz4g48Nt6dlm3ysihHbMgb511ntN6IG6
         kaThXQ6XinIP4vjMjzxJ2U4zZRpVTJeJQXYcnFS44VbaLMZjNrp3ohehc4fzCYe0wYX/
         Q1xKoCqU3dFz1ackTjkeeDuaOOzQj4CjKffRJ7BLNmNfwG+y+dL8Lkc2f/c+aaqpyaS3
         xtiinmJUURQBQw2b3vN3UKEM26sXml87ar+bpiZw3+/GtG7zE4b3BkPl6MNwk6Eev3P6
         RNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UAxYgTJ8xiP4XZVnDR92h/oyODoJt823YPaFX/5CcQk=;
        b=Tb6a3jIKZ8Dtpg1/v9I8xXFUJvwlu7ntMg+r6RjYtaCFXrkvkk76mmX85CiHX40+mf
         QxheEEFjSbgiieOg46LzP4sXBEuS0menpEGKrKAGtx6Y/2OXM3wp4uStJxNvsspSAE2q
         ygsvSCcVEGlF4+wDFbEzzCnYIli6sYaOZk4wxvpmhCcbGMWlbRcNxI2xEeorlb7sPNJB
         bPkwVvewUmIXd4a3DF/scwnK0z0C7rEdS6+3vntoLCj015H7qegcwnD8gXNPa2MYj5v5
         9LkgvY4d4350vkJwmMvZJpvcjBOf6oVcjCFP/zXqvnpdlM0IqYsG8cvC9n3BS0xJmZgJ
         WmLg==
X-Gm-Message-State: AOAM532f7L/RYZSv5dQfLuAgxKD6o9oscl0KEfhFYmVaAymkOyA8Hxp2
        9r7QM1upqmpGBhQzrcSHKRNMNSIZo5KeiQ==
X-Google-Smtp-Source: ABdhPJzoGLR/WnU8lAmQ5r8+4xzJPxLgSGecJIUOMByK2tLMna5pTLk9ejyjl55HqpKPqiFJo8G1iw==
X-Received: by 2002:a63:e42:: with SMTP id 2mr3782293pgo.100.1616006333176;
        Wed, 17 Mar 2021 11:38:53 -0700 (PDT)
Received: from mahak-Inspiron-7570 ([103.37.201.168])
        by smtp.gmail.com with ESMTPSA id z8sm3369883pjr.57.2021.03.17.11.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:38:52 -0700 (PDT)
From:   Mahak Gupta <gmahak1@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Mahak Gupta <gmahak1@gmail.com>
Subject: [PATCH] staging: octeon-usb: Match alignment with open parenthesis
Date:   Thu, 18 Mar 2021 00:08:46 +0530
Message-Id: <20210317183846.4867-1-gmahak1@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches fixes the checks- 'Alignment should match open parenthesis'
of 'checkpatch.pl'.

Signed-off-by: Mahak Gupta <gmahak1@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 32 +++++++++++++------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index e2f8b6b67f75..f27f20a4aa2d 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -1258,7 +1258,7 @@ static void cvmx_usb_poll_tx_fifo(struct octeon_hcd *usb)
 		union cvmx_usbcx_hptxsts tx_status;
 
 		tx_status.u32 = cvmx_usb_read_csr32(usb,
-					CVMX_USBCX_HPTXSTS(usb->index));
+						    CVMX_USBCX_HPTXSTS(usb->index));
 		if (cvmx_usb_fill_tx_hw(usb, &usb->periodic,
 					tx_status.s.ptxfspcavail))
 			USB_SET_FIELD32(CVMX_USBCX_GINTMSK(usb->index),
@@ -1272,7 +1272,7 @@ static void cvmx_usb_poll_tx_fifo(struct octeon_hcd *usb)
 		union cvmx_usbcx_gnptxsts tx_status;
 
 		tx_status.u32 = cvmx_usb_read_csr32(usb,
-					CVMX_USBCX_GNPTXSTS(usb->index));
+						    CVMX_USBCX_GNPTXSTS(usb->index));
 		if (cvmx_usb_fill_tx_hw(usb, &usb->nonperiodic,
 					tx_status.s.nptxfspcavail))
 			USB_SET_FIELD32(CVMX_USBCX_GINTMSK(usb->index),
@@ -1298,13 +1298,13 @@ static void cvmx_usb_fill_tx_fifo(struct octeon_hcd *usb, int channel)
 
 	/* We only need to fill data on outbound channels */
 	hcchar.u32 = cvmx_usb_read_csr32(usb,
-			CVMX_USBCX_HCCHARX(channel, usb->index));
+					 CVMX_USBCX_HCCHARX(channel, usb->index));
 	if (hcchar.s.epdir != CVMX_USB_DIRECTION_OUT)
 		return;
 
 	/* OUT Splits only have data on the start and not the complete */
 	usbc_hcsplt.u32 = cvmx_usb_read_csr32(usb,
-				CVMX_USBCX_HCSPLTX(channel, usb->index));
+					      CVMX_USBCX_HCSPLTX(channel, usb->index));
 	if (usbc_hcsplt.s.spltena && usbc_hcsplt.s.compsplt)
 		return;
 
@@ -1313,7 +1313,7 @@ static void cvmx_usb_fill_tx_fifo(struct octeon_hcd *usb, int channel)
 	 * words.
 	 */
 	usbc_hctsiz.u32 = cvmx_usb_read_csr32(usb,
-				CVMX_USBCX_HCTSIZX(channel, usb->index));
+					      CVMX_USBCX_HCTSIZX(channel, usb->index));
 	if (!usbc_hctsiz.s.xfersize)
 		return;
 
@@ -1360,7 +1360,7 @@ static void cvmx_usb_start_channel_control(struct octeon_hcd *usb,
 	union cvmx_usbcx_hctsizx usbc_hctsiz;
 
 	usbc_hctsiz.u32 = cvmx_usb_read_csr32(usb,
-				CVMX_USBCX_HCTSIZX(channel, usb->index));
+					      CVMX_USBCX_HCTSIZX(channel, usb->index));
 
 	switch (transaction->stage) {
 	case CVMX_USB_STAGE_NON_CONTROL:
@@ -1517,7 +1517,7 @@ static void cvmx_usb_start_channel(struct octeon_hcd *usb, int channel,
 
 		/* Clear all channel status bits */
 		usbc_hcint.u32 = cvmx_usb_read_csr32(usb,
-					CVMX_USBCX_HCINTX(channel, usb->index));
+						     CVMX_USBCX_HCINTX(channel, usb->index));
 
 		cvmx_usb_write_csr32(usb,
 				     CVMX_USBCX_HCINTX(channel, usb->index),
@@ -1552,7 +1552,7 @@ static void cvmx_usb_start_channel(struct octeon_hcd *usb, int channel,
 
 		/* Enable the channel interrupt to propagate */
 		usbc_haintmsk.u32 = cvmx_usb_read_csr32(usb,
-					CVMX_USBCX_HAINTMSK(usb->index));
+							CVMX_USBCX_HAINTMSK(usb->index));
 		usbc_haintmsk.s.haintmsk |= 1 << channel;
 		cvmx_usb_write_csr32(usb, CVMX_USBCX_HAINTMSK(usb->index),
 				     usbc_haintmsk.u32);
@@ -1836,7 +1836,7 @@ static void cvmx_usb_start_channel(struct octeon_hcd *usb, int channel,
  * Returns: Pipe or NULL if none are ready
  */
 static struct cvmx_usb_pipe *cvmx_usb_find_ready_pipe(struct octeon_hcd *usb,
-		enum cvmx_usb_transfer xfer_type)
+						      enum cvmx_usb_transfer xfer_type)
 {
 	struct list_head *list = usb->active_pipes + xfer_type;
 	u64 current_frame = usb->frame_number;
@@ -2309,7 +2309,8 @@ static int cvmx_usb_cancel(struct octeon_hcd *usb,
 		CVMX_SYNCW;
 
 		usbc_hcchar.u32 = cvmx_usb_read_csr32(usb,
-				CVMX_USBCX_HCCHARX(pipe->channel, usb->index));
+						      CVMX_USBCX_HCCHARX(pipe->channel,
+									 usb->index));
 		/*
 		 * If the channel isn't enabled then the transaction already
 		 * completed.
@@ -2605,11 +2606,12 @@ static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
 
 	/* Read the interrupt status bits for the channel */
 	usbc_hcint.u32 = cvmx_usb_read_csr32(usb,
-				CVMX_USBCX_HCINTX(channel, usb->index));
+					     CVMX_USBCX_HCINTX(channel, usb->index));
 
 	if (usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_NO_DMA) {
 		usbc_hcchar.u32 = cvmx_usb_read_csr32(usb,
-				CVMX_USBCX_HCCHARX(channel, usb->index));
+						      CVMX_USBCX_HCCHARX(channel,
+									 usb->index));
 
 		if (usbc_hcchar.s.chena && usbc_hcchar.s.chdis) {
 			/*
@@ -2688,9 +2690,9 @@ static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
 	 * transferred
 	 */
 	usbc_hcchar.u32 = cvmx_usb_read_csr32(usb,
-			CVMX_USBCX_HCCHARX(channel, usb->index));
+					      CVMX_USBCX_HCCHARX(channel, usb->index));
 	usbc_hctsiz.u32 = cvmx_usb_read_csr32(usb,
-			CVMX_USBCX_HCTSIZX(channel, usb->index));
+					      CVMX_USBCX_HCTSIZX(channel, usb->index));
 
 	/*
 	 * Calculating the number of bytes successfully transferred is dependent
@@ -3010,7 +3012,7 @@ static int cvmx_usb_poll(struct octeon_hcd *usb)
 		union cvmx_usbcx_haint usbc_haint;
 
 		usbc_haint.u32 = cvmx_usb_read_csr32(usb,
-					CVMX_USBCX_HAINT(usb->index));
+						     CVMX_USBCX_HAINT(usb->index));
 		while (usbc_haint.u32) {
 			int channel;
 
-- 
2.17.1

