Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256C5366630
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbhDUHVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:21:18 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:52460 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236733AbhDUHVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:21:16 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 2C307B007AA; Wed, 21 Apr 2021 09:20:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 29B13B0035D;
        Wed, 21 Apr 2021 09:20:41 +0200 (CEST)
Date:   Wed, 21 Apr 2021 09:20:41 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Matthew Wilcox <willy@infradead.org>
cc:     Yejune Deng <yejune.deng@gmail.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab.c: use 'ac' from the caller
In-Reply-To: <20210421031019.GF3596236@casper.infradead.org>
Message-ID: <alpine.DEB.2.22.394.2104210912150.52601@gentwo.de>
References: <20210421022518.67451-1-yejune.deng@gmail.com> <20210421031019.GF3596236@casper.infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021, Matthew Wilcox wrote:

> On Wed, Apr 21, 2021 at 10:25:17AM +0800, Yejune Deng wrote:
> > @@ -3045,12 +3044,7 @@ static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
> >  	}
> >
> >  	STATS_INC_ALLOCMISS(cachep);
> > -	objp = cache_alloc_refill(cachep, flags);
> > -	/*
> > -	 * the 'ac' may be updated by cache_alloc_refill(),
> > -	 * and kmemleak_erase() requires its correct value.
> > -	 */
> > -	ac = cpu_cache_get(cachep);
> > +	objp = cache_alloc_refill(cachep, ac, flags);
>
> I think passing 'ac' in is fine (probably?  I don't know this code
> deeply), but deleting this call to 'ac' is clearly wrong.  The comment
> even tells you that!  I just verified the code, and the comment is
> correct.


Yep the delete of the ac assignment is wrong.

But even without that issue: There is no point to passing ac to
cache_alloc_refill since cpu_cache_get is rather trivial and does not
even require memory access since "cachep" is usually in some register.

