Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EB336A997
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 23:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhDYVpT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Apr 2021 17:45:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13602 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231426AbhDYVpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 17:45:12 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13PLY3q3018801
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 14:44:32 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3853g8a7nc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 14:44:31 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Apr 2021 14:43:55 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id C0CF062E2330; Sun, 25 Apr 2021 14:43:48 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <acme@redhat.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <songliubraving@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v5 5/5] perf-stat: introduce bpf_counter_ops->disable()
Date:   Sun, 25 Apr 2021 14:43:33 -0700
Message-ID: <20210425214333.1090950-6-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210425214333.1090950-1-song@kernel.org>
References: <20210425214333.1090950-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7TsyWlJWDSzxrObmeriLsqe9I-XdrwZx
X-Proofpoint-GUID: 7TsyWlJWDSzxrObmeriLsqe9I-XdrwZx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-25_09:2021-04-23,2021-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104250162
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce bpf_counter_ops->disable(), which is used stop counting the
event.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/perf/util/bpf_counter.c | 26 ++++++++++++++++++++++++++
 tools/perf/util/bpf_counter.h |  7 +++++++
 tools/perf/util/evlist.c      |  4 ++++
 3 files changed, 37 insertions(+)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index f179f57430253..ddb52f748c8e8 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -215,6 +215,17 @@ static int bpf_program_profiler__enable(struct evsel *evsel)
 	return 0;
 }
 
+static int bpf_program_profiler__disable(struct evsel *evsel)
+{
+	struct bpf_counter *counter;
+
+	list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
+		assert(counter->skel != NULL);
+		bpf_prog_profiler_bpf__detach(counter->skel);
+	}
+	return 0;
+}
+
 static int bpf_program_profiler__read(struct evsel *evsel)
 {
 	// perf_cpu_map uses /sys/devices/system/cpu/online
@@ -280,6 +291,7 @@ static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu,
 struct bpf_counter_ops bpf_program_profiler_ops = {
 	.load       = bpf_program_profiler__load,
 	.enable	    = bpf_program_profiler__enable,
+	.disable    = bpf_program_profiler__disable,
 	.read       = bpf_program_profiler__read,
 	.destroy    = bpf_program_profiler__destroy,
 	.install_pe = bpf_program_profiler__install_pe,
@@ -627,6 +639,12 @@ static int bperf__enable(struct evsel *evsel)
 	return 0;
 }
 
+static int bperf__disable(struct evsel *evsel)
+{
+	evsel->follower_skel->bss->enabled = 0;
+	return 0;
+}
+
 static int bperf__read(struct evsel *evsel)
 {
 	struct bperf_follower_bpf *skel = evsel->follower_skel;
@@ -768,6 +786,7 @@ static int bperf__destroy(struct evsel *evsel)
 struct bpf_counter_ops bperf_ops = {
 	.load       = bperf__load,
 	.enable     = bperf__enable,
+	.disable    = bperf__disable,
 	.read       = bperf__read,
 	.install_pe = bperf__install_pe,
 	.destroy    = bperf__destroy,
@@ -806,6 +825,13 @@ int bpf_counter__enable(struct evsel *evsel)
 	return evsel->bpf_counter_ops->enable(evsel);
 }
 
+int bpf_counter__disable(struct evsel *evsel)
+{
+	if (bpf_counter_skip(evsel))
+		return 0;
+	return evsel->bpf_counter_ops->disable(evsel);
+}
+
 int bpf_counter__read(struct evsel *evsel)
 {
 	if (bpf_counter_skip(evsel))
diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
index cb9c532e0a079..d6d907c3dcf92 100644
--- a/tools/perf/util/bpf_counter.h
+++ b/tools/perf/util/bpf_counter.h
@@ -18,6 +18,7 @@ typedef int (*bpf_counter_evsel_install_pe_op)(struct evsel *evsel,
 struct bpf_counter_ops {
 	bpf_counter_evsel_target_op load;
 	bpf_counter_evsel_op enable;
+	bpf_counter_evsel_op disable;
 	bpf_counter_evsel_op read;
 	bpf_counter_evsel_op destroy;
 	bpf_counter_evsel_install_pe_op install_pe;
@@ -32,6 +33,7 @@ struct bpf_counter {
 
 int bpf_counter__load(struct evsel *evsel, struct target *target);
 int bpf_counter__enable(struct evsel *evsel);
+int bpf_counter__disable(struct evsel *evsel);
 int bpf_counter__read(struct evsel *evsel);
 void bpf_counter__destroy(struct evsel *evsel);
 int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
@@ -51,6 +53,11 @@ static inline int bpf_counter__enable(struct evsel *evsel __maybe_unused)
 	return 0;
 }
 
+static inline int bpf_counter__disable(struct evsel *evsel __maybe_unused)
+{
+	return 0;
+}
+
 static inline int bpf_counter__read(struct evsel *evsel __maybe_unused)
 {
 	return -EAGAIN;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d29a8a118973c..e71041c890102 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -17,6 +17,7 @@
 #include "evsel.h"
 #include "debug.h"
 #include "units.h"
+#include "bpf_counter.h"
 #include <internal/lib.h> // page_size
 #include "affinity.h"
 #include "../perf.h"
@@ -421,6 +422,9 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
 	if (affinity__setup(&affinity) < 0)
 		return;
 
+	evlist__for_each_entry(evlist, pos)
+		bpf_counter__disable(pos);
+
 	/* Disable 'immediate' events last */
 	for (imm = 0; imm <= 1; imm++) {
 		evlist__for_each_cpu(evlist, i, cpu) {
-- 
2.30.2

