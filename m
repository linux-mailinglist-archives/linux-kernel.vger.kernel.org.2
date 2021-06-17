Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7863AAD45
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFQHW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:22:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21007 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhFQHW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:22:58 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G5D4158LszB9Fk;
        Thu, 17 Jun 2021 09:20:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wCDKAHjRDKix; Thu, 17 Jun 2021 09:20:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G5D3z4bHQzB9Wp;
        Thu, 17 Jun 2021 09:20:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 82ED08B801;
        Thu, 17 Jun 2021 09:20:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9faBJfkXW1W1; Thu, 17 Jun 2021 09:20:47 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 882DA8B770;
        Thu, 17 Jun 2021 09:20:46 +0200 (CEST)
Subject: Re: [PATCH v3 13/23] mm/mmap: Make vm_special_mapping::mremap return
 void
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
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20210611180242.711399-1-dima@arista.com>
 <20210611180242.711399-14-dima@arista.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <901f4541-ee96-5d6b-5453-559731d65e82@csgroup.eu>
Date:   Thu, 17 Jun 2021 09:20:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611180242.711399-14-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/06/2021 à 20:02, Dmitry Safonov a écrit :
> Previously .mremap() callback had to return (int) to provide
> a way to restrict resizing of a special mapping. Now it's
> restricted by providing .may_split = special_mapping_split.
> 
> Removing (int) return simplifies further changes to
> special_mapping_mremap() as it won't need save ret code from the
> callback. Also, it removes needless `return 0` from callbacks.
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>   arch/arm/kernel/process.c | 3 +--
>   arch/arm64/kernel/vdso.c  | 4 +---
>   arch/mips/vdso/genvdso.c  | 3 +--
>   arch/x86/entry/vdso/vma.c | 4 +---
>   include/linux/mm_types.h  | 4 ++--
>   mm/mmap.c                 | 2 +-
>   6 files changed, 7 insertions(+), 13 deletions(-)
> 

Build failure:

   CC      arch/powerpc/kernel/vdso.o
arch/powerpc/kernel/vdso.c:93:19: error: initialization of 'void (*)(const struct vm_special_mapping 
*, struct vm_area_struct *)' from incompatible pointer type 'int (*)(const struct vm_special_mapping 
*, struct vm_area_struct *)' [-Werror=incompatible-pointer-types]
    93 |         .mremap = vdso32_mremap,
       |                   ^~~~~~~~~~~~~
arch/powerpc/kernel/vdso.c:93:19: note: (near initialization for 'vdso32_spec.mremap')
arch/powerpc/kernel/vdso.c:98:19: error: initialization of 'void (*)(const struct vm_special_mapping 
*, struct vm_area_struct *)' from incompatible pointer type 'int (*)(const struct vm_special_mapping 
*, struct vm_area_struct *)' [-Werror=incompatible-pointer-types]
    98 |         .mremap = vdso64_mremap,
       |                   ^~~~~~~~~~~~~
arch/powerpc/kernel/vdso.c:98:19: note: (near initialization for 'vdso64_spec.mremap')
cc1: all warnings being treated as errors
make[3]: *** [arch/powerpc/kernel/vdso.o] Error 1
make[2]: *** [arch/powerpc/kernel] Error 2
make[1]: *** [arch/powerpc] Error 2
make: *** [__sub-make] Error 2

