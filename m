Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D5A4035A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350656AbhIHHqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233210AbhIHHqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:46:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE7FB61178
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 07:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631087135;
        bh=PoRu+CAUg3VBGh79YA9R6PzT7K6KJSWvOcZiEPGVbg4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hwdvwbkgODALuKqNxKonrXkN90p2soca7NQhu65Y+1qOx3s0t7h4goIMJ6sOv87Zs
         azNOOjusDsVEUvUV5Vvw40ZO5EJzRsC8RlDtREHOkZJhXAwTIGTsEIR1HIFSPnAIOk
         qL5+ObCrLt/0YPTqhoHjMkCZoAl340mJ7WJfIArRSH8I3mi7i5hcFE9bVMjSijyCPn
         5/FueRobVSj11GcqGxjTold3u/G8ijrMA0jzwS+zkZNk8Du6fFun2uhcMAQxbMMQzr
         lyQgpg6bzBL875p8o0UhYDkO0Bj/Of9pdxbif59psmtrbLCVjnA7EOZTfPmUDHKgiU
         znPksNp8TNIbA==
Received: by mail-ot1-f42.google.com with SMTP id x10-20020a056830408a00b004f26cead745so1807713ott.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 00:45:35 -0700 (PDT)
X-Gm-Message-State: AOAM530rmV2SxipXxOpXm4rwQYsMr8k4ApfZxk/ptfTV19vFNn93GEuS
        PB9EiAbs2JSXZODaKcjhx8s7aDztZmPIWIWuVZQ=
X-Google-Smtp-Source: ABdhPJyOB6Ole19/mwc56/w3p7NNTf7L8aSx0sEgGjXiC1beNoWvMENfg8b+dzFoh7My+WOm51sTIvD4nhu65WLM/N4=
X-Received: by 2002:a9d:12e2:: with SMTP id g89mr2050992otg.112.1631087135031;
 Wed, 08 Sep 2021 00:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210904060908.1310204-1-keithp@keithp.com> <20210907220038.91021-1-keithpac@amazon.com>
 <20210907220038.91021-5-keithpac@amazon.com>
In-Reply-To: <20210907220038.91021-5-keithpac@amazon.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Sep 2021 09:45:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE6woRq1Z1BDN3qKgXPyJkrePMgUmQHnFo1CMs-NyYt9A@mail.gmail.com>
Message-ID: <CAMj1kXE6woRq1Z1BDN3qKgXPyJkrePMgUmQHnFo1CMs-NyYt9A@mail.gmail.com>
Subject: Re: [PATCH 4/7] ARM: Use hack from powerpc to get current cpu number
To:     Keith Packard <keithpac@amazon.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Russell King <linux@armlinux.org.uk>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sept 2021 at 00:00, Keith Packard <keithpac@amazon.com> wrote:
>
> When we enable THREAD_INFO_IN_TASK, the cpu number will disappear from
> thread_info and reappear in task_struct. As we cannot include
> linux/sched.h in asm/smp.h, there's no way to use that struct type in
> the raw_smp_processor_id macro. Instead, a hack from the powerpc code
> is used. This pulls the TI_CPU offset out of asm-offsets.h and uses
> that to find the cpu value.
>
> Signed-off-by: Keith Packard <keithpac@amazon.com>
> ---
>  arch/arm/Makefile          |  8 ++++++++
>  arch/arm/include/asm/smp.h | 18 +++++++++++++++++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 415c3514573a..6752995d2914 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -284,6 +284,14 @@ stack_protector_prepare: prepare0
>         $(eval GCC_PLUGINS_CFLAGS += $(SSP_PLUGIN_CFLAGS))
>  endif
>
> +ifdef CONFIG_SMP
> +prepare: task_cpu_prepare
> +
> +PHONY += task_cpu_prepare
> +task_cpu_prepare: prepare0
> +       $(eval KBUILD_CFLAGS += -D_TI_CPU=$(shell awk '{if ($$2 == "TI_CPU") print $$3;}' include/generated/asm-offsets.h))
> +endif
> +
>  all:   $(notdir $(KBUILD_IMAGE))
>
>
> diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
> index d43b64635d77..f77ba3753bc4 100644
> --- a/arch/arm/include/asm/smp.h
> +++ b/arch/arm/include/asm/smp.h
> @@ -15,7 +15,23 @@
>  # error "<asm/smp.h> included in non-SMP build"
>  #endif
>
> -#define raw_smp_processor_id() (current_thread_info()->cpu)
> +/*
> + * This is particularly ugly: it appears we can't actually get the
> + * definition of task_struct here, but we need access to the CPU this
> + * task is running on, which is stored in task_struct when
> + * THREAD_INFO_IN_TASK is set.  Instead of using task_struct we're
> + * using TI_CPU which is extracted from asm-offsets.h by kbuild to get
> + * the current processor ID.
> + *
> + * This also needs to be safeguarded when building asm-offsets.s
> + * because at that time TI_CPU is not defined yet.
> + */
> +#ifndef _TI_CPU
> +#define raw_smp_processor_id()         (0)
> +#else
> +#define raw_smp_processor_id() \
> +       (*(unsigned int *)((void *)current_thread_info() + _TI_CPU))
> +#endif
>
>  struct seq_file;
>

As I stated before, I would really like to avoid using this hack - I
don't think we need to.
