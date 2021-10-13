Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76FB42C16C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhJMNbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:31:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59550 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234642AbhJMNbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:31:41 -0400
Received: from zn.tnic (p200300ec2f1208001796bb6dc2170571.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:800:1796:bb6d:c217:571])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCB471EC051F;
        Wed, 13 Oct 2021 15:29:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634131776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eib15nFkl+n6OUtdA+Nl+GZd2C6LATPkGvYOz4Jw5cQ=;
        b=pkYNkNM66kf1BhNNweLzAppQouWU4/+Jh/rqixeY2s8GOCP02qVf19Wt1WzMvec/aanZkY
        8Ph8gmA5n6JP1TO+RoyA5kHT0w6RDoV1txruu9Hwe3I2K2Vbf+toOCVk159+EHcvBhnzZA
        r6Pwq1hpI364wsfEeCRJVV3GHYxc4qI=
Date:   Wed, 13 Oct 2021 15:29:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 1/9] objtool,x86: Replace alternatives with
 .retpoline_sites
Message-ID: <YWbfPxkMdpr96lqx@zn.tnic>
References: <20211013122217.304265366@infradead.org>
 <20211013123644.614129149@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013123644.614129149@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:22:18PM +0200, Peter Zijlstra wrote:
> Instead of writing complete alternatives, simply provide a list of all
> the retpoline thunk calls. Then the kernel is free to do with them as
> it pleases. Simpler code all-round.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/vmlinux.lds.S       |   12 +++
>  arch/x86/lib/retpoline.S            |   42 ------------
>  tools/objtool/arch/x86/decode.c     |  126 +++++++-----------------------------
>  tools/objtool/elf.c                 |   84 ------------------------
>  tools/objtool/include/objtool/elf.h |    1 
>  5 files changed, 38 insertions(+), 227 deletions(-)
> 
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -273,6 +273,18 @@ SECTIONS
>  	}

#ifdef CONFIG_RETPOLINE around it I guess...

>  	/*
> +	 * List of instructions that call/jmp/jcc to retpoline thunks
> +	 * __x86_indirect_thunk_*(). These instructions can be patched along
> +	 * with alternatives, after which the section can be freed.
> +	 */
> +	. = ALIGN(8);
> +	.retpoline_sites : AT(ADDR(.retpoline_sites) - LOAD_OFFSET) {
> +		__retpoline_sites = .;
> +		*(.retpoline_sites)
> +		__retpoline_sites_end = .;
> +	}

#endif

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
