Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF6E428F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbhJKN47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbhJKNzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:55:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFCDC0617BA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 06:49:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so41202pjq.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=10k7yW5D+4LcaavEb5KgVuWK4194TSdRqCJ594ZSvWA=;
        b=axzOdcRi/yOy+p9hDMR+1+O+pZU1fCauoQ9Njk5AED31qtK4Rah8yp6fEqHDT0/itl
         3TnBXFRyzrg2nq+Ssr+d1seLN7qw4Gqb6ePcAZUrfyNHUtUTKDSsvPmFBYP35f+UEYO7
         qGKlbWEIN6I7yLTT9JMnBvKhyGJx1GlpeUyXUriJVedzbg2Wp73mN6JN+bs6QBqgG1nS
         Ue0U0YnXR3FIMcJnkfJTmyoOl0NwaG82GW7ty0WutMC42B54QYHDeS0138Brf8GPrQuE
         dd3l3qQ1UvQCzQok8Rkc6J/NT/3VrkZmV2/awzTSN4+xhgDNAXRk5rrDAeFHx/OZ9aoF
         kJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=10k7yW5D+4LcaavEb5KgVuWK4194TSdRqCJ594ZSvWA=;
        b=2WIfa6r+C8zHVIMk0mKEcs+xc321rjNYJt3AkqJPggf96+KvYK33s8MmW22OC/PXXy
         X1hLXlFUP2i8EQWXpzQt0L6SV5l4vM/qYyiLqKlaoCZ9m5wuxNdZPF7/EmX5bnHOKdCm
         pDTV6nAYbsdpTlT9OKlnLzhtDYJO6PiMg/dSOhpOp6UkmZQPxj//rAb6zKw+du6GeZOO
         EAcx0/DkjmcsdYBAwr4kjV4MJViEEVAzF8Md4AWg+9gClG2ijinRZ1uLWG8fXKRF73BR
         ObiAUCY1TTt34XeRsbjwMBNKEJCOVCGYlsK6VW4ShfU3fZmGLkzsbfJQdm3M4Iv32E9Y
         uIfg==
X-Gm-Message-State: AOAM5332GCyIjshjjG/ye/ltQkoRCRIQ3GTkUOwA5KF8zZAvWNevrrul
        ej0KNjcKbv67dU+7TNxaXe8=
X-Google-Smtp-Source: ABdhPJz3V1dxqzffZBrfqWYqSkIM+OiMIjYd4IlGZQVCeDsPFh4svfFsLxExILNnp51bgm7brreAUg==
X-Received: by 2002:a17:902:9303:b029:12c:29c:43f9 with SMTP id bc3-20020a1709029303b029012c029c43f9mr24816562plb.5.1633960192750;
        Mon, 11 Oct 2021 06:49:52 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id t71sm8388480pgc.29.2021.10.11.06.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 06:49:52 -0700 (PDT)
Date:   Mon, 11 Oct 2021 13:49:48 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Perf and Hackbench results on my machine
Message-ID: <20211011134948.GA68654@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211008133602.4963-1-42.hyeyoo@gmail.com>
 <30a76d87-e0af-3eec-d095-d87e898b31cf@google.com>
 <904b6e72-cc2e-2e4d-5601-dacab734bf15@suse.cz>
 <20211011103302.GA65713@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011103302.GA65713@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 10:33:02AM +0000, Hyeonggon Yoo wrote:
> Hello Vlastimil.
> 
> On Mon, Oct 11, 2021 at 09:21:01AM +0200, Vlastimil Babka wrote:
> > On 10/11/21 00:49, David Rientjes wrote:
> > > On Fri, 8 Oct 2021, Hyeonggon Yoo wrote:
> > > 
> > >> It's certain that an object will be not only read, but also
> > >> written after allocation.
> > >> 
> > > 
> > > Why is it certain?  I think perhaps what you meant to say is that if we 
> > > are doing any prefetching here, then access will benefit from prefetchw 
> > > instead of prefetch.  But it's not "certain" that allocated memory will be 
> > > accessed at all.
> > 
> > I think the primary reason there's a prefetch is freelist traversal. The
> > cacheline we prefetch will be read during the next allocation, so if we
> > expect there to be one soon, prefetch might help.
> 
> I agree that.
> 
> > That the freepointer is
> > part of object itself and thus the cache line will be probably accessed also
> > after the allocation, is secondary.
> 
> Right. it depends on cache line size and whether first cache line of an
> object is frequently accessed or not.

Not first cache line because free pointer is in the middle of object or
out of object area. my mistake.

> >> Use prefetchw instead of prefetchw. On supported architecture
> >
> > If we're using prefetchw instead of prefetchw, I think the diff would be
> > 0 lines changed :)
> >
> >> like x86, it helps to invalidate cache line when the object exists
> >> in other processors' cache.
> >>
> >> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> >> ---
> >>  mm/slub.c | 7 +++----
> >>  1 file changed, 3 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index 3d2025f7163b..2aca7523165e 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -352,9 +352,9 @@ static inline void *get_freepointer(struct kmem_cache *s, void *object)
> >>  	return freelist_dereference(s, object + s->offset);
> >>  }
> >>
> >> -static void prefetch_freepointer(const struct kmem_cache *s, void *object)
> >> +static void prefetchw_freepointer(const struct kmem_cache *s, void *object)
>
> I wouldn't rename the function itself, unless we have both  variants for
> different situations (we don't). That it uses prefetchw() is internal detail
> at this point.

looks good. that is simpler.
