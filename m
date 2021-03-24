Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B83480C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbhCXSjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:39:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:17739 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237643AbhCXSi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:38:29 -0400
IronPort-SDR: XlAG5BrE69rbM1RaGqBGN1cKxPTaWf/bgf5xBIwgqwIqRNX5/r5uX1AFvih92MMXcH4owk1KJP
 LrUDJ88vFoqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190859508"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190859508"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:29 -0700
IronPort-SDR: um/LvL+gG9RzKP8mq3wM0U6H60hcBUDZQTXQAZpaESfMqf5RXGCTuXM16hjffM6OxaLYaWv6US
 fZVoY2wh9RNg==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608203796"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:26 -0700
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>
Subject: [PATCH v2 05/13] intel_gna: initialize mmu
Date:   Wed, 24 Mar 2021 19:36:02 +0100
Message-Id: <20210324183610.4574-6-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

Setup mmu in the driver with a new memory component.

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-Developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/intel/gna/gna_device.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/intel/gna/gna_device.c b/drivers/misc/intel/gna/gna_device.c
index 25137d0ac519..3d559f22ee93 100644
--- a/drivers/misc/intel/gna/gna_device.c
+++ b/drivers/misc/intel/gna/gna_device.c
@@ -9,10 +9,11 @@
 
 #define GNA_BAR0		0
 
-static void gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
+static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 			const struct pci_device_id *pci_id)
 {
 	u32 bld_reg;
+	int ret;
 
 	pci_set_drvdata(pcidev, gna_priv);
 
@@ -24,10 +25,29 @@ static void gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 	bld_reg = gna_reg_read(gna_priv->bar0_base, GNA_MMIO_IBUFFS);
 	gna_priv->hw_info.in_buf_s = bld_reg & GENMASK(7, 0);
 
+	if (gna_mmu_alloc(gna_priv)) {
+		dev_err(&pcidev->dev, "mmu allocation failed\n");
+		ret = -EFAULT;
+		goto err_pci_drvdata_unset;
+
+	}
+	dev_dbg(&pcidev->dev, "maximum memory size %llu num pd %d\n",
+		gna_priv->info.max_hw_mem, gna_priv->info.num_pagetables);
+	dev_dbg(&pcidev->dev, "desc rsvd size %d mmu vamax size %d\n",
+		gna_priv->info.desc_info.rsvd_size,
+		gna_priv->info.desc_info.mmu_info.vamax_size);
+
 	mutex_init(&gna_priv->mmu_lock);
 
 	idr_init(&gna_priv->memory_idr);
 	mutex_init(&gna_priv->memidr_lock);
+
+	return 0;
+
+err_pci_drvdata_unset:
+	pci_set_drvdata(pcidev, NULL);
+
+	return ret;
 }
 
 static void gna_dev_deinit(struct gna_private *gna_priv)
@@ -84,7 +104,12 @@ int gna_probe(struct pci_dev *pcidev, const struct pci_device_id *pci_id)
 
 	pci_set_master(pcidev);
 
-	gna_dev_init(gna_priv, pcidev, pci_id);
+	ret = gna_dev_init(gna_priv, pcidev, pci_id);
+	if (ret) {
+		dev_err(&pcidev->dev, "could not initialize %s device\n", GNA_DV_NAME);
+		return ret;
+	}
+
 
 	return 0;
 }
-- 
2.28.0

