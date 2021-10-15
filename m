Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A498F42F9FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbhJORYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbhJORXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:23:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033F7C061764
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:21:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y18-20020a25a092000000b005bddb39f160so10459925ybh.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XW2mCrDf1DUphwbsZwW9UQbbVujr91pVtxEQxiDp1EI=;
        b=NIPGrv9BA/LZYfiUo7NPjx8EdPL1MouxnBhCEzjFTW27A3qVWCmbH3hVxMbYCaY8gz
         XrtutPqUji9pJtmI5wWSjcx4Pz9UxpTorp+vLGEOPSmpa3550/iJbee6b0lB/Ff+iN0W
         /hjRngvvu62glxs6KqMVqLBcn1juprlgRgpt69qBE+X1+u+YRF2LApZB53yx5NTdGXog
         RODcv0FdV/1GEK9QpLbZJ3G0IBPlY3/bS1Zoqi5lSe6YFnva4+J7WJdLdPMkxT6EyfHF
         LrqMdjXjpHQixdesuUINS6xlXZo4h0O//7xtg+iTy9HjBZ9Fl5Ez+0ZDvrxhXLL5eyA1
         gjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XW2mCrDf1DUphwbsZwW9UQbbVujr91pVtxEQxiDp1EI=;
        b=ZdL36SFIVJyvyYUOEGHh37RyrEbXLvw0SmO+Jg3pWERaCMVeKlRvghq2+3TFEK5gdf
         3XffzZqXGNjWoCf7m/UvvIqefwIZkR9M/qFEEUfeaOOJ+uMK+3u7QQfZZjs4DgHJ8jJk
         7w7RBubTzV3tCmnqi0CiOZT/638XAnxpHA0WBtwNrhsq6k/so2irytoHqiTBVqpKPTXS
         6oKP3ak4C7PeYFJw+kI0VdFaUU8p6JlQrN7K5YCiXRSPznLn5fdvzUjJFfqNHOwCtfPP
         Br+d32HJq+yXW3i8l45tgaOP1EKDwQaHfrtsbhkH481oQWVzTQa0TdnLpKKEsOE1puOy
         PnDQ==
X-Gm-Message-State: AOAM530SivN9dfVdmixCFNlqDndwfKmC0t+A19Foa627maA6EKfOAaFh
        05KKMkYKGeUSab84OGmNz3MecGZZa91Z
X-Google-Smtp-Source: ABdhPJzql8UID52sHiRlvZQ979qtJqoOFqn8yZz6fXTYBFx1XPDbTQpVNwNVzHQv5qJfnQryYoW1RqO1B5Z8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a25:afcf:: with SMTP id
 d15mr13161012ybj.433.1634318505185; Fri, 15 Oct 2021 10:21:45 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:14 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-4-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 03/21] perf pmu: Make pmu_sys_event_tables const.
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make lookup nature of data structures clearer through their type.

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.c    | 2 +-
 tools/perf/pmu-events/pmu-events.h | 2 +-
 tools/perf/tests/pmu-events.c      | 2 +-
 tools/perf/util/pmu.c              | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 5624a37d6f93..a31de0f77097 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -832,7 +832,7 @@ static void print_mapping_test_table(FILE *outfp)
 
 static void print_system_event_mapping_table_prefix(FILE *outfp)
 {
-	fprintf(outfp, "\nstruct pmu_sys_events pmu_sys_event_tables[] = {");
+	fprintf(outfp, "\nconst struct pmu_sys_events pmu_sys_event_tables[] = {");
 }
 
 static void print_system_event_mapping_table_suffix(FILE *outfp)
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 42c6db6bedec..f6c9c9fc4ab2 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -54,6 +54,6 @@ struct pmu_sys_events {
  * table of PMU events.
  */
 extern const struct pmu_events_map pmu_events_map[];
-extern struct pmu_sys_events pmu_sys_event_tables[];
+extern const struct pmu_sys_events pmu_sys_event_tables[];
 
 #endif
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 8a1fdcd072f5..c0f8b61871c8 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -258,7 +258,7 @@ static const struct pmu_events_map *__test_pmu_get_events_map(void)
 
 static struct pmu_event *__test_pmu_get_sys_events_table(void)
 {
-	struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
+	const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
 
 	for ( ; tables->name; tables++) {
 		if (!strcmp("pme_test_soc_sys", tables->name))
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 4bcdc595ce5e..c04a89cc7cef 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -873,7 +873,7 @@ void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data)
 	int i = 0;
 
 	while (1) {
-		struct pmu_sys_events *event_table;
+		const struct pmu_sys_events *event_table;
 		int j = 0;
 
 		event_table = &pmu_sys_event_tables[i++];
-- 
2.33.0.1079.g6e70778dc9-goog

