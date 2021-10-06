Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865C04236C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 05:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhJFEAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 00:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbhJFD7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 23:59:51 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E58C061259
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 20:55:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 133so1284274pgb.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 20:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jm638j1gTfOkeKJqLpDPeHPNo/d/3pdWvH0ndHGkMeA=;
        b=e/eBlfdAF85VK5uiXNPtOucUg90AoYpTcWCJU5r+yVSiKpc4F/WfDt0BPfJuWmjXcK
         lRTl6VW5NcXxzvWgRJvE7Qhn69nreJc31h4U9xEtWD2rSCXbayhz+J7Plr+m5/52dAIO
         QxF2Bl640o3NhYtiyTpp1stB+EnYektopBY1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jm638j1gTfOkeKJqLpDPeHPNo/d/3pdWvH0ndHGkMeA=;
        b=obVEY/HZc3iOTlrSNaDbaJtVGSWMch2OgoX5qzr9EWl331XJ3eOILS5UoE+DP6nRA+
         qKVKkab7RMhQe96K4fcStx1yZ86hnOqkSMPLvnt1d69n6ctqwtfowm3+o35sSKYy+2PV
         veJuysWUHg4QyLll8PqFKZoyE7927vphIvai4EYvw6ZVDGb8rlBgoc3QvJST1iwSoYc6
         O3Warm+Rt3amG0n4OHdUUG+EqR338ljZ5F664gbazHrpFgU1O16zd1nmhTQLa5N1nF0U
         B2RlGQJeIVCuhhmaR0TQBfkFpCmf4P0izNTN2siebwLjFymFvtkJ2lX7xojaPl5NKS7r
         3ayA==
X-Gm-Message-State: AOAM533jQcp2SUUb5lIBDq4/vJ6HU9LKUDe50rROek0wo10ZZ6pV/0Z6
        ZS6v6skZEL1LBLBN4EVvo0tnxw==
X-Google-Smtp-Source: ABdhPJwLLMd1L8WitARptmvyv7yMLOE+rXPSBTDbDdVKpZcF5x2r/IObrNNfPxEdu0PNOw++Gv21Mg==
X-Received: by 2002:a62:52c7:0:b0:44b:d8b4:4b0f with SMTP id g190-20020a6252c7000000b0044bd8b44b0fmr33718189pfb.18.1633492530591;
        Tue, 05 Oct 2021 20:55:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a13sm19071350pfn.24.2021.10.05.20.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:55:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] kasan: test: Bypass __alloc_size checks
Date:   Tue,  5 Oct 2021 20:55:22 -0700
Message-Id: <20211006035522.539346-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2968; h=from:subject; bh=xz5c7mcxVXMgC6PuWaLiQPhsapFTq50WqH+V3y1vybk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhXR4pBfwWQd8BknEyuHsNzKL6EJMMJ+t/5lz+naGR ScRhzoGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYV0eKQAKCRCJcvTf3G3AJrv9EA CiIWV6+I4NncSuJkGCnCGlkPgyk+p7UqmlqsrmltutvhV2n1bw+mbrK83AMOTZfaC2ekROwo8akZ2n C5WDN1UlB/xVK2nV0hDIzRrx/XIuaGAVmqxe7aHQqavhhSAKX1du9cDdyZ90qvNfiJeniohemF9uP+ 8HuDY1RmD4NzD9jnf1h6+ejU331PSf8KUnVRGW63LtkZjCihQ0mA82RMWwpPtInfBYY+bMLnq0vNM8 aBWXizmrHJ176+HSnCdPkHnrE28TRpdwBJG44bKKR4xN5iGtURhER/tIKxqwLKV7T4M7Cm3jjmcWE4 hcN/7Zj/7/GvEOh0zx1QlFn5QBdC3q+KIfWckr0W3bXSizFJkDxgobfjnpexR0JDLXD04kNHIo8AdQ /tcAJfkWaBivfGt6nDzILjo27rOItHRR7SCUKDzpfkJnHt5fxcxfEZCLdMjgbQkYybihKAQQRdP4t6 28ZEAWyyqV4cPyEhrzqaUz8Kqlx5HH1fIInuPBrQq2+skTP74P5UODMHaYgNF4Fj9azNBjNrjZiTqT Vc9Lr7CFZ1PMtpme16WeylGmaLYLn8JJgKeEGZG0DY00pUvgLp/+YRt+xmquCs/N+xT+VaiLTYJp6U drmg7+ypID6pwWPX4SG7yineg2jJBvLoAnb9FDBZemTG2ga/jkun60uDIUVA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intentional overflows, as performed by the KASAN tests, are detected
at compile time[1] (instead of only at run-time) with the addition of
__alloc_size. Fix this by forcing the compiler into not being able to
trust the size used following the kmalloc()s.

[1] https://lore.kernel.org/lkml/20211005184717.65c6d8eb39350395e387b71f@linux-foundation.org

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_kasan.c        | 10 +++++-----
 lib/test_kasan_module.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 8835e0784578..0e1f8d5281b4 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -435,7 +435,7 @@ static void kmalloc_uaf_16(struct kunit *test)
 static void kmalloc_oob_memset_2(struct kunit *test)
 {
 	char *ptr;
-	size_t size = 128 - KASAN_GRANULE_SIZE;
+	volatile size_t size = 128 - KASAN_GRANULE_SIZE;
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
@@ -447,7 +447,7 @@ static void kmalloc_oob_memset_2(struct kunit *test)
 static void kmalloc_oob_memset_4(struct kunit *test)
 {
 	char *ptr;
-	size_t size = 128 - KASAN_GRANULE_SIZE;
+	volatile size_t size = 128 - KASAN_GRANULE_SIZE;
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
@@ -459,7 +459,7 @@ static void kmalloc_oob_memset_4(struct kunit *test)
 static void kmalloc_oob_memset_8(struct kunit *test)
 {
 	char *ptr;
-	size_t size = 128 - KASAN_GRANULE_SIZE;
+	volatile size_t size = 128 - KASAN_GRANULE_SIZE;
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
@@ -471,7 +471,7 @@ static void kmalloc_oob_memset_8(struct kunit *test)
 static void kmalloc_oob_memset_16(struct kunit *test)
 {
 	char *ptr;
-	size_t size = 128 - KASAN_GRANULE_SIZE;
+	volatile size_t size = 128 - KASAN_GRANULE_SIZE;
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
@@ -483,7 +483,7 @@ static void kmalloc_oob_memset_16(struct kunit *test)
 static void kmalloc_oob_in_memset(struct kunit *test)
 {
 	char *ptr;
-	size_t size = 128 - KASAN_GRANULE_SIZE;
+	volatile size_t size = 128 - KASAN_GRANULE_SIZE;
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
index 7ebf433edef3..c8cc77b1dcf3 100644
--- a/lib/test_kasan_module.c
+++ b/lib/test_kasan_module.c
@@ -19,7 +19,7 @@ static noinline void __init copy_user_test(void)
 {
 	char *kmem;
 	char __user *usermem;
-	size_t size = 128 - KASAN_GRANULE_SIZE;
+	volatile size_t size = 128 - KASAN_GRANULE_SIZE;
 	int __maybe_unused unused;
 
 	kmem = kmalloc(size, GFP_KERNEL);
-- 
2.30.2

