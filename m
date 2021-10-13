Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E46942C274
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhJMOMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:12:53 -0400
Received: from esa3.barco.c3s2.iphmx.com ([68.232.159.70]:41095 "EHLO
        esa3.barco.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhJMOMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:12:52 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Oct 2021 10:12:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=barco.com; i=@barco.com; q=dns/txt; s=ces;
  t=1634134249; x=1665670249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aDR2+fYMgloTuSp0dSem8l72LeNz+/ywx8G9kJNsZbo=;
  b=sRcoU/VCB3Rn5K861jeHwa4QjOZDaFLfKSMovZE9Oq+aOxFyLXj4phgu
   MXn4Dp9c6ogWx+01Kikes0PiV5ikgsScZ+EuHLzukUAm0Z404gs2i1262
   Lt5YhUSh9ZeXITE7mriaXyX68vIjaKLiQw6z9QSv1V3dDMUVhhc6900zp
   MumEXGkYhABmidQr282RS8RFo3VXyBPSauO4PCsdP03j5Px+ta7xwu/1v
   i+uj8cssuuVK5LIQRIzFQ13yhMJ2PFpX78vbzmjxJXEWpWtRaeKQ1RY39
   jlzcKaaEJkrFJTz1wo17B1nYh7CJ8PtCrTxGJOg1KfA/kubaMrwMQUukj
   g==;
X-IronPort-AV: E=Sophos;i="5.85,371,1624323600"; 
   d="scan'208";a="25857762"
From:   Santosh Kumar Yadav <santoshkumar.yadav@barco.com>
To:     <santoshyadav30@gmail.com>
CC:     <santoshkumar.yadav@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: [PATCH] platform/x86: Support for EC-connected GPIOs for identify LED/button on Barco P50 board
Date:   Wed, 13 Oct 2021 19:33:55 +0530
Message-ID: <20211013140356.6235-1-santoshkumar.yadav@barco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver providing access to the GPIOs for the identify button and led
present on Barco P50 board, based on the pcengines-apuv2.c driver.

There is unfortunately no suitable ACPI entry for the EC communication
interface, so instead bind to boards with "P50" as their DMI product family
and hard code the I/O port number (0x299).

The driver also hooks up the leds-gpio and gpio-keys-polled drivers to the
GPIOs, so they are finally exposed as:

LED:
/sys/class/leds/identify

Button: (/proc/bus/input/devices)
I: Bus=3D0019 Vendor=3D0001 Product=3D0001 Version=3D0100
N: Name=3D"identify"
P: Phys=3Dgpio-keys-polled/input0
S: Sysfs=3D/devices/platform/barco-p50-gpio/gpio-keys-polled/input/input10
U: Uniq=3D
H: Handlers=3Devent10
B: PROP=3D0
B: EV=3D3
B: KEY=3D1000000 0 0 0 0 0 0

Signed-off-by: Santosh Kumar Yadav <santoshkumar.yadav@barco.com>
Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
 MAINTAINERS                           |   6 +
 drivers/platform/x86/Kconfig          |  10 +
 drivers/platform/x86/Makefile         |   3 +
 drivers/platform/x86/barco-p50-gpio.c | 427 ++++++++++++++++++++++++++
 4 files changed, 446 insertions(+)
 create mode 100644 drivers/platform/x86/barco-p50-gpio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a4a0c2baaf27..604f544a9e17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3220,6 +3220,12 @@ F:       drivers/video/backlight/
 F:     include/linux/backlight.h
 F:     include/linux/pwm_backlight.h

+BARCO P50 GPIO DRIVER
+M:     Santosh Kumar Yadav <santoshkumar.yadav@barco.com>
+M:     Peter Korsgaard <peter.korsgaard@barco.com>
+S:     Maintained
+F:     drivers/platform/x86/barco-p50-gpio.c
+
 BATMAN ADVANCED
 M:     Marek Lindner <mareklindner@neomailbox.ch>
 M:     Simon Wunderlich <sw@simonwunderlich.de>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index e21ea3d23e6f..42b4895e4acc 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -713,6 +713,16 @@ config PCENGINES_APU2
          To compile this driver as a module, choose M here: the module
          will be called pcengines-apuv2.

+config BARCO_P50_GPIO
+       tristate "Barco P50 GPIO driver for identify LED/button"
+       depends on GPIOLIB
+       help
+         This driver provides access to the GPIOs for the identify button
+         and led present on Barco P50 board.
+
+         To compile this driver as a module, choose M here: the module
+         will be called barco-p50-gpio.
+
 config SAMSUNG_LAPTOP
        tristate "Samsung Laptop driver"
        depends on RFKILL || RFKILL =3D n
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 69690e26bb6d..e1acfc03301f 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -80,6 +80,9 @@ obj-$(CONFIG_XO1_RFKILL)      +=3D xo1-rfkill.o
 # PC Engines
 obj-$(CONFIG_PCENGINES_APU2)   +=3D pcengines-apuv2.o

+# Barco
+obj-$(CONFIG_BARCO_P50_GPIO)    +=3D barco-p50-gpio.o
+
 # Samsung
 obj-$(CONFIG_SAMSUNG_LAPTOP)   +=3D samsung-laptop.o
 obj-$(CONFIG_SAMSUNG_Q10)      +=3D samsung-q10.o
diff --git a/drivers/platform/x86/barco-p50-gpio.c b/drivers/platform/x86/b=
arco-p50-gpio.c
new file mode 100644
index 000000000000..1629cfbb85db
--- /dev/null
+++ b/drivers/platform/x86/barco-p50-gpio.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Support for EC-connected GPIOs for identify
+ * LED/button on Barco P50 board
+ *
+ * Copyright (C) 2021 Barco NV
+ * Author: Santosh Kumar Yadav <santoshkumar.yadav@barco.com>
+ */
+
+#define pr_fmt(fmt)    KBUILD_MODNAME ": " fmt
+
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/dmi.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/gpio_keys.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
+#include <linux/input.h>
+
+
+#define DRIVER_NAME    "barco-p50-gpio"
+
+/* GPIO lines */
+#define P50_GPIO_LINE_LED      0
+#define P50_GPIO_LINE_BTN      1
+
+/* GPIO IO Ports */
+#define P50_GPIO_IO_PORT_BASE  0x299
+
+#define P50_PORT_DATA  0x00
+#define P50_PORT_CMD   0x01
+
+#define P50_STATUS_OBF 0x01 /* EC output buffer full */
+#define P50_STATUS_IBF 0x02 /* EC input buffer full */
+
+#define P50_CMD_READ   0xa0
+#define P50_CMD_WRITE  0x50
+
+/* EC mailbox registers */
+#define P50_MBOX_REG_CMD       0x00
+#define P50_MBOX_REG_STATUS    0x01
+#define P50_MBOX_REG_PARAM     0x02
+#define P50_MBOX_REG_DATA      0x03
+
+#define P50_MBOX_CMD_READ_GPIO 0x11
+#define P50_MBOX_CMD_WRITE_GPIO        0x12
+#define P50_MBOX_CMD_CLEAR     0xff
+
+#define P50_MBOX_STATUS_SUCCESS        0x01
+
+#define P50_MBOX_PARAM_LED     0x12
+#define P50_MBOX_PARAM_BTN     0x13
+
+
+struct p50_gpio {
+       struct gpio_chip gc;
+       struct mutex lock;
+       unsigned long base;
+       struct platform_device *leds_pdev;
+       struct platform_device *keys_pdev;
+};
+
+static struct platform_device *gpio_pdev;
+
+static int gpio_params[] =3D {
+       [P50_GPIO_LINE_LED] =3D P50_MBOX_PARAM_LED,
+       [P50_GPIO_LINE_BTN] =3D P50_MBOX_PARAM_BTN,
+};
+
+static const char * const gpio_names[] =3D {
+       [P50_GPIO_LINE_LED] =3D "identify-led",
+       [P50_GPIO_LINE_BTN] =3D "identify-button",
+};
+
+
+static struct gpiod_lookup_table p50_gpio_led_table =3D {
+       .dev_id =3D "leds-gpio",
+       .table =3D {
+               GPIO_LOOKUP_IDX(DRIVER_NAME, P50_GPIO_LINE_LED, NULL, 0, GP=
IO_ACTIVE_HIGH),
+               {}
+       }
+};
+
+
+/* low level access routines */
+
+static int p50_wait_ec(struct p50_gpio *p50, int mask, int expected)
+{
+       int i, val;
+
+       for (i =3D 0; i < 100; i++) {
+               val =3D inb(p50->base + P50_PORT_CMD) & mask;
+               if (val =3D=3D expected)
+                       return 0;
+               usleep_range(500, 2000);
+       }
+
+       dev_err(p50->gc.parent, "Timed out waiting for EC (0x%x)\n", val);
+       return -ETIMEDOUT;
+}
+
+
+static int p50_read_mbox_reg(struct p50_gpio *p50, int reg)
+{
+       int ret;
+
+       ret =3D p50_wait_ec(p50, P50_STATUS_IBF, 0);
+       if (ret)
+               return ret;
+
+       /* clear output buffer flag, prevent unfinished commands */
+       inb(p50->base + P50_PORT_DATA);
+
+       /* cmd/address */
+       outb(P50_CMD_READ | reg, p50->base + P50_PORT_CMD);
+
+       ret =3D p50_wait_ec(p50, P50_STATUS_OBF, P50_STATUS_OBF);
+       if (ret)
+               return ret;
+
+       return inb(p50->base + P50_PORT_DATA);
+}
+
+static int p50_write_mbox_reg(struct p50_gpio *p50, int reg, int val)
+{
+       int ret;
+
+       ret =3D p50_wait_ec(p50, P50_STATUS_IBF, 0);
+       if (ret)
+               return ret;
+
+       /* cmd/address */
+       outb(P50_CMD_WRITE | reg, p50->base + P50_PORT_CMD);
+
+       ret =3D p50_wait_ec(p50, P50_STATUS_IBF, 0);
+       if (ret)
+               return ret;
+
+       /* data */
+       outb(val, p50->base + P50_PORT_DATA);
+
+       return 0;
+}
+
+
+/* mbox routines */
+
+static int p50_wait_mbox_idle(struct p50_gpio *p50)
+{
+       int i, val;
+
+       for (i =3D 0; i < 1000; i++) {
+               val =3D p50_read_mbox_reg(p50, P50_MBOX_REG_CMD);
+               /* cmd is 0 when idle */
+               if (val <=3D 0)
+                       return val;
+
+               usleep_range(500, 2000);
+       }
+
+       dev_err(p50->gc.parent, "Timed out waiting for EC mbox idle (CMD: 0=
x%x)\n", val);
+
+       return -ETIMEDOUT;
+}
+
+static int p50_send_mbox_cmd(struct p50_gpio *p50, int cmd, int param, int=
 data)
+{
+       int ret;
+
+       ret =3D p50_wait_mbox_idle(p50);
+       if (ret)
+               return ret;
+
+       ret =3D p50_write_mbox_reg(p50, P50_MBOX_REG_DATA, data);
+       if (ret)
+               return ret;
+
+       ret =3D p50_write_mbox_reg(p50, P50_MBOX_REG_PARAM, param);
+       if (ret)
+               return ret;
+
+       ret =3D p50_write_mbox_reg(p50, P50_MBOX_REG_CMD, cmd);
+       if (ret)
+               return ret;
+
+       ret =3D p50_wait_mbox_idle(p50);
+       if (ret)
+               return ret;
+
+       ret =3D p50_read_mbox_reg(p50, P50_MBOX_REG_STATUS);
+       if (ret < 0)
+               return ret;
+
+       if (ret =3D=3D P50_MBOX_STATUS_SUCCESS)
+               return 0;
+
+       dev_err(p50->gc.parent, "Mbox command failed (CMD=3D0x%x STAT=3D0x%=
x PARAM=3D0x%x DATA=3D0x%x)\n",
+               cmd, ret, param, data);
+
+       return -EIO;
+}
+
+
+/* gpio routines */
+
+static int p50_gpio_get_direction(struct gpio_chip *gc, unsigned int offse=
t)
+{
+       switch (offset) {
+       case P50_GPIO_LINE_BTN:
+               return GPIO_LINE_DIRECTION_IN;
+
+       case P50_GPIO_LINE_LED:
+               return GPIO_LINE_DIRECTION_OUT;
+
+       default:
+               return -EINVAL;
+       }
+}
+
+static int p50_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+       struct p50_gpio *p50 =3D gpiochip_get_data(gc);
+       int ret;
+
+       mutex_lock(&p50->lock);
+
+       ret =3D p50_send_mbox_cmd(p50, P50_MBOX_CMD_READ_GPIO, gpio_params[=
offset], 0);
+       if (ret =3D=3D 0)
+               ret =3D p50_read_mbox_reg(p50, P50_MBOX_REG_DATA);
+
+       mutex_unlock(&p50->lock);
+
+       return ret;
+}
+
+static void p50_gpio_set(struct gpio_chip *gc, unsigned int offset, int va=
lue)
+{
+       struct p50_gpio *p50 =3D gpiochip_get_data(gc);
+
+       mutex_lock(&p50->lock);
+
+       p50_send_mbox_cmd(p50, P50_MBOX_CMD_WRITE_GPIO, gpio_params[offset]=
, value);
+
+       mutex_unlock(&p50->lock);
+}
+
+static int p50_gpio_probe(struct platform_device *pdev)
+{
+       /* GPIO LEDs */
+       struct gpio_led leds[] =3D {
+               { .name =3D "identify" }
+       };
+
+       struct gpio_led_platform_data leds_pdata =3D {
+               .num_leds =3D ARRAY_SIZE(leds),
+               .leds =3D leds,
+       };
+
+       /* GPIO keyboard */
+       struct gpio_keys_button buttons[] =3D {
+               {
+                       .code =3D KEY_RESTART,
+                       .gpio =3D P50_GPIO_LINE_BTN,
+                       .active_low =3D 1,
+                       .type =3D EV_KEY,
+                       .value =3D 1,
+               },
+       };
+
+       struct gpio_keys_platform_data keys_pdata =3D {
+               .buttons =3D buttons,
+               .nbuttons =3D ARRAY_SIZE(buttons),
+               .poll_interval =3D 100,
+               .rep =3D 0,
+               .name =3D "identify",
+       };
+
+       struct p50_gpio *p50;
+       struct resource *res;
+       int ret;
+
+       p50 =3D devm_kzalloc(&pdev->dev, sizeof(*p50), GFP_KERNEL);
+       if (!p50)
+               return -ENOMEM;
+
+       res =3D platform_get_resource(pdev, IORESOURCE_IO, 0);
+       if (!res) {
+               dev_err(&pdev->dev, "Cannot get I/O ports\n");
+               return -ENODEV;
+       }
+
+       if (!devm_request_region(&pdev->dev, res->start, resource_size(res)=
, pdev->name)) {
+               dev_err(&pdev->dev, "Unable to reserve I/O region\n");
+               return -EBUSY;
+       }
+
+       p50->base =3D res->start;
+
+       ret =3D p50_send_mbox_cmd(p50, P50_MBOX_CMD_CLEAR, 0, 0);
+       if (ret < 0)
+               return -ENODEV;
+
+       p50->gc.owner =3D THIS_MODULE;
+       p50->gc.parent =3D &pdev->dev;
+       p50->gc.label =3D dev_name(&pdev->dev);
+       p50->gc.ngpio =3D ARRAY_SIZE(gpio_names);
+       p50->gc.names =3D gpio_names;
+       p50->gc.can_sleep =3D true;
+       p50->gc.base =3D -1;
+       p50->gc.get_direction =3D p50_gpio_get_direction;
+       p50->gc.get =3D p50_gpio_get;
+       p50->gc.set =3D p50_gpio_set;
+
+       mutex_init(&p50->lock);
+
+       platform_set_drvdata(pdev, p50);
+
+       ret =3D devm_gpiochip_add_data(&pdev->dev, &p50->gc, p50);
+       if (ret < 0) {
+               dev_err(&pdev->dev, "Could not register gpiochip: %d\n", re=
t);
+               return ret;
+       }
+
+       gpiod_add_lookup_table(&p50_gpio_led_table);
+
+       p50->leds_pdev =3D platform_device_register_data(&pdev->dev,
+               "leds-gpio", PLATFORM_DEVID_NONE, &leds_pdata, sizeof(leds_=
pdata));
+
+       if (IS_ERR(p50->leds_pdev)) {
+               ret =3D PTR_ERR(p50->leds_pdev);
+               dev_err(&pdev->dev, "Could not register leds-gpio: %d\n", r=
et);
+               goto err_leds;
+       }
+
+       /* gpio-keys-polled uses old-style gpio interface, pass the right i=
dentifier */
+       buttons[0].gpio +=3D p50->gc.base;
+
+       p50->keys_pdev =3D
+               platform_device_register_data(&pdev->dev, "gpio-keys-polled=
",
+                                             PLATFORM_DEVID_NONE,
+                                             &keys_pdata, sizeof(keys_pdat=
a));
+
+       if (IS_ERR(p50->keys_pdev)) {
+               ret =3D PTR_ERR(p50->keys_pdev);
+               dev_err(&pdev->dev, "Could not register gpio-keys-polled: %=
d\n", ret);
+               goto err_keys;
+       }
+
+       return 0;
+
+err_keys:
+       platform_device_unregister(p50->leds_pdev);
+err_leds:
+       gpiod_remove_lookup_table(&p50_gpio_led_table);
+
+       return ret;
+}
+
+static int p50_gpio_remove(struct platform_device *pdev)
+{
+       struct p50_gpio *p50 =3D platform_get_drvdata(pdev);
+
+       platform_device_unregister(p50->keys_pdev);
+       platform_device_unregister(p50->leds_pdev);
+
+       gpiod_remove_lookup_table(&p50_gpio_led_table);
+
+       return 0;
+}
+
+static struct platform_driver p50_gpio_driver =3D {
+       .driver =3D {
+               .name =3D DRIVER_NAME,
+       },
+       .probe =3D p50_gpio_probe,
+       .remove =3D p50_gpio_remove,
+};
+
+/* Board setup */
+static const struct dmi_system_id dmi_ids[] __initconst =3D {
+       {
+               .matches =3D {
+                       DMI_EXACT_MATCH(DMI_PRODUCT_FAMILY, "P50")
+               },
+       },
+       {}
+};
+
+static int __init p50_module_init(void)
+{
+       struct resource res =3D DEFINE_RES_IO(P50_GPIO_IO_PORT_BASE, P50_PO=
RT_CMD + 1);
+
+       if (!dmi_first_match(dmi_ids))
+               return -ENODEV;
+
+       platform_driver_register(&p50_gpio_driver);
+
+       gpio_pdev =3D platform_device_register_simple(DRIVER_NAME, PLATFORM=
_DEVID_NONE, &res, 1);
+       if (IS_ERR(gpio_pdev)) {
+               pr_err("failed registering %s: %ld\n", DRIVER_NAME, PTR_ERR=
(gpio_pdev));
+               platform_driver_unregister(&p50_gpio_driver);
+               return PTR_ERR(gpio_pdev);
+       }
+
+       return 0;
+}
+
+static void __exit p50_module_exit(void)
+{
+       platform_device_unregister(gpio_pdev);
+       platform_driver_unregister(&p50_gpio_driver);
+}
+
+module_init(p50_module_init);
+module_exit(p50_module_exit);
+
+MODULE_AUTHOR("Santosh Kumar Yadav, Barco NV <santoshkumar.yadav@barco.com=
>");
+MODULE_DESCRIPTION("Barco P50 identify GPIOs driver");
+MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: platform:leds-gpio platform:gpio-keys-polled");
--
2.19.1

This message is subject to the following terms and conditions: MAIL DISCLAI=
MER<http://www.barco.com/en/maildisclaimer>
