Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F6E3B8A02
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 23:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhF3VNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 17:13:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:4265 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235162AbhF3VMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 17:12:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="195720728"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="195720728"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 14:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="558431189"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2021 14:10:15 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 07/16] perf/x86/intel/uncore: Add Sapphire Rapids server IMC support
Date:   Wed, 30 Jun 2021 14:08:31 -0700
Message-Id: <1625087320-194204-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625087320-194204-1-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The Sapphire Rapids IMC provides the interface to the DRAM and
communicates to the rest of the uncore through the M2M block.

The layout of the control registers for a IMC uncore unit is a little
bit different from the generic one. There is a fixed counter for IMC.
So a specific format and ops are required. Expose the common MMIO ops
which can be reused.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_discovery.c | 10 ++++-----
 arch/x86/events/intel/uncore_discovery.h |  6 ++++++
 arch/x86/events/intel/uncore_snbep.c     | 35 +++++++++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 25f1c01..cc44311 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -454,7 +454,7 @@ static unsigned int generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
 	return type->box_ctls[box->dieid] + type->mmio_offsets[box->pmu->pmu_idx];
 }
 
-static void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
+void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 {
 	unsigned int box_ctl = generic_uncore_mmio_box_ctl(box);
 	struct intel_uncore_type *type = box->pmu->type;
@@ -478,7 +478,7 @@ static void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 	writel(GENERIC_PMON_BOX_CTL_INT, box->io_addr);
 }
 
-static void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)
 {
 	if (!box->io_addr)
 		return;
@@ -486,7 +486,7 @@ static void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)
 	writel(GENERIC_PMON_BOX_CTL_FRZ, box->io_addr);
 }
 
-static void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box)
 {
 	if (!box->io_addr)
 		return;
@@ -505,8 +505,8 @@ static void intel_generic_uncore_mmio_enable_event(struct intel_uncore_box *box,
 	writel(hwc->config, box->io_addr + hwc->config_base);
 }
 
-static void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
-					      struct perf_event *event)
+void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
+					     struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index c3bbb83..eeab94c 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -134,5 +134,11 @@ void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box);
 void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box);
 void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box);
 
+void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box);
+void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
+					     struct perf_event *event);
+
 struct intel_uncore_type **
 intel_uncore_generic_init_uncores(enum uncore_access_type type_id);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 006d111..e6827e3 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5479,6 +5479,39 @@ static struct intel_uncore_type spr_uncore_pcu = {
 	.name			= "pcu",
 };
 
+static void spr_uncore_mmio_enable_event(struct intel_uncore_box *box,
+					 struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!box->io_addr)
+		return;
+
+	if (uncore_pmc_fixed(hwc->idx))
+		writel(SNBEP_PMON_CTL_EN, box->io_addr + hwc->config_base);
+	else
+		writel(hwc->config, box->io_addr + hwc->config_base);
+}
+
+static struct intel_uncore_ops spr_uncore_mmio_ops = {
+	.init_box		= intel_generic_uncore_mmio_init_box,
+	.exit_box		= uncore_mmio_exit_box,
+	.disable_box		= intel_generic_uncore_mmio_disable_box,
+	.enable_box		= intel_generic_uncore_mmio_enable_box,
+	.disable_event		= intel_generic_uncore_mmio_disable_event,
+	.enable_event		= spr_uncore_mmio_enable_event,
+	.read_counter		= uncore_mmio_read_counter,
+};
+
+static struct intel_uncore_type spr_uncore_imc = {
+	SPR_UNCORE_COMMON_FORMAT(),
+	.name			= "imc",
+	.fixed_ctr_bits		= 48,
+	.fixed_ctr		= SNR_IMC_MMIO_PMON_FIXED_CTR,
+	.fixed_ctl		= SNR_IMC_MMIO_PMON_FIXED_CTL,
+	.ops			= &spr_uncore_mmio_ops,
+};
+
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
@@ -5488,7 +5521,7 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_m2pcie,
 	&spr_uncore_pcu,
 	NULL,
-	NULL,
+	&spr_uncore_imc,
 	NULL,
 	NULL,
 	NULL,
-- 
2.7.4

