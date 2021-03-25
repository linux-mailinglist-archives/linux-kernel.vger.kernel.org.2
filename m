Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9977D349366
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhCYNzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:55:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:60128 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230459AbhCYNzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:55:04 -0400
IronPort-SDR: L9/zr1LuupBw+IaHv8PxVv2VMx1Psi+IO87XF27IAqNAZ0UT3fYFwqOC+KwYNvubTTmZ86ASk3
 WHA3ZybNVI0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="178483989"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="178483989"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 06:55:03 -0700
IronPort-SDR: frxC22Hq6Qfy/WZv8tWawXed1KPcDIMse80XzModv96u90kJigFMKA16z3BiBJF8PEduijy5Od
 k21jqkRcCNMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="593786943"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 25 Mar 2021 06:55:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E5A3DE7; Thu, 25 Mar 2021 15:55:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 3/4] usb: gadget: pch_udc: Use PCI sub IDs instead of DMI
Date:   Thu, 25 Mar 2021 15:55:07 +0200
Message-Id: <20210325135508.70350-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325135508.70350-1-andriy.shevchenko@linux.intel.com>
References: <20210325135508.70350-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need DMI to identify Intel Minnowboard (v1) since it has
properly set PCI sub IDs. So, drop unneeded DMI level of identification.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/udc/pch_udc.c | 91 +++++++++++++++-----------------
 1 file changed, 44 insertions(+), 47 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index d5685d427158..db6b63f060f3 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -7,7 +7,6 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
-#include <linux/dmi.h>
 #include <linux/errno.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
@@ -1356,43 +1355,6 @@ static irqreturn_t pch_vbus_gpio_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static struct gpiod_lookup_table minnowboard_udc_gpios = {
-	.dev_id		= "0000:02:02.4",
-	.table		= {
-		GPIO_LOOKUP("sch_gpio.33158", 12, NULL, GPIO_ACTIVE_HIGH),
-		{}
-	},
-};
-
-static const struct dmi_system_id pch_udc_gpio_dmi_table[] = {
-	{
-		.ident = "MinnowBoard",
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "MinnowBoard"),
-		},
-		.driver_data = &minnowboard_udc_gpios,
-	},
-	{ }
-};
-
-static void pch_vbus_gpio_remove_table(void *table)
-{
-	gpiod_remove_lookup_table(table);
-}
-
-static int pch_vbus_gpio_add_table(struct pch_udc_dev *dev)
-{
-	struct device *d = &dev->pdev->dev;
-	const struct dmi_system_id *dmi;
-
-	dmi = dmi_first_match(pch_udc_gpio_dmi_table);
-	if (!dmi)
-		return 0;
-
-	gpiod_add_lookup_table(dmi->driver_data);
-	return devm_add_action_or_reset(d, pch_vbus_gpio_remove_table, dmi->driver_data);
-}
-
 /**
  * pch_vbus_gpio_init() - This API initializes GPIO port detecting VBUS.
  * @dev:		Reference to the driver structure
@@ -1411,10 +1373,6 @@ static int pch_vbus_gpio_init(struct pch_udc_dev *dev)
 	dev->vbus_gpio.port = NULL;
 	dev->vbus_gpio.intr = 0;
 
-	err = pch_vbus_gpio_add_table(dev);
-	if (err)
-		return err;
-
 	/* Retrieve the GPIO line from the USB gadget device */
 	gpiod = devm_gpiod_get_optional(d, NULL, GPIOD_IN);
 	if (IS_ERR(gpiod))
@@ -2867,7 +2825,7 @@ static void pch_udc_pcd_reinit(struct pch_udc_dev *dev)
  *
  * Return codes:
  *	0:		Success
- *	-%ERRNO:	All kind of errors when retrieving VBUS GPIO
+ *	-ERRNO:		All kind of errors when retrieving VBUS GPIO
  */
 static int pch_udc_pcd_init(struct pch_udc_dev *dev)
 {
@@ -2978,6 +2936,30 @@ static int pch_udc_stop(struct usb_gadget *g)
 	return 0;
 }
 
+static void pch_vbus_gpio_remove_table(void *table)
+{
+	gpiod_remove_lookup_table(table);
+}
+
+static int pch_vbus_gpio_add_table(struct device *d, void *table)
+{
+	gpiod_add_lookup_table(table);
+	return devm_add_action_or_reset(d, pch_vbus_gpio_remove_table, table);
+}
+
+static struct gpiod_lookup_table pch_udc_minnow_vbus_gpio_table = {
+	.dev_id		= "0000:02:02.4",
+	.table		= {
+		GPIO_LOOKUP("sch_gpio.33158", 12, NULL, GPIO_ACTIVE_HIGH),
+		{}
+	},
+};
+
+static int pch_udc_minnow_platform_init(struct device *d)
+{
+	return pch_vbus_gpio_add_table(d, &pch_udc_minnow_vbus_gpio_table);
+}
+
 static void pch_udc_shutdown(struct pci_dev *pdev)
 {
 	struct pch_udc_dev *dev = pci_get_drvdata(pdev);
@@ -3043,9 +3025,11 @@ static int __maybe_unused pch_udc_resume(struct device *d)
 
 static SIMPLE_DEV_PM_OPS(pch_udc_pm, pch_udc_suspend, pch_udc_resume);
 
-static int pch_udc_probe(struct pci_dev *pdev,
-			  const struct pci_device_id *id)
+typedef int (*platform_init_fn)(struct device *);
+
+static int pch_udc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	platform_init_fn platform_init = (platform_init_fn)id->driver_data;
 	int			bar;
 	int			retval;
 	struct pch_udc_dev	*dev;
@@ -3063,6 +3047,13 @@ static int pch_udc_probe(struct pci_dev *pdev,
 	dev->pdev = pdev;
 	pci_set_drvdata(pdev, dev);
 
+	/* Platform specific hook */
+	if (platform_init) {
+		retval = platform_init(&pdev->dev);
+		if (retval)
+			return retval;
+	}
+
 	/* Determine BAR based on PCI ID */
 	if (id->device == PCI_DEVICE_ID_INTEL_QUARK_X1000_UDC)
 		bar = PCH_UDC_PCI_BAR_QUARK_X1000;
@@ -3119,10 +3110,16 @@ static int pch_udc_probe(struct pci_dev *pdev,
 
 static const struct pci_device_id pch_udc_pcidev_id[] = {
 	{
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL,
-			   PCI_DEVICE_ID_INTEL_QUARK_X1000_UDC),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_QUARK_X1000_UDC),
+		.class = PCI_CLASS_SERIAL_USB_DEVICE,
+		.class_mask = 0xffffffff,
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EG20T_UDC,
+			       PCI_VENDOR_ID_CIRCUITCO, PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD),
 		.class = PCI_CLASS_SERIAL_USB_DEVICE,
 		.class_mask = 0xffffffff,
+		.driver_data = (kernel_ulong_t)&pch_udc_minnow_platform_init,
 	},
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EG20T_UDC),
-- 
2.30.2

