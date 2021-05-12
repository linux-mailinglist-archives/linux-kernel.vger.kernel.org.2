Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D695937B9A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhELJvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhELJvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:51:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BEDC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 02:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BRFBW43fgtHv4ucSXHHlezy38Womgpx7pRY+Lyjlhnk=; b=U/oG3qIwGMJ4zSIjL+hP9N5akz
        HBz2BbQi2DRXwUkCtfWVGl83GLhrKfXY3326xR7CSn45eOdYMF6cFuMy1fqwJDrmXrw8mXAsMMTeW
        YAngOWF7DRp0ucmdiE49Ygt/iUbhXoYSvQJWho8FSC+qqasF/E00ezZgQh9NP+JylJwe3xyEjt8Kp
        yGDGGAm+lmVHKrEtnNVhPs8bIsxZ5uVonU2MTiWzeP4Xq1yoehQpJ0nb/fx9wNd///lDEfbxIfvw7
        c5xzxGvMNZYEd+htTbljyX8tQXBktzB2Jhckcxj+ikfLHpl9tvrVRS440g74+v6S2dm8w+NeRhLO8
        hGiUXGgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lglVG-002TGZ-LP; Wed, 12 May 2021 09:50:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8693230026A;
        Wed, 12 May 2021 11:50:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 702942040BF7C; Wed, 12 May 2021 11:50:05 +0200 (CEST)
Date:   Wed, 12 May 2021 11:50:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/asm: Simplify __smp_mb() definition
Message-ID: <YJukzRPyN7XbLlTd@hirez.programming.kicks-ass.net>
References: <20210512093310.5635-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512093310.5635-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 11:33:10AM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Drop the bitness ifdeffery in favor of using the rSP register
> specification for 32 and 64 bit depending on the build.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/barrier.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index 4819d5e5a335..3ba772a69cc8 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -54,11 +54,8 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
>  #define dma_rmb()	barrier()
>  #define dma_wmb()	barrier()
>  
> -#ifdef CONFIG_X86_32
> -#define __smp_mb()	asm volatile("lock; addl $0,-4(%%esp)" ::: "memory", "cc")
> -#else
> -#define __smp_mb()	asm volatile("lock; addl $0,-4(%%rsp)" ::: "memory", "cc")
> -#endif
> +#define __smp_mb()	asm volatile("lock; addl $0,-4(%%" _ASM_SP ")" ::: "memory", "cc")
> +
>  #define __smp_rmb()	dma_rmb()
>  #define __smp_wmb()	barrier()
>  #define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
