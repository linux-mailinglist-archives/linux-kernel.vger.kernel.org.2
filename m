Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0100B36B3F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 15:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhDZNRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 09:17:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:57069 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233681AbhDZNRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:17:04 -0400
IronPort-SDR: 9I4YsrYDNGl5cx1/4mO1AKWKT917TPUYbfDzmwb/n5qpgJdGYXpIJgjs7N5Z0apvDN+00wZWrw
 7LpMtr0QnlmQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="175815578"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="175815578"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 06:16:23 -0700
IronPort-SDR: dUv2hXBlipOkNxj/sz89W016dA108S/2yS/xWwTtwNHlyH+6mRv2s+pcbaYmRYb/vZ9RrnxL5I
 oam00rEJ8TSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="424903151"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by orsmga007.jf.intel.com with ESMTP; 26 Apr 2021 06:16:20 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
        ak@linux.intel.com, steve.wahl@hpe.com, kyle.meyer@hpe.com,
        alexander.antonov@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com
Subject: [PATCH 2/3] perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on SNR
Date:   Mon, 26 Apr 2021 16:16:13 +0300
Message-Id: <20210426131614.16205-3-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210426131614.16205-1-alexander.antonov@linux.intel.com>
References: <20210426131614.16205-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

I/O stacks to PMON mapping on Skylake server relies on topology information
from CPU_BUS_NO MSR but this approach is not applicable for SNR and ICX.
Mapping on these platforms can be gotten by reading SAD_CONTROL_CFG CSR
from Mesh2IIO device with 0x09a2 DID.
SAD_CONTROL_CFG CSR contains stack IDs in its own notation which are
statically mapped on IDs in PMON notation.

The map for Snowridge:

Stack Name         | CBDMA/DMI | PCIe Gen 3 | DLB | NIS | QAT
SAD_CONTROL_CFG ID |     0     |      1     |  2  |  3  |  4
PMON ID            |     1     |      4     |  3  |  2  |  0

This patch enables I/O stacks to IIO PMON mapping on Snowridge.
Mapping is exposed through attributes /sys/devices/uncore_iio_<pmu_idx>/dieX,
where dieX is file which holds "Segment:Root Bus" for PCIe root port which
can be monitored by that IIO PMON block. Example for Snowridge:

==> /sys/devices/uncore_iio_0/die0 <==
0000:f3
==> /sys/devices/uncore_iio_1/die0 <==
0000:00
==> /sys/devices/uncore_iio_2/die0 <==
0000:eb
==> /sys/devices/uncore_iio_3/die0 <==
0000:e3
==> /sys/devices/uncore_iio_4/die0 <==
0000:14

Mapping for Icelake server will be enabled in the follow-up patch.

Cc: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 96 ++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 72970b4c907b..9d75da6d9c75 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -348,6 +348,13 @@
 #define SKX_M2M_PCI_PMON_CTR0		0x200
 #define SKX_M2M_PCI_PMON_BOX_CTL	0x258
 
+/* Memory Map registers device ID */
+#define SNR_ICX_MESH2IIO_MMAP_DID		0x9a2
+#define SNR_ICX_SAD_CONTROL_CFG		0x3f4
+
+/* Getting I/O stack id in SAD_COTROL_CFG notation */
+#define SAD_CONTROL_STACK_ID(data)		(((data) >> 4) & 0x7)
+
 /* SNR Ubox */
 #define SNR_U_MSR_PMON_CTR0			0x1f98
 #define SNR_U_MSR_PMON_CTL0			0x1f91
@@ -4414,6 +4421,91 @@ static const struct attribute_group snr_uncore_iio_format_group = {
 	.attrs = snr_uncore_iio_formats_attr,
 };
 
+static umode_t
+snr_iio_mapping_visible(struct kobject *kobj, struct attribute *attr, int die)
+{
+	/* Root bus 0x00 is valid only for pmu_idx = 1. */
+	return pmu_iio_mapping_visible(kobj, attr, die, 1);
+}
+
+static struct attribute_group snr_iio_mapping_group = {
+	.is_visible	= snr_iio_mapping_visible,
+};
+
+static const struct attribute_group *snr_iio_attr_update[] = {
+	&snr_iio_mapping_group,
+	NULL,
+};
+
+static int sad_cfg_iio_topology(struct intel_uncore_type *type, u8 *sad_pmon_mapping)
+{
+	u32 sad_cfg;
+	int die, stack_id, ret = -EPERM;
+	struct pci_dev *dev = NULL;
+
+	type->topology = kcalloc(uncore_max_dies(), sizeof(*type->topology),
+				 GFP_KERNEL);
+	if (!type->topology)
+		return -ENOMEM;
+
+	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, SNR_ICX_MESH2IIO_MMAP_DID, dev))) {
+		ret = pci_read_config_dword(dev, SNR_ICX_SAD_CONTROL_CFG, &sad_cfg);
+		if (ret) {
+			ret = pcibios_err_to_errno(ret);
+			break;
+		}
+
+		die = uncore_pcibus_to_dieid(dev->bus);
+		stack_id = SAD_CONTROL_STACK_ID(sad_cfg);
+		if (die < 0 || stack_id >= type->num_boxes) {
+			ret = -EPERM;
+			break;
+		}
+
+		/* Convert stack id from SAD_CONTROL to PMON notation. */
+		stack_id = sad_pmon_mapping[stack_id];
+
+		((u8 *)&(type->topology[die].configuration))[stack_id] = dev->bus->number;
+		type->topology[die].segment = pci_domain_nr(dev->bus);
+	}
+
+	if (ret) {
+		kfree(type->topology);
+		type->topology = NULL;
+	}
+
+	return ret;
+}
+
+/*
+ * SNR has a static mapping of stack IDs from SAD_CONTROL_CFG notation to PMON
+ */
+enum {
+	SNR_QAT_PMON_ID,
+	SNR_CBDMA_DMI_PMON_ID,
+	SNR_NIS_PMON_ID,
+	SNR_DLB_PMON_ID,
+	SNR_PCIE_GEN3_PMON_ID
+};
+
+static u8 snr_sad_pmon_mapping[] = {
+	SNR_CBDMA_DMI_PMON_ID,
+	SNR_PCIE_GEN3_PMON_ID,
+	SNR_DLB_PMON_ID,
+	SNR_NIS_PMON_ID,
+	SNR_QAT_PMON_ID
+};
+
+static int snr_iio_get_topology(struct intel_uncore_type *type)
+{
+	return sad_cfg_iio_topology(type, snr_sad_pmon_mapping);
+}
+
+static int snr_iio_set_mapping(struct intel_uncore_type *type)
+{
+	return pmu_iio_set_mapping(type, &snr_iio_mapping_group);
+}
+
 static struct intel_uncore_type snr_uncore_iio = {
 	.name			= "iio",
 	.num_counters		= 4,
@@ -4427,6 +4519,10 @@ static struct intel_uncore_type snr_uncore_iio = {
 	.msr_offset		= SNR_IIO_MSR_OFFSET,
 	.ops			= &ivbep_uncore_msr_ops,
 	.format_group		= &snr_uncore_iio_format_group,
+	.attr_update		= snr_iio_attr_update,
+	.get_topology		= snr_iio_get_topology,
+	.set_mapping		= snr_iio_set_mapping,
+	.cleanup_mapping	= skx_iio_cleanup_mapping,
 };
 
 static struct intel_uncore_type snr_uncore_irp = {
-- 
2.21.3

