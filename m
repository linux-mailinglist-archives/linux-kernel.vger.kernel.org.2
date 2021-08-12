Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3CB3EA6E4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbhHLOyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:54:23 -0400
Received: from out2.migadu.com ([188.165.223.204]:65054 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236964AbhHLOyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:54:18 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1628780032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rCxgc2eXwoBM9Jq6kKWMWlEDWeYYkjt8bVAWDL+S3zY=;
        b=AZHYWSAY6u8of2S9Uh2HPisrpdnDgrGOTBNn0OU4NMs5Xph99AC3MMNtoiZbG0ooZfvUGB
        1xMOSi1ab2RYa2PZuVFEdN7lOV8BmnsbYHnFYYq5EWokVpS/33QjTeageOmCGbVJs9sj0q
        DWzig2XdXx2kAKZkga+UFP0g/rry4DE=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] kasan: test: avoid corrupting memory via memset
Date:   Thu, 12 Aug 2021 16:53:30 +0200
Message-Id: <64fd457668a16e7b58d094f14a165f9d5170c5a9.1628779805.git.andreyknvl@gmail.com>
In-Reply-To: <cover.1628779805.git.andreyknvl@gmail.com>
References: <cover.1628779805.git.andreyknvl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: andrey.konovalov@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@gmail.com>

kmalloc_oob_memset_*() tests do writes past the allocated objects.
As the result, they corrupt memory, which might lead to crashes with the
HW_TAGS mode, as it neither uses quarantine nor redzones.

Adjust the tests to only write memory within the aligned kmalloc objects.

Also add a comment mentioning that memset tests are designed to touch
both valid and invalid memory.

Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 lib/test_kasan.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index c82a82eb5393..db73bc9e3fa2 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -428,64 +428,70 @@ static void kmalloc_uaf_16(struct kunit *test)
 	kfree(ptr1);
 }
 
+/*
+ * Note: in the memset tests below, the written range touches both valid and
+ * invalid memory. This makes sure that the instrumentation does not only check
+ * the starting address but the whole range.
+ */
+
 static void kmalloc_oob_memset_2(struct kunit *test)
 {
 	char *ptr;
-	size_t size = 8;
+	size_t size = 128 - KASAN_GRANULE_SIZE;
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
-	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + 7 + OOB_TAG_OFF, 0, 2));
+	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 1, 0, 2));
 	kfree(ptr);
 }
 
 static void kmalloc_oob_memset_4(struct kunit *test)
 {
 	char *ptr;
-	size_t size = 8;
+	size_t size = 128 - KASAN_GRANULE_SIZE;
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
-	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + 5 + OOB_TAG_OFF, 0, 4));
+	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 3, 0, 4));
 	kfree(ptr);
 }
 
-
 static void kmalloc_oob_memset_8(struct kunit *test)
 {
 	char *ptr;
-	size_t size = 8;
+	size_t size = 128 - KASAN_GRANULE_SIZE;
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
-	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + 1 + OOB_TAG_OFF, 0, 8));
+	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 7, 0, 8));
 	kfree(ptr);
 }
 
 static void kmalloc_oob_memset_16(struct kunit *test)
 {
 	char *ptr;
-	size_t size = 16;
+	size_t size = 128 - KASAN_GRANULE_SIZE;
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
-	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + 1 + OOB_TAG_OFF, 0, 16));
+	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 15, 0, 16));
 	kfree(ptr);
 }
 
 static void kmalloc_oob_in_memset(struct kunit *test)
 {
 	char *ptr;
-	size_t size = 666;
+	size_t size = 128 - KASAN_GRANULE_SIZE;
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
-	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr, 0, size + 5 + OOB_TAG_OFF));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+				memset(ptr, 0, size + KASAN_GRANULE_SIZE));
 	kfree(ptr);
 }
 
-- 
2.25.1

