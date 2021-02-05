Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03298311726
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBEXcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhBEOWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:22:50 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B502C061222
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:00:33 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id p16so5592070wrx.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=r9X5DpdR9qKQzOGqj5YPMHvNzUxwchyNv1XRoONrpMQ=;
        b=GinXCbIKDRoOgLUpKmgxzl260l9tsG2LG+b4gApdVcTyZiiVgLI843m0SQIZzi7Qae
         NfAp0Io+LgzQcCk69t45hFOJaqjI9KbQccxbpOgaJcJcsZgClEf6fOOjoLnqeysqDHzq
         FFGcssvQchbEYQAOQYIjmmCgsqDh8MRge4yFNbKPar14MoUKxkyYfLYU4IcGP5q5DCJ/
         uq6GvLUb93p8KgHDIgo2/wB6GGYBaMGnvBP6ZxWTkuxb9g0ZXn0bOOLgzYqsobzl23WX
         ypCO6WqihQFQ1clhxfXOzKJRjdZ8iu8uQBbv8Tp6n8rPnb3bq8lPznSVsroHSUulMSsU
         BQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r9X5DpdR9qKQzOGqj5YPMHvNzUxwchyNv1XRoONrpMQ=;
        b=emXgldsg7er6BQfwFpy2pVVm3blBqdZDxoVC24hLfosjWB8r4vwQKuefsqHUN44Abr
         eXiDB66Te0DmUdbbsizJ0bpqo1CL4Xv3JW0f13PvZ0q0QWM56B3NNAwjFvSE0GpcH9DA
         oAGPXWmVLuYxQ7gDfDgGa3qWpbuYbcAx6oWM0VViYJDKDcp4eLvzymE4wpdIBrmuqDSh
         AsEDYybpTIZSLht2YDaYuh01E9KhYmGT2MhYUO9dSnml0+0dn+hoiTkYGAxM9PeizdjY
         r4V2w62ZlxyeQbIoITTDZ1SKCNeGZgCiD8qZaj93YyD3tkanz8YwD7RtnEUkgqSTNNkf
         ms5A==
X-Gm-Message-State: AOAM533EX3fjLMJ92wHAKVkyFqEJ4Naqa8aPLNfnJFXtDjzD2l6ypFA4
        iLctLk2RHNY2iRm6I62d27Y97CwRuDZlJpPe
X-Google-Smtp-Source: ABdhPJwGux2zXHlarundz7K3SOkAa4ybczg07jIuC0920I9YRGfTqF2RXx4UClbc5pUiakH6JEZV6yYw43coZmqv
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a1c:730a:: with SMTP id
 d10mr4025957wmb.53.1612539584906; Fri, 05 Feb 2021 07:39:44 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:39:12 +0100
In-Reply-To: <cover.1612538932.git.andreyknvl@google.com>
Message-Id: <182acaae3ed39231e6c3132c6bc7fc6b08ef003f.1612538932.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612538932.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 11/12] kasan: inline HW_TAGS helper functions
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

Mark all static functions in common.c and kasan.h that are used for
hardware tag-based KASAN as inline to avoid unnecessary function calls.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 7ffb1e6de2ef..7b53291dafa1 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -279,7 +279,8 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
  *    based on objects indexes, so that objects that are next to each other
  *    get different tags.
  */
-static u8 assign_tag(struct kmem_cache *cache, const void *object, bool init)
+static inline u8 assign_tag(struct kmem_cache *cache,
+					const void *object, bool init)
 {
 	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
 		return 0xff;
@@ -321,8 +322,8 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 	return (void *)object;
 }
 
-static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
-			      unsigned long ip, bool quarantine)
+static inline bool ____kasan_slab_free(struct kmem_cache *cache,
+				void *object, unsigned long ip, bool quarantine)
 {
 	u8 tag;
 	void *tagged_object;
@@ -366,7 +367,7 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return ____kasan_slab_free(cache, object, ip, true);
 }
 
-static bool ____kasan_kfree_large(void *ptr, unsigned long ip)
+static inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
 {
 	if (ptr != page_address(virt_to_head_page(ptr))) {
 		kasan_report_invalid_free(ptr, ip);
@@ -461,8 +462,8 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 	return tagged_object;
 }
 
-static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
-					size_t size, gfp_t flags)
+static inline void *____kasan_kmalloc(struct kmem_cache *cache,
+				const void *object, size_t size, gfp_t flags)
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
-- 
2.30.0.365.g02bc693789-goog

