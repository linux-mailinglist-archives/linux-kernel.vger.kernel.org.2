Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FE145455F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 12:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhKQLM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 06:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbhKQLMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 06:12:25 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BFFC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 03:09:26 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso2686122wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 03:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9taf4pcDDL8ZRr8QtehQRp327fUKjZJHKOwSYb8Gk0w=;
        b=sBRFbICWZPYUZ50hE5OAaZtyFLxiooBBZ0pFKbWrkqhO2PngGbFIFfGNSsWBxOxNL9
         GKnU14KQ6vv06Pg4qGp4oye/2kHN+ZuyhnJUBTWfZ5cf+506nJMxZq3KOMsFX1QZRnzC
         AqS4WMFTLT5Oq05Du2T883L6PEE6psSeTSCcIRuiXXAWfYG8m7MzHt1Rb8dJVzm2pomJ
         ZlYtSiLmEYu7ePYTe+j9t57XXvDZhnxIBJ8S9M3jDLrc8XCJp/vHFYRCnztiDmhUy2kx
         fPwmZTwpv1rYw3rypnFUKo0Qk5D2mRWNkUCLdRSY1j9/zajVcCDfPFXYqqdBDCMWgWAb
         BOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9taf4pcDDL8ZRr8QtehQRp327fUKjZJHKOwSYb8Gk0w=;
        b=sJJJj4ggVLmbbx5y9gj6EXH5YU4dyx9BWzpMTbyMyr2qfsNCz9d+MuSqVgyxJ5LkEM
         ZfO8qvLk8ttqr1ayFnSeTvtKxKBb3QPMnoX+e8QEom/5Gcps57XyWpSQzQPAB9ntsZFq
         NQsrCU0++ixSyVoll/xzjx90jv6lkPCab9U6XyY+cpVkJK3TVoAt4JkLni7wrCjP0p1q
         AuCmjFXmtY3NQ3ebOMR/EHRWT8HZ6KrzQ/cR6qy52v8FP12utR6jlq/62RlUnVtL3Zer
         uVThqt4iycdiRoN+jXg+XDo46JRZ4Bhp7rv9T4vGxrv8YV0O619bXUy1qCyNI6vkhzZq
         AD8A==
X-Gm-Message-State: AOAM5301EL/KjxFiceC/o2TKm5JTiKhpj0ruUQma4ezs1ifXDVrPCsCd
        4K7EweIH+w5SfmGwiDZVAMG2Gben9Q==
X-Google-Smtp-Source: ABdhPJyDoLkrFyRZ+xSL7lowBi50Bs7Xbn6xBWOipL4CkZhKDFfQld24YCcWtJPZ+VYkOkwh9kiQnGMQOw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:80aa:59e4:a6a7:e11e])
 (user=elver job=sendgmr) by 2002:a1c:9dc6:: with SMTP id g189mr16624727wme.87.1637147365103;
 Wed, 17 Nov 2021 03:09:25 -0800 (PST)
Date:   Wed, 17 Nov 2021 12:09:16 +0100
Message-Id: <20211117110916.97944-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] kasan: test: add globals left-out-of-bounds test
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test checking that KASAN generic can also detect out-of-bounds
accesses to the left of globals.

Unfortunately it seems that GCC doesn't catch this (tested GCC 10, 11).
The main difference between GCC's globals redzoning and Clang's is that
GCC relies on using increased alignment to producing padding, where
Clang's redzoning implementation actually adds real data after the
global and doesn't rely on alignment to produce padding. I believe this
is the main reason why GCC can't reliably catch globals out-of-bounds in
this case.

Given this is now a known issue, to avoid failing the whole test suite,
skip this test case with GCC.

Reported-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 lib/test_kasan.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 67ed689a0b1b..69c32c91420b 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -700,7 +700,7 @@ static void kmem_cache_bulk(struct kunit *test)
 
 static char global_array[10];
 
-static void kasan_global_oob(struct kunit *test)
+static void kasan_global_oob_right(struct kunit *test)
 {
 	/*
 	 * Deliberate out-of-bounds access. To prevent CONFIG_UBSAN_LOCAL_BOUNDS
@@ -723,6 +723,19 @@ static void kasan_global_oob(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
 }
 
+static void kasan_global_oob_left(struct kunit *test)
+{
+	char *volatile array = global_array;
+	char *p = array - 3;
+
+	/*
+	 * GCC is known to fail this test, skip it.
+	 */
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_CC_IS_CLANG);
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
+	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
+}
+
 /* Check that ksize() makes the whole object accessible. */
 static void ksize_unpoisons_memory(struct kunit *test)
 {
@@ -1160,7 +1173,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmem_cache_oob),
 	KUNIT_CASE(kmem_cache_accounted),
 	KUNIT_CASE(kmem_cache_bulk),
-	KUNIT_CASE(kasan_global_oob),
+	KUNIT_CASE(kasan_global_oob_right),
+	KUNIT_CASE(kasan_global_oob_left),
 	KUNIT_CASE(kasan_stack_oob),
 	KUNIT_CASE(kasan_alloca_oob_left),
 	KUNIT_CASE(kasan_alloca_oob_right),
-- 
2.34.0.rc2.393.gf8c9666880-goog

