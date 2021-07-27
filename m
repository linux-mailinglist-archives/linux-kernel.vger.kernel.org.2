Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C728F3D7B60
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhG0QvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:51:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:26791 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhG0Qu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:50:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="199667789"
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="199667789"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 09:50:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="517023365"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jul 2021 09:50:57 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [UPDATE][PATCH] platform/x86: ISST: Fix optimization with use of numa
Date:   Tue, 27 Jul 2021 09:50:52 -0700
Message-Id: <20210727165052.427238-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When numa is used to map CPU to PCI device, the optimized path to read
from cached data is not working and still calls _isst_if_get_pci_dev().

The reason is that when caching the mapping, numa information is not
available as it is read later. So move the assignment of
isst_cpu_info[cpu].numa_node before calling _isst_if_get_pci_dev().

Fixes: aa2ddd242572 ("ISST: Use numa node id for cpu pci dev mapping")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Update:
	The fixes tag was wrong
This patch can wait for next merge window as these systems are not
shipped.

 drivers/platform/x86/intel_speed_select_if/isst_if_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
index 6f0cc679c8e5..8a4d52a9028d 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
@@ -379,6 +379,8 @@ static int isst_if_cpu_online(unsigned int cpu)
 	u64 data;
 	int ret;
 
+	isst_cpu_info[cpu].numa_node = cpu_to_node(cpu);
+
 	ret = rdmsrl_safe(MSR_CPU_BUS_NUMBER, &data);
 	if (ret) {
 		/* This is not a fatal error on MSR mailbox only I/F */
@@ -397,7 +399,6 @@ static int isst_if_cpu_online(unsigned int cpu)
 		return ret;
 	}
 	isst_cpu_info[cpu].punit_cpu_id = data;
-	isst_cpu_info[cpu].numa_node = cpu_to_node(cpu);
 
 	isst_restore_msr_local(cpu);
 
-- 
2.31.1

