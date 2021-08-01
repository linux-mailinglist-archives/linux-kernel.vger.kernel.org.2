Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31133DCDBF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 22:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhHAUdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 16:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhHAUdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 16:33:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E96C06175F;
        Sun,  1 Aug 2021 13:33:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i10so17274559pla.3;
        Sun, 01 Aug 2021 13:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sRvrjPcuJWSHHGBhZB5+jGu6mRzFPO1VA6jKLnAdmxk=;
        b=n8XEMV18y6ApkWUt1WYTyoi4697t9LTLdFdUlZTu/4VDW2AR132x7QhIHU+eXPAHwo
         i3w7VlPjO8YlH1ncag2+xiuE98osj0XOHFBRwmB09LtoF+IKgZCw2wiNAF5mhLoVfHxU
         TiPhzOuKS1Vt95KgN4qgaqZkzbodkmixK6afzq8l68infsgcalU7o+1Bb9UCIvLx+iBO
         9ouuGq2IVuQxq27M5sy3q0ADBluNy9r7cVDt9Qyz5DzrzKb7lvTc4K+hpRS9obbeNTxP
         blyyEPZB4NIiIy43DxEuD1RuuhuAcIh1deRK+6ez6oKBp2O0srZVP2YxGW0LQppR7Ccb
         drsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sRvrjPcuJWSHHGBhZB5+jGu6mRzFPO1VA6jKLnAdmxk=;
        b=twqIxjrbpFNjOFqCfiZAzljf0X2bdlM/t8KdiVRris9l/NEucz7nbFucYDPOKBmT0j
         h8qgySk8NM1PxJ+scYhktOB4etM8cpFQoE/xFbJSTLodlMJ6cHmrtutVnZhbW/IIfQRz
         +OoroRDKuQWvIj+5ufUrM6zCecixnh/H+qLDZoXnL7lYxV49yp+zAB0Xh57oHOjYBnI/
         5Tmr3hr6KnfL8UQC90DoP9XjvjiIhncSY5K6GXEXPBDgq0wU8g5uAW538wVqLnRocOpg
         RnMciWg29jNPjMC+pntlaXuFI2Jevppcusz6lXXJskMnDJSZiE9pMbw939UM5smWSHPi
         fJXQ==
X-Gm-Message-State: AOAM531aujR0MlbDdEvVNNKzMvOJFVIVNF4Ry3RgTsqxPpRTAsnoKP5H
        UuPB/Z/UQScRPyZosbHPedk=
X-Google-Smtp-Source: ABdhPJyj2epBDaELGK1juuRK1WWTGOxQjVrgCeS1xHWs8IA46BeVCMPhRbt/APTsDLUIVMHAY5V94g==
X-Received: by 2002:a62:8f86:0:b029:32e:33d7:998b with SMTP id n128-20020a628f860000b029032e33d7998bmr14069351pfd.64.1627849986054;
        Sun, 01 Aug 2021 13:33:06 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:15b3:589:f07d:5386:a3c2:3056])
        by smtp.gmail.com with ESMTPSA id k10sm8897974pfc.169.2021.08.01.13.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 13:33:05 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH v2 1/6] USB: serial: ch314: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Mon,  2 Aug 2021 02:01:17 +0530
Message-Id: <20210801203122.3515-2-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210801203122.3515-1-himadrispandya@gmail.com>
References: <20210801203122.3515-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_control_msg_send/recv are new wrapper functions for usb_control_msg()
that have proper error checks for short read/writes. These functions
can also accept data buffer on stack. Hence use these functions to have
more robust error checks, and to reduce kernel memory usage for usb
messages.

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
Changes in v2:
 - Fix callers of ch341_control_out() and ch341_control_in()
 - Remove label "out"
 - Remove an unnecessary assignment statement
---
 drivers/usb/serial/ch341.c | 97 ++++++++++++--------------------------
 1 file changed, 29 insertions(+), 68 deletions(-)

diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 2db917eab799..c6f7ff9ca8ae 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -113,10 +113,10 @@ static int ch341_control_out(struct usb_device *dev, u8 request,
 	dev_dbg(&dev->dev, "%s - (%02x,%04x,%04x)\n", __func__,
 		request, value, index);
 
-	r = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), request,
-			    USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			    value, index, NULL, 0, DEFAULT_TIMEOUT);
-	if (r < 0)
+	r = usb_control_msg_send(dev, 0, request,
+				 USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
+				 value, index, NULL, 0, DEFAULT_TIMEOUT, GFP_KERNEL);
+	if (r)
 		dev_err(&dev->dev, "failed to send control message: %d\n", r);
 
 	return r;
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
@@ -287,23 +277,19 @@ static int ch341_set_handshake(struct usb_device *dev, u8 control)
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
+	if (r)
 		goto out;
 
 	spin_lock_irqsave(&priv->lock, flags);
 	priv->msr = (~(*buffer)) & CH341_BITS_MODEM_STAT;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-out:	kfree(buffer);
+out:
 	return r;
 }
 
@@ -312,21 +298,17 @@ out:	kfree(buffer);
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
+	if (r)
 		goto out;
 	dev_dbg(&dev->dev, "Chip version: 0x%02x\n", buffer[0]);
 
 	r = ch341_control_out(dev, CH341_REQ_SERIAL_INIT, 0, 0);
-	if (r < 0)
+	if (r)
 		goto out;
 
 	r = ch341_set_baudrate_lcr(dev, priv, priv->baud_rate, priv->lcr);
@@ -335,7 +317,7 @@ static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
 
 	r = ch341_set_handshake(dev, priv->mcr);
 
-out:	kfree(buffer);
+out:
 	return r;
 }
 
@@ -345,39 +327,23 @@ static int ch341_detect_quirks(struct usb_serial_port *port)
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
@@ -647,23 +613,19 @@ static void ch341_break_ctl(struct tty_struct *tty, int break_state)
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
-	r = ch341_control_in(port->serial->dev, CH341_REQ_READ_REG,
-			ch341_break_reg, 0, break_reg, 2);
-	if (r < 0) {
+	r = ch341_control_in(port->serial->dev, CH341_REQ_READ_REG, ch341_break_reg, 0,
+			     break_reg, 2);
+	if (r) {
 		dev_err(&port->dev, "%s - USB control read error (%d)\n",
 				__func__, r);
-		goto out;
+		return;
 	}
 	dev_dbg(&port->dev, "%s - initial ch341 break register contents - reg1: %x, reg2: %x\n",
 		__func__, break_reg[0], break_reg[1]);
@@ -681,11 +643,10 @@ static void ch341_break_ctl(struct tty_struct *tty, int break_state)
 	reg_contents = get_unaligned_le16(break_reg);
 	r = ch341_control_out(port->serial->dev, CH341_REQ_WRITE_REG,
 			ch341_break_reg, reg_contents);
-	if (r < 0)
+	if (r)
 		dev_err(&port->dev, "%s - USB control write error (%d)\n",
 				__func__, r);
-out:
-	kfree(break_reg);
+	return;
 }
 
 static int ch341_tiocmset(struct tty_struct *tty,
-- 
2.17.1

