Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611AD35A255
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhDIPwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhDIPwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:52:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F2E4610E5;
        Fri,  9 Apr 2021 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617983560;
        bh=6fAGErj2J4HCPH2328MFWjuHuytAsL7Ib/FU8QD+5YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZzcX555balgSmm29H2xGjEKvZ2unnym7l/tIPcmbZpQrMekBhzl4OLcMh1wHP3bV
         z9j811R5LijhuNLF/eAutpvpCWcbyX1PKHa8MMzAQ1OXYlOcp8VzQuwdOEEpZsq8Tx
         0iu/72eE3zeSpq1lS5sLwO2L/PVvwD+QhECH82b4frC5MDsQyhyWlyNKLqRHIyAXvV
         m79bPCzA/bcA6H89j38ZRSi0kJ02xEyQtC4JGZAdZJBHlEvkQ/XL5T+n6s2mXVm+ma
         0RKJFSoRASh7HGDgMpImYMHlegzK5YeSY0reXvqGt5qMaG/2EDxgnrEnCQSoSJcT7A
         jMGMQXNmCSE5w==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lUtQz-0008In-Tc; Fri, 09 Apr 2021 17:52:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pho Tran <photranvan0712@gmail.com>, Hung.Nguyen@silabs.com,
        Tung.Pham@silabs.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] USB: serial: cp210x: provide gpio valid mask
Date:   Fri,  9 Apr 2021 17:52:15 +0200
Message-Id: <20210409155216.31867-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210409155216.31867-1-johan@kernel.org>
References: <20210409155216.31867-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new GPIO valid-mask feature to inform gpiolib which pins are
available for use instead of handling that in a request callback.

This also allows user space to figure out which pins are available
through the chardev interface without having to request each pin in
turn.

Note that the return value when requesting an unavailable pin will now
be -EINVAL instead of -ENODEV.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index a373cd63b3a4..ceb3a656a075 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1410,17 +1410,6 @@ static void cp210x_break_ctl(struct tty_struct *tty, int break_state)
 }
 
 #ifdef CONFIG_GPIOLIB
-static int cp210x_gpio_request(struct gpio_chip *gc, unsigned int offset)
-{
-	struct usb_serial *serial = gpiochip_get_data(gc);
-	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
-
-	if (priv->gpio_altfunc & BIT(offset))
-		return -ENODEV;
-
-	return 0;
-}
-
 static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct usb_serial *serial = gpiochip_get_data(gc);
@@ -1549,6 +1538,18 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
 	return -ENOTSUPP;
 }
 
+static int cp210x_gpio_init_valid_mask(struct gpio_chip *gc,
+		unsigned long *valid_mask, unsigned int ngpios)
+{
+	struct usb_serial *serial = gpiochip_get_data(gc);
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+	unsigned long altfunc_mask = priv->gpio_altfunc;
+
+	bitmap_complement(valid_mask, &altfunc_mask, ngpios);
+
+	return 0;
+}
+
 /*
  * This function is for configuring GPIO using shared pins, where other signals
  * are made unavailable by configuring the use of GPIO. This is believed to be
@@ -1786,13 +1787,13 @@ static int cp210x_gpio_init(struct usb_serial *serial)
 		return result;
 
 	priv->gc.label = "cp210x";
-	priv->gc.request = cp210x_gpio_request;
 	priv->gc.get_direction = cp210x_gpio_direction_get;
 	priv->gc.direction_input = cp210x_gpio_direction_input;
 	priv->gc.direction_output = cp210x_gpio_direction_output;
 	priv->gc.get = cp210x_gpio_get;
 	priv->gc.set = cp210x_gpio_set;
 	priv->gc.set_config = cp210x_gpio_set_config;
+	priv->gc.init_valid_mask = cp210x_gpio_init_valid_mask;
 	priv->gc.owner = THIS_MODULE;
 	priv->gc.parent = &serial->interface->dev;
 	priv->gc.base = -1;
-- 
2.26.3

