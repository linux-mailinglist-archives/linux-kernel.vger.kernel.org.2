Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24E0413270
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhIULVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:21:41 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:44114
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232229AbhIULVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:21:40 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DAC4A3FE05
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632223211;
        bh=MjesVevkYIqX1GQ7DanAgbDwI571QgAHXDgwfVLZUzk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=OyUhrziLcDFlH7MmAr5uOEFZZUXtAIS77FEtEKNx+Vkm11az0J54tFv0LRJ9wT9DN
         HJOL+H8xohwKPPqqTVr/P7lOwUt8ZHxsQdwRxNjey+IvVlo0JfTEpy3j/Z8oib3rq9
         r6FMcZG/VDN+iSqFsyHng/DDAonB7BSnE79jHRaChgckDWXsEC0m6Yy7E2v6mR1WFm
         KTs4DqMvwtser2kMDRI4C4NBRsNz/rscu7IMytNaMdrKWU3zxeaEUlbdnr5Y5blH+T
         BrtAtNs85LD4L1kHBKSdBu3v8gfwKeG8CKWt9OpqwRzysuF+qa5cnnqVrqD5AFwleK
         H6qUJcFsJkvdA==
Received: by mail-ed1-f70.google.com with SMTP id w24-20020a056402071800b003cfc05329f8so18761593edx.19
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 04:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MjesVevkYIqX1GQ7DanAgbDwI571QgAHXDgwfVLZUzk=;
        b=1xqKKdV4WnPu1J67ksfafFN9FaSjxA6bxDW6VNfSyWUMaqWIRE0YrI69qnW4qT2GnI
         T+cQt4OdKl5U6NFtH3k1h08dOO58MxJeRuF8oW7IuR+Qy3pzr+eQdYBp8dR8bqqm7AgX
         U2DpxhMQ284VMTWUw8rzfDT6526Hn+zeyRQs+/L6c78ZzptmyJnyj6B20og37tJ5rWvB
         OMNvgnQayHfOFDSOcES0jZsA5WaM0zhKc6vZ4b1ck07R4XRP6vtsqD9mHBSPVRBDswVt
         1f/5XVTdc8Cq0ZEsiuTfcAa2txyavi/3XAuOYgKL2Nqg+SBRcLCJFD5tgqbFMO0/HIbG
         OTCw==
X-Gm-Message-State: AOAM530p3ov/Z48eP/b2vpn/pXvP+YYratIuVH96uXYTk4IlETJV7HBD
        Ln6VoqXU9oEslJOwWql36BaCtAQuy57JMW3XshvnlugcJKN/hYFsjbcP4qudYEXPEo7QZNUIM2l
        Jl11jwrhE9DuADs8GOzBlsiNbe5XMuynf2/bhHSE++zL6LMfYdydtB/FdUg==
X-Received: by 2002:a17:906:8981:: with SMTP id gg1mr34363649ejc.95.1632223211456;
        Tue, 21 Sep 2021 04:20:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzy1Zml1lG/L7siYipoWZFKyg+Vw32nqM/rZd7PNcGFYuxpgdmkEWCLjGp8N6QGPtYWTGqstZeGuhBNqGpURJw=
X-Received: by 2002:a17:906:8981:: with SMTP id gg1mr34363627ejc.95.1632223211220;
 Tue, 21 Sep 2021 04:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com> <CAAhSdy07KzQnTH+ad4esxtfhogzpXQagY8KeDkq1Kc81-Z33Yw@mail.gmail.com>
In-Reply-To: <CAAhSdy07KzQnTH+ad4esxtfhogzpXQagY8KeDkq1Kc81-Z33Yw@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Tue, 21 Sep 2021 13:20:00 +0200
Message-ID: <CA+zEjCsFG31kcM89B6LfP32Kh7WTHxzU6zvxigmKrDheKkU2fQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
To:     Anup Patel <anup@brainfault.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I chose a priority lower than the one you proposed in your SRST series
(https://lkml.org/lkml/2021/6/9/620).

Alex

On Tue, Sep 21, 2021 at 12:17 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Sep 21, 2021 at 11:04 AM Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
> >
> > The SiFive Unmatched board uses the da9063 PMIC for reset: add a restart
> > notifier that will execute a small i2c sequence allowing to reset the
> > board.
> >
> > The original implementation comes from Marcus Comstedt and Anders Montonen
> > (https://forums.sifive.com/t/reboot-command/4721/28).
> >
> > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> > ---
> >  drivers/mfd/da9063-core.c       | 25 +++++++++++++++++++++++++
> >  include/linux/mfd/da9063/core.h |  3 +++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> > index df407c3afce3..c87b8d611f20 100644
> > --- a/drivers/mfd/da9063-core.c
> > +++ b/drivers/mfd/da9063-core.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/mfd/core.h>
> >  #include <linux/regmap.h>
> > +#include <linux/reboot.h>
> >
> >  #include <linux/mfd/da9063/core.h>
> >  #include <linux/mfd/da9063/registers.h>
> > @@ -158,6 +159,18 @@ static int da9063_clear_fault_log(struct da9063 *da9063)
> >         return ret;
> >  }
> >
> > +static int da9063_restart_notify(struct notifier_block *this,
> > +                                unsigned long mode, void *cmd)
> > +{
> > +       struct da9063 *da9063 = container_of(this, struct da9063, restart_handler);
> > +
> > +       regmap_write(da9063->regmap, DA9063_REG_PAGE_CON, 0x00);
> > +       regmap_write(da9063->regmap, DA9063_REG_CONTROL_F, 0x04);
> > +       regmap_write(da9063->regmap, DA9063_REG_CONTROL_A, 0x68);
> > +
> > +       return NOTIFY_DONE;
> > +}
> > +
> >  int da9063_device_init(struct da9063 *da9063, unsigned int irq)
> >  {
> >         int ret;
> > @@ -197,6 +210,18 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
> >                 }
> >         }
> >
> > +       da9063->restart_handler.notifier_call = da9063_restart_notify;
> > +       da9063->restart_handler.priority = 128;
>
> How was this priority value chosen ?
>
> I mean, we will be having SBI SRST as well so we should choose
> a priority value lower than what we choose for SBI SRST handler.
>
> Regards,
> Anup
>
> > +       ret = register_restart_handler(&da9063->restart_handler);
> > +       if (ret) {
> > +               dev_err(da9063->dev, "Failed to register restart handler\n");
> > +               return ret;
> > +       }
> > +
> > +       devm_add_action(da9063->dev,
> > +                       (void (*)(void *))unregister_restart_handler,
> > +                       &da9063->restart_handler);
> > +
> >         return ret;
> >  }
> >
> > diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
> > index fa7a43f02f27..1b20c498e340 100644
> > --- a/include/linux/mfd/da9063/core.h
> > +++ b/include/linux/mfd/da9063/core.h
> > @@ -85,6 +85,9 @@ struct da9063 {
> >         int             chip_irq;
> >         unsigned int    irq_base;
> >         struct regmap_irq_chip_data *regmap_irq;
> > +
> > +       /* Restart */
> > +       struct notifier_block restart_handler;
> >  };
> >
> >  int da9063_device_init(struct da9063 *da9063, unsigned int irq);
> > --
> > 2.30.2
> >
