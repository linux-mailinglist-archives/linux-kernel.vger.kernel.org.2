Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BD1415984
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 09:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbhIWHs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 03:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239793AbhIWHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78D9C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:46:42 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w10-20020a0cb54a000000b0037a9848b92fso20362757qvd.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8/vLHEatF56tRYYCixJ8mAYibrjQPYFCtQw+LEHly14=;
        b=gUDOjpMu9NR33CwU3XttdZ64LFpA58kWGPBJQdBER5o3HnMNsP3eOqRijM67QvKUzB
         VAcOSaghYr2/ryY+u2UO3urQELtDAr4FRSAmTcSv4LIWiUfX6DXxrzkk+O8TkyY1y8Om
         AdyLMloA9JigBpp+3qXUfg/Gp8ZP3gzEdZdBFTDAnquI+7CGBvNqsZJWI+SJk1ymkmF8
         wDzqg1wzdkDq/PElxw7IQTWSN3ocKApyH9RecNiSA6xa2Yb8yZrWvlw/4BXzRAxsTnCy
         nRXUU2r4eeGUdC3+kGe9nt4nEEKVpd5EJLVATb0VTOmeO3z4B5SeR1q0usWFWYLpVvWj
         TXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8/vLHEatF56tRYYCixJ8mAYibrjQPYFCtQw+LEHly14=;
        b=iLrjpNYaLYeII50eGd4kAmJDHFHsuWF0QfACmQFCg5WFzh/nC6KiXsqiYopnLv0B+d
         Lcg7TmZQkPq6HAcLZWjzcpeWg3r5t1RtW27nXMhZHFXiG7hA3UomHPz9pGvT/XmuHqbZ
         ENFQAhfjppm3nC9ENB2Nju2X3r3pviMnZ8gl6VQF70exN0S5yTZFI2uk8znBq3BDZPcF
         lgFUE5PdA3UfNWHeNqVuoIhrJb/EgnLk+qKkA1nPEP/67ouns2BY1riAosdNXZQiNWo+
         nFZuxyROR4yOph1wCbGr1LTC3KdKiRAKeoTrr9YMZtoIwZxLhYQdfwpQ0+5JbGj6zxZP
         FFMA==
X-Gm-Message-State: AOAM531/BA/Xxovn6mlhJ2SLlVNo7C6pYzO5T4r2rgFmxoq/oCep6Cxg
        ul8dFHAqRCfu+OfXtsHH419PUguhzTvC
X-Google-Smtp-Source: ABdhPJzy5RwTHeXcf3z/dRJA8JYJBydsb1C6L52nMxSz6ECXeaaIGyHqE4grWc0cnRvz574Dg01pLj5fWPfb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a05:6214:1331:: with SMTP id
 c17mr3155570qvv.56.1632383202012; Thu, 23 Sep 2021 00:46:42 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:06 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-4-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 03/13] perf expr: Remove unused headers and inline d_ratio
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

No functional change. Inlining d_ratio makes it easier to special case
for constants in a later patch.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 41c9cd4efadd..e6005450feae 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -2,23 +2,10 @@
 %{
 #define YYDEBUG 1
 #include <math.h>
-#include <stdio.h>
-#include "util.h"
 #include "util/debug.h"
-#include <stdlib.h> // strtod()
+#include "smt.h"
 #define IN_EXPR_Y 1
 #include "expr.h"
-#include "smt.h"
-#include <string.h>
-
-static double d_ratio(double val0, double val1)
-{
-	if (val1 == 0) {
-		return 0;
-	}
-	return  val0 / val1;
-}
-
 %}
 
 %define api.pure full
@@ -120,7 +107,12 @@ expr:	  NUMBER
 	| MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
 	| MAX '(' expr ',' expr ')' { $$ = $3 > $5 ? $3 : $5; }
 	| SMT_ON		 { $$ = smt_on() > 0; }
-	| D_RATIO '(' expr ',' expr ')' { $$ = d_ratio($3,$5); }
+	| D_RATIO '(' expr ',' expr ')' { if ($5 == 0) {
+						$$ = 0;
+					  } else {
+						$$ = $3 / $5;
+					  }
+					}
 	;
 
 %%
-- 
2.33.0.464.g1972c5931b-goog

