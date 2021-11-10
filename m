Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD9D44C5BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 18:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhKJRO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 12:14:59 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:40099 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhKJRO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:14:57 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HqBGw58FDz9sSJ;
        Wed, 10 Nov 2021 18:12:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BV-OD3C18pQI; Wed, 10 Nov 2021 18:12:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HqBGw4CxQz9sSG;
        Wed, 10 Nov 2021 18:12:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B5D88B77E;
        Wed, 10 Nov 2021 18:12:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EhBDh9Hq4S2x; Wed, 10 Nov 2021 18:12:08 +0100 (CET)
Received: from [192.168.233.217] (unknown [192.168.233.217])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0391B8B77A;
        Wed, 10 Nov 2021 18:12:07 +0100 (CET)
Message-ID: <ed04d4a1-7a60-ee39-f64b-203b299e8875@csgroup.eu>
Date:   Wed, 10 Nov 2021 18:12:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] powerpc: Fix sigset_t copy
Content-Language: fr-FR
To:     Finn Thain <fthain@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     "Christopher M. Riedl" <cmr@bluescreens.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <08bbe7240b384016e0b2912ecf3bf5e2d25ef2c6.1636501628.git.fthain@linux-m68k.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <08bbe7240b384016e0b2912ecf3bf5e2d25ef2c6.1636501628.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/11/2021 à 00:47, Finn Thain a écrit :
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> The conversion from __copy_from_user() to __get_user() introduced a
> regression in __get_user_sigset() in v5.13. The bug was subsequently
> copied and pasted in unsafe_get_user_sigset().
> 
> The regression was reported by users of the Xorg packages distributed in
> Debian/powerpc --
> 
>      "The symptoms are that the fb screen goes blank, with the backlight
>      remaining on and no errors logged in /var/log; wdm (or startx) run
>      with no effect (I tried logging in in the blind, with no effect).
>      And they are hard to kill, requiring 'kill -KILL ...'"
> 
> Fix the regression by casting the __get_user() assignment lvalue to u64
> so that the entire struct gets copied.
> 
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Christopher M. Riedl <cmr@bluescreens.de>
> Link: https://lore.kernel.org/linuxppc-dev/FEtBUOuFPMN4zJy4bIOqz6C4xoliCbTxS7VtMKD6UZkbvEbycUceRgGAd7e9-trRdwVN3hWAbQi0qrNx8Zgn8niTQf2KPVdw-W35czDIaeQ=@protonmail.com/
> Fixes: 887f3ceb51cd ("powerpc/signal32: Convert do_setcontext[_tm]() to user access block")
> Fixes: d3ccc9781560 ("powerpc/signal: Use __get_user() to copy sigset_t")
> Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---

Hi Finn,

> Christophe, I hope this change is the one you wanted to see upstream (?).
> If it is acceptable please add your signed-off-by tag.

I'm on holidays, I was planing to handle this next week.

Only PPC64 uses __get_user_sigset() on mainline so I don't think it is 
worth modifying it. If we decide to modify it anyway in mainline, it 
should be another patch that can be backported without additional effort.

For unsafe_get_user_sigset(), as we don't have the KUAP overhead that we 
had with __get_user(), I'd prefer we simply perform two 32 bits 
unsafe_get_user(), one for sig[0] and one for sig[1], instead of all 
those casts to u64.

Thanks anyway for the detailed description of the problem.
Christophe

> ---
>   arch/powerpc/kernel/signal.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
> index 1f07317964e4..44e736b88e91 100644
> --- a/arch/powerpc/kernel/signal.h
> +++ b/arch/powerpc/kernel/signal.h
> @@ -23,10 +23,10 @@ static inline int __get_user_sigset(sigset_t *dst, const sigset_t __user *src)
>   {
>   	BUILD_BUG_ON(sizeof(sigset_t) != sizeof(u64));
>   
> -	return __get_user(dst->sig[0], (u64 __user *)&src->sig[0]);
> +	return __get_user(*(u64 *)&dst->sig[0], (u64 __user *)&src->sig[0]);
>   }
>   #define unsafe_get_user_sigset(dst, src, label) \
> -	unsafe_get_user((dst)->sig[0], (u64 __user *)&(src)->sig[0], label)
> +	unsafe_get_user(*(u64 *)&(dst)->sig[0], (u64 __user *)&(src)->sig[0], label)
>   
>   #ifdef CONFIG_VSX
>   extern unsigned long copy_vsx_to_user(void __user *to,
> 
