Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2264534A630
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCZLNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhCZLMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:12:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1877C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 04:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=NPZOeK7lpdUkuK8Gb8OEEbUBOL4qNIww27yfcO5L4Q4=; b=VcAFM3K9NdlK4Rwrep45+G2eKr
        tkhCoM/E+GxXP/LvWreTu8+Z2udy6pHGgy6XMucTRllLDufGXaV1XkhQuPBR5ox8r4SsoXJyFLQGw
        6HYWkom5MVkqBMIq/J+66MoDFDGbxWU6IbBgcFxILFsIzNEccDBaFan2tubxavfZ8e2Irj5kWLZ52
        LolIAJn71pCUsmctihkkTAXnNXx5yBW/9WtP7GGr2mai+tInhM3NRt+C/dUq252Lx99bfpZYTCUbP
        5c6atIeRF3Yhdnr9EOlB+X5h846FkY/jqXyuFeMzUiGkWDK2hceL4OkZXTEc2Ixlr7wuzZRxzVYTH
        pUo5Txbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPkOK-003PEj-Dc; Fri, 26 Mar 2021 11:12:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE422304D58;
        Fri, 26 Mar 2021 12:12:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89FF220424904; Fri, 26 Mar 2021 12:12:35 +0100 (CET)
Date:   Fri, 26 Mar 2021 12:12:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH mptcp-next] static_call: fix unused variable warn w/o
 MODULE
Message-ID: <YF3Bo8xfVt5UvGAg@hirez.programming.kicks-ass.net>
References: <20210326105023.2058860-1-matthieu.baerts@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210326105023.2058860-1-matthieu.baerts@tessares.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 11:50:23AM +0100, Matthieu Baerts wrote:
> Here is the warning converted as error and reported by GCC:
> 
>   kernel/static_call.c: In function ‘__static_call_update’:
>   kernel/static_call.c:153:18: error: unused variable ‘mod’ [-Werror=unused-variable]
>     153 |   struct module *mod = site_mod->mod;
>         |                  ^~~
>   cc1: all warnings being treated as errors
>   make[1]: *** [scripts/Makefile.build:271: kernel/static_call.o] Error 1
> 
> This is simply because since recently, we no longer use 'mod' variable
> elsewhere if MODULE is unset.
> 
> When using 'make tinyconfig' to generate the default kconfig, MODULE is
> unset.
> 
> There are different ways to fix this warning. Here I tried to minimised
> the number of modified lines and not add more #ifdef. We could also move
> the declaration of the 'mod' variable inside the if-statement or
> directly use site_mod->mod.
> 
> Fixes: 698bacefe993 ("static_call: Align static_call_is_init() patching condition")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> 
> Notes:
>     Feel free to modify this patch directly if you prefer. I can of course
>     send a new version if needed.

Ah, I had indeed meant to take a look at this, but hadn't come around to
it. I think this is as nice a solution as there is, so let me go apply
this.

>  kernel/static_call.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/static_call.c b/kernel/static_call.c
> index 2c5950b0b90e..723fcc9d20db 100644
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -165,13 +165,13 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
>  
>  		stop = __stop_static_call_sites;
>  
> -#ifdef CONFIG_MODULES
>  		if (mod) {
> +#ifdef CONFIG_MODULES
>  			stop = mod->static_call_sites +
>  			       mod->num_static_call_sites;
>  			init = mod->state == MODULE_STATE_COMING;
> -		}
>  #endif
> +		}
>  

