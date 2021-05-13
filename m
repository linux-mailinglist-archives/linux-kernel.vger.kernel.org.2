Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B5C37F63F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhEMLEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:04:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:45133 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232960AbhEMLCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:02:22 -0400
IronPort-SDR: tGrkvHMV8d69cOVENlNjKhULwGNJHUi0H0t2rHiHlidfhuw0ENlDuN3fshnHI/izji2Q4FXdB4
 jlI/+Xl4SMGA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187048301"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187048301"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:10 -0700
IronPort-SDR: p5QxGLK2JefNFLyOHXo2nMRKh5TN5UsP9DBnX9EnYon/3c2ovGMih0j7es+c2NplsWLWoEZgHX
 xbvI9o3WEsAQ==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625984061"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:07 -0700
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
Subject: [PATCH v3 06/14] intel_gna: add hardware ids
Date:   Thu, 13 May 2021 13:00:32 +0200
Message-Id: <20210513110040.2268-7-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

Add PCI ids of Intel(R) Gaussian & Neural Accelerator on supported
platforms.

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/intel/gna/hw.h  | 34 +++++++++++++++++++
 drivers/misc/intel/gna/pci.c | 65 ++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/drivers/misc/intel/gna/hw.h b/drivers/misc/intel/gna/hw.h
index f61792f9dd52..2a6890fb748e 100644
--- a/drivers/misc/intel/gna/hw.h
+++ b/drivers/misc/intel/gna/hw.h
@@ -10,6 +10,40 @@
 struct gna_compute_cfg;
 struct gna_private;
 
+#define GNA_FEATURES						\
+	.max_hw_mem = 256 * 1024 * 1024,			\
+		.num_pagetables = 64,				\
+		.num_page_entries = PAGE_SIZE / sizeof(u32),	\
+		/* desc_info all in bytes */			\
+		.desc_info = {					\
+		.rsvd_size = 256,				\
+		.cfg_size = 256,				\
+		.desc_size = 784,				\
+		.mmu_info = {					\
+			.vamax_size = 4,			\
+			.rsvd_size = 12,			\
+			.pd_size = 4 * 64,			\
+		},						\
+	}
+
+#define GNA_GEN1_FEATURES			\
+	GNA_FEATURES,				\
+		.max_layer_count = 1024
+
+#define GNA_GEN2_FEATURES			\
+	GNA_FEATURES,				\
+		.max_layer_count = 4096
+
+#define GNA_DEV_HWID_CNL	0x5A11
+#define GNA_DEV_HWID_EHL	0x4511
+#define GNA_DEV_HWID_GLK	0x3190
+#define GNA_DEV_HWID_ICL	0x8A11
+#define GNA_DEV_HWID_JSL	0x4E11
+#define GNA_DEV_HWID_TGL	0x9A11
+#define GNA_DEV_HWID_RKL	0x4C11
+#define GNA_DEV_HWID_ADL	0x464F
+#define GNA_DEV_HWID_RPL	0xA74F
+
 /* GNA MMIO registers */
 #define GNA_MMIO_STS		0x80
 #define GNA_MMIO_CTRL		0x84
diff --git a/drivers/misc/intel/gna/pci.c b/drivers/misc/intel/gna/pci.c
index ade9076db097..525e9de9d577 100644
--- a/drivers/misc/intel/gna/pci.c
+++ b/drivers/misc/intel/gna/pci.c
@@ -5,8 +5,70 @@
 #include <linux/pci.h>
 
 #include "device.h"
+#include "hw.h"
 #include "pci.h"
 
+static const struct gna_dev_info cnl_dev_info = {
+	.hwid = GNA_DEV_HWID_CNL,
+	GNA_GEN1_FEATURES
+};
+
+static const struct gna_dev_info glk_dev_info = {
+	.hwid = GNA_DEV_HWID_GLK,
+	GNA_GEN1_FEATURES
+};
+
+static const struct gna_dev_info ehl_dev_info = {
+	.hwid = GNA_DEV_HWID_EHL,
+	GNA_GEN1_FEATURES
+};
+
+static const struct gna_dev_info icl_dev_info = {
+	.hwid = GNA_DEV_HWID_ICL,
+	GNA_GEN1_FEATURES
+};
+
+static const struct gna_dev_info jsl_dev_info = {
+	.hwid = GNA_DEV_HWID_JSL,
+	GNA_GEN2_FEATURES
+};
+
+static const struct gna_dev_info tgl_dev_info = {
+	.hwid = GNA_DEV_HWID_TGL,
+	GNA_GEN2_FEATURES
+};
+
+static const struct gna_dev_info rkl_dev_info = {
+	.hwid = GNA_DEV_HWID_RKL,
+	GNA_GEN2_FEATURES
+};
+
+static const struct gna_dev_info adl_dev_info = {
+	.hwid = GNA_DEV_HWID_ADL,
+	GNA_GEN2_FEATURES
+};
+
+static const struct gna_dev_info rpl_dev_info = {
+	.hwid = GNA_DEV_HWID_RPL,
+	GNA_GEN2_FEATURES
+};
+
+#define INTEL_GNA_DEVICE(hwid, info)				\
+	{ PCI_VDEVICE(INTEL, hwid), (kernel_ulong_t)(info) }
+
+static const struct pci_device_id gna_pci_ids[] = {
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_CNL, &cnl_dev_info),
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_EHL, &ehl_dev_info),
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_GLK, &glk_dev_info),
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_ICL, &icl_dev_info),
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_JSL, &jsl_dev_info),
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_TGL, &tgl_dev_info),
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_RKL, &rkl_dev_info),
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_ADL, &adl_dev_info),
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_RPL, &rpl_dev_info),
+	{ }
+};
+
 int gna_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pci_id)
 {
 	struct gna_dev_info *dev_info;
@@ -42,7 +104,10 @@ int gna_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pci_id)
 
 static struct pci_driver gna_pci_driver = {
 	.name = GNA_DV_NAME,
+	.id_table = gna_pci_ids,
 	.probe = gna_pci_probe,
 };
 
 module_pci_driver(gna_pci_driver);
+
+MODULE_DEVICE_TABLE(pci, gna_pci_ids);
-- 
2.28.0

