Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824A63DFC11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 09:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhHDH0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 03:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbhHDH0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 03:26:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A421CC061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 00:25:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i32-20020a25b2200000b02904ed415d9d84so2080305ybj.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wFXVwjyWGfQgIMZomutoD6Q8NQazpuACEt5r5XuS4+I=;
        b=b312wk1fFJZLEdrNi874u+c7lDcfJUvC4oJ+TKN8DglbZG6mfoJZM3WYsauV9op8B/
         /8rWH56bqPH20YmZPd/08q+vIaFSToPfXrN9qok0Qzi7G+dCra5Xslj9dJ72tcf9/6Ol
         xVSQgqGkX9Ax9Wg9j1nqjQaEo8lk6cU2xhhARq6lFAx0S5NADZ/Em2h+Zu65n5fS5p8k
         BFY7p5Nhn4asT5oZT014x9M5TiivwaZ5RwCLqUiv+MyaK69ueL9yM9oVYsg3JOhV+Zcf
         91URytPMk2W/IIbHx+6jCxRIKUqnI1RM9La/isb+gS5Bp+9t8aUEfzhF8LuVA1tUBizv
         amsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wFXVwjyWGfQgIMZomutoD6Q8NQazpuACEt5r5XuS4+I=;
        b=aa1pCkcc6OMWQP6DuWkEzUUGzJpX6GrxH8BxpR62/WMhj094qOFt9PeKX55WL2ke4x
         SnE5ClOCapELI1bS/O2/GIMzFAZpxhHsvUUeu4XaaEHulzCHLTOj/tvxt7sp8PbSv9jA
         SGz5ftmDp90C4mZVXAD2LKUiNsGWlkCiJxMOSAz8FGryFL7T4q6zjw8waoAl1Xl2e0gZ
         4R0ktPC+xqUBNvm8Hs6+ttfUlI5Hf+57cYSsPQw+NIph6dmmfCoKr9UJOD7787cpd763
         nzfnFJuQxSTOHewgmRRXQUVbknFYdncJY7nSKbfKe2v+BYqig2qSKoIwG23Z4zLy/vg9
         +9Jg==
X-Gm-Message-State: AOAM5306ZKW347cZsmXmxZZAGlcCUr2f9toCy5XU6Ro6xuR2CBYqLhqh
        ocP8KIDLi69dV8zsEEk0VSI/VB6CrQGY
X-Google-Smtp-Source: ABdhPJy9LNMega1xQeTpJyUFPV0eZ7pK2QxWD5u1+1i0pJg9MoEo7FIIVTQ/WApTZ2za6yx1d92FTFb4dUcn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:bfcb:f7e3:49a1:c031])
 (user=irogers job=sendgmr) by 2002:a5b:8cd:: with SMTP id w13mr25193445ybq.106.1628061952889;
 Wed, 04 Aug 2021 00:25:52 -0700 (PDT)
Date:   Wed,  4 Aug 2021 00:25:47 -0700
Message-Id: <20210804072547.1728924-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH] perf test: Make metric testing more robust.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing metric expressions we fake counter values from 1 going
upward. For some metrics this can yield negative values that are clipped
to zero, and then cause divide by zero failures. A workaround for this
case is to try a second time with counter values going in the opposite
direction.

This case was seen in a metric like:
  event1 / max(event2 - event3, 0)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index b8aff8fb50d8..6c1cd58605c1 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -600,8 +600,18 @@ static int test_parsing(void)
 			}
 
 			if (expr__parse(&result, &ctx, pe->metric_expr, 0)) {
-				expr_failure("Parse failed", map, pe);
-				ret++;
+				/*
+				 * Parsing failed, make numbers go from large to
+				 * small which can resolve divide by zero
+				 * issues.
+				 */
+				k = 1024;
+				hashmap__for_each_entry((&ctx.ids), cur, bkt)
+					expr__add_id_val(&ctx, strdup(cur->key), k--);
+				if (expr__parse(&result, &ctx, pe->metric_expr, 0)) {
+					expr_failure("Parse failed", map, pe);
+					ret++;
+				}
 			}
 			expr__ctx_clear(&ctx);
 		}
@@ -656,10 +666,20 @@ static int metric_parse_fake(const char *str)
 		}
 	}
 
-	if (expr__parse(&result, &ctx, str, 0))
-		pr_err("expr__parse failed\n");
-	else
-		ret = 0;
+	ret = 0;
+	if (expr__parse(&result, &ctx, str, 0)) {
+		/*
+		 * Parsing failed, make numbers go from large to small which can
+		 * resolve divide by zero issues.
+		 */
+		i = 1024;
+		hashmap__for_each_entry((&ctx.ids), cur, bkt)
+			expr__add_id_val(&ctx, strdup(cur->key), i--);
+		if (expr__parse(&result, &ctx, str, 0)) {
+			pr_err("expr__parse failed\n");
+			ret = -1;
+		}
+	}
 
 out:
 	expr__ctx_clear(&ctx);
-- 
2.32.0.554.ge1b32706d8-goog

