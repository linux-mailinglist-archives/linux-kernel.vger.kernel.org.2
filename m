Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831634353EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhJTTkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhJTTkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:40:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE52C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:38:10 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h193so8040481pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AieI3bvElbBAFUYr7qnOh/7i3cSfGy56FTR3mT6hwmE=;
        b=JKyb1SkFN3SMYLLFhnbqPffCCkIhLIn2NewvRo9HmWO+JgInVY5CfgAjedd39VjJiR
         0iIi3Kzm5cOFuuzjFVE21MauGKKDEelbsvDKGXaKGYt/U6eeTNQNodalYp7PdHNknH8K
         LSDaYEDIw6rciFlQexovQJFSkjkV7V90Ba2UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AieI3bvElbBAFUYr7qnOh/7i3cSfGy56FTR3mT6hwmE=;
        b=jnn/rp6I9HfgLOxzQr5yNcWxZpo6TIqC7dkUlLboFMOweBlqBbP9tYToGAY6SbsqgH
         dekbtCjHhhwGcelA721M/flVBvaGpjQJ9qU+t6JWdqkjCw45OY61sNNEmjGBPDoPQcdp
         2D63mW9F25E72CCP5hQ7cHiO498BMjbsA/d3fO9LJwtK9ZqpEFLCJYaGcXBI06WDwD6L
         rGBFAZGDxTXSTuB67XZ4L49WNSNs21dRFN1qVdjpmkv1EVuM29VnZwdzjdBwagJdrU7/
         ipfk29jlJ1loWQFIe/atTD5CJJDcb69attSVvFWBkF7473LFQ4VbsKaylBjY4dmijp2T
         8aHA==
X-Gm-Message-State: AOAM5338EjospIHkVKIPO5E0noECrDje2+iLf8Qht2U6QLErPh/N/XYx
        Xd0XZ4x4XIlpCO8PbSW3pweohw==
X-Google-Smtp-Source: ABdhPJwqDOdqmlhsXqex24xJoPb07RcqwWVHrt+R0o/zydVIUSbU49nt98KnA4FEgx4UWf0YGBhNgw==
X-Received: by 2002:a63:720d:: with SMTP id n13mr940824pgc.470.1634758689723;
        Wed, 20 Oct 2021 12:38:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id hi1sm3116213pjb.28.2021.10.20.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 12:38:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] kasan: test: Consolidate workarounds for unwanted __alloc_size() protection
Date:   Wed, 20 Oct 2021 12:38:07 -0700
Message-Id: <20211020193807.40684-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2714; h=from:subject; bh=iLZ4NeBfkWYVPoHEvytY6uZRaHHHRpbBD9aJk8sFCo8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhcHAeOncBqloNqe5Jh5YTZozruTg+mIo+5x7FRFmv mT1TQsyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYXBwHgAKCRCJcvTf3G3AJjHvD/ 4vNtVszulxNrfqy5Wok6IMFaTdPBhyb0/9pmGXt/kGQ+XSo/013n5wISDITIGlAQaUr7fdJ+x+dwR7 rutGa4psrboVf6tFgP1/krBnCqXLvFJUGtLUAmNXkFQuD6MNd1EKbh1rnzuH33A+rWlbVWaN+liVYk 9LUaozVSdQQMvuCQMG6WYxUV2rbZ4hxsfnbTJxV06MgEefnOaatyC5sk68te9ZZzvITNXX0uBSpdKL fUlWPVqG19X3Rq59o1X6V9oCFQsFBKRjB2AaUFHfMdob9r7fsND8SgxXO46Rin+cVV61lVy6+NrVtz m25U3dihpLRJYtWagAZkdjaAdAR/s7tFILPHPmRhITTMpq8NhvBVTvNSsdLph0w5JkDWN+vE0yui1e k2ar8i8TTRN8sQnJg3EsWRHReJqdDTOaU58KROqbhGTRsfar2gKPzpA63ApdwKOAY4JWNcPWeX1nPO Oj99NLNw6WyPXQ9Zh01P+0e/ywi40AoShv3TLDy5LSC41ksTOgu9Ts9MfealpwqzoyEebs5/vMRXmm w2/FWZh/2vIAMsWwV2kQTCXNpIRyOqxtb6bt1ZnYW+YaTgVEdAxssuZbeiuZzMWjrLlpEwuTq1AZQE 7dcMAf9nOO8fICycy8lx4p1CdESG3md29TTylk+fFKD7c9KqOXyRtHpWYGkg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes kasan-test-use-underlying-string-helpers.patch to avoid needing
new helpers. As done in kasan-test-bypass-__alloc_size-checks.patch,
just use OPTIMIZER_HIDE_VAR(). Additionally converts a use of
"volatile", which was trying to work around similar detection.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Hi Andrew,

Can you please collapse this into your series? It's cleaner to use the
same method everywhere in this file to avoid the compiler being smart. :)

Thanks!

-Kees
---
 lib/test_kasan.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 318fc612e7e7..96a1f085b460 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -525,12 +525,13 @@ static void kmalloc_memmove_invalid_size(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 64;
-	volatile size_t invalid_size = size;
+	size_t invalid_size = size;
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	memset((char *)ptr, 0, 64);
+	OPTIMIZER_HIDE_VAR(invalid_size);
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		memmove((char *)ptr, (char *)ptr + 4, invalid_size));
 	kfree(ptr);
@@ -852,21 +853,6 @@ static void kmem_cache_invalid_free(struct kunit *test)
 	kmem_cache_destroy(cache);
 }
 
-/*
- * noinline wrappers to prevent the compiler from noticing the overflow
- * at compile time rather than having kasan catch it.
- */
-static noinline void *__kasan_memchr(const void *s, int c, size_t n)
-{
-	return memchr(s, c, n);
-}
-
-static noinline int __kasan_memcmp(const void *s1, const void *s2, size_t n)
-{
-	return memcmp(s1, s2, n);
-}
-
-
 static void kasan_memchr(struct kunit *test)
 {
 	char *ptr;
@@ -884,8 +870,9 @@ static void kasan_memchr(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(size);
 	KUNIT_EXPECT_KASAN_FAIL(test,
-		kasan_ptr_result = __kasan_memchr(ptr, '1', size + 1));
+		kasan_ptr_result = memchr(ptr, '1', size + 1));
 
 	kfree(ptr);
 }
@@ -909,8 +896,9 @@ static void kasan_memcmp(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 	memset(arr, 0, sizeof(arr));
 
+	OPTIMIZER_HIDE_VAR(size);
 	KUNIT_EXPECT_KASAN_FAIL(test,
-		kasan_int_result = __kasan_memcmp(ptr, arr, size+1));
+		kasan_int_result = memcmp(ptr, arr, size+1));
 	kfree(ptr);
 }
 
-- 
2.30.2

