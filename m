Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0343933F7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhCQSGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:06:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:35063 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhCQSFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:05:37 -0400
IronPort-SDR: Z7mpj6h+afkFh7O4escX5zQ6yKDzAUYU+xLUBDmxYhO4X9pVW9gl7iD49BQcKTlP60H7ADJb42
 u4TG1FbGUT0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="209489897"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="209489897"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 11:05:36 -0700
IronPort-SDR: 0UrPRCymUuAPUE9eBdN0GIlK+OuypHmnKVsmUErJn8DbqZolLzbFIxNFTfMQaRB+QFNzwybpNE
 3elCVjhVXzEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="522957290"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2021 11:05:36 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 4/5] perf/x86/intel/uncore: Generic support for the PCI type of uncore blocks
Date:   Wed, 17 Mar 2021 10:59:36 -0700
Message-Id: <1616003977-90612-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com>
References: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The discovery table provides the generic uncore block information
for the PCI type of uncore blocks, which is good enough to provide
basic uncore support.

The PCI BUS and DEVFN information can be retrieved from the box control
field. Introduce the uncore_pci_pmus_register() to register all the
PCICFG type of uncore blocks. The old PCI probe/remove way is dropped.

The PCI BUS and DEVFN information are different among dies. Add box_ctls
to store the box control field of each die.

Add a new BUS notifier for the PCI type of uncore block to support the
hotplug. If the device is "hot remove", the corresponding registered PMU
has to be unregistered. Perf cannot locate the PMU by searching a const
pci_device_id table, because the discovery tables don't provide such
information. Introduce uncore_pci_find_dev_pmu_from_types() to search
the whole uncore_pci_uncores for the PMU.

Implement generic support for the PCI type of uncore block.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c           | 91 +++++++++++++++++++++++++++++---
 arch/x86/events/intel/uncore.h           |  6 ++-
 arch/x86/events/intel/uncore_discovery.c | 80 ++++++++++++++++++++++++++++
 arch/x86/events/intel/uncore_discovery.h |  7 +++
 4 files changed, 177 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 391fa7c..3109082 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1032,10 +1032,37 @@ static int uncore_pci_get_dev_die_info(struct pci_dev *pdev, int *die)
 	return 0;
 }
 
+static struct intel_uncore_pmu *
+uncore_pci_find_dev_pmu_from_types(struct pci_dev *pdev)
+{
+	struct intel_uncore_type **types = uncore_pci_uncores;
+	struct intel_uncore_type *type;
+	u64 box_ctl;
+	int i, die;
+
+	for (; *types; types++) {
+		type = *types;
+		for (die = 0; die < __uncore_max_dies; die++) {
+			for (i = 0; i < type->num_boxes; i++) {
+				if (!type->box_ctls[die])
+					continue;
+				box_ctl = type->box_ctls[die] + type->pci_offsets[i];
+				if (pdev->devfn == UNCORE_DISCOVERY_PCI_DEVFN(box_ctl) &&
+				    pdev->bus->number == UNCORE_DISCOVERY_PCI_BUS(box_ctl) &&
+				    pci_domain_nr(pdev->bus) == UNCORE_DISCOVERY_PCI_DOMAIN(box_ctl))
+					return &type->pmus[i];
+			}
+		}
+	}
+
+	return NULL;
+}
+
 /*
  * Find the PMU of a PCI device.
  * @pdev: The PCI device.
  * @ids: The ID table of the available PCI devices with a PMU.
+ *       If NULL, search the whole uncore_pci_uncores.
  */
 static struct intel_uncore_pmu *
 uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
@@ -1045,6 +1072,9 @@ uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
 	kernel_ulong_t data;
 	unsigned int devfn;
 
+	if (!ids)
+		return uncore_pci_find_dev_pmu_from_types(pdev);
+
 	while (ids && ids->vendor) {
 		if ((ids->vendor == pdev->vendor) &&
 		    (ids->device == pdev->device)) {
@@ -1283,6 +1313,48 @@ static void uncore_pci_sub_driver_init(void)
 		uncore_pci_sub_driver = NULL;
 }
 
+static int uncore_pci_bus_notify(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	return uncore_bus_notify(nb, action, data, NULL);
+}
+
+static struct notifier_block uncore_pci_notifier = {
+	.notifier_call = uncore_pci_bus_notify,
+};
+
+
+static void uncore_pci_pmus_register(void)
+{
+	struct intel_uncore_type **types = uncore_pci_uncores;
+	struct intel_uncore_type *type;
+	struct intel_uncore_pmu *pmu;
+	struct pci_dev *pdev;
+	u64 box_ctl;
+	int i, die;
+
+	for (; *types; types++) {
+		type = *types;
+		for (die = 0; die < __uncore_max_dies; die++) {
+			for (i = 0; i < type->num_boxes; i++) {
+				if (!type->box_ctls[die])
+					continue;
+				box_ctl = type->box_ctls[die] + type->pci_offsets[i];
+				pdev = pci_get_domain_bus_and_slot(UNCORE_DISCOVERY_PCI_DOMAIN(box_ctl),
+								   UNCORE_DISCOVERY_PCI_BUS(box_ctl),
+								   UNCORE_DISCOVERY_PCI_DEVFN(box_ctl));
+				if (!pdev)
+					continue;
+				pmu = &type->pmus[i];
+
+				uncore_pci_pmu_register(pdev, type, pmu, die);
+			}
+		}
+	}
+
+	bus_register_notifier(&pci_bus_type, &uncore_pci_notifier);
+}
+
 static int __init uncore_pci_init(void)
 {
 	size_t size;
@@ -1299,12 +1371,15 @@ static int __init uncore_pci_init(void)
 	if (ret)
 		goto errtype;
 
-	uncore_pci_driver->probe = uncore_pci_probe;
-	uncore_pci_driver->remove = uncore_pci_remove;
+	if (uncore_pci_driver) {
+		uncore_pci_driver->probe = uncore_pci_probe;
+		uncore_pci_driver->remove = uncore_pci_remove;
 
-	ret = pci_register_driver(uncore_pci_driver);
-	if (ret)
-		goto errtype;
+		ret = pci_register_driver(uncore_pci_driver);
+		if (ret)
+			goto errtype;
+	} else
+		uncore_pci_pmus_register();
 
 	if (uncore_pci_sub_driver)
 		uncore_pci_sub_driver_init();
@@ -1328,7 +1403,10 @@ static void uncore_pci_exit(void)
 		pcidrv_registered = false;
 		if (uncore_pci_sub_driver)
 			bus_unregister_notifier(&pci_bus_type, &uncore_pci_sub_notifier);
-		pci_unregister_driver(uncore_pci_driver);
+		if (uncore_pci_driver)
+			pci_unregister_driver(uncore_pci_driver);
+		else
+			bus_unregister_notifier(&pci_bus_type, &uncore_pci_notifier);
 		uncore_types_exit(uncore_pci_uncores);
 		kfree(uncore_extra_pci_dev);
 		uncore_free_pcibus_map();
@@ -1676,6 +1754,7 @@ static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
 
 static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
 	.cpu_init = intel_uncore_generic_uncore_cpu_init,
+	.pci_init = intel_uncore_generic_uncore_pci_init,
 };
 
 static const struct x86_cpu_id intel_uncore_match[] __initconst = {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 05c8e06..76fc898 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -58,6 +58,7 @@ struct intel_uncore_type {
 	unsigned fixed_ctr;
 	unsigned fixed_ctl;
 	unsigned box_ctl;
+	u64 *box_ctls;	/* Unit ctrl addr of the first box of each die */
 	union {
 		unsigned msr_offset;
 		unsigned mmio_offset;
@@ -66,7 +67,10 @@ struct intel_uncore_type {
 	unsigned num_shared_regs:8;
 	unsigned single_fixed:1;
 	unsigned pair_ctr_ctl:1;
-	unsigned *msr_offsets;
+	union {
+		unsigned *msr_offsets;
+		unsigned *pci_offsets;
+	};
 	unsigned *box_ids;
 	struct event_constraint unconstrainted;
 	struct event_constraint *constraints;
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index b27f4a9..01aa2c0 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -377,6 +377,71 @@ static struct intel_uncore_ops generic_uncore_msr_ops = {
 	.read_counter		= uncore_msr_read_counter,
 };
 
+static void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	int box_ctl = uncore_pci_box_ctl(box);
+
+	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
+	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
+}
+
+static void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	int box_ctl = uncore_pci_box_ctl(box);
+
+	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_FRZ);
+}
+
+static void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	int box_ctl = uncore_pci_box_ctl(box);
+
+	pci_write_config_dword(pdev, box_ctl, 0);
+}
+
+static void intel_generic_uncore_pci_enable_event(struct intel_uncore_box *box,
+					    struct perf_event *event)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	struct hw_perf_event *hwc = &event->hw;
+
+	pci_write_config_dword(pdev, hwc->config_base, hwc->config);
+}
+
+static void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
+					     struct perf_event *event)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	struct hw_perf_event *hwc = &event->hw;
+
+	pci_write_config_dword(pdev, hwc->config_base, 0);
+}
+
+static u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
+					   struct perf_event *event)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	struct hw_perf_event *hwc = &event->hw;
+	u64 count = 0;
+
+	pci_read_config_dword(pdev, hwc->event_base, (u32 *)&count);
+	pci_read_config_dword(pdev, hwc->event_base + 4, (u32 *)&count + 1);
+
+	return count;
+}
+
+static struct intel_uncore_ops generic_uncore_pci_ops = {
+	.init_box	= intel_generic_uncore_pci_init_box,
+	.disable_box	= intel_generic_uncore_pci_disable_box,
+	.enable_box	= intel_generic_uncore_pci_enable_box,
+	.disable_event	= intel_generic_uncore_pci_disable_event,
+	.enable_event	= intel_generic_uncore_pci_enable_event,
+	.read_counter	= intel_generic_uncore_pci_read_counter,
+};
+
 static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 				      struct intel_uncore_type *uncore,
 				      struct intel_uncore_discovery_type *type)
@@ -395,6 +460,14 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 		uncore->box_ctl = (unsigned int)type->box_ctrl;
 		uncore->msr_offsets = type->box_offset;
 		break;
+	case UNCORE_ACCESS_PCI:
+		uncore->ops = &generic_uncore_pci_ops;
+		uncore->perf_ctr = (unsigned int)UNCORE_DISCOVERY_PCI_BOX_CTRL(type->box_ctrl) + type->ctr_offset;
+		uncore->event_ctl = (unsigned int)UNCORE_DISCOVERY_PCI_BOX_CTRL(type->box_ctrl) + type->ctl_offset;
+		uncore->box_ctl = (unsigned int)UNCORE_DISCOVERY_PCI_BOX_CTRL(type->box_ctrl);
+		uncore->box_ctls = type->box_ctrl_die;
+		uncore->pci_offsets = type->box_offset;
+		break;
 	default:
 		return false;
 	}
@@ -442,3 +515,10 @@ void intel_uncore_generic_uncore_cpu_init(void)
 {
 	uncore_msr_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_MSR);
 }
+
+int intel_uncore_generic_uncore_pci_init(void)
+{
+	uncore_pci_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_PCI);
+
+	return 0;
+}
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 87078ba..1639ff7 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -23,6 +23,12 @@
 /* Global discovery table size */
 #define UNCORE_DISCOVERY_GLOBAL_MAP_SIZE	0x20
 
+#define UNCORE_DISCOVERY_PCI_DOMAIN(data)	((data >> 28) & 0x7)
+#define UNCORE_DISCOVERY_PCI_BUS(data)		((data >> 20) & 0xff)
+#define UNCORE_DISCOVERY_PCI_DEVFN(data)	((data >> 12) & 0xff)
+#define UNCORE_DISCOVERY_PCI_BOX_CTRL(data)	(data & 0xfff)
+
+
 #define uncore_discovery_invalid_unit(unit)			\
 	(!unit.table1 || !unit.ctl || !unit.table3 ||	\
 	 unit.table1 == -1ULL || unit.ctl == -1ULL ||	\
@@ -121,3 +127,4 @@ struct intel_uncore_discovery_type {
 bool intel_uncore_has_discovery_tables(void);
 void intel_uncore_clear_discovery_tables(void);
 void intel_uncore_generic_uncore_cpu_init(void);
+int intel_uncore_generic_uncore_pci_init(void);
-- 
2.7.4

