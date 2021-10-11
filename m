Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2299B428797
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhJKHZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbhJKHZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:25:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E914C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:23:40 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 21so4502876plo.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+wjcgXWzQZD7HaXDjp6jzo5agAgGWRJse11x4Bu0/cM=;
        b=cPUgApwliW+Cbo9e9tFlVhVKvscJY5IcH9fd2lqUHM7RciAKMxgnYuFrsYcnifkTvn
         pU5RudlReApPsGGYMn5Ay0PnPzXQMULaQOjadcgWzFmgcguoOVR2uXUOu9GdL0euBCYu
         tY2yYy1UDlNuZzreD2I8Tu7wQmghfBYFEGKVfXC6LlpNoiNyoknVGDsUKiuwbYV5x8+j
         SfIfVhrGzIZXUSn+VZ1nRzlW4jiSJWHTEmB/BHv+BI9/NXh+mc5jSFg6Bwmb4DjLostI
         D3fBD3jrbpNv5n5M4n6HqoI8ZEpfPPTVZPf+igpMw70mZGfzoZ1sa3onO820rajL7EDu
         RwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+wjcgXWzQZD7HaXDjp6jzo5agAgGWRJse11x4Bu0/cM=;
        b=Q+NaphSe5OyShMbRjBO/U1ooJ3Y3zMx9gvsIEN1AVwq1bU9qxN6IdfE3nzbsyrQHMb
         pZkYMGxVFd1xwhWIz6dmZe7kWiMtBXMEroMMq6FwLhRZbVbe9BgEH9fsryv+wSoxTMRh
         ZvLsSqN9ewjCf7wmPZBCbogY4REH7zszkgN/wwd9ESqekiirJ+x0W6BwtLwx+YpHynOO
         u0yo8ihdTPfxQkKBhgQSVVE/2KsLHq4BMqHsKy7nPxWOVT0NWZ+WF8t7KY6Ri3+liUzV
         f8Urs+pm+z1YF4xe2tfjLL8XPEKzu3ZGvFXHCS82TF2PZJi7sZ1CxKuNBClziDxLCRQx
         byog==
X-Gm-Message-State: AOAM5332U8QMvU+P+iRtl9PIGvTYA09pgFOIL9YzaIV8XXCNbmWGu4bB
        knHg0vKgp5ediyy/LXVA+Yc=
X-Google-Smtp-Source: ABdhPJw06fGR1fY3AjB1GwEyJNne3+wG6k5M7it+RndbaWuqoTE5RZNIXH2CIlIPGJ834ALpnVH4Wg==
X-Received: by 2002:a17:902:70cb:b0:13e:91f3:641a with SMTP id l11-20020a17090270cb00b0013e91f3641amr22833719plt.13.1633937019980;
        Mon, 11 Oct 2021 00:23:39 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id t1sm3818890pfe.51.2021.10.11.00.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 00:23:39 -0700 (PDT)
Date:   Mon, 11 Oct 2021 07:23:35 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm, slub: Use prefetchw instead of prefetch
Message-ID: <20211011072335.GA63489@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211008133602.4963-1-42.hyeyoo@gmail.com>
 <30a76d87-e0af-3eec-d095-d87e898b31cf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a76d87-e0af-3eec-d095-d87e898b31cf@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 03:49:07PM -0700, David Rientjes wrote:
> On Fri, 8 Oct 2021, Hyeonggon Yoo wrote:
> 
> > It's certain that an object will be not only read, but also
> > written after allocation.
> > 
> 
> Why is it certain?  I think perhaps what you meant to say is that if we 
> are doing any prefetching here, then access will benefit from prefetchw 
> instead of prefetch.  But it's not "certain" that allocated memory will be 
> accessed at all.
>

Blame my english skill :(

When I wrote I thought it was ok, but it was unclear.
Thank you for pointing them!

What I meant was "When accessing an object, it must be written before read.
So There's no situation that caller only reads an object and does not
write. Thus it's better to use prefetchw instead of prefetch.".

Let's rephrase:

commit 0ad9500e16fe ("slub: prefetch next freelist pointer in 
slab_alloc()") introduced prefetch_freepointer() because when other cpu(s)
freed objects into a page that current cpu owns, the freelist link is
hot on cpu(s) which freed objects and possibly very cold on current cpu.

But if freelist link chain is hot on cpu(s) which freed	objects,
it's better to invalidate that chain because they're not going to access
again within a short time.

So use prefetchw instead of prefetch. On supported architectures like x86,
it invalidates other copied instances of a cache line when prefetching it.

> > Use prefetchw instead of prefetchw. On supported architecture
> 
> If we're using prefetchw instead of prefetchw, I think the diff would be 
> 0 lines changed :)
>

That was my typo. thankfully Andrew fixed that.

> > like x86, it helps to invalidate cache line when the object exists
> > in other processors' cache.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> >  mm/slub.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 3d2025f7163b..2aca7523165e 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -352,9 +352,9 @@ static inline void *get_freepointer(struct kmem_cache *s, void *object)
> >  	return freelist_dereference(s, object + s->offset);
> >  }
> >  
> > -static void prefetch_freepointer(const struct kmem_cache *s, void *object)
> > +static void prefetchw_freepointer(const struct kmem_cache *s, void *object)
> >  {
> > -	prefetch(object + s->offset);
> > +	prefetchw(object + s->offset);
> >  }
> >  
> >  static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
> > @@ -3195,10 +3195,9 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
> >  			note_cmpxchg_failure("slab_alloc", s, tid);
> >  			goto redo;
> >  		}
> > -		prefetch_freepointer(s, next_object);
> > +		prefetchw_freepointer(s, next_object);
> >  		stat(s, ALLOC_FASTPATH);
> >  	}
> > -
> >  	maybe_wipe_obj_freeptr(s, object);
> >  	init = slab_want_init_on_alloc(gfpflags, s);
> >  
> > -- 
> > 2.27.0
> > 
> > 
