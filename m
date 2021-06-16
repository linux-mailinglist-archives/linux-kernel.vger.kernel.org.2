Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620FC3AA51A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 22:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhFPUVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 16:21:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:45322 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233255AbhFPUVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 16:21:16 -0400
IronPort-SDR: +DQE7ceVgbiYScOisfXMSOhqoyIQ66MzwLK+5derv5V3EcDvVTrXzpBoV4wZVPAYNVwhK+/Ix2
 5hyiC7WiqcVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206288080"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="206288080"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 13:19:09 -0700
IronPort-SDR: B4ZA80f5MK8TTtS40ik3gLS+n4IzMTsxsp9Z1TasFwfr19z/imOpRv2jiJWfC5eYz1ILJhdA9J
 LvOC8JOsj/ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="452486102"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jun 2021 13:19:08 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     degoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] platform/x86: ISST: Optimize CPU to PCI device mapping
Date:   Wed, 16 Jun 2021 13:18:55 -0700
Message-Id: <20210616201856.1690143-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was observed that some of the high performance benchmarks are spending
more time in kernel depending on which CPU package they are executing.
The difference is significant and benchmark scores varies more than 10%.
These benchmarks adjust class of service to improve thread performance
which run in parallel. This class of service change causes access to
MMIO region of Intel Speed Select PCI devices depending on the CPU
package they are executing.

This mapping from CPU to PCI device instance uses a standard Linux PCI
interface "pci_get_domain_bus_and_slot()". This function does a linear
search to get to a PCI device. Since these platforms have 100+ PCI
devices, this search can be expensive in fast path for benchmarks.

Since the device and function of PCI device is fixed for Intel
Speed Select PCI devices, the CPU to PCI device information can be cached
at the same time when bus number for the CPU is read. In this way during
runtime the cached information can be used. This improves performance
of these benchmarks significantly.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel_speed_select_if/isst_if_common.c    | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
index 0c2aa22c7a12..aedb8310214c 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
@@ -281,11 +281,27 @@ static int isst_if_get_platform_info(void __user *argp)
 struct isst_if_cpu_info {
 	/* For BUS 0 and BUS 1 only, which we need for PUNIT interface */
 	int bus_info[2];
+	struct pci_dev *pci_dev[2];
 	int punit_cpu_id;
 };
 
 static struct isst_if_cpu_info *isst_cpu_info;
 
+static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
+{
+	int bus_number;
+
+	if (bus_no < 0 || bus_no > 1 || cpu < 0 || cpu >= nr_cpu_ids ||
+	    cpu >= num_possible_cpus())
+		return NULL;
+
+	bus_number = isst_cpu_info[cpu].bus_info[bus_no];
+	if (bus_number < 0)
+		return NULL;
+
+	return pci_get_domain_bus_and_slot(0, bus_number, PCI_DEVFN(dev, fn));
+}
+
 /**
  * isst_if_get_pci_dev() - Get the PCI device instance for a CPU
  * @cpu: Logical CPU number.
@@ -300,17 +316,18 @@ static struct isst_if_cpu_info *isst_cpu_info;
  */
 struct pci_dev *isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
 {
-	int bus_number;
+	struct pci_dev *pci_dev;
 
 	if (bus_no < 0 || bus_no > 1 || cpu < 0 || cpu >= nr_cpu_ids ||
 	    cpu >= num_possible_cpus())
 		return NULL;
 
-	bus_number = isst_cpu_info[cpu].bus_info[bus_no];
-	if (bus_number < 0)
-		return NULL;
+	pci_dev = isst_cpu_info[cpu].pci_dev[bus_no];
 
-	return pci_get_domain_bus_and_slot(0, bus_number, PCI_DEVFN(dev, fn));
+	if (pci_dev->devfn == PCI_DEVFN(dev, fn))
+		return pci_dev;
+
+	return _isst_if_get_pci_dev(cpu, bus_no, dev, fn);
 }
 EXPORT_SYMBOL_GPL(isst_if_get_pci_dev);
 
@@ -327,6 +344,8 @@ static int isst_if_cpu_online(unsigned int cpu)
 	} else {
 		isst_cpu_info[cpu].bus_info[0] = data & 0xff;
 		isst_cpu_info[cpu].bus_info[1] = (data >> 8) & 0xff;
+		isst_cpu_info[cpu].pci_dev[0] = _isst_if_get_pci_dev(cpu, 0, 0, 1);
+		isst_cpu_info[cpu].pci_dev[1] = _isst_if_get_pci_dev(cpu, 1, 30, 1);
 	}
 
 	ret = rdmsrl_safe(MSR_THREAD_ID_INFO, &data);
-- 
2.30.2

