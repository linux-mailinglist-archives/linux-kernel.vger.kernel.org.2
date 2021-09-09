Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F5040421A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348339AbhIIAMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348233AbhIIAMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:12:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E75C0613C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 17:11:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b84-20020a253457000000b0059e6b730d45so131883yba.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 17:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZRkA7X9CP3l5beQkJa8BoUDI4oCL6IQ1glt1mJkTtT4=;
        b=Vef2IVJOjGk+OzwOrQ+nU5PfmgVydwRU8TGLBffxUU0uOFRBIZR98a4gIDOhrQNj/M
         g6MXKBVc0dG1qcfdLiCxaAnj6nJsSlYyJqsSTMK8E9djS0DF1s52/5BXVP6MegJBjeQx
         sa9lH6QIDG5NtgzM3aVE66+OhpGzdplTwiTRMxk1KiwOaKcz44rlCr3+E9S0qudWhDRo
         jKqVpzs+CtElkIfCl+pMyYuZjBxbpd/8ccYyezIOAOzVit4eURbqMkgUo2jyuW1M+gy/
         /e/j2DJCaJ6Q2Kv226jKPLxDUZSb4OJcFykJEeuky7j53Ae7KH8NnvBqBiqF5qvVTPYd
         SXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZRkA7X9CP3l5beQkJa8BoUDI4oCL6IQ1glt1mJkTtT4=;
        b=4VjqDHGrh2GnI02NR3r5E2aEXGV9LiqkjjtV8oZg3CGpdrrenA3DiESUDrx/D/y6Po
         nI7n9OEQII3AUuQy+zVzPo28WQfEqowZqbh2AlLSyeulTzKj0ga2OnkMvK2Uyu2xOcC3
         q0bul5hVIT941onydKSDEKZeqRjl6N5sB3MeAdq5oq5/NPCplgFAV/KsHNk4O8/ssgX8
         in1yoIvoQTUncfTsmBuk278cNnrsQVSBhBUjw7Kwz8TIUuLk8WQrUKIbS68Qkoi5zjXU
         +25j/kaqbm4z1w3DV15qJ+1ymwz0jAbic1TMSLY4kCdscgIWsg3adI4WI041sy1fOEN1
         YNcg==
X-Gm-Message-State: AOAM531CWcphGkdU8N0N8hopatDYBC90tWSNt9eOE15D5djoaJiZ9gkL
        u1oo1vKr5eo4Bm5jv6XtPXsQEyLV1CBXvg==
X-Google-Smtp-Source: ABdhPJxCjBtKsCPNiXGUhr6V24T2WTYh78DvKqPmch/VaPghbmUyP1Gdpy8IvNfVSy/Hqbw62E0uvXp55cSueQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:68b6:f792:6cb6:9052])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:1029:: with SMTP id
 x9mr141039ybt.420.1631146269514; Wed, 08 Sep 2021 17:11:09 -0700 (PDT)
Date:   Wed,  8 Sep 2021 17:10:35 -0700
In-Reply-To: <20210909001037.2842954-1-dlatypov@google.com>
Message-Id: <20210909001037.2842954-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20210909001037.2842954-1-dlatypov@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 1/3] kunit: add 'kunit.action' param to allow listing out tests
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Context:
It's difficult to map a given .kunitconfig => set of enabled tests.
Letting kunit.py figure that out would be useful.

This patch:
* is intended to be an implementation detail used only by kunit.py
* adds a kunit.action module param with one valid non-null value, "list"
* for the "list" action, it simply prints out "<suite>.<test>"
* leaves the kunit.py changes to make use of this for another patch.

Note: kunit.filter_glob is respected for this and all future actions.

Hack: we print a TAP header and fake test plan to allow kunit.py to
use the same code to pick up KUnit output that it does for normal tests.
Since this is intended to be an implementation detail, it seems fine for
now. Maybe in the future we ouptut each test as SKIPPED or the like.

Go with a more generic "action" param, since it seems like we might
eventually have more modes besides just running or listing tests, e.g.
* perhaps a benchmark mode that reruns test cases and reports timing
* perhaps a deflake mode that reruns test cases that failed
* perhaps a mode where we randomize test order to try and catch
  hermeticity bugs like "test a only passes if run after test b"

Tested:
$ ./tools/testing/kunit/kunit.py run --kernel_arg=kunit.action=list --raw_output=kunit
...
TAP version 14
1..1
example.example_simple_test
example.example_skip_test
example.example_mark_skipped_test
reboot: System halted

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/executor.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 50aa73ebe0e6..4a3dd7c05245 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -202,9 +202,35 @@ static void kunit_print_tap_header(struct suite_set *suite_set)
 	pr_info("1..%d\n", num_of_suites);
 }
 
-int kunit_run_all_tests(void)
+static void kunit_exec_run_tests(struct suite_set *suite_set)
+{
+	struct kunit_suite * const * const *suites;
+
+	kunit_print_tap_header(suite_set);
+
+	for (suites = suite_set->start; suites < suite_set->end; suites++)
+		__kunit_test_suites_init(*suites);
+}
+
+static void kunit_exec_list_tests(struct suite_set *suite_set)
 {
+	unsigned int i;
 	struct kunit_suite * const * const *suites;
+	struct kunit_case *test_case;
+
+	/* Hack: print a tap header so kunit.py can find the start of KUnit output. */
+	kunit_print_tap_header(suite_set);
+
+	for (suites = suite_set->start; suites < suite_set->end; suites++)
+		for (i = 0; (*suites)[i] != NULL; i++) {
+			kunit_suite_for_each_test_case((*suites)[i], test_case) {
+				pr_info("%s.%s\n", (*suites)[i]->name, test_case->name);
+			}
+		}
+}
+
+int kunit_run_all_tests(void)
+{
 	struct suite_set suite_set = {
 		.start = __kunit_suites_start,
 		.end = __kunit_suites_end,
@@ -213,10 +239,12 @@ int kunit_run_all_tests(void)
 	if (filter_glob_param)
 		suite_set = kunit_filter_suites(&suite_set, filter_glob_param);
 
-	kunit_print_tap_header(&suite_set);
-
-	for (suites = suite_set.start; suites < suite_set.end; suites++)
-		__kunit_test_suites_init(*suites);
+	if (!action_param)
+		kunit_exec_run_tests(&suite_set);
+	else if (strcmp(action_param, "list") == 0)
+		kunit_exec_list_tests(&suite_set);
+	else
+		pr_err("kunit executor: unknown action '%s'\n", action_param);
 
 	if (filter_glob_param) { /* a copy was made of each array */
 		kunit_free_suite_set(suite_set);
-- 
2.33.0.309.g3052b89438-goog

