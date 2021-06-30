Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8B53B8A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 23:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhF3VNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 17:13:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:4265 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235219AbhF3VMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 17:12:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="195720745"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="195720745"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 14:10:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="558431208"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2021 14:10:16 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 13/16] perf/x86/intel/uncore: Factor out snr_uncore_mmio_map()
Date:   Wed, 30 Jun 2021 14:08:37 -0700
Message-Id: <1625087320-194204-14-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625087320-194204-1-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The IMC free-running counters on Sapphire Rapids server are also
accessed by MMIO, which is similar to the previous platforms, SNR and
ICX. The only difference is the device ID of the device which contains
BAR address.

Factor out snr_uncore_mmio_map() which ioremap the MMIO space. It can be
reused in the following patch for SPR.

Use the snr_uncore_mmio_map() in the icx_uncore_imc_freerunning_init_box().
There is no box_ctl for the free-running counters.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b4ce740..a4f6c53 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4684,13 +4684,15 @@ int snr_uncore_pci_init(void)
 	return 0;
 }
 
-static struct pci_dev *snr_uncore_get_mc_dev(int id)
+#define SNR_MC_DEVICE_ID	0x3451
+
+static struct pci_dev *snr_uncore_get_mc_dev(unsigned int device, int id)
 {
 	struct pci_dev *mc_dev = NULL;
 	int pkg;
 
 	while (1) {
-		mc_dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3451, mc_dev);
+		mc_dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, mc_dev);
 		if (!mc_dev)
 			break;
 		pkg = uncore_pcibus_to_dieid(mc_dev->bus);
@@ -4700,16 +4702,17 @@ static struct pci_dev *snr_uncore_get_mc_dev(int id)
 	return mc_dev;
 }
 
-static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
-				       unsigned int box_ctl, int mem_offset)
+static int snr_uncore_mmio_map(struct intel_uncore_box *box,
+			       unsigned int box_ctl, int mem_offset,
+			       unsigned int device)
 {
-	struct pci_dev *pdev = snr_uncore_get_mc_dev(box->dieid);
+	struct pci_dev *pdev = snr_uncore_get_mc_dev(device, box->dieid);
 	struct intel_uncore_type *type = box->pmu->type;
 	resource_size_t addr;
 	u32 pci_dword;
 
 	if (!pdev)
-		return;
+		return -ENODEV;
 
 	pci_read_config_dword(pdev, SNR_IMC_MMIO_BASE_OFFSET, &pci_dword);
 	addr = (pci_dword & SNR_IMC_MMIO_BASE_MASK) << 23;
@@ -4722,16 +4725,25 @@ static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
 	box->io_addr = ioremap(addr, type->mmio_map_size);
 	if (!box->io_addr) {
 		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
-		return;
+		return -EINVAL;
 	}
 
-	writel(IVBEP_PMON_BOX_CTL_INT, box->io_addr);
+	return 0;
+}
+
+static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
+				       unsigned int box_ctl, int mem_offset,
+				       unsigned int device)
+{
+	if (!snr_uncore_mmio_map(box, box_ctl, mem_offset, device))
+		writel(IVBEP_PMON_BOX_CTL_INT, box->io_addr);
 }
 
 static void snr_uncore_mmio_init_box(struct intel_uncore_box *box)
 {
 	__snr_uncore_mmio_init_box(box, uncore_mmio_box_ctl(box),
-				   SNR_IMC_MMIO_MEM0_OFFSET);
+				   SNR_IMC_MMIO_MEM0_OFFSET,
+				   SNR_MC_DEVICE_ID);
 }
 
 static void snr_uncore_mmio_disable_box(struct intel_uncore_box *box)
@@ -5255,7 +5267,8 @@ static void icx_uncore_imc_init_box(struct intel_uncore_box *box)
 	int mem_offset = (box->pmu->pmu_idx / ICX_NUMBER_IMC_CHN) * ICX_IMC_MEM_STRIDE +
 			 SNR_IMC_MMIO_MEM0_OFFSET;
 
-	__snr_uncore_mmio_init_box(box, box_ctl, mem_offset);
+	__snr_uncore_mmio_init_box(box, box_ctl, mem_offset,
+				   SNR_MC_DEVICE_ID);
 }
 
 static struct intel_uncore_ops icx_uncore_mmio_ops = {
@@ -5325,7 +5338,8 @@ static void icx_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 	int mem_offset = box->pmu->pmu_idx * ICX_IMC_MEM_STRIDE +
 			 SNR_IMC_MMIO_MEM0_OFFSET;
 
-	__snr_uncore_mmio_init_box(box, uncore_mmio_box_ctl(box), mem_offset);
+	snr_uncore_mmio_map(box, uncore_mmio_box_ctl(box),
+			    mem_offset, SNR_MC_DEVICE_ID);
 }
 
 static struct intel_uncore_ops icx_uncore_imc_freerunning_ops = {
-- 
2.7.4

