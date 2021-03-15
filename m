Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0AD33B201
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhCOMDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229830AbhCOMCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:02:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBF1C64EE3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615809766;
        bh=pKDYtf7UiwMwhGb5OugYKdHJp6nVCYTST0NZnpxnYBI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BQTMIuMkB1PrjurJ/suYgZwYbr4chEt2an6hzna72s6isJoMCGrvDJzqTNOZDmfjf
         3TOGYvcAslkb0dox05Y24f9KWHtkxX+M5eeFYMFeoAT4apDJYPB83F6lTCSqoGbNIP
         9urQiWBwjVcemXMOHTvkN5wBE0d+NXrGog2Tivj06XcZ6t6OxYrGSQrBEMxv4kDHr0
         n2thsTzBAftIDKE8E6iUg7zkz1Jayy48+7tWLT061NZXgEKLdBTt0HETBzMFkjlnvn
         3wMIK1FEPuJHu4+WVWyOWQghpjbQIcEvkW1IiLfkvbUKBhsVmuZK9QibmEFPLtkXRQ
         FQimQ28uewQpw==
Received: by mail-ot1-f42.google.com with SMTP id 101-20020a9d04ee0000b02901b506659320so4968645otm.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:02:46 -0700 (PDT)
X-Gm-Message-State: AOAM530rjXtxy3CXtIcxvcvyaqu6vpTfIt4Zh0gfocu2mFjIlth77Yv9
        oGOSA0K63CVo+1daja6xI/WuqsOgwinQKmsvhck=
X-Google-Smtp-Source: ABdhPJx2aURTMFTXLhyY55yp8MnoGqDYXpEXtgJR6ZHPoqFptGwVbX8S62S/rOtwe+2lwHUXYTIM0xwmHDboagQSrE8=
X-Received: by 2002:a9d:6e15:: with SMTP id e21mr13669773otr.77.1615809765969;
 Mon, 15 Mar 2021 05:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210106103453.152275-1-andre.przywara@arm.com> <20210106103453.152275-4-andre.przywara@arm.com>
In-Reply-To: <20210106103453.152275-4-andre.przywara@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Mar 2021 13:02:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXENEpQMWXCxDa28mC0qqNubVFE42VvLPm-NDWTOpRtUiQ@mail.gmail.com>
Message-ID: <CAMj1kXENEpQMWXCxDa28mC0qqNubVFE42VvLPm-NDWTOpRtUiQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] ARM: implement support for SMCCC TRNG entropy source
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jan 2021 at 11:35, Andre Przywara <andre.przywara@arm.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Implement arch_get_random_seed_*() for ARM based on the firmware
> or hypervisor provided entropy source described in ARM DEN0098.
>
> This will make the kernel's random number generator consume entropy
> provided by this interface, at early boot, and periodically at
> runtime when reseeding.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> [Andre: rework to be initialised by the SMCCC firmware driver]
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I think this one could be dropped into rmk's patch tracker now, right?


> ---
>  arch/arm/Kconfig                  |  4 ++
>  arch/arm/include/asm/archrandom.h | 64 +++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 138248999df7..bfe642510b0a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1644,6 +1644,10 @@ config STACKPROTECTOR_PER_TASK
>           Enable this option to switch to a different method that uses a
>           different canary value for each task.
>
> +config ARCH_RANDOM
> +       def_bool y
> +       depends on HAVE_ARM_SMCCC_DISCOVERY
> +
>  endmenu
>
>  menu "Boot options"
> diff --git a/arch/arm/include/asm/archrandom.h b/arch/arm/include/asm/archrandom.h
> index a8e84ca5c2ee..f3e96a5b65f8 100644
> --- a/arch/arm/include/asm/archrandom.h
> +++ b/arch/arm/include/asm/archrandom.h
> @@ -2,9 +2,73 @@
>  #ifndef _ASM_ARCHRANDOM_H
>  #define _ASM_ARCHRANDOM_H
>
> +#ifdef CONFIG_ARCH_RANDOM
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/kernel.h>
> +
> +#define ARM_SMCCC_TRNG_MIN_VERSION     0x10000UL
> +
> +extern bool smccc_trng_available;
> +
> +static inline bool __init smccc_probe_trng(void)
> +{
> +       struct arm_smccc_res res;
> +
> +       arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_VERSION, &res);
> +       if ((s32)res.a0 < 0)
> +               return false;
> +       if (res.a0 >= ARM_SMCCC_TRNG_MIN_VERSION) {
> +               /* double check that the 32-bit flavor is available */
> +               arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_FEATURES,
> +                                    ARM_SMCCC_TRNG_RND32,
> +                                    &res);
> +               if ((s32)res.a0 >= 0)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static inline bool __must_check arch_get_random_long(unsigned long *v)
> +{
> +       return false;
> +}
> +
> +static inline bool __must_check arch_get_random_int(unsigned int *v)
> +{
> +       return false;
> +}
> +
> +static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
> +{
> +       struct arm_smccc_res res;
> +
> +       if (smccc_trng_available) {
> +               arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND32, 8 * sizeof(*v), &res);
> +
> +               if (res.a0 != 0)
> +                       return false;
> +
> +               *v = res.a3;
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
> +{
> +       return arch_get_random_seed_long((unsigned long *)v);
> +}
> +
> +
> +#else /* !CONFIG_ARCH_RANDOM */
> +
>  static inline bool __init smccc_probe_trng(void)
>  {
>         return false;
>  }
>
> +#endif /* CONFIG_ARCH_RANDOM */
>  #endif /* _ASM_ARCHRANDOM_H */
> --
> 2.17.1
>
