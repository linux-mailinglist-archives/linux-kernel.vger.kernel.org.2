Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE77440A702
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbhINHDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:03:12 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:36600 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbhINHDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:03:04 -0400
Received: by mail-ua1-f41.google.com with SMTP id u11so7979779uaw.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tuysa/nqFrNnprxpuMVAoQ6N3N8odNTAhlZsCOvCuL8=;
        b=2Puh/FAyVywUeHNmmiCblUJNAa8kA5R2Et7vitToEChgbdUEQDIAKK+s//muhoWkkR
         0Y10NwsOcbRaoKMC6TAWx/0V3f0UF3t9SKkyB/aSEyMNd2Tw96+TPHKRBgdPc4raSwQq
         t+HKOVd86+OisVyZ9yKxKS6GXiPyCtNsMjkX3LQajkRVAgMdFEHOLLdXWYky26xIJDtO
         G8Q2EZ6L1Gwka5V/mRxmPLholK4H+lBaK6nEHlAZLxH45mQJtZJ0/MmqtThbzyzS+ZUi
         TtJpBP76P8WUdJwzdwmYpDapDnoFDYnY23RJHgd3w/FXm7Xx6HunPBtgGMaYdjQzFfjD
         LiNQ==
X-Gm-Message-State: AOAM533q8aUw3zrTUwJVbnX3TAqpxKxtMhsTA63tDf8Lv2f+izAbfrPW
        ji1n7A9bLWl1px3nDFYdSHTRnuhBm+5qH8O4dW0=
X-Google-Smtp-Source: ABdhPJwv/7mKMEA/JE1yUMPoECGTyuAhyjzdKrZ0LmOopoEU1RtDvEhAABml2Yytaq6hUSdqfW2G9DkOEy6wvrUnYDU=
X-Received: by 2002:ab0:4d5b:: with SMTP id k27mr2999788uag.78.1631602904013;
 Tue, 14 Sep 2021 00:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com> <20210914043928.4066136-3-saravanak@google.com>
In-Reply-To: <20210914043928.4066136-3-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Sep 2021 09:01:32 +0200
Message-ID: <CAMuHMdU8n9LH7+sZ-OFuce_y89GsQvt+HGUYdQMYCqOxoM3Y7Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] driver core: Set deferred probe reason when
 deferred by driver core
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Tue, Sep 14, 2021 at 6:39 AM Saravana Kannan <saravanak@google.com> wrote:
> When the driver core defers the probe of a device, set the deferred
> probe reason so that it's easier to debug. The deferred probe reason is
> available in debugfs under devices_deferred.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Thanks for your patch!

> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -955,6 +955,29 @@ static void device_links_missing_supplier(struct device *dev)
>         }
>  }
>
> +/**
> + * dev_set_def_probe_reason - Set the deferred probe reason for a device
> + * @dev: the pointer to the struct device
> + * @fmt: printf-style format string
> + * @...: arguments as specified in the format string
> + *
> + * This is a more caller-friendly version of device_set_deferred_probe_reason()
> + * that takes variable argument inputs similar to dev_info().
> + */
> +static void dev_set_def_probe_reason(const struct device *dev, const char *fmt, ...)

So this is indeed similar to device_set_deferred_probe_reason(),
but the function's name is completely different, unlike e.g.
(v)printf()?

> +{
> +       struct va_format vaf;
> +       va_list args;
> +
> +       va_start(args, fmt);
> +       vaf.fmt = fmt;
> +       vaf.va = &args;
> +
> +       device_set_deferred_probe_reason(dev, &vaf);
> +
> +       va_end(args);
> +}

I think you can just make this a macro wrapper calling
dev_err_probe(dev, -EPROBE_DEFER, fmt, ...).
Or open-code that below.

> +
>  /**
>   * device_links_check_suppliers - Check presence of supplier drivers.
>   * @dev: Consumer device.
> @@ -975,6 +998,7 @@ int device_links_check_suppliers(struct device *dev)
>  {
>         struct device_link *link;
>         int ret = 0;
> +       struct fwnode_handle *sup_fw;
>
>         /*
>          * Device waiting for supplier to become available is not allowed to
> @@ -983,10 +1007,13 @@ int device_links_check_suppliers(struct device *dev)
>         mutex_lock(&fwnode_link_lock);
>         if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
>             !fw_devlink_is_permissive()) {
> +               sup_fw = list_first_entry(&dev->fwnode->suppliers,
> +                                         struct fwnode_link,
> +                                         c_hook)->supplier;
>                 dev_dbg(dev, "probe deferral - wait for supplier %pfwP\n",
> -                       list_first_entry(&dev->fwnode->suppliers,
> -                       struct fwnode_link,
> -                       c_hook)->supplier);
> +                       sup_fw);
> +               dev_set_def_probe_reason(dev,
> +                       "wait for supplier %pfwP\n", sup_fw);

dev_err_probe() would replace both the dev_dbg() and the
dev_set_def_probe_reason().

>                 mutex_unlock(&fwnode_link_lock);
>                 return -EPROBE_DEFER;
>         }
> @@ -1003,6 +1030,9 @@ int device_links_check_suppliers(struct device *dev)
>                         device_links_missing_supplier(dev);
>                         dev_dbg(dev, "probe deferral - supplier %s not ready\n",
>                                 dev_name(link->supplier));
> +                       dev_set_def_probe_reason(dev,
> +                               "supplier %s not ready\n",
> +                               dev_name(link->supplier));

Likewise.

>                         ret = -EPROBE_DEFER;
>                         break;
>                 }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
