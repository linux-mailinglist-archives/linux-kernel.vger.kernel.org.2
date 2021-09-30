Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C5841D4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 09:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348834AbhI3Hxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 03:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348824AbhI3Hxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 03:53:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6593C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 00:51:51 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j5so16796966lfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 00:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOQC9qDuzBo2C8E99AFpnFMO/c5cxqQImivipJ9VOGI=;
        b=BssjWxgqLMDsW2dxYyrsl3lvvILHX4cQ9c9yZLwNzBjc5SgAMgQKCZzg4hJLWU7t3U
         76Bz2XiWgqFt3q9gLHa9Ry19K9vlD6hwNwymd9Wq7WXSmaqNo/26ICRPKZo4hYWoY/ba
         rS76bc/Lwkag6G5z50CjruSOuXwP06xZmInpG1odm+tWIhMDqykL8T7dy2cH6F90e6vr
         0R0v+WBq8jbMIvDYvh9kn0GpKCscVTet+M2qR6dPCUAj9CeAterrydtwF23OV+flvcgs
         gbV+YH4fkNBbKa2b/qBde61Nm5C97/U2OIwyr/1cyOPpq54k+UPbfVzFP2Ypbst4jIla
         ugww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOQC9qDuzBo2C8E99AFpnFMO/c5cxqQImivipJ9VOGI=;
        b=wdPs+XMBYmls023HXd98DuTmaWeok8wQs7UCpjmaJniLcacLpM30jp5VaQ0KmT4EcB
         tSUa9gBp6RvP8nBXlTJvTfdsfI3anWL7nwgG0CTNriEayWQQyvutyqxM9qhvP6puF9zk
         GIboOjHMkcbw/ph9WAK/EH2vcpc7YHmrsYcgX4PvyCplfg3qvZMRaUb5KF3iX1krEMTW
         CpkkhdQX9vKrQ2dOmsUUgnJomZ7mIwYgT9Zhd0Rb/tkIJhF1PE3IBgu3WmVkCVGcX0fs
         cVAh0zdJ3nHiK4rqEJuvk5AWjIHVoPpuLnNe0Txtspyzadc+bTx7fAugriCrFPm5WIJ0
         gMFg==
X-Gm-Message-State: AOAM531GL+1yuvu6UbEkIPZi8MWbzkpTE5pVKZtUAOfQnpCxhR0cDNAh
        N0GCE/O/tc40hl7sf78YHXmDUmBE9EsGda+EkTY=
X-Google-Smtp-Source: ABdhPJy00FNBVoPYXCRJLUz4fYYVw+83ZeEGkmcEpC/iUaJIqpXfTbulRfEoNcPT+cJaHx3UeT316dObwNWV9cDuJZ4=
X-Received: by 2002:a2e:7203:: with SMTP id n3mr4604188ljc.195.1632988310174;
 Thu, 30 Sep 2021 00:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com> <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Thu, 30 Sep 2021 10:51:14 +0300
Message-ID: <CAEn-LTqVd8z=kpCtWjiPbKuw24NuHLTQxWzw7g34fEJgDYrp8w@mail.gmail.com>
Subject: Re: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 4:36 PM Adam Thomson
<Adam.Thomson.Opensource@diasemi.com> wrote:
>
> On 24 September 2021 17:17, Alexandre Ghiti wrote:
>
> > > > +static int da9063_restart_notify(struct notifier_block *this,
> > > > +                              unsigned long mode, void *cmd)
> > > > +{
> > > > +     struct da9063 *da9063 = container_of(this, struct da9063,
> > > > restart_handler);
> > > > +
> > > > +     regmap_write(da9063->regmap, DA9063_REG_PAGE_CON, 0x00);
> > > > +     regmap_write(da9063->regmap, DA9063_REG_CONTROL_F, 0x04);
> > > > +     regmap_write(da9063->regmap, DA9063_REG_CONTROL_A, 0x68);
> > > > +
> > > > +     return NOTIFY_DONE;
> > > > +}
> > >
> > > I will talk with our HW team to clarify, but this sequence looks to be very
> > > specific to the needs of the platform in question which doesn't feel right to
> > > me. As was mentioned on another thread as well, the watchdog driver already
> > has
> > > a restart function to reset the device (and thus the system), so I don't believe
> > > we should have multiple of these.
> >
> > From the discussion that happened here
> > https://www.dialog-semiconductor.com/products/pmics?post_id=10052#tab-
> > support_tab_content,
> > it does not seem possible to use the watchdog on a chip whose OTP does
> > not set AUTOBOOT. But anyway, I'm looking forward to hearing from the
> > HW team :)
>
> So I've discussed this internally and so far it's not completely clear how the
> sequence you provided actually performs the reset as you suggest. It certainly
> doesn't look like it should, so maybe this relates to an external pin somehow
> triggering the restart in this particular scenario? I'd be interested to
> understand which event bits are set when the board does restart to understand
> what did actually trigger the boot-up.
>
> Regardless of this though, the consensus right now would be to use the RTC as a
> wake event to restart the platform. An alarm can be set for a couple of seconds
> into the future (or longer if required) and that would provide the event
> required to come up from powerdown/shutdown, in the absence of AUTOBOOT being
> set in OTP. I believe this would be the safest route to take in this case. You
> can then just use the SHUTDOWN bit on CONTROL_F to take down the board.

Today I was looking into OpenBSD DA9063 drivers and they might be
doing what you described for the reset.

dev/fdt/dapmic.c

[..]
241 void
242 dapmic_reset(void)
243 {
244     struct dapmic_softc *sc = dapmic_cd.cd_devs[0];
245     uint8_t reg;
246
247     /* Enable tick alarm wakeup with a one second interval. */
248     reg = dapmic_reg_read(sc, ALARM_MO);
249     reg &= ~ALARM_MO_TICK_TYPE;
250     reg |= ALARM_MO_TICK_WAKE;
251     dapmic_reg_write(sc, ALARM_MO, reg);
252
253     /* Enable tick function. */
254     reg = dapmic_reg_read(sc, ALARM_Y);
255     reg |= ALARM_Y_TICK_ON;
256     dapmic_reg_write(sc, ALARM_Y, reg);
257
258     /* Clear events such that we wake up again. */
259     dapmic_reg_write(sc, EVENT_A, dapmic_reg_read(sc, EVENT_A));
260     dapmic_reg_write(sc, CONTROL_F, CONTROL_F_SHUTDOWN);
261 }
[..]

>
> To reiterate, I believe this should be made a board specific quirk, rather than
> as part of the generic MFD core of DA9063, as the timings may vary for other
> platforms.

Agree. Currently it seems Linux drivers expect DA9063 boards to have
AUTOBOOT ON set in OTP, which is not the case for SiFive Unmatched
(thus issues with reset and WDT).

david

> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
