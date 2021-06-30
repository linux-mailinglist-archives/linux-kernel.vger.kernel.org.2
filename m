Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF583B89FC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 23:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhF3VMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 17:12:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:4263 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235005AbhF3VMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 17:12:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="195720715"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="195720715"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 14:10:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="558431163"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2021 14:10:13 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 01/16] perf/x86/intel/uncore: Add Sapphire Rapids server framework
Date:   Wed, 30 Jun 2021 14:08:25 -0700
Message-Id: <1625087320-194204-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625087320-194204-1-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Intel Sapphire Rapids supports a discovery mechanism, that allows an
uncore driver to discover the different components ("boxes") of the
chip.

All the generic information of the uncore boxes should be retrieved from
the discovery tables. This has been enabled with the commit edae1f06c2cd
("perf/x86/intel/uncore: Parse uncore discovery tables"). Add
use_discovery to indicate the case. The uncore driver doesn't need to
hard code the generic information for each uncore box.
But we still need to enable various functionality that cannot be
directly discovered.

To support these functionalities, the Sapphire Rapids server framework
is introduced here. Each specific uncore unit will be added into the
framework in the following patches.

Add use_discovery to indicate that the discovery mechanism is required
for the platform. Currently, Intel Sapphire Rapids is one of the
platforms.

The box ID from the discovery table is the accurate index. Use it if
applicable.

All the undiscovered platform-specific features will be hard code in the
spr_uncores[]. Add uncore_type_customized_copy(), instead of the memcpy,
to only overwrite these features.

The specific uncore unit hasn't been added here. From user's
perspective, there is nothing changed for now.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c           | 26 ++++++++--
 arch/x86/events/intel/uncore.h           |  3 ++
 arch/x86/events/intel/uncore_discovery.c |  2 +-
 arch/x86/events/intel/uncore_discovery.h |  3 ++
 arch/x86/events/intel/uncore_snbep.c     | 87 ++++++++++++++++++++++++++++++++
 5 files changed, 116 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index df7b07d..7087ce7 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -869,9 +869,13 @@ static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
 			sprintf(pmu->name, "uncore_%s", type->name);
 		else
 			sprintf(pmu->name, "uncore");
-	} else
-		sprintf(pmu->name, "uncore_%s_%d", type->name, pmu->pmu_idx);
-
+	} else {
+		/*
+		 * Use the box ID from the discovery table if applicable.
+		 */
+		sprintf(pmu->name, "uncore_%s_%d", type->name,
+			type->box_ids ? type->box_ids[pmu->pmu_idx] : pmu->pmu_idx);
+	}
 }
 
 static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
@@ -1667,6 +1671,7 @@ struct intel_uncore_init_fun {
 	void	(*cpu_init)(void);
 	int	(*pci_init)(void);
 	void	(*mmio_init)(void);
+	bool	use_discovery;
 };
 
 static const struct intel_uncore_init_fun nhm_uncore_init __initconst = {
@@ -1769,6 +1774,13 @@ static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
 	.mmio_init = snr_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun spr_uncore_init __initconst = {
+	.cpu_init = spr_uncore_cpu_init,
+	.pci_init = spr_uncore_pci_init,
+	.mmio_init = spr_uncore_mmio_init,
+	.use_discovery = true,
+};
+
 static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
 	.cpu_init = intel_uncore_generic_uncore_cpu_init,
 	.pci_init = intel_uncore_generic_uncore_pci_init,
@@ -1813,6 +1825,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
 };
@@ -1836,8 +1849,13 @@ static int __init intel_uncore_init(void)
 			uncore_init = (struct intel_uncore_init_fun *)&generic_uncore_init;
 		else
 			return -ENODEV;
-	} else
+	} else {
 		uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
+		if (uncore_no_discover && uncore_init->use_discovery)
+			return -ENODEV;
+		if (uncore_init->use_discovery && !intel_uncore_has_discovery_tables())
+			return -ENODEV;
+	}
 
 	if (uncore_init->pci_init) {
 		pret = uncore_init->pci_init();
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 2917910..6d44b7e 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -607,6 +607,9 @@ void snr_uncore_mmio_init(void);
 int icx_uncore_pci_init(void);
 void icx_uncore_cpu_init(void);
 void icx_uncore_mmio_init(void);
+int spr_uncore_pci_init(void);
+void spr_uncore_cpu_init(void);
+void spr_uncore_mmio_init(void);
 
 /* uncore_nhmex.c */
 void nhmex_uncore_cpu_init(void);
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index aba9bff..93148e2 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -568,7 +568,7 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 	return true;
 }
 
-static struct intel_uncore_type **
+struct intel_uncore_type **
 intel_uncore_generic_init_uncores(enum uncore_access_type type_id)
 {
 	struct intel_uncore_discovery_type *type;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index abfb1e8..05ef64f 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -129,3 +129,6 @@ void intel_uncore_clear_discovery_tables(void);
 void intel_uncore_generic_uncore_cpu_init(void);
 int intel_uncore_generic_uncore_pci_init(void);
 void intel_uncore_generic_uncore_mmio_init(void);
+
+struct intel_uncore_type **
+intel_uncore_generic_init_uncores(enum uncore_access_type type_id);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 3a75a2c..0daa1e8 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* SandyBridge-EP/IvyTown uncore support */
 #include "uncore.h"
+#include "uncore_discovery.h"
 
 /* SNB-EP pci bus to socket mapping */
 #define SNBEP_CPUNODEID			0x40
@@ -5346,3 +5347,89 @@ void icx_uncore_mmio_init(void)
 }
 
 /* end of ICX uncore support */
+
+/* SPR uncore support */
+
+#define UNCORE_SPR_NUM_UNCORE_TYPES		12
+
+static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+};
+
+static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
+					struct intel_uncore_type *from_type)
+{
+	if (!to_type || !from_type)
+		return;
+
+	if (from_type->name)
+		to_type->name = from_type->name;
+	if (from_type->fixed_ctr_bits)
+		to_type->fixed_ctr_bits = from_type->fixed_ctr_bits;
+	if (from_type->event_mask)
+		to_type->event_mask = from_type->event_mask;
+	if (from_type->event_mask_ext)
+		to_type->event_mask_ext = from_type->event_mask_ext;
+	if (from_type->fixed_ctr)
+		to_type->fixed_ctr = from_type->fixed_ctr;
+	if (from_type->fixed_ctl)
+		to_type->fixed_ctl = from_type->fixed_ctl;
+	if (from_type->fixed_ctr_bits)
+		to_type->fixed_ctr_bits = from_type->fixed_ctr_bits;
+	if (from_type->num_shared_regs)
+		to_type->num_shared_regs = from_type->num_shared_regs;
+	if (from_type->constraints)
+		to_type->constraints = from_type->constraints;
+	if (from_type->ops)
+		to_type->ops = from_type->ops;
+	if (from_type->event_descs)
+		to_type->event_descs = from_type->event_descs;
+	if (from_type->format_group)
+		to_type->format_group = from_type->format_group;
+}
+
+static struct intel_uncore_type **
+uncore_get_uncores(enum uncore_access_type type_id)
+{
+	struct intel_uncore_type **types, **start_types;
+
+	start_types = types = intel_uncore_generic_init_uncores(type_id);
+
+	/* Only copy the customized features */
+	for (; *types; types++) {
+		if ((*types)->type_id >= UNCORE_SPR_NUM_UNCORE_TYPES)
+			continue;
+		uncore_type_customized_copy(*types, spr_uncores[(*types)->type_id]);
+	}
+
+	return start_types;
+}
+
+void spr_uncore_cpu_init(void)
+{
+	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR);
+}
+
+int spr_uncore_pci_init(void)
+{
+	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI);
+	return 0;
+}
+
+void spr_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO);
+}
+
+/* end of SPR uncore support */
-- 
2.7.4

