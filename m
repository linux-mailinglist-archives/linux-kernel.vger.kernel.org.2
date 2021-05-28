Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B69D394281
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhE1M2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhE1M14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:27:56 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ECBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:26:19 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f22so2408008pgb.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrBzKutf4bWltAdgHdE0FNRVNvTwrM5NIFn3FKqpBD4=;
        b=rgyInGBZDJCPrgmeZvWy3P9aZrFRzHTi5u1KglyuC0LNRWo5sdjVb8RwmQlQrjz8xW
         xebjxpo4ipRg2tLhTofTbipxzEiAY1N+if6fpVCKoeQ+rdyCvtxAahK090fgH2kbkmOy
         WcdPEi4OAo7jDRyWD6tayjqSTZv7joCbwlwb5A28oxVLtu7vsiwO9+RhnsiJpC7q5A3p
         JDlTYSc4RbFCMfMx4Lqc2ySj7JC0DKZ5jiQy/du2dMyvsvTIofLQHQ4lw2gBjgSPItEU
         FtfRTRvj/G4DQa5om6UzkgT+4aTlFTip6UA3Sf4J5hq1rJg3+CJirDGIFq85Y/sXNHo+
         P/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrBzKutf4bWltAdgHdE0FNRVNvTwrM5NIFn3FKqpBD4=;
        b=X70tP6mCMbEesKTRV54z/Qom/nlzIphAhFmp2sg7tM1wnIU8OlcH97hsPQLin+sKTx
         ix0qRfTMMZNoqACo6172r8xE7JYj3UahwtXx3Q9lNnO3pTNU9lcKw1CtiviNO6upgbEv
         pJCIuR6EeoLJE7jeNaa+6oCtPrki5teKY21QKfBhLTzL22K4cLY4anP63MnE4qToflWy
         wMKxLlyzyKQrjPUr3BpKMqnPpU95xSylcC5szBKu75NFbtAlV6dFtpW+CZ8vx4fKn8tP
         +++vhvqmmhOyXWY/BQESPXVBcl3TmYNyVo1LMa8e+QjWjQ0ze/U9mNQ78L0e3obOPLf8
         U/3w==
X-Gm-Message-State: AOAM531E8sCVl5bZljpvWIsj6EpXBfXNDc1cwjglLhN/OKXs6Nt6bMWS
        Rl8SOicqKgSTHNORBovbpR5cK65nr7X4BKHQfuQ=
X-Google-Smtp-Source: ABdhPJz3SMMbqfQB8n7Z8WAV1xrkBwe9LvKm8pQxIiE9u2CjWtlXkcfOND0CHyEJvFGf9Mno7rYrY2rapBkrkXosiJg=
X-Received: by 2002:a63:b507:: with SMTP id y7mr8758638pge.74.1622204778456;
 Fri, 28 May 2021 05:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210528095845.6991-1-saumah@gmail.com>
In-Reply-To: <20210528095845.6991-1-saumah@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 May 2021 15:26:02 +0300
Message-ID: <CAHp75VfpNLaUM5uWceewoQFb4QQ0FYhGCHMMQam=9coCr-Zm9g@mail.gmail.com>
Subject: Re: [PATCH] mfd:Add SUNIX mfd & PCIe driver
To:     Moriis Ku <saumah@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jason_lee@sunix.com, taian.chen@sunix.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 2:44 PM Moriis Ku <saumah@gmail.com> wrote:
>
> From: Morris Ku <saumah@gmail.com>

Not sure why we have it here.

> Add SUNIX mfd & PCIe driver

Needs a bit more information.

> Signed-off-by: Morris Ku <saumah@gmail.com>

...

> + * Based on Intel Sunrisepoint LPSS core driver written by

Looking into the code I'm not sure how it's based on that.

> + * - Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> + * - Mika Westerberg <mika.westerberg@linux.intel.com>
> + * - Heikki Krogerus <heikki.krogerus@linux.intel.com>
> + * - Jarkko Nikula <jarkko.nikula@linux.intel.com>
> + * Copyright (C) 2015, Intel Corporation

...

> +struct cib_config {
> +       unsigned int mem_offset;
> +       unsigned int mem_size;

The above is probably better when they are type of resource_size_t.
If it's something that goes directly to the hardware or from it, use
fixed-width types.

> +       unsigned char ic_brand;
> +       unsigned char ic_model;

u8 ?

> +};
> +
> +struct cib_uart {
> +       unsigned int io_offset;
> +       unsigned char io_size;
> +       unsigned int mem_offset;
> +       unsigned int mem_size;
> +       unsigned short tx_fifo_size;
> +       unsigned short rx_fifo_size;
> +       unsigned int significand;
> +       unsigned char exponent;
> +       unsigned char rs232_cap;
> +       unsigned char rs422_cap;
> +       unsigned char rs485_cap;
> +       unsigned char ahdc_cap;
> +       unsigned char cs_cap;
> +       unsigned char rs422_end_cap;
> +       unsigned char rs485_end_cap;
> +};

As per above

> +struct cib_info {
> +       unsigned char number;
> +       unsigned char type;
> +       unsigned char version;
> +       unsigned char total_length;
> +       unsigned char resource_cap;
> +       unsigned char event_type;
> +
> +       struct cib_config *config;
> +       struct cib_uart *uart;
> +};

As per above.

...

> +       char model_name[18];

Strange size, but okay.

...


> +       offsetDW = 2;
> +       info->config->mem_offset = readl(membase + ptr + (offsetDW * 4));
> +       offsetDW = 3;
> +       info->config->mem_size = readl(membase + ptr + (offsetDW * 4));
> +       offsetDW = 4;
> +       temp = readl(membase + ptr + (offsetDW * 4));

You will benefit if you create the IO accessor helper functions, these
become like

 a = my_ioread(base, ptr, offset);
 b = ...

...

> +       info->config->ic_brand = (unsigned char)((temp & 0x0000ff00) >> 8);
> +       info->config->ic_model = (unsigned char)((temp & 0x00ff0000) >> 16);

Use GENMASK().
Castings are not needed.

> +}

...

> +static void sdc_get_uart_info(struct cib_info *info, void __iomem *membase,
> +                               unsigned short ptr)
> +{

Same as above.

> +       info->uart->rs232_cap = (temp & 0x00000001) ? 0x01 : 0x00;
> +       info->uart->rs422_cap = (temp & 0x00000002) ? 0x01 : 0x00;
> +       info->uart->rs485_cap = (temp & 0x00000004) ? 0x01 : 0x00;
> +       info->uart->ahdc_cap = (temp & 0x00000008) ? 0x01 : 0x00;
> +       info->uart->cs_cap = (temp & 0x00000010) ? 0x01 : 0x00;
> +       info->uart->rs422_end_cap = (temp & 0x00000040) ? 0x01 : 0x00;
> +       info->uart->rs485_end_cap = (temp & 0x00000080) ? 0x01 : 0x00;

It seems you are using char type for boolean variables.
Also consider BIT() to be in use.

> +}

...

> +       root_dir = debugfs_create_dir(dev_name(sdc->dev), sdc_mfd_debugfs);

> +       if (IS_ERR(root_dir))
> +               return PTR_ERR(root_dir);

Nope, we don't check for error codes for debugfs.

...

> +       debugfs_create_u32("device_number", 0644, root_dir,
> +               &sdc->info.device_number);

> +       debugfs_create_u8("minor_version", 0644, root_dir,
> +               &sdc->minor_version);
> +       debugfs_create_u8("available_chls", 0644, root_dir,
> +               &sdc->available_chls);

Above can sit on a single line each.

...

> +       for (i = 0; i < sdc->available_chls; i++) {
> +               chl = &sdc->channels[i];

> +               memset(chl_name, 0, sizeof(char) * 20);

Why?

> +               sprintf(chl_name, "chl%d", i);
> +               chl_dir = debugfs_create_dir(chl_name, root_dir);
> +

Redundant empty line.

> +               if (!chl_dir) {

> +                       dev_warn(sdc->dev, "create chl %d debugfs fail\n", i);

Message with no value.

> +                       continue;
> +               }

...

> +               switch (chl->info.type) {

The default case is missing.

> +               }
> +       }

...

> +       sdc->debugfs = root_dir;

Do we really need this? Debufs API can lookup for the folders with
predefined names.

...

> +       int ret;
> +       int i;
> +       int j;
> +       int prop_index;
> +       struct sdc_mfd *sdc = NULL;
> +       unsigned int temp;
> +       struct sdc_channel *chl = NULL;
> +       unsigned short next_cib_ptr = 0;
> +       unsigned short next_cib_ptr_backup = 0;
> +       unsigned long bar1_io;
> +       void __iomem *bar2_mem;
> +       unsigned long bar2_length;

Reverse xmas tree order, please.

...

> +       bar2_length = pci_resource_len(info->pdev, 2);
> +       bar2_mem = devm_ioremap(dev, pci_resource_start(info->pdev, 2),
> +               bar2_length);
> +       if (!bar2_mem)
> +               return -ENOMEM;

Why can't you use pcim_iomap_regions()?

...

> +       sdc->major_version = (unsigned char)((temp & 0x000000ff));
> +       sdc->minor_version = (unsigned char)((temp & 0x0000ff00) >> 8);
> +       sdc->available_chls = (unsigned char)((temp & 0x00ff0000) >> 16);
> +       sdc->total_length = (unsigned char)((temp & 0xff000000) >> 24);

> +       next_cib_ptr = next_cib_ptr_backup =
> +               (unsigned short)((temp & 0x0000ffff));

GENMASK(), no castings.
Same for other similar places.

...

> +       sdc->model_name[strlen(sdc->model_name)] = 0x0a;

Use '\n'

...

> +       sdc->channels = devm_kzalloc(dev, sizeof(struct sdc_channel) *
> +               sdc->available_chls, GFP_KERNEL);

devm_kcalloc()

> +       if (!sdc->channels)
> +               return -ENOMEM;

...

> +                       chl->info.config = devm_kzalloc(dev,
> +                               sizeof(struct cib_config), GFP_KERNEL);

Safer pattern is sizeof(*chl->info.config).

> +                       if (!chl->info.config)
> +                               return -ENOMEM;

...

> +                       chl->property = devm_kzalloc(dev,
> +                               sizeof(struct property_entry) * 18, GFP_KERNEL);

devm_kcalloc()

> +                       if (!chl->property)
> +                               return -ENOMEM;

...

> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U32(
> +                               "bus_number", sdc->info.bus_number);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U32(
> +                               "device_number", sdc->info.device_number);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U32(
> +                               "irq", sdc->info.irq);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U8(
> +                               "number", chl->info.number);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U8(
> +                               "version", chl->info.version);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U8(
> +                               "resource_cap", chl->info.resource_cap);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U8(
> +                               "event_type", chl->info.event_type);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U16(
> +                               "tx_fifo_size", chl->info.uart->tx_fifo_size);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U16(
> +                               "rx_fifo_size", chl->info.uart->rx_fifo_size);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U32(
> +                               "significand", chl->info.uart->significand);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U8(
> +                               "exponent", chl->info.uart->exponent);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U8(
> +                               "rs232_cap", chl->info.uart->rs232_cap);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U8(
> +                               "rs422_cap", chl->info.uart->rs422_cap);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U8(
> +                               "rs485_cap", chl->info.uart->rs485_cap);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U8(
> +                               "ahdc_cap", chl->info.uart->ahdc_cap);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U8(
> +                               "cs_cap", chl->info.uart->cs_cap);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U8(
> +                               "rs422_end_cap", chl->info.uart->rs422_end_cap);
> +                       chl->property[prop_index++] = PROPERTY_ENTRY_U8(
> +                               "rs485_end_cap", chl->info.uart->rs485_end_cap);

I'm not sure what's going on here. Can you add documentation somewhere
to explain all these?

...

> +static void __exit sdc_exit(void)
> +{

> +       ida_destroy(&sdc_devid_ida);

If you do it on non-freeid IDA it means you have a bug in resource
management (leakage) somewhere. I guess it was mistakenly used by the
drivers.

> +       debugfs_remove(sdc_mfd_debugfs);
> +}
> +module_exit(sdc_exit);

...

> +static int sdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{

> +       flags = pci_resource_flags(pdev, 0);
> +       if (!(flags & IORESOURCE_MEM)) {

> +               pr_err("bar0 resource flag x%lx invalid\n", flags);

So what? Besides the fact that dev_err() should be used.

> +               return -ENODEV;
> +       }
> +
> +       flags = pci_resource_flags(pdev, 1);
> +       if (!(flags & IORESOURCE_IO)) {
> +               pr_err("bar1 resource flag x%lx invalid\n", flags);
> +               return -ENODEV;
> +       }
> +
> +       flags = pci_resource_flags(pdev, 2);
> +       if (!(flags & IORESOURCE_MEM)) {
> +               pr_err("bar2 resource flag x%lx invalid\n", flags);
> +               return -ENODEV;
> +       }

All above checks seem redundant.

> +       ret = sdc_probe(&pdev->dev, &info);
> +       if (ret)
> +               return ret;

...

> +static const struct pci_device_id sdc_pci_ids[] = {
> +       { PCI_VDEVICE(SUNIX, 0x2000) },

> +       { },

Comma is not needed for terminator lines.

> +};


-- 
With Best Regards,
Andy Shevchenko
