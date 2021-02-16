Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CCC31CE83
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhBPQ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhBPQzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:55:52 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EB2C061574;
        Tue, 16 Feb 2021 08:55:11 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id u143so6489704pfc.7;
        Tue, 16 Feb 2021 08:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/H6LiWn0A6b/8ios9SP8cUE1Sv4bQ5yNhbgbGBgv2c=;
        b=bvku63Vnc7mFQXtlbolu8qNCzN2Z7r6KeIfAuYHevo6xfVjCjYxHX1hbWi2iSLSA1s
         sqL274JEeloGKCO4Omp1Ge8EKcj8eK5+L+a1z6ibRMvsYcjBQpPrrBJCBU9ch5lISf4s
         TM+mtMHslwl+d2UdMoYG54/tt/kbSIvoo4OmRRZ9RlREhx9u28LFDVJa31yyWtRrWkuv
         L/oz/6sGLwf3jw8ifepSpKzqtdRLNNSCVEliZ6IrFE9nf5b0E8EeGDgqNpgZ3KTEeWfO
         i48OB7t5m6eT+jnHXTDSHOdn4S400TWznWwvWkdLWv8WT/VwU4Z8vXahAPkA1WaCH6gu
         O3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/H6LiWn0A6b/8ios9SP8cUE1Sv4bQ5yNhbgbGBgv2c=;
        b=eQyDqAWjDiP/WxpSaMOateagPzFEG/6pYLroQ/bJqB57k8LnFiQqE8Ap46EmrxdYgv
         7iiywnmmBk3QRgIl3LuUoZ1cuSYap1AlAaY78H42sJ59DqhFK9Sb2ffEQg3cBB83Pa21
         NFBbqY+nvHA6pbb19mwoUpUMuo5pxsnE9Kn8nB7K7Ry4v550f7c+cf3SbWc3ocu1Oyyp
         Y85IeGs+FzpHA9QIPObkMIwcwkaIUps7eaged9Trv5P3YzvpiV+Zs4fKhV6WGeljLzU+
         nWqphFC1pWVoDqKDVbfUF/3vtynmklMcWpamtOU06m62nFm23OlNCuqHOzcqIkj1opek
         lHuA==
X-Gm-Message-State: AOAM532GZVrtGnPkSOQmls9zHFaJZjLGZwuw4uO4zWW9DFN2qIhddhIF
        Weakxk7JB9wukegxQHnX/ufxLWRcsdGKuhkcAmI=
X-Google-Smtp-Source: ABdhPJxh1nK6gvBMYME2JhZZPEgzFDpvr46SKAtmAYdZiFSXjHLnKprPgueiEnwfl/mD44LmOatwmlRw1Bl8zJOos6k=
X-Received: by 2002:a63:3d0:: with SMTP id 199mr20202328pgd.4.1613494511176;
 Tue, 16 Feb 2021 08:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com> <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com>
In-Reply-To: <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Feb 2021 18:54:54 +0200
Message-ID: <CAHp75Vep0Fm1k_7gJcozk4t316QmUgt5Qe3PauwDg=py5VnHfQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] gna: add driver module
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 6:11 PM Maciej Kwapulinski
<maciej.kwapulinski@linux.intel.com> wrote:
>
> From: Tomasz Jankowski <tomasz1.jankowski@intel.com>
>
> Add a new PCI driver for Intel(R) Gaussian & Neural Accelerator
> with basic support like module loading and unloading. The full
> function of the driver will be added by further changes.

...

> +config INTEL_GNA
> +       tristate "Intel(R) Gaussian & Neural Accelerator (Intel(R) GNA)"

Intel (R) Intel (R) RRR!

> +       depends on X86_64 && PCI
> +       help
> +         This option enables the Intel(R) Gaussian & Neural Accelerator
> +         (Intel(R) GNA) driver.
> +         User space interface is defined in include/uapi/misc/gna.h, while
> +         information about functionality is in
> +         Documentation/misc-devices/gna.rst

No module name?

...

> +/* Reverse gna_dev_init() */
> +static void gna_dev_deinit(struct gna_private *gna_priv)
> +{
> +       pci_set_drvdata(gna_priv->pdev, NULL);
> +}

This is done by device core. Why do you need it?

...

> +       ret = pcim_enable_device(pcidev);
> +       if (ret) {
> +               dev_err(&pcidev->dev, "pci device can't be enabled\n");


> +               goto end;

Useless label. Return here.

> +       }

...

> +       ret = pci_request_regions(pcidev, GNA_DRV_NAME);
> +       if (ret)
> +               goto end;

Why? Can't you use pcim_iomap_regions() directly?

...

> +       ret = pci_set_dma_mask(pcidev, DMA_BIT_MASK(64));

No way. This is an obsoleted API.

> +       if (ret) {
> +               dev_err(&pcidev->dev, "pci_set_dma_mask returned error %d\n", ret);
> +               goto err_release_regions;
> +       }

...

> +       /* init gna device */

Useless comments here and there.

...

> +       gna_priv = devm_kzalloc(&pcidev->dev, sizeof(*gna_priv), GFP_KERNEL);
> +       if (!gna_priv) {
> +               ret = -ENOMEM;

> +               goto err_clear_master;

What? You have used pciM_enabled_device(). Please, read documentation.

> +       }

...

> +       gna_priv->bar0.iostart = pci_resource_start(pcidev, 0);
> +       gna_priv->bar0.iosize = pci_resource_len(pcidev, 0);
> +       gna_priv->bar0.mem_addr = pcim_iomap(pcidev, 0, 0);
> +       if (!gna_priv->bar0.mem_addr) {
> +               dev_err(&pcidev->dev, "could not map BAR 0\n");
> +               ret = -EINVAL;
> +               goto err_clear_master;
> +       }

Why do you need all these?!

...

> +       dev_dbg(&pcidev->dev, "bar0 io start: 0x%llx\n", (unsigned long long)gna_priv->bar0.iostart);
> +       dev_dbg(&pcidev->dev, "bar0 io size: %llu\n", (unsigned long long)gna_priv->bar0.iosize);
> +       dev_dbg(&pcidev->dev, "bar0 memory address: %p\n", gna_priv->bar0.mem_addr);

No, please read printk-formats.rst.

...

> +err_clear_master:
> +       pci_clear_master(pcidev);
> +err_release_regions:
> +       pci_release_regions(pcidev);
> +end:
> +       dev_err(&pcidev->dev, "gna probe failed with %d\n", ret);
> +       return ret;

These are all completely redundant.

> +}

...

> +void gna_remove(struct pci_dev *pcidev)
> +{
> +       struct gna_private *gna_priv;
> +
> +       gna_priv = pci_get_drvdata(pcidev);
> +
> +       gna_dev_deinit(gna_priv);
> +
> +       pci_clear_master(pcidev);
> +       pci_release_regions(pcidev);
> +}

Redundant entire function.

...

> +#include <linux/pci.h>

Haven't noticed how this header is used here.

...

> +       struct device dev;

Missed linux/device.h.

...

> +static int __init gna_drv_init(void)
> +{
> +       int ret;
> +
> +       mutex_init(&gna_drv_priv.lock);
> +
> +       gna_class = class_create(THIS_MODULE, "gna");
> +       if (IS_ERR(gna_class)) {
> +               pr_err("class device create failed\n");
> +               return PTR_ERR(gna_class);
> +       }
> +       gna_class->devnode = gna_devnode;
> +
> +       ret = pci_register_driver(&gna_driver);

Is it possible to decouple a PCI glue driver from the class as many
other existing examples are doing?

> +       if (ret) {
> +               pr_err("pci register driver failed\n");
> +               class_destroy(gna_class);
> +               return ret;
> +       }
> +
> +       return 0;
> +}

...

> +#include <linux/kernel.h>

Why do you need this header?

...

> +#define GNA_DRV_VER    "1.2.0"

Nowadays the version is the Git SHA sum.

...

> +       struct file *fd;

Missed forward declaration.

...

> +       struct list_head memory_list;

Missed linux/list.h

> +       struct list_head flist;

...

> +extern struct gna_driver_private gna_drv_priv;

> +extern int recovery_timeout;

Global?!

...

> +#define GNA_STS_SCORE_COMPLETED                (1 << 0)
> +#define GNA_STS_STATISTICS_VALID       (1 << 3)
> +#define GNA_STS_PCI_MMU_ERR            (1 << 4)
> +#define GNA_STS_PCI_DMA_ERR            (1 << 5)
> +#define GNA_STS_PCI_UNEXCOMPL_ERR      (1 << 6)
> +#define GNA_STS_VA_OOR                 (1 << 7)
> +#define GNA_STS_PARAM_OOR              (1 << 8)
> +#define GNA_STS_OUTBUF_FULL            (1 << 16)
> +#define GNA_STS_SATURATE               (1 << 17)

You can use _BITUL() from const.h, but it's up to you.

...

> +#define GNA_ERROR (GNA_STS_PCI_DMA_ERR                 | \

When definitions start on the next line it will be easier to read.

> +                       GNA_STS_PCI_MMU_ERR             | \
> +                       GNA_STS_PCI_UNEXCOMPL_ERR       | \
> +                       GNA_STS_PARAM_OOR               | \
> +                       GNA_STS_VA_OOR)

-- 
With Best Regards,
Andy Shevchenko
