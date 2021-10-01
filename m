Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8829B41E7D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 09:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352396AbhJAHBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 03:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352364AbhJAHBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 03:01:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA2AC06176A;
        Thu, 30 Sep 2021 23:59:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a18so1755744wru.4;
        Thu, 30 Sep 2021 23:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P+OzgnL1G0ttOe4vqLJBGYDGUcbBV/anUgBwFpeug1w=;
        b=VQK+YzUIl5LkDBJpDjYNu0Mkt+qzeJfv44icf+sy9+Gj6RlVwwf/s/P160zKuy/wXe
         UMX17gF5A/sgCs1El2C3rPwoXJgaHqVozYBM/kG6NpLWul7RcLT4lsjzv2zHzINNCKyO
         zSPdMdnW8Khbfn9EUWeBn08qdZBERtpuRtDN952xghNDm/DMFWkrv9fun5iw8jScv1pR
         P5XPU6wHzIXJ+lEbiZRB9K4cY/pHzmmKmdYM5Ew2IsAUzJDopdHbcOIrjw2sMHMHF0Na
         ZexdXV4k+qboa2wHoMuNqUROIDN2QzDbqe26gUjdeu+5sgfw5fcx+DLCz1t0vW68oO2H
         /KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P+OzgnL1G0ttOe4vqLJBGYDGUcbBV/anUgBwFpeug1w=;
        b=7b8rJE/3kROQLrfNtDBJxVE37K11ETY0ujxXIcyEG9bzvkEy7hx37E6Mvg2e7vcCGw
         UaYbdMgR3uvm3SzrgwgSxZUUBg6VRJ4pGz0oRWAFbVoNxvcvA1/7Vad570Tv2ghIdsBF
         UY0UUlzYPMrvgT5ovqPFwB+DGRxd2vpItn9gobpQMXDlZX+em/FCd5Qjbv+espcOSnWo
         38Y/Xsu3CYfXNlQwPpCZ4JpK5oxQz2N8cE2c4TptzLDfK1/5iS1ZOHfRRcZaWvgLTkqi
         UtI4Ut3CD0uez+0s/ev7981W8jw3K3o4nMLinQ+FT/c1GzAgICOxRudUeUfgs9cwqy65
         ADxA==
X-Gm-Message-State: AOAM5336rak/fKn5M7A/MrEbxEX3MT3B7fLL6jrkOyype3DnvQvw96JK
        KONeq4XtvDsGI9qO736ONqs=
X-Google-Smtp-Source: ABdhPJzRLvuGX5GNbaLLPWoE2TUNyvRNvwdhP4sQR1EcH4RAFDJgcKL2uTWTtx3rc+j5aA15PvOkWg==
X-Received: by 2002:adf:bb41:: with SMTP id x1mr4001333wrg.346.1633071596340;
        Thu, 30 Sep 2021 23:59:56 -0700 (PDT)
Received: from localhost.localdomain (eth-east-parth2-46-193-64-114.wb.wifirst.net. [46.193.64.114])
        by smtp.gmail.com with ESMTPSA id 15sm6782000wmk.48.2021.09.30.23.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 23:59:55 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH v3 1/2] USB: serial: ch314: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Fri,  1 Oct 2021 08:57:19 +0200
Message-Id: <20211001065720.21330-2-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001065720.21330-1-himadrispandya@gmail.com>
References: <20211001065720.21330-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_control_msg_send/recv are new wrapper functions for usb_control_msg()
that have proper error checks for short reads. These functions can also
accept data buffer on stack. Hence use these functions to simplify error
handling for short reads. Short reads will now get reported as
-EREMOTEIO with no indication of how short the transfer was.

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
Changes in v3:
 - Rephrase the commit message
 - Include a note on not reporting size of the short reads in the commit
 - Drop unnecessary changes in ch341_control_out()
 - Drop a non-relevant style change
 - Remove some more "out" labels
 - Remove unnecessary return statement from a void function

Changes in v2:
 - Fix callers of ch341_control_out() and ch341_control_in()
 - Remove label "out"
 - Remove an unnecessary assignment statement
---
 drivers/usb/serial/ch341.c | 90 ++++++++++----------------------------
 1 file changed, 24 insertions(+), 66 deletions(-)

diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 2db917eab799..8aecc1f0dee4 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -131,23 +131,13 @@ static int ch341_control_in(struct usb_device *dev,
 	dev_dbg(&dev->dev, "%s - (%02x,%04x,%04x,%u)\n", __func__,
 		request, value, index, bufsize);
 
-	r = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), request,
-			    USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			    value, index, buf, bufsize, DEFAULT_TIMEOUT);
-	if (r < (int)bufsize) {
-		if (r >= 0) {
-			dev_err(&dev->dev,
-				"short control message received (%d < %u)\n",
-				r, bufsize);
-			r = -EIO;
-		}
-
-		dev_err(&dev->dev, "failed to receive control message: %d\n",
-			r);
-		return r;
-	}
+	r = usb_control_msg_recv(dev, 0, request,
+				 USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
+				 value, index, buf, bufsize, DEFAULT_TIMEOUT, GFP_KERNEL);
+	if (r)
+		dev_err(&dev->dev, "failed to receive control message: %d\n", r);
 
-	return 0;
+	return r;
 }
 
 #define CH341_CLKRATE		48000000
@@ -287,23 +277,18 @@ static int ch341_set_handshake(struct usb_device *dev, u8 control)
 static int ch341_get_status(struct usb_device *dev, struct ch341_private *priv)
 {
 	const unsigned int size = 2;
-	char *buffer;
+	u8 buffer[2];
 	int r;
 	unsigned long flags;
 
-	buffer = kmalloc(size, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
 	r = ch341_control_in(dev, CH341_REQ_READ_REG, 0x0706, 0, buffer, size);
-	if (r < 0)
-		goto out;
+	if (r)
+		return r;
 
 	spin_lock_irqsave(&priv->lock, flags);
 	priv->msr = (~(*buffer)) & CH341_BITS_MODEM_STAT;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-out:	kfree(buffer);
 	return r;
 }
 
@@ -312,30 +297,25 @@ out:	kfree(buffer);
 static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
 {
 	const unsigned int size = 2;
-	char *buffer;
+	u8 buffer[2];
 	int r;
 
-	buffer = kmalloc(size, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
 	/* expect two bytes 0x27 0x00 */
 	r = ch341_control_in(dev, CH341_REQ_READ_VERSION, 0, 0, buffer, size);
-	if (r < 0)
-		goto out;
+	if (r)
+		return r;
 	dev_dbg(&dev->dev, "Chip version: 0x%02x\n", buffer[0]);
 
 	r = ch341_control_out(dev, CH341_REQ_SERIAL_INIT, 0, 0);
-	if (r < 0)
-		goto out;
+	if (r)
+		return r;
 
 	r = ch341_set_baudrate_lcr(dev, priv, priv->baud_rate, priv->lcr);
 	if (r < 0)
-		goto out;
+		return r;
 
 	r = ch341_set_handshake(dev, priv->mcr);
 
-out:	kfree(buffer);
 	return r;
 }
 
@@ -345,39 +325,23 @@ static int ch341_detect_quirks(struct usb_serial_port *port)
 	struct usb_device *udev = port->serial->dev;
 	const unsigned int size = 2;
 	unsigned long quirks = 0;
-	char *buffer;
+	u8 buffer[2];
 	int r;
 
-	buffer = kmalloc(size, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
 	/*
 	 * A subset of CH34x devices does not support all features. The
 	 * prescaler is limited and there is no support for sending a RS232
 	 * break condition. A read failure when trying to set up the latter is
 	 * used to detect these devices.
 	 */
-	r = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0), CH341_REQ_READ_REG,
-			    USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			    CH341_REG_BREAK, 0, buffer, size, DEFAULT_TIMEOUT);
+	r = usb_control_msg_recv(udev, 0, CH341_REQ_READ_REG,
+				 USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
+				 CH341_REG_BREAK, 0, &buffer, size, DEFAULT_TIMEOUT, GFP_KERNEL);
 	if (r == -EPIPE) {
 		dev_info(&port->dev, "break control not supported, using simulated break\n");
 		quirks = CH341_QUIRK_LIMITED_PRESCALER | CH341_QUIRK_SIMULATE_BREAK;
-		r = 0;
-		goto out;
-	}
-
-	if (r != size) {
-		if (r >= 0)
-			r = -EIO;
+	} else if (r)
 		dev_err(&port->dev, "failed to read break control: %d\n", r);
-		goto out;
-	}
-
-	r = 0;
-out:
-	kfree(buffer);
 
 	if (quirks) {
 		dev_dbg(&port->dev, "enabling quirk flags: 0x%02lx\n", quirks);
@@ -647,23 +611,19 @@ static void ch341_break_ctl(struct tty_struct *tty, int break_state)
 	struct ch341_private *priv = usb_get_serial_port_data(port);
 	int r;
 	uint16_t reg_contents;
-	uint8_t *break_reg;
+	uint8_t break_reg[2];
 
 	if (priv->quirks & CH341_QUIRK_SIMULATE_BREAK) {
 		ch341_simulate_break(tty, break_state);
 		return;
 	}
 
-	break_reg = kmalloc(2, GFP_KERNEL);
-	if (!break_reg)
-		return;
-
 	r = ch341_control_in(port->serial->dev, CH341_REQ_READ_REG,
 			ch341_break_reg, 0, break_reg, 2);
-	if (r < 0) {
+	if (r) {
 		dev_err(&port->dev, "%s - USB control read error (%d)\n",
 				__func__, r);
-		goto out;
+		return;
 	}
 	dev_dbg(&port->dev, "%s - initial ch341 break register contents - reg1: %x, reg2: %x\n",
 		__func__, break_reg[0], break_reg[1]);
@@ -681,11 +641,9 @@ static void ch341_break_ctl(struct tty_struct *tty, int break_state)
 	reg_contents = get_unaligned_le16(break_reg);
 	r = ch341_control_out(port->serial->dev, CH341_REQ_WRITE_REG,
 			ch341_break_reg, reg_contents);
-	if (r < 0)
+	if (r)
 		dev_err(&port->dev, "%s - USB control write error (%d)\n",
 				__func__, r);
-out:
-	kfree(break_reg);
 }
 
 static int ch341_tiocmset(struct tty_struct *tty,
-- 
2.17.1

