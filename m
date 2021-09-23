Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F322D415986
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 09:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239915AbhIWHsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 03:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbhIWHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:18 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D6CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:46:47 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p23-20020a05620a22f700b003d5ac11ac5cso17742658qki.15
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CH2wfweYlXSkrBMY+EWAyo/kDd2ZFKaxNyUFDQse7Ek=;
        b=lIRkvIUn79NH9MvjfHE7pASLtyI67ldRrBLfsfDkbKKHT7As7IOGVlf+jIqhOczi6A
         Wgu8rNiH3P9HXgO6akmhbAQdF54t1TMqcr1Ygn4mdbr4adt3OToEPSE1ZO7YwXKzyosn
         l19lOmdPbBPwEamgCdaFEjTJ8C8hCL62sTYwRE3+4W++jMbgSt8C4LO254f9mDiuONeE
         6gqPJ0NklG1vZ5X8RjywO915pA4Hz/jDeLAWFmnCPI6OQS3IVMk6yGUxdWEKW0TcMdXn
         CibbiIbDmi6rW/q5syK5X+x5GrrPrjbVnMftAzyWHZQcf1GPhrXg3x37FXr2VEE6NBQG
         NN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CH2wfweYlXSkrBMY+EWAyo/kDd2ZFKaxNyUFDQse7Ek=;
        b=YAm0QFJd+OE6DHGXAfhOk3IaFSj5ltJXOy3eF0XTmrNxR5P10Oo0dN9WiNLDna9pxj
         rV5EUCThHmUpisivKKBaW8EKeRvD2ph8URtehhZ3dEkYC62GyqXiAV2jeWCs9coGHIxw
         LB/YW1NMPDxNpcD0NHYO8/ukT7BQdDb+Ztm/Xpbxja0pWN9sBz/NNvfqYcjAX5tH+YiK
         Nxje4nvu1t0UCuHag1AXFkl5gkHaLTLuuGg489uOO4ATqAlNgDha4852dcwvWHwOPmyo
         +sxLJ7r/0uzsTPOJUCFag+n3t3NmmiSJE2cw9Yxef238M8o0jwNPtTzxk8xylNuJ9xoU
         qJ/g==
X-Gm-Message-State: AOAM5333RMzHETGkMck96Xw7sUoyPyIheKg6zkZJsoPEteb62OLkhYH+
        DBA41L0oR68rcMLO51JQxm0EhrD9yIAT
X-Google-Smtp-Source: ABdhPJwEjkQ7FuNj4fQbf3vnT5ewzSpH6LKVZLyQL/zmTVlQRDWbSFylPe9T+77fbXHvY4hWbW6kgJuSVgZ9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a25:3086:: with SMTP id
 w128mr4257655ybw.139.1632383206601; Thu, 23 Sep 2021 00:46:46 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:08 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-6-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 05/13] perf expr: Use macros for operators
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

No functional change, switch the operators to use macros so that
additional complexity for constants can be added in a later change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 68b122e59b3f..5535badeef0a 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -43,6 +43,12 @@ static void expr_error(double *final_val __maybe_unused,
 	pr_debug("%s\n", s);
 }
 
+#define BINARY_LONG_OP(RESULT, OP, LHS, RHS)				\
+	RESULT = (long)LHS OP (long)RHS;
+
+#define BINARY_OP(RESULT, OP, LHS, RHS)					\
+	RESULT = LHS OP RHS;
+
 %}
 %%
 
@@ -81,14 +87,14 @@ expr:	  NUMBER
 
 					free($1);
 				}
-	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
-	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
-	| expr '^' expr		{ $$ = (long)$1 ^ (long)$3; }
-	| expr '<' expr		{ $$ = $1 < $3; }
-	| expr '>' expr		{ $$ = $1 > $3; }
-	| expr '+' expr		{ $$ = $1 + $3; }
-	| expr '-' expr		{ $$ = $1 - $3; }
-	| expr '*' expr		{ $$ = $1 * $3; }
+	| expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
+	| expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
+	| expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
+	| expr '<' expr { BINARY_OP($$, <, $1, $3); }
+	| expr '>' expr { BINARY_OP($$, >, $1, $3); }
+	| expr '+' expr { BINARY_OP($$, +, $1, $3); }
+	| expr '-' expr { BINARY_OP($$, -, $1, $3); }
+	| expr '*' expr { BINARY_OP($$, *, $1, $3); }
 	| expr '/' expr		{ if ($3 == 0) {
 					pr_debug("division by zero\n");
 					YYABORT;
-- 
2.33.0.464.g1972c5931b-goog

