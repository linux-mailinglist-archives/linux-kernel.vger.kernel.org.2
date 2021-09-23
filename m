Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F4A415987
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbhIWHsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 03:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239835AbhIWHsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:21 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FCEC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:46:49 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id c21-20020ac85195000000b002a540bbf1caso16533787qtn.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dTCV7YWIOb5NUrZqR0pgXW+ZL6gamk0NccGgryZgkiY=;
        b=D20W20c73dlsK/2BlqYB52FFagYFFzetx4U09I4lVDwriIZi2rtLgFCcWHK41Q7Cm1
         BgjIyeq/h3ueBegsmaurWbJ501T8WocP9CTC44yy5nZDdQ985aCH+8Rt7IjhfFrNeGFq
         mPXWdIS5l6jgs+tXHw4/5zbWwZE3QITlIm/KfZdStVcFOGrp3DaY/iUG8DHHA9m/WtQ9
         rGVhegtE8vIgFWUUfuPXZhebCDUAbq/nK+ISkYfbShJzYT4lN7yrbCqsmJk4q0SHXUVB
         gp38fA4BhsHUXLFDyJ9F9sBAFQU99gHEVdq+hmS8CzPRKNRdLNHLHF4yugcjZ//7q7ew
         hfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dTCV7YWIOb5NUrZqR0pgXW+ZL6gamk0NccGgryZgkiY=;
        b=Krvk4Qrftwj2FBEON+WMGsdP17qnGyxYwYtUhQZwpqlfz5UwGJJ6Lg3WhBrDQQThkj
         38NF4JtDJS5yK05wR5FgbEqymSH6DyWxlgyjLBL1cUT5JQOkt+qzEU+YJMxxD1aeq07r
         qXbR5auWsWgpdYFj2HiW3NBfJDj8oejv7Fep3LKjChx+DKxXBbslgAX6fmfZszsxIucC
         /XETrxvNOn4TqbSQ4OvXARjmlZLYgvK930nQx9nr325JS8Bny03dc83ZDPy0+en2TH2m
         stVH3l+An6hXH5XesD9w3iuHd1Ee0vTAJrjn/2mobdfetsYiYsfSG0U8DGUeLJm3v3y2
         L4/Q==
X-Gm-Message-State: AOAM531VEZyHPPjGJDgCkNK6ciEvKUtsA6VxYgbGhQwkEmbzJXQo/ZFF
        XQI2pO0Gpl/d4ymVeIqoBKNVNpYvHbAO
X-Google-Smtp-Source: ABdhPJwYOXb/bUVquxzTCQXoWai3VFLJ9Qlu6Z6viyB9trXkie2jQYT9M2XcpWDF3Kro7q1sGvmCqjdpJSbW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a25:9906:: with SMTP id
 z6mr4056639ybn.373.1632383208945; Thu, 23 Sep 2021 00:46:48 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:09 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-7-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 06/13] perf expr: Move actions to the left.
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

No functional change, just modifying whitespace. This creates additional
space for adding logic to actions in later changes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 124 +++++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 49 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 5535badeef0a..78cbe377eb0e 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -70,54 +70,80 @@ MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/
 '<' | '>' | D_RATIO
 
 all_expr: if_expr			{ *final_val = $1; }
-	;
-
-if_expr:
-	expr IF expr ELSE expr { $$ = $3 ? $1 : $5; }
-	| expr
-	;
-
-expr:	  NUMBER
-	| ID			{
-					struct expr_id_data *data;
-
-					$$ = NAN;
-					if (expr__resolve_id(ctx, $1, &data) == 0)
-						$$ = expr_id_data__value(data);
-
-					free($1);
-				}
-	| expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
-	| expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
-	| expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
-	| expr '<' expr { BINARY_OP($$, <, $1, $3); }
-	| expr '>' expr { BINARY_OP($$, >, $1, $3); }
-	| expr '+' expr { BINARY_OP($$, +, $1, $3); }
-	| expr '-' expr { BINARY_OP($$, -, $1, $3); }
-	| expr '*' expr { BINARY_OP($$, *, $1, $3); }
-	| expr '/' expr		{ if ($3 == 0) {
-					pr_debug("division by zero\n");
-					YYABORT;
-				  }
-				  $$ = $1 / $3;
-	                        }
-	| expr '%' expr		{ if ((long)$3 == 0) {
-					pr_debug("division by zero\n");
-					YYABORT;
-				  }
-				  $$ = (long)$1 % (long)$3;
-	                        }
-	| '-' expr %prec NEG	{ $$ = -$2; }
-	| '(' if_expr ')'	{ $$ = $2; }
-	| MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
-	| MAX '(' expr ',' expr ')' { $$ = $3 > $5 ? $3 : $5; }
-	| SMT_ON		 { $$ = smt_on() > 0; }
-	| D_RATIO '(' expr ',' expr ')' { if ($5 == 0) {
-						$$ = 0;
-					  } else {
-						$$ = $3 / $5;
-					  }
-					}
-	;
+
+if_expr: expr IF expr ELSE expr
+{
+	$$ = $3 ? $1 : $5;
+}
+| expr
+;
+
+expr: NUMBER
+{
+	$$ = $1;
+}
+| ID
+{
+	struct expr_id_data *data;
+
+	$$ = NAN;
+	if (expr__resolve_id(ctx, $1, &data) == 0)
+		$$ = expr_id_data__value(data);
+
+	free($1);
+}
+| expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
+| expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
+| expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
+| expr '<' expr { BINARY_OP($$, <, $1, $3); }
+| expr '>' expr { BINARY_OP($$, >, $1, $3); }
+| expr '+' expr { BINARY_OP($$, +, $1, $3); }
+| expr '-' expr { BINARY_OP($$, -, $1, $3); }
+| expr '*' expr { BINARY_OP($$, *, $1, $3); }
+| expr '/' expr
+{
+	if ($3 == 0) {
+		pr_debug("division by zero\n");
+		YYABORT;
+	}
+	$$ = $1 / $3;
+}
+| expr '%' expr
+{
+	if ((long)$3 == 0) {
+		pr_debug("division by zero\n");
+		YYABORT;
+	}
+	$$ = (long)$1 % (long)$3;
+}
+| D_RATIO '(' expr ',' expr ')'
+{
+	if ($5 == 0) {
+		$$ = 0;
+	} else {
+		$$ = $3 / $5;
+	}
+}
+| '-' expr %prec NEG
+{
+	$$ = -$2;
+}
+| '(' if_expr ')'
+{
+	$$ = $2;
+}
+| MIN '(' expr ',' expr ')'
+{
+	$$ = $3 < $5 ? $3 : $5;
+}
+| MAX '(' expr ',' expr ')'
+{
+	$$ = $3 > $5 ? $3 : $5;
+}
+| SMT_ON
+{
+	$$ = smt_on() > 0 ? 1.0 : 0.0;
+}
+;
 
 %%
-- 
2.33.0.464.g1972c5931b-goog

