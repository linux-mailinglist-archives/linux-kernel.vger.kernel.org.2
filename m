Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5643966F7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhEaR0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbhEaRZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:25:54 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DE6C0494C2
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 08:59:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x10so4507678plg.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=by1GcBcH0zFhFff68TJvck6DvOHLGQmEOlvl4E3sn6M=;
        b=vFmuMxLRM/ih1j2p7F8wLwWgkF1iFs+NvPFUsy70GFMgdx4AXdMY453+CXh3ThL4US
         bIPMScVmx2pLEtvfTdIBRZkWCFY8opLEsQFXpgPbwy0dvsniGOZ1uq9eFWksxU/sfx9j
         bOgUwCwK+hHUDEwWtuTKPu/9mM3Nn/Ek0WAkmBAtgfjKpVYk3flRxaQq6BVPSVQ9XOQH
         u/lud62I02uRMM59gVQufWFVmcKS9rtVKaIk2l7K1SaiYZ5BEAfw+M5NNFLNI2W3gV6u
         q0U3Blg7NCOYEPT7jlkqWFa68hTnefeZmfCbTS+m7+qAvTE1fcHvD99NhB5Rb1MARg1I
         a4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=by1GcBcH0zFhFff68TJvck6DvOHLGQmEOlvl4E3sn6M=;
        b=VFAj5BUWHSozCLjvsf2KSnuKqxZ1pWVttNuo2lupykHlMI9D++JdtiqTh7HJRt/Fmo
         XcW9z2z3g56vac3sAi5DIPC57sZXpQAhPa8rtB4gPr3uEGVaxLvbzRQuYE+MOyF5NskJ
         gDw7JyTpg5p1nJS6x9TlSOCVlqT8Cbm213wb0XFT38nAV0JVrMgcpcguuqrxi6wRmmvB
         Kt4sDM2AvfK/qAFcSmHRaCQRXbIKJN/OTXuzHp2t/jUL/1lKMOmLqHqS9BwMCmlFWSKv
         lClWB8NzGTkZNYC4pnbl0NgdO/KQjfIEwBac0ZvFcOCK47J7hsDXQQg6UNUK4I/AwJkE
         0koA==
X-Gm-Message-State: AOAM532V1zr3HaJ6jJ7AqsHcDM4LiG8CiGt5oKoOJq8xCKYfT5BYNerk
        q639huyKO6ALahxmZKUDnCaTaG8fB8k=
X-Google-Smtp-Source: ABdhPJzAxVinrqMqECdArRhmK6XX4V9ChEcaLVGeTfnV3wR9FCIx9LClc5jSBEFtZ+YyUmDm8LNpJA==
X-Received: by 2002:a17:90a:668d:: with SMTP id m13mr15376267pjj.144.1622476758139;
        Mon, 31 May 2021 08:59:18 -0700 (PDT)
Received: from DESKTOP-PJLD54P.localdomain (122-116-74-98.HINET-IP.hinet.net. [122.116.74.98])
        by smtp.gmail.com with ESMTPSA id t12sm11259049pjw.57.2021.05.31.08.59.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 May 2021 08:59:17 -0700 (PDT)
Date:   Mon, 31 May 2021 23:59:12 +0800
From:   Kuan-Ying Lee <kylee0686026@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Walter Wu <walter-zh.wu@mediatek.com>
Subject: Re: [PATCH 1/1] kasan: add memory corruption identification for
 hardware tag-based mode
Message-ID: <20210531155912.GC622@DESKTOP-PJLD54P.localdomain>
References: <20210530044708.7155-1-kylee0686026@gmail.com>
 <20210530044708.7155-2-kylee0686026@gmail.com>
 <YLSjUOVo5c+gTbzA@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLSjUOVo5c+gTbzA@elver.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 10:50:24AM +0200, Marco Elver wrote:
> On Sun, May 30, 2021 at 12:47PM +0800, Kuan-Ying Lee wrote:
> > Add memory corruption identification at bug report for hardware tag-based
> > mode. The report shows whether it is "use-after-free" or "out-of-bound"
> > error instead of "invalid-access" error. This will make it easier for
> > programmers to see the memory corruption problem.
> > 
> > We extend the slab to store five old free pointer tag and free backtrace,
> > we can check if the tagged address is in the slab record and make a good
> > guess if the object is more like "use-after-free" or "out-of-bound".
> > therefore every slab memory corruption can be identified whether it's
> > "use-after-free" or "out-of-bound".
> > 
> > Signed-off-by: Kuan-Ying Lee <kylee0686026@gmail.com>
> 

> On a whole this makes sense because SW_TAGS mode supports this, too.
> 
> My main complaints are the copy-paste of the SW_TAGS code.
> 
> Does it make sense to refactor per my suggestions below?

Thanks for your suggestions.
I will refactor them in v2.
> 
> This is also a question to KASAN maintainers (Andrey, any preference?).
> 
> > ---
> >  lib/Kconfig.kasan         |  8 ++++++++
> >  mm/kasan/hw_tags.c        | 25 ++++++++++++++++++++++---
> >  mm/kasan/kasan.h          |  4 ++--
> >  mm/kasan/report_hw_tags.c | 28 ++++++++++++++++++++++++++++
> >  4 files changed, 60 insertions(+), 5 deletions(-)
> > 
> > diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> > index cffc2ebbf185..f7e666b23058 100644
> > --- a/lib/Kconfig.kasan
> > +++ b/lib/Kconfig.kasan
> > @@ -163,6 +163,14 @@ config KASAN_SW_TAGS_IDENTIFY
> >  	  (use-after-free or out-of-bounds) at the cost of increased
> >  	  memory consumption.
> >  
> > +config KASAN_HW_TAGS_IDENTIFY
> > +	bool "Enable memory corruption identification"
> > +	depends on KASAN_HW_TAGS
> > +	help
> > +	  This option enables best-effort identification of bug type
> > +	  (use-after-free or out-of-bounds) at the cost of increased
> > +	  memory consumption.
> 
> Can we rename KASAN_SW_TAGS_IDENTIFY -> KASAN_TAGS_IDENTIFY in a
> separate patch and then use that?
> 
> Or do we have a problem renaming this options if there are existing
> users of it?

I tend to keep KASAN_SW_TAGS_IDENTIFY and KASAN_HW_TAGS_IDENTIFY
separately.

We need these two configs to decide how many stacks we will store.

If we store as many stacks as SW tag-based kasan does(5 stacks), we might
mistake out-of-bound issues for use-after-free sometime. Becuase HW
tag-based kasan only has 16 kinds of tags. When Out-of-bound issues happened, it might
find the same tag in the stack we just stored and mistake happened.
There is high probability that this mistake will happen.
> 
> >  config KASAN_VMALLOC
> >  	bool "Back mappings in vmalloc space with real shadow memory"
> >  	depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
> > diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> > index 4004388b4e4b..b1c6bb116600 100644
> > --- a/mm/kasan/hw_tags.c
> > +++ b/mm/kasan/hw_tags.c
> > @@ -220,22 +220,41 @@ void kasan_set_free_info(struct kmem_cache *cache,
> >  				void *object, u8 tag)
> >  {
> >  	struct kasan_alloc_meta *alloc_meta;
> > +	u8 idx = 0;
> >  
> >  	alloc_meta = kasan_get_alloc_meta(cache, object);
> > -	if (alloc_meta)
> > -		kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
> > +	if (!alloc_meta)
> > +		return;
> > +
> > +#ifdef CONFIG_KASAN_HW_TAGS_IDENTIFY
> > +	idx = alloc_meta->free_track_idx;
> > +	alloc_meta->free_pointer_tag[idx] = tag;
> > +	alloc_meta->free_track_idx = (idx + 1) % KASAN_NR_FREE_STACKS;
> > +#endif
> > +
> > +	kasan_set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
> >  }
> >  
> >  struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> >  				void *object, u8 tag)
> >  {
> >  	struct kasan_alloc_meta *alloc_meta;
> > +	int i = 0;
> >  
> >  	alloc_meta = kasan_get_alloc_meta(cache, object);
> >  	if (!alloc_meta)
> >  		return NULL;
> >  
> > -	return &alloc_meta->free_track[0];
> > +#ifdef CONFIG_KASAN_HW_TAGS_IDENTIFY
> > +	for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> > +		if (alloc_meta->free_pointer_tag[i] == tag)
> > +			break;
> > +	}
> > +	if (i == KASAN_NR_FREE_STACKS)
> > +		i = alloc_meta->free_track_idx;
> > +#endif
> > +
> > +	return &alloc_meta->free_track[i];
> >  }
> 
> Again, we now have code duplication. These functions are now identical
> to the sw_tags.c ones?
> 
> Does it make sense to also move them in a preparatory patch to a new
> 'tags.c'?
> 
Yes, moving them into tags.c will be better.
I will refactor in v2.
> >  #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index 8f450bc28045..41b47f456130 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -153,7 +153,7 @@ struct kasan_track {
> >  	depot_stack_handle_t stack;
> >  };
> >  

I think my v1 patch sets KASAN_NR_FREE_STACKS to 5 is not suitable.
The same reason as above.

I am thinking to store 2 or 1 stacks is acceptable in HW tag-based kasan mode.
Does it make sense?
Any suggetions are appreciated.

> > -#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> > +#if defined(CONFIG_KASAN_SW_TAGS_IDENTIFY) || defined(CONFIG_KASAN_HW_TAGS_IDENTIFY)
> >  #define KASAN_NR_FREE_STACKS 5
> >  #else
> >  #define KASAN_NR_FREE_STACKS 1
> > @@ -170,7 +170,7 @@ struct kasan_alloc_meta {
> >  #else
> >  	struct kasan_track free_track[KASAN_NR_FREE_STACKS];
> >  #endif
> > -#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> > +#if defined(CONFIG_KASAN_SW_TAGS_IDENTIFY) || defined(CONFIG_KASAN_HW_TAGS_IDENTIFY)
> >  	u8 free_pointer_tag[KASAN_NR_FREE_STACKS];
> >  	u8 free_track_idx;
> >  #endif
> > diff --git a/mm/kasan/report_hw_tags.c b/mm/kasan/report_hw_tags.c
> > index 42b2168755d6..d77109b85a09 100644
> > --- a/mm/kasan/report_hw_tags.c
> > +++ b/mm/kasan/report_hw_tags.c
> > @@ -14,9 +14,37 @@
> >  #include <linux/types.h>
> >  
> >  #include "kasan.h"
> > +#include "../slab.h"
> >  
> >  const char *kasan_get_bug_type(struct kasan_access_info *info)
> >  {
> > +#ifdef CONFIG_KASAN_HW_TAGS_IDENTIFY
> > +	struct kasan_alloc_meta *alloc_meta;
> > +	struct kmem_cache *cache;
> > +	struct page *page;
> > +	const void *addr;
> > +	void *object;
> > +	u8 tag;
> > +	int i;
> > +
> > +	tag = get_tag(info->access_addr);
> > +	addr = kasan_reset_tag(info->access_addr);
> > +	page = kasan_addr_to_page(addr);
> > +	if (page && PageSlab(page)) {
> > +		cache = page->slab_cache;
> > +		object = nearest_obj(cache, page, (void *)addr);
> > +		alloc_meta = kasan_get_alloc_meta(cache, object);
> > +
> > +		if (alloc_meta) {
> > +			for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> > +				if (alloc_meta->free_pointer_tag[i] == tag)
> > +					return "use-after-free";
> > +			}
> > +		}
> > +		return "out-of-bounds";
> > +	}
> > +
> > +#endif
> >  	return "invalid-access";
> >  }
> 
> This function is an almost copy-paste of what we have in
> report_sw_tags.c. Does it make sense to try and share this code or would
> it complicate things?
> 

I got your point.
I will refactor them in v2.

Thanks,
Kuan-Ying Lee

> I imagine we could have a header report_tags.h, which defines a static
> const char *kasan_try_get_bug_type(..), and simply returns NULL if it
> couldn't identify it:
> 
> 	#if defined(CONFIG_KASAN_SW_TAGS_IDENTIFY) || defined(CONFIG_KASAN_HW_TAGS_IDENTIFY)
> 	static const char *kasan_try_get_bug_type(struct kasan_access_info *info)
> 	{
> 		... the code above ...
> 
> 		return NULL;
> 	}
> 	#else
> 	static const char *kasan_try_get_bug_type(struct kasan_access_info *info) { return NULL; }
> 	#endif
> 
> 
> Thanks,
> -- Marco
