Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09FD32D7E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbhCDQed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:34:33 -0500
Received: from foss.arm.com ([217.140.110.172]:41094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238001AbhCDQeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:34:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B7B4113E;
        Thu,  4 Mar 2021 08:33:23 -0800 (PST)
Received: from e125528.arm.com (unknown [10.57.51.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC9AD3F766;
        Thu,  4 Mar 2021 08:33:17 -0800 (PST)
From:   Alexandre Truong <alexandre.truong@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Alexandre Truong <alexandre.truong@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Al Grant <al.grant@arm.com>, James Clark <james.clark@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>
Subject: [PATCH RESEND WITH CCs v3 3/4] perf tools: enable dwarf_callchain_users on aarch64
Date:   Thu,  4 Mar 2021 16:32:54 +0000
Message-Id: <20210304163255.10363-3-alexandre.truong@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210304163255.10363-1-alexandre.truong@arm.com>
References: <20210304163255.10363-1-alexandre.truong@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, enable dwarf_callchain_users which will be needed
to do a dwarf unwind in order to get the caller of the leaf frame.

Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Kemeng Shi <shikemeng@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Al Grant <al.grant@arm.com>
Cc: James Clark <james.clark@arm.com>
Cc: Wilco Dijkstra <wilco.dijkstra@arm.com>
---
 tools/perf/builtin-report.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2a845d6cac09..93661a3eaeb1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -405,6 +405,10 @@ static int report__setup_sample_type(struct report *rep)
 
 	callchain_param_setup(sample_type);
 
+	if (callchain_param.record_mode == CALLCHAIN_FP &&
+			strncmp(rep->session->header.env.arch, "aarch64", 7) == 0)
+		dwarf_callchain_users = true;
+
 	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
 			    "Please apply --call-graph lbr when recording.\n");
-- 
2.23.0

