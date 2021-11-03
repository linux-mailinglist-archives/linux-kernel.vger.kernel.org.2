Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982C3443DA3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhKCHZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:25:02 -0400
Received: from mail-sn1anam02on2062.outbound.protection.outlook.com ([40.107.96.62]:36200
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230152AbhKCHZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:25:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id1VQekVz9uWMyNaDvBqqByWxItAUJt/0eiZqKElq9zUabvvDC6ajZ7PQqgmbT0OOMHMhPNiAoOnwXSNCh/90UR2tJX8+Zs9iKxx4JI9UZEohnmNiwWd8Am6z+hil5vgYR7h+aS2Ooz9O2UWtCSORUVcJEStJhl+17EhYlgKSsZ+QHAv8bIDnvxTAN1Gs0ukEj4Acg9mXbpCBSbQSf7neu44B2oHoYvAtsJTc1NEVxnzmki9HHeA+6LpqD0AW0q4s9vrARUTXfV21aqTRQGR+wxWDDpF/ZOQ0c3rVt10/v5xiaibB9fmBcqdLbOhT8guMS+o5fY4O+TLeXpJg6NTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuVCfVuX7YyYrAXFC1m45xfcLyG+c7eIVE48qYEUfeo=;
 b=cK+QmrG6Pg1sGxElrI2kIO8X7Oc8At0PkvS9zCwJEPLflqSVinYn0X3WGnYQuFGyvuqir6jTK57tJuuqYg4+2Q1Au5X3FXC9/nKLguEbArgqRLMw7UVrKyz/9SpwIc2bvcUb42l6Dnf2GhRZHlJ6T7R2LrhpCS7McckmBUXBNZMmklltq5JE3FIQyDGHrPWqziwQ9Mtg0zdIBmKtP61krzWQIVFLhs+FS5LAPkgx+I9xrmEZxsjfjL0oIWKUizuIoLNVTfJ4dAVb20VFSJkyZQ4mGJeTStzE7X7IzJT1/+9nVIZp54hzTWPtZTLgtQ/rkptIMqexMzpwTV9kBpvbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuVCfVuX7YyYrAXFC1m45xfcLyG+c7eIVE48qYEUfeo=;
 b=gYuWjgA1u+DsuMUXIh79qxN+XfUNG0AMgp3vG2O/1KOe4MrVHqQl3q+FDj4QpGhk2e5si0I8r4IKsr5iObGNHB1vRk07pBmaB/QoTN5Ik4iDgQlBcGwU1V0Gb63qKChZHjkNTigInLRRGxylxI+vNURXAv8IwcOsYqFXKVYMxSE=
Received: from BN9PR03CA0304.namprd03.prod.outlook.com (2603:10b6:408:112::9)
 by CY4PR12MB1399.namprd12.prod.outlook.com (2603:10b6:903:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 3 Nov
 2021 07:22:21 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::df) by BN9PR03CA0304.outlook.office365.com
 (2603:10b6:408:112::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Wed, 3 Nov 2021 07:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 07:22:21 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 02:22:16 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <namhyung@kernel.org>, <acme@kernel.org>, <jolsa@redhat.com>
CC:     <mingo@kernel.org>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <ak@linux.intel.com>,
        <irogers@google.com>, <eranian@google.com>, <kim.phillips@amd.com>,
        <ravi.bangoria@amd.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
Date:   Wed, 3 Nov 2021 12:51:12 +0530
Message-ID: <20211103072112.32312-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029224929.379505-1-namhyung@kernel.org>
References: <20211029224929.379505-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0716a007-9742-4d76-ba81-08d99e9aacf4
X-MS-TrafficTypeDiagnostic: CY4PR12MB1399:
X-Microsoft-Antispam-PRVS: <CY4PR12MB13995D69BDDD62159F03C8B5E08C9@CY4PR12MB1399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9oqPtTWdcqhWbOVnInB0f5XvMTQzuFBtzK9r+ViOS1FMuAUANfnK/NvQpMn7QSp8pyMBV+kCcU/i5C9iv502Wr0hihuUV0gu1EVfoLKpI7C/Weq1Bj1r1hVDBw4dyA55tMZMnk68b5alv6En6QRhrvS4SKPpcBm8CJUdP02ww6uRHtY9PVA7XmVb73C20og6fT2x8MhgwfKV9VrLxIjHo7tTn4AC9PwZc++x/d5vly9xAFjnp8Hrv+sXsr3vUciHSLQXDxerfjCH8NyE56CZdhWJxwzg5eLgxL5eWmIor84OxpWnxTDB1BK8MdpFRAaljPVXQXUKuOias8mChT/lTvp7z0J7XvGfyanWHdhMXlnpuDmeOotzLTxUBTEr6fqZE8NSupB//oOEiLgu2/SezeTRfSJ4OCuzrk9B/vsWuO8QVLsBku+p/IISEdRPq2SSmuqqR3Apsq0OmVTSM+fLSmW6V4grKrangs9OmmuNefGcpT1cx7zcq4unKmKnKRnLZ+JH18pRxgSp3nHdE6PFTtqmH3/3FXUxcdQ7t2hu0Qh6GM0W8m/+gcDCrw7v6IyU1LCboEBJAACBFHIRhqtEoTlJSlzHY+fuhZXDsW0jjWqDfLTjt44ZXZE0KWhNMGLh2bKkFN/+ncrvh5icjCO0yfPZBtK6HgyOCsfCq14oGpP1p4gOqN+YPvgnOI/QlzbwXIUK2PbnT9k0vozdjN+W3VaLzvb7m0Vmsf2d6IuM18=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(5660300002)(8676002)(8936002)(1076003)(26005)(86362001)(82310400003)(70206006)(186003)(83380400001)(70586007)(53546011)(7696005)(16526019)(4326008)(54906003)(356005)(81166007)(36756003)(508600001)(110136005)(6666004)(2906002)(336012)(36860700001)(426003)(316002)(47076005)(44832011)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 07:22:21.3077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0716a007-9742-4d76-ba81-08d99e9aacf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1399
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The current logic for the perf missing feature has a bug that it can
> wrongly clear some modifiers like G or H.  Actually some PMUs don't
> support any filtering or exclusion while others do.  But we check it
> as a global feature.

(Sorry to pitch in bit late)

AMD has one more problem on a similar line. On AMD, non-precise and
precise sampling are provided by core and IBS pmu respectively. Plus,
core pmu has filtering capability but IBS does not. Perf by default
sets precise_ip=3 and exclude_guest=1 and goes on decreasing precise_ip
with exclude_guest set until perf_event_open() succeeds. This is
causing perf to always fallback to core pmu (non-precise mode) even if
it's perfectly feasible to do precise sampling. Do you guys think this
problem should also be addressed while designing solution for Namhyung's
patch or solve it seperately like below patch:

---><---

From 48808299679199c39ff737a30a7f387669314fd7 Mon Sep 17 00:00:00 2001
From: Ravi Bangoria <ravi.bangoria@amd.com>
Date: Tue, 2 Nov 2021 11:01:12 +0530
Subject: [PATCH] perf/amd/ibs: Don't set exclude_guest by default

Perf tool sets exclude_guest by default while calling perf_event_open().
Because IBS does not have filtering capability, it always gets rejected
by IBS PMU driver and thus perf falls back to non-precise sampling. Fix
it by not setting exclude_guest by default on AMD.

Before:
  $ sudo ./perf record -C 0 -vvv true |& grep precise
    precise_ip                       3
  decreasing precise_ip by one (2)
    precise_ip                       2
  decreasing precise_ip by one (1)
    precise_ip                       1
  decreasing precise_ip by one (0)

After:
  $ sudo ./perf record -C 0 -vvv true |& grep precise
    precise_ip                       3
  decreasing precise_ip by one (2)
    precise_ip                       2

Reported-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/util/evsel.c | 23 +++++++++++++++++++++++
 tools/perf/util/evsel.c          | 12 +++++++-----
 tools/perf/util/evsel.h          |  1 +
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 2f733cdc8dbb..7841a49ce856 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -1,8 +1,31 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
+#include <stdlib.h>
 #include "util/evsel.h"
+#include "util/env.h"
+#include "linux/string.h"
 
 void arch_evsel__set_sample_weight(struct evsel *evsel)
 {
 	evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
 }
+
+void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
+{
+	struct perf_env env = {0};
+
+	if (!perf_env__cpuid(&env))
+		return;
+
+	/*
+	 * On AMD, precise cycles event sampling internally uses IBS pmu.
+	 * But IBS does not have filtering capabilities and perf by default
+	 * sets exclude_guest = 1. This makes IBS pmu event init fail and
+	 * thus perf ends up doing non-precise sampling. Avoid it by clearing
+	 * exclude_guest.
+	 */
+	if (env.cpuid && strstarts(env.cpuid, "AuthenticAMD"))
+		attr->exclude_guest = 0;
+
+	free(env.cpuid);
+}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbfeceb2546c..0b4267d4bb38 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -294,7 +294,7 @@ static bool perf_event_can_profile_kernel(void)
 	return perf_event_paranoid_check(1);
 }
 
-struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config)
+struct evsel *evsel__new_cycles(bool precise __maybe_unused, __u32 type, __u64 config)
 {
 	struct perf_event_attr attr = {
 		.type	= type,
@@ -305,18 +305,16 @@ struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config)
 
 	event_attr_init(&attr);
 
-	if (!precise)
-		goto new_event;
-
 	/*
 	 * Now let the usual logic to set up the perf_event_attr defaults
 	 * to kick in when we return and before perf_evsel__open() is called.
 	 */
-new_event:
 	evsel = evsel__new(&attr);
 	if (evsel == NULL)
 		goto out;
 
+	arch_evsel__fixup_new_cycles(&evsel->core.attr);
+
 	evsel->precise_max = true;
 
 	/* use asprintf() because free(evsel) assumes name is allocated */
@@ -1047,6 +1045,10 @@ void __weak arch_evsel__set_sample_weight(struct evsel *evsel)
 	evsel__set_sample_bit(evsel, WEIGHT);
 }
 
+void __weak arch_evsel__fixup_new_cycles(struct perf_event_attr *attr __maybe_unused)
+{
+}
+
 /*
  * The enable_on_exec/disabled value strategy:
  *
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 1f7edfa8568a..764e54c6a23d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -277,6 +277,7 @@ void __evsel__reset_sample_bit(struct evsel *evsel, enum perf_event_sample_forma
 void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
 
 void arch_evsel__set_sample_weight(struct evsel *evsel);
+void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr);
 
 int evsel__set_filter(struct evsel *evsel, const char *filter);
 int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
-- 
2.27.0

