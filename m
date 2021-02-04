Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A730F73E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhBDQHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:07:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:9802 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237795AbhBDQHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:07:12 -0500
IronPort-SDR: ydMx5/AYZamQ/l+sg6ZQgkZGQfkcPRT0iWYsA7sZburc+PrVOxEFojRnRi+D5aJBQtAORi72B5
 CGSLTUA2wyHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="161024683"
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="161024683"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 08:06:14 -0800
IronPort-SDR: qrd4mranS5Z93xaQ0vMXNfqxwfu2ztxmMQgjN58iy6jxWX46uvXKM/l4ypBQ9sCdqnRRj+MZ3U
 yFx0s83CE5sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="372728070"
Received: from power-sh.sh.intel.com ([10.239.48.130])
  by fmsmga008.fm.intel.com with ESMTP; 04 Feb 2021 08:06:12 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kan.liang@linux.intel.com, ak@linux.intel.com
Subject: [PATCH V2 3/3] perf/x86/rapl: Fix psys-energy event on Intel SPR platform
Date:   Fri,  5 Feb 2021 00:18:16 +0800
Message-Id: <20210204161816.12649-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204161816.12649-1-rui.zhang@intel.com>
References: <20210204161816.12649-1-rui.zhang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several things special for the RAPL Psys energy counter, on
Intel Sapphire Rapids platform.
1. it contains one Psys master package, and only CPUs on the master
   package can read valid value of the Psys energy counter, reading the
   MSR on CPUs in the slave package returns 0.
2. The master package does not have to be Physical package 0. And when
   all the CPUs on the Psys master package are offlined, we lose the Psys
   energy counter, at runtime.
3. The Psys energy counter can be disabled by BIOS, while all the other
   energy counters are not affected.

It is not easy to handle all of these in the current RAPL PMU design
because
a) perf_msr_probe() validates the MSR on some random CPU, which may either
   be in the Psys master package or in the Psys slave package.
b) all the RAPL events share the same PMU, and there is not API to remove
   the psys-energy event cleanly, without affecting the other events in
   the same PMU.

This patch addresses the problems in a simple way.

First,  by setting .no_check bit for RAPL Psys MSR, the psys-energy event
is always added, so we don't have to check the Psys ENERGY_STATUS MSR on
master package.

Then, by removing rapl_not_visible(), the psys-energy event is always
available in sysfs. This does not affect the previous code because, for
the RAPL MSRs with .no_check cleared, the .is_visible() callback is always
overriden in the perf_msr_probe() function.

Note, although RAPL PMU is die-based, and the Psys energy counter MSR on
Intel SPR is package scope, this is not a problem because there is only
one die in each package on SPR.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/rapl.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 7ed25b2ba05f..f42a70496a24 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -454,16 +454,9 @@ static struct attribute *rapl_events_cores[] = {
 	NULL,
 };
 
-static umode_t
-rapl_not_visible(struct kobject *kobj, struct attribute *attr, int i)
-{
-	return 0;
-}
-
 static struct attribute_group rapl_events_cores_group = {
 	.name  = "events",
 	.attrs = rapl_events_cores,
-	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_pkg[] = {
@@ -476,7 +469,6 @@ static struct attribute *rapl_events_pkg[] = {
 static struct attribute_group rapl_events_pkg_group = {
 	.name  = "events",
 	.attrs = rapl_events_pkg,
-	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_ram[] = {
@@ -489,7 +481,6 @@ static struct attribute *rapl_events_ram[] = {
 static struct attribute_group rapl_events_ram_group = {
 	.name  = "events",
 	.attrs = rapl_events_ram,
-	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_gpu[] = {
@@ -502,7 +493,6 @@ static struct attribute *rapl_events_gpu[] = {
 static struct attribute_group rapl_events_gpu_group = {
 	.name  = "events",
 	.attrs = rapl_events_gpu,
-	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_psys[] = {
@@ -515,7 +505,6 @@ static struct attribute *rapl_events_psys[] = {
 static struct attribute_group rapl_events_psys_group = {
 	.name  = "events",
 	.attrs = rapl_events_psys,
-	.is_visible = rapl_not_visible,
 };
 
 static bool test_msr(int idx, void *data)
@@ -534,6 +523,14 @@ static struct perf_msr intel_rapl_msrs[] = {
 	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, false, RAPL_MSR_MASK },
 };
 
+static struct perf_msr intel_rapl_spr_msrs[] = {
+	[PERF_RAPL_PP0]  = { MSR_PP0_ENERGY_STATUS,      &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PKG]  = { MSR_PKG_ENERGY_STATUS,      &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PP1]  = { MSR_PP1_ENERGY_STATUS,      &rapl_events_gpu_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, true, RAPL_MSR_MASK },
+};
+
 /*
  * Force to PERF_RAPL_MAX size due to:
  * - perf_msr_probe(PERF_RAPL_MAX)
@@ -764,7 +761,7 @@ static struct rapl_model model_spr = {
 			  BIT(PERF_RAPL_PSYS),
 	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_SPR,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_msrs      = intel_rapl_spr_msrs,
 };
 
 static struct rapl_model model_amd_fam17h = {
-- 
2.17.1

