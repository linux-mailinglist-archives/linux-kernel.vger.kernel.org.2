Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5651445B07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 21:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhKDUZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 16:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23744 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229694AbhKDUZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 16:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636057345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dyn4gVhrnOfU8Eh21VWnuvjYv16sLsfU5x56FULi4fI=;
        b=IHaFIR7wXvcxVxQLkmpgoQ3kSlhFDfSzwLB9RN1EY4YJ/WrOr1rJmD4g3KqUTnHeK+4mlr
        OeuwttDcFuiUvZVmZQzNFoTuB9bz/byUDuDazk12QLHr5kqntUEj91P/znBTnA/L3RtRZD
        rNNvDcNmNdrd+LqgnxCEBjntNchsDaA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-02Wndk04OeOSzoAalsgJEA-1; Thu, 04 Nov 2021 16:22:24 -0400
X-MC-Unique: 02Wndk04OeOSzoAalsgJEA-1
Received: by mail-oi1-f199.google.com with SMTP id w123-20020aca3081000000b002a7aee8ee98so4090043oiw.21
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 13:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dyn4gVhrnOfU8Eh21VWnuvjYv16sLsfU5x56FULi4fI=;
        b=tenswQktIEuY6Tq6tbLMRQe/Aers7ffjyL/8RU76tjii4z8zUSA1Y5KUA51ifPgdVg
         xUFWvOkmgOxVL9VrZDUCn6tvHQuG4RIBP/TREk1VbpvuHskwgvd83OPtNUxlNN4wK+it
         xPly32LyHBWazo1RBDFd+7UQq3gsLpTSw0kKtGsa8NtkDHFSyOgZBALcC5iKlF16C7o7
         71jh0pHTW0c9eUuCbN+6VzpJS1ILzVjJUTcBVvJOs0Gmf8wUjA+jVAdtzedBvGUSR6Dg
         lI/rO3WokVJ8frXSIGD1lu59JG5cp75dXGCGepF8DfsYELzrX8dU3kMsTHsXZwSiD2ey
         GXEQ==
X-Gm-Message-State: AOAM533TpqTnNhi0lZwuQ6TsWfPaa5xvdpgJ8YGcHWGJc5ooqAPSwLE2
        mvAOTT0ysqgG8JwZx5j4b0dcgrfTE7vaBL1D6kzn32njv/6SH0chO1dfKC3xosiM7NNNb5qIq6R
        WxrbWSkvi07ZFjkglJd2I3hO3
X-Received: by 2002:a9d:e8b:: with SMTP id 11mr17249540otj.43.1636057343772;
        Thu, 04 Nov 2021 13:22:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBkcxVmtqTEAgJgg7bZE1R+nVxqWe50yOYbfV2om/neT0eXbjz5Z7sLZCcGedAO+B0IhBhxw==
X-Received: by 2002:a9d:e8b:: with SMTP id 11mr17249524otj.43.1636057343540;
        Thu, 04 Nov 2021 13:22:23 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id p62sm1714064oif.43.2021.11.04.13.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 13:22:23 -0700 (PDT)
Date:   Thu, 4 Nov 2021 13:22:20 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 02/22] x86,mmx_32: Remove .fixup usage
Message-ID: <20211104202220.xwm23nbpvwma6wds@treble>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.625383149@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211104165524.625383149@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 05:47:31PM +0100, Peter Zijlstra wrote:
> This code puts an exception table entry on the "PREFIX" instruction to
> overwrite it with a jmp.d8 when it triggers an exception. Except of
> course, our code is no longer writable, also SMP.
> 
> Replace it with ALTERNATIVE, the novel
> 
> XXX: arguably we should just delete this code
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/lib/mmx_32.c |   83 ++++++++++++++++----------------------------------
>  1 file changed, 27 insertions(+), 56 deletions(-)
> 
> --- a/arch/x86/lib/mmx_32.c
> +++ b/arch/x86/lib/mmx_32.c
> @@ -50,23 +50,17 @@ void *_mmx_memcpy(void *to, const void *
>  	kernel_fpu_begin_mask(KFPU_387);
>  
>  	__asm__ __volatile__ (
> -		"1: prefetch (%0)\n"		/* This set is 28 bytes */
> -		"   prefetch 64(%0)\n"
> -		"   prefetch 128(%0)\n"
> -		"   prefetch 192(%0)\n"
> -		"   prefetch 256(%0)\n"
> -		"2:  \n"
> -		".section .fixup, \"ax\"\n"
> -		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
> -		"   jmp 2b\n"
> -		".previous\n"
> -			_ASM_EXTABLE(1b, 3b)
> -			: : "r" (from));
> +		ALTERNATIVE "",
> +			    "prefetch (%0)\n"
> +			    "prefetch 64(%0)\n"
> +			    "prefetch 128(%0)\n"
> +			    "prefetch 192(%0)\n"
> +			    "prefetch 256(%0)\n", X86_FEATURE_3DNOW

I think this should instead be X86_FEATURE_3DNOWPREFETCH (which isn't
3DNow-specific and should really just be called X86_FEATURE_PREFETCH
anyway)

> +		: : "r" (from));
>  
>  	for ( ; i > 5; i--) {
>  		__asm__ __volatile__ (
> -		"1:  prefetch 320(%0)\n"
> -		"2:  movq (%0), %%mm0\n"
> +		"  movq (%0), %%mm0\n"

Not sure why this prefetch was removed?  It can also be behind an
alternative just like the first one.

-- 
Josh

