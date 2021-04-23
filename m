Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611D13691D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 14:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242300AbhDWMRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 08:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhDWMRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 08:17:31 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44014C061574;
        Fri, 23 Apr 2021 05:16:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w6so19421824pfc.8;
        Fri, 23 Apr 2021 05:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G/BmLl0nYWEPYETZn3uqnSPz9a6Nsg4oY5oONtLIcNg=;
        b=cYuyZF1OUeFIWLkE+F9T4tfBi9YF0hAILdhCAwtDaq3OUZqpPlaicULwnMdWYeK/8d
         Mvdb/xf/K99Mm0Eh0J+736sNmFCNBRRpejyKpXNl3DIMU+o+nSGKBdT3EY2a7V6qRT/+
         8YHkVOWi4fFD5kFHTRrurAQ/UAwdYH+pnbZ7IUnC1TBmo+r95idmda6B94Z2OYvq2Y7Y
         DEVio/0Obok1ACSYBspuATVKMWclSPWUzPMRuyuTRq32GBtVXsqE0m2A7Hn5yh9N7sJ5
         HYtkoeFmKmzT0N7QlpQbbs6CpW7WIWCU+AYzPrpXQocyhm+Bua72s1+hR+ywSkjdclYv
         KSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G/BmLl0nYWEPYETZn3uqnSPz9a6Nsg4oY5oONtLIcNg=;
        b=abNTW69a3aisqsE1gj71sSdz0Mbgz/2JQpC2ZBd57tVJktt1H9CEI11KYTXPqyZvBg
         FWt2VJ1rxEI7mRRn/NWCyuuwAC4F/u4jB6xzpMSeZos+UnNDwNC0stkvAOlZQ05HA7rv
         Pdr/tOBwk2uAsgIcs/nSGVLXYPaD2mh55fBegpTh20lImVAvqjCyF/u3k31jLCEUGjd3
         FiHMnHYxZZDC7v3D7/t5uVNAAtjF0VXormUravwY83RlkzCao6Hb2tzsBf7n2W94QnJv
         JARQnwYVvwQBBGf7Ai+IXxc4EIp8GAG1qW5Xo5ny7NhKnfvcYmP/R7xUMEGleHvOW6Yh
         EXMw==
X-Gm-Message-State: AOAM531Xt5O3VKUia/OSF3AWsCUDQNZMDD/KaHjxZmlyPlNZfXun74Sk
        R6kBMj2jnZKgKuuJ6qF7qQo=
X-Google-Smtp-Source: ABdhPJyPQ7jd0R81xVeBndj5BWcUX3M4s52ihca/Rvvx47bDz2JFltPlbgHTKHSxTG0KAHIiGx9G6Q==
X-Received: by 2002:a63:1c48:: with SMTP id c8mr3531574pgm.234.1619180214732;
        Fri, 23 Apr 2021 05:16:54 -0700 (PDT)
Received: from localhost.localdomain ([27.67.176.78])
        by smtp.gmail.com with ESMTPSA id i123sm5112148pfc.53.2021.04.23.05.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 05:16:54 -0700 (PDT)
From:   tu pham <thanhtung1909@gmail.com>
X-Google-Original-From: tu pham <tupham@silabs.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hung.Nguyen@silabs.com, Tung.Pham@silabs.com,
        thanhtung1909@gmail.com, Pho Tran <pho.tran@silabs.com>
Subject: [PATCH v10] USB: serial: cp210x: Add support for GPIOs on CP2108
Date:   Fri, 23 Apr 2021 19:16:45 +0700
Message-Id: <20210423121645.16790-1-tupham@silabs.com>
X-Mailer: git-send-email 2.17.1
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

04/23/2021: Patch v9 Modified code according to comment of Johan:
        1. Remove quad-port-config comment.
        2. Move defice EF_IFC_GPIOs go after the quad-port-config 
        structure with the other port config defines, add CP2108_ prefix.
        3. Drop CP2108 Quad Port State structure sentence comment;
         clear from the code.
        4. remove Double new line.
        5. Use lowercase pb for consistency.
        6. Avoid // comments. CP2108 (uppercase P).
        7. remove Double new line.
        8. Lowercase ifc.
        9. Just keep the current struct as is and add a second one for 16 bits
         (e.g. struct cp210x_gpio_write16).
        10. don't need both u16 buf, but it may be cleaner to use u8 buf[2] 
        for the transfer buffer.
        11. Add missing indentation.
        12. Try to be consistent with capitalisation of CP210x.
        13. Just do the read after the switch into a common u8 buf[2] and 
        use the full length only for CP2108.
        14. Add leak the PM counter reference here.
        15. Change buf = le16_to_cpu(wbuf); to le16_to_cpup((__le16 *)buf).
        16. Keep the original struct as is cp210x_gpio_write.
        17. Add another one for cp2108 with a suitable suffix.
        18. No need to do open-parenthesis alignment; two tabs is enough.
        19. Random whitespace changes.
        20. Change check enhancedfxn_ifc.
        21. Remove case EF_IFC_GPIO_RS485_LOGIC.
        22. Remove case EF_IFC_DYNAMIC_SUSPEND.
        23. Correct typo: only.
04/08/2021: Patch v8 Fixed build warning reported by kernel test robot
with ARCH=i386
04/05/2021: Patch v7 Modified commit message follow Greg's comment.
04/05/2021: Patch v6 Fixed build warning reported by kernel test robot
with ARCH=x86_64
03/15/2021: Patch v5 Modified code according to comment of Johan:
        1. Unified the handling of CP2108 and other types and
        take care about endianness.
        2. Used suitable types data for variable.
        3. Fixed cp2108_gpio_init and add more detail on
        commit message and comment.
        4. Dropped some of the ones that don't add any value.
        5. Changed how the altfunctions were detected and fixed the gpio_init
         error handling.
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

 drivers/usb/serial/cp210x.c | 211 +++++++++++++++++++++++++++++++-----
 1 file changed, 182 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 7bec1e730b20..24cdf86ed23c 100644
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
@@ -500,6 +500,50 @@ struct cp210x_single_port_config {
 	u8	device_cfg;
 } __packed;
 
+/*
+ * Quad Port Config definitions
+ * Refer to https://www.silabs.com/documents/public/application-notes/an978-cp210x-usb-to-uart-api-specification.pdf
+ * for more information.
+ * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 0x49 bytes
+ * on a CP2108 chip.
+ */
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
+#define CP2108_EF_IFC_GPIO_TXLED		0x01
+#define CP2108_EF_IFC_GPIO_RXLED		0x02
+#define CP2108_EF_IFC_GPIO_RS485		0x04
+#define CP2108_EF_IFC_GPIO_RS485_LOGIC 0x08
+#define CP2108_EF_IFC_GPIO_CLOCK		0x10
+#define CP2108_EF_IFC_DYNAMIC_SUSPEND	0x40
+
+/* CP2108 Quad Port Config structure */
+struct cp210x_quad_port_config {
+	struct cp210x_quad_port_state reset_state;
+	struct cp210x_quad_port_state suspend_state;
+	u8 ipdelay_ifc[4];
+	u8 enhancedfxn_ifc[4];
+	u8 enhancedfxn_device;
+	u8 extclkfreq[4];
+} __packed;
+
 /* GPIO modes */
 #define CP210X_SCI_GPIO_MODE_OFFSET	9
 #define CP210X_SCI_GPIO_MODE_MASK	GENMASK(11, 9)
@@ -510,6 +554,9 @@ struct cp210x_single_port_config {
 #define CP210X_GPIO_MODE_OFFSET		8
 #define CP210X_GPIO_MODE_MASK		GENMASK(11, 8)
 
+#define CP2108_GPIO_MODE_OFFSET		0
+#define CP2108_GPIO_MODE_MASK		GENMASK(15, 0)
+
 /* CP2105 port configuration values */
 #define CP2105_GPIO0_TXLED_MODE		BIT(0)
 #define CP2105_GPIO1_RXLED_MODE		BIT(1)
@@ -526,7 +573,19 @@ struct cp210x_single_port_config {
 #define CP210X_2NCONFIG_GPIO_RSTLATCH_IDX	587
 #define CP210X_2NCONFIG_GPIO_CONTROL_IDX	600
 
-/* CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x2 bytes. */
+/*
+ * CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these
+ * 0x04 bytes on CP2108.
+ */
+struct cp210x_gpio_write16 {
+	__le16	mask;
+	__le16	state;
+};
+
+/*
+ * CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these
+ * 0x02 bytes on CP2102N, Cp2103, Cp2104 and CP2105.
+ */
 struct cp210x_gpio_write {
 	u8	mask;
 	u8	state;
@@ -1298,22 +1357,39 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
 	u8 req_type = REQTYPE_DEVICE_TO_HOST;
 	int result;
-	u8 buf;
-
-	if (priv->partnum == CP210X_PARTNUM_CP2105)
-		req_type = REQTYPE_INTERFACE_TO_HOST;
+	u8 buf[2];
 
 	result = usb_autopm_get_interface(serial->interface);
 	if (result)
 		return result;
+	/*
+	 * This function will be read latch value of gpio and storage to buf(16bit)
+	 * where bit 0 is GPIO0, bit 1 is GPIO1, etc. Up to GPIOn where n is
+	 * total number of GPIO pins the interface supports.
+	 * Interfaces on CP2102N supports 7 GPIOs
+	 * Interfaces on CP2103 amd CP2104 supports 4 GPIOs
+	 * Enhanced interfaces on CP2105 support 3 GPIOs
+	 * Standard interfaces on CP2105 support 4 GPIOs
+	 * Interfaces on CP2108 supports 16 GPIOs
+	 */
+	if ((priv->partnum == CP210X_PARTNUM_CP2108) || (priv->partnum == CP210X_PARTNUM_CP2105)) {
+	/*
+	 * Request type to Read_Latch of CP2105 and CP2108
+	 * is 0xc1 <REQTYPE_INTERFACE_TO_HOST>
+	 */
+		req_type = REQTYPE_INTERFACE_TO_HOST;
+	}
 
 	result = cp210x_read_vendor_block(serial, req_type,
-					  CP210X_READ_LATCH, &buf, sizeof(buf));
-	usb_autopm_put_interface(serial->interface);
-	if (result < 0)
-		return result;
+				CP210X_READ_LATCH, buf, 2);
 
-	return !!(buf & BIT(gpio));
+	if (result < 0){
+		usb_autopm_put_interface(serial->interface);
+		return result;
+	}
+	result = le16_to_cpup((__le16 *)buf);
+	usb_autopm_put_interface(serial->interface);
+	return !!(result & BIT(gpio));
 }
 
 static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
@@ -1321,37 +1397,51 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 	struct usb_serial *serial = gpiochip_get_data(gc);
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
 	struct cp210x_gpio_write buf;
+	struct cp210x_gpio_write16 buf16;
+	u16 wIndex;
 	int result;
 
-	if (value == 1)
+	if (value == 1) {
 		buf.state = BIT(gpio);
-	else
+		buf16.state = cpu_to_le16(BIT(gpio));
+	} else {
 		buf.state = 0;
-
+		buf16.state = 0;
+	}
 	buf.mask = BIT(gpio);
+	buf16.mask = cpu_to_le16(BIT(gpio));
 
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
+						REQTYPE_HOST_TO_INTERFACE,
+						CP210X_WRITE_LATCH, &buf16,
+						sizeof(buf16));
+		break;
+	case CP210X_PARTNUM_CP2105:
+		result = cp210x_write_vendor_block(serial,
+						REQTYPE_HOST_TO_INTERFACE,
+						CP210X_WRITE_LATCH, &buf,
+						sizeof(buf));
+		break;
+	default:
+		wIndex = buf.state << 8 | buf.mask;
 		result = usb_control_msg(serial->dev,
-					 usb_sndctrlpipe(serial->dev, 0),
-					 CP210X_VENDOR_SPECIFIC,
-					 REQTYPE_HOST_TO_DEVICE,
-					 CP210X_WRITE_LATCH,
-					 wIndex,
-					 NULL, 0, USB_CTRL_SET_TIMEOUT);
+						usb_sndctrlpipe(serial->dev, 0),
+						CP210X_VENDOR_SPECIFIC,
+						REQTYPE_HOST_TO_DEVICE,
+						CP210X_WRITE_LATCH,
+						wIndex,
+						NULL, 0, USB_CTRL_SET_TIMEOUT);
+		break;
 	}
 
 	usb_autopm_put_interface(serial->interface);
+
 out:
 	if (result < 0) {
 		dev_err(&serial->interface->dev, "failed to set GPIO value: %d\n",
@@ -1420,6 +1510,60 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
 	return -ENOTSUPP;
 }
 
+static int cp2108_gpio_init(struct usb_serial *serial)
+{
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+	struct cp210x_quad_port_config config;
+	u16 gpio_latch;
+	u16 temp;
+	int result;
+	u8 i;
+
+	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
+					  CP210X_GET_PORTCONFIG, &config,
+					  sizeof(config));
+	if (result < 0)
+		return result;
+	priv->gc.ngpio = 16;
+	temp = le16_to_cpu(config.reset_state.gpio_mode_pb1);
+	priv->gpio_pushpull = (temp & CP2108_GPIO_MODE_MASK) >> CP2108_GPIO_MODE_OFFSET;
+	temp = le16_to_cpu(config.reset_state.gpio_latch_pb1);
+	gpio_latch = (temp & CP2108_GPIO_MODE_MASK) >> CP2108_GPIO_MODE_OFFSET;
+	/*
+	 * Mark all pins which are not in GPIO mode
+	 * Refer to table 9.1: GPIO Mode alternate Functions on CP2108 datasheet:
+	 * https://www.silabs.com/documents/public/data-sheets/cp2108-datasheet.pdf
+	 * Alternate Functions of GPIO0 to GPIO3 is determine by enhancedfxn_ifc[0]
+	 * and the same for other pins, enhancedfxn_ifc[1]: GPIO4 to GPIO7,
+	 * enhancedfxn_ifc[2]: GPIO8 to GPIO11, enhancedfxn_ifc[3]: GPIO12 to GPIO15.
+	 */
+	for (i = 0; i < 4; i++) {
+		if(config.enhancedfxn_ifc[i] & CP2108_EF_IFC_GPIO_TXLED)
+			priv->gpio_altfunc |= BIT(i * 4);
+		if(config.enhancedfxn_ifc[i] & CP2108_EF_IFC_GPIO_RXLED)
+			priv->gpio_altfunc |= BIT((i * 4) + 1);
+		if(config.enhancedfxn_ifc[i] & CP2108_EF_IFC_GPIO_RS485)
+			priv->gpio_altfunc |= BIT((i * 4) + 2);
+		if(config.enhancedfxn_ifc[i] & CP2108_EF_IFC_GPIO_CLOCK)
+			priv->gpio_altfunc |= BIT((i * 4) + 3);
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
@@ -1649,6 +1793,15 @@ static int cp210x_gpio_init(struct usb_serial *serial)
 	case CP210X_PARTNUM_CP2102N_QFN20:
 		result = cp2102n_gpioconf_init(serial);
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
 	default:
 		return 0;
 	}
-- 
2.17.1

