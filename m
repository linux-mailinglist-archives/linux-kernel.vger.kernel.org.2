Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA7330F740
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbhBDQIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:08:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:9765 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237777AbhBDQHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:07:06 -0500
IronPort-SDR: lVY4z9WJbU62XcGxvvQdWKNZ8g/bNqdU/2vqEm3Nv8x4KrVXmTJv5McBX2vs9wadlLCM8vieu4
 eZ/fF6TUWXNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="161024650"
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="161024650"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 08:06:12 -0800
IronPort-SDR: eQy496WW/35g6GP4T6wKxBvSaTnWvP16Cf53LhZfVIPqMuiv0m2mhCXuhPOKJ92E9pSq/k+PJa
 plm0CsityIvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="372728031"
Received: from power-sh.sh.intel.com ([10.239.48.130])
  by fmsmga008.fm.intel.com with ESMTP; 04 Feb 2021 08:06:09 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kan.liang@linux.intel.com, ak@linux.intel.com
Subject: [PATCH V2 2/3] perf/x86/rapl: Only check lower 32bits for RAPL energy counters
Date:   Fri,  5 Feb 2021 00:18:15 +0800
Message-Id: <20210204161816.12649-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204161816.12649-1-rui.zhang@intel.com>
References: <20210204161816.12649-1-rui.zhang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the RAPL ENERGY_COUNTER MSR, only the lower 32bits represent the energy
counter.

On previous platforms, the higher 32bits are reverved and always return
Zero. But on Intel SapphireRapids platform, the higher 32bits are reused
for other purpose and return non-zero value.

Thus check the lower 32bits only for these ENERGY_COUTNER MSRs, to make
sure the RAPL PMU events are not added erroneously when higher 32bits
contain non-zero value.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/rapl.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 7dbbeaacd995..7ed25b2ba05f 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -523,12 +523,15 @@ static bool test_msr(int idx, void *data)
 	return test_bit(idx, (unsigned long *) data);
 }
 
+/* Only lower 32bits of the MSR represents the energy counter */
+#define RAPL_MSR_MASK 0xFFFFFFFF
+
 static struct perf_msr intel_rapl_msrs[] = {
-	[PERF_RAPL_PP0]  = { MSR_PP0_ENERGY_STATUS,      &rapl_events_cores_group, test_msr },
-	[PERF_RAPL_PKG]  = { MSR_PKG_ENERGY_STATUS,      &rapl_events_pkg_group,   test_msr },
-	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr },
-	[PERF_RAPL_PP1]  = { MSR_PP1_ENERGY_STATUS,      &rapl_events_gpu_group,   test_msr },
-	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr },
+	[PERF_RAPL_PP0]  = { MSR_PP0_ENERGY_STATUS,      &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PKG]  = { MSR_PKG_ENERGY_STATUS,      &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PP1]  = { MSR_PP1_ENERGY_STATUS,      &rapl_events_gpu_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, false, RAPL_MSR_MASK },
 };
 
 /*
-- 
2.17.1

