Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5478C325BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 04:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBZDMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 22:12:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhBZDMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 22:12:35 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C8564E7A;
        Fri, 26 Feb 2021 03:11:54 +0000 (UTC)
Date:   Thu, 25 Feb 2021 22:11:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] static_call: Fix the module key fixup
Message-ID: <20210225221151.7f9f04d7@oasis.local.home>
In-Reply-To: <20210225220351.GE4746@worktop.programming.kicks-ass.net>
References: <20210225131221.11dab26e@gandalf.local.home>
        <20210225220351.GE4746@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 23:03:51 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Subject: static_call: Fix the module key fixup
> 
> Provided the target address of a R_X86_64_PC32 relocation is aligned,
> the low two bits should be invariant between the relative and absolute
> value.
> 
> Turns out the address is not aligned and things go sideways, ensure we
> transfer the bits in the absolute form when fixing up the key address.
> 

Link: https://lore.kernel.org/lkml/20210225131221.11dab26e@gandalf.local.home/

> Reported-by: Steven Rostedt <rostedt@goodmis.org>

Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/static_call.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/static_call.c b/kernel/static_call.c
> index 6906c6ec4c97..ae825295cf68 100644
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -349,7 +349,8 @@ static int static_call_add_module(struct module *mod)
>  	struct static_call_site *site;
>  
>  	for (site = start; site != stop; site++) {
> -		unsigned long addr = (unsigned long)static_call_key(site);
> +		unsigned long s_key = (long)site->key + (long)&site->key;
> +		unsigned long addr = s_key & ~STATIC_CALL_SITE_FLAGS;
>  		unsigned long key;
>  
>  		/*
> @@ -373,8 +374,8 @@ static int static_call_add_module(struct module *mod)
>  			return -EINVAL;
>  		}
>  
> -		site->key = (key - (long)&site->key) |
> -			    (site->key & STATIC_CALL_SITE_FLAGS);
> +		key |= s_key & STATIC_CALL_SITE_FLAGS;
> +		site->key = key - (long)&site->key;
>  	}
>  
>  	return __static_call_init(mod, start, stop);

