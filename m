Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3340542C7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbhJMRug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbhJMRtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:49:43 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8022C06177F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:47:00 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t12-20020a05621421ac00b00382ea49a7cbso3356405qvc.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jYnPKDnIb9jCABxSeWwyJlgAHHtqNSNz2hy+RZpbGhE=;
        b=hJp2h0IwFjqu+nL3q81nmAI5pQHAPZOKJQCAL4o/EAmqKA/hO+HFMInX3R9edpQ9sX
         MKbDnLHhmkx8s5sLOWEGjkIYbBQm+EKbY4TteYfPC4asXiMlrJqiHmlrtSDEqBJwYSSI
         M7yjN39o/09Uz6k9NvW4ifZwg5JFM/H+FNUSQtOFVO1WdbbJ5EiomZYb0ouX0Bu0Y6P9
         ATdkb45K7tqVjwqvQt968NGZC9jPKQUT3Ii1dQGj5aWI+qSaZTLL1mk5HJqWLTTTPjX1
         gSPAHJ7lyfv5JGW8obQevRwUbYFJKaO8f/fiP7OvRTlEQjX3b4ci1Y9VSGZTQppXs21T
         P2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jYnPKDnIb9jCABxSeWwyJlgAHHtqNSNz2hy+RZpbGhE=;
        b=BdxxlpAevjzUL+P25rW9NNJR37OjV+o8ggqu7WbVx2wFxAX0MFuR7pTlYGz6AF28jl
         P9SLs3Gc+vQsILzmMNeI3KCUeMTxV5owqD+5M0LE3WIN2lj8BsX2zKTtEyqimwYpM90L
         IPM422KYLMuSBLHewrxHzFtZSQLNO1YVsJl9NPfGcYQoyDTjnhrTpw/oKs8TPx2QBxGB
         cOSbJP0gvMHk+jRglRY9BeQr7BrZElf3qgNUoxSgFKlhGekC+/wcMxmuwUF/qZPuJ+HS
         2GjsDrFE72h+JAKxHExc45EHXIbzahjh9jBVnY4gqClyMsVG8fZQrK392fKcCpcYKRYf
         Bg4w==
X-Gm-Message-State: AOAM532Imm6vj9zwR1XoyXRvwPzyBnrGzWx806HGZdbfrEpXkQ+/tFsO
        If7Edfv/RTPCQA49LOfHDXsRuWZ6Y9Jm
X-Google-Smtp-Source: ABdhPJwhawtQy74eIQc8uAgxH0mmLE2Doh8/Z0rFmyveRN5kEDSg9YR7n/cBEdY4kh9FHviAsG8E0+xhtidq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:ac8:5784:: with SMTP id
 v4mr894472qta.42.1634147219959; Wed, 13 Oct 2021 10:46:59 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:58 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-17-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 16/22] perf test: bp tests use test case
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migration toward kunit style test cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/bp_account.c         | 7 ++++++-
 tools/perf/tests/bp_signal.c          | 7 ++++++-
 tools/perf/tests/bp_signal_overflow.c | 7 ++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 365120146d17..e4f7b635ffef 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -205,8 +205,13 @@ static bool test__bp_account_is_supported(void)
 #endif
 }
 
+static struct test_case bp_accounting_tests[] = {
+	TEST_CASE("Breakpoint accounting", bp_accounting),
+	{ .name = NULL, }
+};
+
 struct test_suite suite__bp_accounting = {
 	.desc = "Breakpoint accounting",
-	.func = test__bp_accounting,
+	.test_cases = bp_accounting_tests,
 	.is_supported = test__bp_account_is_supported,
 };
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 3c269f81818a..1676e3a11906 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -312,8 +312,13 @@ bool test__bp_signal_is_supported(void)
 #endif
 }
 
+static struct test_case bp_signal_tests[] = {
+	TEST_CASE("Breakpoint overflow signal handler", bp_signal),
+	{ .name = NULL, }
+};
+
 struct test_suite suite__bp_signal = {
 	.desc = "Breakpoint overflow signal handler",
-	.func = test__bp_signal,
+	.test_cases = bp_signal_tests,
 	.is_supported = test__bp_signal_is_supported,
 };
diff --git a/tools/perf/tests/bp_signal_overflow.c b/tools/perf/tests/bp_signal_overflow.c
index 5ac6e1393cf4..bc1f13851750 100644
--- a/tools/perf/tests/bp_signal_overflow.c
+++ b/tools/perf/tests/bp_signal_overflow.c
@@ -134,8 +134,13 @@ static int test__bp_signal_overflow(struct test_suite *test __maybe_unused, int
 	return fails ? TEST_FAIL : TEST_OK;
 }
 
+static struct test_case bp_signal_overflow_tests[] = {
+	TEST_CASE("Breakpoint overflow sampling", bp_signal_overflow),
+	{ .name = NULL, }
+};
+
 struct test_suite suite__bp_signal_overflow = {
 	.desc = "Breakpoint overflow sampling",
-	.func = test__bp_signal_overflow,
+	.test_cases = bp_signal_overflow_tests,
 	.is_supported = test__bp_signal_is_supported,
 };
-- 
2.33.0.882.g93a45727a2-goog

