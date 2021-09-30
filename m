Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21E141D7A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349931AbhI3K12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:27:28 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38048
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349893AbhI3K1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:27:21 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 70C9840279
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632997533;
        bh=6bJ/KKwRD3P6cVHXUuBeJPUvhLBCys6Z5e/DGfI2INI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=GVFUAZ21PZLYIHyCVQhJ7yuptL7lyHHD/KOqDZFH1u4gqVVTTlEM5WfMOZ6I0cPmZ
         GNiI3Eb6SBAznR+nEbqeLgMyvu6JPsDlg5lLtMFD8vkpiTurFlUo5QsHSOXk18pisz
         cuTErTBAY3NGz7ROfFm0akTGcZBqKzRpAXvPffWLgLAMtxz618kQiC/Bg2M+ZjfEs1
         hMqnzokHqgubMx6WdDyCMrbEyrFjltRn+XFogVRlWYZg/2GMhST07kQbH6M57/a/NA
         T0lDFA8CWCsTKIAjMs6EKv6qLns0p43FiWVNEsQ1puvjXXmfz0z9kJSVeZxOuUJp1V
         jsnXXPMzbvWKA==
Received: by mail-ed1-f72.google.com with SMTP id x7-20020a50ba87000000b003dabd8354f1so1109230ede.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 03:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bJ/KKwRD3P6cVHXUuBeJPUvhLBCys6Z5e/DGfI2INI=;
        b=GM2lhYuAk1aMeHObMQ5M4mMi9BIV5bUXGdQQmZHQYjXy+MozgS+OZF910UHlUbcUK1
         UvELBfk8jsSE3bOAZTIyqKYHSTlrA2tyv3VJOzb9Yjk/4ecCKHgzPe9W/TdIfwx1KVHh
         /3hDo4+R5NGKNn0x/6RwnITtSXKwwu4Pvwrsfu0ccNu6hw7TasCA++riStzjLIYFMd1n
         MbwLfXZV6okh7BEhitc2VDB5Lh4q7ZijGO3suPOvygD7DoFKHSTo9gEKED/f9Syq26aC
         jBobR4vPm01wXQIrUWBEIItDC8mm/AI43TnYrjQiPNsws6r3ze76KJLIWPbh4Nq0mDrI
         bveQ==
X-Gm-Message-State: AOAM5323M9TQHygew2PGdCk4PgPeazfsH9Zqx1PwdJhjz3Gj3d8Pjogk
        DZem49vrdxOuc+xG6OYILSQLTPmSVp1DS7HrFgCxHqegXBGnF1T5LI0Zxz1ug/YfN4qpEX/DURW
        VwMqaphhrNJ7axCswmM8225NiaZcNKmMw3uzCU4AL4I4OZrxGv0zjRQD8Cg==
X-Received: by 2002:a50:da49:: with SMTP id a9mr6232271edk.281.1632997533093;
        Thu, 30 Sep 2021 03:25:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1xKeVqUJ6nQktZ5CoqoEFhXeDC+QUMtNphnsnn7kzUNYkMsY9ktMcMEjnvDr2rOxl8YyRJiQWzgQ83zpxXfc=
X-Received: by 2002:a50:da49:: with SMTP id a9mr6232248edk.281.1632997532879;
 Thu, 30 Sep 2021 03:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com>
 <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CAEn-LTqVd8z=kpCtWjiPbKuw24NuHLTQxWzw7g34fEJgDYrp8w@mail.gmail.com>
In-Reply-To: <CAEn-LTqVd8z=kpCtWjiPbKuw24NuHLTQxWzw7g34fEJgDYrp8w@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Thu, 30 Sep 2021 12:25:22 +0200
Message-ID: <CA+zEjCtQN6c8bikg620PQwoPzJ6T4wGLvzQ413iPs1tCeHif0Q@mail.gmail.com>
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

Hi David,

On Thu, Sep 30, 2021 at 9:51 AM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
>
> On Wed, Sep 29, 2021 at 4:36 PM Adam Thomson
> <Adam.Thomson.Opensource@diasemi.com> wrote:
> >
> > On 24 September 2021 17:17, Alexandre Ghiti wrote:
> >
> > > > > +static int da9063_restart_notify(struct notifier_block *this,
> > > > > +                              unsigned long mode, void *cmd)
> > > > > +{
> > > > > +     struct da9063 *da9063 = container_of(this, struct da9063,
> > > > > restart_handler);
> > > > > +
> > > > > +     regmap_write(da9063->regmap, DA9063_REG_PAGE_CON, 0x00);
> > > > > +     regmap_write(da9063->regmap, DA9063_REG_CONTROL_F, 0x04);
> > > > > +     regmap_write(da9063->regmap, DA9063_REG_CONTROL_A, 0x68);
> > > > > +
> > > > > +     return NOTIFY_DONE;
> > > > > +}
> > > >
> > > > I will talk with our HW team to clarify, but this sequence looks to be very
> > > > specific to the needs of the platform in question which doesn't feel right to
> > > > me. As was mentioned on another thread as well, the watchdog driver already
> > > has
> > > > a restart function to reset the device (and thus the system), so I don't believe
> > > > we should have multiple of these.
> > >
> > > From the discussion that happened here
> > > https://www.dialog-semiconductor.com/products/pmics?post_id=10052#tab-
> > > support_tab_content,
> > > it does not seem possible to use the watchdog on a chip whose OTP does
> > > not set AUTOBOOT. But anyway, I'm looking forward to hearing from the
> > > HW team :)
> >
> > So I've discussed this internally and so far it's not completely clear how the
> > sequence you provided actually performs the reset as you suggest. It certainly
> > doesn't look like it should, so maybe this relates to an external pin somehow
> > triggering the restart in this particular scenario? I'd be interested to
> > understand which event bits are set when the board does restart to understand
> > what did actually trigger the boot-up.
> >
> > Regardless of this though, the consensus right now would be to use the RTC as a
> > wake event to restart the platform. An alarm can be set for a couple of seconds
> > into the future (or longer if required) and that would provide the event
> > required to come up from powerdown/shutdown, in the absence of AUTOBOOT being
> > set in OTP. I believe this would be the safest route to take in this case. You
> > can then just use the SHUTDOWN bit on CONTROL_F to take down the board.
>
> Today I was looking into OpenBSD DA9063 drivers and they might be
> doing what you described for the reset.
>
> dev/fdt/dapmic.c
>
> [..]
> 241 void
> 242 dapmic_reset(void)
> 243 {
> 244     struct dapmic_softc *sc = dapmic_cd.cd_devs[0];
> 245     uint8_t reg;
> 246
> 247     /* Enable tick alarm wakeup with a one second interval. */
> 248     reg = dapmic_reg_read(sc, ALARM_MO);
> 249     reg &= ~ALARM_MO_TICK_TYPE;
> 250     reg |= ALARM_MO_TICK_WAKE;
> 251     dapmic_reg_write(sc, ALARM_MO, reg);
> 252
> 253     /* Enable tick function. */
> 254     reg = dapmic_reg_read(sc, ALARM_Y);
> 255     reg |= ALARM_Y_TICK_ON;
> 256     dapmic_reg_write(sc, ALARM_Y, reg);
> 257
> 258     /* Clear events such that we wake up again. */
> 259     dapmic_reg_write(sc, EVENT_A, dapmic_reg_read(sc, EVENT_A));
> 260     dapmic_reg_write(sc, CONTROL_F, CONTROL_F_SHUTDOWN);
> 261 }
> [..]
>

Thanks for the pointer! I have just tested this sequence from the
u-boot shell, it resets the board correctly. But then if we try to
power down the board by a long press to the corresponding button on
the board within 16 seconds, it resets the board: so we cannot
shutdown the board in the next 16 seconds that follow this sequence.

Maybe that can be resolved by using the one-shot alarm as described by
Adam, I'll try to find that in the datasheet.

Thanks

Alex

> >
> > To reiterate, I believe this should be made a board specific quirk, rather than
> > as part of the generic MFD core of DA9063, as the timings may vary for other
> > platforms.
>
> Agree. Currently it seems Linux drivers expect DA9063 boards to have
> AUTOBOOT ON set in OTP, which is not the case for SiFive Unmatched
> (thus issues with reset and WDT).
>
> david
>
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
