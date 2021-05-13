Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792DD37F6E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhEMLjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:39:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:46110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233431AbhEMLiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:38:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 70C69B021;
        Thu, 13 May 2021 11:37:39 +0000 (UTC)
To:     Marco Elver <elver@google.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210511173448.GA54466@hyeyoo>
 <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
 <20210513031220.GA133011@hyeyoo>
 <20210512204024.401ff3de38649d7d0f5a45e8@linux-foundation.org>
 <20210513062809.GA319973@hyeyoo>
 <a36ab9a1-f07a-42ca-bb11-5bd0c70660bb@suse.cz>
 <YJ0ACtMpasnoZdUp@elver.google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in kmalloc_index()
 to compile-time
Message-ID: <90c1b2ae-a5c1-07d1-b056-5b3699b6cc77@suse.cz>
Date:   Thu, 13 May 2021 13:37:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJ0ACtMpasnoZdUp@elver.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/21 12:31 PM, Marco Elver wrote:
> On Thu, May 13, 2021 at 10:51AM +0200, Vlastimil Babka wrote:
>> On 5/13/21 8:28 AM, Hyeonggon Yoo wrote:
>> > On Wed, May 12, 2021 at 08:40:24PM -0700, Andrew Morton wrote:
>> >> On Thu, 13 May 2021 12:12:20 +0900 Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>> >> > On Wed, May 12, 2021 at 07:52:27PM -0700, Andrew Morton wrote:
>> >> > > This explodes in mysterious ways.  The patch as I have it is appended,
>> >> > > for reference.
>> >> > > 
>> >> > > gcc-10.3.0 allmodconfig.
>> >> > > 
>> >> > > This patch suppresses the error:
>> >> 
>> >> Ah, yes, of course, your patch changes kmalloc_index() to require that
>> >> it always is called with a constant `size'.  kfence_test doesn't do
>> >> that.
>> >> 
>> >> kfence is being a bit naughty here - the other kmalloc_index() callers
>> >> only comple up the call after verifying that `size' is a compile-time
>> >> constant.
>> 
>> Agreed.
> 
> It's just a test, and performance doesn't matter for it.

Sure. But what if there appear more users where it will matter. Those would get
better performance out of kmalloc_slab().

> The thing is this function lives in <linux/slab.h>, isn't prefixed with
> __ or anything like that, so it really does look like a public function.
> 
>> >> Would something like this work?
>> 
>> I'd prefer if we kept kmalloc_index() for constant sizes only. The broken build
>> then warns anyone using it the wrong way that they shouldn't.
> 
> Agreed. Andrew's size_is_constant would do that. Also see my suggestion
> below to keep the same interface.
> 
>> Besides, it really
>> shouldn't be used outside of slab.
> 
> It's an allocator test. If we want to facilitate testing, it must be
> allowed to verify or set up test cases that test boundary conditions
> based on internal state.
> 
> In the case of kfence_test it wants:  the cache's alignment to create
> accesses that fall on alignment boundaries; and to verify obj_to_index()
> and objs_per_slab_page() are set up correctly.

OK.

> I think the requirements are:
> 
> 1. Make the interface hard to abuse. Adding the BUILD_BUG_ON does that.

Yes.

> 2. Facilitate testing.

Right.

>> But if kfence test really needs this, we could perhaps extract the index
>> determining part out of kmalloc_slab().
> 
> That would duplicate kmalloc_index()? I don't see the need, let's keep
> things simple.

They are already "duplicated". But one is tailored for constant sizes, the other
for variable sizes.

>> Hmm or I guess the kfence tests could just use kmalloc_slab() directly?
> 
> kmalloc_slab() is internal to slab and should not be exported.

So should be kmalloc_index(). However it needs to have the full implementation
in a header accessible to all kmalloc() users to work, so it's there, visible to
anyone.

> It'd
> require exporting because the tests can be built as modules.

That's true.

> kmalloc_index() works perfectly fine, and the test really doesn't care
> about performance of kmalloc_index(). :-)

OK then.

> See my suggestion below that builds on Andrew's size_is_constant but
> would retain the old interface and support testing.

I can accept that, but please also modify/expand the newly added comment. Now
it's *normally* evaluated in compile-time. And there should be warning that
anyone calling it with size_is_constant == false should do that only in context
where performance (and code bloat, most likely too) doesn't matter, such as unit
test.

Thanks, Vlastimil

> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> From: Marco Elver <elver@google.com>
> Subject: [PATCH] kfence: test: fix for "mm, slub: change run-time assertion in
>  kmalloc_index() to compile-time"
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/slab.h    | 9 +++++++--
>  mm/kfence/kfence_test.c | 5 +++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 27d142564557..7a10bdc4b7a9 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -350,7 +350,8 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>   * Note: there's no need to optimize kmalloc_index because it's evaluated
>   * in compile-time.
>   */
> -static __always_inline unsigned int kmalloc_index(size_t size)
> +static __always_inline unsigned int __kmalloc_index(size_t size,
> +						    bool size_is_constant)
>  {
>  	if (!size)
>  		return 0;
> @@ -386,11 +387,15 @@ static __always_inline unsigned int kmalloc_index(size_t size)
>  	if (size <=  16 * 1024 * 1024) return 24;
>  	if (size <=  32 * 1024 * 1024) return 25;
>  
> -	BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
> +	if (size_is_constant)
> +		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
> +	else
> +		BUG();
>  
>  	/* Will never be reached. Needed because the compiler may complain */
>  	return -1;
>  }
> +#define kmalloc_index(s) __kmalloc_index(s, true)
>  #endif /* !CONFIG_SLOB */
>  
>  void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __malloc;
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 4acf4251ee04..7f24b9bcb2ec 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -197,7 +197,7 @@ static void test_cache_destroy(void)
>  
>  static inline size_t kmalloc_cache_alignment(size_t size)
>  {
> -	return kmalloc_caches[kmalloc_type(GFP_KERNEL)][kmalloc_index(size)]->align;
> +	return kmalloc_caches[kmalloc_type(GFP_KERNEL)][__kmalloc_index(size, false)]->align;
>  }
>  
>  /* Must always inline to match stack trace against caller. */
> @@ -267,7 +267,8 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
>  
>  		if (is_kfence_address(alloc)) {
>  			struct page *page = virt_to_head_page(alloc);
> -			struct kmem_cache *s = test_cache ?: kmalloc_caches[kmalloc_type(GFP_KERNEL)][kmalloc_index(size)];
> +			struct kmem_cache *s = test_cache ?:
> +					kmalloc_caches[kmalloc_type(GFP_KERNEL)][__kmalloc_index(size, false)];
>  
>  			/*
>  			 * Verify that various helpers return the right values
> 

