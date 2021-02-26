Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF532632A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBZNNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:13:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12955 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZNNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:13:38 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Dn95P0X9PzjRpt;
        Fri, 26 Feb 2021 21:11:05 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Feb 2021 21:12:17 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <acme@kernel.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@redhat.com>, <namhyung@kernel.org>,
        <irogers@google.com>, <kjain@linux.ibm.com>, <ak@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] perf vendor events: Remove 'type' field from mapfiles
Date:   Fri, 26 Feb 2021 21:08:17 +0800
Message-ID: <1614344897-229717-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Included for each CPU entry in the per-arch mapfile.csv file is a 'type'
field.

However, it is never used in the jevents or any other code, and it has
been this way since commit 80eeb67fe577a ("perf jevents: Program to
convert JSON file"). Indeed, each entry so far just sets the field to
'core'.

So just remove it, as so far this has just caused confusion.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 0d609149b82a..4e6f934cd93d 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -1,5 +1,5 @@
 # Format:
-#	MIDR,Version,JSON/file/pathname,Type
+#	MIDR,Version,JSON/file/pathname
 #
 # where
 #	MIDR	Processor version
@@ -8,17 +8,16 @@
 #		but currently unused.
 #	JSON/file/pathname is the path to JSON file, relative
 #		to tools/perf/pmu-events/arch/arm64/.
-#	Type is core, uncore etc
 #
 #
-#Family-model,Version,Filename,EventType
-0x00000000410fd030,v1,arm/cortex-a53,core
-0x00000000420f1000,v1,arm/cortex-a53,core
-0x00000000410fd070,v1,arm/cortex-a57-a72,core
-0x00000000410fd080,v1,arm/cortex-a57-a72,core
-0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
-0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
-0x00000000420f5160,v1,cavium/thunderx2,core
-0x00000000430f0af0,v1,cavium/thunderx2,core
-0x00000000480fd010,v1,hisilicon/hip08,core
-0x00000000500f0000,v1,ampere/emag,core
+#Family-model,Version,Filename
+0x00000000410fd030,v1,arm/cortex-a53
+0x00000000420f1000,v1,arm/cortex-a53
+0x00000000410fd070,v1,arm/cortex-a57-a72
+0x00000000410fd080,v1,arm/cortex-a57-a72
+0x00000000410fd0b0,v1,arm/cortex-a76-n1
+0x00000000410fd0c0,v1,arm/cortex-a76-n1
+0x00000000420f5160,v1,cavium/thunderx2
+0x00000000430f0af0,v1,cavium/thunderx2
+0x00000000480fd010,v1,hisilicon/hip08
+0x00000000500f0000,v1,ampere/emag
diff --git a/tools/perf/pmu-events/arch/nds32/mapfile.csv b/tools/perf/pmu-events/arch/nds32/mapfile.csv
index efb395f26883..19937201e2e9 100644
--- a/tools/perf/pmu-events/arch/nds32/mapfile.csv
+++ b/tools/perf/pmu-events/arch/nds32/mapfile.csv
@@ -1,5 +1,5 @@
 # Format:
-#	MIDR,Version,JSON/file/pathname,Type
+#	MIDR,Version,JSON/file/pathname
 #
 # where
 #	MIDR	Processor version
@@ -8,8 +8,7 @@
 #		but currently unused.
 #	JSON/file/pathname is the path to JSON file, relative
 #		to tools/perf/pmu-events/arch/arm64/.
-#	Type is core, uncore etc
 #
 #
-#Family-model,Version,Filename,EventType
-0x0,v3,n13,core
+#Family-model,Version,Filename
+0x0,v3,n13
diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
index 229150e7ab7d..c5f19576a78c 100644
--- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
+++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
@@ -1,5 +1,5 @@
 # Format:
-# 	PVR,Version,JSON/file/pathname,Type
+# 	PVR,Version,JSON/file/pathname
 #
 # where
 # 	PVR	Processor version
@@ -7,11 +7,10 @@
 # 		but currently unused.
 # 	JSON/file/pathname is the path to JSON file, relative
 # 		to tools/perf/pmu-events/arch/powerpc/.
-# 	Type is core, uncore etc
 #
 # Multiple PVRs could map to a single JSON file.
 #
 
 # Power8 entries
-004[bcd][[:xdigit:]]{4},1,power8,core
-004e[[:xdigit:]]{4},1,power9,core
+004[bcd][[:xdigit:]]{4},1,power8
+004e[[:xdigit:]]{4},1,power9
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index 61641a3480e0..af86c7d6ecd0 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -1,7 +1,7 @@
-Family-model,Version,Filename,EventType
-^IBM.209[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z10,core
-^IBM.281[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z196,core
-^IBM.282[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_zec12,core
-^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13,core
-^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
-^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_z15,core
+Family-model,Version,Filename
+^IBM.209[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z10
+^IBM.281[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z196
+^IBM.282[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_zec12
+^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13
+^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14
+^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_z15
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 2f2a209e87e1..0b111954dea2 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,41 +1,41 @@
-Family-model,Version,Filename,EventType
-GenuineIntel-6-56,v5,broadwellde,core
-GenuineIntel-6-3D,v17,broadwell,core
-GenuineIntel-6-47,v17,broadwell,core
-GenuineIntel-6-4F,v10,broadwellx,core
-GenuineIntel-6-1C,v4,bonnell,core
-GenuineIntel-6-26,v4,bonnell,core
-GenuineIntel-6-27,v4,bonnell,core
-GenuineIntel-6-36,v4,bonnell,core
-GenuineIntel-6-35,v4,bonnell,core
-GenuineIntel-6-5C,v8,goldmont,core
-GenuineIntel-6-7A,v1,goldmontplus,core
-GenuineIntel-6-3C,v24,haswell,core
-GenuineIntel-6-45,v24,haswell,core
-GenuineIntel-6-46,v24,haswell,core
-GenuineIntel-6-3F,v17,haswellx,core
-GenuineIntel-6-3A,v18,ivybridge,core
-GenuineIntel-6-3E,v19,ivytown,core
-GenuineIntel-6-2D,v20,jaketown,core
-GenuineIntel-6-57,v9,knightslanding,core
-GenuineIntel-6-85,v9,knightslanding,core
-GenuineIntel-6-1E,v2,nehalemep,core
-GenuineIntel-6-1F,v2,nehalemep,core
-GenuineIntel-6-1A,v2,nehalemep,core
-GenuineIntel-6-2E,v2,nehalemex,core
-GenuineIntel-6-[4589]E,v24,skylake,core
-GenuineIntel-6-37,v13,silvermont,core
-GenuineIntel-6-4D,v13,silvermont,core
-GenuineIntel-6-4C,v13,silvermont,core
-GenuineIntel-6-2A,v15,sandybridge,core
-GenuineIntel-6-2C,v2,westmereep-dp,core
-GenuineIntel-6-25,v2,westmereep-sp,core
-GenuineIntel-6-2F,v2,westmereex,core
-GenuineIntel-6-55-[01234],v1,skylakex,core
-GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
-GenuineIntel-6-7D,v1,icelake,core
-GenuineIntel-6-7E,v1,icelake,core
-GenuineIntel-6-86,v1,tremontx,core
-AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
-AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
-AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen2,core
+Family-model,Version,Filename
+GenuineIntel-6-56,v5,broadwellde
+GenuineIntel-6-3D,v17,broadwell
+GenuineIntel-6-47,v17,broadwell
+GenuineIntel-6-4F,v10,broadwellx
+GenuineIntel-6-1C,v4,bonnell
+GenuineIntel-6-26,v4,bonnell
+GenuineIntel-6-27,v4,bonnell
+GenuineIntel-6-36,v4,bonnell
+GenuineIntel-6-35,v4,bonnell
+GenuineIntel-6-5C,v8,goldmont
+GenuineIntel-6-7A,v1,goldmontplus
+GenuineIntel-6-3C,v24,haswell
+GenuineIntel-6-45,v24,haswell
+GenuineIntel-6-46,v24,haswell
+GenuineIntel-6-3F,v17,haswellx
+GenuineIntel-6-3A,v18,ivybridge
+GenuineIntel-6-3E,v19,ivytown
+GenuineIntel-6-2D,v20,jaketown
+GenuineIntel-6-57,v9,knightslanding
+GenuineIntel-6-85,v9,knightslanding
+GenuineIntel-6-1E,v2,nehalemep
+GenuineIntel-6-1F,v2,nehalemep
+GenuineIntel-6-1A,v2,nehalemep
+GenuineIntel-6-2E,v2,nehalemex
+GenuineIntel-6-[4589]E,v24,skylake
+GenuineIntel-6-37,v13,silvermont
+GenuineIntel-6-4D,v13,silvermont
+GenuineIntel-6-4C,v13,silvermont
+GenuineIntel-6-2A,v15,sandybridge
+GenuineIntel-6-2C,v2,westmereep-dp
+GenuineIntel-6-25,v2,westmereep-sp
+GenuineIntel-6-2F,v2,westmereex
+GenuineIntel-6-55-[01234],v1,skylakex
+GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex
+GenuineIntel-6-7D,v1,icelake
+GenuineIntel-6-7E,v1,icelake
+GenuineIntel-6-86,v1,tremontx
+AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1
+AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2
+AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen2
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index e1f3f5c8c550..0edb5d40a88d 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -795,7 +795,6 @@ static void print_mapping_table_suffix(FILE *outfp)
 	fprintf(outfp, "{\n");
 	fprintf(outfp, "\t.cpuid = 0,\n");
 	fprintf(outfp, "\t.version = 0,\n");
-	fprintf(outfp, "\t.type = 0,\n");
 	fprintf(outfp, "\t.table = 0,\n");
 	fprintf(outfp, "},\n");
 
@@ -811,7 +810,6 @@ static void print_mapping_test_table(FILE *outfp)
 	fprintf(outfp, "{\n");
 	fprintf(outfp, "\t.cpuid = \"testcpu\",\n");
 	fprintf(outfp, "\t.version = \"v1\",\n");
-	fprintf(outfp, "\t.type = \"core\",\n");
 	fprintf(outfp, "\t.table = pme_test_cpu,\n");
 	fprintf(outfp, "},\n");
 }
@@ -876,7 +874,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
 
 	line_num = 1;
 	while (1) {
-		char *cpuid, *version, *type, *fname;
+		char *cpuid, *version, *fname;
 
 		line_num++;
 		p = fgets(line, n, mapfp);
@@ -898,23 +896,11 @@ static int process_mapfile(FILE *outfp, char *fpath)
 		cpuid = fixregex(strtok_r(p, ",", &save));
 		version = strtok_r(NULL, ",", &save);
 		fname = strtok_r(NULL, ",", &save);
-		type = strtok_r(NULL, ",", &save);
 
 		tblname = file_name_to_table_name(fname);
 		fprintf(outfp, "{\n");
 		fprintf(outfp, "\t.cpuid = \"%s\",\n", cpuid);
 		fprintf(outfp, "\t.version = \"%s\",\n", version);
-		fprintf(outfp, "\t.type = \"%s\",\n", type);
-
-		/*
-		 * CHECK: We can't use the type (eg "core") field in the
-		 * table name. For us to do that, we need to somehow tweak
-		 * the other caller of file_name_to_table(), process_json()
-		 * to determine the type. process_json() file has no way
-		 * of knowing these are "core" events unless file name has
-		 * core in it. If filename has core in it, we can safely
-		 * ignore the type field here also.
-		 */
 		fprintf(outfp, "\t.table = %s\n", tblname);
 		fprintf(outfp, "},\n");
 	}
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index d1172f6aebf1..82c0e0a18301 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -40,7 +40,6 @@ struct pmu_event {
 struct pmu_events_map {
 	const char *cpuid;
 	const char *version;
-	const char *type;		/* core, uncore etc */
 	struct pmu_event *table;
 };
 
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index 0e46aeb843ce..a7cc011dd7f8 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -196,7 +196,6 @@ static int expand_metric_events(void)
 	struct pmu_events_map ev_map = {
 		.cpuid		= "test",
 		.version	= "1",
-		.type		= "core",
 		.table		= pme_test,
 	};
 
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 6dc1db1626ad..64516fd92fac 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -81,7 +81,6 @@ static struct pmu_event pme_test[] = {
 static struct pmu_events_map map = {
 	.cpuid		= "test",
 	.version	= "1",
-	.type		= "core",
 	.table		= pme_test,
 };
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 0ca6a5a53523..1226b40ba06e 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -465,8 +465,8 @@ static void expr_failure(const char *msg,
 			 const struct pmu_events_map *map,
 			 const struct pmu_event *pe)
 {
-	pr_debug("%s for map %s %s %s\n",
-		msg, map->cpuid, map->version, map->type);
+	pr_debug("%s for map %s %s\n",
+		msg, map->cpuid, map->version);
 	pr_debug("On metric %s\n", pe->metric_name);
 	pr_debug("On expression %s\n", pe->metric_expr);
 }
-- 
2.26.2

