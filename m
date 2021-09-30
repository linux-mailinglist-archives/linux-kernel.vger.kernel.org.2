Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0711641D6DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349614AbhI3J5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:57:13 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57826
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238316AbhI3J5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:57:10 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 992204025C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632995727;
        bh=pqAX+UbJIa/RMJv8j6rl+G+R+tbCZ7fA5m1R+K85bTM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Coj8IMPqpFx00+3UZ87iL3TxNl8BnxZtvCql+1ieHUWjy1QTen5UFIKh3BNHOZFlr
         LFWfKWSHawhBVXgmq+a++aBfIiLCmQqCVsg1kOuBaCRJyN5EuhqWpZLxgvk1BjhiYm
         d5jKTWu9vqSNG7OqFWVx1zQ7iELEf5vACdMySwmiIxxJqtpa8zNba99+R0CO/Nn4Kr
         4r5joUvZhwS2XnTwVktWGASPI+Q/8RUaXT9IwjM9q1dYol4YUs7LanCJRDKJkhTaHw
         hxzlBnAL1doACEw2q1LMUNcr5rlLf7AV4VmZIRXbg1ymbQDn3ZKQjbslsetabP09Z2
         cC7ziKreG4rBA==
Received: by mail-ed1-f69.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so5664443edy.14
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 02:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqAX+UbJIa/RMJv8j6rl+G+R+tbCZ7fA5m1R+K85bTM=;
        b=31TFnxAVfUvO1LUUZGxM4807ZFQ5MVfY8dP1cy814fVyeESGzQomxf7C7VMRUfK7N/
         wcpdO1gjfkM7H6SfCtidwdk4Ca6GOfqY/il2Ngn+oUi3QWaAim2BzH6iH1aTof66oTM3
         RBLid6BpbJ+oiuj64SIzEZF95q/es36f+d9aS3oXokxSzko43i/D/RdfPaY6451QrbK/
         u5UDCYVhm7XHCi5NzNmPGmBOdoRQCbMAKObs18sgI9ERoToAG4vaO/8rHUrrBMfCsDa6
         0v7kAqZECjPD3Po2c02nMa2nfLFXgiQ/emfH5eviX4XBF0ZmBfAsfpuZQdtUcl3M37MN
         XauQ==
X-Gm-Message-State: AOAM530fwn0jUgkhyRzNClIy/y2RfslbobWUIWx6coN3fczPySbSnmBS
        UhLhr+pLZZ8fwTFAXgr34VffWosX2JGDPgdTd0rc75fhloCvA4WdYUgQkYcglE29KhAiNyl/o8l
        DuhQYCJwMx2+mN6xS0LgjCdaBYucoDDi+f0U5dlCb9Bk3JkS0j23yPvdVzw==
X-Received: by 2002:a50:da49:: with SMTP id a9mr6069826edk.281.1632995727272;
        Thu, 30 Sep 2021 02:55:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzo+WktB+lKivY55kkL6Lpyd6wyqermcOkd7ja1F42auhV0sOF5FP4afdjG0REUJIWjOwRJCpUMRqAPVD9nKCI=
X-Received: by 2002:a50:da49:: with SMTP id a9mr6069808edk.281.1632995727067;
 Thu, 30 Sep 2021 02:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com> <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Thu, 30 Sep 2021 11:55:16 +0200
Message-ID: <CA+zEjCv8tExoZx309qRMe6KCZ=-AC+nCOV7qivJWE5gCqrd2MA@mail.gmail.com>
Subject: Re: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Thank you for your answer.

On Wed, Sep 29, 2021 at 3:33 PM Adam Thomson
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

After clearing all those registers and a reset as done in this patch,
I get the following values:

FAULT_LOG: 0x00
EVENT_A: 0x10 => As per the datasheet, "Sequencer reached final
position caused event" ?
EVENT_B: 0x00
EVENT_C: 0x00
EVENT_D: 0x00

Do you need any other info?

>
> Regardless of this though, the consensus right now would be to use the RTC as a
> wake event to restart the platform. An alarm can be set for a couple of seconds
> into the future (or longer if required) and that would provide the event
> required to come up from powerdown/shutdown, in the absence of AUTOBOOT being
> set in OTP. I believe this would be the safest route to take in this case. You
> can then just use the SHUTDOWN bit on CONTROL_F to take down the board.
>
> To reiterate, I believe this should be made a board specific quirk, rather than
> as part of the generic MFD core of DA9063, as the timings may vary for other
> platforms.

Alex
