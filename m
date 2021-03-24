Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA231347C36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbhCXPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:19:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:40171 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236558AbhCXPTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:19:22 -0400
IronPort-SDR: Zn2GkqVZDV+F27jZEWhPIo4v809vj+WwdIe1hiu8zJJkYuSlmP+btzDNhGaj7rzIy1HwxNyrnF
 YuM5wdTearMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="170704278"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="170704278"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 08:19:18 -0700
IronPort-SDR: 7OdYXiQ2/SO/jBlIPUYfsq3QhvVySrWY7+SL5h6fg1FFxGXiQEKM1fD9XX7ik7aZ+mxpx9ISAC
 P753hWlfB6YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="514231841"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2021 08:19:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1441F16A; Wed, 24 Mar 2021 17:19:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 1/1] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Date:   Wed, 24 Mar 2021 17:19:29 +0200
Message-Id: <20210324151929.36844-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow interrupts to be MSI if supported by hardware.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: added a comment about magic 1s (Lee)

 drivers/mfd/intel_quark_i2c_gpio.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 52728a963c17..7f90e6f022ba 100644
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
 
 	cell->platform_data = pdata;
 	cell->pdata_size = sizeof(*pdata);
@@ -245,22 +245,31 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
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
@@ -269,6 +278,7 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
 static void intel_quark_mfd_remove(struct pci_dev *pdev)
 {
 	mfd_remove_devices(&pdev->dev);
+	pci_free_irq_vectors(pdev);
 	intel_quark_unregister_i2c_clk(&pdev->dev);
 }
 
-- 
2.30.2

