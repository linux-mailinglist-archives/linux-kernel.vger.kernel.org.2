Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53A03FF1FE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346429AbhIBRCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346410AbhIBRCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:02:22 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA5AC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 10:01:21 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id v26so5128612ybd.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpysPmik57x5vnDmjTrZwtUlMx9bD37Da+iZfWbm5qg=;
        b=MjoPmyE65znm1D0n+HXu82MDj+gi8kUK0hXr1O6+Bjv/0XAG2S5ahgwzwBD+Cnu3oO
         mCweJVAtssAovQojoUmS6Ci++Uti7Ht6PYH1jWKKoI5eVjR67tdebUj2PCrXVlmfg8tM
         GyiQeXcN+v9qtEiprBzVjjzZ7yQjO3B3RB0RjTjVFZec+EtnhvmuxQV6HzPf1Ce4rVYk
         Gy9f0zlDrqqWd5K0smV29f3g4eEijuq462wK6TYG45R1D1Ize7UGrVUTJ2rR8JN5ILQ9
         GYAjv/Mfjox9wtbxaEeHdHUz20MaTDkDSEcwV5fAbMdjTM64pRm6mNidTYDDG6UJo3t6
         KbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpysPmik57x5vnDmjTrZwtUlMx9bD37Da+iZfWbm5qg=;
        b=GCNaJHQfkpeR8OA5l03VknbEjK4Di3ziUxxEHWqFX87vCkhoPNR8rTTKhpDOJ4t5MI
         FXPWW0E3EE91xjGHGmRXrNvTiImYsrrQ0pXZALGTC+8pP+WCCC55mDYMmU8e3oS2g9fb
         ANAcC81DoYHJO6rjF7JZLk72t7Gt8Ca4sX1qcrUhV5Zmvl4/vDAB/C5MC5P2gS65qUO0
         I0+IFnSCMUVLhlVsgPnCn12WkGSeRnGkDz6BaGGCu4CrWZ2gCTRGE+vuyVd5UXgF54Nl
         NNnf94OqyYnk2vw3Xes1NNZAIgqqVXEKwoy8JopIIDuuIg1MOWDrPLKbAnyOi01SAI//
         y9TA==
X-Gm-Message-State: AOAM533LfXfd5Hvla/VQ+6yuP52PVyx4n9/ani9lRRAdfFdCsFj6W4Ao
        v2ESpdyqpTll+BNY3j4GbjG8/qKizCxZLo/tzE5Yfg==
X-Google-Smtp-Source: ABdhPJyt8C3Ru+98FAhkc1VPkGvpkiogD6mUaNAdSCekNWLAzApbq4a2RvTAF9sHto1glvhd7SJ6dQ+62d8ugoff0lE=
X-Received: by 2002:a25:6746:: with SMTP id b67mr6335807ybc.96.1630602080287;
 Thu, 02 Sep 2021 10:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210902134914.176986-1-narmstrong@baylibre.com> <20210902134914.176986-2-narmstrong@baylibre.com>
In-Reply-To: <20210902134914.176986-2-narmstrong@baylibre.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 2 Sep 2021 10:00:44 -0700
Message-ID: <CAGETcx9KYWmmSYjXGPW6awmVYcKr6sdmxhc_tP=hf149=8Pm6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip: irq-meson-gpio: make it possible to build as
 a module
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     maz@kernel.org, tglx@linutronix.de, jbrunet@baylibre.com,
        khilman@baylibre.com, lee.jones@linaro.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 6:49 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> In order to reduce the kernel Image size on multi-platform distributions,
> make it possible to build the Amlogic GPIO IRQ controller as a module
> by switching it to a platform driver.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/irqchip/Kconfig          |  5 +++--
>  drivers/irqchip/irq-meson-gpio.c | 15 +++++++++------
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 4d5924e9f766..2aba485025fd 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -400,8 +400,9 @@ config IRQ_UNIPHIER_AIDET
>           Support for the UniPhier AIDET (ARM Interrupt Detector).
>
>  config MESON_IRQ_GPIO
> -       bool "Meson GPIO Interrupt Multiplexer"
> -       depends on ARCH_MESON
> +       tristate "Meson GPIO Interrupt Multiplexer"
> +       depends on ARCH_MESON || COMPILE_TEST
> +       default ARCH_MESON
>         select IRQ_DOMAIN_HIERARCHY
>         help
>           Support Meson SoC Family GPIO Interrupt Multiplexer
> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
> index e50676ce2ec8..d90ff0b92480 100644
> --- a/drivers/irqchip/irq-meson-gpio.c
> +++ b/drivers/irqchip/irq-meson-gpio.c
> @@ -436,8 +436,7 @@ static const struct irq_domain_ops meson_gpio_irq_domain_ops = {
>         .translate      = meson_gpio_irq_domain_translate,
>  };
>
> -static int __init meson_gpio_irq_parse_dt(struct device_node *node,
> -                                         struct meson_gpio_irq_controller *ctl)
> +static int meson_gpio_irq_parse_dt(struct device_node *node, struct meson_gpio_irq_controller *ctl)
>  {
>         const struct of_device_id *match;
>         int ret;
> @@ -463,8 +462,7 @@ static int __init meson_gpio_irq_parse_dt(struct device_node *node,
>         return 0;
>  }
>
> -static int __init meson_gpio_irq_of_init(struct device_node *node,
> -                                        struct device_node *parent)
> +static int meson_gpio_irq_of_init(struct device_node *node, struct device_node *parent)
>  {
>         struct irq_domain *domain, *parent_domain;
>         struct meson_gpio_irq_controller *ctl;
> @@ -521,5 +519,10 @@ static int __init meson_gpio_irq_of_init(struct device_node *node,
>         return ret;
>  }
>
> -IRQCHIP_DECLARE(meson_gpio_intc, "amlogic,meson-gpio-intc",
> -               meson_gpio_irq_of_init);
> +IRQCHIP_PLATFORM_DRIVER_BEGIN(meson_gpio_intc)
> +IRQCHIP_MATCH("amlogic,meson-gpio-intc", meson_gpio_irq_of_init)
> +IRQCHIP_PLATFORM_DRIVER_END(meson_gpio_intc)
> +
> +MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:meson-gpio-intc");
> --

Acked-by: Saravana Kannan <saravanak@google.com>

Marc, my mdio-mux patches have landed.

-Saravana
