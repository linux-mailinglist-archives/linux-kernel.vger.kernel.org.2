Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB6394805
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhE1UlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhE1UlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:41:18 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56F7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:39:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:169:3df5::4db])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 578FD5C4C67;
        Fri, 28 May 2021 22:39:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1622234379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=KhCy/yoLV9qevSGKOXy0Z5r2TlIVvAc3NqHXzFrQ7Ps=;
        b=CNOXm1NA77BtO6n2KyYUBijKIQTJ4VFNuMseNUN4mJsflN/0DQC2lVwjOYanp94HTZAvMT
        vjuQjDscLy0F8DOVWnCaZaJrIRexdl8ypsBSaolPEvBvtXmsT5ZnpqP2Bei+MbrAFVGuCM
        kukFFX4iEaGNHkmmctuK5QAdgyHo+zE=
From:   Stefan Agner <stefan@agner.ch>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefan@agner.ch
Subject: [PATCH] USB: serial: cp210x: Fix alternate function for CP2102N QFN20
Date:   Fri, 28 May 2021 22:39:31 +0200
Message-Id: <51830b2b24118eb0f77c5c9ac64ffb2f519dbb1d.1622218300.git.stefan@agner.ch>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QFN20 part has a different GPIO/port function assignment. The
configuration struct bit field ordered as TX/RX/RS485/WAKEUP/CLK
which exactly matches GPIO0-3 for QFN24/28. However, QFN20 has a
different GPIO to primary function assignment.

Special case QFN20 to follow to properly detect which GPIOs are
available.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Tested on a custom PCB with a CP2102N QFP20 device. I noticed the bug after
configuring GPIO.2/3 to be TX/RX LED.

--
Stefan

 drivers/usb/serial/cp210x.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index ee595d1bea0a..c9f8ebd34122 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -537,6 +537,12 @@ struct cp210x_single_port_config {
 #define CP210X_2NCONFIG_GPIO_RSTLATCH_IDX	587
 #define CP210X_2NCONFIG_GPIO_CONTROL_IDX	600
 
+/* CP2102N QFN20 port configuration values */
+#define CP2102N_QFN20_GPIO2_TXLED_MODE		BIT(2)
+#define CP2102N_QFN20_GPIO3_RXLED_MODE		BIT(3)
+#define CP2102N_QFN20_GPIO1_RS485_MODE		BIT(4)
+#define CP2102N_QFN20_GPIO0_CLK_MODE		BIT(6)
+
 /* CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x2 bytes. */
 struct cp210x_gpio_write {
 	u8	mask;
@@ -1733,7 +1739,19 @@ static int cp2102n_gpioconf_init(struct usb_serial *serial)
 	priv->gpio_pushpull = (gpio_pushpull >> 3) & 0x0f;
 
 	/* 0 indicates GPIO mode, 1 is alternate function */
-	priv->gpio_altfunc = (gpio_ctrl >> 2) & 0x0f;
+	if (priv->partnum == CP210X_PARTNUM_CP2102N_QFN20) {
+		/* QFN20 is special... */
+		if (gpio_ctrl & CP2102N_QFN20_GPIO0_CLK_MODE)   /* GPIO 0 */
+			priv->gpio_altfunc |= BIT(0);
+		if (gpio_ctrl & CP2102N_QFN20_GPIO1_RS485_MODE) /* GPIO 1 */
+			priv->gpio_altfunc |= BIT(1);
+		if (gpio_ctrl & CP2102N_QFN20_GPIO2_TXLED_MODE) /* GPIO 2 */
+			priv->gpio_altfunc |= BIT(2);
+		if (gpio_ctrl & CP2102N_QFN20_GPIO3_RXLED_MODE) /* GPIO 3 */
+			priv->gpio_altfunc |= BIT(3);
+	} else {
+		priv->gpio_altfunc = (gpio_ctrl >> 2) & 0x0f;
+	}
 
 	if (priv->partnum == CP210X_PARTNUM_CP2102N_QFN28) {
 		/*
-- 
2.31.1

