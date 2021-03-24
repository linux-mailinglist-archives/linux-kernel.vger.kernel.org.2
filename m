Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C650E347EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbhCXRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:11:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:51374 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237215AbhCXRKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:10:48 -0400
IronPort-SDR: JzVHCg0x4PBJtdDVzHW1KmQCHEVwFqkNFQDhkJPp83oK9V86caz2cxY3lTg5/AsjK31ZTYb9g+
 rl2kReCgGuuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="170096861"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="170096861"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 10:08:24 -0700
IronPort-SDR: UqggpaTwGqbdhQydAAMA1kW5JiJSPTreoQvdeZQDvhB3WVYrOUFEGhBm87IDhfYsq7aEa1/y1C
 RpM0b61tA5VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="525311546"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2021 10:08:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D13F0195; Wed, 24 Mar 2021 19:08:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Date:   Wed, 24 Mar 2021 19:08:34 +0200
Message-Id: <20210324170834.20605-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow interrupts to be MSI if supported by hardware.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: rebased on clean for-mfd-next branch (Lee)
 drivers/mfd/intel_quark_i2c_gpio.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index c94060003323..b219045f37a9 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -169,8 +169,8 @@ static int intel_quark_i2c_setup(struct pci_dev *pdev, struct mfd_cell *cell)
 	res[INTEL_QUARK_IORES_MEM].end =
 		pci_resource_end(pdev, MFD_I2C_BAR);
 
-	res[INTEL_QUARK_IORES_IRQ].start = pdev->irq;
-	res[INTEL_QUARK_IORES_IRQ].end = pdev->irq;
+	res[INTEL_QUARK_IORES_IRQ].start = pci_irq_vector(pdev, 0);
+	res[INTEL_QUARK_IORES_IRQ].end = pci_irq_vector(pdev, 0);
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -217,7 +217,7 @@ static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
 	pdata->properties->idx		= 0;
 	pdata->properties->ngpio	= INTEL_QUARK_MFD_NGPIO;
 	pdata->properties->gpio_base	= INTEL_QUARK_MFD_GPIO_BASE;
-	pdata->properties->irq[0]	= pdev->irq;
+	pdata->properties->irq[0]	= pci_irq_vector(pdev, 0);
 	pdata->properties->irq_shared	= true;
 
 	cell->platform_data = pdata;
@@ -246,22 +246,31 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
+	pci_set_master(pdev);
+
+	/* This driver only requires 1 IRQ vector */
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		goto err_unregister_i2c_clk;
+
 	ret = intel_quark_i2c_setup(pdev, &intel_quark_mfd_cells[MFD_I2C_BAR]);
 	if (ret)
-		goto err_unregister_i2c_clk;
+		goto err_free_irq_vectors;
 
 	ret = intel_quark_gpio_setup(pdev, &intel_quark_mfd_cells[MFD_GPIO_BAR]);
 	if (ret)
-		goto err_unregister_i2c_clk;
+		goto err_free_irq_vectors;
 
 	ret = mfd_add_devices(&pdev->dev, 0, intel_quark_mfd_cells,
 			      ARRAY_SIZE(intel_quark_mfd_cells), NULL, 0,
 			      NULL);
 	if (ret)
-		goto err_unregister_i2c_clk;
+		goto err_free_irq_vectors;
 
 	return 0;
 
+err_free_irq_vectors:
+	pci_free_irq_vectors(pdev);
 err_unregister_i2c_clk:
 	intel_quark_unregister_i2c_clk(&pdev->dev);
 	return ret;
@@ -270,6 +279,7 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
 static void intel_quark_mfd_remove(struct pci_dev *pdev)
 {
 	mfd_remove_devices(&pdev->dev);
+	pci_free_irq_vectors(pdev);
 	intel_quark_unregister_i2c_clk(&pdev->dev);
 }
 
-- 
2.30.2

