Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1CF3DCDC6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 22:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhHAUd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 16:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhHAUdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 16:33:23 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD68AC061799;
        Sun,  1 Aug 2021 13:33:15 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q2so17239486plr.11;
        Sun, 01 Aug 2021 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m9zvSZe68jgoYggnKmJEwWFOA2wmg629eWtmjh7kzPQ=;
        b=GyyFElPb6VaE5iyhlk0ZRnk3saewzJXXn+Ou1a3k35wR2JvqeEzv/3nB1wPSXkI2mN
         dZMmhlEICEOvOlUpo6qoWor7uxXgJKMI+X4w06UUjaf8vK6O9m7z3sub/4sUpi3irVHY
         cA9vNYsLMRXvZk1+1FJGyOBHrsvBa8e6mtoOsmeJtTxiIhhw2NhXbGKqdEOvBTufo2WU
         hm8zWnVylpou3xmCg3Da8azGVQ4pWxLHuGu0zge0TJxYnBGod+ojm3CpU0Wr7Y/gGiQx
         Q5AR3nwPGYi9ln6s+nB0t82cwyTJNq6P+L7+vZk0rApom57Ed6DA/kNNzKnLkCLBf1zY
         4Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m9zvSZe68jgoYggnKmJEwWFOA2wmg629eWtmjh7kzPQ=;
        b=MItT7pJu9M+8hKeiuneFHhUxhIeg3xrUg87aWXz2Jpm/VkLZ4z9pyDnJ93ouFKFPrT
         qBpXSOZ8D1RD8LIpFxGWl/eq5zV4F/A0LrIDXHths/Os4EQQIbfws6vNVsGlENKLIoQ1
         lWYIMD4Qo3HZhC0OOJglsVH68HxmVuPktdmtkjg8UONvGu4I7cLy3ncJ1qi5WWDBm876
         lJJe06O9Zvfne/CVeOktEPHp1D073oHg9CjWVBQrOojrYbBIF+Y8QJWsKgK7UVo3XOlW
         qG4kuITlkm/67s0b9aopYOCfsYxbMo6wjhBZ27fSyQOuK0aM9M9TUleQxflvW2DmFuYQ
         uvcg==
X-Gm-Message-State: AOAM532Uk0txaP72++vnSTbbpg/URNDd+QEdBBdo0e0qBkBBSz+q7Mqc
        i9d/1IG6YhoCNxY9MHE4piw=
X-Google-Smtp-Source: ABdhPJwjuEigkpTgbKlBbSTxIAxuAg+D4dHm8eczLtD7GX+Pdf/UgLW47NVvHZqT2j1mPDBPEyrrhg==
X-Received: by 2002:a63:504a:: with SMTP id q10mr11139668pgl.383.1627849995245;
        Sun, 01 Aug 2021 13:33:15 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:15b3:589:f07d:5386:a3c2:3056])
        by smtp.gmail.com with ESMTPSA id k10sm8897974pfc.169.2021.08.01.13.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 13:33:14 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH v2 4/6] USB: serial: ftdi_sio: use usb_control_msg_recv()
Date:   Mon,  2 Aug 2021 02:01:20 +0530
Message-Id: <20210801203122.3515-5-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210801203122.3515-1-himadrispandya@gmail.com>
References: <20210801203122.3515-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_control_msg_recv() nicely wraps usb_control_msg() and removes the
compulsion of using dma buffers for usb messages. It also includes proper
error check for possible short read. So use the wrapper and remove dma
buffers from the callers.

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
Changes in v2:
 - Drop unnecessary use of wrappers
---
 drivers/usb/serial/ftdi_sio.c | 53 ++++++++++-------------------------
 1 file changed, 15 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 4a1f3a95d017..d4c61568b549 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1436,27 +1436,15 @@ static int _read_latency_timer(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	struct usb_device *udev = port->serial->dev;
-	unsigned char *buf;
+	u8 buf;
 	int rv;
 
-	buf = kmalloc(1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	rv = usb_control_msg(udev,
-			     usb_rcvctrlpipe(udev, 0),
-			     FTDI_SIO_GET_LATENCY_TIMER_REQUEST,
-			     FTDI_SIO_GET_LATENCY_TIMER_REQUEST_TYPE,
-			     0, priv->interface,
-			     buf, 1, WDR_TIMEOUT);
-	if (rv < 1) {
-		if (rv >= 0)
-			rv = -EIO;
-	} else {
-		rv = buf[0];
-	}
-
-	kfree(buf);
+	rv = usb_control_msg_recv(udev, 0, FTDI_SIO_GET_LATENCY_TIMER_REQUEST,
+				  FTDI_SIO_GET_LATENCY_TIMER_REQUEST_TYPE, 0,
+				  priv->interface, &buf, 1, WDR_TIMEOUT,
+				  GFP_KERNEL);
+	if (rv == 0)
+		rv = buf;
 
 	return rv;
 }
@@ -1851,32 +1839,21 @@ static int ftdi_read_cbus_pins(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	struct usb_serial *serial = port->serial;
-	unsigned char *buf;
+	u8 buf;
 	int result;
 
 	result = usb_autopm_get_interface(serial->interface);
 	if (result)
 		return result;
 
-	buf = kmalloc(1, GFP_KERNEL);
-	if (!buf) {
-		usb_autopm_put_interface(serial->interface);
-		return -ENOMEM;
-	}
-
-	result = usb_control_msg(serial->dev,
-				 usb_rcvctrlpipe(serial->dev, 0),
-				 FTDI_SIO_READ_PINS_REQUEST,
-				 FTDI_SIO_READ_PINS_REQUEST_TYPE, 0,
-				 priv->interface, buf, 1, WDR_TIMEOUT);
-	if (result < 1) {
-		if (result >= 0)
-			result = -EIO;
-	} else {
-		result = buf[0];
-	}
+	result = usb_control_msg_recv(serial->dev, 0,
+				      FTDI_SIO_READ_PINS_REQUEST,
+				      FTDI_SIO_READ_PINS_REQUEST_TYPE, 0,
+				      priv->interface, &buf, 1, WDR_TIMEOUT,
+				      GFP_KERNEL);
+	if (result == 0)
+		result = buf;
 
-	kfree(buf);
 	usb_autopm_put_interface(serial->interface);
 
 	return result;
-- 
2.17.1

