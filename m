Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C9E45395D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 19:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbhKPS2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 13:28:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33530 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239420AbhKPS2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 13:28:50 -0500
Received: from zn.tnic (p200300ec2f139500c9e6c49efd08035a.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:9500:c9e6:c49e:fd08:35a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A8B281EC0570;
        Tue, 16 Nov 2021 19:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1637087152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fXxb1moZ4Zx9zCRqmyWRq8nU536DLYxuz2qQVP1M+4s=;
        b=d+izvkN38zvOMCmdVtfOKRaBc3oWjQErvlnIhCrwtoyJqBGxjTn8hxLS8cTKuCqf8/TKTQ
        ORy4jnyH/9wd4z/3YrCUmTrm0IWAJuGGp8I58F/nBUkho8uJ5KnhclHeDbrmPYf08dZIpd
        Lw2VsThWybw2ZqRjHUo2ZU0xatxxca4=
Date:   Tue, 16 Nov 2021 19:25:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.orgg, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        pbonzini@redhat.com, mbenes@suse.cz
Subject: Re: [PATCH v2.1 02/23] x86/mmx_32: Remove X86_USE_3DNOW
Message-ID: <YZP3p2uqKVJfkmNX@zn.tnic>
References: <20211110100102.250793167@infradead.org>
 <20211110101325.009464367@infradead.org>
 <YZKQzUmeNuwyvZpk@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZKQzUmeNuwyvZpk@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 05:54:37PM +0100, Peter Zijlstra wrote:
> 
> 
> The alternative (har har) for this patch is the below, which seems
> favoured by Boris.
> 
> ---
> Subject: x86/mmx_32: Remove X86_USE_3DNOW
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Nov 15 17:46:39 CET 2021
> 
> This code puts an exception table entry on the PREFETCH instruction to
> overwrite it with a JMP.d8 when it triggers an exception. Except of
> course, our code is no longer writable, also SMP.
> 
> Instead of fixing this broken mess, simply take it out.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/Kconfig                               |    2 
>  arch/x86/Kconfig.cpu                           |    4 
>  arch/x86/include/asm/mmx.h                     |   15 
>  arch/x86/include/asm/page_32.h                 |   14 
>  arch/x86/include/asm/required-features.h       |    4 
>  arch/x86/include/asm/string_32.h               |   33 --
>  arch/x86/lib/Makefile                          |    1 
>  arch/x86/lib/memcpy_32.c                       |    4 
>  arch/x86/lib/mmx_32.c                          |  388 -------------------------
>  arch/x86/lib/usercopy_32.c                     |    1 
>  tools/arch/x86/include/asm/required-features.h |    4 
>  11 files changed, 1 insertion(+), 469 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

Obviously. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
