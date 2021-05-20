Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B889638B5BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhETSFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233351AbhETSFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:05:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFC6C6100A
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 18:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621533870;
        bh=VQwp4XJLOY8NbEJ2c96jI+zDjuoFguc3td2LgXxVTvo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MFFsRMD/5TJnCqUKZ4pnq2uz7YHPN1clRmQ8RA2xxF9nA5uEYVfky4nQMglyVQ75O
         70D3N+3uHl9mELxNIX3G4/aUGUAUTIsfmNMLtrHKH6Dut4fhhN0iwNSzCzAoPrHxOR
         hEt3bQvS/GwUE3QXJH7vWU7/9feUucSXvy0XrLQsB4wd8b5tQtxAPsAGU8xxPAl7+r
         vUMdNZ9fCd1QHy7IoYkGkxxd7w4G4LW49PHYW4+MP/HQd+bb3mfslXKUC/FXWVOUtH
         0ClANE9J6t12lterT3bhx3CPYLao/7O4RCP/ZyYxaNmK7V0UhQLW9EYCO83i2+c0zh
         lIlFVNawUCQwg==
Received: by mail-ed1-f45.google.com with SMTP id b17so20490824ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 11:04:30 -0700 (PDT)
X-Gm-Message-State: AOAM533BKotuM/HA0KTq0igaNvfcghTs7EGEQUGPwGQXPvQL4ezTomV9
        PKlzJlyyM+xFEorrr5dblcR3ey2q3lIoW4wEww==
X-Google-Smtp-Source: ABdhPJyg46HfyNml8JnUNhE2Dk7TTa9xNEt/Bo8IgrXmIz+8P4+WSt6KtYmdrtHtGrjwSKwdH4zNHfQ9kcQPrfoWn4s=
X-Received: by 2002:a05:6402:c7:: with SMTP id i7mr6481075edu.194.1621533869303;
 Thu, 20 May 2021 11:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210520163751.27325-1-maz@kernel.org> <20210520163751.27325-35-maz@kernel.org>
In-Reply-To: <20210520163751.27325-35-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 May 2021 13:04:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ2onUWecftfOrZZAZgegJzwC2_UT_gRcV88L5A9R9Ddg@mail.gmail.com>
Message-ID: <CAL_JsqJ2onUWecftfOrZZAZgegJzwC2_UT_gRcV88L5A9R9Ddg@mail.gmail.com>
Subject: Re: [PATCH 34/39] ARM: Bulk conversion to generic_handle_domain_irq()
To:     Marc Zyngier <maz@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 11:58 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Wherever possible, replace constructs that match either
> generic_handle_irq(irq_find_mapping()) or
> generic_handle_irq(irq_linear_revmap()) to a single call to
> generic_handle_domain_irq().
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm/mach-pxa/pxa_cplds_irqs.c | 6 ++----
>  arch/arm/mach-s3c/irq-s3c24xx.c    | 5 ++---
>  2 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds_irqs.c
> index ec0d9b094744..ce1bbabbad54 100644
> --- a/arch/arm/mach-pxa/pxa_cplds_irqs.c
> +++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c
> @@ -39,10 +39,8 @@ static irqreturn_t cplds_irq_handler(int in_irq, void *d)
>
>         do {
>                 pending = readl(fpga->base + FPGA_IRQ_SET_CLR) & fpga->irq_mask;
> -               for_each_set_bit(bit, &pending, CPLDS_NB_IRQ) {
> -                       generic_handle_irq(irq_find_mapping(fpga->irqdomain,
> -                                                           bit));
> -               }
> +               for_each_set_bit(bit, &pending, CPLDS_NB_IRQ)
> +                       generic_handle_domain_irq(fpga->irqdomain, bit);

We see this pattern a bit, I'm wondering if we can come up with a
common helper. For an even longer name, something like:

generic_handle_domain_irq_for_bitmap(fpga->irqdomain, &pending, CPLDS_NB_IRQ);

Rob
