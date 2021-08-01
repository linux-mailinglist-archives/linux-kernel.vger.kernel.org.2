Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C2C3DCDC1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 22:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhHAUdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 16:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhHAUdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 16:33:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5972CC06175F;
        Sun,  1 Aug 2021 13:33:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t21so17217949plr.13;
        Sun, 01 Aug 2021 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2ku34cnAyfySr5zI5nerb5zYCOk3G/JYtmkF3StscuA=;
        b=W9fTsbTc3Gs/mwd6ZiD20Ne4v2Jh2jqzhcvdtdQsl6JkdB4hWubMpt2epdEuFh4D2e
         0PxlQRraHRwYvGGO3JPizBIAFVCI7k6a4Xosis3g173oRjqTG9+liGaRmKPn8XILuM78
         7m56XJZnUpSIz3G9pDQjwxdHaETGmc4fap8zBvyAIugn7zB8k9dTD3D1pRKxsewsfwR+
         IaU0DgwFB/fi/fGZAHUSQbjCCJIPn9i/ub39vbnB2oAm63lPXyv9Y0WINd4VmLoQ6eEy
         EwtP3oPdbqExVGCGww4W6asxJ/f5LIixUASSmuNEGqbXu03UfIpXC77v0Mn0buyqMohu
         uRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2ku34cnAyfySr5zI5nerb5zYCOk3G/JYtmkF3StscuA=;
        b=KEV7u1MSZWrm84GhlIUhOeYjOpB2a1Zbb7nXFFix5Z5CVTsoweSNP4EAX5aD5ebcTw
         TqlElfkcrPU92KgTBIu+muU89ztznikiAuCDVRaOADlsB7Xq+jLQotdA6H47/0dIhTV5
         //or9r2i9nTSfn8rPfjbh7V9uv0DkV9/tzPoq3ddzBdZ33DUXP3fj8YMglyQ3hb3e9eR
         Ie5tdR2anziiMs4xP2+bGMM1fQCjOZNjUfdedIETehnIKicw4pyBU5gnRWJy58nuFmvO
         QclAjMeXQdd5cb7ChNUcD+OxifvnUnyq2K2SsGGh21NusDAJk6IWc5+TL5i0IJJmCr6w
         GlHQ==
X-Gm-Message-State: AOAM533yEizKJgi89YTBKxdAwYe1/TXz2003tW9cvJry+j6NOeUakKJE
        XrtoYCvVxnZ59B61ZNxKOGw=
X-Google-Smtp-Source: ABdhPJyLjM34FpwpxdXOyEnCTnCTKE/CJPYY2Uc9jld8n+H3FCClx+e1fw+oIUmSKa6GYcBmNH3aQQ==
X-Received: by 2002:a17:903:2444:b029:12c:8eba:fd6a with SMTP id l4-20020a1709032444b029012c8ebafd6amr11677278pls.0.1627849988906;
        Sun, 01 Aug 2021 13:33:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:15b3:589:f07d:5386:a3c2:3056])
        by smtp.gmail.com with ESMTPSA id k10sm8897974pfc.169.2021.08.01.13.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 13:33:08 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH v2 2/6] USB: serial: cp210x: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Mon,  2 Aug 2021 02:01:18 +0530
Message-Id: <20210801203122.3515-3-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210801203122.3515-1-himadrispandya@gmail.com>
References: <20210801203122.3515-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new wrapper functions for usb_control_msg() can accept data from
stack with robust error checks. Hence use the wrappers with stack
variables for usb transfer buffers to save kernel memory.

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
Changes in v2:
 - Drop unrelated style fixes
---
 drivers/usb/serial/cp210x.c | 107 ++++++++++--------------------------
 1 file changed, 30 insertions(+), 77 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 3c80bfbf3bec..b73581fc1768 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -628,29 +628,18 @@ static int cp210x_read_reg_block(struct usb_serial_port *port, u8 req,
 {
 	struct usb_serial *serial = port->serial;
 	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
-	void *dmabuf;
 	int result;
 
-	dmabuf = kmalloc(bufsize, GFP_KERNEL);
-	if (!dmabuf)
-		return -ENOMEM;
-
-	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
-			req, REQTYPE_INTERFACE_TO_HOST, 0,
-			port_priv->bInterfaceNumber, dmabuf, bufsize,
-			USB_CTRL_SET_TIMEOUT);
-	if (result == bufsize) {
-		memcpy(buf, dmabuf, bufsize);
-		result = 0;
-	} else {
+	result = usb_control_msg_recv(serial->dev, 0, req,
+				      REQTYPE_INTERFACE_TO_HOST, 0,
+				      port_priv->bInterfaceNumber, buf,
+				      bufsize, USB_CTRL_SET_TIMEOUT,
+				      GFP_KERNEL);
+	if (result) {
 		dev_err(&port->dev, "failed get req 0x%x size %d status: %d\n",
 				req, bufsize, result);
-		if (result >= 0)
-			result = -EIO;
 	}
 
-	kfree(dmabuf);
-
 	return result;
 }
 
@@ -669,30 +658,17 @@ static int cp210x_read_u8_reg(struct usb_serial_port *port, u8 req, u8 *val)
 static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
 				    void *buf, int bufsize)
 {
-	void *dmabuf;
 	int result;
 
-	dmabuf = kmalloc(bufsize, GFP_KERNEL);
-	if (!dmabuf)
-		return -ENOMEM;
-
-	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
-				 CP210X_VENDOR_SPECIFIC, type, val,
-				 cp210x_interface_num(serial), dmabuf, bufsize,
-				 USB_CTRL_GET_TIMEOUT);
-	if (result == bufsize) {
-		memcpy(buf, dmabuf, bufsize);
-		result = 0;
-	} else {
+	result = usb_control_msg_recv(serial->dev, 0, CP210X_VENDOR_SPECIFIC,
+				      type, val, cp210x_interface_num(serial),
+				      buf, bufsize, USB_CTRL_GET_TIMEOUT,
+				      GFP_KERNEL);
+	if (result) {
 		dev_err(&serial->interface->dev,
 			"failed to get vendor val 0x%04x size %d: %d\n", val,
 			bufsize, result);
-		if (result >= 0)
-			result = -EIO;
 	}
-
-	kfree(dmabuf);
-
 	return result;
 }
 
@@ -727,21 +703,14 @@ static int cp210x_write_reg_block(struct usb_serial_port *port, u8 req,
 {
 	struct usb_serial *serial = port->serial;
 	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
-	void *dmabuf;
 	int result;
 
-	dmabuf = kmemdup(buf, bufsize, GFP_KERNEL);
-	if (!dmabuf)
-		return -ENOMEM;
+	result = usb_control_msg_send(serial->dev, 0, req,
+				      REQTYPE_HOST_TO_INTERFACE, 0,
+				      port_priv->bInterfaceNumber, buf, bufsize,
+				      USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
 
-	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-			req, REQTYPE_HOST_TO_INTERFACE, 0,
-			port_priv->bInterfaceNumber, dmabuf, bufsize,
-			USB_CTRL_SET_TIMEOUT);
-
-	kfree(dmabuf);
-
-	if (result < 0) {
+	if (result) {
 		dev_err(&port->dev, "failed set req 0x%x size %d status: %d\n",
 				req, bufsize, result);
 		return result;
@@ -770,21 +739,14 @@ static int cp210x_write_u32_reg(struct usb_serial_port *port, u8 req, u32 val)
 static int cp210x_write_vendor_block(struct usb_serial *serial, u8 type,
 				     u16 val, void *buf, int bufsize)
 {
-	void *dmabuf;
 	int result;
 
-	dmabuf = kmemdup(buf, bufsize, GFP_KERNEL);
-	if (!dmabuf)
-		return -ENOMEM;
-
-	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-				 CP210X_VENDOR_SPECIFIC, type, val,
-				 cp210x_interface_num(serial), dmabuf, bufsize,
-				 USB_CTRL_SET_TIMEOUT);
+	result = usb_control_msg_send(serial->dev, 0, CP210X_VENDOR_SPECIFIC,
+				      type, val, cp210x_interface_num(serial),
+				      buf, bufsize, USB_CTRL_SET_TIMEOUT,
+				      GFP_KERNEL);
 
-	kfree(dmabuf);
-
-	if (result < 0) {
+	if (result) {
 		dev_err(&serial->interface->dev,
 			"failed to set vendor val 0x%04x size %d: %d\n", val,
 			bufsize, result);
@@ -949,27 +911,18 @@ static int cp210x_get_tx_queue_byte_count(struct usb_serial_port *port,
 {
 	struct usb_serial *serial = port->serial;
 	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
-	struct cp210x_comm_status *sts;
+	struct cp210x_comm_status sts;
 	int result;
 
-	sts = kmalloc(sizeof(*sts), GFP_KERNEL);
-	if (!sts)
-		return -ENOMEM;
-
-	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
-			CP210X_GET_COMM_STATUS, REQTYPE_INTERFACE_TO_HOST,
-			0, port_priv->bInterfaceNumber, sts, sizeof(*sts),
-			USB_CTRL_GET_TIMEOUT);
-	if (result == sizeof(*sts)) {
-		*count = le32_to_cpu(sts->ulAmountInOutQueue);
-		result = 0;
-	} else {
+	result = usb_control_msg_recv(serial->dev, 0, CP210X_GET_COMM_STATUS,
+				      REQTYPE_INTERFACE_TO_HOST, 0,
+				      port_priv->bInterfaceNumber, &sts,
+				      sizeof(sts), USB_CTRL_GET_TIMEOUT,
+				      GFP_KERNEL);
+	if (result == 0)
+		*count = le32_to_cpu(sts.ulAmountInOutQueue);
+	else
 		dev_err(&port->dev, "failed to get comm status: %d\n", result);
-		if (result >= 0)
-			result = -EIO;
-	}
-
-	kfree(sts);
 
 	return result;
 }
-- 
2.17.1

