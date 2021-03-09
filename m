Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBD833215C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhCIIwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:52:32 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:34275 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhCIIwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:52:19 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dvpqh2X62z9txd1;
        Tue,  9 Mar 2021 09:52:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dU0TJnMUe1p4; Tue,  9 Mar 2021 09:52:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dvpqh1dGGz9txd0;
        Tue,  9 Mar 2021 09:52:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2DA508B7DA;
        Tue,  9 Mar 2021 09:52:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Lti_ytR-jCZn; Tue,  9 Mar 2021 09:52:17 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 636798B7DB;
        Tue,  9 Mar 2021 09:52:16 +0100 (CET)
Subject: Re: [PATCH] powerpc: Fix missing declaration of
 [en/dis]able_kernel_vsx()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>
References: <8d7d285a027e9d21f5ff7f850fa71a2655b0c4af.1615279170.git.christophe.leroy@csgroup.eu>
 <CAMuHMdW0Cn1So8ckvhsT+N+p2hiPiksmCS32jzM0xCUYU4UAdQ@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b12f9128-790b-7d8b-5f3c-e0912f5bec0a@csgroup.eu>
Date:   Tue, 9 Mar 2021 09:52:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW0Cn1So8ckvhsT+N+p2hiPiksmCS32jzM0xCUYU4UAdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/03/2021 à 09:45, Geert Uytterhoeven a écrit :
> Hi Christophe,
> 
> On Tue, Mar 9, 2021 at 9:39 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>> Add stub instances of enable_kernel_vsx() and disable_kernel_vsx()
>> when CONFIG_VSX is not set, to avoid following build failure.
>>
>>    CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o
>> In file included from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
>>                   from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:37,
>>                   from drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:27:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: In function 'dcn_bw_apply_registry_override':
>> ./drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:64:3: error: implicit declaration of function 'enable_kernel_vsx'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
>>     64 |   enable_kernel_vsx(); \
>>        |   ^~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:640:2: note: in expansion of macro 'DC_FP_START'
>>    640 |  DC_FP_START();
>>        |  ^~~~~~~~~~~
>> ./drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:75:3: error: implicit declaration of function 'disable_kernel_vsx'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
>>     75 |   disable_kernel_vsx(); \
>>        |   ^~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:676:2: note: in expansion of macro 'DC_FP_END'
>>    676 |  DC_FP_END();
>>        |  ^~~~~~~~~
>> cc1: some warnings being treated as errors
>> make[5]: *** [drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o] Error 1
>>
>> Fixes: 16a9dea110a6 ("amdgpu: Enable initial DCN support on POWER")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Thanks for your patch!
> 
>> --- a/arch/powerpc/include/asm/switch_to.h
>> +++ b/arch/powerpc/include/asm/switch_to.h
>> @@ -71,6 +71,16 @@ static inline void disable_kernel_vsx(void)
>>   {
>>          msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
>>   }
>> +#else
>> +static inline void enable_kernel_vsx(void)
>> +{
>> +       BUILD_BUG();
>> +}
>> +
>> +static inline void disable_kernel_vsx(void)
>> +{
>> +       BUILD_BUG();
>> +}
>>   #endif
> 
> I'm wondering how this is any better than the current situation: using
> BUILD_BUG() will still cause a build failure?

No it won't cause a failure. In drivers/gpu/drm/amd/display/dc/os_types.h you have:

#define DC_FP_START() { \
	if (cpu_has_feature(CPU_FTR_VSX_COMP)) { \
		preempt_disable(); \
		enable_kernel_vsx(); \
	} else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP)) { \
		preempt_disable(); \
		enable_kernel_altivec(); \
	} else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE)) { \
		preempt_disable(); \
		enable_kernel_fp(); \
	} \

When CONFIG_VSX is not selected, cpu_has_feature(CPU_FTR_VSX_COMP) constant folds to 'false' so the 
call to enable_kernel_vsx() is discarded and the build succeeds.

> 
> What about adding "depends on !POWERPC || VSX" instead, to prevent
> the issue from happening in the first place?

CONFIG_VSX is not required as pointed by the DC_FP_START() macro above and the matching DC_FP_END() 
macro.

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 


Christophe
