Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B904309F10
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 22:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhAaVUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 16:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhAaVQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 16:16:58 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D3BC061786
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:06:07 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id w204so12079761ybg.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F6xePmZZnH6hMvD4xD8ZTxXMbXTwQCIaaXwZCqOR73o=;
        b=pomyqoIFXX8blUy7SRM25Ywc+1yks3dkornd4bjxNZ7tJyPbuAIYMU6om7s9K38vJu
         VzCVf4EXMfvoHPrmVlkUDpTvmmsfMex17X44y5ilguI1PX/cW5hb+FhSGH5NoZntkpy7
         k/yS+ANLmiMBiwh7xRB1VsICl/7gFFT7+VGTJp+TMlW9FkAxzhR1ldV6byEN+YrJzyw+
         EkMkKyE6kbmp0WsE5wmuqL00jQ59V9C2c6XSLdiwhzz2ubHYQrLe0jE+KLU4ZfV3ec7y
         mV77qYWFGvW3v4jkAVc91iU0NyniIvM0UCzR40x/EIzC91ahpbFjqayO6t/RhkBNeRqT
         FcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F6xePmZZnH6hMvD4xD8ZTxXMbXTwQCIaaXwZCqOR73o=;
        b=A9QfUykuMFgL/mcmc4o++C59vDz36jYWaSonORQEELAJB9wnmHEAOPNKUCQJfljswB
         VDeU5TQZOOTFwVj2kzKaJ3O7FODLXxfnk+1gNvreQcBjHW2rLh5bwKgfQSAiCRb/N3R7
         3mkS3y/sYkvVAVvMHcyjFNxBzAz4aKif1J1p3iHkHCoVJcMhgQtA0VpWBQP0aAWsDGPu
         lpdA5l3IxJ448hxRbWtNe0q9SqGNtf6WHZXLqg/yWxlt/H5capBDFat9Jkh1a33jPAvi
         xVKhs6BfZ4Av7PsG6O1QInQWOo4Rd2BVJJ5a/F0ggeO2Do57ZplsaNo6ra1lxOxnBc2x
         FjcA==
X-Gm-Message-State: AOAM532dVmtl/11m/lKpvgukbiihwhz9hFi9OjeBPy7VIqZYJlHnZxOQ
        hZ+A86ArSipmi8VhSLAnBwC6rdDfwio67815eV8gow==
X-Google-Smtp-Source: ABdhPJzjU3zj0wbXZG0f03S/hFagW8JbVXaVdT9fwLER5q6Jo0XbHcUOUssMJB/AbhXUdfaJz5NEzNBpvaWWh15ZEzc=
X-Received: by 2002:a25:b74c:: with SMTP id e12mr11231618ybm.20.1612127166455;
 Sun, 31 Jan 2021 13:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20210121225712.1118239-1-saravanak@google.com> <20210131163823.c4zb47pl4tukcl7c@viti.kaiser.cx>
In-Reply-To: <20210131163823.c4zb47pl4tukcl7c@viti.kaiser.cx>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sun, 31 Jan 2021 13:05:30 -0800
Message-ID: <CAGETcx8A_+Y0sCLPdyeeT+rHOsAPsmg4LVn_ahF0NaD6hfRiZw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] of: property: Add fw_devlink support for more props
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 8:38 AM Martin Kaiser <martin@kaiser.cx> wrote:
>
> Dear all,
>
> Thus wrote Saravana Kannan (saravanak@google.com):
>
> > Sending again because I messed up the To/Cc for the coverletter.
>
> > This series combines two patches [1] [2] that'd conflict.
>
> > Greg,
>
> > Can you please pull this into driver-core-next?
>
> > -Saravana
>
> > [1] - https://lore.kernel.org/lkml/20210115210159.3090203-1-saravanak@google.com/
> > [2] - https://lore.kernel.org/lkml/20201218210750.3455872-1-saravanak@google.com/
>
> I'm running linux-next on my hardware which is based on the imx258
> chipset by Freescale/NXP.
>
> When those two patches appeared in linux-next, my system would not boot
> any more. It was stuck right after
>
> Uncompressing Linux... done, booting the kernel.
>
> Reverting the irq-patch made the system boot again. Still, a number of
> devices like usb or nand flash controller are not found any more.
> If I revert the gpio patch as well, all devices are available again.
>
> My system's device tree is based on arch/arm/boot/dts/imx25.dtsi with
> very few adaptations for my board.
>
> I tried to play around with the new parse_interrupts() function to
> figure out which device causes the boot failure. If I skip the following
> device, I can boot again:
>
> -       return of_irq_find_parent(np);
> +       np_ret = of_irq_find_parent(np);
> +       if (!strcmp(np->full_name, "serial@50008000")) {
> +           printk(KERN_ERR "skip serial@50008000\n");
> +           return NULL;
> +       }
> +      return np_ret;
>
> This is uart4 of the imx258 chip, which I use as my serial console. The
> imx25.dtsi device tree seems ok, we find an interrupt parent. The
> problem must be in the code that processes the result of
> parse_interrupts().
>
> I tried to boot the unmodified code with qemu, simulating the imx25-pdk
> device. This wouldn't boot either.
>
> Does this ring any bells with anyone?

This series [1] has a high chance of fixing it for you if
CONFIG_MODULES is disabled in your set up. Can you give it a shot?

The real problem is that arch/arm/mach-imx/avic.c doesn't set the
OF_POPULATED flag for the "fsl,avic" node. fw_devlink uses this
information to know that this device node will never have a struct
device created for it. The proper way to do this for root IRQCHIP
nodes is to use IRQCHIP_DECLARE(). I Cc'ed you on a clean up patch for
IMX [2], can you please give [2] a shot *without* [1] and with
CONFIG_MODULES enabled? Things should boot properly with this
combination too.

Btw, for future reference, you can try enabling the logs in
device_links_check_suppliers() to see what devices are being blocked
on what supplier nodes.

[1] - https://lore.kernel.org/lkml/20210130040344.2807439-1-saravanak@google.com/
[2] - https://lore.kernel.org/lkml/20210131205654.3379661-1-saravanak@google.com/T/#u

Thanks,
Saravana
