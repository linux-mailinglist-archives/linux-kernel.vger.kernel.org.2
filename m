Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D149310EE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhBEP6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhBEPx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:53:27 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC0AC06178C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:35:09 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id q24so4071746wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6RV3PXvNWDRRLwJfhc9nA9uOtjOO4vRR2YJTlHhgy1g=;
        b=hr9DzLw8PMFXDmOtc8ZAyVLRhSu9H1GXAWRc7Isd9/XTI8Cgi/jOQVN1GFDvZnERyB
         G0HDSX6x8jQqkjNbE1UygZ3nJdUqxCSAPKSLVU27KQJjuRq2fa0ClujER0+PhSTzUcbZ
         nrhIBgxy8C9/vLXSIHaHysZ86Cf8ZxwaoECfAGez4vWWEVDoSH037sAnwgHeL68Yg5iV
         FjqojbgDKu9rTiWhHFSCGcCAnibfMdcmw/QUZF+vozj8e9iaXiBtzMtFGaPsuvLT80Kw
         2VNm/yfw0oadQd2OIkqOcJCfOagcSL+70vJBOSCrH8Uczn7HUXpEpK1ijgH8yi9KwdHb
         prUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6RV3PXvNWDRRLwJfhc9nA9uOtjOO4vRR2YJTlHhgy1g=;
        b=RIzzxsiIzFJ5/XguNrbRNhx7nj/VdC6hr307MCj3iGgweEK5qnuqE1yycnMod72v5p
         anDw+nTBV9ciTQTjmPaRc2aliRpTLyxbm88VMGpQroeORqoepvwHNpbmQqpEyMcCYG3X
         U/+68cSRbl5HRZqFJzdO9RpKQGdHkR4bIrxl23Ojw7IPgZpg0AGjKu9BQlLWnCWsGhPR
         j/uDf7DVKNfPJZD9FQAXVTr48162J8H3laow0WBiwvGLq63ZOt10dWp/SL3OXikx8zPA
         o6WYKOmGvVsYsDBmmXTBnuqFzJTP4TXaGgy8OG7IVgNmxsaL7F4Jiuw7Zo9gKfBnu+w3
         LmUQ==
X-Gm-Message-State: AOAM531MbRC9Uu0g56RBego8mNuvqJ1iuRXAl8j6Twf2mIWu91CeKb0G
        rXDpnFE91c81b+yZq/1ad5jbvNEgYGX5SHB5
X-Google-Smtp-Source: ABdhPJytRzXE5voKMAWTVE7tb2OGC2+Y1oliS+AIv9OdSPsqoc+dVJE3s1RRE+LkSF8dIUprMqGcmE4wi/aHTTwX
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a1c:3185:: with SMTP id
 x127mr4375625wmx.117.1612546507585; Fri, 05 Feb 2021 09:35:07 -0800 (PST)
Date:   Fri,  5 Feb 2021 18:34:41 +0100
In-Reply-To: <cover.1612546384.git.andreyknvl@google.com>
Message-Id: <cbcf7b02be0a1ca11de4f833f2ff0b3f2c9b00c8.1612546384.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612546384.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 mm 07/13] kasan, mm: fail krealloc on freed objects
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
index ffebad2f0e6e..1328c468fdb5 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -353,6 +353,25 @@ static void krealloc_pagealloc_less_oob(struct kunit *test)
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
@@ -1050,6 +1069,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
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

