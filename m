Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B617F44B2DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242715AbhKISwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbhKISwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:52:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D68C061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 10:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YL9j7lej8XrT5xtmXgw8J3S+ZbROD4VKmCbZ/lMA8f8=; b=A7nevf/oS99Wsb8Xr0urtmSvsW
        tVV+vDrC1axTdpzw4t9kehCKB3sdQ46sAjf6fEZurviC2VitkM1OegdiXuG0/rL5Lobi95ELeSKLp
        lXTGMgjxknShfSiOG+MhEWnYP10JaYq+R/HukvowpT7/+CetUVBt0Lq1ru99X4jdasOqEuGj7H8Lf
        ofrFdO83wr9aFrHVXaM3V4It21mig7uPnq4SLKHcwe8jYmLFfW93Gszc9Qd0hsgUz8vE24HBVS1M6
        fle6ME2AWLebUuDxoc5Zpoc7s4396IMbGQs3SxlTR3FL0PGKuGoPVskU15KL+WNH917msWA4eb0Nt
        RjC9NFAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkWB6-00F735-Fd; Tue, 09 Nov 2021 18:49:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA5283000A3;
        Tue,  9 Nov 2021 19:49:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1BEE212EE599; Tue,  9 Nov 2021 19:49:03 +0100 (CET)
Date:   Tue, 9 Nov 2021 19:49:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 2/7] static_call: deal with unexported keys without
 cluttering up the API
Message-ID: <YYrCn3mc+EbY+OB/@hirez.programming.kicks-ass.net>
References: <20211109164549.1724710-1-ardb@kernel.org>
 <20211109164549.1724710-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109164549.1724710-3-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 05:45:44PM +0100, Ard Biesheuvel wrote:

> diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
> index 5a00b8b2cf9f..0bb36294cce7 100644
> --- a/include/linux/static_call_types.h
> +++ b/include/linux/static_call_types.h
> @@ -32,15 +32,20 @@
>  struct static_call_site {
>  	s32 addr;
>  	s32 key;
> +	s32 tramp;
>  };

I can't say I'm thrilled at growing this thing, but the cleanup is nice.
Perhaps we can increase alignment on struct static_call_key and instead
frob it in .key still?

>  
>  #define DECLARE_STATIC_CALL(name, func)					\
> -	extern struct static_call_key STATIC_CALL_KEY(name);		\
> +	extern __weak struct static_call_key STATIC_CALL_KEY(name);	\
>  	extern typeof(func) STATIC_CALL_TRAMP(name);

I'm a little bit confused on how this actually works. What does a __weak
extern data symbol do?

A __weak function definition would create a module local instance of the
function barring a strong override.

But what does a __weak extern do?

> diff --git a/kernel/static_call.c b/kernel/static_call.c
> index 43ba0b1e0edb..360cc3cd0fbf 100644
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -366,18 +366,18 @@ static int static_call_add_module(struct module *mod)
>  		 * means modules are allowed to call static_call_update() on
>  		 * it.
>  		 *
> -		 * Otherwise, the key isn't exported, and 'addr' points to the
> +		 * Otherwise, the key isn't exported, and 'tramp' points to the
>  		 * trampoline so we need to lookup the key.
>  		 *
>  		 * We go through this dance to prevent crazy modules from
>  		 * abusing sensitive static calls.
>  		 */
> -		if (!kernel_text_address(addr))
> +		if (addr)
>  			continue;

This seems to imply that the __weak extern symbol gets resolved to 0 at
module link time.

>  
> -		key = tramp_key_lookup(addr);
> +		key = tramp_key_lookup((unsigned long)offset_to_ptr(&site->tramp));
>  		if (!key) {
> -			pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
> +			pr_warn("Failed to fixup static_call() usage at: %ps\n",
>  				static_call_addr(site));
>  			return -EINVAL;

>  		}
