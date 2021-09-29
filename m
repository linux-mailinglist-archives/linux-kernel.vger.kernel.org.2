Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3BE41CCF6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245398AbhI2T4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345790AbhI2T42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:56:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B8EC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:54:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p20-20020a25d814000000b005b6a75a370cso4903717ybg.14
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cmuN5/kREXwmVWvA5tkze8AF++qHoi0QEen4hqx19c0=;
        b=OQHtExlktX+92wICLzjUgzDTBZXxoI3WVRWnYw6oTo6d32fdZqoGi9IHUBAHn2oj4K
         0hEWVIRSE51HT1Gub1QEXkwvpqMapvSpu+7zFTA6mbFwdUDYBtpv11MP9+t2mz7GUoOC
         eG5GLlhPd3RaRKmPqJBEqsm71YNFDWgOOVJ02VaTkhiNNReE6wNfW7/T3lNQ0Hg2VVCs
         FNGOkLKPWKf1ikZO9FIaX41IvBC+fmkh14nYm520bJLVq9amS5HrOEYTZupjlaWM7zo+
         JKQayfjXJBiY6ruROIu96vOMlB6uF65BSL65cyEpzGn7EFzWTXdRD7QEcRetr5GWgqy3
         8JbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cmuN5/kREXwmVWvA5tkze8AF++qHoi0QEen4hqx19c0=;
        b=w4rOSp5JddbxeW7ztKUvBGrogR+UdMBIxL4tyq225hdJGt+t53EHNfl0BwimM75QAS
         s72Dh6z8AJW10d2usfHU/LhjnM091KJYyf2Nd+WUJ+dIHlDUVseE3j3qpHVdSck59BCQ
         XUbfs+TGKWicHYK353hTQUpAIqU8SUKnyPpstq3yrjE9ZKZGaWEKLPFVQXGCH2IWKO8q
         X9qRLp7rAnPjiqMpt8bA9plCc7T5YBppTXkgW89V1Z2vu/zvfCqOci9yaU6hFUExLIhb
         wrxjxu7SMqoDTkilU5GSlLb5MOPWGEFL7l0/kBYu2PzXvhlRoenoq9UCBzo4dN5XCyK6
         22AQ==
X-Gm-Message-State: AOAM531Vax39w70jxWL5eU2yWLx/sdBroOPZILWWjaLauz47mFYFWdpl
        MeuXHAtQF/rcZEaN6GhRzLPPLH+8d2CeKA==
X-Google-Smtp-Source: ABdhPJwDlPdBEhkctOrLWQ+LWC6bVlq6tpkkvhzzv0QqtngCuM4KIeiEpbL0u9KO8juX9vrO40pJog6erGTP4A==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:e473:7cd7:9986:85b7])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:102e:: with SMTP id
 x14mr2272641ybt.410.1632945285749; Wed, 29 Sep 2021 12:54:45 -0700 (PDT)
Date:   Wed, 29 Sep 2021 12:54:33 -0700
In-Reply-To: <20210929195436.1405996-1-dlatypov@google.com>
Message-Id: <20210929195436.1405996-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20210929195436.1405996-1-dlatypov@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 1/4] kunit: add 'kunit.action' param to allow listing out tests
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

Hack: we print a TAP header (but no test plan) to allow kunit.py to
use the same code to pick up KUnit output that it does for normal tests.
Since this is intended to be an implementation detail, it seems fine for
now. Maybe in the future we output each test as SKIPPED or the like.

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
Reviewed-by: David Gow <davidgow@google.com>
---
 lib/kunit/executor.c | 45 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index bab3ab940acc..ce1f57a44ab9 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -15,9 +15,16 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 #if IS_BUILTIN(CONFIG_KUNIT)
 
 static char *filter_glob_param;
+static char *action_param;
+
 module_param_named(filter_glob, filter_glob_param, charp, 0);
 MODULE_PARM_DESC(filter_glob,
 		"Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
+module_param_named(action, action_param, charp, 0);
+MODULE_PARM_DESC(action,
+		 "Changes KUnit executor behavior, valid values are:\n"
+		 "<none>: run the tests like normal\n"
+		 "'list' to list test names instead of running them.\n");
 
 /* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
 struct kunit_test_filter {
@@ -196,9 +203,35 @@ static void kunit_print_tap_header(struct suite_set *suite_set)
 	pr_info("1..%d\n", num_of_suites);
 }
 
-int kunit_run_all_tests(void)
+static void kunit_exec_run_tests(struct suite_set *suite_set)
 {
 	struct kunit_suite * const * const *suites;
+
+	kunit_print_tap_header(suite_set);
+
+	for (suites = suite_set->start; suites < suite_set->end; suites++)
+		__kunit_test_suites_init(*suites);
+}
+
+static void kunit_exec_list_tests(struct suite_set *suite_set)
+{
+	unsigned int i;
+	struct kunit_suite * const * const *suites;
+	struct kunit_case *test_case;
+
+	/* Hack: print a tap header so kunit.py can find the start of KUnit output. */
+	pr_info("TAP version 14\n");
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
@@ -207,10 +240,12 @@ int kunit_run_all_tests(void)
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
2.33.0.685.g46640cef36-goog

