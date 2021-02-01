Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC330B0B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhBATqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhBATpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:45:23 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117F2C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:43:55 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 185so14133681qkl.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=XCxo0tPucACpabOxuZtkTLtcboXhH0Xr2jZowtJcY6I=;
        b=nnt2QvzSfV0fa4ZZ03BZbnCp26ygACCoyTH46dpZyV9pLif0zOs6SXCEH2kcnjoFoV
         U1X5EXE1b/4nl5HZlwRerfFqKzt7jlwQz2d6uc95LKZ+SqbWeT8/Jp5hmPe3wZ5Q5tR+
         Me7mRSARwZsr3WcDQyZ/mm/huwmItQuMt6csyGU8hTuyjthwd5A/Nn8C9a4mByWlS1VZ
         1MkGWO4bG9xlswrcA618UKRyKeogViFJD3prqZJKBHRo3djA6zeLo3w47rwnsunN0gz3
         flvwfX50AHe7/LCWla+sbrMmy1N/cEUeB+vO+5PGoJ4Hd85oD2y2azxexCmHYTpLxzJp
         /Jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XCxo0tPucACpabOxuZtkTLtcboXhH0Xr2jZowtJcY6I=;
        b=ZA3CwlwqLVfJPxhJFGJXPPPRc7DGjlHFSx5e/lSZdVQTWo3n8l2Cxh/wf6BGkFDXiu
         HPpChFDrvz2J/qYpATnORLWyTU6uZPVKbbTjMgxtMzmmgdkzZqbKAQXuOrMgYWhH2WEh
         i/PZxPcXVmZoMYFnS89UQoxKvRLjTNb2Lg6feoeaVWz4lq/nW7KUXvgH+k/WqEJVeLKd
         /q3f1lXn54Nk6k/LPxfMnzHONIbCFjohpI9VWlpkmf6pPUJst9KSbTkhBvXuSaeclNpe
         ZJFhuSd3RZR4knPg+Ecjvnpgu7aLDPIPvdD2a2WocIoOv5MwTWiVfjE+Gp+1QAS/RWm7
         hZNQ==
X-Gm-Message-State: AOAM532oqAVcee90dp71MCSUeNkEXTPqjjNOXQHgxmbesaP0n+FeAsM5
        HDEYyCCdMXItqJvgl9MFRRT+JJhNVuO4ljVt
X-Google-Smtp-Source: ABdhPJwdXbY1qM/NMUi7jaSpz4LhDzmb7rta6x+9O6xGnsVRwYvyMYrhWT+3uFTKuYlZPyvi6dklTIkdGEdweICZ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:40c6:: with SMTP id
 x6mr16803415qvp.10.1612208634261; Mon, 01 Feb 2021 11:43:54 -0800 (PST)
Date:   Mon,  1 Feb 2021 20:43:30 +0100
In-Reply-To: <cover.1612208222.git.andreyknvl@google.com>
Message-Id: <995edb531f4f976277d7da9ca8a78a96a2ea356e.1612208222.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 06/12] kasan: rework krealloc tests
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
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

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 91 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 10 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 5699e43ca01b..2bb52853f341 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -258,11 +258,14 @@ static void kmalloc_large_oob_right(struct kunit *test)
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
@@ -270,15 +273,31 @@ static void kmalloc_oob_krealloc_more(struct kunit *test)
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
@@ -286,10 +305,60 @@ static void kmalloc_oob_krealloc_less(struct kunit *test)
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
+	 * For all modes both middle and size1 should land in separate granules
+	 * and thus be inaccessible.
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
@@ -983,8 +1052,10 @@ static struct kunit_case kasan_kunit_test_cases[] = {
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

