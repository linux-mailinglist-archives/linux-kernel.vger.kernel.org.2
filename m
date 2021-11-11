Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5FC44CE3C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhKKAYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbhKKAYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:24:14 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10CDC061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:21:25 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q29-20020a631f5d000000b002dfcc4e0201so452545pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IIP3omaqBXw35Jy8B7vTYqW9trSeG0oUdyp8KTWGdgg=;
        b=MwNTRPkMMsZarvMublTXk0TdKu3x4B0Fs73wM803nCq92KpqssTxK2T2GxsVOhmTVA
         OUCLAQFhJV0OY0l4OkMd4DwAWQUavsnqgT9yl7NNAIyXHua2tTxqa6CXKZmRk4jZgJ3Z
         krDOPPTVvby+ZBVW+yzuY0U4NftS/aEKQRSxUHosXcyrtaGhdcgvuHlGxu9E1MC0oVwo
         PZf6GWOI+/ENwhqECL5BgPf6RbcTpU11RND9Z7taFP1jvenfc708fwqdUAcHaF4y9219
         fvN4ND8bbJorBVMDr9z7m5Vq3tHmvwtWXQSZUJgY6FM7P1Ezjx6h9SoWcDxLpa3FYBKm
         7q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IIP3omaqBXw35Jy8B7vTYqW9trSeG0oUdyp8KTWGdgg=;
        b=RmsMHOMcCXKwABw1o1f5fjxEKhxH25iBO2LKcLBHS8viHxOEr26InNqeTV3uP02Q6z
         SqNr8AoKJtbl98+8PbMSxlXuCmvkG0Ls7ruOXgXPRoq3RjZQoeZyO6bb9rA37BGEWl53
         h6ChJHoNNnHb1jqznZRnT6fM0EFdSOqC70XkvwmaKgaSFR3jWrijYU5iAAFkgzlArz5m
         DbtW8XG/MgKqQnfn/4xqjH9iMik5FokRfDJg4jLnt4xszFLT6V5Un9PiddtFOJxozIxV
         E6/1KHFpGHFHVGUMBDxbS/wMWsrJ/14qxE+HCxlY7Goi7b/rtMMSN1s2aSngNMI/y/mU
         kpGg==
X-Gm-Message-State: AOAM531PydLrPL6xmTRoMWozXvy08s7Od629zHa3Aac6od5bW8WB5HtL
        nzUkVLCpHRrCnNQxfxDPpHbCO0ErBGS0
X-Google-Smtp-Source: ABdhPJx6mTCra5xOG1QD9EK4C0RjCS8MjL5LRHWif2I8cCDNJo6OQTGGap1E9oIesuh9HpNA2ZJapVWOoo1v
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9510:b6b5:241:e409])
 (user=irogers job=sendgmr) by 2002:a63:88c2:: with SMTP id
 l185mr1953670pgd.168.1636590085413; Wed, 10 Nov 2021 16:21:25 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:21:06 -0800
In-Reply-To: <20211111002109.194172-1-irogers@google.com>
Message-Id: <20211111002109.194172-6-irogers@google.com>
Mime-Version: 1.0
References: <20211111002109.194172-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2 5/8] perf expr: Add literal values starting with #
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
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
2.34.0.rc1.387.gb447b232ab-goog

