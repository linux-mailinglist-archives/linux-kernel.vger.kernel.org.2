Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E714C365F26
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhDTS0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhDTS0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:26:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2A7C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ozu5pdOsYN6E+7mGSErSyhQ4h8W6Zeylc79fQOt8oNU=; b=QGcJRLgQygNn+NaLdcxrGCNCGy
        qnEu7pRgRnh1OA99tLT1w4G7qSqqPJoYpUB1Jxac2cAPiQwXUXAxYFa0/4jrn2NO7AQshrx1CBTTf
        AiGcWtwnZq4zVAt1m7ZE8UKNIiFJHNLGRVEDQLkLjVN7/jvkRjiSU+u9aMt0ujmoR10e9g4VSlRbk
        EQnZDQAbd2HnYD3299LR2ebHfCjlxHw3n5/EOABRMUnEm+YH0tCMEu8l6iz8B0vhgH/lC5t//YfO3
        G5D0pkv1WpBPJAbh1qExBQHxHmpYj1eZKyhN8C6ZSlKKjJNrPhE1jeXBA/LeEk4iendeKcoD4uTjZ
        cPUcW0Xw==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYv3y-00FUrP-6C; Tue, 20 Apr 2021 18:25:42 +0000
Subject: Re: PPC_FPU, ALTIVEC: enable_kernel_fp, put_vr, get_vr
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <7107fcae-5c7a-ac94-8d89-326f2cd4cd33@infradead.org>
 <8b1cb0a2-ed3a-7da0-a73a-febbda528703@csgroup.eu>
 <20210418174648.GN26583@gate.crashing.org>
 <bf119bfe-7db1-e7f3-d837-f910635eeebb@infradead.org>
 <87sg3mct3x.fsf@mpe.ellerman.id.au>
 <bd83b06d-ed36-e600-e988-c1e0014fb9cf@infradead.org>
 <1f337b4c-940e-110c-d0a2-2ad95cfb2dc8@csgroup.eu>
 <871rb5cd25.fsf@mpe.ellerman.id.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1aac1f8c-00e7-87e5-2dc9-433367e284c2@infradead.org>
Date:   Tue, 20 Apr 2021 11:25:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <871rb5cd25.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/21 6:15 AM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> Le 19/04/2021 à 23:39, Randy Dunlap a écrit :
>>> On 4/19/21 6:16 AM, Michael Ellerman wrote:
>>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>
>>>>> Sure.  I'll post them later today.
>>>>> They keep FPU and ALTIVEC as independent (build) features.
>>>>
>>>> Those patches look OK.
>>>>
>>>> But I don't think it makes sense to support that configuration, FPU=n
>>>> ALTVEC=y. No one is ever going to make a CPU like that. We have enough
>>>> testing surface due to configuration options, without adding artificial
>>>> combinations that no one is ever going to use.
>>>>
>>>> IMHO :)
>>>>
>>>> So I'd rather we just make ALTIVEC depend on FPU.
>>>
>>> That's rather simple. See below.
>>> I'm doing a bunch of randconfig builds with it now.
>>>
>>> ---
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>> Subject: [PATCH] powerpc: make ALTIVEC depend PPC_FPU
>>>
>>> On a kernel config with ALTIVEC=y and PPC_FPU not set/enabled,
>>> there are build errors:
>>>
>>> drivers/cpufreq/pmac32-cpufreq.c:262:2: error: implicit declaration of function 'enable_kernel_fp' [-Werror,-Wimplicit-function-declaration]
>>>             enable_kernel_fp();
>>> ../arch/powerpc/lib/sstep.c: In function 'do_vec_load':
>>> ../arch/powerpc/lib/sstep.c:637:3: error: implicit declaration of function 'put_vr' [-Werror=implicit-function-declaration]
>>>    637 |   put_vr(rn, &u.v);
>>>        |   ^~~~~~
>>> ../arch/powerpc/lib/sstep.c: In function 'do_vec_store':
>>> ../arch/powerpc/lib/sstep.c:660:3: error: implicit declaration of function 'get_vr'; did you mean 'get_oc'? [-Werror=implicit-function-declaration]
>>>    660 |   get_vr(rn, &u.v);
>>>        |   ^~~~~~
>>>
>>> In theory ALTIVEC is independent of PPC_FPU but in practice nobody
>>> is going to build such a machine, so make ALTIVEC require PPC_FPU
>>> by depending on PPC_FPU.
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> Cc: Segher Boessenkool <segher@kernel.crashing.org>
>>> Cc: lkp@intel.com
>>> ---
>>>   arch/powerpc/platforms/86xx/Kconfig    |    1 +
>>>   arch/powerpc/platforms/Kconfig.cputype |    2 ++
>>>   2 files changed, 3 insertions(+)
>>>
>>> --- linux-next-20210416.orig/arch/powerpc/platforms/86xx/Kconfig
>>> +++ linux-next-20210416/arch/powerpc/platforms/86xx/Kconfig
>>> @@ -4,6 +4,7 @@ menuconfig PPC_86xx
>>>   	bool "86xx-based boards"
>>>   	depends on PPC_BOOK3S_32
>>>   	select FSL_SOC
>>> +	select PPC_FPU
>>>   	select ALTIVEC
>>>   	help
>>>   	  The Freescale E600 SoCs have 74xx cores.
>>> --- linux-next-20210416.orig/arch/powerpc/platforms/Kconfig.cputype
>>> +++ linux-next-20210416/arch/powerpc/platforms/Kconfig.cputype
>>> @@ -186,6 +186,7 @@ config E300C3_CPU
>>>   config G4_CPU
>>>   	bool "G4 (74xx)"
>>>   	depends on PPC_BOOK3S_32
>>> +	select PPC_FPU
>>>   	select ALTIVEC
>>>   
>>>   endchoice
>>> @@ -309,6 +310,7 @@ config PHYS_64BIT
>>>   
>>>   config ALTIVEC
>>>   	bool "AltiVec Support"
>>> +	depends on PPC_FPU
>>
>> Shouldn't we do it the other way round ? In extenso make ALTIVEC select PPC_FPU and avoid the two 
>> selects that are above ?
> 
> Yes, ALTIVEC should select PPC_FPU.
> 
> The latter is (generally) not user selectable, so there's no issue with
> selecting it, whereas the reverse is not true.
> 
> For 64-bit Book3S I think we could just always enable ALTIVEC these
> days. It's only Power5 that doesn't have it, and essentially no one is
> running mainline on those AFAIK. But that can be done separately.

OK, I'll run that thru some tests today.

thanks.
-- 
~Randy

