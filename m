Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C70642030F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 19:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhJCRRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhJCRRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 13:17:36 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C29C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 10:15:48 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h20so15872598ilj.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JhNHAkQYs0q543UXbdIS0YUcmawVIjR2itOxVo67Ac=;
        b=emCHt75xmQzy4LoUWKWBsqVvCphrVe+6fxIxDd5X1IqBG8DXBJiFZhf7HLX7MBYIvG
         N/l6fLZ/ETfhw3gfu4HtogOQHl/yf+n3FnV+cRQWGbnYj1Asu+VsTdhkw4FjgYVnd0CP
         S/sPRBd7AFIunyFYI35akf9xhXhjzfW+tw1/eTemlYCW48i9qQdSCCNAwqpiXBoaOyaB
         ZHxa8mydSgbqyWHSDbcdQyWTq7OM7zvRRPzlOTmEQ2JuC8BmzWG8eYD8Nb6npXn5CU59
         ArhXtkq4pX/eekTY1J1XNjBoQ+urlXD/X7IUY+wg179WrPH9BerWLzLnzRtAaZBG6FFm
         RYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JhNHAkQYs0q543UXbdIS0YUcmawVIjR2itOxVo67Ac=;
        b=hRxR/M2vRKv/MxRggP3lM73jSa/uljnk0nO2VDgfojwn7gfB7hCDuK4+btPWD3EcuZ
         ngy3S3+CPWa3pYFufMjF7JcdpmmWxtvLoS8zXt1V7y3ZVA5iSyOKIch8xI8H2yT/qAo1
         v9PozLbHxEKm1otTcDYrYtCsyzDKzCmFihAR+YJ8WNRlEDHRmFo7mTb3YnwTbsE28ko8
         l8iL8bGYy98e2dVnPogWmsajBmPVtszsYFTZK5aqLT+xxCoqVUv9q+Or5pZvOXgD8dcs
         SkCB1SUJSMjmGWO4FSZ1np73OndhvabxweRRg7nrS5VuRFR7P2yL9OOwWQPY+3H0djBT
         4Wcg==
X-Gm-Message-State: AOAM531uwsBlbESxS9vrA8qaNlbjL/sKZlFNa8O8yKyCYtajZx+S3mAB
        t8JJOuXjPL/PJ4No52iVGCP8X6L/bUe3Ec2YstqnlpJIWmcr1g==
X-Google-Smtp-Source: ABdhPJz+tyocE96vComzYTqi63RCWWs2btB5KIIDEMFNAPy1sixmGguuNG6lGnkX0DBuGuy3aBFxnIz8/6pq0OIl3BU=
X-Received: by 2002:a92:ca4a:: with SMTP id q10mr360097ilo.233.1633281348059;
 Sun, 03 Oct 2021 10:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210913081424.48613-1-vincenzo.frascino@arm.com> <20210913081424.48613-5-vincenzo.frascino@arm.com>
In-Reply-To: <20210913081424.48613-5-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 3 Oct 2021 19:15:37 +0200
Message-ID: <CA+fCnZeW35+ZmvM6SxZSb_NAMqsK42Ds_ADVKeVkfs9MT=Aovg@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: mte: Add asymmetric mode support
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 10:14 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> MTE provides an asymmetric mode for detecting tag exceptions. In
> particular, when such a mode is present, the CPU triggers a fault
> on a tag mismatch during a load operation and asynchronously updates
> a register when a tag mismatch is detected during a store operation.
>
> Add support for MTE asymmetric mode.
>
> Note: If the CPU does not support MTE asymmetric mode the kernel falls
> back on synchronous mode which is the default for kasan=on.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/memory.h    |  1 +
>  arch/arm64/include/asm/mte-kasan.h |  5 +++++
>  arch/arm64/kernel/mte.c            | 26 ++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index f1745a843414..1b9a1e242612 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -243,6 +243,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>  #ifdef CONFIG_KASAN_HW_TAGS
>  #define arch_enable_tagging_sync()             mte_enable_kernel_sync()
>  #define arch_enable_tagging_async()            mte_enable_kernel_async()
> +#define arch_enable_tagging_asymm()            mte_enable_kernel_asymm()
>  #define arch_force_async_tag_fault()           mte_check_tfsr_exit()
>  #define arch_get_random_tag()                  mte_get_random_tag()
>  #define arch_get_mem_tag(addr)                 mte_get_mem_tag(addr)
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> index 22420e1f8c03..478b9bcf69ad 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -130,6 +130,7 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag,
>
>  void mte_enable_kernel_sync(void);
>  void mte_enable_kernel_async(void);
> +void mte_enable_kernel_asymm(void);
>
>  #else /* CONFIG_ARM64_MTE */
>
> @@ -161,6 +162,10 @@ static inline void mte_enable_kernel_async(void)
>  {
>  }
>
> +static inline void mte_enable_kernel_asymm(void)
> +{
> +}
> +
>  #endif /* CONFIG_ARM64_MTE */
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 9d314a3bad3b..ef5484ecb2da 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -137,6 +137,32 @@ void mte_enable_kernel_async(void)
>         if (!system_uses_mte_async_mode())
>                 static_branch_enable(&mte_async_mode);
>  }
> +
> +void mte_enable_kernel_asymm(void)
> +{
> +       if (cpus_have_cap(ARM64_MTE_ASYMM)) {
> +               __mte_enable_kernel("asymmetric", SCTLR_ELx_TCF_ASYMM);
> +
> +               /*
> +                * MTE asymm mode behaves as async mode for store
> +                * operations. The mode is set system wide by the
> +                * first PE that executes this function.
> +                *
> +                * Note: If in future KASAN acquires a runtime switching
> +                * mode in between sync and async, this strategy needs
> +                * to be reviewed.
> +                */
> +               if (!system_uses_mte_async_mode())
> +                       static_branch_enable(&mte_async_mode);

This part is confusing: mte_async_mode gets enabled for the asymm
mode, which contradicts the comment next to the mte_async_mode
definition.

> +       } else {
> +               /*
> +                * If the CPU does not support MTE asymmetric mode the
> +                * kernel falls back on synchronous mode which is the
> +                * default for kasan=on.
> +                */
> +               mte_enable_kernel_sync();
> +       }
> +}
>  #endif
>
>  #ifdef CONFIG_KASAN_HW_TAGS
> --
> 2.33.0
>
