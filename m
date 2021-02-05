Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5BC310EE3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhBEP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhBEPxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:53:24 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B80C06178B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:35:06 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id x20so4120392wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=WvobzSj421U2nh52f1sEoHIHe/BM9iFVUw3RqQILbkc=;
        b=NNedEXHnWuo6mudQu55pc85Aj8ZkARgExTe1GyiP//qvZCPgdJYoRMIytaxulPpENP
         5m1UVeBdJCEJGndVwvbfCkgSYO0C9rL4pVy43HKK1B1XVeNg5b62xCGqn5v8Qh+IlOCL
         Z8y1xgKP51VVTVAvtqhaGHX2Gd2rlut623m9JBsMdQ0JCtXKRh0cZUakJeUCSgW01IFW
         4jDbbpMJf1turd9ap5dKzKvSp1aSdk/eco4V90CWDmBtbcR0DLoHGPdb6wFqGhfy1ifP
         bOnqCbXQFu7nWzu5ypuM4z61ktabT+Xr2DOtVjR+7zwFld+Mi9L68l/xjVzO+c81Wm5k
         ynDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WvobzSj421U2nh52f1sEoHIHe/BM9iFVUw3RqQILbkc=;
        b=njiLIKMe7UyWwFADB7anEJRXn6LtAOdMD/HjystIruWBpGMvBCr9Ofpj5wsBL0rzwa
         AnVBFErvjGCMiXkuyBIADmCuTXlAzXWzP+hW2qOhQ9Ii7NfxZa3K3zGTFJSrEB/jidm3
         Qnf51L1/9U2+zsm7I8qdXn6+12CLwGSBJz8/rJStfTkiQg6r51EJgZZfr5lYhMf+fpsF
         IIAE0hUmR/ZM3zhZSp+6V5c+hAx7umh9XkSarJ71/iJc4+QwevVUUd4LixPIf4JjPy62
         4aU3zFA7qQHYMATURGp/1vXolod//wo4vOJ2QPsSEvr4U/YMwqKufPk6asmZeFEhnHqx
         X5Nw==
X-Gm-Message-State: AOAM533BHDIcUitmRQ/Dgc6yMt4EF+o5MZgnc2+voXnWSG1kvR4fK72a
        70/o0M5bOOksy552RCqzEHYdrUXMqfhnF7p7
X-Google-Smtp-Source: ABdhPJx4HJoO7CbKgZftXFbdt22PtMMn75VuP2ft+tzw4fvt8SPfqelmj8N1SzNcHwszBmgAjB1HSrpNRQNyRInI
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:154f:: with SMTP id
 f15mr4396184wmg.20.1612546504994; Fri, 05 Feb 2021 09:35:04 -0800 (PST)
Date:   Fri,  5 Feb 2021 18:34:40 +0100
In-Reply-To: <cover.1612546384.git.andreyknvl@google.com>
Message-Id: <c707f128a2bb9f2f05185d1eb52192cf179cf4fa.1612546384.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612546384.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 mm 06/13] kasan: rework krealloc tests
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

This patch reworks KASAN-KUnit tests for krealloc() to:

1. Check both slab and page_alloc based krealloc() implementations.
2. Allow at least one full granule to fit between old and new sizes for
   each KASAN mode, and check accesses to that granule accordingly.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 91 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 10 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index d16ec9e66806..ffebad2f0e6e 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -252,11 +252,14 @@ static void kmalloc_large_oob_right(struct kunit *test)
 	kfree(ptr);
 }
 
-static void kmalloc_oob_krealloc_more(struct kunit *test)
+static void krealloc_more_oob_helper(struct kunit *test,
+					size_t size1, size_t size2)
 {
 	char *ptr1, *ptr2;
-	size_t size1 = 17;
-	size_t size2 = 19;
+	size_t middle;
+
+	KUNIT_ASSERT_LT(test, size1, size2);
+	middle = size1 + (size2 - size1) / 2;
 
 	ptr1 = kmalloc(size1, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
@@ -264,15 +267,31 @@ static void kmalloc_oob_krealloc_more(struct kunit *test)
 	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
 
-	KUNIT_EXPECT_KASAN_FAIL(test, ptr2[size2 + OOB_TAG_OFF] = 'x');
+	/* All offsets up to size2 must be accessible. */
+	ptr2[size1 - 1] = 'x';
+	ptr2[size1] = 'x';
+	ptr2[middle] = 'x';
+	ptr2[size2 - 1] = 'x';
+
+	/* Generic mode is precise, so unaligned size2 must be inaccessible. */
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
+		KUNIT_EXPECT_KASAN_FAIL(test, ptr2[size2] = 'x');
+
+	/* For all modes first aligned offset after size2 must be inaccessible. */
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		ptr2[round_up(size2, KASAN_GRANULE_SIZE)] = 'x');
+
 	kfree(ptr2);
 }
 
-static void kmalloc_oob_krealloc_less(struct kunit *test)
+static void krealloc_less_oob_helper(struct kunit *test,
+					size_t size1, size_t size2)
 {
 	char *ptr1, *ptr2;
-	size_t size1 = 17;
-	size_t size2 = 15;
+	size_t middle;
+
+	KUNIT_ASSERT_LT(test, size2, size1);
+	middle = size2 + (size1 - size2) / 2;
 
 	ptr1 = kmalloc(size1, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
@@ -280,10 +299,60 @@ static void kmalloc_oob_krealloc_less(struct kunit *test)
 	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
 
-	KUNIT_EXPECT_KASAN_FAIL(test, ptr2[size2 + OOB_TAG_OFF] = 'x');
+	/* Must be accessible for all modes. */
+	ptr2[size2 - 1] = 'x';
+
+	/* Generic mode is precise, so unaligned size2 must be inaccessible. */
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
+		KUNIT_EXPECT_KASAN_FAIL(test, ptr2[size2] = 'x');
+
+	/* For all modes first aligned offset after size2 must be inaccessible. */
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		ptr2[round_up(size2, KASAN_GRANULE_SIZE)] = 'x');
+
+	/*
+	 * For all modes all size2, middle, and size1 should land in separate
+	 * granules and thus the latter two offsets should be inaccessible.
+	 */
+	KUNIT_EXPECT_LE(test, round_up(size2, KASAN_GRANULE_SIZE),
+				round_down(middle, KASAN_GRANULE_SIZE));
+	KUNIT_EXPECT_LE(test, round_up(middle, KASAN_GRANULE_SIZE),
+				round_down(size1, KASAN_GRANULE_SIZE));
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr2[middle] = 'x');
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr2[size1 - 1] = 'x');
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr2[size1] = 'x');
+
 	kfree(ptr2);
 }
 
+static void krealloc_more_oob(struct kunit *test)
+{
+	krealloc_more_oob_helper(test, 201, 235);
+}
+
+static void krealloc_less_oob(struct kunit *test)
+{
+	krealloc_less_oob_helper(test, 235, 201);
+}
+
+static void krealloc_pagealloc_more_oob(struct kunit *test)
+{
+	/* page_alloc fallback in only implemented for SLUB. */
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
+
+	krealloc_more_oob_helper(test, KMALLOC_MAX_CACHE_SIZE + 201,
+					KMALLOC_MAX_CACHE_SIZE + 235);
+}
+
+static void krealloc_pagealloc_less_oob(struct kunit *test)
+{
+	/* page_alloc fallback in only implemented for SLUB. */
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
+
+	krealloc_less_oob_helper(test, KMALLOC_MAX_CACHE_SIZE + 235,
+					KMALLOC_MAX_CACHE_SIZE + 201);
+}
+
 static void kmalloc_oob_16(struct kunit *test)
 {
 	struct {
@@ -977,8 +1046,10 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(pagealloc_oob_right),
 	KUNIT_CASE(pagealloc_uaf),
 	KUNIT_CASE(kmalloc_large_oob_right),
-	KUNIT_CASE(kmalloc_oob_krealloc_more),
-	KUNIT_CASE(kmalloc_oob_krealloc_less),
+	KUNIT_CASE(krealloc_more_oob),
+	KUNIT_CASE(krealloc_less_oob),
+	KUNIT_CASE(krealloc_pagealloc_more_oob),
+	KUNIT_CASE(krealloc_pagealloc_less_oob),
 	KUNIT_CASE(kmalloc_oob_16),
 	KUNIT_CASE(kmalloc_uaf_16),
 	KUNIT_CASE(kmalloc_oob_in_memset),
-- 
2.30.0.365.g02bc693789-goog

