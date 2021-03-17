Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4D733F7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhCQSGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:06:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:35063 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232916AbhCQSFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:05:36 -0400
IronPort-SDR: 2h8rZ+aoBEkiwhBsriUUtmsseOTuwnJIiEjnJN7sJx7lzVGHcMTuJCjsAKJSzZz6qr3N97+IMO
 N19j1cnikIpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="209489895"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="209489895"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 11:05:35 -0700
IronPort-SDR: JeFFKVBFzDYFprxUO0XXSOggjod4g1nCb7PMygI90hFkDCvKrwNb4ChCbWvpFiDXFEVi8pBdoY
 c0S0mpGDwd5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="522957286"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2021 11:05:35 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/5] perf/x86/intel/uncore: Rename uncore_notifier to uncore_pci_sub_notifier
Date:   Wed, 17 Mar 2021 10:59:35 -0700
Message-Id: <1616003977-90612-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com>
References: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf will use a similar method to the PCI sub driver to register
the PMUs for the PCI type of uncore blocks. The method requires a BUS
notifier to support hotplug. The current BUS notifier cannot be reused,
because it searches a const id_table for the corresponding registered
PMU. The PCI type of uncore blocks in the discovery tables doesn't
provide an id_table.

Factor out uncore_bus_notify() and add the pointer of an id_table as a
parameter. The uncore_bus_notify() will be reused in the following
patch.

The current BUS notifier is only used by the PCI sub driver. Its name is
too generic. Rename it to uncore_pci_sub_notifier, which is specific for
the PCI sub driver.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index dabc01f..391fa7c 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1203,7 +1203,8 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 }
 
 static int uncore_bus_notify(struct notifier_block *nb,
-			     unsigned long action, void *data)
+			     unsigned long action, void *data,
+			     const struct pci_device_id *ids)
 {
 	struct device *dev = data;
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -1214,7 +1215,7 @@ static int uncore_bus_notify(struct notifier_block *nb,
 	if (action != BUS_NOTIFY_DEL_DEVICE)
 		return NOTIFY_DONE;
 
-	pmu = uncore_pci_find_dev_pmu(pdev, uncore_pci_sub_driver->id_table);
+	pmu = uncore_pci_find_dev_pmu(pdev, ids);
 	if (!pmu)
 		return NOTIFY_DONE;
 
@@ -1226,8 +1227,15 @@ static int uncore_bus_notify(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block uncore_notifier = {
-	.notifier_call = uncore_bus_notify,
+static int uncore_pci_sub_bus_notify(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	return uncore_bus_notify(nb, action, data,
+				 uncore_pci_sub_driver->id_table);
+}
+
+static struct notifier_block uncore_pci_sub_notifier = {
+	.notifier_call = uncore_pci_sub_bus_notify,
 };
 
 static void uncore_pci_sub_driver_init(void)
@@ -1268,7 +1276,7 @@ static void uncore_pci_sub_driver_init(void)
 		ids++;
 	}
 
-	if (notify && bus_register_notifier(&pci_bus_type, &uncore_notifier))
+	if (notify && bus_register_notifier(&pci_bus_type, &uncore_pci_sub_notifier))
 		notify = false;
 
 	if (!notify)
@@ -1319,7 +1327,7 @@ static void uncore_pci_exit(void)
 	if (pcidrv_registered) {
 		pcidrv_registered = false;
 		if (uncore_pci_sub_driver)
-			bus_unregister_notifier(&pci_bus_type, &uncore_notifier);
+			bus_unregister_notifier(&pci_bus_type, &uncore_pci_sub_notifier);
 		pci_unregister_driver(uncore_pci_driver);
 		uncore_types_exit(uncore_pci_uncores);
 		kfree(uncore_extra_pci_dev);
-- 
2.7.4

