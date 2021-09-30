Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F72B41D67B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349473AbhI3Jjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:39:35 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56860
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349419AbhI3Jje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:39:34 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0AA71402CB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632994666;
        bh=4X6dQ0l1/8G9mRvlRpg8SXm7KFk/1WWtkX+qwHW3nT4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ivBU7Oh7NXqLJ0lxFIFoiyIcdQdn1qociACLLt4u5VWr8uMM5XXVoKvz+qJ/G1E06
         279hwswxU5ls5FmxUAeeONmZ9TgSKVondLPfxZxnGTyBA+e2QI1BKHI+qOn7MuVBtp
         QV8GT7T5IJnXdTDJNgroZx+6EM7Gzir2A3BkY7b4J/PGt7ddYUrkEC/fTuSMsFrcpv
         RSJwVz8nl67NMMvgH79KDxEFpUedhN48PlJsewyCcCxZFBd36I1GF7j1jjhypUIwi/
         4QPDaYjtZdLaoBCpSIZAr2pjEPtHItTfSrdnXx8wfm0o3dD3Lk+E7FVccvDx7lhW7f
         WJqQpUTk0VxzQ==
Received: by mail-lf1-f71.google.com with SMTP id x33-20020a0565123fa100b003fcfd99073dso5092268lfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 02:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4X6dQ0l1/8G9mRvlRpg8SXm7KFk/1WWtkX+qwHW3nT4=;
        b=fOdB1sdlKz/VQ7x+2+PjCklicgvBxuKfVy26azx5bkWLcyE5DtMvd2I1SPh9X0rAz4
         KLQkboxnSNlVbph5USJcK7/K8Xrx9fvQ+nV+9RXcl+YNl7YPJmNnZhqWx4zEhj4M7XJi
         WUuEdhtYAIJlkPWObqW24w6OLRcm5dkshrcJtLxnw1OIcGVK0H5gvp2tHJ2PaHm7kpqy
         93NJ7UD3crZdcVV84icY4cKagknDnzA4JnoIegIZqRTt/moPAj6PYYya4RHDXJdCox2N
         dPWIW4xAsxbinNlVacqqNAP+zk9kqRfu+Oe04dgcYVyui9qEv3qyOZuwkNZNtEb61dyR
         Sa1Q==
X-Gm-Message-State: AOAM5324Xh+Vikt0bJnMwxb7TRry0v8skv+mtjroxmwlxKswXwsK7IGs
        gVLxbm+BC0RtM0eJgLINFkuSfftFNaZ4ev+i/G3dQM1VQE7BxRj/PVm1xTeomCP+1snvFHD6czV
        c0yonfRewoJDJJVR3Qe2YEEPFC5zG5n7edAs6zAVMz8/96bQCYedmQ/56lg==
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr4992334lfg.498.1632994665302;
        Thu, 30 Sep 2021 02:37:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNYcDzQ7LBIUZhurzYKgr9dBeC3UWYffeeYCMH3qAHDp44YUInp/6LuwNJ9oNdspH0hPtiIv8TSR06B420Fbg=
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr4992318lfg.498.1632994665112;
 Thu, 30 Sep 2021 02:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com> <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Thu, 30 Sep 2021 11:37:34 +0200
Message-ID: <CA+zEjCtViMOXERby6A=wOKswQOFL60kTidc4+LY6_Y5svB_kLQ@mail.gmail.com>
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

What timings are you referring to? Is the timing you're talking to the
time between the shutdown and the tick that wakes the device up?

Because I have another series ready which uses a new device tree
binding so that platforms that want the reset from the DA9063 can ask
for it via the device tree. And then I could add a property "duration"
that is platform dependent.
