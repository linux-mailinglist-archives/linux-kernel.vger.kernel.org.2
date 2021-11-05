Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D10D446790
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhKERMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbhKERMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:12:43 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D086C061210
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:09:59 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id v63-20020a632f42000000b002cc65837088so6169397pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ga/JTvMFQ2vXfkZ6husQa1qKB1WqPSvSIWfyJShez0g=;
        b=QH2QS/D2usw9Eo983gIvl4iYDseLT6cegL944F3D4nhS8FMrjI+ggq8ZuSiMYoIcJn
         WEx3uYqpjjK0DToatE5ooK4PyA1Mleup5jeotXKrScI2oT9ywocheXzsk4ncjnmTSlR/
         PxCvrLv9x3P8UjZMGTTlKinuLKtiDhJCoq/Oec9XTvM98QC298yc4OACNVyjU6PicTi8
         kcWUbZSaMsmudZ2nC2cf7UBgsUUUpqD3WJDI+28XqYXH7gpARdPZSxUSPgZWoAHf3yDB
         xORPZv4MmaEaFhj4uhDGWKH74IvoOhnPMJ7/GhnVK6jM/RmxXNXWSRJQcnGBxfeanWjl
         7g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ga/JTvMFQ2vXfkZ6husQa1qKB1WqPSvSIWfyJShez0g=;
        b=mbVbRAXMk8nZFnivUMxxGvzyTy/s/2OmwZLi4BI3mo2jxL9Z3LnjNcROucY6KJYLJu
         dODYOpHm/4zzEFL4FbFUaA0sOEPYPONxhVuVobDefkqRixXxsKZ0LR+PShjWnDlW0lY4
         zunP6EuUJltQBtzuommMRI3NwGSXs33TXnzZZP5XIxRmwLHxPha9utzoZKbRbMT3pYNA
         ADrIOvroz39KpZO0v5cDSz/3Dht0mmrOd67o14oMc4iU3R+kMqeCbB0i+QcVMfEkX0OO
         n7T8CDcKFs7V4baWfAG0h9RhB99rCuDKQOSghWVo9cN45btDABvXgWwNAViG3907FiCj
         lqZw==
X-Gm-Message-State: AOAM533haDubv9mV0zUqQnHckRwmwkaCC6K+ZFxENaoF2naeJVyF9+4p
        2mVzb0oR0hKDw0/SYr4J3A1Ot3NG4rbR
X-Google-Smtp-Source: ABdhPJxbxlJD2Et9RoxMTNa6hDu2Bse0kzgfQIuu/SRGVsAE4wGo+cOA34qIKUY/I3r2wORQMxyvk5NEQ8eX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4cee:beb8:1744:5207])
 (user=irogers job=sendgmr) by 2002:a17:903:1248:b0:13f:cd7d:69eb with SMTP id
 u8-20020a170903124800b0013fcd7d69ebmr52836736plh.23.1636132198979; Fri, 05
 Nov 2021 10:09:58 -0700 (PDT)
Date:   Fri,  5 Nov 2021 10:09:41 -0700
In-Reply-To: <20211105170943.3479315-1-irogers@google.com>
Message-Id: <20211105170943.3479315-6-irogers@google.com>
Mime-Version: 1.0
References: <20211105170943.3479315-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 5/7] perf expr: Add literal values starting with #
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
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to have literal values for constants relating to
topologies, SMT, etc. Make the parsing of literals shared code and add a
lookup function. Move #smt_on to this function.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 11 +++++++++++
 tools/perf/util/expr.h |  1 +
 tools/perf/util/expr.l | 15 ++++++++++++++-
 tools/perf/util/expr.y |  9 ++++-----
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 77c6ad81a923..7464739c2890 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -9,9 +9,11 @@
 #include "expr.h"
 #include "expr-bison.h"
 #include "expr-flex.h"
+#include "smt.h"
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <ctype.h>
+#include <math.h>
 
 #ifdef PARSER_DEBUG
 extern int expr_debug;
@@ -370,3 +372,12 @@ double expr_id_data__value(const struct expr_id_data *data)
 	assert(data->kind == EXPR_ID_DATA__REF_VALUE);
 	return data->ref.val;
 }
+
+double expr__get_literal(const char *literal)
+{
+	if (!strcmp("#smt_on", literal))
+		return smt_on() > 0 ? 1.0 : 0.0;
+
+	pr_err("Unrecognized literal '%s'", literal);
+	return NAN;
+}
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index cf81f9166dbb..a6ab7f2b23d1 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -55,5 +55,6 @@ int expr__find_ids(const char *expr, const char *one,
 		   struct expr_parse_ctx *ids);
 
 double expr_id_data__value(const struct expr_id_data *data);
+double expr__get_literal(const char *literal);
 
 #endif
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index bd20f33418ba..cf6e3c710502 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -6,6 +6,7 @@
 #include <linux/compiler.h>
 #include "expr.h"
 #include "expr-bison.h"
+#include <math.h>
 
 char *expr_get_text(yyscan_t yyscanner);
 YYSTYPE *expr_get_lval(yyscan_t yyscanner);
@@ -77,6 +78,17 @@ static int str(yyscan_t scanner, int token, int runtime)
 	yylval->str = normalize(yylval->str, runtime);
 	return token;
 }
+
+static int literal(yyscan_t scanner)
+{
+	YYSTYPE *yylval = expr_get_lval(scanner);
+
+	yylval->num = expr__get_literal(expr_get_text(scanner));
+	if (isnan(yylval->num))
+		return EXPR_ERROR;
+
+	return LITERAL;
+}
 %}
 
 number		([0-9]+\.?[0-9]*|[0-9]*\.?[0-9]+)
@@ -85,6 +97,7 @@ sch		[-,=]
 spec		\\{sch}
 sym		[0-9a-zA-Z_\.:@?]+
 symbol		({spec}|{sym})+
+literal		#[0-9a-zA-Z_\.\-]+
 
 %%
 	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
@@ -94,7 +107,7 @@ max		{ return MAX; }
 min		{ return MIN; }
 if		{ return IF; }
 else		{ return ELSE; }
-#smt_on		{ return SMT_ON; }
+{literal}	{ return literal(yyscanner); }
 {number}	{ return value(yyscanner); }
 {symbol}	{ return str(yyscanner, ID, sctx->runtime); }
 "|"		{ return '|'; }
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index f969dfa525bd..ba6c6dbf30c8 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -4,7 +4,6 @@
 #include <assert.h>
 #include <math.h>
 #include "util/debug.h"
-#include "smt.h"
 #define IN_EXPR_Y 1
 #include "expr.h"
 %}
@@ -37,7 +36,7 @@
 	} ids;
 }
 
-%token ID NUMBER MIN MAX IF ELSE SMT_ON D_RATIO EXPR_ERROR
+%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO EXPR_ERROR
 %left MIN MAX IF
 %left '|'
 %left '^'
@@ -46,7 +45,7 @@
 %left '-' '+'
 %left '*' '/' '%'
 %left NEG NOT
-%type <num> NUMBER
+%type <num> NUMBER LITERAL
 %type <str> ID
 %destructor { free ($$); } <str>
 %type <ids> expr if_expr
@@ -280,9 +279,9 @@ expr: NUMBER
 		$$ = union_expr($3, $5);
 	}
 }
-| SMT_ON
+| LITERAL
 {
-	$$.val = smt_on() > 0 ? 1.0 : 0.0;
+	$$.val = $1;
 	$$.ids = NULL;
 }
 ;
-- 
2.34.0.rc0.344.g81b53c2807-goog

