Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB5D42FA0B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242275AbhJORYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242271AbhJORYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:24:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4F6C061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s6-20020a254506000000b005b6b6434cd6so11860652yba.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n2qQN+jjLqArsxwfpJs8hFqSHgqyt/GIbderpbxzS8A=;
        b=H2pp7U/HRhuPEknq7viwmMK+MxyGHU4B/QBxj7YKOqXRQMk3t/jo5xwJTstCrT+u51
         Nh+Hn5+kWO6f7DOt8Fdqc8JJEvYQ41T7ebzlWHTkewL7gRrL2/IqQ7y1S9XcGNKix5Uc
         c92JLhWbgD2z9ZtRMuxyp4bdh4aLCk7p9ZAa2ik9oQ6VbiN+JaiucvvuyNodtGTXIEK9
         dziZXBtBr4lUZDrikf5Yq4bRN1pUuZq8ZbkIvGGqlOf35JeirBDm5lZrWqFk5t3PSt/M
         1hp9mavqTBhq1NTc9tZ5kSaqXrz972g9imxSiLKlrv8Sohx0+Av5HcO4OEz3fbE5IWHX
         oBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n2qQN+jjLqArsxwfpJs8hFqSHgqyt/GIbderpbxzS8A=;
        b=uztCx3ZH3MwMseVDGbQXkq4HmnNFWd7vWWQBzRYcZveQbifo4Q3Ls3i0A3cZ1G1RPI
         vlY8heCA95pe/TzFOGhG/+MDvZAlVxizktJRXmkazx/y1vgJGpA7IJn++4tjpg/s7YqL
         0pVfBctzsNBFwNzEK6vM7CrB/btLbu9zGAqhlhuY2hrl6uh5zaEPke/3vWBot4zYZcyM
         O8klwCh8hUToutajGfXx/xJLfcQ/zNh2ONAzBmx/14zygR4rM5F1Ouh5MII6ad4MTqGu
         CQcdCihuas2dDOW2yTjrEIatZoF1ZfOXae3VhspjaRmS9/JUJyfrTmL2wpA5A6WUWsEr
         aMyQ==
X-Gm-Message-State: AOAM532A0MvISULorAw5oP4S47mLKNgShgHs8aiyAk9pVIajEu5ksm8N
        a/mw8VHzVb+JIdYEJ5b6elxAT/vHLIRo
X-Google-Smtp-Source: ABdhPJwFQhaWqNbX/JUwqLb+gBlWg7HqhqGjVrcf8GQJLrkDm/1dMnmtiNOv6QtEJKz2/QPRMunMfF9ASUOb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a25:ccd0:: with SMTP id
 l199mr13546191ybf.430.1634318524141; Fri, 15 Oct 2021 10:22:04 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:22 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-12-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 11/21] perf metric: Document the internal 'struct metric'
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

Add documentation as part of code tidying.

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index c96f9fe163f9..632867cedbae 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -117,14 +117,34 @@ struct metric_ref_node {
 	struct list_head list;
 };
 
+/**
+ * The metric under construction. The data held here will be placed in a
+ * metric_expr.
+ */
 struct metric {
 	struct list_head nd;
+	/**
+	 * The expression parse context importantly holding the IDs contained
+	 * within the expression.
+	 */
 	struct expr_parse_ctx *pctx;
+	/** The name of the metric such as "IPC". */
 	const char *metric_name;
+	/** The expression to parse, for example, "instructions/cycles". */
 	const char *metric_expr;
+	/**
+	 * The "ScaleUnit" that scales and adds a unit to the metric during
+	 * output.
+	 */
 	const char *metric_unit;
+	/** The list of metrics referenced by this one. */
 	struct list_head metric_refs;
+	/** The size of the metric_refs list. */
 	int metric_refs_cnt;
+	/**
+	 * Is there a constraint on the group of events? In which case the
+	 * events won't be grouped.
+	 */
 	bool has_constraint;
 };
 
-- 
2.33.0.1079.g6e70778dc9-goog

