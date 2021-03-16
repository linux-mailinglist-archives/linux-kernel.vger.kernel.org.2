Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CCF33DD57
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbhCPTWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236324AbhCPTWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:22:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7A6A6505E;
        Tue, 16 Mar 2021 19:22:42 +0000 (UTC)
Date:   Tue, 16 Mar 2021 19:22:40 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: Issue with kfence and kmemleak
Message-ID: <20210316192240.GC28565@arm.com>
References: <YFDf6iKH1p/jGnM0@suse.de>
 <YFDrGL45JxFHyajD@elver.google.com>
 <20210316181938.GA28565@arm.com>
 <YFD9JEdQNI1TqSuL@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFD9JEdQNI1TqSuL@elver.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 07:47:00PM +0100, Marco Elver wrote:
> One thing I've just run into: "BUG: KFENCE: out-of-bounds read in
> scan_block+0x6b/0x170 mm/kmemleak.c:1244"
> 
> Probably because kmemleak is passed the rounded size for the size-class,
> and not the real allocation size. Can this be fixed with
> kmemleak_ignore() only called on the KFENCE guard pages?

If it's only on the occasional object, you can do a
kmemleak_scan_area() but some care needed as this in turn allocates
memory for kmemleak internal metadata.

> I'd like kmemleak to scan the valid portion of an object allocated
> through KFENCE, but no further than that.
> 
> Or do we need to fix the size if it's a kfence object:
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index c0014d3b91c1..fe6e3ae8e8c6 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -97,6 +97,7 @@
>  #include <linux/atomic.h>
>  
>  #include <linux/kasan.h>
> +#include <linux/kfence.h>
>  #include <linux/kmemleak.h>
>  #include <linux/memory_hotplug.h>
>  
> @@ -589,7 +590,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>  	atomic_set(&object->use_count, 1);
>  	object->flags = OBJECT_ALLOCATED;
>  	object->pointer = ptr;
> -	object->size = size;
> +	object->size = kfence_ksize((void *)ptr) ?: size;
>  	object->excess_ref = 0;
>  	object->min_count = min_count;
>  	object->count = 0;			/* white color initially */
> 
> The alternative is to call kfence_ksize() in slab_post_alloc_hook() when
> calling kmemleak_alloc.

One of these is probably the easiest. If kfence only works on slab
objects, better to pass the right size from slab_post_alloc_hook(). If
you plan to expand it later to vmalloc(), just fix the size in
create_object().

-- 
Catalin
