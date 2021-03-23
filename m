Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EBB345E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhCWMel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:34:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:41162 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhCWMeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:34:25 -0400
IronPort-SDR: tGTRi7U/pMropPJd7fLMCqfRCF9DKsWsyQ+tI/LrUeUo15COTSYwkrhejwrLvgcxHq7D6myMLe
 mKtFdkKSpd3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="254463534"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="254463534"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 05:34:25 -0700
IronPort-SDR: x0lyJalfC87vAyLqBf6xpyVlQC9/NX7iHXk0W/VQZHvmm9U0sMV83Yu46goN9bMH1dSh2jzioD
 TE/YpF0PERMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="604288516"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2021 05:34:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B9CDF179; Tue, 23 Mar 2021 14:34:37 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 2/2] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Date:   Tue, 23 Mar 2021 14:34:33 +0200
Message-Id: <20210323123433.45371-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323123433.45371-1-andriy.shevchenko@linux.intel.com>
References: <20210323123433.45371-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow interrupts to be MSI if supported by hardware.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/mfd/intel_quark_i2c_gpio.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 52728a963c17..16ce9cb3aa2f 100644
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
@@ -245,22 +245,30 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
+	pci_set_master(pdev);
+
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
@@ -269,6 +277,7 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
 static void intel_quark_mfd_remove(struct pci_dev *pdev)
 {
 	mfd_remove_devices(&pdev->dev);
+	pci_free_irq_vectors(pdev);
 	intel_quark_unregister_i2c_clk(&pdev->dev);
 }
 
-- 
2.30.2

