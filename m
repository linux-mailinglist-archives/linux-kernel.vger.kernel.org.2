Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1609B311764
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhBEXpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbhBEORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:17:43 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89CAC0617AB
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:46:49 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id h18so5626014wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Eem+CPI6cqDr3+sdydeGQiL8gIW8yui8+/Xm+DAKB7k=;
        b=SekTvXiN+P4rBMIGDiv0wwZwiSR5ud4S18Maw4kVgQUSz5FEyuQjH7o5vB8M2vmUMM
         Q9IwKiqWZ2Yzni/Twm1vRliwxS6Ofyr6GjmKPH0fvoYIpgsmkQdgB+otayIHcj7mH/2D
         jmQoetdjxOjtR114YWCAtS8Fc2juWVSQssSxdWmZlUIYr3jed51NrPHMZtJCMyGYNRLf
         xFoK/UyBl2mkVnEi/vaWWeRBriSKqgl/b+Wku4w85oDpVvnXWiYQLwR5eUbxAOT6jUTa
         Z8LefNUER57XhQirYMl1Si4r9oJMTxRRv8rujMp6fw+hnNTyANk4BtTWwAwQn6481LYu
         1Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Eem+CPI6cqDr3+sdydeGQiL8gIW8yui8+/Xm+DAKB7k=;
        b=nmgr0Rk9jlYEVVWpNrqkYJ/PUcFKF3DDYVSKeNvOBk0KmXzQEPqW0xSCM2ecjiZchi
         Fce6+wOrzgYnD+LTS44oxpKCSqK+5Q8FF3syRkJEqJalDptFhw/BtgIpZcIgrGNRyE0p
         yyJ4Ptaojgk5SxnogoHOcttjTA3OqDdQqMtAEEStJkpX30nnUyJS2xhs6NemJprANfCl
         GNy/JTQhO+3nciIyZrSu60LRB2tCauD8E7Etij8ikMUGPifB3K139Rk/fBShtGRf3Q5q
         Ua1nqWAg9jpPsHSk3Tr54E3D523PZJ5aS03XYwXWWia7l7kBPtKd0qsgOVfkUttCHYdc
         7m9g==
X-Gm-Message-State: AOAM531avT0GgcGbVrnM2RODEArhVeHiLZXkLq83olPIS/OA9x428MM8
        hJy4FXJC4zuHpJ4oTJpE+DS6nEd1/J5x4wIJ
X-Google-Smtp-Source: ABdhPJyqQdKHrhOuNMT3pVa3R7FPH70A7UVF1EhvgAytPKqWBBtNMrRHXWGCczaKH2RqOThi7wWAhXKWKxUeKXJY
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a1c:25c2:: with SMTP id
 l185mr4086468wml.62.1612539574962; Fri, 05 Feb 2021 07:39:34 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:39:08 +0100
In-Reply-To: <cover.1612538932.git.andreyknvl@google.com>
Message-Id: <419e4e7ac9ff7596a1a0956c117fcad1938e5d77.1612538932.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612538932.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 07/12] kasan, mm: fail krealloc on freed objects
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if krealloc() is called on a freed object with KASAN enabled,
it allocates and returns a new object, but doesn't copy any memory from
the old one as ksize() returns 0. This makes the caller believe that
krealloc() succeeded (KASAN report is printed though).

This patch adds an accessibility check into __do_krealloc(). If the check
fails, krealloc() returns NULL. This check duplicates the one in ksize();
this is fixed in the following patch.

This patch also adds a KASAN-KUnit test to check krealloc() behaviour
when it's called on a freed object.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 20 ++++++++++++++++++++
 mm/slab_common.c |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 6e63ba62db09..791164ef191b 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -359,6 +359,25 @@ static void krealloc_pagealloc_less_oob(struct kunit *test)
 					KMALLOC_MAX_CACHE_SIZE + 201);
 }
 
+/*
+ * Check that krealloc() detects a use-after-free, returns NULL,
+ * and doesn't unpoison the freed object.
+ */
+static void krealloc_uaf(struct kunit *test)
+{
+	char *ptr1, *ptr2;
+	int size1 = 201;
+	int size2 = 235;
+
+	ptr1 = kmalloc(size1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
+	kfree(ptr1);
+
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr2 = krealloc(ptr1, size2, GFP_KERNEL));
+	KUNIT_ASSERT_PTR_EQ(test, (void *)ptr2, NULL);
+	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)ptr1);
+}
+
 static void kmalloc_oob_16(struct kunit *test)
 {
 	struct {
@@ -1056,6 +1075,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(krealloc_less_oob),
 	KUNIT_CASE(krealloc_pagealloc_more_oob),
 	KUNIT_CASE(krealloc_pagealloc_less_oob),
+	KUNIT_CASE(krealloc_uaf),
 	KUNIT_CASE(kmalloc_oob_16),
 	KUNIT_CASE(kmalloc_uaf_16),
 	KUNIT_CASE(kmalloc_oob_in_memset),
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 39d1a8ff9bb8..dad70239b54c 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1140,6 +1140,9 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
 	void *ret;
 	size_t ks;
 
+	if (likely(!ZERO_OR_NULL_PTR(p)) && !kasan_check_byte(p))
+		return NULL;
+
 	ks = ksize(p);
 
 	if (ks >= new_size) {
-- 
2.30.0.365.g02bc693789-goog

