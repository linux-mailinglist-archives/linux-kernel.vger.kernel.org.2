Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AB031CDA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhBPQKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:10:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:31327 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhBPQJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:09:57 -0500
IronPort-SDR: qXxIHIrMS7Xl85ojurTLgUGrAFxqFxEMNdGXPLxM+2HTBVBEDeXpZM5feyJ8eSAKy149jrjCWI
 ICW7RYei7crw==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="202118463"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="202118463"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:07:58 -0800
IronPort-SDR: nvNv5lA3+bztzY3UlPEVC2+ShJ8mCbHcF7mWfwfrOw8h6bYK8W+26awjWz4dRWankOwly8jyBf
 LJsbK05S5C/w==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="493336640"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:07:56 -0800
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH v1 02/12] gna: add component of hardware operation
Date:   Tue, 16 Feb 2021 17:05:15 +0100
Message-Id: <20210216160525.5028-3-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
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
 drivers/misc/gna/Kbuild       |   2 +-
 drivers/misc/gna/gna_device.h |   4 ++
 drivers/misc/gna/gna_hw.c     | 118 ++++++++++++++++++++++++++++++++++
 drivers/misc/gna/gna_hw.h     |  84 ++++++++++++++++++++++++
 4 files changed, 207 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/gna/gna_hw.c
 create mode 100644 drivers/misc/gna/gna_hw.h

diff --git a/drivers/misc/gna/Kbuild b/drivers/misc/gna/Kbuild
index 863956d5761a..8620d88588e5 100644
--- a/drivers/misc/gna/Kbuild
+++ b/drivers/misc/gna/Kbuild
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-gna-y := gna_device.o gna_driver.o
+gna-y := gna_device.o gna_driver.o gna_hw.o
 
 obj-$(CONFIG_INTEL_GNA) += gna.o
diff --git a/drivers/misc/gna/gna_device.h b/drivers/misc/gna/gna_device.h
index 736bc5af5081..add8088ffa28 100644
--- a/drivers/misc/gna/gna_device.h
+++ b/drivers/misc/gna/gna_device.h
@@ -10,12 +10,16 @@
 
 #include <uapi/misc/gna.h>
 
+#include "gna_hw.h"
+
 struct gna_drv_info {
 	u32 hwid;
 	u32 num_pagetables;
 	u32 num_page_entries;
 	u32 max_layer_count;
 	u64 max_hw_mem;
+
+	struct gna_desc_info desc_info;
 };
 
 struct gna_pci_bar {
diff --git a/drivers/misc/gna/gna_hw.c b/drivers/misc/gna/gna_hw.c
new file mode 100644
index 000000000000..3b85c4b75fd8
--- /dev/null
+++ b/drivers/misc/gna/gna_hw.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/jiffies.h>
+#include <linux/pci.h>
+
+#include <uapi/misc/gna.h>
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
+		dev_dbg(&gna_priv->dev, "GNA completed with errors: %#x\n", hw_status);
+		status = -EIO;
+	} else if (hw_status & GNA_STS_SCORE_COMPLETED) {
+		status = 0;
+		dev_dbg(&gna_priv->dev, "GNA completed successfully: %#x\n", hw_status);
+	} else {
+		dev_err(&gna_priv->dev, "GNA not completed, status: %#x\n", hw_status);
+		status = -ENODATA;
+	}
+
+	return status;
+}
+
+void gna_print_error_status(struct gna_private *gna_priv, u32 hw_status)
+{
+	if (hw_status & GNA_STS_PARAM_OOR)
+		dev_dbg(&gna_priv->dev, "GNA error: Param Out Range Error\n");
+
+	if (hw_status & GNA_STS_VA_OOR)
+		dev_dbg(&gna_priv->dev, "GNA error: VA Out of Range Error\n");
+
+	if (hw_status & GNA_STS_PCI_MMU_ERR)
+		dev_dbg(&gna_priv->dev, "GNA error: PCI MMU Error\n");
+
+	if (hw_status & GNA_STS_PCI_DMA_ERR)
+		dev_dbg(&gna_priv->dev, "GNA error: PCI MMU Error\n");
+
+	if (hw_status & GNA_STS_PCI_UNEXCOMPL_ERR)
+		dev_dbg(&gna_priv->dev, "GNA error: PCI Unexpected Completion Error\n");
+
+	if (hw_status & GNA_STS_SATURATE)
+		dev_dbg(&gna_priv->dev, "GNA error: Saturation Reached !\n");
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
+	dev_dbg(&gna_priv->dev, "scoring started...\n");
+}
+
+static void gna_clear_saturation(struct gna_private *gna_priv)
+{
+	void __iomem *addr = gna_priv->bar0.mem_addr;
+	u32 val;
+
+	val = gna_reg_read(addr, GNA_MMIO_STS);
+	if (val & GNA_STS_SATURATE) {
+		dev_dbg(&gna_priv->dev, "saturation reached\n");
+		dev_dbg(&gna_priv->dev, "gna status: %#x\n", val);
+
+		val = val & GNA_STS_SATURATE;
+		gna_reg_write(addr, GNA_MMIO_STS, val);
+	}
+}
+
+void gna_abort_hw(struct gna_private *gna_priv)
+{
+	void __iomem *addr = gna_priv->bar0.mem_addr;
+	u32 val;
+	int i;
+
+	/* saturation bit in the GNA status register needs
+	 * to be explicitly cleared.
+	 */
+	gna_clear_saturation(gna_priv);
+
+	val = gna_reg_read(addr, GNA_MMIO_STS);
+	dev_dbg(&gna_priv->dev, "status before abort: %#x\n", val);
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
+		dev_err(&gna_priv->dev, "abort did not complete\n");
+}
diff --git a/drivers/misc/gna/gna_hw.h b/drivers/misc/gna/gna_hw.h
new file mode 100644
index 000000000000..e09e562aae50
--- /dev/null
+++ b/drivers/misc/gna/gna_hw.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_HW_H__
+#define __GNA_HW_H__
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/io.h>
+
+/* GNA MMIO registers */
+#define GNA_MMIO_STS		0x80
+#define GNA_MMIO_CTRL		0x84
+#define GNA_MMIO_MCTL		0x88
+#define GNA_MMIO_PTC		0x8C
+#define GNA_MMIO_PSC		0x90
+#define GNA_MMIO_BP		0xA0
+#define GNA_MMIO_D0I3C		0xA8
+#define GNA_MMIO_DESBASE	0xB0
+#define GNA_MMIO_PWRCTRL	0xB2
+#define GNA_MMIO_IBUFFS		0xB4
+
+#define GNA_PT_ENTRY_SIZE		4
+/* there are up to 1024 32-bit pointers in one page in Page Table (L1) */
+#define GNA_PT_LENGTH           (PAGE_SIZE / GNA_PT_ENTRY_SIZE)
+
+/* page entries alignment for correct HW prefetching */
+#define GNA_PREFETCH_ALIGNMENT		64
+
+/* additional page entries for correct HW prefetching */
+#define GNA_PREFETCH_ENTRIES		32
+
+/* minimum size of XNN layer descriptors in bytes (at least 1 layer) */
+#define XNN_LYR_DSC_SIZE		(128)
+
+#define GMM_CFG_SIZE			(128)
+
+#define GNA_VAMAXADDR_OFFSET		0x200
+
+#define GNA_PGDIRN_OFFSET		0x210
+#define GNA_PGDIRN_LEN			64
+#define GNA_PGDIR_ENTRIES		1024 /* 32-bit page addresses */
+#define GNA_PGDIR_INVALID		1
+
+#define GNA_CTRL_START_ACCEL			BIT(0)
+#define GNA_CTRL_ACTIVE_LIST_EN			BIT(1)
+#define GNA_CTRL_ABORT_CLR_ACCEL		BIT(2)
+#define GNA_CTRL_PAUSE_ACCEL			BIT(3)
+#define GNA_CTRL_RESUME_ACCEL			BIT(4)
+#define GNA_CTRL_OP_MODE		GENMASK(6, 5)
+#define GNA_CTRL_COMP_INT_EN			BIT(8)
+#define GNA_CTRL_BP_INT_EN				BIT(9)
+#define GNA_CTRL_ERR_INT_EN				BIT(10)
+#define GNA_CTRL_COMP_STATS_EN	GENMASK(15, 12)
+#define GNA_CTRL_PM_OVER_POW_ON			BIT(16)
+#define GNA_CTRL_PM_OVER_CLK_ON			BIT(17)
+#define GNA_CTRL_PM_QUITE_IDLE_DIS		BIT(18)
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

