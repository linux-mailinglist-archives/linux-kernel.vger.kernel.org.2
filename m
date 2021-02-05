Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2E73116D3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhBEXPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbhBEO26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:28:58 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDA5C0617A7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:06:53 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id h18so5656447wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8mKaNk2QrOQTwEWb38aMmksU7/sGdVLcyph/DgY5wHs=;
        b=QfjYpmjXoRqlsRMRzIr1+KVDuXCF2mGgmlq8dFVbwnt4uNtQtYnNne3p0LEk8PZQDP
         LH5OZXYZHXnUePnOcLRuNPszmnd0FbfwstXEBdw/yq0puinkR3zPz/pMVKUI41FN1LRO
         TITdhTVPQ66BT7n+DGzJ0E4W8mHLBXe/RUdro9N/o4FevnpDSQT2EyQ2VTOhoKL0Hp51
         4Yghkms3teme8JHxSmMN4lmoel1ruP8Q48RDs2QWYWOy9muAuK4Vh7IhKz+yWLzPjY7X
         R5eEwvcYRQPrf+CrkQtsI/MqKbLgrmOyHKWOEGwlEQK6O7TeqmH59+a4LK7xxIg906Nl
         3wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8mKaNk2QrOQTwEWb38aMmksU7/sGdVLcyph/DgY5wHs=;
        b=oC+ICtjxpBGse0IL5ER9z+ddtzfNFgmvPKQtxWIIUQkEm8x3RDAx+2ggrBua5Dk3bI
         J0JKscoBl1oWuklgbpJjVI1+Bth3dxpzwcMNzZkAselDTtBq/vphktuGu1YTjvPq7fOr
         YyIlg6n8Kum7W5iA+djvXot5mWlt5NgI1P2PpvX7wU3uSjZ6u7qJ+gfQkNpzCa1Un3rN
         KwHaVaKllZX52PwUvHDkQx/xVg5+Ups7qjN/yA/7EJPgYNr16/0pMrqS4vyndB4yqztk
         tBaax7XzHWmbXoCVDVkTfsQe8fBjYGuewIMy0hytrVzXIaQDJJb36/MxChpFwgH+Aj69
         5hsQ==
X-Gm-Message-State: AOAM530AtVz5ITz09CkCg5Lg51/OscGMGphpnosX+P+0JzSxPC+VhIvE
        4+6l6ZZaocwWe3fyu1uRM7Y1PuLWc8w8BBtG
X-Google-Smtp-Source: ABdhPJzYoU8WAwIEjECte+81tcJ5TXF+4Xxppz8zhonkdU8HFTaLQCKRYJRQjlnulmI0sfacZvfaDU8xnzFhQTTE
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:35c9:: with SMTP id
 r9mr499080wmq.0.1612539572043; Fri, 05 Feb 2021 07:39:32 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:39:07 +0100
In-Reply-To: <cover.1612538932.git.andreyknvl@google.com>
Message-Id: <dd0784c422133ca65ba691650b87989320d0714d.1612538932.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612538932.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 06/12] kasan: rework krealloc tests
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
index 5699e43ca01b..6e63ba62db09 100644
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

