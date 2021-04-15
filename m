Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8188361423
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhDOVak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:30:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:8933 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235835AbhDOVaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:30:39 -0400
IronPort-SDR: M16VoHaVvbZ4HrTln6WYQAlNpE+sr8X/WBANVhADVQX1OKo+e80cU8db1AvM/2Z+YC0tiAveOt
 7r77F2XtkBVg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="195058515"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="195058515"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 14:30:15 -0700
IronPort-SDR: lfTKbKre0OBv6ge5Wa/shNrmskHfegjKmdmgkTJ42VWSuNEm6MRdJMf1DGyVGKmTkDNKAYzlUe
 CCIa5FkElBLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="421822574"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga007.jf.intel.com with ESMTP; 15 Apr 2021 14:30:15 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, acme@kernel.org, andreas@oehler-net.de,
        eranian@google.com, osk@google.com, tglx@linutronix.de,
        mark@voidzero.net, steve.wahl@hpe.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Remove uncore extra PCI dev HSWEP_PCI_PCU_3
Date:   Thu, 15 Apr 2021 14:22:43 -0700
Message-Id: <1618521764-100923-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

There may be a kernel panic on the Haswell server and the Broadwell
server, if the snbep_pci2phy_map_init() return error.

The uncore_extra_pci_dev[HSWEP_PCI_PCU_3] is used in the cpu_init() to
detect the existence of the SBOX, which is a MSR type of PMON unit.
The uncore_extra_pci_dev is allocated in the uncore_pci_init(). If the
snbep_pci2phy_map_init() returns error, perf doesn't initialize the
PCI type of the PMON units, so the uncore_extra_pci_dev will not be
allocated. But perf may continue initializing the MSR type of PMON
units. A null dereference kernel panic will be triggered.

The sockets in a Haswell server or a Broadwell server are identical.
Only need to detect the existence of the SBOX once.
Current perf probes all available PCU devices and stores them into the
uncore_extra_pci_dev. It's unnecessary.
Use the pci_get_device() to replace the uncore_extra_pci_dev. Only
detect the existence of the SBOX on the first available PCU device once.

Factor out hswep_has_limit_sbox(), since the Haswell server and the
Broadwell server uses the same way to detect the existence of the SBOX.

Add some macros to replace the magic number.

Fixes: 5306c31c5733 ("perf/x86/uncore/hsw-ep: Handle systems with only two SBOXes")
Reported-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 61 +++++++++++++++---------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b79951d..9b89376 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1159,7 +1159,6 @@ enum {
 	SNBEP_PCI_QPI_PORT0_FILTER,
 	SNBEP_PCI_QPI_PORT1_FILTER,
 	BDX_PCI_QPI_PORT2_FILTER,
-	HSWEP_PCI_PCU_3,
 };
 
 static int snbep_qpi_hw_config(struct intel_uncore_box *box, struct perf_event *event)
@@ -2857,22 +2856,33 @@ static struct intel_uncore_type *hswep_msr_uncores[] = {
 	NULL,
 };
 
-void hswep_uncore_cpu_init(void)
+#define HSWEP_PCU_DID			0x2fc0
+#define HSWEP_PCU_CAPID4_OFFET		0x94
+#define hswep_get_chop(_cap)		(((_cap) >> 6) & 0x3)
+
+static bool hswep_has_limit_sbox(unsigned int device)
 {
-	int pkg = boot_cpu_data.logical_proc_id;
+	struct pci_dev *dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, NULL);
+	u32 capid4;
+
+	if (!dev)
+		return false;
+
+	pci_read_config_dword(dev, HSWEP_PCU_CAPID4_OFFET, &capid4);
+	if (!hswep_get_chop(capid4))
+		return true;
 
+	return false;
+}
+
+void hswep_uncore_cpu_init(void)
+{
 	if (hswep_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
 		hswep_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
 
 	/* Detect 6-8 core systems with only two SBOXes */
-	if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
-		u32 capid4;
-
-		pci_read_config_dword(uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3],
-				      0x94, &capid4);
-		if (((capid4 >> 6) & 0x3) == 0)
-			hswep_uncore_sbox.num_boxes = 2;
-	}
+	if (hswep_has_limit_sbox(HSWEP_PCU_DID))
+		hswep_uncore_sbox.num_boxes = 2;
 
 	uncore_msr_uncores = hswep_msr_uncores;
 }
@@ -3135,11 +3145,6 @@ static const struct pci_device_id hswep_uncore_pci_ids[] = {
 		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
 						   SNBEP_PCI_QPI_PORT1_FILTER),
 	},
-	{ /* PCU.3 (for Capability registers) */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fc0),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
-						   HSWEP_PCI_PCU_3),
-	},
 	{ /* end: all zeroes */ }
 };
 
@@ -3231,27 +3236,18 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+#define BDX_PCU_DID			0x6fc0
+
 void bdx_uncore_cpu_init(void)
 {
-	int pkg = topology_phys_to_logical_pkg(boot_cpu_data.phys_proc_id);
-
 	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
 		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
 	uncore_msr_uncores = bdx_msr_uncores;
 
-	/* BDX-DE doesn't have SBOX */
-	if (boot_cpu_data.x86_model == 86) {
-		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
 	/* Detect systems with no SBOXes */
-	} else if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
-		struct pci_dev *pdev;
-		u32 capid4;
-
-		pdev = uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3];
-		pci_read_config_dword(pdev, 0x94, &capid4);
-		if (((capid4 >> 6) & 0x3) == 0)
-			bdx_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
-	}
+	if ((boot_cpu_data.x86_model == 86) || hswep_has_limit_sbox(BDX_PCU_DID))
+		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
+
 	hswep_uncore_pcu.constraints = bdx_uncore_pcu_constraints;
 }
 
@@ -3472,11 +3468,6 @@ static const struct pci_device_id bdx_uncore_pci_ids[] = {
 		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
 						   BDX_PCI_QPI_PORT2_FILTER),
 	},
-	{ /* PCU.3 (for Capability registers) */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
-						   HSWEP_PCI_PCU_3),
-	},
 	{ /* end: all zeroes */ }
 };
 
-- 
2.7.4

