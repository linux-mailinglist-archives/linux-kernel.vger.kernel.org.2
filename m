Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1857D3813F1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 00:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhENWyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 18:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230371AbhENWyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 18:54:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D9C86140A;
        Fri, 14 May 2021 22:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621032781;
        bh=YrRUzwUUrm9b+bJX+DwHQoDonOGLf0mKSa8j8FGg7hc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WuDBXv9qQA7ik47vsUWDo6OVFk52ZEbzTnCsKT7RgbhwlzjHMzSCAH4k46r0wu4RQ
         kaTtf8GAdkETlwZvE867WlH/3Xr9xMYefyqy0aURQe9Y39gTKG3tWPNJxfsge5Phw4
         l3fiTIYjgJAUDb0JE8kB7b4/y/yzRy+x5jqIemItjuAlsnDF+fw2xvcr3CiDzZ9z3l
         CgIyU4fD+8Q2zJmelOy4ba2vygF5TyepWsGEqGw0vDeFASFLtYm+G+NOu7wPutixCt
         i9I6BoKSBkIsX0WLftFozcjLNyMb68bu1TYrPgVIbTUJdbhkzqUhUsvKiIIroZRzUo
         m67o0GEHV6YqQ==
Subject: Re: [PATCH 1/6] x86/traps: add X86_NR_HW_TRAPS to <asm/trapnr.h>
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210511005531.1065536-1-hpa@zytor.com>
 <20210511005531.1065536-2-hpa@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <af998fee-7886-977a-a36b-8b21fe1edcca@kernel.org>
Date:   Fri, 14 May 2021 15:53:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511005531.1065536-2-hpa@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/21 5:55 PM, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> The x86 architecture supports up to 32 trap vectors. Add that constant
> to <asm/trapnr.h>.
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> ---
>  arch/x86/include/asm/trapnr.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/trapnr.h b/arch/x86/include/asm/trapnr.h
> index f5d2325aa0b7..f0baf92da20b 100644
> --- a/arch/x86/include/asm/trapnr.h
> +++ b/arch/x86/include/asm/trapnr.h
> @@ -27,6 +27,7 @@
>  #define X86_TRAP_VE		20	/* Virtualization Exception */
>  #define X86_TRAP_CP		21	/* Control Protection Exception */
>  #define X86_TRAP_VC		29	/* VMM Communication Exception */
> +#define X86_NR_HW_TRAPS		32	/* Max hardware trap number */
>  #define X86_TRAP_IRET		32	/* IRET Exception */
>  
>  #endif
> 

Acked-by: Andy Lutomirski <luto@kernel.org>
