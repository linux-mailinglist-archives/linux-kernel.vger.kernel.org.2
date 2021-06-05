Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63039C595
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 05:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFEDub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 23:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhFEDua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 23:50:30 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0D8C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 20:48:28 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id k125-20020a3788830000b02903a65618d46cso7952335qkd.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 20:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XPZDtLKS30vXkuj6yT8Gl5haFHJZ9BAHWp7Vy4vosPo=;
        b=TvjnijF0vPDLPSEaiTmZFU9TzbbKhy0hoiMyrAevNrBhCYahvldQr5j0W8oFB4ivfH
         KQZyj+izjiJof0v9yJBVk42uRcQTic9/Y9djD5Hnxshe+cNFZ8bAqnZ5c1UCtE8KnA7o
         jMbvXMjxRkLZHCWloXdYpJsuvrM6U5SKDGE/dGaj6+Xs5NigenABUX0iJk0zoRrMAnyl
         nP4FTi2k+qWCMay3CzCiiKt04z7c2Tb6xNyq5333dNk0LgyD1ESdXZu2qfWHJem8aN5P
         PX0FBlgh35reEx5nc7aAFM0lwH4LblEayEmPdcQXh6kmTGaEqARGRMB5CIMIuLthGXNo
         EHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XPZDtLKS30vXkuj6yT8Gl5haFHJZ9BAHWp7Vy4vosPo=;
        b=A6u65Us1mCfDmjKnTO0lwl2T88OrrRk2bI0uq/lWXlkc3fqrNrsA1iul1U20uOFRu8
         b3Bgpgjx3MBlpb/02sjTy0O2FE4FcsD19EXOVMqvNqoURbJn8jBi78GA+5wDXNf5R7eA
         2zlszs4FIHy+YJDqcb20VlsLo2T1rB26Bvcm0YVYe3r4PNsAwz3MX3IW5HfcZmQZDqyb
         F/8OR1n4dWaWaQ8yxkgVN+RTniLxl+Dg1S2krNCkHT3qsQwM2hZ4vvaF+ACwveNTtpAi
         e1X1FasRmQZP/Ey7S0UMIC5+RVRwoGelZG2UcAYMSIE4kRP5b9a89wfyoD2nR19mKk+v
         SYjw==
X-Gm-Message-State: AOAM530Ohgkhg3I/yoA1+zb7h1BLqescjWaRwsN7txulgSWyuP0eiUvF
        4gqx34k88c4mqNNgGZbOLzwcE+M0RoOxGA==
X-Google-Smtp-Source: ABdhPJz7cBjexK94rflz9gn4I2v/TXByvAjjxpfrYXkp022JYQ7GP4NKC9u3eMPyHNYy0+BU6AhML4QyipVcPw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:b70c:2182:75b0:bac0])
 (user=davidgow job=sendgmr) by 2002:a0c:dc92:: with SMTP id
 n18mr8063460qvk.8.1622864907203; Fri, 04 Jun 2021 20:48:27 -0700 (PDT)
Date:   Fri,  4 Jun 2021 20:48:21 -0700
Message-Id: <20210605034821.2098034-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v2] kasan: test: Improve failure message in KUNIT_EXPECT_KASAN_FAIL()
From:   David Gow <davidgow@google.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Daniel Axtens <dja@axtens.net>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KUNIT_EXPECT_KASAN_FAIL() macro currently uses KUNIT_EXPECT_EQ() to
compare fail_data.report_expected and fail_data.report_found. This
always gave a somewhat useless error message on failure, but the
addition of extra compile-time checking with READ_ONCE() has caused it
to get much longer, and be truncated before anything useful is displayed.

Instead, just check fail_data.report_found by hand (we've just set
report_expected to 'true'), and print a better failure message with
KUNIT_FAIL(). Because of this, report_expected is no longer used
anywhere, and can be removed.

Beforehand, a failure in:
KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)area)[3100]);
would have looked like:
[22:00:34] [FAILED] vmalloc_oob
[22:00:34]     # vmalloc_oob: EXPECTATION FAILED at lib/test_kasan.c:991
[22:00:34]     Expected ({ do { extern void __compiletime_assert_705(void) __attribute__((__error__("Unsupported access size for {READ,WRITE}_ONCE()."))); if (!((sizeof(fail_data.report_expected) == sizeof(char) || sizeof(fail_data.repp
[22:00:34]     not ok 45 - vmalloc_oob

With this change, it instead looks like:
[22:04:04] [FAILED] vmalloc_oob
[22:04:04]     # vmalloc_oob: EXPECTATION FAILED at lib/test_kasan.c:993
[22:04:04]     KASAN failure expected in "((volatile char *)area)[3100]", but none occurred
[22:04:04]     not ok 45 - vmalloc_oob

Signed-off-by: David Gow <davidgow@google.com>
---
Changes since v1:
https://groups.google.com/g/kasan-dev/c/CbabdwoXGlE
- Remove fail_data.report_expected now that it's unused.
- Use '!' instead of '== false' in the comparison.
- Minor typo fixes in the commit message.

The test failure being used as an example is tracked in:
https://bugzilla.kernel.org/show_bug.cgi?id=213335

Cheers,
-- David

 include/linux/kasan.h |  1 -
 lib/test_kasan.c      | 11 +++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index b1678a61e6a7..18cd5ec2f469 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -17,7 +17,6 @@ struct task_struct;
 
 /* kasan_data struct is used in KUnit tests for KASAN expected failures */
 struct kunit_kasan_expectation {
-	bool report_expected;
 	bool report_found;
 };
 
diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index cacbbbdef768..44e08f4d9c52 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -55,7 +55,6 @@ static int kasan_test_init(struct kunit *test)
 	multishot = kasan_save_enable_multi_shot();
 	kasan_set_tagging_report_once(false);
 	fail_data.report_found = false;
-	fail_data.report_expected = false;
 	kunit_add_named_resource(test, NULL, NULL, &resource,
 					"kasan_data", &fail_data);
 	return 0;
@@ -94,20 +93,20 @@ static void kasan_test_exit(struct kunit *test)
 	    !kasan_async_mode_enabled())				\
 		migrate_disable();					\
 	KUNIT_EXPECT_FALSE(test, READ_ONCE(fail_data.report_found));	\
-	WRITE_ONCE(fail_data.report_expected, true);			\
 	barrier();							\
 	expression;							\
 	barrier();							\
-	KUNIT_EXPECT_EQ(test,						\
-			READ_ONCE(fail_data.report_expected),		\
-			READ_ONCE(fail_data.report_found));		\
+	if (!READ_ONCE(fail_data.report_found)) {			\
+		KUNIT_FAIL(test, KUNIT_SUBTEST_INDENT "KASAN failure "	\
+				"expected in \"" #expression		\
+				 "\", but none occurred");		\
+	}								\
 	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {				\
 		if (READ_ONCE(fail_data.report_found))			\
 			kasan_enable_tagging_sync();			\
 		migrate_enable();					\
 	}								\
 	WRITE_ONCE(fail_data.report_found, false);			\
-	WRITE_ONCE(fail_data.report_expected, false);			\
 } while (0)
 
 #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {			\
-- 
2.32.0.rc1.229.g3e70b5a671-goog

