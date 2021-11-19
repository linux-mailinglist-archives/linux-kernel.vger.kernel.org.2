Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2810C45708B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhKSOZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbhKSOZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:25:40 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2A8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:22:38 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so8539579edq.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IEIj8/RLwMC8pWEHCeAMmji/+yQZYVPCoiXY0EfgE4k=;
        b=dd6fdpFKQhgB8y6tFQDaNj/9mD5oFs/5cTtxRClH0UCf6n2JDhhry+q2bruK1H8UZR
         jmaVn1t9ZtDKMm4fGm+w8BB+TIYRG6WdpPTzQsSZO4n9NUmKv5jAWa/PxdVet623lgL7
         SFLyz4j1JpdvnBV2xZnczdzUbvM0FM+ZR/7ghh1Eywtoy4Lju7d1poc54kO7CbRYfJi/
         OrXDH6LnqnLGMudrJGhn5JWDEUcKB2K0ThmKxn8EoKcgD/F3Gy5MTxJmTfyjOc5U6d40
         H1fpoWoXddyMcVlZp2xRz0vErEIN2hzw/n7DSWxk/344eCSnv+3zo64SBuD+/TkmkPWe
         CFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IEIj8/RLwMC8pWEHCeAMmji/+yQZYVPCoiXY0EfgE4k=;
        b=xylW+ih6RGHFJ5TGhHuVV8C7wrDMQ7PGEL3QuwCEnrJ6U1xYY8o/5KXEs4hc3kulmx
         KJRDEuBIl7PHmuCo0fAlhSQv/Q4nZNw5XWkxpLO8npgBka3dDBM1yNRGp724ASV+AqrE
         GottiaoOdXhswIVdeVcriBsRaVzUDz+EZIo4lKAEawTn8OHiJQiA6vE0uptUEx9Av65E
         G8U/C/al4a1VhtLhUc4Z1MZLsi1rx6CqJOT5ELKjkM1hdsqTjapCqRSgdRQlAQ0dV2jv
         pMezNPEt+6XXLwzYCjiS+Otx921ewz8sdrNvjJvqYn6dlwpidR6KWuFfmA1fgRUY3CTH
         yFwA==
X-Gm-Message-State: AOAM533jwDcARYW+HuClq8a7v8cGqN2tjMt9pKLHWPsDQJj28QI1QsIk
        CbYOuu9uvd+e1IBA2VDqfhBsqJZMJw==
X-Google-Smtp-Source: ABdhPJzDdsQ6WmsTnEwG19frgMnerT1R6j778ldtfgMgTu0p47v8bteljUjpyoiEUpp9C7OsWMaUWzfKxQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:24a0:cdec:f386:83d0])
 (user=elver job=sendgmr) by 2002:a05:6402:2210:: with SMTP id
 cq16mr25134631edb.32.1637331757116; Fri, 19 Nov 2021 06:22:37 -0800 (PST)
Date:   Fri, 19 Nov 2021 15:22:19 +0100
In-Reply-To: <20211119142219.1519617-1-elver@google.com>
Message-Id: <20211119142219.1519617-2-elver@google.com>
Mime-Version: 1.0
References: <20211119142219.1519617-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 2/2] kasan: test: add test case for double-kmem_cache_destroy()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test case for double-kmem_cache_destroy() detection.

Signed-off-by: Marco Elver <elver@google.com>
---
 lib/test_kasan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 40f7274297c1..4da4b214ed06 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -866,6 +866,16 @@ static void kmem_cache_invalid_free(struct kunit *test)
 	kmem_cache_destroy(cache);
 }
 
+static void kmem_cache_double_destroy(struct kunit *test)
+{
+	struct kmem_cache *cache;
+
+	cache = kmem_cache_create("test_cache", 200, 0, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
+	kmem_cache_destroy(cache);
+	KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_destroy(cache));
+}
+
 static void kasan_memchr(struct kunit *test)
 {
 	char *ptr;
@@ -1183,6 +1193,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(ksize_uaf),
 	KUNIT_CASE(kmem_cache_double_free),
 	KUNIT_CASE(kmem_cache_invalid_free),
+	KUNIT_CASE(kmem_cache_double_destroy),
 	KUNIT_CASE(kasan_memchr),
 	KUNIT_CASE(kasan_memcmp),
 	KUNIT_CASE(kasan_strings),
-- 
2.34.0.rc2.393.gf8c9666880-goog

