Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2940D349365
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCYNzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:55:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:9881 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhCYNzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:55:03 -0400
IronPort-SDR: FRxF1kP2vDmJQEhXxu4FU1pwfmmLeIJnaSoi826tUStS87/xFipzY044rw3muXmeJNRkgvs+WB
 Yc3yIyCHvUgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="188633475"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="188633475"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 06:55:03 -0700
IronPort-SDR: W2IUB7LGdO/QRiRGhY1w+xl1iIj2KbSlskWwq1ZhicVdUfAqwD3iWScNRmKTH4O9lXAmlG1xDm
 q5HENV1eUiCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="414169304"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2021 06:55:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D5E6E195; Thu, 25 Mar 2021 15:55:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 4/4] usb: gadget: pch_udc: Convert Intel Quark quirk to use driver data
Date:   Thu, 25 Mar 2021 15:55:08 +0200
Message-Id: <20210325135508.70350-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325135508.70350-1-andriy.shevchenko@linux.intel.com>
References: <20210325135508.70350-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify quirks, in particular one for Intel Quark, to use driver data
and accompanying infrastructure.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/udc/pch_udc.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index db6b63f060f3..9bb7a9d7a2fb 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -332,6 +332,7 @@ struct pch_vbus_gpio_data {
  * @dma_addr:		DMA pool for received
  * @setup_data:		Received setup data
  * @base_addr:		for mapped device memory
+ * @bar:		PCI BAR used for mapped device memory
  * @cfg_data:		current cfg, intf, and alt in use
  * @vbus_gpio:		GPIO informaton for detecting VBUS
  */
@@ -354,6 +355,7 @@ struct pch_udc_dev {
 	dma_addr_t			dma_addr;
 	struct usb_ctrlrequest		setup_data;
 	void __iomem			*base_addr;
+	unsigned short			bar;
 	struct pch_udc_cfg_data		cfg_data;
 	struct pch_vbus_gpio_data	vbus_gpio;
 };
@@ -2960,6 +2962,14 @@ static int pch_udc_minnow_platform_init(struct device *d)
 	return pch_vbus_gpio_add_table(d, &pch_udc_minnow_vbus_gpio_table);
 }
 
+static int pch_udc_quark_platform_init(struct device *d)
+{
+	struct pch_udc_dev *dev = dev_get_drvdata(d);
+
+	dev->bar = PCH_UDC_PCI_BAR_QUARK_X1000;
+	return 0;
+}
+
 static void pch_udc_shutdown(struct pci_dev *pdev)
 {
 	struct pch_udc_dev *dev = pci_get_drvdata(pdev);
@@ -3030,7 +3040,6 @@ typedef int (*platform_init_fn)(struct device *);
 static int pch_udc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	platform_init_fn platform_init = (platform_init_fn)id->driver_data;
-	int			bar;
 	int			retval;
 	struct pch_udc_dev	*dev;
 
@@ -3044,6 +3053,7 @@ static int pch_udc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (retval)
 		return retval;
 
+	dev->bar = PCH_UDC_PCI_BAR;
 	dev->pdev = pdev;
 	pci_set_drvdata(pdev, dev);
 
@@ -3054,18 +3064,12 @@ static int pch_udc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			return retval;
 	}
 
-	/* Determine BAR based on PCI ID */
-	if (id->device == PCI_DEVICE_ID_INTEL_QUARK_X1000_UDC)
-		bar = PCH_UDC_PCI_BAR_QUARK_X1000;
-	else
-		bar = PCH_UDC_PCI_BAR;
-
 	/* PCI resource allocation */
-	retval = pcim_iomap_regions(pdev, 1 << bar, pci_name(pdev));
+	retval = pcim_iomap_regions(pdev, BIT(dev->bar), pci_name(pdev));
 	if (retval)
 		return retval;
 
-	dev->base_addr = pcim_iomap_table(pdev)[bar];
+	dev->base_addr = pcim_iomap_table(pdev)[dev->bar];
 
 	/* initialize the hardware */
 	retval = pch_udc_pcd_init(dev);
@@ -3113,6 +3117,7 @@ static const struct pci_device_id pch_udc_pcidev_id[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_QUARK_X1000_UDC),
 		.class = PCI_CLASS_SERIAL_USB_DEVICE,
 		.class_mask = 0xffffffff,
+		.driver_data = (kernel_ulong_t)&pch_udc_quark_platform_init,
 	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EG20T_UDC,
-- 
2.30.2

