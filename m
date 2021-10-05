Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5884C422829
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhJENpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:45:31 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37966
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233942AbhJENp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:45:29 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D319C402CF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633441414;
        bh=MQr5JvhbeTPXIzpILBDcG4ZyoASVQMlOTqtjeshmuUA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Sknu0kSqtQX5rf0ecDGf3CxN8oOu7Re7TXRXvJrb+7Yos0py+Q6TDoX57UeJCpvVI
         yofsTFypeYOzhqjWsiJdsimY2ehi0vJmY/U19qX7+BQ7firQsmI0dK+/sKLNqjyB2v
         cty0jFNpE36hwHpwyP+kBoMwW4+bpLhqSlUB6xZpgECAKfGn66Ukf1OUIIm7PaZH0L
         0HLMVcNb/3RzA7+k3oVyneOpRjG+mpBiWY+HKfcFxvughtnzpuTqLANe3m+AO2YPo4
         rugdzTnHNXgIIdsKFYl3AC9GV7zXlPZAYZRyDRDWPSGS1V+gC/I9QlFf8dVvfSchKP
         sBRvWcFE7gmDw==
Received: by mail-ed1-f70.google.com with SMTP id i7-20020a50d747000000b003db0225d219so3503477edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 06:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQr5JvhbeTPXIzpILBDcG4ZyoASVQMlOTqtjeshmuUA=;
        b=fiZShbK4UNXI/MuHIqIamtJCjSxgRKDmZVE3UZh+7N0oYfnhZI3FDWfIJAMlzQbSIM
         Nr57L+QKmV6imH9YIrzib5rkCIH72zjaUoO9yftaz19I/VggV9wPAsLTQ7h2i/6smmuU
         34gUbo6RHcCYYjfRccu3S2WMgu9W9eAEJWCL1ciHWrr2XeIyzNnQ25FpCvOd9nREvnZa
         z++TsdizNN3mYWim6O/6OQZ4YnAmzE7TupEHsAW9de/B55vwj/Iw3qrszMHuA3cyKNcF
         bGCZi5TVDKARsW9kGSWho5DqMZey+5PJf6xq969gUMBXa0IrQT/qPe+W4RPMxG0l+NjB
         8t0A==
X-Gm-Message-State: AOAM5331Hlsb8FDyzli28b6pQhY+JUF4INBMBAC4MOCFc+C/Sfds1eJK
        YEheIOaGG+kCNHXmZ+ju0zAuY6CSMUueftnx50CcVjGnm1tD2GObhsFThFwcq4J3oBz3tweSdyG
        KF+nr3iR+rtn/RIOp+8U92owRfW+6pyRkBcwLuYwaDQDAPceeoBzqSZRekw==
X-Received: by 2002:a50:9b06:: with SMTP id o6mr26248167edi.284.1633441414437;
        Tue, 05 Oct 2021 06:43:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE45cpl2a+b8XPh2W0hWmXiukiZgAFGqPvSyDY9pDwB6MyC5rWC0zmflwKMSa6IYu1tdvjYgYYnqb8ycx037s=
X-Received: by 2002:a50:9b06:: with SMTP id o6mr26248152edi.284.1633441414285;
 Tue, 05 Oct 2021 06:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com>
 <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CAEn-LTqVd8z=kpCtWjiPbKuw24NuHLTQxWzw7g34fEJgDYrp8w@mail.gmail.com>
 <CA+zEjCtQN6c8bikg620PQwoPzJ6T4wGLvzQ413iPs1tCeHif0Q@mail.gmail.com>
 <CA+zEjCtVxDkg8K0iK32j4KO+Wgt+hTjXD15HdRhNeCV2Sjpckw@mail.gmail.com> <DB9PR10MB4652294AB444536BF57E320A80AE9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB9PR10MB4652294AB444536BF57E320A80AE9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Tue, 5 Oct 2021 15:43:23 +0200
Message-ID: <CA+zEjCsf6m8cctHNPBxJczg-J9XC-piAcdtNDO71qmtCtDj9gw@mail.gmail.com>
Subject: Re: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 5:11 PM Adam Thomson
<Adam.Thomson.Opensource@diasemi.com> wrote:
>
> On 04 October 2021 13:05, Alexandre Ghiti wrote:
>
> > > > Today I was looking into OpenBSD DA9063 drivers and they might be
> > > > doing what you described for the reset.
> > > >
> > > > dev/fdt/dapmic.c
> > > >
> > > > [..]
> > > > 241 void
> > > > 242 dapmic_reset(void)
> > > > 243 {
> > > > 244     struct dapmic_softc *sc = dapmic_cd.cd_devs[0];
> > > > 245     uint8_t reg;
> > > > 246
> > > > 247     /* Enable tick alarm wakeup with a one second interval. */
> > > > 248     reg = dapmic_reg_read(sc, ALARM_MO);
> > > > 249     reg &= ~ALARM_MO_TICK_TYPE;
> > > > 250     reg |= ALARM_MO_TICK_WAKE;
> > > > 251     dapmic_reg_write(sc, ALARM_MO, reg);
> > > > 252
> > > > 253     /* Enable tick function. */
> > > > 254     reg = dapmic_reg_read(sc, ALARM_Y);
> > > > 255     reg |= ALARM_Y_TICK_ON;
> > > > 256     dapmic_reg_write(sc, ALARM_Y, reg);
> > > > 257
> > > > 258     /* Clear events such that we wake up again. */
> > > > 259     dapmic_reg_write(sc, EVENT_A, dapmic_reg_read(sc, EVENT_A));
> > > > 260     dapmic_reg_write(sc, CONTROL_F, CONTROL_F_SHUTDOWN);
> > > > 261 }
> > > > [..]
> > > >
> > >
> > > Thanks for the pointer! I have just tested this sequence from the
> > > u-boot shell, it resets the board correctly. But then if we try to
> > > power down the board by a long press to the corresponding button on
> > > the board within 16 seconds, it resets the board: so we cannot
> > > shutdown the board in the next 16 seconds that follow this sequence.
> > >
> > > Maybe that can be resolved by using the one-shot alarm as described by
> > > Adam, I'll try to find that in the datasheet.
> >
> > After configuring the one-shot alarm, I still have those intempestive
> > reboots if I try to power down the board by a long press within 16
> > seconds. The only thing I found in the datasheet regarding this timing
> > is in case of power undervoltage, not sure how this is linked to what
> > I see.
> >
> > @Adam Thomson Any ideas?
>
> Nothing immediately springs to mind. Can you confirm this is the nONKEY long
> press that you're attempting here, which is resetting the board rather than
> shutting down?

Yes, this is the nONKEY long press that, if done within ~16sec after
the board is reset using the alarm, resets the board instead of
shutting it down.

>
> Also, would you able to again provide events and fault log when this unwanted
> reset occurs, just in case there's anything there to give a clue. Can then
> discuss internally to see if we can ascertain what might be happening here.

FAULT_LOG = 0x60
EVENT_A = 0x12
EVENT_B to EVENT_D = 0

But I'm unsure of those values since they are the same after the reset
triggered by the one-shot alarm *and* if I clear EVENT_A, the
intempestive reboot does not appear!

Thanks,

Alex
