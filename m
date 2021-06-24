Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C9B3B2495
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 03:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhFXBjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 21:39:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:8652 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhFXBjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 21:39:20 -0400
IronPort-SDR: MxXL87sGau7DiMEcoUm85KSi9QnEPGB+8ce7u9nNogZlxHPoYIyEtkdI6vzIYixfDih6TAPMpo
 eOvaQBueThGA==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="187757001"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="187757001"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 18:37:02 -0700
IronPort-SDR: cvc+siIfh4TAMuNpmyeuOsZBVASGzAWlG0EFxKoiT8JMH+I6CX7vkQNfnJ7QXIX7c9OXRqAXQq
 pWzpYIQPhVyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="490928489"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jun 2021 18:37:02 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, acme@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/7] perf/x86/intel/uncore: Factor out snr_uncore_mmio_map()
Date:   Wed, 23 Jun 2021 18:22:07 -0700
Message-Id: <1624497729-158864-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
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
index a4f436a..2696657 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4792,13 +4792,15 @@ int snr_uncore_pci_init(void)
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
@@ -4808,16 +4810,17 @@ static struct pci_dev *snr_uncore_get_mc_dev(int id)
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
@@ -4830,16 +4833,25 @@ static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
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
@@ -5413,7 +5425,8 @@ static void icx_uncore_imc_init_box(struct intel_uncore_box *box)
 	int mem_offset = (box->pmu->pmu_idx / ICX_NUMBER_IMC_CHN) * ICX_IMC_MEM_STRIDE +
 			 SNR_IMC_MMIO_MEM0_OFFSET;
 
-	__snr_uncore_mmio_init_box(box, box_ctl, mem_offset);
+	__snr_uncore_mmio_init_box(box, box_ctl, mem_offset,
+				   SNR_MC_DEVICE_ID);
 }
 
 static struct intel_uncore_ops icx_uncore_mmio_ops = {
@@ -5483,7 +5496,8 @@ static void icx_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 	int mem_offset = box->pmu->pmu_idx * ICX_IMC_MEM_STRIDE +
 			 SNR_IMC_MMIO_MEM0_OFFSET;
 
-	__snr_uncore_mmio_init_box(box, uncore_mmio_box_ctl(box), mem_offset);
+	snr_uncore_mmio_map(box, uncore_mmio_box_ctl(box),
+			    mem_offset, SNR_MC_DEVICE_ID);
 }
 
 static struct intel_uncore_ops icx_uncore_imc_freerunning_ops = {
-- 
2.7.4

