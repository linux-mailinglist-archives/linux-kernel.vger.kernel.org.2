Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40E230B0B8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhBATqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhBATpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:45:24 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E61C06178C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:43:57 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 5so190317wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yMQgrLxhHIKq4G0a2NCbXbKyDrvusdwY4yeazjCtuyk=;
        b=ivESTfLfXADjygdQiFNXCX+wPXeMmmyDL7MhSMwYXQFbjxX6om64VWAa9DB0UHgjky
         FA0IkQ9/NQQQM1j6Es5XovdS1v0MO0KZldXf+YBmCCZn47B20vO09U3YN5ZVtPh9slfU
         V0695NxHTqBxob7ObPmJFRiD3DbtZI77vvKRyogyBNt+B0g1mlTTZfcvclio6T9srFgt
         DeT+ymo2vjail6bFhgkunaozgr3fW+qjwQ7TMJkpHXXpDU0/3qtwo9c7+nWPQ+JBZxK0
         m6EaK0Hm5acOgUfe9nl3oqyOCXvObbHtXRzj+nbFuJQYf48336Ff8i+FpKXIIffMt9oQ
         NOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yMQgrLxhHIKq4G0a2NCbXbKyDrvusdwY4yeazjCtuyk=;
        b=qM7uB6ftT6Zgsd9IW6oXGp/jvvyxWkKXqmpd/oDDcrC/4OwHm2ZrTgsq0Jz/egYA3+
         qJ0zVYN/lNH8SOBl+rRLuncTRaPQrN6AP+EVA8bbwJX2XpyD6Z5/8W5lG6dIWBCc5dtf
         rcDu3JvqQ+8vkkschHSgWZpHXTWfJ+n1+kkU2NoPKkQckV9ZMzGT0XLNjRayXsx2XYXn
         +iQMU/48HkdfebWPFn70p1FYgQntWvDgv+o+i8PSzji3tg63RVKA5uVorXKfC7E1SdE3
         2w8YxJ6l+mzTzfc0FiDnt+m0V7XavbbXngb1wYMO6CIccEwNKSIP4WHh82bgtc3cXJoN
         lnbA==
X-Gm-Message-State: AOAM5317BTktIxUMnJ2tPTBhpvxFUFrgzV7lYCGGtEi2fH8Afuuw5xYQ
        fianM9lB8t0ZI1oUgNqGqp0spTuMqSUAMw7H
X-Google-Smtp-Source: ABdhPJzOa+LccFfH9kBnsOeOGuqeG8GyRvo7cSnKb8yeZh67FwLtjenT5WmmmRbIZ1nG1AOskfgvEC22yE1+sKw/
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:7711:: with SMTP id
 t17mr441041wmi.64.1612208636543; Mon, 01 Feb 2021 11:43:56 -0800 (PST)
Date:   Mon,  1 Feb 2021 20:43:31 +0100
In-Reply-To: <cover.1612208222.git.andreyknvl@google.com>
Message-Id: <884e37ddff31b671725f4d83106111c7dcf8fb9b.1612208222.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 07/12] kasan, mm: remove krealloc side-effect
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

Currently, if krealloc() is called on a freed object with KASAN enabled,
it allocates and returns a new object, but doesn't copy any memory from
the old one as ksize() returns 0. This makes a caller believe that
krealloc() succeeded (KASAN report is printed though).

This patch adds an accessibility check into __do_krealloc(). If the check
fails, krealloc() returns NULL. This check duplicates the one in ksize();
this is fixed in the following patch.

This patch also adds a KASAN-KUnit test to check krealloc() behaviour
when it's called on a freed object.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 20 ++++++++++++++++++++
 mm/slab_common.c |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 2bb52853f341..61bc894d9f7e 100644
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

