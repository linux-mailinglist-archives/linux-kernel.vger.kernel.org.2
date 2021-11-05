Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4337144678B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhKERMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbhKERMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:12:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22242C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:09:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a25ac05000000b005c55592df4dso5995928ybi.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z0O3497izQrGzE+RqKqAfi71eKeDLbQ0+emHXSjNxus=;
        b=WrgOMrKMjZPLM7nMk6lChnpzCQIONGBrgE3he26bqeO2RzqC4TVOam4bD2gnphOyC3
         zW/VfJuZMPR3ynAXNZYnJtEHwYsx1fozSDhsKZ5BtgWzOq1DXKRWgtWbm++u2XeMsy3V
         GN3ZwOSf1uIH+JlJPViafrDhLm50MRIiy+dtRLR5sD3iUuCzugFZfTsmwZg2PMezar1e
         esV2PPLauUUq0vldALr18vpgHUt7Y9ps2umUk2hEE3epqJaW44eyMK8q7UU27O2WGJCq
         6AB6An76iUhXxCSgPBcA7ZTtwl/Q7400MiEUdCkqh3j1ynEotiGGVWRyJvCczQ+ajbmv
         xJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z0O3497izQrGzE+RqKqAfi71eKeDLbQ0+emHXSjNxus=;
        b=4yJWb+zy+5pE52tdtHrZ2EP29YlN82HKQoHYK2sU9kVwlEcvCwgeM26bMS+jZesxSd
         Je1zGqoMeuoUbRBanc6WQvYuZsBzV9T+JFmPd9ar+j86/ciFYzVeydbpBynHkuQbf/AU
         QpUC+0ImPKzflSKx/vaC3FNwbqJQt7LlsMo6CA7Lnkc8IdQAUyntw/+9ESN18hBWvEzu
         y3Kh2hq8jLqjWH8ogHE2BsMEgXuASgGi6mKl6pTqPJi8AOjJixoTSJrtemuaWU5zNBw2
         DDIhT8Shw04GCa3HVuH2Na20scfyGOdZa+GRXCR9E2nzcl/eakx1Eh1ZdnsPaBhcxb8G
         bUCw==
X-Gm-Message-State: AOAM533MeSsXq5KLwRru/MIHi9EHTJIIZXh6npncFwEYIrlc1csLC4wy
        Vh3+2HQYbamkIp7yIkjtdrrrJ5HhMIxF
X-Google-Smtp-Source: ABdhPJz60IBOqx0nkmjSLQqDEhkpU/OQKzLYO599+iSl9UaJoKUz284gVKoe2Vh67KpFF/mHb1uhjwvfC2CM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4cee:beb8:1744:5207])
 (user=irogers job=sendgmr) by 2002:a25:ab66:: with SMTP id
 u93mr5317341ybi.337.1636132190339; Fri, 05 Nov 2021 10:09:50 -0700 (PDT)
Date:   Fri,  5 Nov 2021 10:09:37 -0700
In-Reply-To: <20211105170943.3479315-1-irogers@google.com>
Message-Id: <20211105170943.3479315-2-irogers@google.com>
Mime-Version: 1.0
References: <20211105170943.3479315-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 1/7] perf test: Add expr test for events with hyphens
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

An example of such an event is topdown-fe-bound.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 077783223ce0..9ee2dc91c27b 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -134,6 +134,16 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT2,param=3@",
 						    (void **)&val_ptr));
 
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("dash\\-event1 - dash\\-event2",
+				       NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 2);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "dash-event1",
+						    (void **)&val_ptr));
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "dash-event2",
+						    (void **)&val_ptr));
+
 	/* Only EVENT1 or EVENT2 need be measured depending on the value of smt_on. */
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
-- 
2.34.0.rc0.344.g81b53c2807-goog

