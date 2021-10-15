Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB76342FA11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242367AbhJORZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242272AbhJORYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:24:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82868C0613E3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i83-20020a256d56000000b005b706d1417bso11969830ybc.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ehHQEfD5QF795LiWNu1NX0B6LCS/5JtCJ4EKdRcTYBI=;
        b=j90US0DFz1tmT/Uu1SLfE7Lv7Ue6pjlkJRmZkFtPKlbes51pt3GqiGcNwSBmlLmb+L
         HjFBduRPbQjsUXGhNFbHthZyPyr7Gcg2TLnzlDsqd7iWoKMiIHf1dfJ+suwLBUbJBa2V
         DnH1Rf1+PzyLZDc0bjpp2oZb5qN2MIXnFQ5EQQKzCdvX5sNcJqr3KyEiVSOP9cC25bzc
         JhN2TliQHI57R2r2VUXL5ibwviudL2OmYby9IYXjFv2/ir685UoMLqfX4vTjy0N27hpg
         e9Ei2pVdiQktA7FxFfh0Fjljpe+Rf2vybj2fklDpLChxrHL4jlig8DpnVQUcIqNIlHoc
         DFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ehHQEfD5QF795LiWNu1NX0B6LCS/5JtCJ4EKdRcTYBI=;
        b=urRPqezMNvgjP0zwbzbjsqVYmhYQor0Q9LJhnKRKYH7DktN8yVFWn1iBqDa3hC9sbV
         VvBR7A2w+w1BKVCQwEdHpy+52s2J1QeR/J0pd0/YIyKDJNur8rFY4mTKff6zefmaxerl
         qokIM0xetHg3JpOiNqlm5Pk5mx1ze7I4KvO0XkxVZ5KQ3FcnLIRdUe8DIZRz953wm38r
         gZ9wGfGKEY78SYS7Vny3QYbTGuzfkLxwF2/c4sk0ow1Htj4u1fxG5fWXVXiVEt1QbpqD
         5vtl3Ln3fQIT7kZ+Uq2MAg3ImxHxyaajA8zTtG6TqZozgIYtj53f2XoSBPs8eyfqIO0e
         j0LQ==
X-Gm-Message-State: AOAM532vyzJnJ8gUTyhZuniflZycgZ0p5sjgOQx3A8zrXEMt3daDeYI1
        /xnC7yBP5bIUkVQ95vVldSJ30yJKEm2B
X-Google-Smtp-Source: ABdhPJwc0qGJHldel/2iQhYmOIv1lBvvaR0ABQCNqCfnXjJHOViy+QQ07XVw5n3mNV4wi/KAtS3LCrhBzT/C
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a25:478b:: with SMTP id
 u133mr14382110yba.422.1634318538682; Fri, 15 Oct 2021 10:22:18 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:28 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-18-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 17/21] perf expr: Add subset utility.
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

Add a helper that returns true if all the IDs in needles are present in
haystack. Later this will be used in sharing events between metrics.

Acked-by: Andi Kleen <ak@linux.intel.com>
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
2.33.0.1079.g6e70778dc9-goog

