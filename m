Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0743651AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 06:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhDTE4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 00:56:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3843 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDTE4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 00:56:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FPWb91nFPz9vBKZ;
        Tue, 20 Apr 2021 06:55:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ie5cxGwG9F7s; Tue, 20 Apr 2021 06:55:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FPWb90hkBz9vBKT;
        Tue, 20 Apr 2021 06:55:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C58218B7D6;
        Tue, 20 Apr 2021 06:55:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wk-bweOaRv6E; Tue, 20 Apr 2021 06:55:33 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3642D8B7CB;
        Tue, 20 Apr 2021 06:55:33 +0200 (CEST)
Subject: Re: PPC_FPU, ALTIVEC: enable_kernel_fp, put_vr, get_vr
To:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <7107fcae-5c7a-ac94-8d89-326f2cd4cd33@infradead.org>
 <8b1cb0a2-ed3a-7da0-a73a-febbda528703@csgroup.eu>
 <20210418174648.GN26583@gate.crashing.org>
 <bf119bfe-7db1-e7f3-d837-f910635eeebb@infradead.org>
 <87sg3mct3x.fsf@mpe.ellerman.id.au>
 <bd83b06d-ed36-e600-e988-c1e0014fb9cf@infradead.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1f337b4c-940e-110c-d0a2-2ad95cfb2dc8@csgroup.eu>
Date:   Tue, 20 Apr 2021 06:55:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <bd83b06d-ed36-e600-e988-c1e0014fb9cf@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/04/2021 à 23:39, Randy Dunlap a écrit :
> On 4/19/21 6:16 AM, Michael Ellerman wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>>> Sure.  I'll post them later today.
>>> They keep FPU and ALTIVEC as independent (build) features.
>>
>> Those patches look OK.
>>
>> But I don't think it makes sense to support that configuration, FPU=n
>> ALTVEC=y. No one is ever going to make a CPU like that. We have enough
>> testing surface due to configuration options, without adding artificial
>> combinations that no one is ever going to use.
>>
>> IMHO :)
>>
>> So I'd rather we just make ALTIVEC depend on FPU.
> 
> That's rather simple. See below.
> I'm doing a bunch of randconfig builds with it now.
> 
> ---
> From: Randy Dunlap <rdunlap@infradead.org>
> Subject: [PATCH] powerpc: make ALTIVEC depend PPC_FPU
> 
> On a kernel config with ALTIVEC=y and PPC_FPU not set/enabled,
> there are build errors:
> 
> drivers/cpufreq/pmac32-cpufreq.c:262:2: error: implicit declaration of function 'enable_kernel_fp' [-Werror,-Wimplicit-function-declaration]
>             enable_kernel_fp();
> ../arch/powerpc/lib/sstep.c: In function 'do_vec_load':
> ../arch/powerpc/lib/sstep.c:637:3: error: implicit declaration of function 'put_vr' [-Werror=implicit-function-declaration]
>    637 |   put_vr(rn, &u.v);
>        |   ^~~~~~
> ../arch/powerpc/lib/sstep.c: In function 'do_vec_store':
> ../arch/powerpc/lib/sstep.c:660:3: error: implicit declaration of function 'get_vr'; did you mean 'get_oc'? [-Werror=implicit-function-declaration]
>    660 |   get_vr(rn, &u.v);
>        |   ^~~~~~
> 
> In theory ALTIVEC is independent of PPC_FPU but in practice nobody
> is going to build such a machine, so make ALTIVEC require PPC_FPU
> by depending on PPC_FPU.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: lkp@intel.com
> ---
>   arch/powerpc/platforms/86xx/Kconfig    |    1 +
>   arch/powerpc/platforms/Kconfig.cputype |    2 ++
>   2 files changed, 3 insertions(+)
> 
> --- linux-next-20210416.orig/arch/powerpc/platforms/86xx/Kconfig
> +++ linux-next-20210416/arch/powerpc/platforms/86xx/Kconfig
> @@ -4,6 +4,7 @@ menuconfig PPC_86xx
>   	bool "86xx-based boards"
>   	depends on PPC_BOOK3S_32
>   	select FSL_SOC
> +	select PPC_FPU
>   	select ALTIVEC
>   	help
>   	  The Freescale E600 SoCs have 74xx cores.
> --- linux-next-20210416.orig/arch/powerpc/platforms/Kconfig.cputype
> +++ linux-next-20210416/arch/powerpc/platforms/Kconfig.cputype
> @@ -186,6 +186,7 @@ config E300C3_CPU
>   config G4_CPU
>   	bool "G4 (74xx)"
>   	depends on PPC_BOOK3S_32
> +	select PPC_FPU
>   	select ALTIVEC
>   
>   endchoice
> @@ -309,6 +310,7 @@ config PHYS_64BIT
>   
>   config ALTIVEC
>   	bool "AltiVec Support"
> +	depends on PPC_FPU

Shouldn't we do it the other way round ? In extenso make ALTIVEC select PPC_FPU and avoid the two 
selects that are above ?

>   	depends on PPC_BOOK3S_32 || PPC_BOOK3S_64 || (PPC_E500MC && PPC64)
>   	help
>   	  This option enables kernel support for the Altivec extensions to the
> 
