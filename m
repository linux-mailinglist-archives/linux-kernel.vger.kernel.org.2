Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEB8456248
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 19:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhKRSZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 13:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhKRSZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:25:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C53DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qYIG8OnTXas2oJFDWG+2h1Y3uoqVRsk7LoHj4bDucEk=; b=lLsakPI5xyI9xfvTjGNPSLIrH1
        TK8StjoAcF65in5pn5JnDocEJbGP0lZMNjUCED/2iu6uirIXIwiZMUR9aUe63mlbo83Ytz3PLDfc0
        JD/4tlUKQcI4uUjnDoNUU6J0cDTWhOnK/bsgtGa88qfUEZx5PuuE3RP8IqKHS+bThn4b0YQRfY8OX
        cMbZ/adJPwMnGkFhLx/WGBEPz10dVbf/xhcO1sj5sVOAU75YnPLUp6QHstl7ep3NwUL+r+XyKeJXd
        hg+sJavRVMNQZTk7dsZWYneslon5nGtCQ4zxXZ8fe13a3ZzQRMi9UZkLftdTOpDjFDRLg0FqbTIL9
        6c9bVvtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnm3C-008hc6-E9; Thu, 18 Nov 2021 18:22:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D68729863CD; Thu, 18 Nov 2021 19:22:21 +0100 (CET)
Date:   Thu, 18 Nov 2021 19:22:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Johannes Berg <johannes.berg@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] x86/csum: fix compilation error for UM
Message-ID: <20211118182221.GI174703@worktop.programming.kicks-ass.net>
References: <20211118175239.1525650-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118175239.1525650-1-eric.dumazet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 09:52:39AM -0800, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> load_unaligned_zeropad() is not yet universal.
> 
> ARCH=um SUBARCH=x86_64 builds do not have it.
> 
> When CONFIG_DCACHE_WORD_ACCESS is not set, simply continue
> the bisection with 4, 2 and 1 byte steps.
> 
> Fixes: df4554cebdaa ("x86/csum: Rewrite/optimize csum_partial()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Alexander Duyck <alexanderduyck@fb.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---

Yeah, that's much nicer. I'll go feed that to the robots I suppose :-)

>  arch/x86/lib/csum-partial_64.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> index 5ec35626945b6db2f7f41c6d46d5e422810eac46..1eb8f2d11f7c785be624eba315fe9ca7989fd56d 100644
> --- a/arch/x86/lib/csum-partial_64.c
> +++ b/arch/x86/lib/csum-partial_64.c
> @@ -92,6 +92,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>  		buff += 8;
>  	}
>  	if (len & 7) {
> +#ifdef CONFIG_DCACHE_WORD_ACCESS
>  		unsigned int shift = (8 - (len & 7)) * 8;
>  		unsigned long trail;
>  
> @@ -101,6 +102,31 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>  		    "adcq $0,%[res]"
>  			: [res] "+r" (temp64)
>  			: [trail] "r" (trail));
> +#else
> +		if (len & 4) {
> +			asm("addq %[val],%[res]\n\t"
> +			    "adcq $0,%[res]"
> +				: [res] "+r" (temp64)
> +				: [val] "r" ((u64)*(u32 *)buff)
> +				: "memory");
> +			buff += 4;
> +		}
> +		if (len & 2) {
> +			asm("addq %[val],%[res]\n\t"
> +			    "adcq $0,%[res]"
> +				: [res] "+r" (temp64)
> +				: [val] "r" ((u64)*(u16 *)buff)
> +				: "memory");
> +			buff += 2;
> +		}
> +		if (len & 1) {
> +			asm("addq %[val],%[res]\n\t"
> +			    "adcq $0,%[res]"
> +				: [res] "+r" (temp64)
> +				: [val] "r" ((u64)*(u8 *)buff)
> +				: "memory");
> +		}
> +#endif
>  	}
>  	result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
>  	if (unlikely(odd)) { 
> -- 
> 2.34.0.rc1.387.gb447b232ab-goog
> 
