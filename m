Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5816831CDBA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhBPQND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:13:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:31316 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhBPQMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:12:33 -0500
IronPort-SDR: 8o4MimEv/v0MFqZcRKM38qNDhJD7N6Oev87E9SRByAuF2XjrkGTB3fCbOjuX1woAQ5PPZJy5tI
 IdK8oMTNVtTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="202118596"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="202118596"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:08:09 -0800
IronPort-SDR: zh/374SG7yj0lIBvv9fWouF7d0bh94e4N1eKAGPnEXCG2KgnINKEg+HzrugjXNwzt+DuK4npHL
 VP4I/XN0ZmPA==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="493336683"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:08:06 -0800
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
Subject: [PATCH v1 06/12] gna: add hardware ids
Date:   Tue, 16 Feb 2021 17:05:19 +0100
Message-Id: <20210216160525.5028-7-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
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
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/gna/gna_device.c | 76 +++++++++++++++++++++++++++++++++++
 drivers/misc/gna/gna_device.h |  2 +
 drivers/misc/gna/gna_driver.c |  1 +
 3 files changed, 79 insertions(+)

diff --git a/drivers/misc/gna/gna_device.c b/drivers/misc/gna/gna_device.c
index d6a6d3cab570..7031a5d7c16c 100644
--- a/drivers/misc/gna/gna_device.c
+++ b/drivers/misc/gna/gna_device.c
@@ -8,6 +8,82 @@
 #include "gna_driver.h"
 #include "gna_hw.h"
 
+#define GNA_DEV_HWID_CNL	0x5A11
+#define GNA_DEV_HWID_EHL	0x4511
+#define GNA_DEV_HWID_GLK	0x3190
+#define GNA_DEV_HWID_ICL	0x8A11
+#define GNA_DEV_HWID_JSL	0x4E11
+#define GNA_DEV_HWID_TGL	0x9A11
+
+#define GNA_FEATURES \
+	.max_hw_mem = 256 * 1024 * 1024, \
+	.num_pagetables = 64, \
+	.num_page_entries = PAGE_SIZE / sizeof(u32), \
+	/* desc_info all in bytes */ \
+	.desc_info = { \
+		.rsvd_size = 256, \
+		.cfg_size = 256, \
+		.desc_size = 784, \
+		.mmu_info = { \
+			.vamax_size = 4, \
+			.rsvd_size = 12, \
+			.pd_size = 4 * 64, \
+		}, \
+	}
+
+#define GNA_GEN1_FEATURES \
+	GNA_FEATURES, \
+	.max_layer_count = 1024
+
+#define GNA_GEN2_FEATURES \
+	GNA_FEATURES, \
+	.max_layer_count = 4096
+
+static const struct gna_drv_info cnl_drv_info = {
+	.hwid = GNA_DEV_HWID_CNL,
+	GNA_GEN1_FEATURES
+};
+
+static const struct gna_drv_info glk_drv_info = {
+	.hwid = GNA_DEV_HWID_GLK,
+	GNA_GEN1_FEATURES
+};
+
+static const struct gna_drv_info ehl_drv_info = {
+	.hwid = GNA_DEV_HWID_EHL,
+	GNA_GEN1_FEATURES
+};
+
+static const struct gna_drv_info icl_drv_info = {
+	.hwid = GNA_DEV_HWID_ICL,
+	GNA_GEN1_FEATURES
+};
+
+static const struct gna_drv_info jsl_drv_info = {
+	.hwid = GNA_DEV_HWID_JSL,
+	GNA_GEN2_FEATURES
+};
+
+static const struct gna_drv_info tgl_drv_info = {
+	.hwid = GNA_DEV_HWID_TGL,
+	GNA_GEN2_FEATURES
+};
+
+#define INTEL_GNA_DEVICE(hwid, info) \
+	{ PCI_VDEVICE(INTEL, hwid), (kernel_ulong_t)(info) }
+
+const struct pci_device_id gna_pci_ids[] = {
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_CNL, &cnl_drv_info),
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_EHL, &ehl_drv_info),
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_GLK, &glk_drv_info),
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_ICL, &icl_drv_info),
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_JSL, &jsl_drv_info),
+	INTEL_GNA_DEVICE(GNA_DEV_HWID_TGL, &tgl_drv_info),
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, gna_pci_ids);
+
 static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 			const struct pci_device_id *pci_id)
 {
diff --git a/drivers/misc/gna/gna_device.h b/drivers/misc/gna/gna_device.h
index ee234e474d43..22c47f2c03ec 100644
--- a/drivers/misc/gna/gna_device.h
+++ b/drivers/misc/gna/gna_device.h
@@ -56,6 +56,8 @@ struct gna_private {
 	struct mutex memidr_lock;
 };
 
+extern const struct pci_device_id gna_pci_ids[];
+
 int gna_probe(struct pci_dev *dev, const struct pci_device_id *id);
 
 void gna_remove(struct pci_dev *dev);
diff --git a/drivers/misc/gna/gna_driver.c b/drivers/misc/gna/gna_driver.c
index 81f0f003f377..80981c448f3a 100644
--- a/drivers/misc/gna/gna_driver.c
+++ b/drivers/misc/gna/gna_driver.c
@@ -15,6 +15,7 @@ struct class *gna_class;
 
 static struct pci_driver gna_driver = {
 	.name = GNA_DRV_NAME,
+	.id_table = gna_pci_ids,
 	.probe = gna_probe,
 	.remove = gna_remove,
 };
-- 
2.28.0

