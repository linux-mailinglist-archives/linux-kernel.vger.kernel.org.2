Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE97E3BA03E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhGBMUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhGBMUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:20:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F6DC061764
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 05:17:53 -0700 (PDT)
Date:   Fri, 2 Jul 2021 14:17:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625228271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GayRj68MxYlhLq1b72BYBOzpVTzkn6ZlV4tZ2wvOh7w=;
        b=Cw4KZ3DbM3XM9/ouqvqzAGiIhwYUuKq7vRGFxLVCC4rkOq5FsdkbVQvcNrJAiDRNmvzSsx
        C3EkL8+242kyNQcjdbKkYjjHcV02KYDavb2LIImrvfGznL28qXzkU0T3uiF+xJV3YF33NH
        pDrc2MY4w4olSuPBi1YS49DRnGDz8yE7Pha1+WzUzmaWoiR/aRKxSIndWzZ/X9EodY+97V
        qH3NvNga5USmwE2UNVeGAS3gco6AE5Nv2pJn4WvTZI50C0UnT/rg509YBRnnjnentFnJZG
        dj4r9ywKiH+UyrA+4r9xQmnprnTXUs+R4Hio/flljWXOo28e2102HqUcYLCEqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625228271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GayRj68MxYlhLq1b72BYBOzpVTzkn6ZlV4tZ2wvOh7w=;
        b=rflAF7uIIPZLISkwTB0wCO+VkyX7Cp4wKoawbaMXO9umI0hjececP3AtZm42aWNpDQHE/5
        v+7iaxDNOgGn8yCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC v2 31/34] mm, slub: optionally save/restore irqs in
 slab_[un]lock()/
Message-ID: <20210702121749.edrkrwf6uaxwoiyp@linutronix.de>
References: <20210609113903.1421-1-vbabka@suse.cz>
 <20210609113903.1421-32-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210609113903.1421-32-vbabka@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-09 13:39:00 [+0200], Vlastimil Babka wrote:
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -353,18 +353,35 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
>  /*
>   * Per slab locking using the pagelock
>   */
> -static __always_inline void slab_lock(struct page *page)
> +static __always_inline void
> +__slab_lock(struct page *page, unsigned long *flags, bool disable_irqs)
>  {
>  	VM_BUG_ON_PAGE(PageTail(page), page);
> +	if (disable_irqs)
> +		local_irq_save(*flags);
>  	bit_spin_lock(PG_locked, &page->flags);
>  }
>  
> -static __always_inline void slab_unlock(struct page *page)
> +static __always_inline void
> +__slab_unlock(struct page *page, unsigned long *flags, bool disable_irqs)
>  {
>  	VM_BUG_ON_PAGE(PageTail(page), page);
> +	if (disable_irqs)
> +		local_irq_restore(*flags);
>  	__bit_spin_unlock(PG_locked, &page->flags);
>  }

You should first unlock then enable IRQs.

Sebastian
