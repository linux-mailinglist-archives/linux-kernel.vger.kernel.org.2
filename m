Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C173C420A90
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhJDMHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:07:23 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51328
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232591AbhJDMHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:07:21 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5CB19402C9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 12:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633349128;
        bh=yk33OuLVmJWefKEhzs9+C3SahsZbMShSnLaFEJM9QYM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=FjR4NqKp9ldOStLvJzEZbLmW/hbJMQFu1FvagKpmgZ6cDzJxfr10SZJ7eGpkj/ibb
         XYRb5Km++2OfcgDuld8CuO/kr7ou+X0VCqKZI5HVm9WzG7hNx03UessJQi4cEqfP/U
         UED36SVhcMfokP8SCIjBPMRiKukKfN/7DioAgD4ObC553pq3MyFaybu1Kiqa5TPBWP
         1PMreKF4H3Ug090LazqOQ8dlgzWszeV9uHFOBW858oe+stzaVKILljBWwV5OsoHxgk
         ZvPIYiaAFmuzOwCpe98rG8sEmaL1KFF35E21bTOFBdXbCycdVoks81bv1ce3XUrPz3
         wFAoQXp5OHFiQ==
Received: by mail-ed1-f72.google.com with SMTP id z62-20020a509e44000000b003da839b9821so16907712ede.15
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 05:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yk33OuLVmJWefKEhzs9+C3SahsZbMShSnLaFEJM9QYM=;
        b=GZI979Z7hfR6xIZSw9RG1f20zdD2LOqUyz2/P6uq6RuM83Iy0VUTeUEkmMpofdz7AW
         dJOk+64B1hbPLwFg1WhPXZmSauZ6nGYdeuOfwlYvTQ6wSRfydClmAg/6+uEPh7pO4t8p
         4XlhevYCii5BE8wqstsUBfyNzjPIsW3v8WeMcgK5kFYbnwdQIVbkxtbOeU9YYrVwfESD
         YPYbGTKaJs2PBFB+gEk/P9z8TqC4LotSgxx9k79efRMpcjj6rYs51qrgZV/ID0+Pyj8j
         FFSFIdtMlZ6Stih4hz/1EkdSCsO1yDt2fXdUUTlqOVvjACm/Bt9WwCTI60qrFlvWEdVV
         +4lw==
X-Gm-Message-State: AOAM53145/kCSceL/hwfL3A8VpzKA35zyB4MLYv0LKrFs4q/FutricgB
        NbWaQVz1Y+CsuJUyfSjQH51t7TopDXPYWI5mLT7gFehHUCQUP0NIIPid1SQ8VMM6zyXjPxjT7wj
        Mm2LLD9yY+sBmP8JHcVHjzWT5Msk3h+ypDb8hOeLIYCmy8rz89hwLpjKiPg==
X-Received: by 2002:aa7:dbcf:: with SMTP id v15mr2179edt.243.1633349127889;
        Mon, 04 Oct 2021 05:05:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/rYt+eImhQuoGMVtko2yxHPLqYrknaRlL4bDtktcDR1TvI/BP3O1SIGNgMTynDp0FqNcwLiYGyDh5LZS7zTg=
X-Received: by 2002:aa7:dbcf:: with SMTP id v15mr2160edt.243.1633349127673;
 Mon, 04 Oct 2021 05:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com>
 <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CAEn-LTqVd8z=kpCtWjiPbKuw24NuHLTQxWzw7g34fEJgDYrp8w@mail.gmail.com> <CA+zEjCtQN6c8bikg620PQwoPzJ6T4wGLvzQ413iPs1tCeHif0Q@mail.gmail.com>
In-Reply-To: <CA+zEjCtQN6c8bikg620PQwoPzJ6T4wGLvzQ413iPs1tCeHif0Q@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Mon, 4 Oct 2021 14:05:16 +0200
Message-ID: <CA+zEjCtVxDkg8K0iK32j4KO+Wgt+hTjXD15HdRhNeCV2Sjpckw@mail.gmail.com>
Subject: Re: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 12:25 PM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> Hi David,
>
> On Thu, Sep 30, 2021 at 9:51 AM David Abdurachmanov
> <david.abdurachmanov@gmail.com> wrote:
> >
> > On Wed, Sep 29, 2021 at 4:36 PM Adam Thomson
> > <Adam.Thomson.Opensource@diasemi.com> wrote:
> > >
> > > On 24 September 2021 17:17, Alexandre Ghiti wrote:
> > >
> > > > > > +static int da9063_restart_notify(struct notifier_block *this,
> > > > > > +                              unsigned long mode, void *cmd)
> > > > > > +{
> > > > > > +     struct da9063 *da9063 = container_of(this, struct da9063,
> > > > > > restart_handler);
> > > > > > +
> > > > > > +     regmap_write(da9063->regmap, DA9063_REG_PAGE_CON, 0x00);
> > > > > > +     regmap_write(da9063->regmap, DA9063_REG_CONTROL_F, 0x04);
> > > > > > +     regmap_write(da9063->regmap, DA9063_REG_CONTROL_A, 0x68);
> > > > > > +
> > > > > > +     return NOTIFY_DONE;
> > > > > > +}
> > > > >
> > > > > I will talk with our HW team to clarify, but this sequence looks to be very
> > > > > specific to the needs of the platform in question which doesn't feel right to
> > > > > me. As was mentioned on another thread as well, the watchdog driver already
> > > > has
> > > > > a restart function to reset the device (and thus the system), so I don't believe
> > > > > we should have multiple of these.
> > > >
> > > > From the discussion that happened here
> > > > https://www.dialog-semiconductor.com/products/pmics?post_id=10052#tab-
> > > > support_tab_content,
> > > > it does not seem possible to use the watchdog on a chip whose OTP does
> > > > not set AUTOBOOT. But anyway, I'm looking forward to hearing from the
> > > > HW team :)
> > >
> > > So I've discussed this internally and so far it's not completely clear how the
> > > sequence you provided actually performs the reset as you suggest. It certainly
> > > doesn't look like it should, so maybe this relates to an external pin somehow
> > > triggering the restart in this particular scenario? I'd be interested to
> > > understand which event bits are set when the board does restart to understand
> > > what did actually trigger the boot-up.
> > >
> > > Regardless of this though, the consensus right now would be to use the RTC as a
> > > wake event to restart the platform. An alarm can be set for a couple of seconds
> > > into the future (or longer if required) and that would provide the event
> > > required to come up from powerdown/shutdown, in the absence of AUTOBOOT being
> > > set in OTP. I believe this would be the safest route to take in this case. You
> > > can then just use the SHUTDOWN bit on CONTROL_F to take down the board.
> >
> > Today I was looking into OpenBSD DA9063 drivers and they might be
> > doing what you described for the reset.
> >
> > dev/fdt/dapmic.c
> >
> > [..]
> > 241 void
> > 242 dapmic_reset(void)
> > 243 {
> > 244     struct dapmic_softc *sc = dapmic_cd.cd_devs[0];
> > 245     uint8_t reg;
> > 246
> > 247     /* Enable tick alarm wakeup with a one second interval. */
> > 248     reg = dapmic_reg_read(sc, ALARM_MO);
> > 249     reg &= ~ALARM_MO_TICK_TYPE;
> > 250     reg |= ALARM_MO_TICK_WAKE;
> > 251     dapmic_reg_write(sc, ALARM_MO, reg);
> > 252
> > 253     /* Enable tick function. */
> > 254     reg = dapmic_reg_read(sc, ALARM_Y);
> > 255     reg |= ALARM_Y_TICK_ON;
> > 256     dapmic_reg_write(sc, ALARM_Y, reg);
> > 257
> > 258     /* Clear events such that we wake up again. */
> > 259     dapmic_reg_write(sc, EVENT_A, dapmic_reg_read(sc, EVENT_A));
> > 260     dapmic_reg_write(sc, CONTROL_F, CONTROL_F_SHUTDOWN);
> > 261 }
> > [..]
> >
>
> Thanks for the pointer! I have just tested this sequence from the
> u-boot shell, it resets the board correctly. But then if we try to
> power down the board by a long press to the corresponding button on
> the board within 16 seconds, it resets the board: so we cannot
> shutdown the board in the next 16 seconds that follow this sequence.
>
> Maybe that can be resolved by using the one-shot alarm as described by
> Adam, I'll try to find that in the datasheet.

After configuring the one-shot alarm, I still have those intempestive
reboots if I try to power down the board by a long press within 16
seconds. The only thing I found in the datasheet regarding this timing
is in case of power undervoltage, not sure how this is linked to what
I see.

@Adam Thomson Any ideas?

Thanks,

Alex

>
> Thanks
>
> Alex
>
> > >
> > > To reiterate, I believe this should be made a board specific quirk, rather than
> > > as part of the generic MFD core of DA9063, as the timings may vary for other
> > > platforms.
> >
> > Agree. Currently it seems Linux drivers expect DA9063 boards to have
> > AUTOBOOT ON set in OTP, which is not the case for SiFive Unmatched
> > (thus issues with reset and WDT).
> >
> > david
> >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
