Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A98F3A2D10
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhFJNcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 09:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230402AbhFJNct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:32:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12170613F5;
        Thu, 10 Jun 2021 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623331853;
        bh=08tg9EmwQcTk6h4F94sHDVXBbTWUbexJPjygK7f+0CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ngE3NZvlsYNccrKT5GNnKvKUH7L1tIxwGkmFU05Y7qA7SZQwigDB8Dor0mD4sAZDf
         dBNrhtbTUassdpuCo32zX64pnopj8y2XD8SYUJypTPZNYDaD3i4hCogNM9l66NOmxn
         3SaRatsOEnuhuBYNS+2PywBUuMzPSidkhEHVe9AA7gkDuYve29tVpprgJnJK/g191T
         zAKiR0+iEfA5Nl5zVD3EIfhxC1v4j/xvOftJXlJIzc8gVFNgckDuFTQYAxvTIIsreX
         j4AYgZOSCH4VIbFVyjVK+UFfBBlWw+rHavLHoHlD9sZP56zDbcdV7sLweCd3sLc6ZC
         2ijSyxwkZYv5w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lrKli-0006eV-It; Thu, 10 Jun 2021 15:30:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     tu pham <thanhtung1909@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hung.Nguyen@silabs.com, Tung.Pham@silabs.com,
        Pho Tran <pho.tran@silabs.com>,
        Tung Pham <tung.pham@silabs.com>
Subject: [PATCH v13] USB: serial: cp210x: add support for GPIOs on CP2108
Date:   Thu, 10 Jun 2021 15:28:44 +0200
Message-Id: <20210610132844.25495-1-johan@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YMITDyLtcPinbHMv@hovoldconsulting.com>
References: <YMITDyLtcPinbHMv@hovoldconsulting.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pho Tran <pho.tran@silabs.com>

Similar to some other CP210x device types, CP2108 has a number of GPIO
pins that can be exposed through gpiolib.

CP2108 has four serial interfaces but only one set of GPIO pins, which
is modelled as a single gpio chip and registered as a child of the first
interface.

CP2108 has 16 GPIOs so the width of the state variables needs to be
extended to 16 bits and this is also reflected in the control requests.

Like CP2104, CP2108 have GPIO pins with configurable alternate
functions and pins unavailable for GPIO use are determined and reported
to gpiolib at probe.

Signed-off-by: Pho Tran <pho.tran@silabs.com>
Co-developed-by: Tung Pham <tung.pham@silabs.com>
Signed-off-by: Tung Pham <tung.pham@silabs.com>
[ johan: rewrite gpio get() and set(); misc cleanups; amend commit
         message ]
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Tested using CP2108 and CP2102N.

Changes in v13
 - rewrite cp210x_gpio_get() using a shared 16 bit mask and
   le16_to_cpus()
 - rewrite cp210x_gpio_set() using shared 16-bit mask and state
   variables
 - drop pointless no-op shift and mask operations during initialisation
 - reorder defines
 - reword some comments
 - fix some style issues
 - amend commit message

v12 can be found here:
 - https://lore.kernel.org/r/20210426091244.19994-1-tupham@silabs.com


 drivers/usb/serial/cp210x.c | 189 ++++++++++++++++++++++++++++++++----
 1 file changed, 170 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index ee595d1bea0a..8424ad9f0955 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -247,9 +247,9 @@ struct cp210x_serial_private {
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
@@ -531,18 +531,72 @@ struct cp210x_single_port_config {
 #define CP2104_GPIO1_RXLED_MODE		BIT(1)
 #define CP2104_GPIO2_RS485_MODE		BIT(2)
 
+struct cp210x_quad_port_state {
+	__le16 gpio_mode_pb0;
+	__le16 gpio_mode_pb1;
+	__le16 gpio_mode_pb2;
+	__le16 gpio_mode_pb3;
+	__le16 gpio_mode_pb4;
+
+	__le16 gpio_lowpower_pb0;
+	__le16 gpio_lowpower_pb1;
+	__le16 gpio_lowpower_pb2;
+	__le16 gpio_lowpower_pb3;
+	__le16 gpio_lowpower_pb4;
+
+	__le16 gpio_latch_pb0;
+	__le16 gpio_latch_pb1;
+	__le16 gpio_latch_pb2;
+	__le16 gpio_latch_pb3;
+	__le16 gpio_latch_pb4;
+};
+
+/*
+ * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 0x49 bytes
+ * on a CP2108 chip.
+ *
+ * See https://www.silabs.com/documents/public/application-notes/an978-cp210x-usb-to-uart-api-specification.pdf
+ */
+struct cp210x_quad_port_config {
+	struct cp210x_quad_port_state reset_state;
+	struct cp210x_quad_port_state suspend_state;
+	u8 ipdelay_ifc[4];
+	u8 enhancedfxn_ifc[4];
+	u8 enhancedfxn_device;
+	u8 extclkfreq[4];
+} __packed;
+
+#define CP2108_EF_IFC_GPIO_TXLED		0x01
+#define CP2108_EF_IFC_GPIO_RXLED		0x02
+#define CP2108_EF_IFC_GPIO_RS485		0x04
+#define CP2108_EF_IFC_GPIO_RS485_LOGIC		0x08
+#define CP2108_EF_IFC_GPIO_CLOCK		0x10
+#define CP2108_EF_IFC_DYNAMIC_SUSPEND		0x40
+
 /* CP2102N configuration array indices */
 #define CP210X_2NCONFIG_CONFIG_VERSION_IDX	2
 #define CP210X_2NCONFIG_GPIO_MODE_IDX		581
 #define CP210X_2NCONFIG_GPIO_RSTLATCH_IDX	587
 #define CP210X_2NCONFIG_GPIO_CONTROL_IDX	600
 
-/* CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x2 bytes. */
+/*
+ * CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x02 bytes
+ * for CP2102N, CP2103, CP2104 and CP2105.
+ */
 struct cp210x_gpio_write {
 	u8	mask;
 	u8	state;
 };
 
+/*
+ * CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x04 bytes
+ * for CP2108.
+ */
+struct cp210x_gpio_write16 {
+	__le16	mask;
+	__le16	state;
+};
+
 /*
  * Helper to get interface number when we only have struct usb_serial.
  */
@@ -1414,52 +1468,84 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct usb_serial *serial = gpiochip_get_data(gc);
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
-	u8 req_type = REQTYPE_DEVICE_TO_HOST;
+	u8 req_type;
+	u16 mask;
 	int result;
-	u8 buf;
-
-	if (priv->partnum == CP210X_PARTNUM_CP2105)
-		req_type = REQTYPE_INTERFACE_TO_HOST;
+	int len;
 
 	result = usb_autopm_get_interface(serial->interface);
 	if (result)
 		return result;
 
-	result = cp210x_read_vendor_block(serial, req_type,
-					  CP210X_READ_LATCH, &buf, sizeof(buf));
+	switch (priv->partnum) {
+	case CP210X_PARTNUM_CP2105:
+		req_type = REQTYPE_INTERFACE_TO_HOST;
+		len = 1;
+		break;
+	case CP210X_PARTNUM_CP2108:
+		req_type = REQTYPE_INTERFACE_TO_HOST;
+		len = 2;
+		break;
+	default:
+		req_type = REQTYPE_DEVICE_TO_HOST;
+		len = 1;
+		break;
+	}
+
+	mask = 0;
+	result = cp210x_read_vendor_block(serial, req_type, CP210X_READ_LATCH,
+					  &mask, len);
+
 	usb_autopm_put_interface(serial->interface);
+
 	if (result < 0)
 		return result;
 
-	return !!(buf & BIT(gpio));
+	le16_to_cpus((__le16 *)&mask);
+
+	return !!(mask & BIT(gpio));
 }
 
 static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 {
 	struct usb_serial *serial = gpiochip_get_data(gc);
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+	struct cp210x_gpio_write16 buf16;
 	struct cp210x_gpio_write buf;
+	u16 mask, state;
+	u16 wIndex;
 	int result;
 
 	if (value == 1)
-		buf.state = BIT(gpio);
+		state = BIT(gpio);
 	else
-		buf.state = 0;
+		state = 0;
 
-	buf.mask = BIT(gpio);
+	mask = BIT(gpio);
 
 	result = usb_autopm_get_interface(serial->interface);
 	if (result)
 		goto out;
 
-	if (priv->partnum == CP210X_PARTNUM_CP2105) {
+	switch (priv->partnum) {
+	case CP210X_PARTNUM_CP2105:
+		buf.mask = (u8)mask;
+		buf.state = (u8)state;
 		result = cp210x_write_vendor_block(serial,
 						   REQTYPE_HOST_TO_INTERFACE,
 						   CP210X_WRITE_LATCH, &buf,
 						   sizeof(buf));
-	} else {
-		u16 wIndex = buf.state << 8 | buf.mask;
-
+		break;
+	case CP210X_PARTNUM_CP2108:
+		buf16.mask = cpu_to_le16(mask);
+		buf16.state = cpu_to_le16(state);
+		result = cp210x_write_vendor_block(serial,
+						   REQTYPE_HOST_TO_INTERFACE,
+						   CP210X_WRITE_LATCH, &buf16,
+						   sizeof(buf16));
+		break;
+	default:
+		wIndex = state << 8 | mask;
 		result = usb_control_msg(serial->dev,
 					 usb_sndctrlpipe(serial->dev, 0),
 					 CP210X_VENDOR_SPECIFIC,
@@ -1467,6 +1553,7 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 					 CP210X_WRITE_LATCH,
 					 wIndex,
 					 NULL, 0, USB_CTRL_SET_TIMEOUT);
+		break;
 	}
 
 	usb_autopm_put_interface(serial->interface);
@@ -1676,6 +1763,61 @@ static int cp2104_gpioconf_init(struct usb_serial *serial)
 	return 0;
 }
 
+static int cp2108_gpio_init(struct usb_serial *serial)
+{
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+	struct cp210x_quad_port_config config;
+	u16 gpio_latch;
+	int result;
+	u8 i;
+
+	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
+					  CP210X_GET_PORTCONFIG, &config,
+					  sizeof(config));
+	if (result < 0)
+		return result;
+
+	priv->gc.ngpio = 16;
+	priv->gpio_pushpull = le16_to_cpu(config.reset_state.gpio_mode_pb1);
+	gpio_latch = le16_to_cpu(config.reset_state.gpio_latch_pb1);
+
+	/*
+	 * Mark all pins which are not in GPIO mode.
+	 *
+	 * Refer to table 9.1 "GPIO Mode alternate Functions" in the datasheet:
+	 * https://www.silabs.com/documents/public/data-sheets/cp2108-datasheet.pdf
+	 *
+	 * Alternate functions of GPIO0 to GPIO3 are determine by enhancedfxn_ifc[0]
+	 * and the similarly for the other pins; enhancedfxn_ifc[1]: GPIO4 to GPIO7,
+	 * enhancedfxn_ifc[2]: GPIO8 to GPIO11, enhancedfxn_ifc[3]: GPIO12 to GPIO15.
+	 */
+	for (i = 0; i < 4; i++) {
+		if (config.enhancedfxn_ifc[i] & CP2108_EF_IFC_GPIO_TXLED)
+			priv->gpio_altfunc |= BIT(i * 4);
+		if (config.enhancedfxn_ifc[i] & CP2108_EF_IFC_GPIO_RXLED)
+			priv->gpio_altfunc |= BIT((i * 4) + 1);
+		if (config.enhancedfxn_ifc[i] & CP2108_EF_IFC_GPIO_RS485)
+			priv->gpio_altfunc |= BIT((i * 4) + 2);
+		if (config.enhancedfxn_ifc[i] & CP2108_EF_IFC_GPIO_CLOCK)
+			priv->gpio_altfunc |= BIT((i * 4) + 3);
+	}
+
+	/*
+	 * Like CP2102N, CP2108 has also no strict input and output pin
+	 * modes. Do the same input mode emulation as CP2102N.
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
 static int cp2102n_gpioconf_init(struct usb_serial *serial)
 {
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
@@ -1780,6 +1922,15 @@ static int cp210x_gpio_init(struct usb_serial *serial)
 	case CP210X_PARTNUM_CP2105:
 		result = cp2105_gpioconf_init(serial);
 		break;
+	case CP210X_PARTNUM_CP2108:
+		/*
+		 * The GPIOs are not tied to any specific port so only register
+		 * once for interface 0.
+		 */
+		if (cp210x_interface_num(serial) != 0)
+			return 0;
+		result = cp2108_gpio_init(serial);
+		break;
 	case CP210X_PARTNUM_CP2102N_QFN28:
 	case CP210X_PARTNUM_CP2102N_QFN24:
 	case CP210X_PARTNUM_CP2102N_QFN20:
-- 
2.31.1

