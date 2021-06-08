Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA13A079E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 01:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhFHXOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 19:14:16 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:39796 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbhFHXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:14:13 -0400
Received: by mail-pg1-f177.google.com with SMTP id y12so5974506pgk.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 16:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CtnIG0I9WH5rJ/qkiBO8MTiub4f1BJwHmBXw1xc/PqU=;
        b=dxzowAxFXpK7aiWcWxbNfqXurQ1lkSAJANaUZhAo+/ACQvsmkdvn85Ksv9A80cNT4r
         cpVKsC7BJ+foyQTW7mhParj8XoFy4ytIPqr/unu215You+Ymrz7KEMlQHBfORJOgQZsr
         KcDkWQGZ7QTrNwnEHU9S8pzRLxrMsNHhU51OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CtnIG0I9WH5rJ/qkiBO8MTiub4f1BJwHmBXw1xc/PqU=;
        b=WO51t5dMJmKn9LBdjHeFIsWlor45We6XADKCsC2rtxt341kyseVMZ3fV1+nv+mwi7a
         OgxXDJOmRenyhydGKWEg9cGyOpQSY+F9lal9zsxH6kEVdWZKJPAtUJlI5ZgXs6fvwybP
         854E8Qc2rtCQO3aJodIVGmse61D7Scl/vbthAsItt369NvJdAENFTQBa6oLxUXEjbwUU
         +QwjDKDPo/UZhBejt9cbcllWDyl9ISJnq3N0Gnly2zTBzjX9sH7mg1Ubga5po40L9pgr
         3DielI4InkM1rkz4Sf8hZpocZXpCDwjv1rDG5YbT3XTFHTNTXY9D825Fifc6EM2/cEMJ
         KBFQ==
X-Gm-Message-State: AOAM531ysIlZeWfraXHy07AtIw0uAoJV3CeOwUu5kcGRWaWkYiSWgl4l
        rPQdXUXSYLzctJtjSje91mf0LA==
X-Google-Smtp-Source: ABdhPJwsH1ZT/91h9f3ez1aHPP3kcJQrsPqtXCwE2vACMsQ/QMIYOKVYw4mf/HzmIRBastKcADl4sA==
X-Received: by 2002:aa7:8392:0:b029:2db:4a7:d866 with SMTP id u18-20020aa783920000b02902db04a7d866mr2311154pfm.66.1623193866812;
        Tue, 08 Jun 2021 16:11:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r2sm3837786pfq.87.2021.06.08.16.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:11:06 -0700 (PDT)
Date:   Tue, 8 Jun 2021 16:11:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marco Elver <elver@google.com>, "Lin, Zhenpeng" <zplin@psu.edu>,
        stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 3/3] mm/slub: Actually fix freelist pointer vs
 redzoning
Message-ID: <202106081608.A50EA64@keescook>
References: <20210608183955.280836-1-keescook@chromium.org>
 <20210608183955.280836-4-keescook@chromium.org>
 <20210608135633.167bd07cf8011a792a128976@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608135633.167bd07cf8011a792a128976@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 01:56:33PM -0700, Andrew Morton wrote:
> On Tue,  8 Jun 2021 11:39:55 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > It turns out that SLUB redzoning ("slub_debug=Z") checks from
> > s->object_size rather than from s->inuse (which is normally bumped
> > to make room for the freelist pointer), so a cache created with an
> > object size less than 24 would have the freelist pointer written beyond
> > s->object_size, causing the redzone to be corrupted by the freelist
> > pointer. This was very visible with "slub_debug=ZF":
> > 
> > BUG test (Tainted: G    B            ): Right Redzone overwritten
> > -----------------------------------------------------------------------------
> > 
> > INFO: 0xffff957ead1c05de-0xffff957ead1c05df @offset=1502. First byte 0x1a instead of 0xbb
> > INFO: Slab 0xffffef3950b47000 objects=170 used=170 fp=0x0000000000000000 flags=0x8000000000000200
> > INFO: Object 0xffff957ead1c05d8 @offset=1496 fp=0xffff957ead1c0620
> > 
> > Redzone  (____ptrval____): bb bb bb bb bb bb bb bb               ........
> > Object   (____ptrval____): 00 00 00 00 00 f6 f4 a5               ........
> > Redzone  (____ptrval____): 40 1d e8 1a aa                        @....
> > Padding  (____ptrval____): 00 00 00 00 00 00 00 00               ........
> > 
> > Adjust the offset to stay within s->object_size.
> > 
> > (Note that no caches of in this size range are known to exist in the
> > kernel currently.)
> 
> We already have
> https://lkml.kernel.org/r/6746FEEA-FD69-4792-8DDA-C78F5FE7DA02@psu.edu.
> Is this patch better?

Yes, I believe so, since it reduces code and corrects the size checking
more directly (and more clearly demonstrates the redzone calculation
problem in the commit log).

-Kees

> 
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3689,7 +3689,6 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
> >  {
> >  	slab_flags_t flags = s->flags;
> >  	unsigned int size = s->object_size;
> > -	unsigned int freepointer_area;
> >  	unsigned int order;
> >  
> >  	/*
> > @@ -3698,13 +3697,6 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
> >  	 * the possible location of the free pointer.
> >  	 */
> >  	size = ALIGN(size, sizeof(void *));
> > -	/*
> > -	 * This is the area of the object where a freepointer can be
> > -	 * safely written. If redzoning adds more to the inuse size, we
> > -	 * can't use that portion for writing the freepointer, so
> > -	 * s->offset must be limited within this for the general case.
> > -	 */
> > -	freepointer_area = size;
> >  
> >  #ifdef CONFIG_SLUB_DEBUG
> >  	/*
> > @@ -3730,7 +3722,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
> >  
> >  	/*
> >  	 * With that we have determined the number of bytes in actual use
> > -	 * by the object. This is the potential offset to the free pointer.
> > +	 * by the object and redzoning.
> >  	 */
> >  	s->inuse = size;
> >  
> > @@ -3753,13 +3745,13 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
> >  		 */
> >  		s->offset = size;
> >  		size += sizeof(void *);
> > -	} else if (freepointer_area > sizeof(void *)) {
> > +	} else {
> >  		/*
> >  		 * Store freelist pointer near middle of object to keep
> >  		 * it away from the edges of the object to avoid small
> >  		 * sized over/underflows from neighboring allocations.
> >  		 */
> > -		s->offset = ALIGN(freepointer_area / 2, sizeof(void *));
> > +		s->offset = ALIGN_DOWN(s->object_size / 2, sizeof(void *));
> >  	}
> >  
> >  #ifdef CONFIG_SLUB_DEBUG
> > -- 
> > 2.25.1

-- 
Kees Cook
