Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D944C332102
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhCIIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:45:42 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:34689 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCIIpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:45:33 -0500
Received: by mail-vs1-f43.google.com with SMTP id m18so6403785vsa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 00:45:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lmndnbPQCr8AXP1pY/aZuEbMdRzjbk8ym+KsHGcxBc=;
        b=LsCUYpRCvrARTCeosyDHNRBxTS5dgJg0XibBdgLa5qpwx8EGGEiyhbv8KUFzV6EFeO
         EG5aLlSqHC1Bw2FqakzduorMG9pTKQqj+nwhU+ovpZFFdDPYV/YNkopjTphHyjdsxFAH
         b1mZCHu+0NNaMYwktjpaKDcNQs4u3GIHsnhzPZRF817w5OR7C8Rr47YJK5l8kxc5+6aK
         YgSlY26hwkIFLHptL29qkzpTHc/GUXcc1f23lRZ1oKGxtoFcoJ6yVRykbD1DU3jeijYm
         j5gZs0ccEUDfyNprXuPj7nAGx4nzOtChzBClewkMkGOu3Nn+NpB0VEV2wrmK81Eh4Cst
         x+8A==
X-Gm-Message-State: AOAM530itNOR8VfLAWfBPKFogi47BvWr9rfTLtVIzIGZcJX0Cy4COisM
        fK6KUxT2IHXJRzZJp/DKoftRv1QMPnjJqguRc6I=
X-Google-Smtp-Source: ABdhPJy4eZcopEWPCDQNfxdWr+R5xrYzx0ZKx+VvIgjy2lopCK6Zmh5Qq7qdK7rD5P4ilSTOPk+7P0s2HbgXZZnnOwE=
X-Received: by 2002:a67:f7c6:: with SMTP id a6mr16056565vsp.42.1615279531653;
 Tue, 09 Mar 2021 00:45:31 -0800 (PST)
MIME-Version: 1.0
References: <8d7d285a027e9d21f5ff7f850fa71a2655b0c4af.1615279170.git.christophe.leroy@csgroup.eu>
In-Reply-To: <8d7d285a027e9d21f5ff7f850fa71a2655b0c4af.1615279170.git.christophe.leroy@csgroup.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 9 Mar 2021 09:45:20 +0100
Message-ID: <CAMuHMdW0Cn1So8ckvhsT+N+p2hiPiksmCS32jzM0xCUYU4UAdQ@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Tue, Mar 9, 2021 at 9:39 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Add stub instances of enable_kernel_vsx() and disable_kernel_vsx()
> when CONFIG_VSX is not set, to avoid following build failure.
>
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o
> In file included from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
>                  from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:37,
>                  from drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:27:
> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: In function 'dcn_bw_apply_registry_override':
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:64:3: error: implicit declaration of function 'enable_kernel_vsx'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
>    64 |   enable_kernel_vsx(); \
>       |   ^~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:640:2: note: in expansion of macro 'DC_FP_START'
>   640 |  DC_FP_START();
>       |  ^~~~~~~~~~~
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:75:3: error: implicit declaration of function 'disable_kernel_vsx'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
>    75 |   disable_kernel_vsx(); \
>       |   ^~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:676:2: note: in expansion of macro 'DC_FP_END'
>   676 |  DC_FP_END();
>       |  ^~~~~~~~~
> cc1: some warnings being treated as errors
> make[5]: *** [drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o] Error 1
>
> Fixes: 16a9dea110a6 ("amdgpu: Enable initial DCN support on POWER")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks for your patch!

> --- a/arch/powerpc/include/asm/switch_to.h
> +++ b/arch/powerpc/include/asm/switch_to.h
> @@ -71,6 +71,16 @@ static inline void disable_kernel_vsx(void)
>  {
>         msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
>  }
> +#else
> +static inline void enable_kernel_vsx(void)
> +{
> +       BUILD_BUG();
> +}
> +
> +static inline void disable_kernel_vsx(void)
> +{
> +       BUILD_BUG();
> +}
>  #endif

I'm wondering how this is any better than the current situation: using
BUILD_BUG() will still cause a build failure?

What about adding "depends on !POWERPC || VSX" instead, to prevent
the issue from happening in the first place?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
