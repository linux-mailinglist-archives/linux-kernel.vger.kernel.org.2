Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941033480C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhCXSjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:39:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:17741 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237647AbhCXSic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:38:32 -0400
IronPort-SDR: F+CO5+MznMeHafoGJkhgDOkeMSYgg+mzRADx6ySQmDILE13NjoGf/eU1O0uo6XxCDfhDyzeia0
 xk0vBnSKVoMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190859515"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190859515"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:32 -0700
IronPort-SDR: LghhBQ1fXGbz4QPYwCKLR0xLXKkvGc6wpkKwNZTh/2vMyXef+htFxaKRZPP23IuKLLp68RxCK5
 FkXjc0zlduTA==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608203813"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:29 -0700
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
Subject: [PATCH v2 06/13] intel_gna: add hardware ids
Date:   Wed, 24 Mar 2021 19:36:03 +0100
Message-Id: <20210324183610.4574-7-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
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
 drivers/misc/intel/gna/gna_device.c | 76 +++++++++++++++++++++++++++++
 drivers/misc/intel/gna/gna_device.h |  5 +-
 drivers/misc/intel/gna/gna_driver.c |  1 +
 3 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/intel/gna/gna_device.c b/drivers/misc/intel/gna/gna_device.c
index 3d559f22ee93..9838d003426f 100644
--- a/drivers/misc/intel/gna/gna_device.c
+++ b/drivers/misc/intel/gna/gna_device.c
@@ -7,8 +7,84 @@
 #include "gna_device.h"
 #include "gna_driver.h"
 
+#define GNA_DEV_HWID_CNL	0x5A11
+#define GNA_DEV_HWID_EHL	0x4511
+#define GNA_DEV_HWID_GLK	0x3190
+#define GNA_DEV_HWID_ICL	0x8A11
+#define GNA_DEV_HWID_JSL	0x4E11
+#define GNA_DEV_HWID_TGL	0x9A11
+
 #define GNA_BAR0		0
 
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
diff --git a/drivers/misc/intel/gna/gna_device.h b/drivers/misc/intel/gna/gna_device.h
index a5657ab9f62a..799788d70033 100644
--- a/drivers/misc/intel/gna/gna_device.h
+++ b/drivers/misc/intel/gna/gna_device.h
@@ -7,13 +7,12 @@
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/idr.h>
+#include <linux/pci.h>
 
 #include "gna_hw.h"
 #include "gna_mem.h"
 
 struct gna_driver_private;
-struct pci_device_id;
-struct pci_dev;
 struct device;
 
 struct gna_drv_info {
@@ -51,6 +50,8 @@ struct gna_private {
 	struct mutex memidr_lock;
 };
 
+extern const struct pci_device_id gna_pci_ids[];
+
 int gna_probe(struct pci_dev *dev, const struct pci_device_id *id);
 
 void gna_remove(struct pci_dev *dev);
diff --git a/drivers/misc/intel/gna/gna_driver.c b/drivers/misc/intel/gna/gna_driver.c
index 79f4d8522bdc..a8f69a970f7a 100644
--- a/drivers/misc/intel/gna/gna_driver.c
+++ b/drivers/misc/intel/gna/gna_driver.c
@@ -16,6 +16,7 @@ struct gna_driver_private gna_drv_priv;
 
 static struct pci_driver gna_driver = {
 	.name = GNA_DV_NAME,
+	.id_table = gna_pci_ids,
 	.probe = gna_probe,
 	.remove = gna_remove,
 };
-- 
2.28.0

