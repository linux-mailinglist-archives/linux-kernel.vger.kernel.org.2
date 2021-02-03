Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F1F30D68D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhBCJpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:45:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:52802 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233105AbhBCJpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:45:20 -0500
IronPort-SDR: PYaT1jFMCjp+wM77q3CSY+H1DJq9Kh8R2MjuAfmS5uzkjyi7T2AQhm5s221/FFcT/sq3xrZdcU
 YYEFH8RMvbBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="199968631"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="199968631"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 01:42:16 -0800
IronPort-SDR: S8NKJpoHR43yahxBwwC489fxvEByvmCjRfpxvztC3wxCj3ILzn+/ozMqSz2X29tHWIIO8gVudD
 irHWAJwHvnfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="480285048"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2021 01:42:14 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Yian Chen <yian.chen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 3/3] iommu/vt-d: Apply SATC policy
Date:   Wed,  3 Feb 2021 17:33:28 +0800
Message-Id: <20210203093329.1617808-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210203093329.1617808-1-baolu.lu@linux.intel.com>
References: <20210203093329.1617808-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yian Chen <yian.chen@intel.com>

Starting from Intel VT-d v3.2, Intel platform BIOS can provide a new SATC
table structure. SATC table lists a set of SoC integrated devices that
require ATC to work (VT-d specification v3.2, section 8.8). Furthermore,
the new version of IOMMU supports SoC device ATS in both its Scalable mode
and legacy mode.

When IOMMU is working in scalable mode, software must enable device ATS
support. On the other hand, when IOMMU is in legacy mode for whatever
reason, the hardware managed ATS will automatically take effect and the
SATC required devices can work transparently to the software. As the
result, software shouldn't enable ATS on that device, otherwise duplicate
device TLB invalidations will occur.

Signed-off-by: Yian Chen <yian.chen@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 73 +++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ee0932307d64..3e30c340e6a9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -872,6 +872,60 @@ static bool iommu_is_dummy(struct intel_iommu *iommu, struct device *dev)
 	return false;
 }
 
+static bool iommu_support_ats(struct intel_iommu *iommu)
+{
+	return ecap_dev_iotlb_support(iommu->ecap);
+}
+
+static bool device_support_ats(struct pci_dev *dev)
+{
+	return pci_ats_supported(dev) && dmar_find_matched_atsr_unit(dev);
+}
+
+static int segment_atc_required(u16 segment)
+{
+	struct acpi_dmar_satc *satc;
+	struct dmar_satc_unit *satcu;
+	int ret = 1;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
+		satc = container_of(satcu->hdr, struct acpi_dmar_satc, header);
+		if (satcu->atc_required && satcu->devices_cnt &&
+		    satc->segment == segment)
+			goto out;
+	}
+	ret = 0;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+static int device_atc_required(struct pci_dev *dev)
+{
+	struct dmar_satc_unit *satcu;
+	struct acpi_dmar_satc *satc;
+	struct device *tmp;
+	int i, ret = 1;
+
+	dev = pci_physfn(dev);
+	rcu_read_lock();
+	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
+		satc = container_of(satcu->hdr, struct acpi_dmar_satc, header);
+		if (!satcu->atc_required ||
+		    satc->segment != pci_domain_nr(dev->bus))
+			continue;
+
+		for_each_dev_scope(satcu->devices, satcu->devices_cnt, i, tmp)
+			if (to_pci_dev(tmp) == dev)
+				goto out;
+	}
+	ret = 0;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 {
 	struct dmar_drhd_unit *drhd = NULL;
@@ -2555,10 +2609,16 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
 
-		if (ecap_dev_iotlb_support(iommu->ecap) &&
-		    pci_ats_supported(pdev) &&
-		    dmar_find_matched_atsr_unit(pdev))
-			info->ats_supported = 1;
+		/*
+		 * Support ATS by default if it's supported by both IOMMU and
+		 * client sides, except that the device's ATS is required by
+		 * ACPI/SATC but the IOMMU scalable mode is disabled. In that
+		 * case the hardware managed ATS will be automatically used.
+		 */
+		if (iommu_support_ats(iommu) && device_support_ats(pdev)) {
+			if (!device_atc_required(pdev) || sm_supported(iommu))
+				info->ats_supported = 1;
+		}
 
 		if (sm_supported(iommu)) {
 			if (pasid_supported(iommu)) {
@@ -3155,6 +3215,11 @@ static int __init init_dmars(void)
 	 * endfor
 	 */
 	for_each_drhd_unit(drhd) {
+		if (pci_ats_disabled() && segment_atc_required(drhd->segment)) {
+			pr_warn("Scalable mode disabled -- Use hardware managed ATS because PCIe ATS is disabled but some devices in PCIe segment 0x%x require it.",
+				drhd->segment);
+			intel_iommu_sm = 0;
+		}
 		/*
 		 * lock not needed as this is only incremented in the single
 		 * threaded kernel __init code path all other access are read
-- 
2.25.1

