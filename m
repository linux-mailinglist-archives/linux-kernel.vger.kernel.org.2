Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F9D33B072
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCOK4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhCOK4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:56:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDEEC061574;
        Mon, 15 Mar 2021 03:56:43 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s21so8572228pjq.1;
        Mon, 15 Mar 2021 03:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjEoP/mOGO2TvXZO1+pbAIUlCN14kUHKOmr01cOJo0k=;
        b=YAVQtiYke8i5GwXu58UXmv9tu/8/R5IvlKP5yNCPbWOs370fpG/jUzNSeEim5OkzHv
         RNyzVAOubudXd+S5Tnh2yeh7hIeIDqkltpPRQ0oNqUkNVTHOMfHx3ETY5PIGl69zDZhE
         huUnoVaktBmEhy0sXCR8QT9v7afXcxUit7ql1bIMRvLp2vlLVHh4wCT6TTLqv3Me2CFm
         JpnDQrgzlDewyS3an8pT5xIDF/WzAEwZ9miEtu/w3zKslWG5BHNLgiymFJxOUqIGr7EZ
         A1NR9wHxfWHH2/eKyzati7FlqFwpOhS9K26PJKg4/LLTJbSb5KaQ1zB5icYnWpoQAM2T
         59pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjEoP/mOGO2TvXZO1+pbAIUlCN14kUHKOmr01cOJo0k=;
        b=jmTKqy6ZyeBlluSKEf0C1FIUGzmS4DCaUtn7Yd02K0Ee3XHu+DBpppyS9nIRCYaOKm
         yEj6MhwbkN/Qhv2XT2hzsWBixTcKfFopcDv8hHtP8WKGe9LOkzOpB5dXZFroZ0fNVQH9
         Uh36IATl5f7kKly4+0Xism4LAtU9X+sN5qUQo4q0IVw7iNgHELG8N1hDwKLpAaSqchDi
         J78aebDyvZzVANmZehyteZ87WA4/2oisJ008ymCKf8X4ZDDctlv6K0MrPGhSUszO2ObY
         5SqgFwoa6rooGb+7S9tIClXDBR0aF/Z9GxzL1sG9u8W63EQ+4T5TQDmWtvFIdPrs898W
         8yOA==
X-Gm-Message-State: AOAM530hJkgTALqAumc2FLjxLkZrzQtlhQz9SrlXKXY8MCwxJuO6iukY
        8zZjAXlwHXLNRJndsqMbi2A=
X-Google-Smtp-Source: ABdhPJyAf5vVF+dQC6dADL7niodzTd+Kj6URHTfV0w7JOwPsM5VqfYyRxurpPfms/wZO35FpUX1zoQ==
X-Received: by 2002:a17:902:8306:b029:e6:125c:1a3a with SMTP id bd6-20020a1709028306b02900e6125c1a3amr11518844plb.65.1615805803446;
        Mon, 15 Mar 2021 03:56:43 -0700 (PDT)
Received: from localhost.localdomain ([27.67.188.119])
        by smtp.gmail.com with ESMTPSA id bj15sm10449724pjb.9.2021.03.15.03.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:56:42 -0700 (PDT)
From:   Pho Tran <photranvan0712@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hung.Nguyen@silabs.com, Pho Tran <pho.tran@silabs.com>
Subject: [PATCH v5] USB: serial: cp210x: Make the CP210x driver work with GPIOs of CP2108
Date:   Mon, 15 Mar 2021 17:56:26 +0700
Message-Id: <20210315105626.2510-1-photranvan0712@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pho Tran <pho.tran@silabs.com>

Similar to other CP210x devices, GPIO interfaces (gpiochip) should be
supported for CP2108.

CP2108 has 4 serial interfaces but only 1 set of GPIO pins are shared
to all of those interfaces. So, just need to initialize GPIOs of CP2108
with only one interface (I use interface 0). It means just only 1 gpiochip
device file will be created for CP2108.

CP2108 has 16 GPIOs, So data types of several variables need to be is u16
instead of u8(in struct cp210x_serial_private). This doesn't affect other
CP210x devices.

Because CP2108 has 16 GPIO pins, the parameter passed by cp210x functions
will be different from other CP210x devices. So need to check part number
of the device to use correct data format  before sending commands to
devices.

Like CP2104, CP2108 have GPIO pins with configurable options. Therefore,
should be mask all pins which are not in GPIO mode in cp2108_gpio_init()
function.

Signed-off-by: Pho Tran <pho.tran@silabs.com>
---

03/12/2022: Patch v4 used git send-mail instead of send patch by manual
follow the instructions of Johan Hovold <johan@kernel.org>.
03/05/2021: Patch v3 modified format and contents of changelog follow feedback
from Johan Hovold <johan@kernel.org>.
03/04/2021: Patch v2 modified format patch as comment from
Johan Hovold <johan@kernel.org>:
	1. Break commit message lines at 80 cols
	2. Use kernel u8 and u16 instead of the c99 ones.
03/01/2021: Initialed submission of patch "Make the CP210x driver work with
GPIOs of CP2108.".

 drivers/usb/serial/cp210x.c | 199 +++++++++++++++++++++++++++++++-----
 1 file changed, 172 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 7bec1e730b20..0e92e41bacc5 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -245,9 +245,9 @@ struct cp210x_serial_private {
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip	gc;
 	bool			gpio_registered;
-	u8			gpio_pushpull;
-	u8			gpio_altfunc;
-	u8			gpio_input;
+	u16			gpio_pushpull;
+	u16			gpio_altfunc;
+	u16			gpio_input;
 #endif
 	u8			partnum;
 	speed_t			min_speed;
@@ -500,6 +500,25 @@ struct cp210x_single_port_config {
 	u8	device_cfg;
 } __packed;
 
+/*
+ * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 0x49 bytes
+ * on a CP2108 chip. Structure needs padding due to unused/unspecified bytes.
+ */
+struct cp210x_quad_port_state {
+	__le16 Mode_PB[5];
+	__le16 LowPower_PB[5];
+	__le16 Latch_PB[5];
+} __packed;
+
+struct cp210x_quad_port_config {
+	struct cp210x_quad_port_state reset_state;
+	struct cp210x_quad_port_state suspend_state;
+	u8 IPDelay_IFC[4];
+	u8 EnhancedFxn_IFC[4];
+	u8 EnhancedFxn_Device;
+	u8 ExtClkFreq[4];
+} __packed;
+
 /* GPIO modes */
 #define CP210X_SCI_GPIO_MODE_OFFSET	9
 #define CP210X_SCI_GPIO_MODE_MASK	GENMASK(11, 9)
@@ -510,6 +529,27 @@ struct cp210x_single_port_config {
 #define CP210X_GPIO_MODE_OFFSET		8
 #define CP210X_GPIO_MODE_MASK		GENMASK(11, 8)
 
+#define CP2108_GPIO_MODE_OFFSET		0
+#define CP2108_GPIO_MODE_MASK		GENMASK(15, 0)
+
+/* CP2108 port configuration values */
+#define CP2108_GPIO0_ALTERNATE_FUNC		BIT(0)
+#define CP2108_GPIO1_ALTERNATE_FUNC		BIT(1)
+#define CP2108_GPIO2_ALTERNATE_FUNC		BIT(2)
+#define CP2108_GPIO3_ALTERNATE_FUNC		BIT(3)
+#define CP2108_GPIO4_ALTERNATE_FUNC		BIT(4)
+#define CP2108_GPIO5_ALTERNATE_FUNC		BIT(5)
+#define CP2108_GPIO6_ALTERNATE_FUNC		BIT(6)
+#define CP2108_GPIO7_ALTERNATE_FUNC		BIT(7)
+#define CP2108_GPIO8_ALTERNATE_FUNC		BIT(8)
+#define CP2108_GPIO9_ALTERNATE_FUNC		BIT(9)
+#define CP2108_GPIO10_ALTERNATE_FUNC	BIT(10)
+#define CP2108_GPIO11_ALTERNATE_FUNC	BIT(11)
+#define CP2108_GPIO12_ALTERNATE_FUNC	BIT(12)
+#define CP2108_GPIO13_ALTERNATE_FUNC	BIT(13)
+#define CP2108_GPIO14_ALTERNATE_FUNC	BIT(14)
+#define CP2108_GPIO15_ALTERNATE_FUNC	BIT(15)
+
 /* CP2105 port configuration values */
 #define CP2105_GPIO0_TXLED_MODE		BIT(0)
 #define CP2105_GPIO1_RXLED_MODE		BIT(1)
@@ -532,6 +572,12 @@ struct cp210x_gpio_write {
 	u8	state;
 };
 
+/* CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x4 bytes on CP2108. */
+struct cp2108_gpio_write {
+	u16	mask;
+	u16	state;
+} __packed;
+
 /*
  * Helper to get interface number when we only have struct usb_serial.
  */
@@ -1298,50 +1344,73 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
 	u8 req_type = REQTYPE_DEVICE_TO_HOST;
 	int result;
-	u8 buf;
-
-	if (priv->partnum == CP210X_PARTNUM_CP2105)
-		req_type = REQTYPE_INTERFACE_TO_HOST;
 
-	result = usb_autopm_get_interface(serial->interface);
-	if (result)
-		return result;
+	if (priv->partnum == CP210X_PARTNUM_CP2108) {
+		u16 buf;
 
-	result = cp210x_read_vendor_block(serial, req_type,
-					  CP210X_READ_LATCH, &buf, sizeof(buf));
-	usb_autopm_put_interface(serial->interface);
-	if (result < 0)
-		return result;
-
-	return !!(buf & BIT(gpio));
+		req_type = REQTYPE_INTERFACE_TO_HOST;
+		result = usb_autopm_get_interface(serial->interface);
+		if (result)
+			return result;
+		result = cp210x_read_vendor_block(serial, req_type,
+						CP210X_READ_LATCH, &buf, sizeof(buf));
+		usb_autopm_put_interface(serial->interface);
+		if (result < 0)
+			return result;
+		return !!(buf & BIT(gpio));
+	} else {
+		u8 buf;
+
+		if (priv->partnum == CP210X_PARTNUM_CP2105)
+			req_type = REQTYPE_INTERFACE_TO_HOST;
+		result = usb_autopm_get_interface(serial->interface);
+		if (result)
+			return result;
+		result = cp210x_read_vendor_block(serial, req_type,
+						CP210X_READ_LATCH, &buf, sizeof(buf));
+		usb_autopm_put_interface(serial->interface);
+		if (result < 0)
+			return result;
+		return !!(buf & BIT(gpio));
+	}
 }
 
 static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 {
 	struct usb_serial *serial = gpiochip_get_data(gc);
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
-	struct cp210x_gpio_write buf;
+	struct cp210x_gpio_write u8_buf;
+	struct cp2108_gpio_write u16_buf;
 	int result;
 
 	if (value == 1)
-		buf.state = BIT(gpio);
+		u8_buf.state = BIT(gpio);
 	else
-		buf.state = 0;
+		u8_buf.state = 0;
 
-	buf.mask = BIT(gpio);
+	u8_buf.mask = BIT(gpio);
 
 	result = usb_autopm_get_interface(serial->interface);
 	if (result)
 		goto out;
 
-	if (priv->partnum == CP210X_PARTNUM_CP2105) {
+	if (priv->partnum == CP210X_PARTNUM_CP2105)
 		result = cp210x_write_vendor_block(serial,
 						   REQTYPE_HOST_TO_INTERFACE,
-						   CP210X_WRITE_LATCH, &buf,
-						   sizeof(buf));
+						   CP210X_WRITE_LATCH, &u8_buf,
+						   sizeof(u8_buf));
+	else if (priv->partnum == CP210X_PARTNUM_CP2108) {
+		if (value == 1)
+			u16_buf.state = cpu_to_le16(BIT(gpio));
+		else
+			u16_buf.state = 0;
+		u16_buf.mask = cpu_to_le16(BIT(gpio));
+		result = cp210x_write_vendor_block(serial,
+						   REQTYPE_HOST_TO_INTERFACE,
+						   CP210X_WRITE_LATCH, &u16_buf,
+						   sizeof(u16_buf));
 	} else {
-		u16 wIndex = buf.state << 8 | buf.mask;
-
+		u16 wIndex = u8_buf.state << 8 | u8_buf.mask;
 		result = usb_control_msg(serial->dev,
 					 usb_sndctrlpipe(serial->dev, 0),
 					 CP210X_VENDOR_SPECIFIC,
@@ -1350,7 +1419,6 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 					 wIndex,
 					 NULL, 0, USB_CTRL_SET_TIMEOUT);
 	}
-
 	usb_autopm_put_interface(serial->interface);
 out:
 	if (result < 0) {
@@ -1420,6 +1488,75 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
 	return -ENOTSUPP;
 }
 
+static int cp2108_gpio_init(struct usb_serial *serial)
+{
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+	struct cp210x_quad_port_config config;
+	u16 iface_config;
+	u16 gpio_latch;
+	int result;
+	u16 i;
+
+	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
+					  CP210X_GET_PORTCONFIG, &config,
+					  sizeof(config));
+	if (result < 0) {
+		dev_warn(&serial->interface->dev,
+			 "querying port config on cp2108 failed\n");
+		return result;
+	}
+	priv->gc.ngpio = 16;
+	iface_config = config.EnhancedFxn_IFC[0];
+	priv->gpio_pushpull = (u16)((le16_to_cpu(config.reset_state.Mode_PB[1]) &
+								CP2108_GPIO_MODE_MASK) >>
+								CP2108_GPIO_MODE_OFFSET);
+	gpio_latch = (u16)((le16_to_cpu(config.reset_state.Latch_PB[1]) &
+						CP2108_GPIO_MODE_MASK) >>
+						CP2108_GPIO_MODE_OFFSET);
+
+	/* mark all pins which are not in GPIO mode */
+	if (iface_config & CP2108_GPIO0_ALTERNATE_FUNC)		/* GPIO 0 */
+		priv->gpio_altfunc |= BIT(0);
+	if (iface_config & CP2108_GPIO1_ALTERNATE_FUNC)		/* GPIO 1 */
+		priv->gpio_altfunc |= BIT(1);
+	if (iface_config & CP2108_GPIO2_ALTERNATE_FUNC)		/* GPIO 2 */
+		priv->gpio_altfunc |= BIT(2);
+	if (iface_config & CP2108_GPIO3_ALTERNATE_FUNC)		/* GPIO 3 */
+		priv->gpio_altfunc |= BIT(3);
+	if (iface_config & CP2108_GPIO4_ALTERNATE_FUNC)		/* GPIO 4 */
+		priv->gpio_altfunc |= BIT(4);
+	if (iface_config & CP2108_GPIO5_ALTERNATE_FUNC)		/* GPIO 5 */
+		priv->gpio_altfunc |= BIT(5);
+	if (iface_config & CP2108_GPIO6_ALTERNATE_FUNC)		/* GPIO 6 */
+		priv->gpio_altfunc |= BIT(6);
+	if (iface_config & CP2108_GPIO7_ALTERNATE_FUNC)		/* GPIO 7 */
+		priv->gpio_altfunc |= BIT(7);
+	if (iface_config & CP2108_GPIO8_ALTERNATE_FUNC)		/* GPIO 8 */
+		priv->gpio_altfunc |= BIT(8);
+	if (iface_config & CP2108_GPIO9_ALTERNATE_FUNC)		/* GPIO 9 */
+		priv->gpio_altfunc |= BIT(9);
+	if (iface_config & CP2108_GPIO10_ALTERNATE_FUNC)	/* GPIO 10 */
+		priv->gpio_altfunc |= BIT(10);
+	if (iface_config & CP2108_GPIO11_ALTERNATE_FUNC)	/* GPIO 11 */
+		priv->gpio_altfunc |= BIT(11);
+	if (iface_config & CP2108_GPIO12_ALTERNATE_FUNC)	/* GPIO 12 */
+		priv->gpio_altfunc |= BIT(12);
+	if (iface_config & CP2108_GPIO13_ALTERNATE_FUNC)	/* GPIO 13 */
+		priv->gpio_altfunc |= BIT(13);
+	if (iface_config & CP2108_GPIO14_ALTERNATE_FUNC)	/* GPIO 14 */
+		priv->gpio_altfunc |= BIT(14);
+	if (iface_config & CP2108_GPIO15_ALTERNATE_FUNC)	/* GPIO 15 */
+		priv->gpio_altfunc |= BIT(15);
+
+	for (i = 0; i < priv->gc.ngpio; ++i) {
+		/* Set direction to "input" if pin is open-drain and reset value is 1 */
+		if (!(priv->gpio_pushpull & BIT(i)) && (gpio_latch & BIT(i)))
+			priv->gpio_input |= BIT(i);
+	}
+
+	return 0;
+}
+
 /*
  * This function is for configuring GPIO using shared pins, where other signals
  * are made unavailable by configuring the use of GPIO. This is believed to be
@@ -1649,6 +1786,14 @@ static int cp210x_gpio_init(struct usb_serial *serial)
 	case CP210X_PARTNUM_CP2102N_QFN20:
 		result = cp2102n_gpioconf_init(serial);
 		break;
+	case CP210X_PARTNUM_CP2108:
+		/*
+		 * CP2108 has 4 interfaces, but GPIOs at 4 interfaces are the same and shared.
+		 * So just need init GPIO chip for 1 interface.
+		 */
+		if (cp210x_interface_num(serial) == 0)
+			result = cp2108_gpio_init(serial);
+		break;
 	default:
 		return 0;
 	}
-- 
2.25.1

