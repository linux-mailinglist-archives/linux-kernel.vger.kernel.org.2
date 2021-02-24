Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA9E324512
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhBXUQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:16:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:48419 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235607AbhBXUMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:12:44 -0500
IronPort-SDR: SmweXTpiWU+f7x/wX4z4nKPJqe1Iu1XGMGOiE8cL3RBAtNfvRn35ZvR2KZ9jv04y0v3+GfSWon
 bmuHP1UFL2Bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="164520280"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="164520280"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 12:10:56 -0800
IronPort-SDR: sN+sD1TkriLus3ieFuY73Ub1iLkyq1oE8f3kFCzQLFkx1oN83R3xOdI5CqAOMquK6bEPq8kXvI
 GsogKED4pCtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="583839964"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 24 Feb 2021 12:10:56 -0800
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 108B15804A9;
        Wed, 24 Feb 2021 12:10:56 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/2 V2] MFD: intel_pmt: Add support for DG1
Date:   Wed, 24 Feb 2021 12:10:05 -0800
Message-Id: <20210224201005.1034005-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128172846.99352-1-david.e.box@linux.intel.com>
References: <20210128172846.99352-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds PMT Telemetry aggregator support for the DG1 graphics PCIe card. The
device does not have the DVSEC region in its PCI config space so hard
code the discovery table data in the driver. Also requires a fix for DG1
in the Telemetry driver for how the ACCESS_TYPE field is used.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
Based on 5.11-rc1 review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Changes from V1:

	- New patch

 drivers/mfd/intel_pmt.c                    | 101 +++++++++++++++------
 drivers/platform/x86/intel_pmt_class.c     |  46 ++++++++++
 drivers/platform/x86/intel_pmt_class.h     |   1 +
 drivers/platform/x86/intel_pmt_telemetry.c |  20 ----
 4 files changed, 119 insertions(+), 49 deletions(-)

diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
index 65da2b17a204..dd7eb614c28e 100644
--- a/drivers/mfd/intel_pmt.c
+++ b/drivers/mfd/intel_pmt.c
@@ -49,10 +49,14 @@ enum pmt_quirks {
 
 	/* Use shift instead of mask to read discovery table offset */
 	PMT_QUIRK_TABLE_SHIFT	= BIT(2),
+
+	/* DVSEC not present (provided in driver data) */
+	PMT_QUIRK_NO_DVSEC	= BIT(3),
 };
 
 struct pmt_platform_info {
 	unsigned long quirks;
+	struct intel_dvsec_header **capabilities;
 };
 
 static const struct pmt_platform_info tgl_info = {
@@ -60,6 +64,26 @@ static const struct pmt_platform_info tgl_info = {
 		  PMT_QUIRK_TABLE_SHIFT,
 };
 
+/* DG1 Platform with DVSEC quirk*/
+static struct intel_dvsec_header dg1_telemetry = {
+	.length = 0x10,
+	.id = 2,
+	.num_entries = 1,
+	.entry_size = 3,
+	.tbir = 0,
+	.offset = 0x466000,
+};
+
+static struct intel_dvsec_header *dg1_capabilities[] = {
+	&dg1_telemetry,
+	NULL
+};
+
+static const struct pmt_platform_info dg1_info = {
+	.quirks = PMT_QUIRK_NO_DVSEC,
+	.capabilities = dg1_capabilities,
+};
+
 static int pmt_add_dev(struct pci_dev *pdev, struct intel_dvsec_header *header,
 		       unsigned long quirks)
 {
@@ -147,37 +171,54 @@ static int pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (info)
 		quirks = info->quirks;
 
-	do {
-		struct intel_dvsec_header header;
-		u32 table;
-		u16 vid;
+	if (info && (info->quirks & PMT_QUIRK_NO_DVSEC)) {
+		struct intel_dvsec_header **header;
 
-		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
-		if (!pos)
-			break;
+		header = info->capabilities;
+		while (*header) {
+			ret = pmt_add_dev(pdev, *header, quirks);
+			if (ret)
+				dev_warn(&pdev->dev,
+					 "Failed to add device for DVSEC id %d\n",
+					 (*header)->id);
+			else
+				found_devices = true;
 
-		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vid);
-		if (vid != PCI_VENDOR_ID_INTEL)
-			continue;
-
-		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2,
-				     &header.id);
-		pci_read_config_byte(pdev, pos + INTEL_DVSEC_ENTRIES,
-				     &header.num_entries);
-		pci_read_config_byte(pdev, pos + INTEL_DVSEC_SIZE,
-				     &header.entry_size);
-		pci_read_config_dword(pdev, pos + INTEL_DVSEC_TABLE,
-				      &table);
-
-		header.tbir = INTEL_DVSEC_TABLE_BAR(table);
-		header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
-
-		ret = pmt_add_dev(pdev, &header, quirks);
-		if (ret)
-			continue;
-
-		found_devices = true;
-	} while (true);
+			++header;
+		}
+	} else {
+		do {
+			struct intel_dvsec_header header;
+			u32 table;
+			u16 vid;
+
+			pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
+			if (!pos)
+				break;
+
+			pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vid);
+			if (vid != PCI_VENDOR_ID_INTEL)
+				continue;
+
+			pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2,
+					     &header.id);
+			pci_read_config_byte(pdev, pos + INTEL_DVSEC_ENTRIES,
+					     &header.num_entries);
+			pci_read_config_byte(pdev, pos + INTEL_DVSEC_SIZE,
+					     &header.entry_size);
+			pci_read_config_dword(pdev, pos + INTEL_DVSEC_TABLE,
+					      &table);
+
+			header.tbir = INTEL_DVSEC_TABLE_BAR(table);
+			header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
+
+			ret = pmt_add_dev(pdev, &header, quirks);
+			if (ret)
+				continue;
+
+			found_devices = true;
+		} while (true);
+	}
 
 	if (!found_devices)
 		return -ENODEV;
@@ -195,10 +236,12 @@ static void pmt_pci_remove(struct pci_dev *pdev)
 }
 
 #define PCI_DEVICE_ID_INTEL_PMT_ADL	0x467d
+#define PCI_DEVICE_ID_INTEL_PMT_DG1	0x490e
 #define PCI_DEVICE_ID_INTEL_PMT_OOBMSM	0x09a7
 #define PCI_DEVICE_ID_INTEL_PMT_TGL	0x9a0d
 static const struct pci_device_id pmt_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, PMT_ADL, &tgl_info) },
+	{ PCI_DEVICE_DATA(INTEL, PMT_DG1, &dg1_info) },
 	{ PCI_DEVICE_DATA(INTEL, PMT_OOBMSM, NULL) },
 	{ PCI_DEVICE_DATA(INTEL, PMT_TGL, &tgl_info) },
 	{ }
diff --git a/drivers/platform/x86/intel_pmt_class.c b/drivers/platform/x86/intel_pmt_class.c
index c8939fba4509..bd940b90c306 100644
--- a/drivers/platform/x86/intel_pmt_class.c
+++ b/drivers/platform/x86/intel_pmt_class.c
@@ -19,6 +19,28 @@
 #define PMT_XA_MAX		INT_MAX
 #define PMT_XA_LIMIT		XA_LIMIT(PMT_XA_START, PMT_XA_MAX)
 
+/*
+ * Early implementations of PMT on client platforms have some
+ * differences from the server platforms (which use the Out Of Band
+ * Management Services Module OOBMSM). This list tracks those
+ * platforms as needed to handle those differences. Newer client
+ * platforms are expected to be fully compatible with server.
+ */
+static const struct pci_device_id pmt_telem_early_client_pci_ids[] = {
+	{ PCI_VDEVICE(INTEL, 0x467d) }, /* ADL */
+	{ PCI_VDEVICE(INTEL, 0x490e) }, /* DG1 */
+	{ PCI_VDEVICE(INTEL, 0x9a0d) }, /* TGL */
+	{ }
+};
+
+bool intel_pmt_is_early_client_hw(struct device *dev)
+{
+	struct pci_dev *parent = to_pci_dev(dev->parent);
+
+	return !!pci_match_id(pmt_telem_early_client_pci_ids, parent);
+}
+EXPORT_SYMBOL_GPL(intel_pmt_is_early_client_hw);
+
 /*
  * sysfs
  */
@@ -147,6 +169,30 @@ static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
 		 * base address = end of discovery region + base offset
 		 */
 		entry->base_addr = disc_res->end + 1 + header->base_offset;
+
+		/*
+		 * Some hardware use a different calculation for the base address
+		 * when access_type == ACCESS_LOCAL. On the these systems
+		 * ACCCESS_LOCAL refers to an address in the same BAR as the
+		 * header but at a fixed offset. But as the header address was
+		 * supplied to the driver, we don't know which BAR it was in.
+		 * So search for the bar whose range includes the header address.
+		 */
+		if (intel_pmt_is_early_client_hw(dev)) {
+			int i;
+
+			entry->base_addr = 0;
+			for (i = 0; i < 6; i++)
+				if (disc_res->start >= pci_resource_start(pci_dev, i) &&
+				   (disc_res->start <= pci_resource_end(pci_dev, i))) {
+					entry->base_addr = pci_resource_start(pci_dev, i) +
+							   header->base_offset;
+					break;
+				}
+			if (!entry->base_addr)
+				return -EINVAL;
+		}
+
 		break;
 	case ACCESS_BARID:
 		/*
diff --git a/drivers/platform/x86/intel_pmt_class.h b/drivers/platform/x86/intel_pmt_class.h
index de8f8139ba31..1337019c2873 100644
--- a/drivers/platform/x86/intel_pmt_class.h
+++ b/drivers/platform/x86/intel_pmt_class.h
@@ -44,6 +44,7 @@ struct intel_pmt_namespace {
 				 struct device *dev);
 };
 
+bool intel_pmt_is_early_client_hw(struct device *dev);
 int intel_pmt_dev_create(struct intel_pmt_entry *entry,
 			 struct intel_pmt_namespace *ns,
 			 struct platform_device *pdev, int idx);
diff --git a/drivers/platform/x86/intel_pmt_telemetry.c b/drivers/platform/x86/intel_pmt_telemetry.c
index f8a87614efa4..9b95ef050457 100644
--- a/drivers/platform/x86/intel_pmt_telemetry.c
+++ b/drivers/platform/x86/intel_pmt_telemetry.c
@@ -34,26 +34,6 @@ struct pmt_telem_priv {
 	struct intel_pmt_entry		entry[];
 };
 
-/*
- * Early implementations of PMT on client platforms have some
- * differences from the server platforms (which use the Out Of Band
- * Management Services Module OOBMSM). This list tracks those
- * platforms as needed to handle those differences. Newer client
- * platforms are expected to be fully compatible with server.
- */
-static const struct pci_device_id pmt_telem_early_client_pci_ids[] = {
-	{ PCI_VDEVICE(INTEL, 0x9a0d) }, /* TGL */
-	{ PCI_VDEVICE(INTEL, 0x467d) }, /* ADL */
-	{ }
-};
-
-static bool intel_pmt_is_early_client_hw(struct device *dev)
-{
-	struct pci_dev *parent = to_pci_dev(dev->parent);
-
-	return !!pci_match_id(pmt_telem_early_client_pci_ids, parent);
-}
-
 static bool pmt_telem_region_overlaps(struct intel_pmt_entry *entry,
 				      struct device *dev)
 {
-- 
2.25.1

