Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D134337F81A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhEMMqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhEMMp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:45:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1CEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:44:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h4so26748142wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hD4dt2Eg4RnvV5fMv2oKGaKTjuE+r6cuvUcfND+PBWY=;
        b=SESeB8mMhwbp0etWFYXLMhJ9XUZKmkm6VG+5UuiTFNsT9TXOL1cv9S1VkGKPnBGFAc
         WGWFjUPBEEqqcibuhnmqg9QND5v4/UVxC2hTmqj1ALVZweU+XcwIjiG74KNBZa1RWwEs
         fz34IqHzdRJX0ChorJTRrA5jM3JRLMEiZDahWbRhxRMpNtRWFxh54ciZCyNLvFFow+rx
         AtLPSP88hw6yL+8uIRb1Lad9+Bln1du9fkj3vYOEhwzBG7nEtJKXffqbVBSnwb1O7uYD
         HvzGG+bDMlPjfcMreLouWI+USIE0Ry+uD8wM1+dvP3ptDrJ7Uy6hezldmmqiO3pTqHZu
         JQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hD4dt2Eg4RnvV5fMv2oKGaKTjuE+r6cuvUcfND+PBWY=;
        b=nPtTjQKuJxjmolm3K9ts0OGjUlOg/vHa2uqWDIheEfdi4J42odQviIisXcKsHNtpkJ
         P9xgs4uN4TI2TTuHyLP388eygYu2sdnvEAc8YR2GIyhpS4qcvPEaxxtWWqdrOsMx2MOj
         L9o4xRdkkDIr6cC2tT8dVbj0+NTCAuwJCs6euRIP5xgCreMYNbFDVjMfNQWxC1oacaNx
         UbJCRYIOhfwjBlOwtX+GLEfQVM5w88a6IthOx3vCOipLnwtqNiJeCN3AaV49/Iimkyhl
         m48z6ukRHyWNLdz/qiVHb8JC5OywzEFuHrT507ngwWUJgij63Fd++r/mPP6aRKouKGwx
         z0Ow==
X-Gm-Message-State: AOAM530V4nSoTliZqY4E6hatGROY9I+ed1+HBM6pxyUl+Gun4LrG1DnC
        Taig57p31yc5AkX2PydCIId9Pg==
X-Google-Smtp-Source: ABdhPJyt3R7b9kPzU7PC4XgXZ9FfZE63gu+BsAWl+WIRN1Ky7ldG1rtcDAWHhkMz+ooQEc9pZ0I13g==
X-Received: by 2002:adf:e944:: with SMTP id m4mr9449755wrn.10.1620909885562;
        Thu, 13 May 2021 05:44:45 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:c5e0:2ff3:baa4:b294])
        by smtp.gmail.com with ESMTPSA id n12sm2054569wmq.29.2021.05.13.05.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:44:44 -0700 (PDT)
Date:   Thu, 13 May 2021 14:44:39 +0200
From:   Marco Elver <elver@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        glider@google.com
Subject: [PATCH] kfence: test: fix for "mm, slub: change run-time assertion
 in kmalloc_index() to compile-time"
Message-ID: <YJ0fN5Ul8i9e/3wC@elver.google.com>
References: <20210511173448.GA54466@hyeyoo>
 <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable using kmalloc_index() in allocator test modules again where the
size may be non-constant, while ensuring normal usage always passes a
constant size.

Split the definition into __kmalloc_index(size, size_is_constant), and a
definition of kmalloc_index(s), matching the old kmalloc_index()
interface, but that still requires size_is_constant==true. This ensures
that normal usage of kmalloc_index() always passes a constant size.

While the __-prefix should make it clearer that the function is to be
used with care, also rewrite the "Note" to highlight the restriction
(and add a hint to kmalloc_slab()).

The alternative considered here is to export kmalloc_slab(), but given
it is internal to mm/ and not in <linux/slab.h>, we should probably
avoid exporting it. Allocator test modules will work just fine by using
__kmalloc_index(s, false).

Link: https://lkml.kernel.org/r/20210512195227.245000695c9014242e9a00e5@linux-foundation.org
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/slab.h    | 15 +++++++++++----
 mm/kfence/kfence_test.c |  5 +++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 27d142564557..465c5d9d9630 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -347,10 +347,13 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
  * 2 = 129 .. 192 bytes
  * n = 2^(n-1)+1 .. 2^n
  *
- * Note: there's no need to optimize kmalloc_index because it's evaluated
- * in compile-time.
+ * Note: __kmalloc_index() is compile-time optimized, and not runtime optimized;
+ * typical usage is via kmalloc_index() and therefore evaluated at compile-time.
+ * Callers where !size_is_constant should only be test modules, where runtime
+ * overheads of __kmalloc_index() can be tolerated.  Also see kmalloc_slab().
  */
-static __always_inline unsigned int kmalloc_index(size_t size)
+static __always_inline unsigned int __kmalloc_index(size_t size,
+						    bool size_is_constant)
 {
 	if (!size)
 		return 0;
@@ -386,11 +389,15 @@ static __always_inline unsigned int kmalloc_index(size_t size)
 	if (size <=  16 * 1024 * 1024) return 24;
 	if (size <=  32 * 1024 * 1024) return 25;
 
-	BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
+	if (size_is_constant)
+		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
+	else
+		BUG();
 
 	/* Will never be reached. Needed because the compiler may complain */
 	return -1;
 }
+#define kmalloc_index(s) __kmalloc_index(s, true)
 #endif /* !CONFIG_SLOB */
 
 void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __malloc;
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 4acf4251ee04..7f24b9bcb2ec 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -197,7 +197,7 @@ static void test_cache_destroy(void)
 
 static inline size_t kmalloc_cache_alignment(size_t size)
 {
-	return kmalloc_caches[kmalloc_type(GFP_KERNEL)][kmalloc_index(size)]->align;
+	return kmalloc_caches[kmalloc_type(GFP_KERNEL)][__kmalloc_index(size, false)]->align;
 }
 
 /* Must always inline to match stack trace against caller. */
@@ -267,7 +267,8 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
 
 		if (is_kfence_address(alloc)) {
 			struct page *page = virt_to_head_page(alloc);
-			struct kmem_cache *s = test_cache ?: kmalloc_caches[kmalloc_type(GFP_KERNEL)][kmalloc_index(size)];
+			struct kmem_cache *s = test_cache ?:
+					kmalloc_caches[kmalloc_type(GFP_KERNEL)][__kmalloc_index(size, false)];
 
 			/*
 			 * Verify that various helpers return the right values
-- 
2.31.1.607.g51e8a6a459-goog

