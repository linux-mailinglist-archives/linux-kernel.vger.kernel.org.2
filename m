Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0033CAFA4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 01:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhGOX1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 19:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhGOX1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:27:44 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6E6C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:24:49 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 81-20020a370b540000b02903b854c43335so4965983qkl.21
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xtzBKsfvMGcp1K3C06sE0keOSrupFddw8Qz1483rUH0=;
        b=evFhSvwfDnvoiWO1FssNjqss2R2cZZALzVhwgMv5oZwHKK5vctruLuY5M6ue3Ibi7z
         LJRY7c8SF0lTn82O8TKELaI36doUxZEQMkz4z3cpwyvXvQ+McSLAtXxR57VO5CMI5DfF
         U0xem9u/xRTAkGhaJempk2GOHrt03K5BvVXjBafZW1XEicfV+Fg5BrX+uSD/bXixzPjf
         MZEFgz54zrNhmrutQbOm8PC+mFDvMdn7Y7qKV3FW7y50+3YNT/CiZItEFarmZnw5G6p9
         Og5OFaJoZtY3H+nhjelXyu2V235QgVa6UA19EsyLyXaNgzQwUXEmSlRwTuJTTgOEFoOM
         eSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xtzBKsfvMGcp1K3C06sE0keOSrupFddw8Qz1483rUH0=;
        b=kuYfF8GuYonLsWE5qILpe5VTG4BP32umoXnhBPppPW7Tt3PjAc6eGtY9UmA92g5hdF
         OzZSkwcsSg49VDnZhRmA5w3SYe2Uf+uxYyYPhajL0KPVioELkqn8mDxnsrTebG76pH8J
         +R8Il54HwmNQqUEhHtPnq+3QAsw4Rr3B9/N9b5XZKiFN+TGuSBTLM6VUzYQIuEWQCgKD
         GD2wl0ehqogI0vRwXMyfOQca1RsdBFc7GaIA6PeJBI3qE1zHWVfUg4PaxcX2wBncwt33
         I6pR1kQOAtHLR8s7WN2xxqdM/+14zqxXaRHaCaDQUSWs7RHL7ebgf54ZNWsnoBMp8QIp
         Id3g==
X-Gm-Message-State: AOAM532tRrr64r5f5ClY5qvE9z7o1/Ou/mmHjVIf3Z9GVWnYuG583y93
        v9CmfC86M0THXlb/UZO/j3ucq8HnTs6M1Q==
X-Google-Smtp-Source: ABdhPJyk0KcyBbmeslmFmqYbL+2LRCFwjepnPlaN0C5SZtW0Tu6BpW2c6jZevl+Ya0lDw9kpl1oucUsx4cvS/g==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:24a2:4c13:4cc0:8818])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:186d:: with SMTP id
 eh13mr6867008qvb.35.1626391488871; Thu, 15 Jul 2021 16:24:48 -0700 (PDT)
Date:   Thu, 15 Jul 2021 16:24:41 -0700
Message-Id: <20210715232441.1380885-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH] lib/test: convert test_sort.c to use KUnit
From:   Daniel Latypov <dlatypov@google.com>
To:     akpm@linux-foundation.org
Cc:     pravin.shedge4linux@gmail.com, brendanhiggins@google.com,
        davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This follows up commit ebd09577be6c ("lib/test: convert
lib/test_list_sort.c to use KUnit").

Converting this test to KUnit makes the test a bit shorter, standardizes
how it reports pass/fail, and adds an easier way to run the test [1].

Like ebd09577be6c, this leaves the file and Kconfig option name the
same, but slightly changes their dependencies (needs CONFIG_KUNIT).

[1] Can be run via
$ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
CONFIG_KUNIT=y
CONFIG_TEST_SORT=y
EOF

[11:30:27] Starting KUnit Kernel ...
[11:30:30] ============================================================
[11:30:30] ======== [PASSED] lib_sort ========
[11:30:30] [PASSED] test_sort
[11:30:30] ============================================================
[11:30:30] Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
[11:30:30] Elapsed time: 37.032s total, 0.001s configuring, 34.090s building, 0.000s running

Note: this is the time it took after a `make mrproper`.

With an incremental rebuild, this looks more like:
[11:38:58] Elapsed time: 6.444s total, 0.001s configuring, 3.416s building, 0.000s running

Since the test has no dependencies, it can also be run (with some other
tests) with just:
$ ./tools/testing/kunit/kunit.py run

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/Kconfig.debug |  5 +++--
 lib/test_sort.c   | 40 +++++++++++++++++++---------------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 831212722924..a9f7097fbb86 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2078,8 +2078,9 @@ config TEST_MIN_HEAP
 	  If unsure, say N.
 
 config TEST_SORT
-	tristate "Array-based sort test"
-	depends on DEBUG_KERNEL || m
+	tristate "Array-based sort test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This option enables the self-test function of 'sort()' at boot,
 	  or at module load time.
diff --git a/lib/test_sort.c b/lib/test_sort.c
index 52edbe10f2e5..be02e3a098cf 100644
--- a/lib/test_sort.c
+++ b/lib/test_sort.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/test.h>
+
 #include <linux/sort.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -7,18 +10,17 @@
 
 #define TEST_LEN 1000
 
-static int __init cmpint(const void *a, const void *b)
+static int cmpint(const void *a, const void *b)
 {
 	return *(int *)a - *(int *)b;
 }
 
-static int __init test_sort_init(void)
+static void test_sort(struct kunit *test)
 {
-	int *a, i, r = 1, err = -ENOMEM;
+	int *a, i, r = 1;
 
-	a = kmalloc_array(TEST_LEN, sizeof(*a), GFP_KERNEL);
-	if (!a)
-		return err;
+	a = kunit_kmalloc_array(test, TEST_LEN, sizeof(*a), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a);
 
 	for (i = 0; i < TEST_LEN; i++) {
 		r = (r * 725861) % 6599;
@@ -27,24 +29,20 @@ static int __init test_sort_init(void)
 
 	sort(a, TEST_LEN, sizeof(*a), cmpint, NULL);
 
-	err = -EINVAL;
 	for (i = 0; i < TEST_LEN-1; i++)
-		if (a[i] > a[i+1]) {
-			pr_err("test has failed\n");
-			goto exit;
-		}
-	err = 0;
-	pr_info("test passed\n");
-exit:
-	kfree(a);
-	return err;
+		KUNIT_ASSERT_LE(test, a[i], a[i + 1]);
 }
 
-static void __exit test_sort_exit(void)
-{
-}
+static struct kunit_case sort_test_cases[] = {
+	KUNIT_CASE(test_sort),
+	{}
+};
+
+static struct kunit_suite sort_test_suite = {
+	.name = "lib_sort",
+	.test_cases = sort_test_cases,
+};
 
-module_init(test_sort_init);
-module_exit(test_sort_exit);
+kunit_test_suites(&sort_test_suite);
 
 MODULE_LICENSE("GPL");

base-commit: 8096acd7442e613fad0354fc8dfdb2003cceea0b
-- 
2.32.0.402.g57bb445576-goog

