Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043E9363695
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 18:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhDRQZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 12:25:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13553 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhDRQZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 12:25:01 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FNZyz5sfkz9tynS;
        Sun, 18 Apr 2021 18:24:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6vOFJhRsGw-R; Sun, 18 Apr 2021 18:24:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FNZyz4n1kz9tynR;
        Sun, 18 Apr 2021 18:24:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D9BB8B79C;
        Sun, 18 Apr 2021 18:24:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id w_yOQKn4wsA3; Sun, 18 Apr 2021 18:24:31 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D1FDA8B79B;
        Sun, 18 Apr 2021 18:24:30 +0200 (CEST)
Subject: Re: PPC_FPU, ALTIVEC: enable_kernel_fp, put_vr, get_vr
To:     Randy Dunlap <rdunlap@infradead.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <7107fcae-5c7a-ac94-8d89-326f2cd4cd33@infradead.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <8b1cb0a2-ed3a-7da0-a73a-febbda528703@csgroup.eu>
Date:   Sun, 18 Apr 2021 18:24:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <7107fcae-5c7a-ac94-8d89-326f2cd4cd33@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/04/2021 à 22:17, Randy Dunlap a écrit :
> Hi,
> 
> kernel test robot reports:
> 
>>> drivers/cpufreq/pmac32-cpufreq.c:262:2: error: implicit declaration of function 'enable_kernel_fp' [-Werror,-Wimplicit-function-declaration]
>             enable_kernel_fp();
>             ^
> 
> when
> # CONFIG_PPC_FPU is not set
> CONFIG_ALTIVEC=y
> 
> I see at least one other place that does not handle that
> combination well, here:
> 
> ../arch/powerpc/lib/sstep.c: In function 'do_vec_load':
> ../arch/powerpc/lib/sstep.c:637:3: error: implicit declaration of function 'put_vr' [-Werror=implicit-function-declaration]
>    637 |   put_vr(rn, &u.v);
>        |   ^~~~~~
> ../arch/powerpc/lib/sstep.c: In function 'do_vec_store':
> ../arch/powerpc/lib/sstep.c:660:3: error: implicit declaration of function 'get_vr'; did you mean 'get_oc'? [-Werror=implicit-function-declaration]
>    660 |   get_vr(rn, &u.v);
>        |   ^~~~~~
> 
> 
> Should the code + Kconfigs/Makefiles handle that kind of
> kernel config or should ALTIVEC always mean PPC_FPU as well?

As far as I understand, Altivec is completely independant of FPU in Theory. So it should be possible 
to use Altivec without using FPU.

However, until recently, it was not possible to de-activate FPU support on book3s/32. I made it 
possible in order to reduce unneccessary processing on processors like the 832x that has no FPU.
As far as I can see in cputable.h/.c, 832x is the only book3s/32 without FPU, and it doesn't have 
ALTIVEC either.

So we can in the future ensure that Altivec can be used without FPU support, but for the time being 
I think it is OK to force selection of FPU when selecting ALTIVEC in order to avoid build failures.

> 
> I have patches to fix the build errors with the config as
> reported but I don't know if that's the right thing to do...
> 

Lets see them.

Christophe
