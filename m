Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8573B8A01
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 23:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhF3VNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 17:13:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:4266 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235122AbhF3VMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 17:12:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="195720732"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="195720732"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 14:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="558431191"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2021 14:10:15 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 08/16] perf/x86/intel/uncore: Add Sapphire Rapids server M2M support
Date:   Wed, 30 Jun 2021 14:08:32 -0700
Message-Id: <1625087320-194204-9-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625087320-194204-1-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The M2M blocks manage the interface between the mesh (operating on both
the mesh and the SMI3 protocol) and the memory controllers.

The layout of the control registers for a M2M uncore unit is a little
 bit different from the generic one. So a specific format and ops are
required. Expose the common PCI ops which can be reused.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_discovery.c | 14 +++++++-------
 arch/x86/events/intel/uncore_discovery.h |  8 ++++++++
 arch/x86/events/intel/uncore_snbep.c     | 30 +++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index cc44311..6322df1 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -377,7 +377,7 @@ static struct intel_uncore_ops generic_uncore_msr_ops = {
 	.read_counter		= uncore_msr_read_counter,
 };
 
-static void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
+void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = uncore_pci_box_ctl(box);
@@ -386,7 +386,7 @@ static void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
 	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
 }
 
-static void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = uncore_pci_box_ctl(box);
@@ -394,7 +394,7 @@ static void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
 	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_FRZ);
 }
 
-static void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = uncore_pci_box_ctl(box);
@@ -411,8 +411,8 @@ static void intel_generic_uncore_pci_enable_event(struct intel_uncore_box *box,
 	pci_write_config_dword(pdev, hwc->config_base, hwc->config);
 }
 
-static void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
-					     struct perf_event *event)
+void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
+					    struct perf_event *event)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	struct hw_perf_event *hwc = &event->hw;
@@ -420,8 +420,8 @@ static void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
 	pci_write_config_dword(pdev, hwc->config_base, 0);
 }
 
-static u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
-					   struct perf_event *event)
+u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
+					  struct perf_event *event)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	struct hw_perf_event *hwc = &event->hw;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index eeab94c..c2c2231 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -140,5 +140,13 @@ void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box);
 void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
 					     struct perf_event *event);
 
+void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box);
+void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
+					    struct perf_event *event);
+u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
+					  struct perf_event *event);
+
 struct intel_uncore_type **
 intel_uncore_generic_init_uncores(enum uncore_access_type type_id);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index e6827e3..ff2cc02 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5512,6 +5512,34 @@ static struct intel_uncore_type spr_uncore_imc = {
 	.ops			= &spr_uncore_mmio_ops,
 };
 
+static void spr_uncore_pci_enable_event(struct intel_uncore_box *box,
+					struct perf_event *event)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	struct hw_perf_event *hwc = &event->hw;
+
+	pci_write_config_dword(pdev, hwc->config_base + 4, (u32)(hwc->config >> 32));
+	pci_write_config_dword(pdev, hwc->config_base, (u32)hwc->config);
+}
+
+static struct intel_uncore_ops spr_uncore_pci_ops = {
+	.init_box		= intel_generic_uncore_pci_init_box,
+	.disable_box		= intel_generic_uncore_pci_disable_box,
+	.enable_box		= intel_generic_uncore_pci_enable_box,
+	.disable_event		= intel_generic_uncore_pci_disable_event,
+	.enable_event		= spr_uncore_pci_enable_event,
+	.read_counter		= intel_generic_uncore_pci_read_counter,
+};
+
+#define SPR_UNCORE_PCI_COMMON_FORMAT()			\
+	SPR_UNCORE_COMMON_FORMAT(),			\
+	.ops			= &spr_uncore_pci_ops
+
+static struct intel_uncore_type spr_uncore_m2m = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "m2m",
+};
+
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
@@ -5522,7 +5550,7 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_pcu,
 	NULL,
 	&spr_uncore_imc,
-	NULL,
+	&spr_uncore_m2m,
 	NULL,
 	NULL,
 	NULL,
-- 
2.7.4

