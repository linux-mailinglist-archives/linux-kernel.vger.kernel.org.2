Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7D239199E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhEZOOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:14:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:43915 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233313AbhEZOOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:14:39 -0400
IronPort-SDR: FoiouYgXQPsd4zt0/Y3ZKNzT8/CEHCemxIHtsgFwkUUzasv4+3dTdNtfHb8B86q/Cz5w53pi74
 1JVGlYeIbKWQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202510882"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="202510882"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 07:13:02 -0700
IronPort-SDR: ZtLB4ojf6lkrwrjXkuqGA1frhIHjX9YVFaRNFSg/ySx6bS534MWjI6fcYvWv8VAKxe6kGQ55Rf
 68PJkFe05gKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="464818039"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga004.fm.intel.com with ESMTP; 26 May 2021 07:13:02 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     steve.wahl@hpe.com, john.p.donnelly@oracle.com,
        brian.maly@oracle.com, jack.vogel@oracle.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Fix a kernel WARNING triggered by maxcpus=1
Date:   Wed, 26 May 2021 06:58:47 -0700
Message-Id: <1622037527-156028-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A kernel WARNING may be triggered when setting maxcpus=1.

The uncore counters are Die-scope. When probing a PCI device, only the
BUS information can be retrieved. The uncore driver has to maintain a
mapping table used to calculate the logical Die ID from a given BUS#.

Before the patch ba9506be4e40, the mapping table stores the mapping
information from the BUS# -> a Physical Socket ID. To calculate the
logical die ID, perf does,
- In snbep_pci2phy_map_init(), retrieve the BUS# -> a Physical Socket ID
  from the UBOX PCI configure space.
- Calculate the mapping information (a BUS# -> a Physical Socket ID) for
  the other PCI BUS.
- In the uncore_pci_probe(), get the physical Socket ID from a given BUS
  and the mapping table.
- Calculate the logical Die ID

Since only the logical Die ID is required, with the patch ba9506be4e40,
the mapping table stores the mapping information from the BUS# -> a
logical Die ID. Now perf does,
- In snbep_pci2phy_map_init(), retrieve the BUS# -> a Physical Socket ID
  from the UBOX PCI configure space.
- Calculate the logical Die ID
- Calculate the mapping information (a BUS# -> a logical Die ID) for the
  other PCI BUS.
- In the uncore_pci_probe(), get the logical die ID from a given BUS and
  the mapping table.

When calculating the logical Die ID, -1 may be returned, especially when
maxcpus=1. Here, -1 means the logical Die ID is not found. But when
calculating the mapping information for the other PCI BUS, -1 indicates
that it's the other PCI BUS that requires the calculation of the
mapping. The driver will mistakenly do the calculation.

Uses the -ENODEV to indicate the case which the logical Die ID is not
found. The driver will not mess up the mapping table anymore.

Fixes: ba9506be4e40 ("perf/x86/intel/uncore: Store the logical die id
instead of the physical die id.")
Reported-by: John Donnelly <john.p.donnelly@oracle.com>
Tested-by: John Donnelly <john.p.donnelly@oracle.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index f57d9cb..035787c 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1413,6 +1413,8 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 						die_id = i;
 					else
 						die_id = topology_phys_to_logical_pkg(i);
+					if (die_id < 0)
+						die_id = -ENODEV;
 					map->pbus_to_dieid[bus] = die_id;
 					break;
 				}
@@ -1459,14 +1461,14 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 			i = -1;
 			if (reverse) {
 				for (bus = 255; bus >= 0; bus--) {
-					if (map->pbus_to_dieid[bus] >= 0)
+					if (map->pbus_to_dieid[bus] != -1)
 						i = map->pbus_to_dieid[bus];
 					else
 						map->pbus_to_dieid[bus] = i;
 				}
 			} else {
 				for (bus = 0; bus <= 255; bus++) {
-					if (map->pbus_to_dieid[bus] >= 0)
+					if (map->pbus_to_dieid[bus] != -1)
 						i = map->pbus_to_dieid[bus];
 					else
 						map->pbus_to_dieid[bus] = i;
-- 
2.7.4

