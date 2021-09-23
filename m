Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5759B41598D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 09:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbhIWHtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 03:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239913AbhIWHsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:47 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3895C0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:47:01 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id bi14-20020a05620a318e00b00432f0915dd6so18116100qkb.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qlR5bzlOU/WjUFDG+HHwrsg3nYPORqGbaBaAZ8CvHrw=;
        b=nFr0Rc3HWv7Hyn7I+BZEmAagANmmJKrbjwLeQzvsKr5RGysFzKJil0w6Xylo/ACSjU
         G+DbAaUI4GM9h440leKCcbLtwz83sidh38yF8Xo+e3ycWa6vptOmXYDZNoq0OxKRQK7D
         AFYNG8sRYhcUaUqk+VlCcjJqm5cEpb8Wi355WVhYxXq1ijf6Nzm3mgxwEET++q6G0enR
         F8NyB+e+VHgIBexSNTB41S+IsF0TBZwriRV+paXgTdLGg/7wuA5jHeOlLAIhZfcQOdsa
         4hBWDAv7XAtQSzcZhgpgANU+h/l3ZIfw7ZlhAk3OsoBIygjeZilf6D+oqs4JOezkOuC5
         sHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qlR5bzlOU/WjUFDG+HHwrsg3nYPORqGbaBaAZ8CvHrw=;
        b=qyT7wXobIsuozEROCfMn9Yolt0FbN87QGKIvFksuj9G05DTwJwMqY0EN1Aay4aiReP
         neJN79TilDwjcph4DU9uJDwheuOyxnLNgAanUVCQRtNDQtaB/AVRYVogppHmhFZ7qaFA
         /MbJwa8a11gmeODTmCmVmM7fhzcv93AN/wDLGZ0wd2wgM13I2lAsYdNlaPm0vcRYd607
         znYTuqZMh1+fgl6G3ABkjJSzQe20EECVw09a0X7PurXUbKk91kuOa8t+nHhRp8308RDb
         3syFo4xzUSDckWf7sEAVQB+EVuzEJ8vTzccNC7hK5YUGG7HqsIKT1LjL4tBsqwYiynvt
         06ug==
X-Gm-Message-State: AOAM530Xi7kVUo+sX/KJTWxRWiqkGenrjmTklDQV/ugctmJf1gS7VyCz
        rhrFYrRTx2crmeBQwQsxubiQQr84O/01
X-Google-Smtp-Source: ABdhPJx8EbBywems0yzB+iMD8n/p1IntNrwGGx/ijNsUbvOH2vjE4/2dcjAlH+TLMmO5/Nzbmhw05wE0M7Wf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a05:6214:1444:: with SMTP id
 b4mr3024129qvy.33.1632383220886; Thu, 23 Sep 2021 00:47:00 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:14 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-12-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 11/13] perf expr: Propagate constants for binary operations
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we're computing ID values, if we have constant values then compute
the constant result. For example:
  1 + 2
Previously .val would be set to BOTTOM by union_expr, meaning that
all values are possible. With this change .val is set to 3.
Later changes will use the constant values to hopefully eliminate ID
values that don't need to be computed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 63 ++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 6aeead54760a..5a295e385914 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -68,6 +68,12 @@ static void expr_error(double *final_val __maybe_unused,
  */
 #define BOTTOM NAN
 
+/* During computing ids, does val represent a constant (non-BOTTOM) value? */
+static bool is_const(double val)
+{
+	return isfinite(val);
+}
+
 static struct ids union_expr(struct ids ids1, struct ids ids2)
 {
 	struct ids result = {
@@ -77,8 +83,15 @@ static struct ids union_expr(struct ids ids1, struct ids ids2)
 	return result;
 }
 
+/*
+ * If we're not computing ids or $1 and $3 are constants, compute the new
+ * constant value using OP. Its invariant that there are no ids.  If computing
+ * ids for non-constants union the set of IDs that must be computed.
+ */
 #define BINARY_LONG_OP(RESULT, OP, LHS, RHS)				\
-	if (!compute_ids) {						\
+	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
+		assert(LHS.ids == NULL);				\
+		assert(RHS.ids == NULL);				\
 		RESULT.val = (long)LHS.val OP (long)RHS.val;		\
 		RESULT.ids = NULL;					\
 	} else {							\
@@ -86,7 +99,9 @@ static struct ids union_expr(struct ids ids1, struct ids ids2)
 	}
 
 #define BINARY_OP(RESULT, OP, LHS, RHS)					\
-	if (!compute_ids) {						\
+	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
+		assert(LHS.ids == NULL);				\
+		assert(RHS.ids == NULL);				\
 		RESULT.val = LHS.val OP RHS.val;			\
 		RESULT.ids = NULL;					\
 	} else {							\
@@ -163,40 +178,52 @@ expr: NUMBER
 | expr '*' expr { BINARY_OP($$, *, $1, $3); }
 | expr '/' expr
 {
-	if (!compute_ids) {
-		if (fpclassify($3.val) == FP_ZERO) {
-			pr_debug("division by zero\n");
-			YYABORT;
-		}
+	if (fpclassify($3.val) == FP_ZERO) {
+		pr_debug("division by zero\n");
+		YYABORT;
+	} else if (!compute_ids || (is_const($1.val) && is_const($3.val))) {
+		assert($1.ids == NULL);
+		assert($3.ids == NULL);
 		$$.val = $1.val / $3.val;
 		$$.ids = NULL;
 	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
 		$$ = union_expr($1, $3);
 	}
 }
 | expr '%' expr
 {
-	if (!compute_ids) {
-		if (fpclassify($3.val) == FP_ZERO) {
-			pr_debug("division by zero\n");
-			YYABORT;
-		}
+	if (fpclassify($3.val) == FP_ZERO) {
+		pr_debug("division by zero\n");
+		YYABORT;
+	} else if (!compute_ids || (is_const($1.val) && is_const($3.val))) {
+		assert($1.ids == NULL);
+		assert($3.ids == NULL);
 		$$.val = (long)$1.val % (long)$3.val;
 		$$.ids = NULL;
 	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
 		$$ = union_expr($1, $3);
 	}
 }
 | D_RATIO '(' expr ',' expr ')'
 {
-	if (!compute_ids) {
+	if (fpclassify($5.val) == FP_ZERO) {
+		/*
+		 * Division by constant zero always yields zero and no events
+		 * are necessary.
+		 */
+		assert($5.ids == NULL);
+		$$.val = 0.0;
+		$$.ids = NULL;
+		ids__free($3.ids);
+	} else if (!compute_ids || (is_const($3.val) && is_const($5.val))) {
+		assert($3.ids == NULL);
+		assert($5.ids == NULL);
+		$$.val = $3.val / $5.val;
 		$$.ids = NULL;
-		if (fpclassify($5.val) == FP_ZERO) {
-			$$.val = 0.0;
-		} else {
-			$$.val = $3.val / $5.val;
-		}
 	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
 		$$ = union_expr($3, $5);
 	}
 }
-- 
2.33.0.464.g1972c5931b-goog

