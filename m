Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B89434624D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhCWPGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:06:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:58973 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232597AbhCWPFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:05:42 -0400
IronPort-SDR: JulwpO9Q6wvYGi14dfwTsdmWGelV8Cuf7GAxjC4T0aIrno3qfDv6CkqEw5Rs5yafFQqvnMeFnb
 /GItXdjeI5gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="170461235"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="170461235"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 08:05:12 -0700
IronPort-SDR: judr0z50X+ePtOAbaW+ZwgBF7I+y9Iou8mEp50t4xKFFaxbzooQd50heFi4n6ghln7u9p863xd
 ClTqD3aqs3Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="390913962"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2021 08:05:08 -0700
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     peterz@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
        ak@linux.intel.com, kyle.meyer@hpe.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH] perf/x86/intel/uncore: Enable IIO stacks to PMON mapping for multi-segment SKX
Date:   Tue, 23 Mar 2021 18:05:07 +0300
Message-Id: <20210323150507.2013-1-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IIO stacks to PMON mapping on Skylake servers is exposed through introduced
early attributes /sys/devices/uncore_iio_<pmu_idx>/dieX, where dieX is a
file which holds "Segment:Root Bus" for PCIe root port which can
be monitored by that IIO PMON block. These sysfs attributes are disabled
for multiple segment topologies except VMD domains which start at 0x10000.
This patch removes the limitation and enables IIO stacks to PMON mapping
for multi-segment Skylake servers by introducing segment-aware
intel_uncore_topology structure and attributing the topology configuration
to the segment in skx_iio_get_topology() function.

Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 arch/x86/events/intel/uncore.c       | 12 ++++++
 arch/x86/events/intel/uncore.h       |  9 ++++-
 arch/x86/events/intel/uncore_snbep.c | 60 +++++++++++++---------------
 3 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 33c8180d5a87..0c066d9aa17a 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -48,6 +48,18 @@ int uncore_pcibus_to_dieid(struct pci_bus *bus)
 	return die_id;
 }
 
+int uncore_die_to_segment(int die)
+{
+	struct pci_bus *bus = NULL;
+
+	/* Find first pci bus which attributes to specified die. */
+	while ((bus = pci_find_next_bus(bus)) &&
+	       (die != uncore_pcibus_to_dieid(bus)))
+		;
+
+	return bus ? pci_domain_nr(bus) : -EINVAL;
+}
+
 static void uncore_free_pcibus_map(void)
 {
 	struct pci2phy_map *map, *tmp;
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index a3c6e1643ad2..be2095ec458c 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -42,6 +42,7 @@ struct intel_uncore_pmu;
 struct intel_uncore_box;
 struct uncore_event_desc;
 struct freerunning_counters;
+struct intel_uncore_topology;
 
 struct intel_uncore_type {
 	const char *name;
@@ -80,7 +81,7 @@ struct intel_uncore_type {
 	 * to identify which platform component each PMON block of that type is
 	 * supposed to monitor.
 	 */
-	u64 *topology;
+	struct intel_uncore_topology *topology;
 	/*
 	 * Optional callbacks for managing mapping of Uncore units to PMONs
 	 */
@@ -169,6 +170,11 @@ struct freerunning_counters {
 	unsigned *box_offsets;
 };
 
+struct intel_uncore_topology {
+	u64 configuration;
+	int segment;
+};
+
 struct pci2phy_map {
 	struct list_head list;
 	int segment;
@@ -177,6 +183,7 @@ struct pci2phy_map {
 
 struct pci2phy_map *__find_pci2phy_map(int segment);
 int uncore_pcibus_to_dieid(struct pci_bus *bus);
+int uncore_die_to_segment(int die);
 
 ssize_t uncore_event_show(struct device *dev,
 			  struct device_attribute *attr, char *buf);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b79951d0707c..acc3c0e52f4d 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3684,7 +3684,8 @@ static struct intel_uncore_ops skx_uncore_iio_ops = {
 
 static inline u8 skx_iio_stack(struct intel_uncore_pmu *pmu, int die)
 {
-	return pmu->type->topology[die] >> (pmu->pmu_idx * BUS_NUM_STRIDE);
+	return pmu->type->topology[die].configuration >>
+	       (pmu->pmu_idx * BUS_NUM_STRIDE);
 }
 
 static umode_t
@@ -3697,19 +3698,14 @@ skx_iio_mapping_visible(struct kobject *kobj, struct attribute *attr, int die)
 }
 
 static ssize_t skx_iio_mapping_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+				    struct device_attribute *attr, char *buf)
 {
-	struct pci_bus *bus = pci_find_next_bus(NULL);
-	struct intel_uncore_pmu *uncore_pmu = dev_to_uncore_pmu(dev);
+	struct intel_uncore_pmu *pmu = dev_to_uncore_pmu(dev);
 	struct dev_ext_attribute *ea = to_dev_ext_attribute(attr);
 	long die = (long)ea->var;
 
-	/*
-	 * Current implementation is for single segment configuration hence it's
-	 * safe to take the segment value from the first available root bus.
-	 */
-	return sprintf(buf, "%04x:%02x\n", pci_domain_nr(bus),
-					   skx_iio_stack(uncore_pmu, die));
+	return sprintf(buf, "%04x:%02x\n", pmu->type->topology[die].segment,
+					   skx_iio_stack(pmu, die));
 }
 
 static int skx_msr_cpu_bus_read(int cpu, u64 *topology)
@@ -3746,34 +3742,32 @@ static int die_to_cpu(int die)
 
 static int skx_iio_get_topology(struct intel_uncore_type *type)
 {
-	int i, ret;
-	struct pci_bus *bus = NULL;
-
-	/*
-	 * Verified single-segment environments only; disabled for multiple
-	 * segment topologies for now except VMD domains.
-	 * VMD domains start at 0x10000 to not clash with ACPI _SEG domains.
-	 */
-	while ((bus = pci_find_next_bus(bus))
-		&& (!pci_domain_nr(bus) || pci_domain_nr(bus) > 0xffff))
-		;
-	if (bus)
-		return -EPERM;
+	int die, ret = -EPERM;
 
-	type->topology = kcalloc(uncore_max_dies(), sizeof(u64), GFP_KERNEL);
+	type->topology = kcalloc(uncore_max_dies(), sizeof(*type->topology),
+				 GFP_KERNEL);
 	if (!type->topology)
 		return -ENOMEM;
 
-	for (i = 0; i < uncore_max_dies(); i++) {
-		ret = skx_msr_cpu_bus_read(die_to_cpu(i), &type->topology[i]);
-		if (ret) {
-			kfree(type->topology);
-			type->topology = NULL;
-			return ret;
-		}
+	for (die = 0; die < uncore_max_dies(); die++) {
+		ret = skx_msr_cpu_bus_read(die_to_cpu(die),
+					   &type->topology[die].configuration);
+		if (ret)
+			break;
+
+		ret = uncore_die_to_segment(die);
+		if (ret < 0)
+			break;
+
+		type->topology[die].segment = ret;
 	}
 
-	return 0;
+	if (ret < 0) {
+		kfree(type->topology);
+		type->topology = NULL;
+	}
+
+	return ret;
 }
 
 static struct attribute_group skx_iio_mapping_group = {
@@ -3794,7 +3788,7 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
 	struct dev_ext_attribute *eas = NULL;
 
 	ret = skx_iio_get_topology(type);
-	if (ret)
+	if (ret < 0)
 		goto clear_attr_update;
 
 	ret = -ENOMEM;
-- 
2.19.1

