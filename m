Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A185D40B1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhINOuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbhINOtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:49:04 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ACDC05BD1D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:42:43 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:d46f:7eb5:4a37:9d14])
        by laurent.telenet-ops.be with bizsmtp
        id tqih2500P2aSKa101qihrJ; Tue, 14 Sep 2021 16:42:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQ9dq-004VQr-Gt; Tue, 14 Sep 2021 16:42:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQ9dp-00297w-Vx; Tue, 14 Sep 2021 16:42:34 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] auxdisplay: ht16k33: Make use of device properties
Date:   Tue, 14 Sep 2021 16:42:32 +0200
Message-Id: <20210914144232.511697-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device property API allows drivers to gather device resources from
different sources, such as ACPI, and lift the dependency on Device Tree.
Convert the driver to unleash the power of the device property API.

Suggested-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only for the !OF case.

This depends on "[PATCH v6 00/19] auxdisplay: ht16k33: Add character display
support"
(https://lore.kernel.org/r/20210914143835.511051-1-geert@linux-m68k.org)

 drivers/auxdisplay/Kconfig   |  2 +-
 drivers/auxdisplay/ht16k33.c | 25 +++++++++++--------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index e32ef7f9945d49b2..64012cda4d126707 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -169,7 +169,7 @@ config IMG_ASCII_LCD
 
 config HT16K33
 	tristate "Holtek Ht16K33 LED controller with keyscan"
-	depends on FB && OF && I2C && INPUT
+	depends on FB && I2C && INPUT
 	select FB_SYS_FOPS
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index 89ee5b4b3dfccb68..e5b810e37e0337a6 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/fb.h>
 #include <linux/slab.h>
 #include <linux/backlight.h>
@@ -481,15 +481,13 @@ static int ht16k33_led_probe(struct device *dev, struct led_classdev *led,
 			     unsigned int brightness)
 {
 	struct led_init_data init_data = {};
-	struct device_node *node;
 	int err;
 
 	/* The LED is optional */
-	node = of_get_child_by_name(dev->of_node, "led");
-	if (!node)
+	init_data.fwnode = device_get_named_child_node(dev, "led");
+	if (!init_data.fwnode)
 		return 0;
 
-	init_data.fwnode = of_fwnode_handle(node);
 	init_data.devicename = "auxdisplay";
 	init_data.devname_mandatory = true;
 
@@ -510,7 +508,6 @@ static int ht16k33_keypad_probe(struct i2c_client *client,
 				struct ht16k33_keypad *keypad)
 {
 	struct device *dev = &client->dev;
-	struct device_node *node = dev->of_node;
 	u32 rows = HT16K33_MATRIX_KEYPAD_MAX_ROWS;
 	u32 cols = HT16K33_MATRIX_KEYPAD_MAX_COLS;
 	int err;
@@ -529,11 +526,11 @@ static int ht16k33_keypad_probe(struct i2c_client *client,
 	keypad->dev->open = ht16k33_keypad_start;
 	keypad->dev->close = ht16k33_keypad_stop;
 
-	if (!of_get_property(node, "linux,no-autorepeat", NULL))
+	if (!device_property_present(dev, "linux,no-autorepeat"))
 		__set_bit(EV_REP, keypad->dev->evbit);
 
-	err = of_property_read_u32(node, "debounce-delay-ms",
-				   &keypad->debounce_ms);
+	err = device_property_read_u32(dev, "debounce-delay-ms",
+				       &keypad->debounce_ms);
 	if (err) {
 		dev_err(dev, "key debounce delay not specified\n");
 		return err;
@@ -620,8 +617,8 @@ static int ht16k33_fbdev_probe(struct device *dev, struct ht16k33_priv *priv,
 		goto err_fbdev_buffer;
 	}
 
-	err = of_property_read_u32(dev->of_node, "refresh-rate-hz",
-				   &fbdev->refresh_rate);
+	err = device_property_read_u32(dev, "refresh-rate-hz",
+				       &fbdev->refresh_rate);
 	if (err) {
 		dev_err(dev, "refresh rate not specified\n");
 		goto err_fbdev_info;
@@ -727,8 +724,8 @@ static int ht16k33_probe(struct i2c_client *client)
 	if (err)
 		return err;
 
-	err = of_property_read_u32(dev->of_node, "default-brightness-level",
-				   &dft_brightness);
+	err = device_property_read_u32(dev, "default-brightness-level",
+				       &dft_brightness);
 	if (err) {
 		dft_brightness = MAX_BRIGHTNESS;
 	} else if (dft_brightness > MAX_BRIGHTNESS) {
@@ -816,7 +813,7 @@ static struct i2c_driver ht16k33_driver = {
 	.remove		= ht16k33_remove,
 	.driver		= {
 		.name		= DRIVER_NAME,
-		.of_match_table	= of_match_ptr(ht16k33_of_match),
+		.of_match_table	= ht16k33_of_match,
 	},
 	.id_table = ht16k33_i2c_match,
 };
-- 
2.25.1

