Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF2432C949
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391972AbhCDBG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:06:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1453019AbhCDAlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:41:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BEFF64E60;
        Thu,  4 Mar 2021 00:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818442;
        bh=l/hN0ehnczctjJlGi5+wtahLMZm79eft33Johy8Os5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYaxQmGGooHVnLPY5hEHI7S0ZlNXMPxleN2fpT7jjUGgjnENkfQowErlKDWIqgq1I
         N9GpR4rWuJ/cvq4Om5spMof4miaJ620mR5rPtxitwkhlS7amftFbEYF4r4rtvlydLa
         WdEVBS9awEzoY5r7NKwNCDpomdmKroAApB/ozDVbgnfanKSPv4XW6LBz91ZySRBU8R
         UoKRUXl1NWXWP73Tv258rRJIAwEIecFGQfS0KNozt6rhOodPmqL9yhwk4YoB5zePHo
         +dj/Sm47oOAmKICvmees62ut1sITE7A3jdq/yC23xO+AzSwHd073EWOliYJ4rhjDiS
         NCNl3MicUFl9g==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 2/4] kcsan: Make test follow KUnit style recommendations
Date:   Wed,  3 Mar 2021 16:40:38 -0800
Message-Id: <20210304004040.25074-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Per recently added KUnit style recommendations at
Documentation/dev-tools/kunit/style.rst, make the following changes to
the KCSAN test:

	1. Rename 'kcsan-test.c' to 'kcsan_test.c'.

	2. Rename suite name 'kcsan-test' to 'kcsan'.

	3. Rename CONFIG_KCSAN_TEST to CONFIG_KCSAN_KUNIT_TEST and
	   default to KUNIT_ALL_TESTS.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/Makefile                       | 4 ++--
 kernel/kcsan/{kcsan-test.c => kcsan_test.c} | 2 +-
 lib/Kconfig.kcsan                           | 5 +++--
 3 files changed, 6 insertions(+), 5 deletions(-)
 rename kernel/kcsan/{kcsan-test.c => kcsan_test.c} (99%)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index 65ca553..c2bb07f 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -13,5 +13,5 @@ CFLAGS_core.o := $(call cc-option,-fno-conserve-stack) \
 obj-y := core.o debugfs.o report.o
 obj-$(CONFIG_KCSAN_SELFTEST) += selftest.o
 
-CFLAGS_kcsan-test.o := $(CFLAGS_KCSAN) -g -fno-omit-frame-pointer
-obj-$(CONFIG_KCSAN_TEST) += kcsan-test.o
+CFLAGS_kcsan_test.o := $(CFLAGS_KCSAN) -g -fno-omit-frame-pointer
+obj-$(CONFIG_KCSAN_KUNIT_TEST) += kcsan_test.o
diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan_test.c
similarity index 99%
rename from kernel/kcsan/kcsan-test.c
rename to kernel/kcsan/kcsan_test.c
index ebe7fd2..f16f632 100644
--- a/kernel/kcsan/kcsan-test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1156,7 +1156,7 @@ static void test_exit(struct kunit *test)
 }
 
 static struct kunit_suite kcsan_test_suite = {
-	.name = "kcsan-test",
+	.name = "kcsan",
 	.test_cases = kcsan_test_cases,
 	.init = test_init,
 	.exit = test_exit,
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index f271ff5..0440f37 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -69,8 +69,9 @@ config KCSAN_SELFTEST
 	  panic. Recommended to be enabled, ensuring critical functionality
 	  works as intended.
 
-config KCSAN_TEST
-	tristate "KCSAN test for integrated runtime behaviour"
+config KCSAN_KUNIT_TEST
+	tristate "KCSAN test for integrated runtime behaviour" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
 	depends on TRACEPOINTS && KUNIT
 	select TORTURE_TEST
 	help
-- 
2.9.5

