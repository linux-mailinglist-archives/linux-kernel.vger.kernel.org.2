Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F3E39CBF8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 02:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFFA5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 20:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhFFA5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 20:57:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF87C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 17:55:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 67-20020a2514460000b029053a9edba2a6so17517186ybu.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 17:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GHvR3Cn1ebKCJGAQ/YKMJtoF4rLgzfIVburfhTYFub0=;
        b=mB5L3xqaFi+nH1S2esE/5DEuLDnRmH39U8XLeJWuNSjHDNmU9jg49y8aJqxNMZoe/9
         v9G/dvo4pVfBCGocy5SY+KPDnpcUS88V7iz3SevYqqtpfdBtyY8j2cRpIqAb4m4S8aPf
         jPlKvLsCeJZd3F2oI4aR2INyxUBNijiIYLBFm5DIJvmrdDxb5ruifxoEKsl38YeGnQ5D
         29BoMm5Y0F69IdIF7SRpCuo4GsT7zEEOvBq4PzWCmB+aw/D2fGClAmR5w3KyeiAcJL7X
         JU+MmwGUVSZ7JazVU6I/VE98iR0OBN2rvZmKgXR/Wml9BdbR07pITffUy7L7Tln0wKe6
         mfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GHvR3Cn1ebKCJGAQ/YKMJtoF4rLgzfIVburfhTYFub0=;
        b=h7kxrw08k1AQFfp+SplUcxA9MPneWeI5poNLKQR5herFS46i04Zb9KhUydBbO01xh8
         qvVb8BV9htmgY4E8QkSOXpIOQXseLwOUxZeUJOesykLYwuH04t5XUc9wY+bP4LGsu7S0
         EOfNkIuBGGuJdTVJuTTyT5CKanyvEu3ksXZUn/gmJ+bUceWi7F0l1yGhY25HtuifIham
         Bjto/pYfcSmWYRCBlOR7U1wLE8avrdPSSl7DNdZaa5aO9SkjrQVTqvXZxQSIWQ9BYNuV
         oftod8a5kC/NZUWRxXQZgAXzqrlmXBtKoZ9JYMQHOcOIkb59Cb2eEFUGLLKzuckPxNOP
         Jz5g==
X-Gm-Message-State: AOAM533/hmKQY5duk5Xd8JXNbvYExaq0MSIHHS1I/8pwiRQrypagDLog
        DDnvgqmcGoWzZPyonMFfNGeMILNSoiI+/g==
X-Google-Smtp-Source: ABdhPJz0frOeV+p7ws7ArKvBWvQ7181HrSVewSMqL4CsdpPMY7oagmlm1RNRqjNk61nMRckzB9Zr0J8GQseyJw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:836b:eeb9:54f:d89a])
 (user=davidgow job=sendgmr) by 2002:a25:f20f:: with SMTP id
 i15mr14539079ybe.119.1622940934754; Sat, 05 Jun 2021 17:55:34 -0700 (PDT)
Date:   Sat,  5 Jun 2021 17:55:30 -0700
Message-Id: <20210606005531.165954-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3] kasan: test: Improve failure message in KUNIT_EXPECT_KASAN_FAIL()
From:   David Gow <davidgow@google.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Daniel Axtens <dja@axtens.net>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
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

Also update the example failure in the documentation to reflect this.

Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v2:
https://lkml.org/lkml/2021/6/4/1264
- Update the example error in the documentation

Changes since v1:
https://groups.google.com/g/kasan-dev/c/CbabdwoXGlE
- Remove fail_data.report_expected now that it's unused.
- Use '!' instead of '== false' in the comparison.
- Minor typo fixes in the commit message.

The test failure being used as an example is tracked in:
https://bugzilla.kernel.org/show_bug.cgi?id=213335



 Documentation/dev-tools/kasan.rst |  9 ++++-----
 include/linux/kasan.h             |  1 -
 lib/test_kasan.c                  | 11 +++++------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index d3f335ffc751..83ec4a556c19 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -447,11 +447,10 @@ When a test fails due to a failed ``kmalloc``::
 
 When a test fails due to a missing KASAN report::
 
-        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:629
-        Expected kasan_data->report_expected == kasan_data->report_found, but
-        kasan_data->report_expected == 1
-        kasan_data->report_found == 0
-        not ok 28 - kmalloc_double_kzfree
+        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:974
+        KASAN failure expected in "kfree_sensitive(ptr)", but none occurred
+        not ok 44 - kmalloc_double_kzfree
+
 
 At the end the cumulative status of all KASAN tests is printed. On success::
 
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

