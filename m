Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D3537F637
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhEMLDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:03:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:45141 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232905AbhEMLCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:02:09 -0400
IronPort-SDR: OUaoHcN21icCi+IAPl6W1XCMYdTLl5EC5h69LqY/hoRfT6OaP189TXXLgcxgaqBWUJ7iDiakk2
 WzTinTeP/Owg==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187048269"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187048269"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:00:59 -0700
IronPort-SDR: QJrnVK7cLlifzMvuOVQQUYB4cIDxX6q+wsXYNO6n76GhvJNygYIGmpdJI5VqeRXIyEM3ho+sVx
 7AVkrutrquqw==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625983794"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:00:57 -0700
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
Subject: [PATCH v3 02/14] intel_gna: add component of hardware operation
Date:   Thu, 13 May 2021 13:00:28 +0200
Message-Id: <20210513110040.2268-3-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
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
 drivers/misc/intel/gna/Kbuild   |   2 +-
 drivers/misc/intel/gna/device.h |  16 +++++
 drivers/misc/intel/gna/hw.c     | 118 ++++++++++++++++++++++++++++++++
 drivers/misc/intel/gna/hw.h     |  50 ++++++++++++++
 include/uapi/misc/intel/gna.h   |  47 +++++++++++++
 5 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/intel/gna/hw.c
 create mode 100644 include/uapi/misc/intel/gna.h

diff --git a/drivers/misc/intel/gna/Kbuild b/drivers/misc/intel/gna/Kbuild
index 02d758132d32..69e20c8c22bd 100644
--- a/drivers/misc/intel/gna/Kbuild
+++ b/drivers/misc/intel/gna/Kbuild
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-intel_gna-y := device.o pci.o
+intel_gna-y := device.o hw.o pci.o
 
 obj-$(CONFIG_INTEL_GNA) += intel_gna.o
diff --git a/drivers/misc/intel/gna/device.h b/drivers/misc/intel/gna/device.h
index e12bac64fbf4..a188f482a273 100644
--- a/drivers/misc/intel/gna/device.h
+++ b/drivers/misc/intel/gna/device.h
@@ -4,6 +4,7 @@
 #ifndef __GNA_DEVICE_H__
 #define __GNA_DEVICE_H__
 
+#include <linux/io.h>
 #include <linux/types.h>
 
 #include "hw.h"
@@ -27,4 +28,19 @@ struct gna_private {
 
 int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem *iobase);
 
+static inline u32 gna_reg_read(struct gna_private *gna_priv, u32 reg)
+{
+	return readl(gna_priv->iobase + reg);
+}
+
+static inline void gna_reg_write(struct gna_private *gna_priv, u32 reg, u32 val)
+{
+	writel(val, gna_priv->iobase + reg);
+}
+
+static inline struct device *gna_dev(struct gna_private *gna_priv)
+{
+	return gna_priv->parent;
+}
+
 #endif /* __GNA_DEVICE_H__ */
diff --git a/drivers/misc/intel/gna/hw.c b/drivers/misc/intel/gna/hw.c
new file mode 100644
index 000000000000..5288d554c77c
--- /dev/null
+++ b/drivers/misc/intel/gna/hw.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/iopoll.h>
+
+#include <uapi/misc/intel/gna.h>
+
+#include "device.h"
+#include "hw.h"
+
+int gna_parse_hw_status(struct gna_private *gna_priv, u32 hw_status)
+{
+	if (hw_status & GNA_ERROR) {
+		dev_dbg(gna_dev(gna_priv), "GNA completed with errors: %#x\n", hw_status);
+		return -EIO;
+	}
+
+	if (hw_status & GNA_STS_SCORE_COMPLETED) {
+		dev_dbg(gna_dev(gna_priv), "GNA completed successfully: %#x\n", hw_status);
+		return 0;
+	}
+
+	dev_err(gna_dev(gna_priv), "GNA not completed, status: %#x\n", hw_status);
+	return -ENODATA;
+}
+
+void gna_print_error_status(struct gna_private *gna_priv, u32 hw_status)
+{
+	if (hw_status & GNA_STS_PARAM_OOR)
+		dev_dbg(gna_dev(gna_priv), "GNA error: Param Out Range Error\n");
+
+	if (hw_status & GNA_STS_VA_OOR)
+		dev_dbg(gna_dev(gna_priv), "GNA error: VA Out of Range Error\n");
+
+	if (hw_status & GNA_STS_PCI_MMU_ERR)
+		dev_dbg(gna_dev(gna_priv), "GNA error: PCI MMU Error\n");
+
+	if (hw_status & GNA_STS_PCI_DMA_ERR)
+		dev_dbg(gna_dev(gna_priv), "GNA error: PCI MMU Error\n");
+
+	if (hw_status & GNA_STS_PCI_UNEXCOMPL_ERR)
+		dev_dbg(gna_dev(gna_priv), "GNA error: PCI Unexpected Completion Error\n");
+
+	if (hw_status & GNA_STS_SATURATE)
+		dev_dbg(gna_dev(gna_priv), "GNA error: Saturation Reached !\n");
+}
+
+bool gna_hw_perf_enabled(struct gna_private *gna_priv)
+{
+	u32 ctrl = gna_reg_read(gna_priv, GNA_MMIO_CTRL);
+
+	return !!FIELD_GET(GNA_CTRL_COMP_STATS_EN, ctrl);
+}
+
+void gna_start_scoring(struct gna_private *gna_priv,
+		       struct gna_compute_cfg *compute_cfg)
+{
+	u32 ctrl = gna_reg_read(gna_priv, GNA_MMIO_CTRL);
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
+	gna_reg_write(gna_priv, GNA_MMIO_CTRL, ctrl);
+
+	dev_dbg(gna_dev(gna_priv), "scoring started...\n");
+}
+
+static void gna_clear_saturation(struct gna_private *gna_priv)
+{
+	u32 val;
+
+	val = gna_reg_read(gna_priv, GNA_MMIO_STS);
+	if (val & GNA_STS_SATURATE) {
+		dev_dbg(gna_dev(gna_priv), "saturation reached\n");
+		dev_dbg(gna_dev(gna_priv), "status: %#x\n", val);
+
+		val = val & GNA_STS_SATURATE;
+		gna_reg_write(gna_priv, GNA_MMIO_STS, val);
+	}
+}
+
+void gna_abort_hw(struct gna_private *gna_priv)
+{
+	u32 val;
+	int ret;
+
+	/* saturation bit in the GNA status register needs
+	 * to be explicitly cleared.
+	 */
+	gna_clear_saturation(gna_priv);
+
+	val = gna_reg_read(gna_priv, GNA_MMIO_STS);
+	dev_dbg(gna_dev(gna_priv), "status before abort: %#x\n", val);
+
+	val = gna_reg_read(gna_priv, GNA_MMIO_CTRL);
+	val |= GNA_CTRL_ABORT_CLR_ACCEL;
+	gna_reg_write(gna_priv, GNA_MMIO_CTRL, val);
+
+	ret = readl_poll_timeout(gna_priv->iobase + GNA_MMIO_STS, val,
+				!(val & 0x1),
+				0, 1000);
+
+	if (ret)
+		dev_err(gna_dev(gna_priv), "abort did not complete\n");
+}
diff --git a/drivers/misc/intel/gna/hw.h b/drivers/misc/intel/gna/hw.h
index 8ef8dc182b92..f9c0566cbe60 100644
--- a/drivers/misc/intel/gna/hw.h
+++ b/drivers/misc/intel/gna/hw.h
@@ -4,14 +4,64 @@
 #ifndef __GNA_HW_H__
 #define __GNA_HW_H__
 
+#include <linux/bits.h>
 #include <linux/mm_types.h>
 
+struct gna_compute_cfg;
+struct gna_private;
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
 struct gna_dev_info {
 	u32 hwid;
 	u32 num_pagetables;
 	u32 num_page_entries;
 	u32 max_layer_count;
 	u64 max_hw_mem;
+
+	struct gna_desc_info desc_info;
 };
 
+void gna_abort_hw(struct gna_private *gna_priv);
+bool gna_hw_perf_enabled(struct gna_private *gna_priv);
+int gna_parse_hw_status(struct gna_private *gna_priv, u32 hw_status);
+void gna_print_error_status(struct gna_private *gna_priv, u32 hw_status);
+void gna_start_scoring(struct gna_private *gna_priv,
+		struct gna_compute_cfg *compute_cfg);
+
 #endif // __GNA_HW_H__
diff --git a/include/uapi/misc/intel/gna.h b/include/uapi/misc/intel/gna.h
new file mode 100644
index 000000000000..16a44efd0f76
--- /dev/null
+++ b/include/uapi/misc/intel/gna.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef _UAPI_GNA_H_
+#define _UAPI_GNA_H_
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+#include <linux/types.h>
+
+#define GNA_STS_SCORE_COMPLETED		_BITUL(0)
+#define GNA_STS_STATISTICS_VALID	_BITUL(3)
+#define GNA_STS_PCI_MMU_ERR		_BITUL(4)
+#define GNA_STS_PCI_DMA_ERR		_BITUL(5)
+#define GNA_STS_PCI_UNEXCOMPL_ERR	_BITUL(6)
+#define GNA_STS_VA_OOR			_BITUL(7)
+#define GNA_STS_PARAM_OOR		_BITUL(8)
+#define GNA_STS_SATURATE		_BITUL(17)
+
+#define GNA_ERROR			\
+	(GNA_STS_PCI_DMA_ERR		|\
+	 GNA_STS_PCI_MMU_ERR		|\
+	 GNA_STS_PCI_UNEXCOMPL_ERR	|\
+	 GNA_STS_PARAM_OOR		|\
+	 GNA_STS_VA_OOR)
+
+struct gna_compute_cfg {
+	__u32 layer_base;
+	__u32 layer_count;
+
+	/* List of GNA memory buffers */
+	__u64 buffers_ptr;
+	__u64 buffer_count;
+
+	__u8 active_list_on;
+	__u8 gna_mode;
+	__u8 hw_perf_encoding;
+	__u8 pad[5];
+};
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* _UAPI_GNA_H_ */
-- 
2.28.0

