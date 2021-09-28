Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765FE41AD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbhI1Krk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbhI1Kri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:47:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3ACC061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:45:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v127so3085954wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pMkBoBL/2u2hxj5OV4tpOntSstW0kYsraUoSIB/HZzM=;
        b=mbVshFaEww29h7aEmVf9HpLxzvNaZp8olijYpB6eBQhNUqD6W2WouWSzZkFvbHIhu8
         lOqvFHF93aQ7gVEwhMK66slUwrjFHvKlm84BBDg87CKbAfRowUVfSXMDoXAqUWi42i5q
         NU7awEQdq4PHqqQZkXtnektMYFh53uN0eWBbC/5hdGwp0w4L5bL0U+YCJbjQc1UlG1L6
         4CqrZuYDGlxUnNlCPhPB0E7/ur23XYgj42JSOGCpYRprfTUZIJwZ5n8OWRhdUhPsBtp2
         rj6haqHIYp2kNIZAvIrKk374JQIL4tpamA6wmKk7xq5NwNNbxUPCzr7aTavI4I+5P/GO
         vlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pMkBoBL/2u2hxj5OV4tpOntSstW0kYsraUoSIB/HZzM=;
        b=MjMgI9bRee7tS9Rnn09Wzj4pyHgT78vkRiPOw94asR/cPPa4uGUBW89ivwJXHnfCpf
         aW6IL5sS6eZ1Ag0cN9hJ21qWO4UR4SpQ4f+poz7iI0e/qNv+ZofwJPc+dRzOUcaNq0kq
         S4KQqUUjvk1mie6YLqs5jh7A5CyhkfyJbQ6gYlxmSnOte2sFbBhN7qmN/lH5shOLYwWX
         YMtAr6RSuQODvyd5966VVYrIbWOfzQhmd33RVqfScGz0/yloe4eTBbhhVuHwyWAEtSTl
         uPhCPtaGQvP4Cy28mYemwbG56Jbb4LGa++K2e7rEPPljul+rtAdWLYlN4SdwyUhnC1j1
         hvlQ==
X-Gm-Message-State: AOAM530QSmxCpzk2OIxuv4iUeXVnVpnhg7jz1eTvwvOPx+UIFAs7XL41
        28gfueB3FUoncIj1kXiBDbu7Vw==
X-Google-Smtp-Source: ABdhPJxCiCIrJ4P2i364s2mImazMHWq9MdtaswRYwBJ7Zsj9nHMmrkzH/a9pwLFblIWArlO2+gvOHA==
X-Received: by 2002:a05:600c:2206:: with SMTP id z6mr3911093wml.133.1632825957432;
        Tue, 28 Sep 2021 03:45:57 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id z17sm19327249wrr.49.2021.09.28.03.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 03:45:56 -0700 (PDT)
Date:   Tue, 28 Sep 2021 11:45:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, maz@kernel.org,
        tglx@linutronix.de, jbrunet@baylibre.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] irqchip: irq-meson-gpio: make it possible to build
 as a module
Message-ID: <YVLyY7ETBlhexv+9@google.com>
References: <20210902134914.176986-1-narmstrong@baylibre.com>
 <20210902134914.176986-2-narmstrong@baylibre.com>
 <CAGETcx9KYWmmSYjXGPW6awmVYcKr6sdmxhc_tP=hf149=8Pm6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx9KYWmmSYjXGPW6awmVYcKr6sdmxhc_tP=hf149=8Pm6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Sep 2021, Saravana Kannan wrote:

> On Thu, Sep 2, 2021 at 6:49 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > In order to reduce the kernel Image size on multi-platform distributions,
> > make it possible to build the Amlogic GPIO IRQ controller as a module
> > by switching it to a platform driver.
> >
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> >  drivers/irqchip/Kconfig          |  5 +++--
> >  drivers/irqchip/irq-meson-gpio.c | 15 +++++++++------
> >  2 files changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 4d5924e9f766..2aba485025fd 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -400,8 +400,9 @@ config IRQ_UNIPHIER_AIDET
> >           Support for the UniPhier AIDET (ARM Interrupt Detector).
> >
> >  config MESON_IRQ_GPIO
> > -       bool "Meson GPIO Interrupt Multiplexer"
> > -       depends on ARCH_MESON
> > +       tristate "Meson GPIO Interrupt Multiplexer"
> > +       depends on ARCH_MESON || COMPILE_TEST
> > +       default ARCH_MESON
> >         select IRQ_DOMAIN_HIERARCHY
> >         help
> >           Support Meson SoC Family GPIO Interrupt Multiplexer
> > diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
> > index e50676ce2ec8..d90ff0b92480 100644
> > --- a/drivers/irqchip/irq-meson-gpio.c
> > +++ b/drivers/irqchip/irq-meson-gpio.c
> > @@ -436,8 +436,7 @@ static const struct irq_domain_ops meson_gpio_irq_domain_ops = {
> >         .translate      = meson_gpio_irq_domain_translate,
> >  };
> >
> > -static int __init meson_gpio_irq_parse_dt(struct device_node *node,
> > -                                         struct meson_gpio_irq_controller *ctl)
> > +static int meson_gpio_irq_parse_dt(struct device_node *node, struct meson_gpio_irq_controller *ctl)
> >  {
> >         const struct of_device_id *match;
> >         int ret;
> > @@ -463,8 +462,7 @@ static int __init meson_gpio_irq_parse_dt(struct device_node *node,
> >         return 0;
> >  }
> >
> > -static int __init meson_gpio_irq_of_init(struct device_node *node,
> > -                                        struct device_node *parent)
> > +static int meson_gpio_irq_of_init(struct device_node *node, struct device_node *parent)
> >  {
> >         struct irq_domain *domain, *parent_domain;
> >         struct meson_gpio_irq_controller *ctl;
> > @@ -521,5 +519,10 @@ static int __init meson_gpio_irq_of_init(struct device_node *node,
> >         return ret;
> >  }
> >
> > -IRQCHIP_DECLARE(meson_gpio_intc, "amlogic,meson-gpio-intc",
> > -               meson_gpio_irq_of_init);
> > +IRQCHIP_PLATFORM_DRIVER_BEGIN(meson_gpio_intc)
> > +IRQCHIP_MATCH("amlogic,meson-gpio-intc", meson_gpio_irq_of_init)
> > +IRQCHIP_PLATFORM_DRIVER_END(meson_gpio_intc)
> > +
> > +MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:meson-gpio-intc");
> > --
> 
> Acked-by: Saravana Kannan <saravanak@google.com>
> 
> Marc, my mdio-mux patches have landed.

Reviewed-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
