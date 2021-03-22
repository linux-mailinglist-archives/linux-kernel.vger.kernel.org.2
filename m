Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E4334519B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhCVVM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:12:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:48950 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhCVVLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:11:46 -0400
IronPort-SDR: NrJcduLZntKw219GOCh73EDf0qaSGrBaledt0Mu8acWZXX3dYSkXeLTKp0gj8TCF0HMr6cbofx
 AqLRMOcBwRkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="170312574"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="170312574"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 14:11:46 -0700
IronPort-SDR: HJB9wExw9ojkEScHmNqLzSOeuju5PaLnpdNxVzIXjtd+h5KHV2earUe85ldAx2p1l55VEJj+Kl
 CuCAd4H10grA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="414651247"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 22 Mar 2021 14:11:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 57322179; Mon, 22 Mar 2021 23:11:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 6/6] usb: gadget: pch_udc: Provide a GPIO line used on Intel Minnowboard (v1)
Date:   Mon, 22 Mar 2021 23:11:49 +0200
Message-Id: <20210322211149.6658-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
References: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Minnowboard (v1) uses SCH GPIO line SUS7 (i.e. 12)
for VBUS sense. Provide a DMI based quirk to have it's being used.

Fixes: e20849a8c883 ("usb: gadget: pch_udc: Convert to use GPIO descriptors")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/udc/pch_udc.c | 71 +++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 1c8c1070eb28..e5f3c6157d53 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -7,12 +7,14 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <linux/gpio/consumer.h>
 #include <linux/irq.h>
 
 #define PCH_VBUS_PERIOD		3000	/* VBUS polling period (msec) */
@@ -1360,6 +1362,43 @@ static irqreturn_t pch_vbus_gpio_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static struct gpiod_lookup_table minnowboard_udc_gpios = {
+	.dev_id		= "0000:02:02.4",
+	.table		= {
+		GPIO_LOOKUP("sch_gpio.33158", 12, NULL, GPIO_ACTIVE_HIGH),
+		{}
+	},
+};
+
+static const struct dmi_system_id pch_udc_gpio_dmi_table[] = {
+	{
+		.ident = "MinnowBoard",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "MinnowBoard"),
+		},
+		.driver_data = &minnowboard_udc_gpios,
+	},
+	{ }
+};
+
+static void pch_vbus_gpio_remove_table(void *table)
+{
+	gpiod_remove_lookup_table(table);
+}
+
+static int pch_vbus_gpio_add_table(struct pch_udc_dev *dev)
+{
+	struct device *d = &dev->pdev->dev;
+	const struct dmi_system_id *dmi;
+
+	dmi = dmi_first_match(pch_udc_gpio_dmi_table);
+	if (!dmi)
+		return 0;
+
+	gpiod_add_lookup_table(dmi->driver_data);
+	return devm_add_action_or_reset(d, pch_vbus_gpio_remove_table, dmi->driver_data);
+}
+
 /**
  * pch_vbus_gpio_init() - This API initializes GPIO port detecting VBUS.
  * @dev:		Reference to the driver structure
@@ -1378,8 +1417,12 @@ static int pch_vbus_gpio_init(struct pch_udc_dev *dev)
 	dev->vbus_gpio.port = NULL;
 	dev->vbus_gpio.intr = 0;
 
+	err = pch_vbus_gpio_add_table(dev);
+	if (err)
+		return err;
+
 	/* Retrieve the GPIO line from the USB gadget device */
-	gpiod = devm_gpiod_get(d, NULL, GPIOD_IN);
+	gpiod = devm_gpiod_get_optional(d, NULL, GPIOD_IN);
 	if (IS_ERR(gpiod))
 		return PTR_ERR(gpiod);
 	gpiod_set_consumer_name(gpiod, "pch_vbus");
@@ -2889,14 +2932,20 @@ static void pch_udc_pcd_reinit(struct pch_udc_dev *dev)
  * @dev:	Reference to the driver structure
  *
  * Return codes:
- *	0: Success
+ *	0:		Success
+ *	-%ERRNO:	All kind of errors when retrieving VBUS GPIO
  */
 static int pch_udc_pcd_init(struct pch_udc_dev *dev)
 {
+	int ret;
+
 	pch_udc_init(dev);
 	pch_udc_pcd_reinit(dev);
-	pch_vbus_gpio_init(dev);
-	return 0;
+
+	ret = pch_vbus_gpio_init(dev);
+	if (ret)
+		pch_udc_exit(dev);
+	return ret;
 }
 
 /**
@@ -3098,16 +3147,10 @@ static int pch_udc_probe(struct pci_dev *pdev,
 
 	dev->base_addr = pcim_iomap_table(pdev)[bar];
 
-	/*
-	 * FIXME: add a GPIO descriptor table to pdev.dev using
-	 * gpiod_add_descriptor_table() from <linux/gpio/machine.h> based on
-	 * the PCI subsystem ID. The system-dependent GPIO is necessary for
-	 * VBUS operation.
-	 */
-
 	/* initialize the hardware */
-	if (pch_udc_pcd_init(dev))
-		return -ENODEV;
+	retval = pch_udc_pcd_init(dev);
+	if (retval)
+		return retval;
 
 	pci_enable_msi(pdev);
 
-- 
2.30.2

