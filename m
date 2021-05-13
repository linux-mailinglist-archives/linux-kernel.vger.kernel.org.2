Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C3637F5A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 12:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhEMKc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 06:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhEMKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 06:32:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95254C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 03:31:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l14so26426608wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 03:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I9TVKnEoxbGOXSQCVpBWnu5KN6jl7TtGegYCc95oDNQ=;
        b=E+2irKwtpsfPWTsIjd+6TJi7qEFHdmPqtExPYrmLdRs5MfegtRmP/2vOt4TCTFEPvm
         sjWbZsO0RkbOk9TBGl7Er/3A4a+GIXAmSu7JOpc6AM4kZ/mOuZ03Rr/puuxg2idaNBjg
         n70IW34QLegjjClx45zq7/ptvQSHshhRE/JbjcOdGRe81dlpzYw6/MVkkigt0R6L3VaP
         X5Ght54Ddxtzzq+odoHUOr0cHnBEP45PlZBKshksGVXMvCGwmqxWM3ChbBw3WDTEv78Z
         on8yeGkCU0KPoSohT5hCcN2gYBETAWLe4mmhNjO42VlDMjE29grku0IvZGwiAqnfM5em
         J/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I9TVKnEoxbGOXSQCVpBWnu5KN6jl7TtGegYCc95oDNQ=;
        b=MmQIxGW7CW+GCZgalx/4p8Pu749q/BSqTlPX83gK+jKMqy/SgUZcOmoEYOzv3zRNmc
         lnonkIbwbu4ZhXWhTNWwwmaUv5rPHFnfcoAZsMuAkRzl+4wTMOBJwkFQSK4xfrGQUdgu
         BAKQzOYvIN+WSxVNXwAvy/tLPl8nJp63Q3LXth8RMUkY4n8zTN4KZxf5XomXxil9xBfA
         7eNBcwRGWIgXoAKMXwIUhpoLur1qj3Ifb0RE7RsEdxdPw9jX3FSgxkWZM25PrN6xwad6
         hdwLi8mX3e7xRZsOfd4OpMNgJK0ckObaXglVgag1kk7EQtay+JKANxeHobyGFLptHumm
         tQfQ==
X-Gm-Message-State: AOAM530EQ1J5qmpyKWMXTyoh6M27odWTMfsg+/bGRcUugG/b+50EtYXA
        4RKzXN4Cq9FL+tuPP5v2PfVHJg==
X-Google-Smtp-Source: ABdhPJyW1ehp4cfqSjErQlvA+WGvuA1Dx8/t7dGKIZ0TQAM8zv4kkHtcCHFQm4hvzIXVrUCII0dt4g==
X-Received: by 2002:a5d:498c:: with SMTP id r12mr51128256wrq.31.1620901905146;
        Thu, 13 May 2021 03:31:45 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:c5e0:2ff3:baa4:b294])
        by smtp.gmail.com with ESMTPSA id b8sm2529623wrx.15.2021.05.13.03.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 03:31:44 -0700 (PDT)
Date:   Thu, 13 May 2021 12:31:38 +0200
From:   Marco Elver <elver@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in
 kmalloc_index() to compile-time
Message-ID: <YJ0ACtMpasnoZdUp@elver.google.com>
References: <20210511173448.GA54466@hyeyoo>
 <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
 <20210513031220.GA133011@hyeyoo>
 <20210512204024.401ff3de38649d7d0f5a45e8@linux-foundation.org>
 <20210513062809.GA319973@hyeyoo>
 <a36ab9a1-f07a-42ca-bb11-5bd0c70660bb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a36ab9a1-f07a-42ca-bb11-5bd0c70660bb@suse.cz>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 10:51AM +0200, Vlastimil Babka wrote:
> On 5/13/21 8:28 AM, Hyeonggon Yoo wrote:
> > On Wed, May 12, 2021 at 08:40:24PM -0700, Andrew Morton wrote:
> >> On Thu, 13 May 2021 12:12:20 +0900 Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >> > On Wed, May 12, 2021 at 07:52:27PM -0700, Andrew Morton wrote:
> >> > > This explodes in mysterious ways.  The patch as I have it is appended,
> >> > > for reference.
> >> > > 
> >> > > gcc-10.3.0 allmodconfig.
> >> > > 
> >> > > This patch suppresses the error:
> >> 
> >> Ah, yes, of course, your patch changes kmalloc_index() to require that
> >> it always is called with a constant `size'.  kfence_test doesn't do
> >> that.
> >> 
> >> kfence is being a bit naughty here - the other kmalloc_index() callers
> >> only comple up the call after verifying that `size' is a compile-time
> >> constant.
> 
> Agreed.

It's just a test, and performance doesn't matter for it.

The thing is this function lives in <linux/slab.h>, isn't prefixed with
__ or anything like that, so it really does look like a public function.

> >> Would something like this work?
> 
> I'd prefer if we kept kmalloc_index() for constant sizes only. The broken build
> then warns anyone using it the wrong way that they shouldn't.

Agreed. Andrew's size_is_constant would do that. Also see my suggestion
below to keep the same interface.

> Besides, it really
> shouldn't be used outside of slab.

It's an allocator test. If we want to facilitate testing, it must be
allowed to verify or set up test cases that test boundary conditions
based on internal state.

In the case of kfence_test it wants:  the cache's alignment to create
accesses that fall on alignment boundaries; and to verify obj_to_index()
and objs_per_slab_page() are set up correctly.

I think the requirements are:

1. Make the interface hard to abuse. Adding the BUILD_BUG_ON does that.
2. Facilitate testing.

> But if kfence test really needs this, we could perhaps extract the index
> determining part out of kmalloc_slab().

That would duplicate kmalloc_index()? I don't see the need, let's keep
things simple.

> Hmm or I guess the kfence tests could just use kmalloc_slab() directly?

kmalloc_slab() is internal to slab and should not be exported. It'd
require exporting because the tests can be built as modules.
kmalloc_index() works perfectly fine, and the test really doesn't care
about performance of kmalloc_index(). :-)

See my suggestion below that builds on Andrew's size_is_constant but
would retain the old interface and support testing.

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Subject: [PATCH] kfence: test: fix for "mm, slub: change run-time assertion in
 kmalloc_index() to compile-time"

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/slab.h    | 9 +++++++--
 mm/kfence/kfence_test.c | 5 +++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 27d142564557..7a10bdc4b7a9 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -350,7 +350,8 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
  * Note: there's no need to optimize kmalloc_index because it's evaluated
  * in compile-time.
  */
-static __always_inline unsigned int kmalloc_index(size_t size)
+static __always_inline unsigned int __kmalloc_index(size_t size,
+						    bool size_is_constant)
 {
 	if (!size)
 		return 0;
@@ -386,11 +387,15 @@ static __always_inline unsigned int kmalloc_index(size_t size)
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

