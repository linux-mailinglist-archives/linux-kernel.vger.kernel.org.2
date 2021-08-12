Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7AA3EA6F3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbhHLO5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:57:11 -0400
Received: from out1.migadu.com ([91.121.223.63]:27993 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236417AbhHLO5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:57:10 -0400
X-Greylist: delayed 70504 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Aug 2021 10:57:09 EDT
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1628780204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLYmxDSn8yRlvCuXwA7dhNRH5OHfdPThVfS1yzZfw8s=;
        b=qyNj2/4L4qC1jYYMJ0qKJnAT7LSTH56iqndM1Ypp/eSyeGZ8vj56KPYO0gmbjJ+hov1PSm
        N6RJjphfvkVM6uC2LTY76FoNbXcXNmLMDeJuuV43soDoOJ0sMahCEQsyhKV2oH/6JfpifJ
        7X7z5dmbyyhErQjYsZ4UB8xulo/AbGI=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] kasan: test: clean up ksize_uaf
Date:   Thu, 12 Aug 2021 16:56:41 +0200
Message-Id: <a1fc34faca4650f4a6e4dfb3f8d8d82c82eb953a.1628779805.git.andreyknvl@gmail.com>
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

Some KASAN tests use global variables to store function returns values
so that the compiler doesn't optimize away these functions.

ksize_uaf() doesn't call any functions, so it doesn't need to use
kasan_int_result. Use volatile accesses instead, to be consistent with
other similar tests.

Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 lib/test_kasan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 1dcba6dbfc97..30f2cde96e81 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -737,8 +737,8 @@ static void ksize_uaf(struct kunit *test)
 	kfree(ptr);
 
 	KUNIT_EXPECT_KASAN_FAIL(test, ksize(ptr));
-	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = *ptr);
-	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = *(ptr + size));
+	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
+	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
 }
 
 static void kasan_stack_oob(struct kunit *test)
-- 
2.25.1

