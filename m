Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87364258A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243160AbhJGRAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243049AbhJGRAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:00:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29458C061775
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 09:58:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 124-20020a251182000000b005a027223ed9so8621130ybr.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 09:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tQGtWWtTqRuXJEGeXnD2fMFCcf930vEI3hAIZRuUuTM=;
        b=DI71ZP8nkwzUGGVqhR1N+ZnV9QTgS7kvddK78nZe8m9DdCl1q5b3CE5gu0erlKA2ag
         2ARPpuh7J+JRSiSeJ7ZRs1IdXtwfdQJsHYAJasGX/eBj02AJ82AuHNubht/mB8aamXcp
         5MdvIdRb+5bQ+37MbnlMZzNTKKt1o5kp2EvEzXmZBBk4E0lWBI0orXWhy+9FZeWtsPQ0
         DtKoFfqFdXvvjQ/yVY06MkRE1bKXnlSlKCiWT+Enpf0z+guCciGSpPmtYSIrtRjIFZ5P
         Hh/iKUoxUnFlM3NaNIyvex+iCobLyL4GzlJka9tVztzl0C+6lLtxjDpe5g1dNdkjfzDx
         eOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tQGtWWtTqRuXJEGeXnD2fMFCcf930vEI3hAIZRuUuTM=;
        b=J+QX6Y3lb3E+buYNgfoetoNr+CyO6YveifMEf8oPEAHKl4mVzx4QJejI/oTI1dpMv/
         1koTShwhWCTQfoOV5kIXDBqmTTOOTdrbsXaV5Qd3Bn8nE8lne5LPnLN9y8PWqq85Wl+l
         0vMwN1RGlghbI4D3mdiJytbhxlJ0zEHuyE66WF09D+mfgFp4ojMTqc9a1bqkAdmbSFxq
         +9aGifK0Im003PyGu9bUvfDgwniIB+yFSVzEMLPoCKCuqp/e4T0p9OSMo/hDYR+zsezV
         8lB3PCNkR16/BOi2LmKh9SpPIpU04I9d0AzYqyJOKcp68o6K4bER5875G5N0urJ78OcU
         KZbA==
X-Gm-Message-State: AOAM5339EJkeZxdRV+JiBfLTxaKu9poWAMZ2CGmVWgprgKTxSPHDzSDb
        eKuCI1SvkvFpmUkmiavpwbygxikW+DQP
X-Google-Smtp-Source: ABdhPJzv9QcmgN+d7/FOJgHqpbf99Dhu8lZzenGcjlRBLAKd75dVgdZdzlqactoMY/tzLqTfbSbYc1vxx1fs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:a25:50ca:: with SMTP id
 e193mr6238555ybb.135.1633625890267; Thu, 07 Oct 2021 09:58:10 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:43 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-18-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 17/21] perf expr: Add subset utility.
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper that returns true if all the IDs in needles are present in
haystack. Later this will be used in sharing events between metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 15 +++++++++++++++
 tools/perf/util/expr.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 5657222aaa25..77c6ad81a923 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -211,6 +211,21 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 	return hashmap__find(ctx->ids, id, (void **)data) ? 0 : -1;
 }
 
+bool expr__subset_of_ids(struct expr_parse_ctx *haystack,
+			 struct expr_parse_ctx *needles)
+{
+	struct hashmap_entry *cur;
+	size_t bkt;
+	struct expr_id_data *data;
+
+	hashmap__for_each_entry(needles->ids, cur, bkt) {
+		if (expr__get_id(haystack, cur->key, &data))
+			return false;
+	}
+	return true;
+}
+
+
 int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 		     struct expr_id_data **datap)
 {
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index c6e534f633c3..cf81f9166dbb 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -43,6 +43,8 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
 int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref);
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 		 struct expr_id_data **data);
+bool expr__subset_of_ids(struct expr_parse_ctx *haystack,
+			 struct expr_parse_ctx *needles);
 int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 		     struct expr_id_data **datap);
 
-- 
2.33.0.882.g93a45727a2-goog

