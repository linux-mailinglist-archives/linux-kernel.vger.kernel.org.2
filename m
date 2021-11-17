Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDC34546EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhKQNKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbhKQNKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:10:18 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19F8C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 05:07:19 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id f4-20020a50e084000000b003db585bc274so2036531edl.17
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 05:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tN9I+pAFJlbUYxyB1icCBjOYc97BjdaVLmTiDNjOPV8=;
        b=ndheOzfsOhhGUnLhlVmbUSUNSnEs7pnEZJdypfUNkwG1z1XiwKopap42PBQY8Y3qZX
         KqiGXPpRY2dvL1oOkjvSv9D+HFZ7gltYL0VmQUBSap8yBIs6oZspP/CZlWFQBmr2f6lB
         LELRE1sINCB5DtaNdyDHW1yoxO9Acr5JYRBtBsNgMHDBE4tdVGzcrk/y+QbZ3coz735N
         AccInz+RZp2i3Az5kGaJkFnTf+tBj6+5E9hnxQTMNYmUHhPxhNuVO8Hl0yC8mn9en/MA
         y7+SJ5Cliab2QztOZbPHHKVbuJYZXcga44wfTJbnaWsdPHdldky5O6Me6RyLaTtYnoxe
         UwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tN9I+pAFJlbUYxyB1icCBjOYc97BjdaVLmTiDNjOPV8=;
        b=AnUAIQw/3w1LiCc1Bc4BqWVJOLkWUFJDLwphwN+6Eh999Ccd24psLkcksV74UVFqSX
         05d6gnuXa5pUHcAEQVqs+xbWLWkcTrU/NncuLfcxwY3qTEC6YYPRXSuCvzOcyBHQR2FL
         YMkVUdFXzzdHmejmAcVo1AMc7ZxAl+Tl1+RP587yPGVwWX4swmlnkqncOZv/w1Vj19Ho
         MGBlAw7AnbA8/bf4jpYugiE7/Pj8PCOLBpsOeOU9IfY14b7OlZMfIz87qXGZLKgZ03bZ
         w4kP0jVJiv/6/SDFuIuHegT/6f+8mqH9gr6AhvgH1+tW/SbfFGUy7Ii6I17ATQFsuYtg
         41+w==
X-Gm-Message-State: AOAM530mLCFvJ7WdsI6Jnuao1STUgcTRadQnqJcpw93p5/JQpuLe5www
        bV7J/oAm2sL4OsvOl3A/AEu94ah2fA==
X-Google-Smtp-Source: ABdhPJyTKq/cx1Q/EX6DBKd8VJ5ppuqmM+IryDyYf0h9dWQbd+9nBOngWc6+zwYj5U64Z00pAfTCRkBcLQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:80aa:59e4:a6a7:e11e])
 (user=elver job=sendgmr) by 2002:a17:907:1c97:: with SMTP id
 nb23mr21669634ejc.488.1637154438173; Wed, 17 Nov 2021 05:07:18 -0800 (PST)
Date:   Wed, 17 Nov 2021 14:07:14 +0100
Message-Id: <20211117130714.135656-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2] kasan: test: add globals left-out-of-bounds test
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
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
---
v2:
* Add bugzilla link.
---
 lib/test_kasan.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 67ed689a0b1b..40f7274297c1 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -700,7 +700,7 @@ static void kmem_cache_bulk(struct kunit *test)
 
 static char global_array[10];
 
-static void kasan_global_oob(struct kunit *test)
+static void kasan_global_oob_right(struct kunit *test)
 {
 	/*
 	 * Deliberate out-of-bounds access. To prevent CONFIG_UBSAN_LOCAL_BOUNDS
@@ -723,6 +723,20 @@ static void kasan_global_oob(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
 }
 
+static void kasan_global_oob_left(struct kunit *test)
+{
+	char *volatile array = global_array;
+	char *p = array - 3;
+
+	/*
+	 * GCC is known to fail this test, skip it.
+	 * See https://bugzilla.kernel.org/show_bug.cgi?id=215051.
+	 */
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_CC_IS_CLANG);
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
+	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
+}
+
 /* Check that ksize() makes the whole object accessible. */
 static void ksize_unpoisons_memory(struct kunit *test)
 {
@@ -1160,7 +1174,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
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

