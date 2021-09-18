Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813E3410472
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 08:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbhIRGh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 02:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbhIRGhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 02:37:08 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF93C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 23:35:43 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e6-20020ac84e46000000b0029baad9aaa0so102673730qtw.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 23:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MM9weOAXJkFMRdlpsJ2tVi3yPALgR9GzmZzrMn/EhJY=;
        b=eUU71ti4ArZoK/O9dYp2jofp3SUGRHhK8ptF9r6/U50bA620C5TbmRbbYjSmIMDlth
         Kcyu01Z2YfphZAtxbkNmx+g2UrUYEKU0baBmVz/OzQeai6UCS3wPW+VG/JYft4B2W0Kz
         QUnKL0UCHAZX3qB19nB3W8lEWSM2GY8THVULlaWdIfR8d2PpMVjoN0F/qUKCfFkwekH7
         pFl72iHmlaPz2/i8BoRVu3H3QWVA/Z9NPSGztYAtn21ds0LrYfyZa32KRk9vm2T+xTxX
         8kdIhDkv0ZwvG4EevvSdr2Dv4JxIg+bgXN9rTh8XMdSZSFXLwqyS4Si16SpXjTk0WIAJ
         5nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MM9weOAXJkFMRdlpsJ2tVi3yPALgR9GzmZzrMn/EhJY=;
        b=K76tQgVxsLBRT3VBuB2GgfANtXahxscwuZCNgoXuDpY32iJZVQkeaNm6C7UZ5q6ZPz
         2UdgMoNjojUnFlv/i9MAyq4Mjv3HL25ZqM9mLDz4w5YQkN3yoD6WjJalOWExnXIG/1I7
         sxZ+OrweSNtjJoUUy4BCj7yjFr/YWneJaFVeexhLoPTiVz6PixFheAmax+9QeppdaQXT
         VUto4Gx23RjBapc+hlA8r//1lxjGjgpTtOCMDK+AnURjZJTnImutUgRPXe0QhxkQWXjq
         BJ0B8xFS20MLkGR2F/byhpYg/LrQ2brbH8AasrwcDrdIwVsS4bbbtzayP0qGJLcoisef
         r9hg==
X-Gm-Message-State: AOAM530yxlSb32Gv2NJsu7S2NJeGtndJ3LLJ/9zOA1hBL5Nv5rih1sCE
        IcWL39Gm6gbAFUTOaSc0x3/gVqzpIlpT
X-Google-Smtp-Source: ABdhPJyT4qFwN6kOxlJ13d4O3gsJd+j+GCc8P+d8EdQaae4sNVoZ/jEMBXbGc0A0RTrGzM1wKFG2aDZl5Ipj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6399:5df3:21d3:3cca])
 (user=irogers job=sendgmr) by 2002:a05:6214:2e4:: with SMTP id
 h4mr15305382qvu.3.1631946942292; Fri, 17 Sep 2021 23:35:42 -0700 (PDT)
Date:   Fri, 17 Sep 2021 23:35:13 -0700
In-Reply-To: <20210918063513.2356923-1-irogers@google.com>
Message-Id: <20210918063513.2356923-9-irogers@google.com>
Mime-Version: 1.0
References: <20210918063513.2356923-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v8 8/8] perf test: Add metric test for eliminating events
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

Add test that ensures we remove events based on #smt_on, or if
evaluating the event has no impact on the output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 1c881bea7fca..5cab5960b257 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/debug.h"
 #include "util/expr.h"
+#include "util/smt.h"
 #include "tests.h"
 #include <stdlib.h>
 #include <string.h>
@@ -132,6 +133,22 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT2,param=3/",
 						    (void **)&val_ptr));
 
+	/* Only EVENT1 or EVENT2 need be measured depending on the value of smt_on. */
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("EVENT1 if #smt_on else EVENT2",
+				NULL, ctx, 0) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
+						  smt_on() ? "EVENT1" : "EVENT2",
+						  (void **)&val_ptr));
+
+	/* The expression is a constant 1.0 without needing to evaluate EVENT1. */
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("1.0 if EVENT1 > 100.0 else 1.0",
+				NULL, ctx, 0) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
 	expr__ctx_free(ctx);
 
 	return 0;
-- 
2.33.0.464.g1972c5931b-goog

