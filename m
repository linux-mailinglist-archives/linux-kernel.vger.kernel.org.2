Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA208414EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbhIVR0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 13:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhIVR0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:26:02 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2E8C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 10:24:32 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r18-20020a056214069200b0037a291a6081so12723630qvz.18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eYmFyjQxJlLAih8817ANlmnPSTWsjS/u2nvqtL+z9+Y=;
        b=I17ESIifGUT777mMs0vxWBghGwJVlaVE20O69OixREeXEwLBOg/rXPqYptKmzC55eT
         8qK5gNqDhH98ueVCasOa8BXfMpZYlgy/dmZPWn0kxdyE8bfF9ZZdWqe3zBKL0Yuuf401
         B0rG96xc+06x8RyrkZBA/jW4+6/FHlkmAlqb6d7Ai/0fur8wrbUgSN3OaIYugLncJif9
         7cGMtNb2E17chaZ8gHuUO4aqD59MBJXNK4bLL5PM9uFbiqaWk7+dgk9NQC9QjuCIs42T
         nwaEKmjxBQxaxKRWmi7Wmdd6RF3iUeH0LpVLE+j7dnWcoztOL8CG8wz/HNyFoYt8WIbh
         L1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eYmFyjQxJlLAih8817ANlmnPSTWsjS/u2nvqtL+z9+Y=;
        b=cWHfOcQjT/yHa3K8wZ+1On8kSq1UGaabM8CMroVJ5RoOswt3V1MTGIDkA7QtTuHDpV
         EKcsUvojVG8v5sMxUbbuvRWRkUCnYXLfDPiLv+CtX/ii2x/JDfc9tPQQbTXuy5TacqS2
         pXGJ/XHcEhTZzKUp0qS/KYXzt3mcjdV6xr/uqIK/yM1LAo7jWgMZq+1azZ4mSmA969OP
         00ihCEAMo6PGX4oDZg6rUjWlxWjx0mEARdf9FUMpB+oNvZeZuX4d6pzkzBUUXm1POGsI
         jnGQtrJ/RWzWk+cCt9nj4kfEuduwUbdtxOVC6ZRQ4vDsa7PZOzp2SvoVD6tkmZg6cXtf
         pn5w==
X-Gm-Message-State: AOAM531k8KqFu478SiHpIFyleF43xeqMcc8TDpwMx7zssyMsjqdwwrUt
        lVW/SF8U9oe8iLivaghajDh+VRgUeVhK
X-Google-Smtp-Source: ABdhPJyTjx6VMtA6M/q+njx49v6Rp1/ItPKEMFUSCwQnP9Cak3Ek4KuWfJw311I8SZEYlyhCgCXw6impTb4K
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a25:c9c5:: with SMTP id
 z188mr321611ybf.223.1632331471582; Wed, 22 Sep 2021 10:24:31 -0700 (PDT)
Date:   Wed, 22 Sep 2021 10:24:27 -0700
Message-Id: <20210922172427.454376-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2] perf test: Make metric testing more robust.
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
to zero, and then cause divide by zero failures. Such clipping is
questionable but may be a result of tools automatically generating
metrics. A workaround for this case is to try a second time with counter
values going in the opposite direction.

This case was seen in a metric like:
  event1 / max(event2 - event3, 0)
But it may also happen in more sensible metrics like:
  event1 / (event2 + event3 - 1 - event4)

v2. Rebase and more detail in commit message.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 43743cf719ef..0ed11764cfab 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -891,8 +891,18 @@ static int test_parsing(void)
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
@@ -947,10 +957,20 @@ static int metric_parse_fake(const char *str)
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
2.33.0.464.g1972c5931b-goog

