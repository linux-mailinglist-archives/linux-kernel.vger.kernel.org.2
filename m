Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B63041E7D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 09:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352422AbhJAHBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 03:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhJAHBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 03:01:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7A6C06176A;
        Thu, 30 Sep 2021 23:59:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j27so6477857wms.0;
        Thu, 30 Sep 2021 23:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lOm0pW5v0MBkaDugCS5YfwkOAvYOSU7oabQOMG2irfw=;
        b=jsc0KVMvs+UBDRiBAunXDe6MGEGt2UApoPFusuhLBe1N/F44XlvbgynBk6l8kc+Ynj
         XYEerSDC9vsJG14026Foo0LDKpyk1joMDcXUlYy5+pLwU7g8PauRQJ0KrDm1zfSXf6jw
         sYhhfBHzKq0l5NdQXq8udnVAWcn+QSh0xZxaWN/sQkREfI7h1h5qJHCsc4ColiImLvd2
         qSXhjEPVn5jpRwUHFzUd7U2rWuyWkDA3VhfTyUk1Gsg4I+fpMR8mryaDsZA6tp6xMzPq
         SjapQVVAyuSUENutklSDe62UmXpxS0dersnEw5VH5Dp6DTbYk5kz7UrvLKVwk79e9fKx
         FU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lOm0pW5v0MBkaDugCS5YfwkOAvYOSU7oabQOMG2irfw=;
        b=iVoQlFVw/vERT05RIkXBXxivcjkEMm5x8vMxD8zFiM9ra3+sSIGdDNbFF0t+XfOfFe
         YDi3XsnwNgPMzdNaHNa9cCxrzaV/o7UmrJ3m5WcBfTGETLESlqckYdKT+9YYLb3hu3BQ
         6rg6RKHEcDxIZ2gDBSRldGVdHD+mMqFlgnCHeJHm5NvEqr+u1yvDCYPkXUhnVcD5gkEN
         /k4ddTFeqWlOEtMrTGgz3OmZT/XbmkesnEMvWJZSopyQ2G1J2xjppEOzpAJymamK9l3d
         9n8VCL9DEYSuyvevPb81vG4OcHPqQcN/oJwwuOcadrS/uxv1QfGSdwzvWFY9eppP7UkC
         ZLCg==
X-Gm-Message-State: AOAM5338DWkLOk2HuiPuL4oI7E/jvxo33NeBZEedRNqBfdnXcSuCFKEn
        DxjQNO9d7bZIv0sCvDkZfiM=
X-Google-Smtp-Source: ABdhPJxuajbFXpaPlSpXiznEBB3q43NbShmltsZ42fSaQ6q4Wz3T7DpkNms3s3hrJ/8qdgk7pMXQbQ==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr2832895wma.72.1633071597498;
        Thu, 30 Sep 2021 23:59:57 -0700 (PDT)
Received: from localhost.localdomain (eth-east-parth2-46-193-64-114.wb.wifirst.net. [46.193.64.114])
        by smtp.gmail.com with ESMTPSA id 15sm6782000wmk.48.2021.09.30.23.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 23:59:56 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH v3 2/2] USB: serial: cp210x: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Fri,  1 Oct 2021 08:57:20 +0200
Message-Id: <20211001065720.21330-3-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001065720.21330-1-himadrispandya@gmail.com>
References: <20211001065720.21330-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new wrapper functions for usb_control_msg() can accept data from
stack and treat short reads as error. Hence use the wrappers functions.
Please note that because of this change, cp210x_read_reg_block() will no
longer log the length of short reads.

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
Changes in v3:
 - Rephrase the commit message
 - Explicitly mention that short reads don't log length now

Changes in v2:
 - Drop unrelated style fixes
---
 drivers/usb/serial/cp210x.c | 106 ++++++++++--------------------------
 1 file changed, 30 insertions(+), 76 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 189279869a8b..3c3ca46b0b82 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -631,29 +631,19 @@ static int cp210x_read_reg_block(struct usb_serial_port *port, u8 req,
 {
 	struct usb_serial *serial = port->serial;
 	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
-	void *dmabuf;
 	int result;
 
-	dmabuf = kmalloc(bufsize, GFP_KERNEL);
-	if (!dmabuf)
-		return -ENOMEM;
 
-	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
-			req, REQTYPE_INTERFACE_TO_HOST, 0,
-			port_priv->bInterfaceNumber, dmabuf, bufsize,
-			USB_CTRL_GET_TIMEOUT);
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
 
@@ -672,30 +662,17 @@ static int cp210x_read_u8_reg(struct usb_serial_port *port, u8 req, u8 *val)
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
 
@@ -730,21 +707,14 @@ static int cp210x_write_reg_block(struct usb_serial_port *port, u8 req,
 {
 	struct usb_serial *serial = port->serial;
 	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
-	void *dmabuf;
 	int result;
 
-	dmabuf = kmemdup(buf, bufsize, GFP_KERNEL);
-	if (!dmabuf)
-		return -ENOMEM;
-
-	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-			req, REQTYPE_HOST_TO_INTERFACE, 0,
-			port_priv->bInterfaceNumber, dmabuf, bufsize,
-			USB_CTRL_SET_TIMEOUT);
-
-	kfree(dmabuf);
+	result = usb_control_msg_send(serial->dev, 0, req,
+				      REQTYPE_HOST_TO_INTERFACE, 0,
+				      port_priv->bInterfaceNumber, buf, bufsize,
+				      USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
 
-	if (result < 0) {
+	if (result) {
 		dev_err(&port->dev, "failed set req 0x%x size %d status: %d\n",
 				req, bufsize, result);
 		return result;
@@ -773,21 +743,14 @@ static int cp210x_write_u32_reg(struct usb_serial_port *port, u8 req, u32 val)
 static int cp210x_write_vendor_block(struct usb_serial *serial, u8 type,
 				     u16 val, void *buf, int bufsize)
 {
-	void *dmabuf;
 	int result;
 
-	dmabuf = kmemdup(buf, bufsize, GFP_KERNEL);
-	if (!dmabuf)
-		return -ENOMEM;
+	result = usb_control_msg_send(serial->dev, 0, CP210X_VENDOR_SPECIFIC,
+				      type, val, cp210x_interface_num(serial),
+				      buf, bufsize, USB_CTRL_SET_TIMEOUT,
+				      GFP_KERNEL);
 
-	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-				 CP210X_VENDOR_SPECIFIC, type, val,
-				 cp210x_interface_num(serial), dmabuf, bufsize,
-				 USB_CTRL_SET_TIMEOUT);
-
-	kfree(dmabuf);
-
-	if (result < 0) {
+	if (result) {
 		dev_err(&serial->interface->dev,
 			"failed to set vendor val 0x%04x size %d: %d\n", val,
 			bufsize, result);
@@ -952,27 +915,18 @@ static int cp210x_get_tx_queue_byte_count(struct usb_serial_port *port,
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

