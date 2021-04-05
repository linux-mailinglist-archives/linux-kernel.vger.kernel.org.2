Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B757353C11
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 08:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhDEGSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 02:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhDEGSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 02:18:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E74C061756;
        Sun,  4 Apr 2021 23:18:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so5336041pjg.5;
        Sun, 04 Apr 2021 23:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKnwZasJLmRmM4SmZ378Jk/xmElI9OgybU5GoT1YGbM=;
        b=qolNSVkWxtHvev29L3Od4n/ByQSqwij+9D83XyYJQRFBgmS7zGrrxqGBGN2UVZm+1z
         JgBlZz6hUYl8HWKfy9jhwmsT0QHXYHxZ35pPXn9ChBBnRtKkFojRVd/T+URlXbwWLCKS
         xhreRB4pnfXkYoW/7H/kP9LsRnrohkzRh6bLnkGDFKS8loKQ837Bkb3AhQHkiaVmMttQ
         MjWoDYOz2+QTeP6AVLjg5J9pLLf/nnTWUZ4fcUkZ7OrO9ZMnHQc3GwbXVy75JdL0pn4N
         unZL/mFt2fZ0lfbBq3rgHCa8/kE/k6jzF8Mkr7r6gspFBDhOTYCUskGnVac/DfauTduc
         8Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKnwZasJLmRmM4SmZ378Jk/xmElI9OgybU5GoT1YGbM=;
        b=pgJ9eicXgliQ1SNxZNzli3KhM4V+npoNP+7RJ0KkCrfQwmFXNPFhgxsIgzI0cJT2H4
         BDaJUuDOGmoUklWgJHee28XnWyvWjj2NOde7orZVf4Zu4jYZw6FCCcqZ6Vx5NC1Iq2o/
         MkgdrV9/4sLF7J6CX4w/L6dMLEp7IUOv+trVuVqnDxhzDtV1VDxU0aoNrW7oDwlAcl68
         O/pQ+MHi1g5gyqNIlt7m7j90IcuJMiwWhpa9fki1q5NA0+ptinirrWzlXd6MWwQPGm3V
         osXsIsV4LEOLUYzLqbSHzGp9pI9lTwaTA4Urshg24ZjFF+PSY8kAkGBfo4qM1Q2KeWry
         kcXw==
X-Gm-Message-State: AOAM532MHDN1GnSYchrfUzchFZvtqHyeDkNo9mB1C2PHRFHhE5kxx3ie
        JayUBcansGERoJkQxYeM6wo=
X-Google-Smtp-Source: ABdhPJx4vBD+FMeB6Ltj1MJfi63WvfCKvmP4f5KZLMEw9zA1V1xCkgN+csY2dSQwWdePTbwktq3P8Q==
X-Received: by 2002:a17:902:b210:b029:e6:5f:62e with SMTP id t16-20020a170902b210b02900e6005f062emr22687341plr.48.1617603514450;
        Sun, 04 Apr 2021 23:18:34 -0700 (PDT)
Received: from localhost.localdomain ([27.67.181.35])
        by smtp.gmail.com with ESMTPSA id u14sm8020649pji.15.2021.04.04.23.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 23:18:33 -0700 (PDT)
From:   Pho Tran <photranvan0712@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hung.Nguyen@silabs.com, Tung.Pham@silabs.com,
        Pho Tran <pho.tran@silabs.com>
Subject: [PATCH v6] USB: serial: cp210x: Add support for GPIOs on CP2108
Date:   Mon,  5 Apr 2021 13:18:23 +0700
Message-Id: <20210405061823.3855-1-photranvan0712@gmail.com>
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
function. Alternate functions of GPIO0 to GPIO3 is determine by
enhancedfxn_IFC[0] and similar for enhancedfxn_IFC[1] and
enhancedfxn_IFC[2]. Refer to CP2108 datasheet at sector
"9: GPIO and UART pins" for more detail:
https://www.silabs.com/documents/public/data-sheets/cp2108-datasheet.pdf

Signed-off-by: Pho Tran <pho.tran@silabs.com>
---

03/15/2021: Patch v5 Modifed code according to comment of Johan:
	1. Unified the handling of CP2108 and other types and
	take care about endianness.
	2. Used suitable types data for variable.
	3. Fixed cp2108_gpio_init and add more detail on
	commit message and comment.
	4. Dropped some of the ones that don't add any value.
03/12/2021: Patch v4 used git send-mail instead of send patch by manual
follow the instructions of Johan Hovold <johan@kernel.org>.
03/05/2021: Patch v3 modified format and contents of changelog follow feedback
from Johan Hovold <johan@kernel.org>.
03/04/2021: Patch v2 modified format patch as comment from
Johan Hovold <johan@kernel.org>:
	1. Break commit message lines at 80 cols
	2. Use kernel u8 and u16 instead of the c99 ones.
03/01/2021: Initialed submission of patch "Make the CP210x driver work with
GPIOs of CP2108.".

 drivers/usb/serial/cp210x.c | 253 +++++++++++++++++++++++++++++++-----
 1 file changed, 219 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 7bec1e730b20..f0ecb4315056 100644
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
@@ -399,6 +399,18 @@ static struct usb_serial_driver * const serial_drivers[] = {
 #define CP210X_PARTNUM_CP2102N_QFN20	0x22
 #define CP210X_PARTNUM_UNKNOWN	0xFF
 
+/*
+ * CP2108 Define bit locations for EnhancedFxn_IFCx
+ * Refer to https://www.silabs.com/documents/public/application-notes/an978-cp210x-usb-to-uart-api-specification.pdf
+ * for more information.
+ */
+#define EF_IFC_GPIO_TXLED		0x01
+#define EF_IFC_GPIO_RXLED		0x02
+#define EF_IFC_GPIO_RS485		0x04
+#define EF_IFC_GPIO_RS485_LOGIC 0x08
+#define EF_IFC_GPIO_CLOCK		0x10
+#define EF_IFC_DYNAMIC_SUSPEND	0x40
+
 /* CP210X_GET_COMM_STATUS returns these 0x13 bytes */
 struct cp210x_comm_status {
 	__le32   ulErrors;
@@ -500,6 +512,45 @@ struct cp210x_single_port_config {
 	u8	device_cfg;
 } __packed;
 
+/*
+ * Quad Port Config definitions
+ * Refer to https://www.silabs.com/documents/public/application-notes/an978-cp210x-usb-to-uart-api-specification.pdf
+ * for more information.
+ * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 0x49 bytes
+ * on a CP2108 chip.
+ * CP2108 Quad Port State structure(used in Quad Port Config structure)
+ */
+struct cp210x_quad_port_state {
+	__le16 gpio_mode_PB0;
+	__le16 gpio_mode_PB1;
+	__le16 gpio_mode_PB2;
+	__le16 gpio_mode_PB3;
+	__le16 gpio_mode_PB4;
+
+
+	__le16 gpio_lowpower_PB0;
+	__le16 gpio_lowpower_PB1;
+	__le16 gpio_lowpower_PB2;
+	__le16 gpio_lowpower_PB3;
+	__le16 gpio_lowpower_PB4;
+
+	__le16 gpio_latch_PB0;
+	__le16 gpio_latch_PB1;
+	__le16 gpio_latch_PB2;
+	__le16 gpio_latch_PB3;
+	__le16 gpio_latch_PB4;
+};
+
+// Cp2108 Quad Port Config structure
+struct cp210x_quad_port_config {
+	struct cp210x_quad_port_state reset_state;
+	struct cp210x_quad_port_state suspend_state;
+	u8 ipdelay_IFC[4];
+	u8 enhancedfxn_IFC[4];
+	u8 enhancedfxn_device;
+	u8 extclkfreq[4];
+} __packed;
+
 /* GPIO modes */
 #define CP210X_SCI_GPIO_MODE_OFFSET	9
 #define CP210X_SCI_GPIO_MODE_MASK	GENMASK(11, 9)
@@ -510,6 +561,9 @@ struct cp210x_single_port_config {
 #define CP210X_GPIO_MODE_OFFSET		8
 #define CP210X_GPIO_MODE_MASK		GENMASK(11, 8)
 
+#define CP2108_GPIO_MODE_OFFSET		0
+#define CP2108_GPIO_MODE_MASK		GENMASK(15, 0)
+
 /* CP2105 port configuration values */
 #define CP2105_GPIO0_TXLED_MODE		BIT(0)
 #define CP2105_GPIO1_RXLED_MODE		BIT(1)
@@ -526,12 +580,31 @@ struct cp210x_single_port_config {
 #define CP210X_2NCONFIG_GPIO_RSTLATCH_IDX	587
 #define CP210X_2NCONFIG_GPIO_CONTROL_IDX	600
 
-/* CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x2 bytes. */
-struct cp210x_gpio_write {
+/*
+ * CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these
+ * 0x04 bytes on CP2108.
+ */
+struct cp210x_16gpios_write {
+	__le16	mask;
+	__le16	state;
+};
+
+/*
+ * CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these
+ * 0x02 bytes on CP2102N, Cp2103, Cp2104 and CP2105.
+ */
+struct cp210x_8gpios_write {
 	u8	mask;
 	u8	state;
 };
 
+//Struct cp210x_gpio_write include devices have both of 8 gpios and 16 gpios.
+struct cp210x_gpio_write {
+	struct cp210x_8gpios_write cp210x_8gpios;
+	struct cp210x_16gpios_write cp210x_16gpios;
+};
+
+
 /*
  * Helper to get interface number when we only have struct usb_serial.
  */
@@ -1298,21 +1371,45 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
 	u8 req_type = REQTYPE_DEVICE_TO_HOST;
 	int result;
-	u8 buf;
-
-	if (priv->partnum == CP210X_PARTNUM_CP2105)
-		req_type = REQTYPE_INTERFACE_TO_HOST;
+	__le16 buf;
 
 	result = usb_autopm_get_interface(serial->interface);
 	if (result)
 		return result;
-
-	result = cp210x_read_vendor_block(serial, req_type,
-					  CP210X_READ_LATCH, &buf, sizeof(buf));
-	usb_autopm_put_interface(serial->interface);
+/*
+ * This function will be read latch value of gpio and storage to buf(16bit)
+ * where bit 0 is GPIO0, bit 1 is GPIO1, etc. Up to GPIOn where n is
+ * total number of GPIO pins the interface supports.
+ * Interfaces on CP2102N supports 7 GPIOs
+ * Interfaces on CP2103 amd CP2104 supports 4 GPIOs
+ * Enhanced interfaces on CP2105 support 3 GPIOs
+ * Standard interfaces on CP2105 support 4 GPIOs
+ * Interfaces on CP2108 supports 16 GPIOs
+ */
+	switch (priv->partnum) {
+	/*
+	 * Request type to Read_Latch of CP2105 and Cp2108
+	 * is 0xc1 <REQTYPE_INTERFACE_TO_HOST>
+	 */
+	case CP210X_PARTNUM_CP2108:
+		req_type = REQTYPE_INTERFACE_TO_HOST;
+		result = cp210x_read_vendor_block(serial, req_type,
+						CP210X_READ_LATCH, &buf, sizeof(__le16));
+		break;
+	case CP210X_PARTNUM_CP2105:
+		req_type = REQTYPE_INTERFACE_TO_HOST;
+		result = cp210x_read_vendor_block(serial, req_type,
+						CP210X_READ_LATCH, &buf, sizeof(u8));
+		break;
+	default:
+		result = cp210x_read_vendor_block(serial, req_type,
+						CP210X_READ_LATCH, &buf, sizeof(u8));
+		break;
+	}
 	if (result < 0)
 		return result;
-
+	buf = le16_to_cpu(buf);
+	usb_autopm_put_interface(serial->interface);
 	return !!(buf & BIT(gpio));
 }
 
@@ -1321,37 +1418,49 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 	struct usb_serial *serial = gpiochip_get_data(gc);
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
 	struct cp210x_gpio_write buf;
+	__le16 wIndex;
 	int result;
 
-	if (value == 1)
-		buf.state = BIT(gpio);
-	else
-		buf.state = 0;
-
-	buf.mask = BIT(gpio);
+	if (value == 1) {
+		buf.cp210x_8gpios.state = BIT(gpio);
+		buf.cp210x_16gpios.state = cpu_to_le16(BIT(gpio));
+	} else {
+		buf.cp210x_8gpios.state = 0;
+		buf.cp210x_16gpios.state = 0;
+	}
+	buf.cp210x_8gpios.mask = BIT(gpio);
+	buf.cp210x_16gpios.mask = cpu_to_le16(BIT(gpio));
 
 	result = usb_autopm_get_interface(serial->interface);
 	if (result)
 		goto out;
 
-	if (priv->partnum == CP210X_PARTNUM_CP2105) {
+	switch (priv->partnum) {
+	case CP210X_PARTNUM_CP2108:
 		result = cp210x_write_vendor_block(serial,
-						   REQTYPE_HOST_TO_INTERFACE,
-						   CP210X_WRITE_LATCH, &buf,
-						   sizeof(buf));
-	} else {
-		u16 wIndex = buf.state << 8 | buf.mask;
-
+							REQTYPE_HOST_TO_INTERFACE,
+							CP210X_WRITE_LATCH, &buf.cp210x_16gpios,
+							sizeof(buf.cp210x_16gpios));
+		break;
+	case CP210X_PARTNUM_CP2105:
+		result = cp210x_write_vendor_block(serial,
+							REQTYPE_HOST_TO_INTERFACE,
+							CP210X_WRITE_LATCH, &buf.cp210x_8gpios,
+							sizeof(buf.cp210x_8gpios));
+		break;
+	default:
+		wIndex = buf.cp210x_8gpios.state << 8 | buf.cp210x_8gpios.mask;
 		result = usb_control_msg(serial->dev,
-					 usb_sndctrlpipe(serial->dev, 0),
-					 CP210X_VENDOR_SPECIFIC,
-					 REQTYPE_HOST_TO_DEVICE,
-					 CP210X_WRITE_LATCH,
-					 wIndex,
-					 NULL, 0, USB_CTRL_SET_TIMEOUT);
+							usb_sndctrlpipe(serial->dev, 0),
+							CP210X_VENDOR_SPECIFIC,
+							REQTYPE_HOST_TO_DEVICE,
+							CP210X_WRITE_LATCH,
+							wIndex,
+							NULL, 0, USB_CTRL_SET_TIMEOUT);
+		break;
 	}
-
 	usb_autopm_put_interface(serial->interface);
+
 out:
 	if (result < 0) {
 		dev_err(&serial->interface->dev, "failed to set GPIO value: %d\n",
@@ -1420,6 +1529,73 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
 	return -ENOTSUPP;
 }
 
+static int cp2108_gpio_init(struct usb_serial *serial)
+{
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+	struct cp210x_quad_port_config config;
+	__le16 gpio_latch;
+	__le16 temp;
+	int result;
+	u8 i;
+
+	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
+					  CP210X_GET_PORTCONFIG, &config,
+					  sizeof(config));
+	if (result < 0)
+		return result;
+	priv->gc.ngpio = 16;
+	temp = le16_to_cpu(config.reset_state.gpio_mode_PB1);
+	priv->gpio_pushpull = (temp & CP2108_GPIO_MODE_MASK) >> CP2108_GPIO_MODE_OFFSET;
+	temp = le16_to_cpu(config.reset_state.gpio_latch_PB1);
+	gpio_latch = (temp & CP2108_GPIO_MODE_MASK) >> CP2108_GPIO_MODE_OFFSET;
+	/*
+	 * Mark all pins which are not in GPIO mode
+	 * Refer to table 9.1: GPIO Mode alternate Functions on CP2108 datasheet:
+	 * https://www.silabs.com/documents/public/data-sheets/cp2108-datasheet.pdf
+	 * Alternate Functions of GPIO0 to GPIO3 is determine by enhancedfxn_IFC[0]
+	 * and the same for other pins, enhancedfxn_IFC[1]: GPIO4 to GPIO7,
+	 * enhancedfxn_IFC[2]: GPIO8 to GPIO11, enhancedfxn_IFC[3]: GPIO12 to GPIO15.
+	 */
+	for (i = 0; i < 4; i++) {
+		switch (config.enhancedfxn_IFC[i]) {
+		case EF_IFC_GPIO_TXLED:
+			priv->gpio_altfunc |= BIT(i * 4);
+			break;
+		case EF_IFC_GPIO_RXLED:
+			priv->gpio_altfunc |= BIT((i * 4) + 1);
+			break;
+		case EF_IFC_GPIO_RS485_LOGIC:
+		case EF_IFC_GPIO_RS485:
+			priv->gpio_altfunc |= BIT((i * 4) + 2);
+			break;
+		case EF_IFC_GPIO_CLOCK:
+			priv->gpio_altfunc |= BIT((i * 4) + 3);
+			break;
+		case EF_IFC_DYNAMIC_SUSPEND:
+			priv->gpio_altfunc |= BIT(i * 4);
+			priv->gpio_altfunc |= BIT((i * 4) + 1);
+			priv->gpio_altfunc |= BIT((i * 4) + 2);
+			priv->gpio_altfunc |= BIT((i * 4) + 3);
+			break;
+		}
+	}
+	/*
+	 * Like CP2102N, CP2108 has also no strict input and output pin
+	 * modes.
+	 * Do the same input mode emulation as CP2102N.
+	 */
+	for (i = 0; i < priv->gc.ngpio; ++i) {
+		/*
+		 * Set direction to "input" iff pin is open-drain and reset
+		 * value is 1.
+		 */
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
@@ -1649,6 +1825,15 @@ static int cp210x_gpio_init(struct usb_serial *serial)
 	case CP210X_PARTNUM_CP2102N_QFN20:
 		result = cp2102n_gpioconf_init(serial);
 		break;
+	case CP210X_PARTNUM_CP2108:
+		/*
+		 * The GPIOs are not tied to any specific port so onlu register
+		 * once for interface 0.
+		 */
+		if (cp210x_interface_num(serial) != 0)
+			return 0;
+		result = cp2108_gpio_init(serial);
+		break;
 	default:
 		return 0;
 	}
-- 
2.17.1

