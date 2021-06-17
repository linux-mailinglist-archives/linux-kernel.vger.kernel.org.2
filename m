Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7603AAC3B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhFQGco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 02:32:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:29067 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhFQGcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:32:41 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G5Bxz2jCKzBDnG;
        Thu, 17 Jun 2021 08:30:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QpXYjQvoTAjz; Thu, 17 Jun 2021 08:30:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G5Bxy1dqgzBDkw;
        Thu, 17 Jun 2021 08:30:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1BE708B801;
        Thu, 17 Jun 2021 08:30:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2UIxgwKDwaK1; Thu, 17 Jun 2021 08:30:30 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE76B8B805;
        Thu, 17 Jun 2021 08:30:28 +0200 (CEST)
Subject: Re: [PATCH v3 22/23] powerpc/vdso: Migrate native signals to generic
 vdso_base
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
References: <20210611180242.711399-1-dima@arista.com>
 <20210611180242.711399-23-dima@arista.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4500e70f-19bc-588c-df8f-d5b5b304ee49@csgroup.eu>
Date:   Thu, 17 Jun 2021 08:30:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611180242.711399-23-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/06/2021 à 20:02, Dmitry Safonov a écrit :
> Generic way to track the land vma area.
> Stat speaks for itself.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---

> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 4bc45d3ed8b0..71dedeac7fdb 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -260,15 +260,6 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
>   
>   extern void arch_exit_mmap(struct mm_struct *mm);
>   
> -static inline void arch_unmap(struct mm_struct *mm,
> -			      unsigned long start, unsigned long end)
> -{
> -	unsigned long vdso_base = (unsigned long)mm->context.vdso;
> -
> -	if (start <= vdso_base && vdso_base < end)
> -		mm->context.vdso = NULL;
> -}
> -
>   #ifdef CONFIG_PPC_MEM_KEYS
>   bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write,
>   			       bool execute, bool foreign);

powerpc was the only user of arch_unmap().

We should get rid of it completely (Remove the stubs in arch/x86/include/asm/mmu_context.h and 
include/asm-generic/mm_hooks.h and remove call in mm/mmap.c)
