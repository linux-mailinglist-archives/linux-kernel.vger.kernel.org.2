Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832B23DCDC3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 22:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhHAUd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 16:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhHAUdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 16:33:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D66DC06175F;
        Sun,  1 Aug 2021 13:33:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so21858626pji.5;
        Sun, 01 Aug 2021 13:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OeCfS3YMgALo1kT7+YVPL/G35vIxdbQwPm6wQHzN0L0=;
        b=kJECoYM4cbjsilfw2BAtj8C9lev0Uf3gQ8nEymU4gmQxZtW0GS5I9qHHyStRLfiWL2
         f+oTZVhjd6pPAZpuw3EMSEptWC2G6TLCJrBULu5y9lRvMJbIiK7fEq/RNA7v92dnzAZd
         VTzE2BsM7Lu8iKrkaKS89UUEI2Fnea/WOi4Wf1gTIRKoQUK1DZrrXlNezSFFkfdRfyY3
         esZduZWjRWnur7q5GBNGaSl+P8widCRit+GP2jKo1Oa9R4QBt9bzlL3yXcrgi8dMZk2n
         6HkwI0iZArhi/D5V4W7pmnAZd8I7+gyJVpEDUtM7cRFz1uac3JXEClhwFh6iqNWC0PTw
         9UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OeCfS3YMgALo1kT7+YVPL/G35vIxdbQwPm6wQHzN0L0=;
        b=nfTugjmghLSKgL6Rzbd3CEdtyC+0a+5zspPtM89eO4c7DtGJ5F2BwHz6xKL5Gl9ImC
         qvxUslJlkHeCldH5ZuhT9czGLbtT4E2VM7fmUogIvBMQidR1PXYEPdUXiIz2Akjox29v
         jKthUVcO7kyLDzYRQ+E2WZe5SM2VKiMoXVJ0HBVKFuXdciF4Tz9c9Rl9i/1JmBkNHcRs
         BwHfDDaZ6QrLtjsEZyDE9sa3Kod4DZUCslHZpdknTR1TUM7omc/cRirD7K1/+0VQSvix
         tzJfKa+ndw8GrWEXVoI+SxX3Ufq3rap3URPyu+JOySoBYYPEnhLGeG+qirGVugDSEXal
         Yseg==
X-Gm-Message-State: AOAM530K20B0l0X+LJ5aiiNmG+FMBiRE5w1NMsVXH6lI9d+0oIces/Xy
        GAa/l/uOiMthrWGVQUplRWRZPomyjcI=
X-Google-Smtp-Source: ABdhPJyhUAU/iDDVskLjW897dx7GSxLUcNNOZFsfcMjo/tNDqzeaGLJf/qeT2icXM/oiAFTaygGQ0A==
X-Received: by 2002:a17:90a:6e41:: with SMTP id s1mr14246287pjm.109.1627849991982;
        Sun, 01 Aug 2021 13:33:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:15b3:589:f07d:5386:a3c2:3056])
        by smtp.gmail.com with ESMTPSA id k10sm8897974pfc.169.2021.08.01.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 13:33:11 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH v2 3/6] USB: serial: f81232: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Mon,  2 Aug 2021 02:01:19 +0530
Message-Id: <20210801203122.3515-4-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210801203122.3515-1-himadrispandya@gmail.com>
References: <20210801203122.3515-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New wrapper functions usb_control_msg_send/recv accept stack variables
for usb message buffer and eliminate the need of creating temporary dma
buffers. The wrappers also have proper error checks for short
read/writes. Hence use the wrappers instead of using usb_control_msg()
directly.

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
Changes in v2:
 - Drop unrelated style changes
---
 drivers/usb/serial/f81232.c | 96 +++++++++++++------------------------
 1 file changed, 34 insertions(+), 62 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index a7a7af8d05bf..3ad1f515fb68 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -139,67 +139,46 @@ static int calc_baud_divisor(speed_t baudrate, speed_t clockrate)
 static int f81232_get_register(struct usb_serial_port *port, u16 reg, u8 *val)
 {
 	int status;
-	u8 *tmp;
 	struct usb_device *dev = port->serial->dev;
 
-	tmp = kmalloc(sizeof(*val), GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
-
-	status = usb_control_msg(dev,
-				usb_rcvctrlpipe(dev, 0),
-				F81232_REGISTER_REQUEST,
-				F81232_GET_REGISTER,
-				reg,
-				0,
-				tmp,
-				sizeof(*val),
-				USB_CTRL_GET_TIMEOUT);
-	if (status != sizeof(*val)) {
+	status = usb_control_msg_recv(dev,
+				      0,
+				      F81232_REGISTER_REQUEST,
+				      F81232_GET_REGISTER,
+				      reg,
+				      0,
+				      val,
+				      sizeof(*val),
+				      USB_CTRL_GET_TIMEOUT,
+				      GFP_KERNEL);
+	if (status) {
 		dev_err(&port->dev, "%s failed status: %d\n", __func__, status);
-
-		if (status < 0)
-			status = usb_translate_errors(status);
-		else
-			status = -EIO;
-	} else {
-		status = 0;
-		*val = *tmp;
+		status = usb_translate_errors(status);
 	}
 
-	kfree(tmp);
 	return status;
 }
 
 static int f81232_set_register(struct usb_serial_port *port, u16 reg, u8 val)
 {
 	int status;
-	u8 *tmp;
 	struct usb_device *dev = port->serial->dev;
 
-	tmp = kmalloc(sizeof(val), GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
-
-	*tmp = val;
-
-	status = usb_control_msg(dev,
-				usb_sndctrlpipe(dev, 0),
-				F81232_REGISTER_REQUEST,
-				F81232_SET_REGISTER,
-				reg,
-				0,
-				tmp,
-				sizeof(val),
-				USB_CTRL_SET_TIMEOUT);
-	if (status < 0) {
+	status = usb_control_msg_send(dev,
+				      0,
+				      F81232_REGISTER_REQUEST,
+				      F81232_SET_REGISTER,
+				      reg,
+				      0,
+				      &val,
+				      sizeof(val),
+				      USB_CTRL_SET_TIMEOUT,
+				      GFP_KERNEL);
+	if (status) {
 		dev_err(&port->dev, "%s failed status: %d\n", __func__, status);
 		status = usb_translate_errors(status);
-	} else {
-		status = 0;
 	}
 
-	kfree(tmp);
 	return status;
 }
 
@@ -857,28 +836,22 @@ static int f81534a_ctrl_set_register(struct usb_interface *intf, u16 reg,
 	struct usb_device *dev = interface_to_usbdev(intf);
 	int retry = F81534A_ACCESS_REG_RETRY;
 	int status;
-	u8 *tmp;
-
-	tmp = kmemdup(val, size, GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
 
 	while (retry--) {
-		status = usb_control_msg(dev,
-					usb_sndctrlpipe(dev, 0),
-					F81232_REGISTER_REQUEST,
-					F81232_SET_REGISTER,
-					reg,
-					0,
-					tmp,
-					size,
-					USB_CTRL_SET_TIMEOUT);
-		if (status < 0) {
+		status = usb_control_msg_send(dev,
+					      0,
+					      F81232_REGISTER_REQUEST,
+					      F81232_SET_REGISTER,
+					      reg,
+					      0,
+					      val,
+					      size,
+					      USB_CTRL_SET_TIMEOUT,
+					      GFP_KERNEL);
+		if (status) {
 			status = usb_translate_errors(status);
 			if (status == -EIO)
 				continue;
-		} else {
-			status = 0;
 		}
 
 		break;
@@ -889,7 +862,6 @@ static int f81534a_ctrl_set_register(struct usb_interface *intf, u16 reg,
 				reg, status);
 	}
 
-	kfree(tmp);
 	return status;
 }
 
-- 
2.17.1

