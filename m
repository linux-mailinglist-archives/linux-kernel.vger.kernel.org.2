Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F65B3C93D5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhGNWcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:32:46 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:46598 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhGNWcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:32:45 -0400
Received: by mail-qk1-f176.google.com with SMTP id 201so3254864qkj.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lsctwH0XgpYOHYMIUUkD/PxnFZz1dTw3T5m+9J+nUZo=;
        b=XzUGkaG2cVYAX5d6tzt2+JkZWz+gR1uXlir+cOLTczod9+1CZAK5IHJ44CTDI70ZfH
         9c+BbVRMmmTmBeF5oIdcQgYTO2ndtunfG+pC4WvY+azNoAiGUMV/DPjV+PhYipEnPWN2
         KEOQmpWcccCzYdW+hXVqOd86SE1wBCfhQYSIqJm8AvrzRKjY0zlVsCEImJs1rvvw7QHm
         OyMwKUQz/us3tHaBJzVWq64BgQqIhb/odL+4VitxiN4Pu4GACSsoP1Xn4JE6w7g4qQlN
         ZTz1jtZ7RrsEQfyUq4l0U5x+WMPF5Awpt0b7wIro7Q5W6sBKhXzsSkuhL1V/J8IxQoMg
         MW1w==
X-Gm-Message-State: AOAM530icXwTOLY9LSHAZe6+dBcXtZODXX3mT0Rsucj0wMLNhPkGZxDL
        M9tRcN3+OwJ8R/2g2xlVGYFJz/+/D7DE6w==
X-Google-Smtp-Source: ABdhPJzhNrL4GO8T9iLd+OBadqWPHSg2Hf8yX1ej99t+P+/7FfedKA0OFHLxd1yl4CFmCtPBVCSLvw==
X-Received: by 2002:ae9:e644:: with SMTP id x4mr240478qkl.105.1626301791637;
        Wed, 14 Jul 2021 15:29:51 -0700 (PDT)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id b25sm1634723qka.123.2021.07.14.15.29.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 15:29:51 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id 77so3253721qkk.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:29:50 -0700 (PDT)
X-Received: by 2002:a37:a58f:: with SMTP id o137mr218663qke.451.1626301790102;
 Wed, 14 Jul 2021 15:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210705111250.1513634-1-fido_max@inbox.ru>
In-Reply-To: <20210705111250.1513634-1-fido_max@inbox.ru>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 14 Jul 2021 17:29:38 -0500
X-Gmail-Original-Message-ID: <CADRPPNRYDBFHEppfpYLwsy7MMEdtsOLS764MJboL9ERW0-KK3Q@mail.gmail.com>
Message-ID: <CADRPPNRYDBFHEppfpYLwsy7MMEdtsOLS764MJboL9ERW0-KK3Q@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: convert QE interrupt controller to platform_device
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, saravanak@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Zhao Qiang <qiang.zhao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 6:12 AM Maxim Kochetkov <fido_max@inbox.ru> wrote:
>
> Since 5.13 QE's ucc nodes can't get interrupts from devicetree:
>
>         ucc@2000 {
>                 cell-index = <1>;
>                 reg = <0x2000 0x200>;
>                 interrupts = <32>;
>                 interrupt-parent = <&qeic>;
>         };
>
> Now fw_devlink expects driver to create and probe a struct device
> for interrupt controller.
>
> So lets convert this driver to simple platform_device with probe().
>
> [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com
> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> Fixes: ea718c699055 ("Revert "Revert "driver core: Set fw_devlink=on by default""")
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---
>  drivers/soc/fsl/qe/qe_ic.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
> index 3f711c1a0996..03d291376895 100644
> --- a/drivers/soc/fsl/qe/qe_ic.c
> +++ b/drivers/soc/fsl/qe/qe_ic.c
> @@ -23,6 +23,7 @@
>  #include <linux/signal.h>
>  #include <linux/device.h>
>  #include <linux/spinlock.h>
> +#include <linux/platform_device.h>
>  #include <asm/irq.h>
>  #include <asm/io.h>
>  #include <soc/fsl/qe/qe.h>
> @@ -404,27 +405,28 @@ static void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
>         chip->irq_eoi(&desc->irq_data);
>  }
>
> -static void __init qe_ic_init(struct device_node *node)
> +static int qe_ic_init(struct platform_device *pdev)
>  {
>         void (*low_handler)(struct irq_desc *desc);
>         void (*high_handler)(struct irq_desc *desc);
>         struct qe_ic *qe_ic;
>         struct resource res;
> +       struct device_node *node = pdev->dev.of_node;
>         u32 ret;
>
>         ret = of_address_to_resource(node, 0, &res);
>         if (ret)
> -               return;
> +               return -ENODEV;
>
>         qe_ic = kzalloc(sizeof(*qe_ic), GFP_KERNEL);
>         if (qe_ic == NULL)
> -               return;
> +               return -ENOMEM;
>
>         qe_ic->irqhost = irq_domain_add_linear(node, NR_QE_IC_INTS,
>                                                &qe_ic_host_ops, qe_ic);
>         if (qe_ic->irqhost == NULL) {
>                 kfree(qe_ic);
> -               return;
> +               return -ENODEV;
>         }
>
>         qe_ic->regs = ioremap(res.start, resource_size(&res));
> @@ -437,7 +439,7 @@ static void __init qe_ic_init(struct device_node *node)
>         if (!qe_ic->virq_low) {
>                 printk(KERN_ERR "Failed to map QE_IC low IRQ\n");
>                 kfree(qe_ic);
> -               return;
> +               return -ENODEV;
>         }
>         if (qe_ic->virq_high != qe_ic->virq_low) {
>                 low_handler = qe_ic_cascade_low;
> @@ -456,20 +458,26 @@ static void __init qe_ic_init(struct device_node *node)
>                 irq_set_handler_data(qe_ic->virq_high, qe_ic);
>                 irq_set_chained_handler(qe_ic->virq_high, high_handler);
>         }
> +       return 0;
>  }
> +static const struct of_device_id qe_ic_ids[] = {
> +       { .compatible = "fsl,qe-ic"},
> +       { .compatible = "qeic"},

From the original code, this should be type = "qeic".  It is not
defined in current binding but probably needed for backward
compatibility.

It would be great if you can also deal with the comments from Dan too.  Thanks.

> +       {},
> +};
>
> -static int __init qe_ic_of_init(void)
> +static struct platform_driver qe_ic_driver =
>  {
> -       struct device_node *np;
> +       .driver = {
> +               .name           = "qe-ic",
> +               .of_match_table = qe_ic_ids,
> +       },
> +       .probe  = qe_ic_init,
> +};
>
> -       np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> -       if (!np) {
> -               np = of_find_node_by_type(NULL, "qeic");
> -               if (!np)
> -                       return -ENODEV;
> -       }
> -       qe_ic_init(np);
> -       of_node_put(np);
> +static int __init qe_ic_of_init(void)
> +{
> +       platform_driver_register(&qe_ic_driver);
>         return 0;
>  }
>  subsys_initcall(qe_ic_of_init);
> --
> 2.31.1
>
