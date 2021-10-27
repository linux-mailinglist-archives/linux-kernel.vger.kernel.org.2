Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E483043CF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243197AbhJ0RN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:13:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43052 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243191AbhJ0RN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:13:57 -0400
Received: from zn.tnic (p200300ec2f161500c684d7dcfa146303.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1500:c684:d7dc:fa14:6303])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C90DF1EC05C4;
        Wed, 27 Oct 2021 19:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635354690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wRvDnISiSsKN1BSrMx8qv/icMew8LYCnI9QO3WNbOC4=;
        b=I1fygnzMThGiGetuYBJaTCszYYBPQIMkImlNcNtMYGmZZH0n4yl04XeRvhY1nvAKu1BuoP
        tifuEBoIS1DaeNHq9BUPc6NVyVXrptnUvcXqH8nXlNfV/69xGAIB4QBhQsh8hvtndclktH
        tqG1sZZBYO5AxYpulEqUVG1l46761kE=
Date:   Wed, 27 Oct 2021 19:11:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86/xstate: Make AVX512 status tracking more
 accurate
Message-ID: <YXmIP2EPg12N7foP@zn.tnic>
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211027162615.1989004-1-goldstein.w.n@gmail.com>
 <20211027162615.1989004-2-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211027162615.1989004-2-goldstein.w.n@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 11:26:15AM -0500, Noah Goldstein wrote:
> diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
> index f5a38a5f3ae1..cb10909fa3da 100644
> --- a/arch/x86/include/asm/fpu/types.h
> +++ b/arch/x86/include/asm/fpu/types.h
> @@ -330,11 +330,21 @@ struct fpu {
>  	unsigned int			last_cpu;
>  
>  	/*
> -	 * @avx512_timestamp:
> +	 * @avx512_ZMM_Hi256_timestamp:
>  	 *
> -	 * Records the timestamp of AVX512 use during last context switch.
> +	 * Records the timestamp of AVX512 use in the ZMM_Hi256 xfeature
> +	 * set. This include zmm0...zmm15.
>  	 */
> -	unsigned long			avx512_timestamp;
> +	unsigned long			avx512_ZMM_Hi256_timestamp;
> +
> +	/*
> +	 * @avx512_Hi16_ZMM_timestamp:
> +	 *
> +	 * Records the timestamp of AVX512 use in the Hi16_ZMM xfeature
> +	 * set. This includes usage of any of the hi16 xmm, ymm, or zmm
> +	 * registers.
> +	 */
> +	unsigned long			avx512_Hi16_ZMM_timestamp;

No, not more of this but less.

That was a bad idea to begin with as exposing this to userspace would
cause exactly this: but but, I need to track my special use case more
precisely.

But the feature mask can't give you that precision so it'll be only an
approximation no matter what you do.

And I'm being told future cores won't have this "problem" so on them
that file becomes actively misleading.

If you really wanna track performance drop precisely or AVX use or
whatnot, there's performance counters for that which can give you
exactly what you wanna know.

So I'll take a simple patch carving out that into a function and which
removes the opmask and otherwise let that thing die. And on future cores
which are not affected, that thing will report only 0 anyway.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
