Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFBB3393BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhCLQlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:41:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:14817 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhCLQka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:40:30 -0500
IronPort-SDR: HwYQM0L4/SarSDU4m96MGB+/wasSHghoW8U58iex5aRKoa1Ece5D71ajVY4FNnXW78cTzmMSRY
 5aYS3ojmjxjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="188219732"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="188219732"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 08:40:29 -0800
IronPort-SDR: 2mJ2SfcKwCqiSI4GTfqI3Z2eaNHhCE6U1xq0PY1ojCTi4SaIToLGVUFUNtqcPA5fSJit/o9xp2
 9Oo305/1QFuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="404469077"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga008.fm.intel.com with ESMTP; 12 Mar 2021 08:40:29 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/5] perf/x86/intel/uncore: Rename uncore_notifier to uncore_pci_sub_notifier
Date:   Fri, 12 Mar 2021 08:34:36 -0800
Message-Id: <1615566878-70244-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615566878-70244-1-git-send-email-kan.liang@linux.intel.com>
References: <1615566878-70244-1-git-send-email-kan.liang@linux.intel.com>
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
index af6010d..45a65d3 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1199,7 +1199,8 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 }
 
 static int uncore_bus_notify(struct notifier_block *nb,
-			     unsigned long action, void *data)
+			     unsigned long action, void *data,
+			     const struct pci_device_id *ids)
 {
 	struct device *dev = data;
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -1210,7 +1211,7 @@ static int uncore_bus_notify(struct notifier_block *nb,
 	if (action != BUS_NOTIFY_DEL_DEVICE)
 		return NOTIFY_DONE;
 
-	pmu = uncore_pci_find_dev_pmu(pdev, uncore_pci_sub_driver->id_table);
+	pmu = uncore_pci_find_dev_pmu(pdev, ids);
 	if (!pmu)
 		return NOTIFY_DONE;
 
@@ -1222,8 +1223,15 @@ static int uncore_bus_notify(struct notifier_block *nb,
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
@@ -1264,7 +1272,7 @@ static void uncore_pci_sub_driver_init(void)
 		ids++;
 	}
 
-	if (notify && bus_register_notifier(&pci_bus_type, &uncore_notifier))
+	if (notify && bus_register_notifier(&pci_bus_type, &uncore_pci_sub_notifier))
 		notify = false;
 
 	if (!notify)
@@ -1315,7 +1323,7 @@ static void uncore_pci_exit(void)
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

