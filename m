Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF02381BBA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 01:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhEOXUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 19:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhEOXUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 19:20:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BEA761289;
        Sat, 15 May 2021 23:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621120766;
        bh=1KA+yRG7lNb2frG45ynfDXbIDn18ohy7oZkqwoBxdL0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lp4IcVtSFGOnzvPd+SzPr2z7lt/owAJpamTC0AsPiqXUGPa80gr6lSGr90LGUpRmJ
         4b0B22jMUt38QeV9WIujHI5ofU1HGk5DbXmIcSdOyC8cDLO61CG0UnJp3USl/8AOVH
         gH8lhLKeoakmB885Xio3iD5rha4xRddoNdQjxspon+1CbArRlsqA5Ap3SmUp+cpk3t
         3IQuAwo4lIijuEJCi9bWWCBsj8FGLWy5tVHZs+IxUbLFWsWsKGenPJx3B/c5SCfLMM
         5FzjMJa9u5U79iH1NtfJWw82lVRbKWgLFOAsfdUYTewVAWhVJZi+Bljq442imIBAPh
         //bWH0cQeapcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 344105C064E; Sat, 15 May 2021 16:19:26 -0700 (PDT)
Date:   Sat, 15 May 2021 16:19:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, ming.lei@redhat.com, riel@fb.com,
        jweiner@fb.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, glittao@gmail.com
Subject: Re: [BUG] Shudown-time lockdep splat in next-20210514
Message-ID: <20210515231926.GB4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210515204622.GA2672367@paulmck-ThinkPad-P17-Gen-1>
 <a9e5c5c4-08db-47bf-cb0a-2a90bd747c77@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9e5c5c4-08db-47bf-cb0a-2a90bd747c77@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 11:09:13PM +0200, Vlastimil Babka wrote:
> On 5/15/21 10:46 PM, Paul E. McKenney wrote:
> > Hello!
> > 
> > I am seeing the following lockdep splat in next-20210514.  It happens
> > at shutdown time in all rcutorture scenarios that enable lockdep.  It
> > happens consistently on 2-hour runs, and I am trying it on shorter runs.
> > If it reproduces nicely, I will try bisection.
> > 
> > In the meantime, does this ring a bell for anyone?
> 
> Hm, I think it will be
> ad36bafb3bcdf mm/slub: use stackdepot to save stack trace in objects
> 
> can you try this please?
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 6b896b8c36f0..04824dae2e32 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -623,7 +623,7 @@ static void set_track(struct kmem_cache *s, void *object,
>  
>  	if (addr) {
>  #ifdef CONFIG_STACKDEPOT
> -		p->handle = save_stack_depot_trace(GFP_KERNEL);
> +		p->handle = save_stack_depot_trace(GFP_NOWAIT);
>  #endif
>  		p->addr = addr;
>  		p->cpu = smp_processor_id();

Works like a charm!

Tested-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul
