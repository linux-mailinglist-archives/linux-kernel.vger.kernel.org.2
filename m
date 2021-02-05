Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9093310DE5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 17:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhBEOvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:51:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:27370 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231321AbhBEOqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:46:46 -0500
IronPort-SDR: j+mRKnFtvjL6UDKMsmDZlAbaB+XsMy/lJ3qKid9xPCK+KHtX9/XfqqROleheQk1CfCOnIk2gyg
 ykPa7/BrkWDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="266280150"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="266280150"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 08:05:48 -0800
IronPort-SDR: TQyk3IkZ7Ia+hD4AAiWVXEgcNV/vxyfTAm+25v+c89BdMESEQefz4GCr6hbY367xgmTlZW5bDZ
 YHiPkt4VLw+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="373447094"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga008.fm.intel.com with ESMTP; 05 Feb 2021 08:05:47 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     atrajeev@linux.vnet.ibm.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf tools: Support arch specific PERF_SAMPLE_WEIGHT_STRUCT processing
Date:   Fri,  5 Feb 2021 08:01:52 -0800
Message-Id: <1612540912-6562-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

For X86, the var2_w field of PERF_SAMPLE_WEIGHT_STRUCT stands for the
instruction latency. Current perf forces the var2_w to the data->ins_lat
in the generic code. It works well for now because X86 is the only
architecture that supports the PERF_SAMPLE_WEIGHT_STRUCT, but it may
bring problems once other architectures support the sample type.
For example, the var2_w may be used to capture something else on
PowerPC.

Create two architecture specific functions to parse and synthesize
the weight related samples. Move the X86 specific codes to the X86
version functions. Other architectures can implement their own functions
later separately.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/event.c   | 25 +++++++++++++++++++++++++
 tools/perf/util/event.h            |  3 +++
 tools/perf/util/evsel.c            | 17 ++++++++---------
 tools/perf/util/synthetic-events.c | 12 +++++++-----
 4 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index 047dc00..9b31734 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -75,3 +75,28 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 }
 
 #endif
+
+void arch_perf_parse_sample_weight(struct perf_sample *data,
+				   const __u64 *array, u64 type)
+{
+	union perf_sample_weight weight;
+
+	weight.full = *array;
+	if (type & PERF_SAMPLE_WEIGHT)
+		data->weight = weight.full;
+	else {
+		data->weight = weight.var1_dw;
+		data->ins_lat = weight.var2_w;
+	}
+}
+
+void arch_perf_synthesize_sample_weight(const struct perf_sample *data,
+					__u64 *array, u64 type)
+{
+	*array = data->weight;
+
+	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
+		*array &= 0xffffffff;
+		*array |= ((u64)data->ins_lat << 32);
+	}
+}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 60752e4..9f123aa 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -414,4 +414,7 @@ extern unsigned int proc_map_timeout;
 #define PAGE_SIZE_NAME_LEN	32
 char *get_page_size_name(u64 size, char *str);
 
+void arch_perf_parse_sample_weight(struct perf_sample *data, const __u64 *array, u64 type);
+void arch_perf_synthesize_sample_weight(const struct perf_sample *data, __u64 *array, u64 type);
+
 #endif /* __PERF_RECORD_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 30b5452..1da8903 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2106,6 +2106,13 @@ perf_event__check_size(union perf_event *event, unsigned int sample_size)
 	return 0;
 }
 
+void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
+					  const __u64 *array,
+					  u64 type __maybe_unused)
+{
+	data->weight = *array;
+}
+
 int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			struct perf_sample *data)
 {
@@ -2347,16 +2354,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	}
 
 	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
-		union perf_sample_weight weight;
-
 		OVERFLOW_CHECK_u64(array);
-		weight.full = *array;
-		if (type & PERF_SAMPLE_WEIGHT)
-			data->weight = weight.full;
-		else {
-			data->weight = weight.var1_dw;
-			data->ins_lat = weight.var2_w;
-		}
+		arch_perf_parse_sample_weight(data, array, type);
 		array++;
 	}
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index c6f9db3..412f4c3 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1507,6 +1507,12 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	return result;
 }
 
+void __weak arch_perf_synthesize_sample_weight(const struct perf_sample *data,
+					       __u64 *array, u64 type __maybe_unused)
+{
+	*array = data->weight;
+}
+
 int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format,
 				  const struct perf_sample *sample)
 {
@@ -1643,11 +1649,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 	}
 
 	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
-		*array = sample->weight;
-		if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
-			*array &= 0xffffffff;
-			*array |= ((u64)sample->ins_lat << 32);
-		}
+		arch_perf_synthesize_sample_weight(sample, array, type);
 		array++;
 	}
 
-- 
2.7.4

