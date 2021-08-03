Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811DC3DF429
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 19:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbhHCRwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 13:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhHCRwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:52:21 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2174C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 10:52:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id a93so45311ybi.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 10:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PBgZljFVrSeLABLK0pp/2Hz7HIGjCIFA/IERb9MuqE0=;
        b=GYI09HQT4+g4j0DHoO2j2OmuszyEtutHTYFs/7ctFeCVDvuZAczx/kGe8dBIUNd/rr
         Cm9Mu4jUrpyXlqkS0gCPtckFJ/FEMCmxYqU3ohAHB471UCp7R6FvWk6D55zklnDEDvDd
         V9bV/fHm7RPfVlWB06Lc0GOtkdEi3ONl874d+56nq3kEw7Vv8Mr6SF3el9VeYJgHVLfj
         ylr4kfYaYDQWGpk62Zex/ZyAGA9e6tlwmIRJQlpOb9EAzLLvkD6LHg45i1ZGJ6ZN3A6f
         8uQPI0dC4aJ2TBNCnpDl3nf/Jns9a3jRuHW3u/+Z8GccGq2H92PXvM2AJxzusQBOsuBq
         s4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBgZljFVrSeLABLK0pp/2Hz7HIGjCIFA/IERb9MuqE0=;
        b=NSJTb/i4FKMDFPKhuD2XVnw44uyRzjK4osEOhpo70lrNT9ridOUTf8+jXqSFCG4WA9
         iyp82swqAxZ1w+krg79qrXcoiNPDZJQmNACubAfZm2GS84W3a2KUCapRC6GEtEnSnxxa
         FX01QgCKUXRDtQL5FZlK0UclU/ouIZtToZCAJqlWa+vin69ABsuPZvc0q6wvSRWJcTBz
         uVK623xbwoqpDH1JtsmLqwhsbGzX+uVEUOuqqH5IyRJkWQwDj+esOouCa4LN+4L52bT/
         UEOGioWB/ZIoqyIDurvd9eGloH2awtuYNgoXc13Pwo9Fl92BGpwjuoDCWWM3nUqFtTnv
         X5+A==
X-Gm-Message-State: AOAM530zUeD7cs/i0f+pWF078uloOwt5YrSkKq5xtQ01Kq9ikbqnWlix
        dMtnDdptZLqh/0yj0jOI72EhGqKJsKkK7Kz5M6JFdQ==
X-Google-Smtp-Source: ABdhPJzjgKwOlw/JSZYeLJKFxQJU1P1kFOhTXCVfn2HkPxUGntC/t/KCQXvtOgO+s2Z+ENrSk1g7mWqYdSF9VroZLJ4=
X-Received: by 2002:a25:d450:: with SMTP id m77mr30661363ybf.412.1628013128847;
 Tue, 03 Aug 2021 10:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210803113538.560277-1-fido_max@inbox.ru>
In-Reply-To: <20210803113538.560277-1-fido_max@inbox.ru>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 3 Aug 2021 10:51:32 -0700
Message-ID: <CAGETcx8QC+AMXvmk4RB=LGp00QLVVX4uCeeruAjFnGq_irMh4Q@mail.gmail.com>
Subject: Re: [PATCH v4] soc: fsl: qe: convert QE interrupt controller to platform_device
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, qiang.zhao@nxp.com,
        leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 4:33 AM Maxim Kochetkov <fido_max@inbox.ru> wrote:
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
> Also use platform_get_ and devm_ family function to get/allocate
> resources and drop unused .compatible = "qeic".

Yes, please!

Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana

>
> [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com
> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> Fixes: ea718c699055 ("Revert "Revert "driver core: Set fw_devlink=on by default""")
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/soc/fsl/qe/qe_ic.c | 75 ++++++++++++++++++++++----------------
>  1 file changed, 44 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
> index 3f711c1a0996..e710d554425d 100644
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
> @@ -404,41 +405,40 @@ static void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
>         chip->irq_eoi(&desc->irq_data);
>  }
>
> -static void __init qe_ic_init(struct device_node *node)
> +static int qe_ic_init(struct platform_device *pdev)
>  {
> +       struct device *dev = &pdev->dev;
>         void (*low_handler)(struct irq_desc *desc);
>         void (*high_handler)(struct irq_desc *desc);
>         struct qe_ic *qe_ic;
> -       struct resource res;
> -       u32 ret;
> +       struct resource *res;
> +       struct device_node *node = pdev->dev.of_node;
>
> -       ret = of_address_to_resource(node, 0, &res);
> -       if (ret)
> -               return;
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (res == NULL) {
> +               dev_err(dev, "no memory resource defined\n");
> +               return -ENODEV;
> +       }
>
> -       qe_ic = kzalloc(sizeof(*qe_ic), GFP_KERNEL);
> +       qe_ic = devm_kzalloc(dev, sizeof(*qe_ic), GFP_KERNEL);
>         if (qe_ic == NULL)
> -               return;
> +               return -ENOMEM;
>
> -       qe_ic->irqhost = irq_domain_add_linear(node, NR_QE_IC_INTS,
> -                                              &qe_ic_host_ops, qe_ic);
> -       if (qe_ic->irqhost == NULL) {
> -               kfree(qe_ic);
> -               return;
> +       qe_ic->regs = devm_ioremap(dev, res->start, resource_size(res));
> +       if (qe_ic->regs == NULL) {
> +               dev_err(dev, "failed to ioremap() registers\n");
> +               return -ENODEV;
>         }
>
> -       qe_ic->regs = ioremap(res.start, resource_size(&res));
> -
>         qe_ic->hc_irq = qe_ic_irq_chip;
>
> -       qe_ic->virq_high = irq_of_parse_and_map(node, 0);
> -       qe_ic->virq_low = irq_of_parse_and_map(node, 1);
> +       qe_ic->virq_high = platform_get_irq(pdev, 0);
> +       qe_ic->virq_low = platform_get_irq(pdev, 1);
>
> -       if (!qe_ic->virq_low) {
> -               printk(KERN_ERR "Failed to map QE_IC low IRQ\n");
> -               kfree(qe_ic);
> -               return;
> +       if (qe_ic->virq_low < 0) {
> +               return -ENODEV;
>         }
> +
>         if (qe_ic->virq_high != qe_ic->virq_low) {
>                 low_handler = qe_ic_cascade_low;
>                 high_handler = qe_ic_cascade_high;
> @@ -447,6 +447,13 @@ static void __init qe_ic_init(struct device_node *node)
>                 high_handler = NULL;
>         }
>
> +       qe_ic->irqhost = irq_domain_add_linear(node, NR_QE_IC_INTS,
> +                                              &qe_ic_host_ops, qe_ic);
> +       if (qe_ic->irqhost == NULL) {
> +               dev_err(dev, "failed to add irq domain\n");
> +               return -ENODEV;
> +       }
> +
>         qe_ic_write(qe_ic->regs, QEIC_CICR, 0);
>
>         irq_set_handler_data(qe_ic->virq_low, qe_ic);
> @@ -456,20 +463,26 @@ static void __init qe_ic_init(struct device_node *node)
>                 irq_set_handler_data(qe_ic->virq_high, qe_ic);
>                 irq_set_chained_handler(qe_ic->virq_high, high_handler);
>         }
> +       return 0;
>  }
> +static const struct of_device_id qe_ic_ids[] = {
> +       { .compatible = "fsl,qe-ic"},
> +       { .type = "qeic"},
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
