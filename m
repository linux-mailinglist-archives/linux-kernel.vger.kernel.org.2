Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3A34BC18
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 13:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhC1LHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 07:07:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36374 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhC1LG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 07:06:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F7XwK2Cwzz9tyJY;
        Sun, 28 Mar 2021 13:06:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id X7bzXoFdbBWq; Sun, 28 Mar 2021 13:06:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F7XwK1C6Rz9tyJV;
        Sun, 28 Mar 2021 13:06:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BE4098B782;
        Sun, 28 Mar 2021 13:06:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EfLRhhLErgBp; Sun, 28 Mar 2021 13:06:57 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0EEB08B75F;
        Sun, 28 Mar 2021 13:06:57 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Fix HAVE_HARDLOCKUP_DETECTOR_ARCH build
 configuration
To:     Chen Huang <chenhuang5@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Don Zickus <dzickus@redhat.com>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Hulk Robot <hulkci@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20210327094900.938555-1-chenhuang5@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <dd6b25d3-006b-be1e-9c4f-89e66aefb519@csgroup.eu>
Date:   Sun, 28 Mar 2021 13:06:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210327094900.938555-1-chenhuang5@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 27/03/2021 à 10:49, Chen Huang a écrit :
> When compiling the powerpc with the SMP disabled, it shows the issue:
> 
> arch/powerpc/kernel/watchdog.c: In function ‘watchdog_smp_panic’:
> arch/powerpc/kernel/watchdog.c:177:4: error: implicit declaration of function ‘smp_send_nmi_ipi’; did you mean ‘smp_send_stop’? [-Werror=implicit-function-declaration]
>    177 |    smp_send_nmi_ipi(c, wd_lockup_ipi, 1000000);
>        |    ^~~~~~~~~~~~~~~~
>        |    smp_send_stop
> cc1: all warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:273: arch/powerpc/kernel/watchdog.o] Error 1
> make[1]: *** [scripts/Makefile.build:534: arch/powerpc/kernel] Error 2
> make: *** [Makefile:1980: arch/powerpc] Error 2
> make: *** Waiting for unfinished jobs....
> 
> We found that powerpc used ipi to implement hardlockup watchdog, so the
> HAVE_HARDLOCKUP_DETECTOR_ARCH should depend on the SMP.
> 
> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Huang <chenhuang5@huawei.com>
> ---
>   arch/powerpc/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 764df010baee..2d4f37b117ce 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -225,7 +225,7 @@ config PPC
>   	select HAVE_LIVEPATCH			if HAVE_DYNAMIC_FTRACE_WITH_REGS
>   	select HAVE_MOD_ARCH_SPECIFIC
>   	select HAVE_NMI				if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
> -	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if (PPC64 && PPC_BOOK3S)
> +	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC64 && PPC_BOOK3S && SMP

While modifying this line, you should restore the alphabetic order by moving it up.

You can use PPC_BOOK3S_64 instead of PPC64 && PPC_BOOK3S

>   	select HAVE_OPTPROBES			if PPC64
>   	select HAVE_PERF_EVENTS
>   	select HAVE_PERF_EVENTS_NMI		if PPC64
> 
