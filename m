Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9484B413299
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhIULfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:35:16 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:44396
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhIULfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:35:14 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 939773F335
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632224025;
        bh=46IQwAllaiUgmZjVqNNo/yi2D55M7e5XlkpRqscq5DA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=uYImOOeIhfIJNjqX3VJ72Ruok8cGw0yR3UULrtkjkOoZI0gC3Ou85il7OPEz10tzq
         iamvlUzACp9K7mhvYD98s9Ml17j7/6WjgB6O9Fc9dFloVgHMFq/Hp7GLyelrhI6Yix
         9stFVveYOImy3Ka884SahGygjPhOwZHHNTFgy0YbSC7Y0ovkpXAN1U3psvem1fxVFg
         LasJmzEVuikjuD1DFquS2PCCnVNQRpNK+lujbvBc+2sHRqrvPvmMAPKyoY8vBWOz7M
         GkpIgk0jYa9GbdDeD2RmANljC1IPVKsVHf7s05XL0iitM79QZRA7BkTZUTYCu+DivW
         gAWxhwPYCUBRg==
Received: by mail-ed1-f71.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so18717761edy.14
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 04:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46IQwAllaiUgmZjVqNNo/yi2D55M7e5XlkpRqscq5DA=;
        b=mQa19HZOdUeS8zfQHYNtahdn5GSlhSVdTMRWNU8Emr7STu6a8elWfWTNGehzrEUpA7
         CbVIcYMGxM3DYj0HLxR2D1TEdnMYboEJppg5gXd4D7L0xTCna12os5sgqApE8vbAlpO+
         9p6XGxNlkomgg2ZMJdYWZrcYokEN9N8b/ZkjTATFIhQKIoSQDy0o5M4qTjWCkgT330zX
         E1WFLtd826XcVdLp1ri+F94tufDKF7HnfKMN+H+a8V7fEfe3d1UC/jD3jvUVF0zcRXc1
         6DksrsOVhAJ7BE4bYRJYZPsy5YkCYqrzQwIHLqF/jDNN3ZsR8p61pxfCBnwcMeA55FBE
         6zRQ==
X-Gm-Message-State: AOAM532rBKMC+PRFKuC/Ze5cfurOm6SwVx9EQK5zMdiimRZUWQ30+UAS
        t+N357Kzme36KR/Q2q6wDv6o3NabN6M98kqmmxrBw2syndaiPo6TR2o+o3z9kkCkyMYuuIHmw7p
        PA3+TOmt4drdWPvXRXTXgDdbOm2nkeoxYcccigZC4sqDH1ASe5XrVGc+ITg==
X-Received: by 2002:a17:906:8981:: with SMTP id gg1mr34434160ejc.95.1632224024946;
        Tue, 21 Sep 2021 04:33:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBUixzvQ6yBN47UbB2xf3oeK2CqEKdGlZoKox+qhzX7J3b6qPfaKXlGw2wpfdKWi5wh+c1ui/AKExAF0LDSIA=
X-Received: by 2002:a17:906:8981:: with SMTP id gg1mr34434141ejc.95.1632224024710;
 Tue, 21 Sep 2021 04:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com> <28072b8e-2c32-e67d-19d3-026913c0bc7f@codethink.co.uk>
In-Reply-To: <28072b8e-2c32-e67d-19d3-026913c0bc7f@codethink.co.uk>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Tue, 21 Sep 2021 13:33:34 +0200
Message-ID: <CA+zEjCsPwGFng73OJShEc2g6wW1SOKwX7XYFqej_vkJKKUxL0A@mail.gmail.com>
Subject: Re: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 12:25 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> On 21/09/2021 06:33, Alexandre Ghiti wrote:
> > The SiFive Unmatched board uses the da9063 PMIC for reset: add a restart
> > notifier that will execute a small i2c sequence allowing to reset the
> > board.
> >
> > The original implementation comes from Marcus Comstedt and Anders Montonen
> > (https://forums.sifive.com/t/reboot-command/4721/28).
> >
> > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
>
> I've got a couple of comments here, mainly is this the right place
> and has anyone other than you tested. I tried something similar on
> my Unmatched and it just turned the board off.

Someone else in the thread I mention in the commit log tried it, but
more feedback are welcome :)

For the Unmatched, this solution will be temporary, the best place
being openSBI which lacks i2c support for now.
But I think this can be used by other boards using this PMIC.

>
> > ---
> >   drivers/mfd/da9063-core.c       | 25 +++++++++++++++++++++++++
> >   include/linux/mfd/da9063/core.h |  3 +++
> >   2 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> > index df407c3afce3..c87b8d611f20 100644
> > --- a/drivers/mfd/da9063-core.c
> > +++ b/drivers/mfd/da9063-core.c
> > @@ -20,6 +20,7 @@
> >   #include <linux/mutex.h>
> >   #include <linux/mfd/core.h>
> >   #include <linux/regmap.h>
> > +#include <linux/reboot.h>
> >
> >   #include <linux/mfd/da9063/core.h>
> >   #include <linux/mfd/da9063/registers.h>
> > @@ -158,6 +159,18 @@ static int da9063_clear_fault_log(struct da9063 *da9063)
> >       return ret;
> >   }
> >
> > +static int da9063_restart_notify(struct notifier_block *this,
> > +                              unsigned long mode, void *cmd)
> > +{
> > +     struct da9063 *da9063 = container_of(this, struct da9063, restart_handler);
> > +
> > +     regmap_write(da9063->regmap, DA9063_REG_PAGE_CON, 0x00);
> > +     regmap_write(da9063->regmap, DA9063_REG_CONTROL_F, 0x04);
> > +     regmap_write(da9063->regmap, DA9063_REG_CONTROL_A, 0x68);
> > +
> > +     return NOTIFY_DONE;
> > +}
> > +
>
> Firstly, do you also need to force the AUTOBOOT (bit 3, CONTROL_C)
> to ensure the PMIC does restart.

I tried this too and actually, it seems that the value is read from
OTP at reboot and as it is not set here, it has no effect.

>
> >   int da9063_device_init(struct da9063 *da9063, unsigned int irq)
> >   {
> >       int ret;
> > @@ -197,6 +210,18 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
> >               }
> >       }
> >
> > +     da9063->restart_handler.notifier_call = da9063_restart_notify;
> > +     da9063->restart_handler.priority = 128;
> > +     ret = register_restart_handler(&da9063->restart_handler);
> > +     if (ret) {
> > +             dev_err(da9063->dev, "Failed to register restart handler\n");
> > +             return ret;
> > +     }
> > +
> > +     devm_add_action(da9063->dev,
> > +                     (void (*)(void *))unregister_restart_handler,
> > +                     &da9063->restart_handler);
>
> there's devm_register_reboot_notifier()

Thanks for that!

>
>
> > +
> >       return ret;
> >   }
> >
> > diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
> > index fa7a43f02f27..1b20c498e340 100644
> > --- a/include/linux/mfd/da9063/core.h
> > +++ b/include/linux/mfd/da9063/core.h
> > @@ -85,6 +85,9 @@ struct da9063 {
> >       int             chip_irq;
> >       unsigned int    irq_base;
> >       struct regmap_irq_chip_data *regmap_irq;
> > +
> > +     /* Restart */
> > +     struct notifier_block restart_handler;
> >   };
> >
> >   int da9063_device_init(struct da9063 *da9063, unsigned int irq);
>
> Note, the watchdog driver for the DA9063 also has a restart method
> although it also does not set the AUTOBOOT bit either.
>
> The best thing is to enable the watchdog driver, the SiFive release
> does not have either the core DA9063 or the watchdog driver for it
> enabled.

It seems that for the restart implemented here to work, the AUTOBOOT
bit needs to be set in the OTP, which seems not to be the case with
the chip on this board: it's been discussed here
https://www.dialog-semiconductor.com/products/pmics?post_id=10052#tab-support_tab_content
(see the accepted answer).

Thanks,

Alex

>
> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
>
> https://www.codethink.co.uk/privacy.html
