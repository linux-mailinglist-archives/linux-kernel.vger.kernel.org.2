Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110F43689E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 02:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbhDWA3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 20:29:46 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:20299 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbhDWA3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 20:29:44 -0400
X-Originating-IP: 68.203.5.165
Received: from tacos.lan (cpe-68-203-5-165.austin.res.rr.com [68.203.5.165])
        (Authenticated sender: frank@zago.net)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 1C333240002;
        Fri, 23 Apr 2021 00:29:04 +0000 (UTC)
From:   Frank Zago <frank@zago.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jan-Niklas Burfeind <kernel@aiyionpri.me>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org, gunar@schorcht.net
Cc:     frank zago <frank@zago.net>
Subject: [PATCH v2 2/2] USB: misc: Add driver for the WCH CH341 in I2C/GPIO mode
Date:   Thu, 22 Apr 2021 19:28:52 -0500
Message-Id: <20210423002852.3904-2-frank@zago.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210423002852.3904-1-frank@zago.net>
References: <20210423002852.3904-1-frank@zago.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: frank zago <frank@zago.net>

The CH341 is a multifunction chip, presenting 3 different USB PID. One
of these functions is for I2C/SPI/GPIO. This new driver manages I2C
and GPIO. A future update will manage the SPI part as well.

The I2C interface can run at 4 different speeds. This driver currently
only offer 100MHz. Tested with a variety of I2C sensors, and the IIO
subsystem.

The GPIO interface offers 8 GPIOs. 6 are read/write, and 2 are
rea-only. However the SPI interface will use 6 of them, leaving 2
available GPIOs.

Signed-off-by: frank zago <frank@zago.net>
---

Changes from v1:
  - Removed double Signed-off-by
  - Move Kconfig into the same directory as the driver

 MAINTAINERS                         |   6 +
 drivers/usb/misc/Kconfig            |   2 +
 drivers/usb/misc/Makefile           |   1 +
 drivers/usb/misc/ch341/Kconfig      |  17 ++
 drivers/usb/misc/ch341/Makefile     |   3 +
 drivers/usb/misc/ch341/ch341-core.c |  87 +++++++++
 drivers/usb/misc/ch341/ch341-gpio.c | 249 ++++++++++++++++++++++++++
 drivers/usb/misc/ch341/ch341-i2c.c  | 267 ++++++++++++++++++++++++++++
 drivers/usb/misc/ch341/ch341.h      |  50 ++++++
 9 files changed, 682 insertions(+)
 create mode 100644 drivers/usb/misc/ch341/Kconfig
 create mode 100644 drivers/usb/misc/ch341/Makefile
 create mode 100644 drivers/usb/misc/ch341/ch341-core.c
 create mode 100644 drivers/usb/misc/ch341/ch341-gpio.c
 create mode 100644 drivers/usb/misc/ch341/ch341-i2c.c
 create mode 100644 drivers/usb/misc/ch341/ch341.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9450e052f1b1..1e9e11db0ae2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19351,6 +19351,12 @@ M:	David Härdeman <david@hardeman.nu>
 S:	Maintained
 F:	drivers/media/rc/winbond-cir.c

+WINCHIPHEAD CH341 I2C/GPIO/SPI DRIVER
+M:	Frank Zago <frank@zago.net>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/misc/ch341/
+
 WINSYSTEMS EBC-C384 WATCHDOG DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-watchdog@vger.kernel.org
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 8f1144359012..e16d665f0c94 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -284,3 +284,5 @@ config BRCM_USB_PINMAP
 	  This option enables support for remapping some USB external
 	  signals, which are typically on dedicated pins on the chip,
 	  to any gpio.
+
+source "drivers/usb/misc/ch341/Kconfig"
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 5f4e598573ab..95c0ca15b8c9 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
 obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
 obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
 obj-$(CONFIG_BRCM_USB_PINMAP)		+= brcmstb-usb-pinmap.o
+obj-$(CONFIG_USB_CH341_CORE)		+= ch341/
diff --git a/drivers/usb/misc/ch341/Kconfig b/drivers/usb/misc/ch341/Kconfig
new file mode 100644
index 000000000000..951a1caa35d6
--- /dev/null
+++ b/drivers/usb/misc/ch341/Kconfig
@@ -0,0 +1,17 @@
+config USB_CH341_CORE
+	tristate "USB WinChipHead CH341 in I2C/SPI/GPIO mode"
+	depends on USB && GPIOLIB && I2C && SPI
+	help
+
+	  If you say yes to this option, support for the CH341 chips,
+	  running in I2C/SPI/GPIO mode will be included. Some versions
+	  of the chip do not support all the functionnalities but
+	  there is no way to differentiate them. For instance the
+	  CH341A and CH341B support everything while the CH341T can
+	  only do I2C.
+
+	  The serial mode is not supported by this driver. Use the
+	  CH341 USB serial driver.
+
+	  This driver can also be built as a module.  If so, the
+	  module will be called ch341-buses.
diff --git a/drivers/usb/misc/ch341/Makefile b/drivers/usb/misc/ch341/Makefile
new file mode 100644
index 000000000000..7c6429e7a46e
--- /dev/null
+++ b/drivers/usb/misc/ch341/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_USB_CH341_CORE) := ch341-buses.o
+
+ch341-buses-objs := ch341-core.o ch341-i2c.o ch341-gpio.o
diff --git a/drivers/usb/misc/ch341/ch341-core.c b/drivers/usb/misc/ch341/ch341-core.c
new file mode 100644
index 000000000000..19c531715ea3
--- /dev/null
+++ b/drivers/usb/misc/ch341/ch341-core.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the CH341A, and CH341B USB to I2C/GPIO adapter
+ * Driver for the CH341T USB to I2C adapter
+ *
+ * Copyright 2021, Frank Zago
+ * Copyright (c) 2017 Gunar Schorcht (gunar@schorcht.net)
+ * Copyright (c) 2016 Tse Lun Bien
+ * Copyright (c) 2014 Marco Gittler
+ * Copyright (c) 2006-2007 Till Harbaum (Till@Harbaum.org)
+ *
+ * The full UART functionality is handled by the CH341 serial driver
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "ch341.h"
+
+static void ch341_usb_free_device(struct ch341_device *dev)
+{
+	ch341_gpio_remove(dev);
+	ch341_i2c_remove(dev);
+
+	usb_set_intfdata(dev->iface, NULL);
+	usb_put_dev(dev->usb_dev);
+
+	kfree(dev);
+}
+
+static int ch341_usb_probe(struct usb_interface *iface,
+			   const struct usb_device_id *usb_id)
+{
+	struct ch341_device *dev;
+	int error;
+
+	dev = kzalloc(sizeof(struct ch341_device), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->usb_dev = usb_get_dev(interface_to_usbdev(iface));
+	dev->iface = iface;
+	mutex_init(&dev->usb_lock);
+	dev->ep_out = iface->cur_altsetting->endpoint[1].desc.bEndpointAddress;
+	dev->ep_in = iface->cur_altsetting->endpoint[0].desc.bEndpointAddress;
+
+	usb_set_intfdata(iface, dev);
+
+	error = ch341_i2c_init(dev);
+	if (error) {
+		ch341_usb_free_device(dev);
+		return error;
+	}
+
+	error = ch341_gpio_init(dev);
+	if (error) {
+		ch341_usb_free_device(dev);
+		return error;
+	}
+
+	return 0;
+}
+
+static void ch341_usb_disconnect(struct usb_interface *usb_if)
+{
+	struct ch341_device *dev = usb_get_intfdata(usb_if);
+
+	ch341_usb_free_device(dev);
+}
+
+static const struct usb_device_id ch341_usb_table[] = {
+	{ USB_DEVICE(0x1a86, 0x5512) },
+	{ }
+};
+
+static struct usb_driver ch341_usb_driver = {
+	.name       = "ch341-buses",
+	.id_table   = ch341_usb_table,
+	.probe      = ch341_usb_probe,
+	.disconnect = ch341_usb_disconnect
+};
+
+module_usb_driver(ch341_usb_driver);
+
+MODULE_AUTHOR("Various");
+MODULE_DESCRIPTION("ch341 USB to I2C/GPIO adapter");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/usb/misc/ch341/ch341-gpio.c b/drivers/usb/misc/ch341/ch341-gpio.c
new file mode 100644
index 000000000000..fff983be6c6c
--- /dev/null
+++ b/drivers/usb/misc/ch341/ch341-gpio.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPIO interface for the CH341A and CH341B chips.
+ *
+ * Copyright 2021, Frank Zago
+ * Copyright (c) 2017 Gunar Schorcht (gunar@schorcht.net)
+ * Copyright (c) 2016 Tse Lun Bien
+ * Copyright (c) 2014 Marco Gittler
+ * Copyright (c) 2006-2007 Till Harbaum (Till@Harbaum.org)
+ */
+
+/* Notes.
+ *
+ * For the CH341, 0=IN, 1=OUT, but for the GPIO subsystem, 1=IN and
+ * 0=OUT. Some translation happens in a couple places.
+ */
+
+#include "ch341.h"
+
+#define CH341_GPIO_NUM_PINS         8     /* Number of GPIO pins */
+
+#define CH341_CMD_UIO_STREAM        0xAB  /* UIO stream command */
+
+#define CH341_CMD_UIO_STM_IN        0x00  /* UIO interface IN command (D0~D7) */
+#define CH341_CMD_UIO_STM_OUT       0x80  /* UIO interface OUT command (D0~D5) */
+#define CH341_CMD_UIO_STM_DIR       0x40  /* UIO interface DIR command (D0~D5) */
+#define CH341_CMD_UIO_STM_END       0x20  /* UIO interface END command */
+
+/* Masks to describe the 8 GPIOs (pins 15 to 22, a.k.a. D0 to D7.)
+ * D0 to D5 can read/write, but pins D6 and D7 can only read.
+ */
+static const u8 pin_can_output = 0b00111111;
+
+/* Various names appearing on breakout boards. */
+static const char * const gpio_names[CH341_GPIO_NUM_PINS] = {
+	"D0/CS0",
+	"D1/CS1",
+	"D2/CS2",
+	"D3/SCK/DCK",
+	"D4/DOUT2",
+	"D5/MOSI/DOUT/SDO",
+	"D6/DIN2",
+	"D7/MISO/DIN"
+};
+
+static void ch341_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+
+	seq_printf(s, "pin config  : %02x  (0=IN, 1=OUT)\n", dev->gpio_dir);
+	seq_printf(s, "last read   : %02x\n", dev->gpio_last_read);
+	seq_printf(s, "last written: %02x\n", dev->gpio_last_written);
+}
+
+/* Send a command and get a reply if requested */
+static int gpio_transfer(struct ch341_device *dev, int out_len, int in_len)
+{
+	int actual;
+	int rc;
+
+	mutex_lock(&dev->usb_lock);
+
+	rc = usb_bulk_msg(dev->usb_dev,
+			  usb_sndbulkpipe(dev->usb_dev, dev->ep_out),
+			  dev->gpio_buf, out_len,
+			  &actual, DEFAULT_TIMEOUT);
+	if (rc < 0)
+		goto done;
+
+	if (in_len == 0) {
+		rc = actual;
+		goto done;
+	}
+
+	rc = usb_bulk_msg(dev->usb_dev,
+			  usb_rcvbulkpipe(dev->usb_dev, dev->ep_in),
+			  dev->gpio_buf, PKT_SIZE, &actual, DEFAULT_TIMEOUT);
+
+	if (rc == 0)
+		rc = actual;
+
+done:
+	mutex_unlock(&dev->usb_lock);
+
+	return rc;
+}
+
+static int read_inputs(struct ch341_device *dev)
+{
+	int result;
+
+	mutex_lock(&dev->gpio_lock);
+
+	dev->gpio_buf[0] = CH341_CMD_UIO_STREAM;
+	dev->gpio_buf[1] = CH341_CMD_UIO_STM_DIR | dev->gpio_dir;
+	dev->gpio_buf[2] = CH341_CMD_UIO_STM_IN;
+	dev->gpio_buf[3] = CH341_CMD_UIO_STM_END;
+
+	result = gpio_transfer(dev, 4, 1);
+
+	if (result == 1)
+		dev->gpio_last_read = dev->gpio_buf[0];
+
+	mutex_unlock(&dev->gpio_lock);
+
+	return (result != 1) ? result : 0;
+}
+
+static int ch341_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+	int rc;
+
+	rc = read_inputs(dev);
+	if (rc)
+		return rc;
+
+	return (dev->gpio_last_read & BIT(offset)) ? 1 : 0;
+}
+
+static int ch341_gpio_get_multiple(struct gpio_chip *chip,
+				   unsigned long *mask, unsigned long *bits)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+	int rc;
+
+	rc = read_inputs(dev);
+	if (rc)
+		return rc;
+
+	*bits = dev->gpio_last_read & *mask;
+
+	return 0;
+}
+
+static void write_outputs(struct ch341_device *dev)
+{
+	mutex_lock(&dev->gpio_lock);
+
+	dev->gpio_buf[0] = CH341_CMD_UIO_STREAM;
+	dev->gpio_buf[1] = CH341_CMD_UIO_STM_DIR | dev->gpio_dir;
+	dev->gpio_buf[2] = CH341_CMD_UIO_STM_OUT | (dev->gpio_last_written & dev->gpio_dir);
+	dev->gpio_buf[3] = CH341_CMD_UIO_STM_END;
+
+	gpio_transfer(dev, 4, 0);
+
+	mutex_unlock(&dev->gpio_lock);
+}
+
+static void ch341_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+
+	if (value)
+		dev->gpio_last_written |= BIT(offset);
+	else
+		dev->gpio_last_written &= ~BIT(offset);
+
+	write_outputs(dev);
+}
+
+static void ch341_gpio_set_multiple(struct gpio_chip *chip,
+				    unsigned long *mask, unsigned long *bits)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+
+	dev->gpio_last_written &= ~*mask;
+	dev->gpio_last_written |= (*bits & *mask);
+
+	write_outputs(dev);
+}
+
+static int ch341_gpio_get_direction(struct gpio_chip *chip,
+				    unsigned int offset)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+
+	return (dev->gpio_dir & BIT(offset)) ? 0 : 1;
+}
+
+static int ch341_gpio_direction_input(struct gpio_chip *chip,
+				      unsigned int offset)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+
+	dev->gpio_dir &= ~BIT(offset);
+
+	return 0;
+}
+
+static int ch341_gpio_direction_output(struct gpio_chip *chip,
+				       unsigned int offset, int value)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+	u8 mask = BIT(offset);
+
+	if (!(pin_can_output & mask))
+		return -EINVAL;
+
+	dev->gpio_dir |= mask;
+
+	ch341_gpio_set(chip, offset, value);
+
+	return 0;
+}
+
+void ch341_gpio_remove(struct ch341_device *dev)
+{
+	if (!dev->gpio_init)
+		return;
+
+	gpiochip_remove(&dev->gpio);
+}
+
+int ch341_gpio_init(struct ch341_device *dev)
+{
+	struct gpio_chip *gpio = &dev->gpio;
+	int result;
+
+	gpio->label = "ch341";
+	gpio->parent = &dev->usb_dev->dev;
+	gpio->owner = THIS_MODULE;
+	gpio->get_direction = ch341_gpio_get_direction;
+	gpio->direction_input = ch341_gpio_direction_input;
+	gpio->direction_output = ch341_gpio_direction_output;
+	gpio->get = ch341_gpio_get;
+	gpio->get_multiple = ch341_gpio_get_multiple;
+	gpio->set = ch341_gpio_set;
+	gpio->set_multiple = ch341_gpio_set_multiple;
+	gpio->dbg_show = ch341_gpio_dbg_show;
+	gpio->base = -1;
+	gpio->ngpio = CH341_GPIO_NUM_PINS;
+	gpio->names = gpio_names;
+	gpio->can_sleep = true;
+
+	dev->gpio_dir = 0;	/* All pins as input */
+
+	mutex_init(&dev->gpio_lock);
+
+	result = gpiochip_add_data(gpio, dev);
+	if (result) {
+		dev_err(&dev->usb_dev->dev, "Could not add GPIO\n");
+		return result;
+	}
+
+	dev->gpio_init = true;
+
+	return 0;
+}
diff --git a/drivers/usb/misc/ch341/ch341-i2c.c b/drivers/usb/misc/ch341/ch341-i2c.c
new file mode 100644
index 000000000000..be675dc54166
--- /dev/null
+++ b/drivers/usb/misc/ch341/ch341-i2c.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * I2C interface for the CH341A, CH341B and CH341T.
+ *
+ * Copyright 2021, Frank Zago
+ * Copyright (c) 2016 Tse Lun Bien
+ * Copyright (c) 2014 Marco Gittler
+ * Copyright (C) 2006-2007 Till Harbaum (Till@Harbaum.org)
+ */
+
+#include "ch341.h"
+
+/* Support not yet implemented */
+#define CH341_I2C_LOW_SPEED 0      /* 20kHz */
+#define CH341_I2C_STANDARD_SPEED 1 /* 100kHz */
+#define CH341_I2C_FAST_SPEED 2     /* 400kHz */
+#define CH341_I2C_HIGH_SPEED 3     /* 750kHz */
+
+#define CH341_CMD_I2C_STREAM 0xAA
+#define CH341_CMD_I2C_STM_END 0x00
+
+#define CH341_CMD_I2C_STM_STA 0x74
+#define CH341_CMD_I2C_STM_STO 0x75
+#define CH341_CMD_I2C_STM_OUT 0x80
+#define CH341_CMD_I2C_STM_IN 0xC0
+#define CH341_CMD_I2C_STM_SET 0x60
+#define CH341_CMD_I2C_STM_MS  0x50
+
+#define CH341_CTRL_VENDOR_VERSION 0x5F	 /* version of chip */
+#define CH341_CTRL_VENDOR_READ_TYPE 0XC0 /* vendor control read */
+
+/* Append a write command to the current request */
+static int append_write(struct ch341_device *dev, const struct i2c_msg *msg)
+{
+	u8 *out = dev->i2c_buf;
+	int len;
+	u8 *p;
+	bool start_done = false;
+
+	len = msg->len;
+	p = msg->buf;
+
+	while (len) {
+		int to_write;
+		int avail;
+
+		if (dev->idx_out % PKT_SIZE) {
+			/* Finish current packet, and advance to the next one */
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_END;
+			dev->out_pkt++;
+			dev->idx_out = dev->out_pkt * PKT_SIZE;
+
+			if (dev->out_pkt == PKT_COUNT)
+				return -E2BIG;
+		}
+
+		out[dev->idx_out++] = CH341_CMD_I2C_STREAM;
+
+		/* account for stream start and end, STA and possible STO */
+		avail = PKT_SIZE - 4;
+
+		if (!start_done) {
+			/* Each message has a start */
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_STA;
+
+			avail -= 2; /* room for STA and device address */
+		}
+
+		to_write = min_t(int, len, avail);
+
+		if (!start_done) {
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_OUT | (to_write + 1);
+			out[dev->idx_out++] = msg->addr << 1;
+
+			start_done = true;
+		} else {
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_OUT | to_write;
+		}
+
+		memcpy(&out[dev->idx_out], p, to_write);
+		dev->idx_out += to_write;
+		len -= to_write;
+	}
+
+	return 0;
+}
+
+/* Append a read command to the request. It usually follows a write
+ * command. When that happens, the driver will attempt to concat the
+ * read command into the same packet. This is necessary for eeprom
+ * devices, otherwise the full request would go past 128 bytes, which
+ * the adapter doesn't support.
+ */
+static int append_read(struct ch341_device *dev, const struct i2c_msg *msg)
+{
+	u8 *out = dev->i2c_buf;
+	bool start_done = false;
+	int len;
+
+	len = msg->len;
+
+	while (len) {
+		int to_read;
+
+		if (dev->idx_out % PKT_SIZE) {
+			if (!start_done &&
+			    (dev->idx_out % PKT_SIZE) <  (PKT_SIZE - 7)) {
+				/* There's enough left for a read */
+			} else {
+				/* Finish current packet, and advance to the next one */
+				out[dev->idx_out++] = CH341_CMD_I2C_STM_END;
+				dev->out_pkt++;
+				dev->idx_out = dev->out_pkt * PKT_SIZE;
+
+				if (dev->out_pkt == PKT_COUNT)
+					return -E2BIG;
+
+				out[dev->idx_out++] = CH341_CMD_I2C_STREAM;
+			}
+		} else {
+			out[dev->idx_out++] = CH341_CMD_I2C_STREAM;
+		}
+
+		if (!start_done) {
+			/* Each message has a start */
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_STA;
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_OUT | 1;
+			out[dev->idx_out++] = msg->addr << 1 | 1;
+
+			start_done = true;
+		}
+
+		/* Apparently the last command must be an STM_IN to
+		 * read the last byte. Without it, the adapter gets
+		 * lost.
+		 */
+		to_read = min_t(int, len, 32);
+		len -= to_read;
+		if (len == 0) {
+			if (to_read > 1)
+				out[dev->idx_out++] = CH341_CMD_I2C_STM_IN | (to_read - 1);
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_IN;
+		} else {
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_IN | to_read;
+		}
+	}
+
+	return 0;
+}
+
+static int ch341_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
+{
+	struct ch341_device *dev = adapter->algo_data;
+	int retval;
+	int i;
+	u8 *out = dev->i2c_buf;
+	int actual;
+
+	/* Prepare the request */
+	dev->idx_out = 0;
+	dev->out_pkt = 0;
+
+	for (i = 0; i != num; i++) {
+		if (msgs[i].flags & I2C_M_RD)
+			retval = append_read(dev, &msgs[i]);
+		else
+			retval = append_write(dev, &msgs[i]);
+
+		if (retval)
+			return retval;
+	}
+
+	out[dev->idx_out++] = CH341_CMD_I2C_STM_STO;
+	out[dev->idx_out++] = CH341_CMD_I2C_STM_END;
+
+	dev_dbg(&dev->adapter.dev, "bulk_out request with %d bytes\n",
+		dev->idx_out);
+
+	mutex_lock(&dev->usb_lock);
+
+	/* Issue the request */
+	retval = usb_bulk_msg(dev->usb_dev,
+			      usb_sndbulkpipe(dev->usb_dev, dev->ep_out),
+			      dev->i2c_buf, dev->idx_out, &actual, DEFAULT_TIMEOUT);
+	if (retval < 0) {
+		mutex_unlock(&dev->usb_lock);
+		return retval;
+	}
+
+	for (i = 0; i != num; i++) {
+		if (!(msgs[i].flags & I2C_M_RD))
+			continue;
+
+		retval = usb_bulk_msg(dev->usb_dev,
+				      usb_rcvbulkpipe(dev->usb_dev, dev->ep_in),
+				      dev->i2c_buf, msgs[i].len, &actual, DEFAULT_TIMEOUT);
+
+		if (retval) {
+			mutex_lock(&dev->usb_lock);
+			return retval;
+		}
+
+		if (actual != msgs[i].len) {
+			mutex_lock(&dev->usb_lock);
+			return -EIO;
+		}
+
+		memcpy(msgs[i].buf, dev->i2c_buf, actual);
+	}
+
+	mutex_unlock(&dev->usb_lock);
+
+	return num;
+}
+
+static u32 ch341_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm ch341_i2c_algorithm = {
+	.master_xfer = ch341_i2c_xfer,
+	.functionality = ch341_i2c_func,
+};
+
+void ch341_i2c_remove(struct ch341_device *dev)
+{
+	if (!dev->i2c_init)
+		return;
+
+	i2c_del_adapter(&dev->adapter);
+}
+
+int ch341_i2c_init(struct ch341_device *dev)
+{
+	int retval;
+	int actual;
+
+	dev->adapter.owner = THIS_MODULE;
+	dev->adapter.class = I2C_CLASS_HWMON;
+	dev->adapter.algo = &ch341_i2c_algorithm;
+	dev->adapter.algo_data = dev;
+	snprintf(dev->adapter.name, sizeof(dev->adapter.name),
+		 "CH341 I2C USB bus %03d device %03d",
+		 dev->usb_dev->bus->busnum, dev->usb_dev->devnum);
+
+	dev->adapter.dev.parent = &dev->iface->dev;
+
+	/* Set ch341 i2c speed */
+	dev->i2c_buf[0] = CH341_CMD_I2C_STREAM;
+	dev->i2c_buf[1] = CH341_CMD_I2C_STM_SET | CH341_I2C_STANDARD_SPEED;
+	dev->i2c_buf[2] = CH341_CMD_I2C_STM_END;
+	mutex_lock(&dev->usb_lock);
+	retval = usb_bulk_msg(dev->usb_dev,
+			      usb_sndbulkpipe(dev->usb_dev, dev->ep_out),
+			      dev->i2c_buf, 3, &actual, DEFAULT_TIMEOUT);
+	mutex_unlock(&dev->usb_lock);
+	if (retval < 0) {
+		dev_err(&dev->adapter.dev, "Cannot set I2C speed\n");
+		return -EIO;
+	}
+
+	i2c_add_adapter(&dev->adapter);
+	dev->i2c_init = true;
+
+	return 0;
+}
diff --git a/drivers/usb/misc/ch341/ch341.h b/drivers/usb/misc/ch341/ch341.h
new file mode 100644
index 000000000000..4ddd77c2e08c
--- /dev/null
+++ b/drivers/usb/misc/ch341/ch341.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Definitions for CH341 driver
+ */
+
+#include <linux/usb.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+
+#define DEFAULT_TIMEOUT 1000	/* 1s USB requests timeout */
+
+/* I2C - The maximum request size is 128 bytes, for reading and
+ * writing. The adapter will get the buffer in packets of up to 32
+ * bytes. The I2C stream must start and stop in each 32-byte packet.
+ * Reading must also be split, up to 32-byte per packet.
+ */
+#define PKT_SIZE 32
+#define PKT_COUNT 4
+
+struct ch341_device {
+	struct usb_device *usb_dev;
+	struct usb_interface *iface;
+	struct mutex usb_lock;
+
+	int ep_in;
+	int ep_out;
+
+	/* I2C */
+	struct i2c_adapter adapter;
+	bool i2c_init;
+
+	/* I2C request and response state */
+	int idx_out;		/* current offset in buf */
+	int out_pkt;		/* current packet */
+	u8 i2c_buf[PKT_COUNT * PKT_SIZE];
+
+	/* GPIO */
+	struct gpio_chip gpio;
+	struct mutex gpio_lock;
+	bool gpio_init;
+	u8 gpio_dir;		/* 1 bit per pin, 0=IN, 1=OUT. */
+	u8 gpio_last_read;	/* last GPIO values read */
+	u8 gpio_last_written;	/* last GPIO values written */
+	u8 gpio_buf[PKT_SIZE];
+};
+
+void ch341_i2c_remove(struct ch341_device *dev);
+int ch341_i2c_init(struct ch341_device *dev);
+void ch341_gpio_remove(struct ch341_device *dev);
+int ch341_gpio_init(struct ch341_device *dev);
--
2.27.0
