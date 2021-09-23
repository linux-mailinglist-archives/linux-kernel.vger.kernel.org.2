Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2EA415982
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 09:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbhIWHsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 03:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbhIWHsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:11 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9293BC061760
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:46:40 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d20-20020ac81194000000b002a53ffbd04dso15869380qtj.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0X+bRUj0ZqyVq9AjBewJSvN4Dct/DQ49eGdrq3G0ots=;
        b=f64qiW4sLGFTJCjmROAwqLNrF8ScIgWzcEMjevIjuuIu0L7GU8xz39XOY86aami4T7
         OwliwH4aL8ysE9bG68d/2vjS//FBViqBN58jMpKte/RJK2Rhq5tk7mShuQP7OgFHIZXk
         Zfbvg/vPnlcyczJxyhrgJv9GE9PM+h8V7qZlsVRRIfSgAec3Rnj5J2qn67EdwRhQU2Xm
         B2FY0o5u4rR/vOt6Wy77QzFZ2OOreoVkiPPMBFYktSTl06AGrPAS9zXlwfJEocdQOfqj
         /EIAHBOmW0XS/0LO8/xE/1BVqsOyKi6PjQWbWUtzv+mw5miKH3fCZ631jnkvV3EXQAaC
         guRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0X+bRUj0ZqyVq9AjBewJSvN4Dct/DQ49eGdrq3G0ots=;
        b=wtJWKMMI6JaiJ+V0pduwkaJLkkU8TfbhrofLLAWO3rkDyxiV9+eKXLer0MJllFGduf
         rpAALHz7NuTUHp5eQdInUO1vTQYJ44cPz9hyjN9QsZDS72LSucbeZSXTPKQTm8/qh9aY
         jKSZGS6rGIl05+V1diu59xieh6rZzypcOBYN5adbUAtN7/btEyGfPlMjg/Tkrqzlcn/O
         +9bZ3KLQc/NmspUtyKIdooQXfNtInY0iI2UP/eMKKHleuuHGwgeekqZ6q4AtOOWqJXAI
         6pZ8Lq7N0Q+ZdD4tHMeQQeF6l0qD6osyfPyvmGthf6VBQ/5nykepV2VR84pBm2+LkNeW
         9l0A==
X-Gm-Message-State: AOAM531obAghGL7CLGOHxNNRutN6MPpu7uuxs6LbtH1wqU+ZUUy8fXa6
        ZHAUJLOaQ1Yf5BJ/IRVpHdGfj4X4D/JL
X-Google-Smtp-Source: ABdhPJxI0faKprRZhdAuhU/Eybqorf8n6chKR04LikVRp9QhpULPNW75ezb1U/IwYQxtU5amjbaVu55x8QSL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a25:9941:: with SMTP id
 n1mr3997064ybo.247.1632383199627; Thu, 23 Sep 2021 00:46:39 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:05 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-3-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 02/13] perf metric: Use NAN for missing event IDs.
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

If during computing a metric an event (id) is missing the parsing
aborts. A later patch will make it so that events that aren't used in
the output are deliberately omitted, in which case we don't want the
abort. Modify the missing ID case to report NAN for these cases.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index b2ada8f8309a..41c9cd4efadd 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -1,6 +1,7 @@
 /* Simple expression parser */
 %{
 #define YYDEBUG 1
+#include <math.h>
 #include <stdio.h>
 #include "util.h"
 #include "util/debug.h"
@@ -88,12 +89,10 @@ expr:	  NUMBER
 	| ID			{
 					struct expr_id_data *data;
 
-					if (expr__resolve_id(ctx, $1, &data)) {
-						free($1);
-						YYABORT;
-					}
+					$$ = NAN;
+					if (expr__resolve_id(ctx, $1, &data) == 0)
+						$$ = expr_id_data__value(data);
 
-					$$ = expr_id_data__value(data);
 					free($1);
 				}
 	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
-- 
2.33.0.464.g1972c5931b-goog

