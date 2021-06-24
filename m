Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABF43B2496
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 03:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFXBj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 21:39:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:8652 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhFXBjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 21:39:22 -0400
IronPort-SDR: RXoZxU9HQSILP1jte0ib48jmjC0mNt4+meDNTRSa0JUHUarw5ULLfry8+gpcnJnl+m3tnOsCc1
 QA5nB6Dmxq1Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="187757003"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="187757003"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 18:37:04 -0700
IronPort-SDR: ZOctdGMGofeghB3Pb2GWDLEKObwLGnNVPHdSm3jbNKldRi2TLZRTEdbnOod7EIxx0O8KuDhPmD
 7jdqVgwju4rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="490928499"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jun 2021 18:37:04 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, acme@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 6/7] perf/x86/intel/uncore: Support free-running counters on Sapphire Rapids server
Date:   Wed, 23 Jun 2021 18:22:08 -0700
Message-Id: <1624497729-158864-7-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Several free-running counters for IMC and IIO uncore blocks are
supported on Sapphire Rapids server.

They are not enumerated in the discovery tables. Extend
generic_init_uncores() to support extra uncore types. The uncore types
for the free-running counters is inserted right after the uncore types
retrieved from the discovery table.

The number of the free-running counter boxes is calculated from the
number of corresponding standard boxes.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_discovery.c |  10 +-
 arch/x86/events/intel/uncore_discovery.h |   2 +-
 arch/x86/events/intel/uncore_snbep.c     | 188 ++++++++++++++++++++++++++++++-
 3 files changed, 189 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 2de5563..8e9f1df 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -569,7 +569,7 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 }
 
 struct intel_uncore_type **
-intel_uncore_generic_init_uncores(enum uncore_access_type type_id)
+intel_uncore_generic_init_uncores(enum uncore_access_type type_id, int num_extra)
 {
 	struct intel_uncore_discovery_type *type;
 	struct intel_uncore_type **uncores;
@@ -577,7 +577,7 @@ intel_uncore_generic_init_uncores(enum uncore_access_type type_id)
 	struct rb_node *node;
 	int i = 0;
 
-	uncores = kcalloc(num_discovered_types[type_id] + 1,
+	uncores = kcalloc(num_discovered_types[type_id] + num_extra + 1,
 			  sizeof(struct intel_uncore_type *), GFP_KERNEL);
 	if (!uncores)
 		return empty_uncore;
@@ -606,17 +606,17 @@ intel_uncore_generic_init_uncores(enum uncore_access_type type_id)
 
 void intel_uncore_generic_uncore_cpu_init(void)
 {
-	uncore_msr_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_MSR);
+	uncore_msr_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_MSR, 0);
 }
 
 int intel_uncore_generic_uncore_pci_init(void)
 {
-	uncore_pci_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_PCI);
+	uncore_pci_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_PCI, 0);
 
 	return 0;
 }
 
 void intel_uncore_generic_uncore_mmio_init(void)
 {
-	uncore_mmio_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_MMIO);
+	uncore_mmio_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_MMIO, 0);
 }
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index b85655b..7280c8a 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -149,4 +149,4 @@ u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
 					  struct perf_event *event);
 
 struct intel_uncore_type **
-intel_uncore_generic_init_uncores(enum uncore_access_type type_id);
+intel_uncore_generic_init_uncores(enum uncore_access_type type_id, int num_extra);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 2696657..f530fc5 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5728,6 +5728,8 @@ static struct intel_uncore_type spr_uncore_mdf = {
 };
 
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
+#define UNCORE_SPR_IIO				1
+#define UNCORE_SPR_IMC				6
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_chabox,
@@ -5744,6 +5746,145 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_mdf,
 };
 
+enum perf_uncore_spr_iio_freerunning_type_id {
+	SPR_IIO_MSR_IOCLK,
+	SPR_IIO_MSR_BW_IN,
+	SPR_IIO_MSR_BW_OUT,
+
+	SPR_IIO_FREERUNNING_TYPE_MAX,
+};
+
+static struct freerunning_counters spr_iio_freerunning[] = {
+	[SPR_IIO_MSR_IOCLK]	= { 0x340e, 0x1, 0x10, 1, 48 },
+	[SPR_IIO_MSR_BW_IN]	= { 0x3800, 0x1, 0x10, 8, 48 },
+	[SPR_IIO_MSR_BW_OUT]	= { 0x3808, 0x1, 0x10, 8, 48 },
+};
+
+static struct uncore_event_desc spr_uncore_iio_freerunning_events[] = {
+	/* Free-Running IIO CLOCKS Counter */
+	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
+	/* Free-Running IIO BANDWIDTH IN Counters */
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
+	/* Free-Running IIO BANDWIDTH OUT Counters */
+	INTEL_UNCORE_EVENT_DESC(bw_out_port0,		"event=0xff,umask=0x30"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port0.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port0.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port1,		"event=0xff,umask=0x31"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port1.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port1.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port2,		"event=0xff,umask=0x32"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port2.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port2.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port3,		"event=0xff,umask=0x33"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port3.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port3.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port4,		"event=0xff,umask=0x34"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port4.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port4.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port5,		"event=0xff,umask=0x35"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port5.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port5.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port6,		"event=0xff,umask=0x36"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port6.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port6.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port7,		"event=0xff,umask=0x37"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port7.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port7.unit,	"MiB"),
+	{ /* end: all zeroes */ },
+};
+
+static struct intel_uncore_type spr_uncore_iio_free_running = {
+	.name			= "iio_free_running",
+	.num_counters		= 17,
+	.num_freerunning_types	= SPR_IIO_FREERUNNING_TYPE_MAX,
+	.freerunning		= spr_iio_freerunning,
+	.ops			= &skx_uncore_iio_freerunning_ops,
+	.event_descs		= spr_uncore_iio_freerunning_events,
+	.format_group		= &skx_uncore_iio_freerunning_format_group,
+};
+
+enum perf_uncore_spr_imc_freerunning_type_id {
+	SPR_IMC_DCLK,
+	SPR_IMC_PQ_CYCLES,
+
+	SPR_IMC_FREERUNNING_TYPE_MAX,
+};
+
+static struct freerunning_counters spr_imc_freerunning[] = {
+	[SPR_IMC_DCLK]		= { 0x22b0, 0x0, 0, 1, 48 },
+	[SPR_IMC_PQ_CYCLES]	= { 0x2318, 0x8, 0, 2, 48 },
+};
+
+static struct uncore_event_desc spr_uncore_imc_freerunning_events[] = {
+	INTEL_UNCORE_EVENT_DESC(dclk,			"event=0xff,umask=0x10"),
+
+	INTEL_UNCORE_EVENT_DESC(rpq_cycles,		"event=0xff,umask=0x20"),
+	INTEL_UNCORE_EVENT_DESC(wpq_cycles,		"event=0xff,umask=0x21"),
+	{ /* end: all zeroes */ },
+};
+
+#define SPR_MC_DEVICE_ID	0x3251
+
+static void spr_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
+{
+	int mem_offset = box->pmu->pmu_idx * ICX_IMC_MEM_STRIDE + SNR_IMC_MMIO_MEM0_OFFSET;
+
+	snr_uncore_mmio_map(box, uncore_mmio_box_ctl(box),
+			    mem_offset, SPR_MC_DEVICE_ID);
+}
+
+static struct intel_uncore_ops spr_uncore_imc_freerunning_ops = {
+	.init_box	= spr_uncore_imc_freerunning_init_box,
+	.exit_box	= uncore_mmio_exit_box,
+	.read_counter	= uncore_mmio_read_counter,
+	.hw_config	= uncore_freerunning_hw_config,
+};
+
+static struct intel_uncore_type spr_uncore_imc_free_running = {
+	.name			= "imc_free_running",
+	.num_counters		= 3,
+	.mmio_map_size		= SNR_IMC_MMIO_SIZE,
+	.num_freerunning_types	= SPR_IMC_FREERUNNING_TYPE_MAX,
+	.freerunning		= spr_imc_freerunning,
+	.ops			= &spr_uncore_imc_freerunning_ops,
+	.event_descs		= spr_uncore_imc_freerunning_events,
+	.format_group		= &skx_uncore_iio_freerunning_format_group,
+};
+
+#define UNCORE_SPR_MSR_EXTRA_UNCORES		1
+#define UNCORE_SPR_MMIO_EXTRA_UNCORES		1
+
+static struct intel_uncore_type *spr_msr_uncores[UNCORE_SPR_MSR_EXTRA_UNCORES] = {
+	&spr_uncore_iio_free_running,
+};
+
+static struct intel_uncore_type *spr_mmio_uncores[UNCORE_SPR_MMIO_EXTRA_UNCORES] = {
+	&spr_uncore_imc_free_running,
+};
+
 static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 					struct intel_uncore_type *from_type)
 {
@@ -5779,11 +5920,13 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 }
 
 static struct intel_uncore_type **
-uncore_get_uncores(enum uncore_access_type type_id)
+uncore_get_uncores(enum uncore_access_type type_id, int num_extra,
+		    struct intel_uncore_type **extra)
 {
 	struct intel_uncore_type **types, **start_types;
+	int i;
 
-	start_types = types = intel_uncore_generic_init_uncores(type_id);
+	start_types = types = intel_uncore_generic_init_uncores(type_id, num_extra);
 
 	/* Only copy the customized features */
 	for (; *types; types++) {
@@ -5792,23 +5935,58 @@ uncore_get_uncores(enum uncore_access_type type_id)
 		uncore_type_customized_copy(*types, spr_uncores[(*types)->type_id]);
 	}
 
+	for (i = 0; i < num_extra; i++, types++)
+		*types = extra[i];
+
 	return start_types;
 }
 
+static struct intel_uncore_type *
+uncore_find_type_by_id(struct intel_uncore_type **types, int type_id)
+{
+	for (; *types; types++) {
+		if (type_id == (*types)->type_id)
+			return *types;
+	}
+
+	return NULL;
+}
+
 void spr_uncore_cpu_init(void)
 {
-	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR);
+	struct intel_uncore_type *iio;
+
+	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
+						UNCORE_SPR_MSR_EXTRA_UNCORES,
+						spr_msr_uncores);
+
+	iio = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_IIO);
+	if (iio)
+		spr_uncore_iio_free_running.num_boxes = iio->num_boxes;
 }
 
 int spr_uncore_pci_init(void)
 {
-	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI);
+	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI, 0, NULL);
 	return 0;
 }
 
 void spr_uncore_mmio_init(void)
 {
-	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO);
+	struct intel_uncore_type *imc;
+
+	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
+
+	if (ret)
+		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL);
+	else {
+		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
+							 UNCORE_SPR_MMIO_EXTRA_UNCORES,
+							 spr_mmio_uncores);
+		imc = uncore_find_type_by_id(uncore_mmio_uncores, UNCORE_SPR_IMC);
+		if (imc)
+			spr_uncore_imc_free_running.num_boxes = imc->num_boxes / 2;
+	}
 }
 
 /* end of SPR uncore support */
-- 
2.7.4

