Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E641E3C2994
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhGITa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 15:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhGITa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 15:30:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF71C0613DD;
        Fri,  9 Jul 2021 12:28:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625858890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SnJkV5Eue+q5YG0ekrQ5djRZ/pRdO+saRQkDIqHszro=;
        b=tyfif7CGd9NFgPoSj8tJTrk3W/Snnx0BIGGKKd335ukMUV8eonIZzHI4YeG1GwyHreDXMo
        emlPYODwK9YowD3J37QUhnMmMefJ0uIDIzH67rfPEhNQUtOx9OrJlBoAtbQUyU0pBWMm0/
        /RyC8lbo8aiAMsSXsNWC5I/mHNIeH6rdq2e19IVRSnumrttzTI7AiMZHOzE15WqUoqnI67
        NWLENNSBfLujTnBEMeNig7lLckSFvrJy4hGpPfESdnndwCsJtT3mYOegyGLHjVd8OF5wdJ
        dOGRBY1ys/Z19RGB629aiWKmuIK1eKeXx26sOaOe3+xr/2gUymfyHkPqQNks7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625858890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SnJkV5Eue+q5YG0ekrQ5djRZ/pRdO+saRQkDIqHszro=;
        b=SF0R0xXgLXf6E4LieE82EgTOdq/BG/vWxteWTPd0GdhJ0alIsHXObTS+NIlIS/VVBamuOo
        MmxCaFneTp3NglCw==
To:     Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local exclusion scope
In-Reply-To: <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de> <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
Date:   Fri, 09 Jul 2021 21:28:10 +0200
Message-ID: <878s2fnv79.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09 2021 at 07:21, Mike Galbraith wrote:
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2497,7 +2497,9 @@ static void put_cpu_partial(struct kmem_
>  				 * partial array is full. Move the existing
>  				 * set to the per node partial list.
>  				 */
> +				local_lock(&s->cpu_slab->lock);
>  				unfreeze_partials(s);
> +				local_unlock(&s->cpu_slab->lock);
>  				oldpage = NULL;
>  				pobjects = 0;
>  				pages = 0;
> @@ -2579,7 +2581,9 @@ static void flush_cpu_slab(struct work_s
>  	if (c->page)
>  		flush_slab(s, c, true);
>  
> +	local_lock(&s->cpu_slab->lock);
>  	unfreeze_partials(s);
> +	local_unlock(&s->cpu_slab->lock);
>  }
>  
>  static bool has_cpu_slab(int cpu, struct kmem_cache *s)
> @@ -2632,8 +2636,11 @@ static int slub_cpu_dead(unsigned int cp
>  	struct kmem_cache *s;
>  
>  	mutex_lock(&slab_mutex);
> -	list_for_each_entry(s, &slab_caches, list)
> +	list_for_each_entry(s, &slab_caches, list) {
> +		local_lock(&s->cpu_slab->lock);

This one is odd. It locks the cpu_slab lock of the CPU which runs this
callback and then flushes the slab of the dead CPU.

Thanks,

        tglx

