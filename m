Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409BC345199
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhCVVMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:12:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:18052 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhCVVLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:11:44 -0400
IronPort-SDR: 2wDh9Rc94p8VUZ9J2O3V83ihF7HBQj4lJoIRFEN3JO6xUAVOFBdOCo0QwhSsmORtHLeoF0FSEY
 uAWcOM/MXZOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="275450703"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="275450703"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 14:11:43 -0700
IronPort-SDR: iJMv8inoGyqydLUXoyzd2GJrF6DyX6qR34EOH16BdVTH43BngjEIGQMZTl7Eb7wFqg2CroWqeB
 Fsn4sErDq4zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="413163039"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 22 Mar 2021 14:11:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4F6DA49E; Mon, 22 Mar 2021 23:11:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 5/6] usb: gadget: pch_udc: Initialize device pointer before use
Date:   Mon, 22 Mar 2021 23:11:48 +0200
Message-Id: <20210322211149.6658-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
References: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During conversion to use GPIO descriptors the device pointer,
which is applied to devm_gpiod_get(), is not yet initialized.

Move initialization in the ->probe() in order to have it set before use.

Fixes: e20849a8c883 ("usb: gadget: pch_udc: Convert to use GPIO descriptors")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/udc/pch_udc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 984c9299d2c6..1c8c1070eb28 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -1370,6 +1370,7 @@ static irqreturn_t pch_vbus_gpio_irq(int irq, void *data)
  */
 static int pch_vbus_gpio_init(struct pch_udc_dev *dev)
 {
+	struct device *d = &dev->pdev->dev;
 	int err;
 	int irq_num = 0;
 	struct gpio_desc *gpiod;
@@ -1378,7 +1379,7 @@ static int pch_vbus_gpio_init(struct pch_udc_dev *dev)
 	dev->vbus_gpio.intr = 0;
 
 	/* Retrieve the GPIO line from the USB gadget device */
-	gpiod = devm_gpiod_get(dev->gadget.dev.parent, NULL, GPIOD_IN);
+	gpiod = devm_gpiod_get(d, NULL, GPIOD_IN);
 	if (IS_ERR(gpiod))
 		return PTR_ERR(gpiod);
 	gpiod_set_consumer_name(gpiod, "pch_vbus");
@@ -3081,6 +3082,7 @@ static int pch_udc_probe(struct pci_dev *pdev,
 	if (retval)
 		return retval;
 
+	dev->pdev = pdev;
 	pci_set_drvdata(pdev, dev);
 
 	/* Determine BAR based on PCI ID */
@@ -3122,7 +3124,6 @@ static int pch_udc_probe(struct pci_dev *pdev,
 
 	/* device struct setup */
 	spin_lock_init(&dev->lock);
-	dev->pdev = pdev;
 	dev->gadget.ops = &pch_udc_ops;
 
 	retval = init_dma_pools(dev);
-- 
2.30.2

