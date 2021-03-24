Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D789F3480A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbhCXSik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:38:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:17716 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237345AbhCXSiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:38:20 -0400
IronPort-SDR: Rt3sDtS/xnGEIVuQSicl0FLQDGVQZOgbm22/geWAJBxyy1vo4Jyatx/uzrVl7yatNA6jAi6cHh
 TDt8WEC1q/9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190859485"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190859485"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:20 -0700
IronPort-SDR: 81diljX1HUvwqyM9rtcMEq5phDKGfuuxRsO9qKVI4/fL8E1YJ7VdTFxX1csr5YvEaxMxapqunv
 TwCitVVYwb/A==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608203746"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:17 -0700
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
Subject: [PATCH v2 02/13] intel_gna: add component of hardware operation
Date:   Wed, 24 Mar 2021 19:35:59 +0100
Message-Id: <20210324183610.4574-3-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

Add definitions and utilities to interact with the hardware
device.

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/intel/gna/Kbuild       |   2 +-
 drivers/misc/intel/gna/gna_device.h |   4 +
 drivers/misc/intel/gna/gna_hw.c     | 125 ++++++++++++++++++++++++++++
 drivers/misc/intel/gna/gna_hw.h     |  62 ++++++++++++++
 4 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/intel/gna/gna_hw.c
 create mode 100644 drivers/misc/intel/gna/gna_hw.h

diff --git a/drivers/misc/intel/gna/Kbuild b/drivers/misc/intel/gna/Kbuild
index 5d3becc71683..0cf083bb211a 100644
--- a/drivers/misc/intel/gna/Kbuild
+++ b/drivers/misc/intel/gna/Kbuild
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-intel_gna-y := gna_device.o gna_driver.o
+intel_gna-y := gna_device.o gna_driver.o gna_hw.o
 
 obj-$(CONFIG_INTEL_GNA) += intel_gna.o
diff --git a/drivers/misc/intel/gna/gna_device.h b/drivers/misc/intel/gna/gna_device.h
index d0b47f75f47f..39dc03d53feb 100644
--- a/drivers/misc/intel/gna/gna_device.h
+++ b/drivers/misc/intel/gna/gna_device.h
@@ -6,6 +6,8 @@
 
 #include <linux/types.h>
 
+#include "gna_hw.h"
+
 struct gna_driver_private;
 struct pci_device_id;
 struct pci_dev;
@@ -17,6 +19,8 @@ struct gna_drv_info {
 	u32 num_page_entries;
 	u32 max_layer_count;
 	u64 max_hw_mem;
+
+	struct gna_desc_info desc_info;
 };
 
 struct gna_private {
diff --git a/drivers/misc/intel/gna/gna_hw.c b/drivers/misc/intel/gna/gna_hw.c
new file mode 100644
index 000000000000..7d2f4ef00136
--- /dev/null
+++ b/drivers/misc/intel/gna/gna_hw.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/pci.h>
+
+#include <uapi/misc/intel/gna.h>
+
+#include "gna_device.h"
+#include "gna_driver.h"
+#include "gna_hw.h"
+
+int gna_parse_hw_status(struct gna_private *gna_priv, u32 hw_status)
+{
+	int status;
+
+	if (hw_status & GNA_ERROR) {
+		dev_dbg(&gna_priv->pdev->dev, "GNA completed with errors: %#x\n", hw_status);
+		status = -EIO;
+	} else if (hw_status & GNA_STS_SCORE_COMPLETED) {
+		status = 0;
+		dev_dbg(&gna_priv->pdev->dev, "GNA completed successfully: %#x\n", hw_status);
+	} else {
+		dev_err(&gna_priv->pdev->dev, "GNA not completed, status: %#x\n", hw_status);
+		status = -ENODATA;
+	}
+
+	return status;
+}
+
+void gna_print_error_status(struct gna_private *gna_priv, u32 hw_status)
+{
+	if (hw_status & GNA_STS_PARAM_OOR)
+		dev_dbg(&gna_priv->pdev->dev, "GNA error: Param Out Range Error\n");
+
+	if (hw_status & GNA_STS_VA_OOR)
+		dev_dbg(&gna_priv->pdev->dev, "GNA error: VA Out of Range Error\n");
+
+	if (hw_status & GNA_STS_PCI_MMU_ERR)
+		dev_dbg(&gna_priv->pdev->dev, "GNA error: PCI MMU Error\n");
+
+	if (hw_status & GNA_STS_PCI_DMA_ERR)
+		dev_dbg(&gna_priv->pdev->dev, "GNA error: PCI MMU Error\n");
+
+	if (hw_status & GNA_STS_PCI_UNEXCOMPL_ERR)
+		dev_dbg(&gna_priv->pdev->dev, "GNA error: PCI Unexpected Completion Error\n");
+
+	if (hw_status & GNA_STS_SATURATE)
+		dev_dbg(&gna_priv->pdev->dev, "GNA error: Saturation Reached !\n");
+}
+
+bool gna_hw_perf_enabled(struct gna_private *gna_priv)
+{
+	void __iomem *addr = gna_priv->bar0_base;
+	u32 ctrl = gna_reg_read(addr, GNA_MMIO_CTRL);
+
+	return FIELD_GET(GNA_CTRL_COMP_STATS_EN, ctrl) ? true : false;
+}
+
+void gna_start_scoring(struct gna_private *gna_priv, void __iomem *addr,
+		       struct gna_compute_cfg *compute_cfg)
+{
+	u32 ctrl = gna_reg_read(addr, GNA_MMIO_CTRL);
+
+	ctrl |= GNA_CTRL_START_ACCEL | GNA_CTRL_COMP_INT_EN | GNA_CTRL_ERR_INT_EN;
+
+	ctrl &= ~GNA_CTRL_COMP_STATS_EN;
+	ctrl |= FIELD_PREP(GNA_CTRL_COMP_STATS_EN,
+			compute_cfg->hw_perf_encoding & FIELD_MAX(GNA_CTRL_COMP_STATS_EN));
+
+	ctrl &= ~GNA_CTRL_ACTIVE_LIST_EN;
+	ctrl |= FIELD_PREP(GNA_CTRL_ACTIVE_LIST_EN,
+			compute_cfg->active_list_on & FIELD_MAX(GNA_CTRL_ACTIVE_LIST_EN));
+
+	ctrl &= ~GNA_CTRL_OP_MODE;
+	ctrl |= FIELD_PREP(GNA_CTRL_OP_MODE,
+			compute_cfg->gna_mode & FIELD_MAX(GNA_CTRL_OP_MODE));
+
+	gna_reg_write(addr, GNA_MMIO_CTRL, ctrl);
+
+	dev_dbg(&gna_priv->pdev->dev, "scoring started...\n");
+}
+
+static void gna_clear_saturation(struct gna_private *gna_priv)
+{
+	void __iomem *addr = gna_priv->bar0_base;
+	u32 val;
+
+	val = gna_reg_read(addr, GNA_MMIO_STS);
+	if (val & GNA_STS_SATURATE) {
+		dev_dbg(&gna_priv->pdev->dev, "saturation reached\n");
+		dev_dbg(&gna_priv->pdev->dev, "status: %#x\n", val);
+
+		val = val & GNA_STS_SATURATE;
+		gna_reg_write(addr, GNA_MMIO_STS, val);
+	}
+}
+
+void gna_abort_hw(struct gna_private *gna_priv)
+{
+	void __iomem *addr = gna_priv->bar0_base;
+	u32 val;
+	int i;
+
+	/* saturation bit in the GNA status register needs
+	 * to be explicitly cleared.
+	 */
+	gna_clear_saturation(gna_priv);
+
+	val = gna_reg_read(addr, GNA_MMIO_STS);
+	dev_dbg(&gna_priv->pdev->dev, "status before abort: %#x\n", val);
+
+	val = gna_reg_read(addr, GNA_MMIO_CTRL);
+	val |= GNA_CTRL_ABORT_CLR_ACCEL;
+	gna_reg_write(addr, GNA_MMIO_CTRL, val);
+
+	i = 100;
+	do {
+		val = gna_reg_read(addr, GNA_MMIO_STS);
+		if ((val & 0x1) == 0)
+			break;
+	} while (--i);
+
+	if (i == 0)
+		dev_err(&gna_priv->pdev->dev, "abort did not complete\n");
+}
diff --git a/drivers/misc/intel/gna/gna_hw.h b/drivers/misc/intel/gna/gna_hw.h
new file mode 100644
index 000000000000..dd682f95094e
--- /dev/null
+++ b/drivers/misc/intel/gna/gna_hw.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_HW_H__
+#define __GNA_HW_H__
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+/* GNA MMIO registers */
+#define GNA_MMIO_STS		0x80
+#define GNA_MMIO_CTRL		0x84
+#define GNA_MMIO_PTC		0x8C
+#define GNA_MMIO_PSC		0x90
+#define GNA_MMIO_DESBASE	0xB0
+#define GNA_MMIO_IBUFFS		0xB4
+
+#define GNA_PT_ENTRY_SIZE		4
+/* there are up to 1024 32-bit pointers in one page in Page Table (L1) */
+#define GNA_PT_LENGTH           (PAGE_SIZE / GNA_PT_ENTRY_SIZE)
+
+#define GNA_PGDIRN_LEN			64
+#define GNA_PGDIR_ENTRIES		1024 /* 32-bit page addresses */
+#define GNA_PGDIR_INVALID		1
+
+#define GNA_CTRL_START_ACCEL		BIT(0)
+#define GNA_CTRL_ACTIVE_LIST_EN		BIT(1)
+#define GNA_CTRL_ABORT_CLR_ACCEL	BIT(2)
+#define GNA_CTRL_OP_MODE		GENMASK(6, 5)
+#define GNA_CTRL_COMP_INT_EN		BIT(8)
+#define GNA_CTRL_ERR_INT_EN		BIT(10)
+#define GNA_CTRL_COMP_STATS_EN		GENMASK(15, 12)
+
+struct gna_mmu_info {
+	u32 vamax_size;
+	u32 rsvd_size;
+	u32 pd_size;
+};
+
+struct gna_desc_info {
+	u32 rsvd_size;
+	u32 cfg_size;
+	u32 desc_size;
+	struct gna_mmu_info mmu_info;
+};
+
+struct gna_private;
+struct gna_compute_cfg;
+
+void gna_abort_hw(struct gna_private *gna_priv);
+bool gna_hw_perf_enabled(struct gna_private *gna_priv);
+int gna_parse_hw_status(struct gna_private *gna_priv, u32 hw_status);
+void gna_print_error_status(struct gna_private *gna_priv, u32 hw_status);
+void gna_start_scoring(struct gna_private *gna_priv, void __iomem *addr,
+		       struct gna_compute_cfg *compute_cfg);
+
+#define gna_reg_read(addr, offset)		readl((addr) + (offset))
+#define gna_reg_write(addr, offset, value)	writel((value), (addr) + (offset))
+
+#endif // __GNA_HW_H__
-- 
2.28.0

