Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9283F6A35
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 22:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhHXUGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 16:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhHXUGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 16:06:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAA35613A7;
        Tue, 24 Aug 2021 20:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629835536;
        bh=VKqDPcr/CV0TdWqn2OdiAByy9r5jf6KX6ZEZ8hc0U78=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CFSBHFcYtjUPrzR8O1hi3aOhfjYpD9tpXUmWGHbyxLx45vUFit5OD8GF2FCzUFtfW
         jtglbcaqy5JdGyrqU+Y6NQiOOOb2DHhpFsYUBTg1/IsO4HemEJ3A2WsxMvggD1heOf
         PJ1rf1hJc3hZp60CBvMM2cuwI2lnl63X1ttsXEaC49Jv1iLRxjWpqAlBF3vC/Wq05g
         qdpubMdcAluv8oCjxtioLd8die4Howi25tAhEZbqd6SwBk7dKlRMV+1uYdeE5rogcN
         r3iQgOzO3kxii3hWbvLrIDwvEt/3JhWC/DKK9QhGpwsYh8vbhVFxd6aKIYp+2PFcFn
         qFIPizYNuCR1g==
Received: by mail-ej1-f52.google.com with SMTP id mf2so28200045ejb.9;
        Tue, 24 Aug 2021 13:05:36 -0700 (PDT)
X-Gm-Message-State: AOAM531Kp3RMJ8CP19U3odq04u2lV0ulRN2J3W4zRU4BXSP430jm+OSQ
        sJWdGScMiA3PRmuCbhXGrypVIqp+wlI59qkpBA==
X-Google-Smtp-Source: ABdhPJxMLQS4U/vsHq8I4WPeek4fhUaumRYpCWq84+36jDRfAvsTZcvO01ujtsR6km04OTuSpzDe3mQjCdMfK5AeY4k=
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr41523122ejb.108.1629835535296;
 Tue, 24 Aug 2021 13:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210816074619.177383-1-wangkefeng.wang@huawei.com> <20210816074619.177383-4-wangkefeng.wang@huawei.com>
In-Reply-To: <20210816074619.177383-4-wangkefeng.wang@huawei.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 24 Aug 2021 15:05:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLBddXVeP-t++wqPNp=xYF7tvEcnCbjFnK9CUBLK2+9JA@mail.gmail.com>
Message-ID: <CAL_JsqLBddXVeP-t++wqPNp=xYF7tvEcnCbjFnK9CUBLK2+9JA@mail.gmail.com>
Subject: Re: [PATCH 3/3] amba: Properly handle device probe without IRQ domain
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ruizhe Lin <linruizhe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Saravana

Saravana mentioned to me there may be some issues with this one...


On Mon, Aug 16, 2021 at 2:43 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> of_amba_device_create() uses irq_of_parse_and_map() to translate
> a DT interrupt specification into a Linux virtual interrupt number.
>
> But it doesn't properly handle the case where the interrupt controller
> is not yet available, eg, when pl011 interrupt is connected to MBIGEN
> interrupt controller, because the mbigen initialization is too late,
> which will lead to no IRQ due to no IRQ domain found, log is shown below,
>   "irq: no irq domain found for uart0 !"
>
> use of_irq_get() to return -EPROBE_DEFER as above, and in the function
> amba_device_try_add()/amba_device_add(), it will properly handle in such
> case, also return 0 in other fail cases to be consistent as before.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Reported-by: Ruizhe Lin <linruizhe@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/amba/bus.c    | 27 +++++++++++++++++++++++++++
>  drivers/of/platform.c |  6 +-----
>  2 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 36f2f42c8014..720aa6cdd402 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -19,6 +19,7 @@
>  #include <linux/clk/clk-conf.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
> +#include <linux/of_irq.h>
>
>  #include <asm/irq.h>
>
> @@ -371,12 +372,38 @@ static void amba_device_release(struct device *dev)
>         kfree(d);
>  }
>
> +static int of_amba_device_decode_irq(struct amba_device *dev)
> +{
> +       struct device_node *node = dev->dev.of_node;
> +       int i, irq = 0;
> +
> +       if (IS_ENABLED(CONFIG_OF_IRQ) && node) {
> +               /* Decode the IRQs and address ranges */
> +               for (i = 0; i < AMBA_NR_IRQS; i++) {
> +                       irq = of_irq_get(node, i);
> +                       if (irq < 0) {
> +                               if (irq == -EPROBE_DEFER)
> +                                       return irq;
> +                               irq = 0;
> +                       }
> +
> +                       dev->irq[i] = irq;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>  {
>         u32 size;
>         void __iomem *tmp;
>         int i, ret;
>
> +       ret = of_amba_device_decode_irq(dev);
> +       if (ret)
> +               goto err_out;
> +
>         ret = request_resource(parent, &dev->res);
>         if (ret)
>                 goto err_out;
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 74afbb7a4f5e..32d5ff8df747 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -222,7 +222,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>  {
>         struct amba_device *dev;
>         const void *prop;
> -       int i, ret;
> +       int ret;
>
>         pr_debug("Creating amba device %pOF\n", node);
>
> @@ -253,10 +253,6 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>         if (prop)
>                 dev->periphid = of_read_ulong(prop, 1);
>
> -       /* Decode the IRQs and address ranges */
> -       for (i = 0; i < AMBA_NR_IRQS; i++)
> -               dev->irq[i] = irq_of_parse_and_map(node, i);
> -
>         ret = of_address_to_resource(node, 0, &dev->res);
>         if (ret) {
>                 pr_err("amba: of_address_to_resource() failed (%d) for %pOF\n",
> --
> 2.26.2
>
