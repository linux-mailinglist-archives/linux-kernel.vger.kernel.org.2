Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC258395766
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhEaIw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhEaIwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:52:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527A2C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:50:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v23so7752584wrd.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xzFWtmO7IWsEOm3BlqiJN4JSZLZ8qP1HgDEe5DSYe7k=;
        b=sRi9Gk3h6xwBThVxf/KoTOl1mvaYXyApZQUJ+HB0E1I9eHhPdrk184cZV12+YwlQ35
         VODS9ZIT6REylSsDG+Y+1aDGyh/cyBKs2HspLsrv1QRoz98lx5cGlK45XwUKNvURcEZD
         ttivdh/myj0RGbA2qAD/+VDU92sjdDgguem4T9iUxPM9R9LffhxBfO6Itp7f4qp3B/TV
         VveYyo5f6cf/Xiqa9p7U/ylIvQGq7NiQh5/reId0J9np3c+9D4on7SwBwTU71kzfhV4R
         BCucct8BC1r0PoZRlW/u+23o7KJoacqSMcn437f+R1REuKy2GSneSsVsa5IVytzsY1zn
         1sAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xzFWtmO7IWsEOm3BlqiJN4JSZLZ8qP1HgDEe5DSYe7k=;
        b=HbflSD7U1pT4b6dBm9pT7ndfqYwbZgvgnF99vwvfGyZIOhjAddF45EtJRM5Dj4GcoD
         rej3Dq2c2HgrQ52gQY/cqZ8/dTLHdbibxhR07CqwmUVI0m09al9Lr7IhLWs3DRYNT0wc
         W4l2S89Wl7BCTnCJBkFMkXOz1CE4xuCXUI65V09cCx1yy7nasvyt+loVJ6rhWJpNXehu
         9gVB/Ajt04LN26XbUrxb/O15DUmdI+yzebw/p59b32y+C+L22Uf2Uueni5P8wRa8PtU+
         tRkU4l79QiAlKue52CrXRy0uzRd3DHWU22S5xBovjqA9frjXdDZgaWK9DsYtghCH7eTD
         Gnig==
X-Gm-Message-State: AOAM531/fQ0PH9oB4C7K73n7XT5z7BpCONph7FBIzwHOtcMjcoCxHwBB
        Pp9GxncmGDxkpMcP6uhl7TUIoQ==
X-Google-Smtp-Source: ABdhPJywSWha3q5SYCbLXV8L07WKM/RhzIw1aoQXM7jj3t+h1qRIfbkYuVj6W7TGOLB8m/e7tBeVOg==
X-Received: by 2002:a5d:64eb:: with SMTP id g11mr21462862wri.260.1622451030640;
        Mon, 31 May 2021 01:50:30 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:79b2:9d30:345a:1523])
        by smtp.gmail.com with ESMTPSA id q3sm16285716wrr.43.2021.05.31.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 01:50:29 -0700 (PDT)
Date:   Mon, 31 May 2021 10:50:24 +0200
From:   Marco Elver <elver@google.com>
To:     Kuan-Ying Lee <kylee0686026@gmail.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Walter Wu <walter-zh.wu@mediatek.com>
Subject: Re: [PATCH 1/1] kasan: add memory corruption identification for
 hardware tag-based mode
Message-ID: <YLSjUOVo5c+gTbzA@elver.google.com>
References: <20210530044708.7155-1-kylee0686026@gmail.com>
 <20210530044708.7155-2-kylee0686026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530044708.7155-2-kylee0686026@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 12:47PM +0800, Kuan-Ying Lee wrote:
> Add memory corruption identification at bug report for hardware tag-based
> mode. The report shows whether it is "use-after-free" or "out-of-bound"
> error instead of "invalid-access" error. This will make it easier for
> programmers to see the memory corruption problem.
> 
> We extend the slab to store five old free pointer tag and free backtrace,
> we can check if the tagged address is in the slab record and make a good
> guess if the object is more like "use-after-free" or "out-of-bound".
> therefore every slab memory corruption can be identified whether it's
> "use-after-free" or "out-of-bound".
> 
> Signed-off-by: Kuan-Ying Lee <kylee0686026@gmail.com>

On a whole this makes sense because SW_TAGS mode supports this, too.

My main complaints are the copy-paste of the SW_TAGS code.

Does it make sense to refactor per my suggestions below?

This is also a question to KASAN maintainers (Andrey, any preference?).

> ---
>  lib/Kconfig.kasan         |  8 ++++++++
>  mm/kasan/hw_tags.c        | 25 ++++++++++++++++++++++---
>  mm/kasan/kasan.h          |  4 ++--
>  mm/kasan/report_hw_tags.c | 28 ++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index cffc2ebbf185..f7e666b23058 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -163,6 +163,14 @@ config KASAN_SW_TAGS_IDENTIFY
>  	  (use-after-free or out-of-bounds) at the cost of increased
>  	  memory consumption.
>  
> +config KASAN_HW_TAGS_IDENTIFY
> +	bool "Enable memory corruption identification"
> +	depends on KASAN_HW_TAGS
> +	help
> +	  This option enables best-effort identification of bug type
> +	  (use-after-free or out-of-bounds) at the cost of increased
> +	  memory consumption.

Can we rename KASAN_SW_TAGS_IDENTIFY -> KASAN_TAGS_IDENTIFY in a
separate patch and then use that?

Or do we have a problem renaming this options if there are existing
users of it?

>  config KASAN_VMALLOC
>  	bool "Back mappings in vmalloc space with real shadow memory"
>  	depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 4004388b4e4b..b1c6bb116600 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -220,22 +220,41 @@ void kasan_set_free_info(struct kmem_cache *cache,
>  				void *object, u8 tag)
>  {
>  	struct kasan_alloc_meta *alloc_meta;
> +	u8 idx = 0;
>  
>  	alloc_meta = kasan_get_alloc_meta(cache, object);
> -	if (alloc_meta)
> -		kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
> +	if (!alloc_meta)
> +		return;
> +
> +#ifdef CONFIG_KASAN_HW_TAGS_IDENTIFY
> +	idx = alloc_meta->free_track_idx;
> +	alloc_meta->free_pointer_tag[idx] = tag;
> +	alloc_meta->free_track_idx = (idx + 1) % KASAN_NR_FREE_STACKS;
> +#endif
> +
> +	kasan_set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
>  }
>  
>  struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>  				void *object, u8 tag)
>  {
>  	struct kasan_alloc_meta *alloc_meta;
> +	int i = 0;
>  
>  	alloc_meta = kasan_get_alloc_meta(cache, object);
>  	if (!alloc_meta)
>  		return NULL;
>  
> -	return &alloc_meta->free_track[0];
> +#ifdef CONFIG_KASAN_HW_TAGS_IDENTIFY
> +	for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> +		if (alloc_meta->free_pointer_tag[i] == tag)
> +			break;
> +	}
> +	if (i == KASAN_NR_FREE_STACKS)
> +		i = alloc_meta->free_track_idx;
> +#endif
> +
> +	return &alloc_meta->free_track[i];
>  }

Again, we now have code duplication. These functions are now identical
to the sw_tags.c ones?

Does it make sense to also move them in a preparatory patch to a new
'tags.c'?

>  #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8f450bc28045..41b47f456130 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -153,7 +153,7 @@ struct kasan_track {
>  	depot_stack_handle_t stack;
>  };
>  
> -#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> +#if defined(CONFIG_KASAN_SW_TAGS_IDENTIFY) || defined(CONFIG_KASAN_HW_TAGS_IDENTIFY)
>  #define KASAN_NR_FREE_STACKS 5
>  #else
>  #define KASAN_NR_FREE_STACKS 1
> @@ -170,7 +170,7 @@ struct kasan_alloc_meta {
>  #else
>  	struct kasan_track free_track[KASAN_NR_FREE_STACKS];
>  #endif
> -#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> +#if defined(CONFIG_KASAN_SW_TAGS_IDENTIFY) || defined(CONFIG_KASAN_HW_TAGS_IDENTIFY)
>  	u8 free_pointer_tag[KASAN_NR_FREE_STACKS];
>  	u8 free_track_idx;
>  #endif
> diff --git a/mm/kasan/report_hw_tags.c b/mm/kasan/report_hw_tags.c
> index 42b2168755d6..d77109b85a09 100644
> --- a/mm/kasan/report_hw_tags.c
> +++ b/mm/kasan/report_hw_tags.c
> @@ -14,9 +14,37 @@
>  #include <linux/types.h>
>  
>  #include "kasan.h"
> +#include "../slab.h"
>  
>  const char *kasan_get_bug_type(struct kasan_access_info *info)
>  {
> +#ifdef CONFIG_KASAN_HW_TAGS_IDENTIFY
> +	struct kasan_alloc_meta *alloc_meta;
> +	struct kmem_cache *cache;
> +	struct page *page;
> +	const void *addr;
> +	void *object;
> +	u8 tag;
> +	int i;
> +
> +	tag = get_tag(info->access_addr);
> +	addr = kasan_reset_tag(info->access_addr);
> +	page = kasan_addr_to_page(addr);
> +	if (page && PageSlab(page)) {
> +		cache = page->slab_cache;
> +		object = nearest_obj(cache, page, (void *)addr);
> +		alloc_meta = kasan_get_alloc_meta(cache, object);
> +
> +		if (alloc_meta) {
> +			for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> +				if (alloc_meta->free_pointer_tag[i] == tag)
> +					return "use-after-free";
> +			}
> +		}
> +		return "out-of-bounds";
> +	}
> +
> +#endif
>  	return "invalid-access";
>  }

This function is an almost copy-paste of what we have in
report_sw_tags.c. Does it make sense to try and share this code or would
it complicate things?

I imagine we could have a header report_tags.h, which defines a static
const char *kasan_try_get_bug_type(..), and simply returns NULL if it
couldn't identify it:

	#if defined(CONFIG_KASAN_SW_TAGS_IDENTIFY) || defined(CONFIG_KASAN_HW_TAGS_IDENTIFY)
	static const char *kasan_try_get_bug_type(struct kasan_access_info *info)
	{
		... the code above ...

		return NULL;
	}
	#else
	static const char *kasan_try_get_bug_type(struct kasan_access_info *info) { return NULL; }
	#endif


Thanks,
-- Marco
