Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A2D3480B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbhCXSi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:38:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:17716 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237621AbhCXSiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:38:23 -0400
IronPort-SDR: L5Hej4U88qeN2o+k3/PwoFkt6hRvB1W/ErgknWO28eV+eU5DCPz1c4m4GvovPGHWyX4WA0+3na
 8tGn++UYFHFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190859498"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190859498"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:23 -0700
IronPort-SDR: O9ibH8UfLSiHH4aEcHqHG84z89xw9HcF23fAouehVmhqNVfv/NwpE5EyXHJYptfVU5cz5o7aJs
 xtkqqFa0N8CA==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608203762"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:20 -0700
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
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH v2 03/13] intel_gna: read hardware info in the driver
Date:   Wed, 24 Mar 2021 19:36:00 +0100
Message-Id: <20210324183610.4574-4-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

Get the hardware information from register MMIO_IBUFFS

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/intel/gna/gna_device.c | 5 +++++
 drivers/misc/intel/gna/gna_device.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/misc/intel/gna/gna_device.c b/drivers/misc/intel/gna/gna_device.c
index 431113297879..6bac481b2247 100644
--- a/drivers/misc/intel/gna/gna_device.c
+++ b/drivers/misc/intel/gna/gna_device.c
@@ -12,12 +12,17 @@
 static void gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 			const struct pci_device_id *pci_id)
 {
+	u32 bld_reg;
+
 	pci_set_drvdata(pcidev, gna_priv);
 
 	gna_priv->parent = &pcidev->dev;
 	gna_priv->pdev = pcidev;
 	gna_priv->info = *(struct gna_drv_info *)pci_id->driver_data;
 	gna_priv->drv_priv = &gna_drv_priv;
+
+	bld_reg = gna_reg_read(gna_priv->bar0_base, GNA_MMIO_IBUFFS);
+	gna_priv->hw_info.in_buf_s = bld_reg & GENMASK(7, 0);
 }
 
 int gna_probe(struct pci_dev *pcidev, const struct pci_device_id *pci_id)
diff --git a/drivers/misc/intel/gna/gna_device.h b/drivers/misc/intel/gna/gna_device.h
index 39dc03d53feb..7704eeda90f6 100644
--- a/drivers/misc/intel/gna/gna_device.h
+++ b/drivers/misc/intel/gna/gna_device.h
@@ -23,6 +23,10 @@ struct gna_drv_info {
 	struct gna_desc_info desc_info;
 };
 
+struct gna_hw_info {
+	u8 in_buf_s;
+};
+
 struct gna_private {
 	struct gna_driver_private *drv_priv;
 
@@ -33,6 +37,7 @@ struct gna_private {
 	/* device related resources */
 	void __iomem *bar0_base;
 	struct gna_drv_info info;
+	struct gna_hw_info hw_info;
 };
 
 int gna_probe(struct pci_dev *dev, const struct pci_device_id *id);
-- 
2.28.0

