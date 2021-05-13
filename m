Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC33137F1B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 05:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhEMDlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 23:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhEMDle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 23:41:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00019613F7;
        Thu, 13 May 2021 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620877225;
        bh=1E/vgh/+WpmAsgp9m69RubUIpeZA4hdZiaw/+4uS6ds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MlwDtV0+RYKgENgM8ynfernEGP+3noACuYmPGIrZgS0pmx8aUQ9bf7TLhgFfjO9bu
         o3AGbazLHZaOaMqyWNvtC/ZjdfdwEBsNg35w560OsRNhPFMfjsZTyYQ/H8rE3fCjo6
         mW6jgklaTqDtue/bF9ru7Tw2R3jN5yq/zzoaUvt4=
Date:   Wed, 12 May 2021 20:40:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     vbabka@suse.cz, iamjoonsoo.kim@lge.com, rientjes@google.com,
        penberg@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in
 kmalloc_index() to compile-time
Message-Id: <20210512204024.401ff3de38649d7d0f5a45e8@linux-foundation.org>
In-Reply-To: <20210513031220.GA133011@hyeyoo>
References: <20210511173448.GA54466@hyeyoo>
        <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
        <20210513031220.GA133011@hyeyoo>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 12:12:20 +0900 Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

> On Wed, May 12, 2021 at 07:52:27PM -0700, Andrew Morton wrote:
> > This explodes in mysterious ways.  The patch as I have it is appended,
> > for reference.
> > 
> > gcc-10.3.0 allmodconfig.
> > 
> > This patch suppresses the error:
> > 
> > --- a/mm/kfence/kfence_test.c~a
> > +++ a/mm/kfence/kfence_test.c
> > @@ -318,13 +318,13 @@ static void test_out_of_bounds_read(stru
> >  
> >  	/* Test both sides. */
> >  
> > -	buf = test_alloc(test, size, GFP_KERNEL, ALLOCATE_LEFT);
> > +	buf = test_alloc(test, 32, GFP_KERNEL, ALLOCATE_LEFT);
> >  	expect.addr = buf - 1;
> >  	READ_ONCE(*expect.addr);
> >  	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> >  	test_free(buf);
> >
> > -	buf = test_alloc(test, size, GFP_KERNEL, ALLOCATE_RIGHT);
> > +	buf = test_alloc(test, 32, GFP_KERNEL, ALLOCATE_RIGHT);
> >  	expect.addr = buf + size;
> >  	READ_ONCE(*expect.addr);
> >  	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> > @@ -519,11 +519,11 @@ static void test_free_bulk(struct kunit
> >  		const size_t size = setup_test_cache(test, 8 + prandom_u32_max(300), 0,
> >  						     (iter & 1) ? ctor_set_x : NULL);
> >  		void *objects[] = {
> > -			test_alloc(test, size, GFP_KERNEL, ALLOCATE_RIGHT),
> > -			test_alloc(test, size, GFP_KERNEL, ALLOCATE_NONE),
> > -			test_alloc(test, size, GFP_KERNEL, ALLOCATE_LEFT),
> > -			test_alloc(test, size, GFP_KERNEL, ALLOCATE_NONE),
> > -			test_alloc(test, size, GFP_KERNEL, ALLOCATE_NONE),
> > +			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_RIGHT),
> > +			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_NONE),
> > +			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_LEFT),
> > +			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_NONE),
> > +			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_NONE),
> >  		};
> >  
> >  		kmem_cache_free_bulk(test_cache, ARRAY_SIZE(objects), objects);
> >
> >
> > Is gcc-10.3.0 simply confused?  test_out_of_bounds_read() is clearly
> > calling kmalloc_index(32) which is OK.
> >
> > Anyway, I'll drop this patch for now so I can compile a kernel!
> >
> 
> The error messages isn't so clear to me.
> but one problem I can see is in kfence_test.c, there are many places that
> are using size which is not constant.

Ah, yes, of course, your patch changes kmalloc_index() to require that
it always is called with a constant `size'.  kfence_test doesn't do
that.

kfence is being a bit naughty here - the other kmalloc_index() callers
only comple up the call after verifying that `size' is a compile-time
constant.

Would something like this work?

 include/linux/slab.h    |   12 ++++++++----
 mm/kfence/kfence_test.c |    4 ++--
 2 files changed, 10 insertions(+), 6 deletions(-)

--- a/include/linux/slab.h~b
+++ a/include/linux/slab.h
@@ -374,7 +374,8 @@ static __always_inline enum kmalloc_cach
  * Note: there's no need to optimize kmalloc_index because it's evaluated
  * in compile-time.
  */
-static __always_inline unsigned int kmalloc_index(size_t size)
+static __always_inline unsigned int kmalloc_index(size_t size,
+						  bool size_is_constant)
 {
 	if (!size)
 		return 0;
@@ -410,7 +411,10 @@ static __always_inline unsigned int kmal
 	if (size <=  16 * 1024 * 1024) return 24;
 	if (size <=  32 * 1024 * 1024) return 25;
 
-	BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
+	if (size_is_constant)
+		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
+	else
+		BUG();
 
 	/* Will never be reached. Needed because the compiler may complain */
 	return -1;
@@ -575,7 +579,7 @@ static __always_inline void *kmalloc(siz
 		if (size > KMALLOC_MAX_CACHE_SIZE)
 			return kmalloc_large(size, flags);
 #ifndef CONFIG_SLOB
-		index = kmalloc_index(size);
+		index = kmalloc_index(size, true);
 
 		if (!index)
 			return ZERO_SIZE_PTR;
@@ -593,7 +597,7 @@ static __always_inline void *kmalloc_nod
 #ifndef CONFIG_SLOB
 	if (__builtin_constant_p(size) &&
 		size <= KMALLOC_MAX_CACHE_SIZE) {
-		unsigned int i = kmalloc_index(size);
+		unsigned int i = kmalloc_index(size, true);
 
 		if (!i)
 			return ZERO_SIZE_PTR;
--- a/mm/kfence/kfence_test.c~b
+++ a/mm/kfence/kfence_test.c
@@ -197,7 +197,7 @@ static void test_cache_destroy(void)
 
 static inline size_t kmalloc_cache_alignment(size_t size)
 {
-	return kmalloc_caches[kmalloc_type(GFP_KERNEL)][kmalloc_index(size)]->align;
+	return kmalloc_caches[kmalloc_type(GFP_KERNEL)][kmalloc_index(size, false)]->align;
 }
 
 /* Must always inline to match stack trace against caller. */
@@ -267,7 +267,7 @@ static void *test_alloc(struct kunit *te
 
 		if (is_kfence_address(alloc)) {
 			struct page *page = virt_to_head_page(alloc);
-			struct kmem_cache *s = test_cache ?: kmalloc_caches[kmalloc_type(GFP_KERNEL)][kmalloc_index(size)];
+			struct kmem_cache *s = test_cache ?: kmalloc_caches[kmalloc_type(GFP_KERNEL)][kmalloc_index(size, false)];
 
 			/*
 			 * Verify that various helpers return the right values
_

