Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C72415F56
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbhIWNSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:18:25 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49304
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234006AbhIWNSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:18:24 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D79E340198
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 13:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632403011;
        bh=MKDfgpyx2DLaN+agqTgdGBhC7hPiB158s/GwrS6Ihlc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ZvGSd9mMmXrMflx0SKK+ZcNh4hzVFVNG02AWKpxAk7qAo40N+A41qCpjW0yiCoAYt
         IPYSf7wtm0Bs3mvR+WDKC4z4L6RGPSRGy14LmoQjrrWbCk7RFYsKWJAWGdvUIFOGPq
         lhacJiEGg0Pg8b//mvU9nSH24AAyAtM54Nz2iohHYmImntEX9VyERQpviXE3Q+cUIw
         6k/BcbsBi5ZBo6qZZailSSdGI+Js8sovS2660avzPZhu1fx+Kc8mRlzG3mpV+AHAbg
         b4owXuz/cqv9hUwaliEuO2NN/WLPC6cSl0yEMukaWgkyQMHi0rtkmplIXnBggc2vxZ
         mx+zItvl5bh9Q==
Received: by mail-ed1-f72.google.com with SMTP id m30-20020a50999e000000b003cdd7680c8cso6746837edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 06:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKDfgpyx2DLaN+agqTgdGBhC7hPiB158s/GwrS6Ihlc=;
        b=6oZcA7WJN8Z+YgP0c4Cspzsrba0midBTN/UGKBAiMERJh6GHn5RBtJUcO/KmFkXNo7
         9thrK/81xTKAQwyjQW9nR9Icarv1TblutnV9Ul2+QBhdtw/LVQCZtz98LtSwvNpL/iv/
         Lkutx9J98NUbO4bta5pWXLIPOcBNK1Fy+iqcPdAKnsJu/v8xxo7VaAcAAXPp8/eEwKws
         BNybAdGYRIPmD1Xxe4+ZSkVpnHfhvD40zqcjcGYGXnp83I9us9JETusRczx69099SiaO
         H3ly4TkeEaFE6z2k+bL+pcXaqmbRJWs6bmXMkpcgb2xrBG9a2RhYw5BIWH2fsaypoTfr
         2mXg==
X-Gm-Message-State: AOAM532Pet2mq2rLcLONv1tb1iq6fzFB/bE/DiS1JCdbQQ9yjcz9dFRL
        umD/159Ge1arB+GTfzE8C7XtERIHs78zTPQRfFdmFm0eSH3/XZLYxDrjaxkw3gr40J9TXtuH18r
        G/Q8nppOPq9OogPAO069YRmFf6PsBUz1SckA0++lULzPUMR6C3qBEsAFFVw==
X-Received: by 2002:a50:9d8e:: with SMTP id w14mr5339879ede.74.1632403011491;
        Thu, 23 Sep 2021 06:16:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrgje9Xp2OF0gTt6J7JjXIzDOTnJlBJzaVdnqqamjZANbNh5L9aWHVmJ3gxN+QGK8XgB4V/GLiPs1Pgzoii4Q=
X-Received: by 2002:a50:9d8e:: with SMTP id w14mr5339856ede.74.1632403011278;
 Thu, 23 Sep 2021 06:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <28072b8e-2c32-e67d-19d3-026913c0bc7f@codethink.co.uk> <CA+zEjCsPwGFng73OJShEc2g6wW1SOKwX7XYFqej_vkJKKUxL0A@mail.gmail.com>
In-Reply-To: <CA+zEjCsPwGFng73OJShEc2g6wW1SOKwX7XYFqej_vkJKKUxL0A@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Thu, 23 Sep 2021 15:16:40 +0200
Message-ID: <CA+zEjCtfQwK04vGJxULrESkxk=Ko8GiE8jm4CexnJ9u6COTwrA@mail.gmail.com>
Subject: Re: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 1:33 PM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> On Tue, Sep 21, 2021 at 12:25 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> >
> > On 21/09/2021 06:33, Alexandre Ghiti wrote:
> > > The SiFive Unmatched board uses the da9063 PMIC for reset: add a restart
> > > notifier that will execute a small i2c sequence allowing to reset the
> > > board.
> > >
> > > The original implementation comes from Marcus Comstedt and Anders Montonen
> > > (https://forums.sifive.com/t/reboot-command/4721/28).
> > >
> > > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> >
> > I've got a couple of comments here, mainly is this the right place
> > and has anyone other than you tested. I tried something similar on
> > my Unmatched and it just turned the board off.
>
> Someone else in the thread I mention in the commit log tried it, but
> more feedback are welcome :)
>
> For the Unmatched, this solution will be temporary, the best place
> being openSBI which lacks i2c support for now.
> But I think this can be used by other boards using this PMIC.
>
> >
> > > ---
> > >   drivers/mfd/da9063-core.c       | 25 +++++++++++++++++++++++++
> > >   include/linux/mfd/da9063/core.h |  3 +++
> > >   2 files changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> > > index df407c3afce3..c87b8d611f20 100644
> > > --- a/drivers/mfd/da9063-core.c
> > > +++ b/drivers/mfd/da9063-core.c
> > > @@ -20,6 +20,7 @@
> > >   #include <linux/mutex.h>
> > >   #include <linux/mfd/core.h>
> > >   #include <linux/regmap.h>
> > > +#include <linux/reboot.h>
> > >
> > >   #include <linux/mfd/da9063/core.h>
> > >   #include <linux/mfd/da9063/registers.h>
> > > @@ -158,6 +159,18 @@ static int da9063_clear_fault_log(struct da9063 *da9063)
> > >       return ret;
> > >   }
> > >
> > > +static int da9063_restart_notify(struct notifier_block *this,
> > > +                              unsigned long mode, void *cmd)
> > > +{
> > > +     struct da9063 *da9063 = container_of(this, struct da9063, restart_handler);
> > > +
> > > +     regmap_write(da9063->regmap, DA9063_REG_PAGE_CON, 0x00);
> > > +     regmap_write(da9063->regmap, DA9063_REG_CONTROL_F, 0x04);
> > > +     regmap_write(da9063->regmap, DA9063_REG_CONTROL_A, 0x68);
> > > +
> > > +     return NOTIFY_DONE;
> > > +}
> > > +
> >
> > Firstly, do you also need to force the AUTOBOOT (bit 3, CONTROL_C)
> > to ensure the PMIC does restart.
>
> I tried this too and actually, it seems that the value is read from
> OTP at reboot and as it is not set here, it has no effect.
>
> >
> > >   int da9063_device_init(struct da9063 *da9063, unsigned int irq)
> > >   {
> > >       int ret;
> > > @@ -197,6 +210,18 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
> > >               }
> > >       }
> > >
> > > +     da9063->restart_handler.notifier_call = da9063_restart_notify;
> > > +     da9063->restart_handler.priority = 128;
> > > +     ret = register_restart_handler(&da9063->restart_handler);
> > > +     if (ret) {
> > > +             dev_err(da9063->dev, "Failed to register restart handler\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     devm_add_action(da9063->dev,
> > > +                     (void (*)(void *))unregister_restart_handler,
> > > +                     &da9063->restart_handler);
> >
> > there's devm_register_reboot_notifier()
>
> Thanks for that!

Actually restart_notifier and reboot_notifier are not the same, see
https://elixir.bootlin.com/linux/latest/source/kernel/reboot.c#L72.
What we need here is restart_handler.

Thanks anyway :)

Alex

>
> >
> >
> > > +
> > >       return ret;
> > >   }
> > >
> > > diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
> > > index fa7a43f02f27..1b20c498e340 100644
> > > --- a/include/linux/mfd/da9063/core.h
> > > +++ b/include/linux/mfd/da9063/core.h
> > > @@ -85,6 +85,9 @@ struct da9063 {
> > >       int             chip_irq;
> > >       unsigned int    irq_base;
> > >       struct regmap_irq_chip_data *regmap_irq;
> > > +
> > > +     /* Restart */
> > > +     struct notifier_block restart_handler;
> > >   };
> > >
> > >   int da9063_device_init(struct da9063 *da9063, unsigned int irq);
> >
> > Note, the watchdog driver for the DA9063 also has a restart method
> > although it also does not set the AUTOBOOT bit either.
> >
> > The best thing is to enable the watchdog driver, the SiFive release
> > does not have either the core DA9063 or the watchdog driver for it
> > enabled.
>
> It seems that for the restart implemented here to work, the AUTOBOOT
> bit needs to be set in the OTP, which seems not to be the case with
> the chip on this board: it's been discussed here
> https://www.dialog-semiconductor.com/products/pmics?post_id=10052#tab-support_tab_content
> (see the accepted answer).
>
> Thanks,
>
> Alex
>
> >
> > --
> > Ben Dooks                               http://www.codethink.co.uk/
> > Senior Engineer                         Codethink - Providing Genius
> >
> > https://www.codethink.co.uk/privacy.html
