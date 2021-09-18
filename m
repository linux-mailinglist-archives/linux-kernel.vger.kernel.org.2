Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11717410511
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 10:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbhIRIWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 04:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbhIRIWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 04:22:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D998C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1NHmEAol1lq4peZ31fSB07z8KoGoEkiOV+QliNg4GBM=; b=Qa/4f3eyYYONE/7nqJCxWs/gwz
        NpxbNpYN1kR2xWb6Xtk9S3nWyRI8oudwN9nXkIaMOw30SNqSXYRu7wy/cS/BZQugxtUL9bfhI+c9z
        16YMU6oBKwJHhdkLG0Y/V0rgRM5YIDaH9eleBq5Pc3RQx/kjcVc/TDXxrUcKUpmvC+TNW98wsoLmC
        Atp0EImfgyRhH1zahwy44ax1i5e+Iz6Nc9ZvM6Vus63yyC9kJYqbMcIPuOKJaZIHepam2jgf2DUWY
        OUBpHocI9SlIQ3+FWtA2LEyAjMdbs7Les5D/OxnXFjJp/NGVkSNgpLYL2ynTwzAFzeIiHFxpX4SFd
        9TJs+b1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRVa9-0042sC-Cq; Sat, 18 Sep 2021 08:20:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACE21986249; Sat, 18 Sep 2021 10:20:20 +0200 (CEST)
Date:   Sat, 18 Sep 2021 10:20:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     cgel.zte@gmail.com
Cc:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Fix the bool convert to int issue
Message-ID: <20210918082020.GL4323@worktop.programming.kicks-ass.net>
References: <20210918073037.239634-1-yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918073037.239634-1-yang.guang5@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 07:30:37AM +0000, cgel.zte@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> The int value which convert from bool true is 0xFFFFFFFF. Causing the
> __sc_insn return wrong type.

Aaah, this is where the insanity starts...

My copy of the C spec says:

  "When any scalar value is converted to _Bool, the result is 0 if the
   value compares equal to 0; otherwise, the result is 1."

What does yours say?

Also, did your kernel boot? If what you say is right it would've gone up
in flames a long time ago.

Please, learn C _before_ sending patches.

*plonk*

> 
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---
>  arch/x86/kernel/static_call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
> index ea028e736831..f608e6710300 100644
> --- a/arch/x86/kernel/static_call.c
> +++ b/arch/x86/kernel/static_call.c
> @@ -89,7 +89,7 @@ static inline enum insn_type __sc_insn(bool null, bool tail)
>  	 *	  1  |   0   |  JMP
>  	 *	  1  |   1   |  RET
>  	 */
> -	return 2*tail + null;
> +	return ((tail)?2:0) + ((null)?1:0);
>  }
>  
>  void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
> -- 
> 2.25.1
> 
