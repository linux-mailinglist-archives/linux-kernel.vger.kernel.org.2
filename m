Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F033E3321C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhCIJQp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Mar 2021 04:16:45 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:34495 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCIJQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:16:36 -0500
Received: by mail-ua1-f47.google.com with SMTP id 101so4314923uag.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 01:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DxSUjQGZz4/YjWnn3wACv5aSRYiuKXpXdqRpRz0A8i4=;
        b=I/SgRrCFz25emtTutuWEehYLC4swdyMK+pA/nb7lFLdwxKaAvzPjca4olVhH+PXFm3
         jUkQxUxbDCJ+Q2N6oNB2lh4gAIQ6397NRggNAauaQgNLBnpNoU+TzcGhxvWNNYYGyeNx
         9meo/RGe7QcFET3z5wPnKqhaBuu4ZMVL1iQpMXm0coZp4nUXpGPFj1Zgvs1KiOeUQIGi
         NOK3NpHW/xzzLC9OB9SK2EjYGSD/57IDsLeWRsWCLAJmw5xnl8OoMmZZVkwa3UqQZy6c
         QzUEwfOEt1ET5goNqGawsqrs6hu5/u6VJ3sCRBeqc/wLuZJLt3jqc2y1TKbt+W0ku0f0
         8D8g==
X-Gm-Message-State: AOAM531tl6rl4A12iMcIBULA4/KAr4xBQDrDSCYVk4UjMDxMULH8hjGG
        wefnClB1HHoSvkzRS94cax1ePh6k6YTTEb+AbOkL5chO
X-Google-Smtp-Source: ABdhPJww7xH7Oe5Pjr4n5IpImR4mF9lUTXCXGNF+o1r811zxaElWbHX29Xxb/k0BiTXqUy738t90tdAg9Vt/0gLMISg=
X-Received: by 2002:a9f:35a1:: with SMTP id t30mr14845428uad.106.1615281395334;
 Tue, 09 Mar 2021 01:16:35 -0800 (PST)
MIME-Version: 1.0
References: <8d7d285a027e9d21f5ff7f850fa71a2655b0c4af.1615279170.git.christophe.leroy@csgroup.eu>
 <CAMuHMdW0Cn1So8ckvhsT+N+p2hiPiksmCS32jzM0xCUYU4UAdQ@mail.gmail.com> <b12f9128-790b-7d8b-5f3c-e0912f5bec0a@csgroup.eu>
In-Reply-To: <b12f9128-790b-7d8b-5f3c-e0912f5bec0a@csgroup.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 9 Mar 2021 10:16:24 +0100
Message-ID: <CAMuHMdXM0qg23UN6VBqbb0Vm2bg3tRSM=OCD5r7U2K1brpnJAg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix missing declaration of [en/dis]able_kernel_vsx()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Tue, Mar 9, 2021 at 9:52 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 09/03/2021 à 09:45, Geert Uytterhoeven a écrit :
> > On Tue, Mar 9, 2021 at 9:39 AM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >> Add stub instances of enable_kernel_vsx() and disable_kernel_vsx()
> >> when CONFIG_VSX is not set, to avoid following build failure.
> >>
> >>    CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o
> >> In file included from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
> >>                   from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:37,
> >>                   from drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:27:
> >> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: In function 'dcn_bw_apply_registry_override':
> >> ./drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:64:3: error: implicit declaration of function 'enable_kernel_vsx'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
> >>     64 |   enable_kernel_vsx(); \
> >>        |   ^~~~~~~~~~~~~~~~~
> >> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:640:2: note: in expansion of macro 'DC_FP_START'
> >>    640 |  DC_FP_START();
> >>        |  ^~~~~~~~~~~
> >> ./drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:75:3: error: implicit declaration of function 'disable_kernel_vsx'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
> >>     75 |   disable_kernel_vsx(); \
> >>        |   ^~~~~~~~~~~~~~~~~~
> >> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:676:2: note: in expansion of macro 'DC_FP_END'
> >>    676 |  DC_FP_END();
> >>        |  ^~~~~~~~~
> >> cc1: some warnings being treated as errors
> >> make[5]: *** [drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o] Error 1
> >>
> >> Fixes: 16a9dea110a6 ("amdgpu: Enable initial DCN support on POWER")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >
> > Thanks for your patch!
> >
> >> --- a/arch/powerpc/include/asm/switch_to.h
> >> +++ b/arch/powerpc/include/asm/switch_to.h
> >> @@ -71,6 +71,16 @@ static inline void disable_kernel_vsx(void)
> >>   {
> >>          msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
> >>   }
> >> +#else
> >> +static inline void enable_kernel_vsx(void)
> >> +{
> >> +       BUILD_BUG();
> >> +}
> >> +
> >> +static inline void disable_kernel_vsx(void)
> >> +{
> >> +       BUILD_BUG();
> >> +}
> >>   #endif
> >
> > I'm wondering how this is any better than the current situation: using
> > BUILD_BUG() will still cause a build failure?
>
> No it won't cause a failure. In drivers/gpu/drm/amd/display/dc/os_types.h you have:
>
> #define DC_FP_START() { \
>         if (cpu_has_feature(CPU_FTR_VSX_COMP)) { \
>                 preempt_disable(); \
>                 enable_kernel_vsx(); \
>         } else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP)) { \
>                 preempt_disable(); \
>                 enable_kernel_altivec(); \
>         } else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE)) { \
>                 preempt_disable(); \
>                 enable_kernel_fp(); \
>         } \
>
> When CONFIG_VSX is not selected, cpu_has_feature(CPU_FTR_VSX_COMP) constant folds to 'false' so the
> call to enable_kernel_vsx() is discarded and the build succeeds.

IC. So you might as well have an empty (dummy) function instead?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
