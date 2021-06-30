Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDCD3B8A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 23:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhF3VNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 17:13:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:4263 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235270AbhF3VMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 17:12:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="195720750"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="195720750"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 14:10:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="558431212"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2021 14:10:16 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 15/16] perf/x86/intel/uncore: Support IMC free-running counters on Sapphire Rapids server
Date:   Wed, 30 Jun 2021 14:08:39 -0700
Message-Id: <1625087320-194204-16-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625087320-194204-1-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Several free-running counters for IMC uncore blocks are supported on
Sapphire Rapids server.

They are not enumerated in the discovery tables. The number of the
free-running counter boxes is calculated from the number of
corresponding standard boxes.

The snbep_pci2phy_map_init() is invoked to setup the mapping from a PCI
BUS to a Die ID, which is used to locate the corresponding MC device of
a IMC uncore unit in the spr_uncore_imc_freerunning_init_box().

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 66 +++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index d195c17..09692ac 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5595,6 +5595,7 @@ static struct intel_uncore_type spr_uncore_mdf = {
 
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 #define UNCORE_SPR_IIO				1
+#define UNCORE_SPR_IMC				6
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_chabox,
@@ -5691,12 +5692,65 @@ static struct intel_uncore_type spr_uncore_iio_free_running = {
 	.format_group		= &skx_uncore_iio_freerunning_format_group,
 };
 
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
 #define UNCORE_SPR_MSR_EXTRA_UNCORES		1
+#define UNCORE_SPR_MMIO_EXTRA_UNCORES		1
 
 static struct intel_uncore_type *spr_msr_uncores[UNCORE_SPR_MSR_EXTRA_UNCORES] = {
 	&spr_uncore_iio_free_running,
 };
 
+static struct intel_uncore_type *spr_mmio_uncores[UNCORE_SPR_MMIO_EXTRA_UNCORES] = {
+	&spr_uncore_imc_free_running,
+};
+
 static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 					struct intel_uncore_type *from_type)
 {
@@ -5799,7 +5853,17 @@ int spr_uncore_pci_init(void)
 
 void spr_uncore_mmio_init(void)
 {
-	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL);
+	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
+
+	if (ret)
+		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL);
+	else {
+		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
+							 UNCORE_SPR_MMIO_EXTRA_UNCORES,
+							 spr_mmio_uncores);
+
+		spr_uncore_imc_free_running.num_boxes = uncore_type_max_boxes(uncore_mmio_uncores, UNCORE_SPR_IMC) / 2;
+	}
 }
 
 /* end of SPR uncore support */
-- 
2.7.4

