Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6033143383F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhJSOUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhJSOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:20:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9436DC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:18:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w14so13237571edv.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgCDDEsGSe1etnRXFlGlYA3RdOp2g4WwA49g9BH2mKE=;
        b=tWFghgkkUlfwYWjFZ3PYbgFlQf/5Mi+IMgCHPscUSOO7C1RUHeBeoxtuvWPSEzFLev
         wVFrWrFn98WLfL4h4+OMZ/U6TlUplFq2ctVYWcBR10YBLVQeaezu4BX56/hIYr9z7xZl
         EOAf9FiQC2zv/Dh63ggvbYyyYn8l3/mWtXfuvdp2lJVhyAXc7ujE/iRJ1fdH60NR2XXg
         vHiLXdv7bC+W3qJXQKo+/DhFRRomE4ojmENGbVXyvw2XStajmJCmm/BaWPW87A4mLjQu
         k/Kpyr39gGNM65JZBs7uMC7/pESvkUguFyRBRdzO74ygiW4l6UUjkiHXI2FsNJZuFW9J
         PSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgCDDEsGSe1etnRXFlGlYA3RdOp2g4WwA49g9BH2mKE=;
        b=Jcnd2tIy4UE4CDxmNOVraYc2daYgWQWBLXbOsdk44x+JsEZ1SavgK9OEk5zVdhCCGU
         TONh2sV1lqoJG6MyEm0QJA0zsV+IKKKtDmMYhX5A9vX9P7iApSoQ22RU89hXzCis4r+V
         5VSuNiA492CBoyj5vGyejI/WKe1hKQsYnIep76jvYL5ZGK8TWrf2zuUpRmz3kQ1WjBGZ
         L+eJ1lGgseum2XAgHV8QY5T11dehmQgrgHlcOFkDnfy9BkNgfw6JzATWuJKHjdjtY0sG
         AGj4UBX+XX5Aif4Au13Q5Zfu+AkIhZuUgjeUKUCCJV/IrQ8swf4ijQzje/hEQ1fAeKfv
         Crsw==
X-Gm-Message-State: AOAM530PXHXGlbdvITiweVQFtiLBiYbzWN6Cwc7uUf1l42y8/U00KOAf
        buZoaPFTVsyNYupJEMAAQBMlsB25c6VjEGOKEXcKGw==
X-Google-Smtp-Source: ABdhPJy1gSI41oeorN63MssHPM8MixeVINo6yVf++/lR4YLCwf0LjmL8Upf93f3ovx7b7dmSgVflhalUnudvZZUPAi0=
X-Received: by 2002:a17:907:764e:: with SMTP id kj14mr37506778ejc.349.1634652981528;
 Tue, 19 Oct 2021 07:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211008081739.26807-1-brgl@bgdev.pl> <20211008081739.26807-6-brgl@bgdev.pl>
 <YW1PEvTyqdhiRYR6@smile.fi.intel.com>
In-Reply-To: <YW1PEvTyqdhiRYR6@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 19 Oct 2021 16:16:10 +0200
Message-ID: <CAMRc=Mcem-EC=ckD2HwiihJXUsOGpGdiJ=U-vWGq1SzmOVwbTg@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] gpio: sim: new testing module
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jack Winch <sunt.un.morcov@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 12:40 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 08, 2021 at 10:17:36AM +0200, Bartosz Golaszewski wrote:
> > Implement a new, modern GPIO testing module controlled by configfs
> > attributes instead of module parameters. The goal of this driver is
> > to provide a replacement for gpio-mockup that will be easily extensible
> > with new features and doesn't require reloading the module to change
> > the setup.
> >
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > [Andy: Initialize attribute allocated on the heap]
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > [Colin: Fix dereference of free'd pointer config]
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Some nit-picks below, up to you to address.
>
> ...
>
> > +     ret = gpio_sim_setup_sysfs(chip);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
>
> return gpio_sim_...(chip); ?
>

Sure, can do.

> ...
>
> > +
>
> Redundant empty line.
>
> > +CONFIGFS_ATTR_RO(gpio_sim_config_, dev_name);
>
> ...
>
> > +
>
> Ditto.
>
> > +CONFIGFS_ATTR_RO(gpio_sim_config_, chip_name);
>
> ...
>
> > +
>
> Ditto.
>
> > +CONFIGFS_ATTR(gpio_sim_config_, label);
>
> ...
>
> > +
>
> Ditto.
>
> > +CONFIGFS_ATTR(gpio_sim_config_, num_lines);
>
> ...
>
> > +
>
> Ditto.
>
> > +CONFIGFS_ATTR(gpio_sim_config_, line_names);
>

These are on purpose - there's the store and show function and putting
it next to only one is misleading IMO.

> ...
>
> > +     fwnode = fwnode_create_software_node(properties, NULL);
> > +     if (IS_ERR(fwnode))
> > +             return PTR_ERR(fwnode);
>
>
> > +     fwnode = dev_fwnode(&config->pdev->dev);
> > +     platform_device_unregister(config->pdev);
> > +     fwnode_remove_software_node(fwnode);
>
> This seems correct, thank you for modifying the code.
>
> ...
>
> > +     config->pdev = NULL;
> > +     mutex_unlock(&config->lock);
>
> mutex_destroy() ?
> Or is it done in the upper level?
>

It's done in the release callback.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
