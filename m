Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D6D41598E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 09:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbhIWHt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 03:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbhIWHss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:48 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6830AC0613E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:47:06 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d20-20020ac81194000000b002a53ffbd04dso15872489qtj.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pMaOfLt+vkRQx0RPjtfU4NwNaK63mYgla1MP1EllA8c=;
        b=rHUFtH7+fh8D4nXJQx30emGYbrI/3qe6050g6PPZZPoA6l3zvxLSLjfKMKJNgugfIq
         ZmkwYHUdx8FnjnyTxIe2M2cmo2O5UQ9rR4pQYPLLdj8JXdfVTta8F2d222y5xheWWqx4
         fLY9znZVpFFHPRjW/QVYUf2uUfD92qtwnP0VoF3mk662kd7OIiA2sJi9h0Ckr/S9sgEC
         Q79W2IWaorHUFJYKscFxVbcXcJeIbcgwNP1eswCfpylMczjZJjMbA4b8ZEU8hVaecD8Z
         1BcOsi12mdXzySlarolIVADLIzIFwEHQVAan/U92/FphPBeIjaB9il5Mi49bQNZEMp7t
         Tjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pMaOfLt+vkRQx0RPjtfU4NwNaK63mYgla1MP1EllA8c=;
        b=NdtBzIzUUX83YtGZjCz4AdieFEKG1OZP4DdGC+NnDzYXYmSvkQUZb6cXF+UuKljFXn
         ARixQo5EdPgU8LID4jU4FUlNtxF5NU7sk0NcRXG46JLdl3AFwHfH9s8h1/dR9QrnWLzX
         qYrQxISUxG9tOY5wG8Sxo3al56DYD9zbNC/lxPOj4PCPGPgo5jU820RPOfdsJPXKBDtU
         NGy7HldMWgCYycB9aqJ2oZtQVd/iApwYNgJt4dv8A5PThDvLC+5hzOxHIaZ1QHsKExEt
         LHTRMt9MT22c+42etuapv2WwaUuvtKUEjenXxMacvNmQ02kqsRbTxAqY/secgru5sPGw
         mytA==
X-Gm-Message-State: AOAM530rxiBnr0vQ8WB5dtoI7ByDlqVzuSPOn/23jAnXuM8e5RMxAf6m
        w120TpZUX7UEu68aaZiNk2rRKTrvTnJJ
X-Google-Smtp-Source: ABdhPJyd9YRKKWvuoZrucIGYxZbbsdVke4KsPWjnifTKDkHc2R/7QWXr8n4ET10km/exXJKF3+n3GHxZWi7r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a05:6902:1504:: with SMTP id
 q4mr3970375ybu.219.1632383225560; Thu, 23 Sep 2021 00:47:05 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:16 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-14-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 13/13] perf metric: Avoid events for an 'if' constant result
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

For a metric like:
  CONST if expr else CONST

if the values of CONST are identical then expr doesn't need evaluating,
and events, in order to compute a result.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c |  7 +++++++
 tools/perf/util/expr.y  | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 287989321d2a..f1d8411fce12 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -143,6 +143,13 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 						  smt_on() ? "EVENT1" : "EVENT2",
 						  (void **)&val_ptr));
 
+	/* The expression is a constant 1.0 without needing to evaluate EVENT1. */
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("1.0 if EVENT1 > 100.0 else 1.0",
+			NULL, ctx, 0) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
+
 	expr__ctx_free(ctx);
 
 	return 0;
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 5b878f044f22..ba7d3b667fcb 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -142,6 +142,16 @@ if_expr: expr IF expr ELSE expr
 		$$.ids = $1.ids;
 		ids__free($3.ids);
 		ids__free($5.ids);
+	} else if ($1.val == $5.val) {
+		/*
+		 * LHS == RHS, so both are an identical constant. No need to
+		 * evaluate any events.
+		 */
+		$$.val = $1.val;
+		$$.ids = NULL;
+		ids__free($1.ids);
+		ids__free($3.ids);
+		ids__free($5.ids);
 	} else {
 		/*
 		 * Value is either the LHS or RHS and we need the IF expression
-- 
2.33.0.464.g1972c5931b-goog

