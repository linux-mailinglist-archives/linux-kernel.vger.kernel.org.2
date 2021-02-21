Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16B2320E92
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 00:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbhBUXpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 18:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbhBUXpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 18:45:07 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 15:44:27 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id e15so8116482qte.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 15:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UAxYgTJ8xiP4XZVnDR92h/oyODoJt823YPaFX/5CcQk=;
        b=MNC9vbSHvJWv2tiNaNI4Sh+9m61qxX7TIuZEneH2uevxc9UC8s2Kt5b3lzpE2wlRpo
         tPPbDXwMogVAXeqKAxoZ5OKjeNHf4ZX9G03CMLZZSY5OAZFFaLSBiRemxu/HoDv/wEkE
         Nd5t+eWC8zSX3dNyzYmP4yKbAtCa07tH5+3t/FJvX4EJzxV9q1YJCd1eOuPfEq8DN5P6
         GQbmEpxFVpdnXcLNm5aZYXykMeM5zyYV9vrfsKQhK6rRlEefmQXVHRz7RN3itanA4Lzt
         5sy06oB1Gl9qAwZIQJAxxmhpMcyHsC/OkMdTG5OJOOLUqRLdUOltIxymImtDS0IogQTL
         J/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UAxYgTJ8xiP4XZVnDR92h/oyODoJt823YPaFX/5CcQk=;
        b=GXaJZYqPmF9JpcyI4hmzBFU9x/FQsfO1nEz2z7cH6RfQ5zzYUldJl1OddW/U6lMOVs
         qAwDvM6E7nNM8W3UuJOaVymOG/DHQPgasJnZkJj9hTM3ka3VZu8KnsC7hDfLmGu51teG
         jn7v2d1cB8HVU8zJCfHxaQQyMcrPoMKuBRBIhJ5EKN13yayDLC3vbC+DJLJI82BeyAF4
         MxYT6iDxSA0Ruzvmtt5dEuI7gjrVaqIgcgkdF8pxmKBQEiMrJcAMPLu2pvQEDY0woKYe
         HCUgvo9d81aj2/41f89fTQ64DrdUakoyK5wHuT+Cg/lpt77egWXfRmeej+omk80+GgC7
         YoRQ==
X-Gm-Message-State: AOAM5332mPq01V6M2Exi9SdvdzFlAKEOTj8UhXUQNPYg+xABUseXh/Tl
        GI66VYTNWtKc0y5CJhcRp34=
X-Google-Smtp-Source: ABdhPJxroqdAssU2fHPbthFL7DOJD91d/CkdWfZc8gQF81uLfvIIV2JD0Wn81NVlTm/d6omlaWDm8w==
X-Received: by 2002:a05:622a:28d:: with SMTP id z13mr18057205qtw.87.1613951066691;
        Sun, 21 Feb 2021 15:44:26 -0800 (PST)
Received: from mahak-Inspiron-7570 ([103.153.208.42])
        by smtp.gmail.com with ESMTPSA id o194sm11097316qke.101.2021.02.21.15.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 15:44:26 -0800 (PST)
From:   Mahak Gupta <gmahak1@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Mahak Gupta <gmahak1@gmail.com>
Subject: [PATCH] Match alignment with open parenthesis
Date:   Mon, 22 Feb 2021 05:14:09 +0530
Message-Id: <20210221234409.11627-1-gmahak1@gmail.com>
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

