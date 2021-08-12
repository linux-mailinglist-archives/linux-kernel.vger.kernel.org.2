Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8513EA6E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbhHLOya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbhHLOyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:54:19 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC282C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 07:53:54 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1628780033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Rw7L29Rl9lI7li/pGD4SgpCx3KCWINRLEY+hWljSMg=;
        b=omGleRtpyvxWbz5TtreIGYBJe+5q5as7BlBu4evJOh1sVulPoLbAFzL/6newVraJs1nofK
        P/C642BePeDmIXJPxDx29g5o2htU5/nSLX+ZE89nQBswpUSC17RDlaSh54uUk2IJeXvVsx
        M5P/KRRzzcS3gE/inx1S0d6+vXXyvNA=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] kasan: test: disable kmalloc_memmove_invalid_size for HW_TAGS
Date:   Thu, 12 Aug 2021 16:53:31 +0200
Message-Id: <088733a06ac21eba29aa85b6f769d2abd74f9638.1628779805.git.andreyknvl@gmail.com>
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

The HW_TAGS mode doesn't check memmove for negative size. As a result,
the kmalloc_memmove_invalid_size test corrupts memory, which can result
in a crash.

Disable this test with HW_TAGS KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 lib/test_kasan.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index db73bc9e3fa2..1f533a7346d9 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -501,11 +501,17 @@ static void kmalloc_memmove_invalid_size(struct kunit *test)
 	size_t size = 64;
 	volatile size_t invalid_size = -2;
 
+	/*
+	 * Hardware tag-based mode doesn't check memmove for negative size.
+	 * As a result, this test introduces a side-effect memory corruption,
+	 * which can result in a crash.
+	 */
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
+
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	memset((char *)ptr, 0, 64);
-
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		memmove((char *)ptr, (char *)ptr + 4, invalid_size));
 	kfree(ptr);
-- 
2.25.1

