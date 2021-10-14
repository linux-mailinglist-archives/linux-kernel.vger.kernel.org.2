Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C4742DEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhJNPxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:53:42 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33298
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230109AbhJNPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:53:40 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C65E93F077
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634226693;
        bh=ibIaPrB4h2yeafzdyejc/m3tdIsM4DZm3oUCx/6wbuk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=M7BGNDKG+rN3EsS7z0lbyFU3gtlIVdo63m8DXNJhX8M0IWAwkwuSARfNXEkswg/RN
         l52tEizDZYQx1AxO9SXeCQskFoyPwjW8+J9s80HkNCBiDEcPJmT7/usqCVFDbC6TXg
         tGTCJU3r83SQq4uHcg4i4/GnNFkLz0CcWH3ZYGdWdpuWlD+wnStL9rphg1eYQOBsvN
         DwzgjqyhGDcedzbbjCr5IrntYLZsRiK2OUown51jZYfFGLozi+f08KWllry3V4Fa0t
         iFrer7zGZnb6ZulYN4InLFaNlzprK+jgFFRK5jGsoTZwx3NFTzIzGzeolgybiL+HGu
         X8gDkNvlGyh0Q==
Received: by mail-ed1-f70.google.com with SMTP id z23-20020aa7cf97000000b003db7be405e1so5570434edx.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibIaPrB4h2yeafzdyejc/m3tdIsM4DZm3oUCx/6wbuk=;
        b=hgHCHZ0SMLbxlXvdwGuzIZ7LKWYFa3gZxPWap5gCU7NOyULYxAsaqM/Cjo1WsrM9S+
         RgVQ3v7Ox+7slRN/7DKn4X89qVlsn4VcshFnynD7M7GxElWjuo4wt4zWMYzk37kYqGSP
         8hpvy+exoAE5H7BlyYx9pQGFBgiiy8GngwXlJCXzdYIpUTAhGjKoY5cBZdGdafnrveBa
         jFoU6bqRDDKZkndGKdz90buc0h1Iu+vhZkldzm5RYPKOAB/tbNcE17Z+r9kCZHK1E1cA
         hwbLL929eWxLSZH/DhMgJxL3pva0PLvfaGZDLug+0Il4akzYMD3WTTM+z1OrVfPinckc
         6Vpw==
X-Gm-Message-State: AOAM530Hf9VwpTEEeZhclSni6o1ljj52xH5JmDPQjNDDrK6q9uH/vu84
        MVUIIBjWL1TqgtfG2njt7S1JL/lcSrLWQ6bRFnLToEquuMCroyBYRNpgpxeBhOML678Iw9uSPy3
        zGz/B/PImimoYC4X7mVBrn2/nNDGWnNkncdOr2GkLK1Dc0/vH9iXfeQ1SDQ==
X-Received: by 2002:a05:6402:1c85:: with SMTP id cy5mr9872549edb.281.1634226693486;
        Thu, 14 Oct 2021 08:51:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXSo7KMpganDPs+BD0ZMLrwk86fT+bJ0DDECD+p0nOUGLuBGc0LtUenwo7PGuhya/lJqPfy6zQImYnMjK1vYM=
X-Received: by 2002:a05:6402:1c85:: with SMTP id cy5mr9872535edb.281.1634226693319;
 Thu, 14 Oct 2021 08:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com>
 <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CAEn-LTqVd8z=kpCtWjiPbKuw24NuHLTQxWzw7g34fEJgDYrp8w@mail.gmail.com>
 <CA+zEjCtQN6c8bikg620PQwoPzJ6T4wGLvzQ413iPs1tCeHif0Q@mail.gmail.com>
 <CA+zEjCtVxDkg8K0iK32j4KO+Wgt+hTjXD15HdRhNeCV2Sjpckw@mail.gmail.com>
 <DB9PR10MB4652294AB444536BF57E320A80AE9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCsf6m8cctHNPBxJczg-J9XC-piAcdtNDO71qmtCtDj9gw@mail.gmail.com>
 <DB9PR10MB465270EA5D6F25C44E68D1E580B09@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvFO6Tz+D42wgnstx_TLNEt=HM0eeT5g0-zwaEscGj2vQ@mail.gmail.com>
 <DB9PR10MB46521072770D6A1C75DEE08380B29@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <DB9PR10MB46525FC6EAF1610178A20B7580B69@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB9PR10MB46525FC6EAF1610178A20B7580B69@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Thu, 14 Oct 2021 17:51:22 +0200
Message-ID: <CA+zEjCsFif-pT6aW-XwYiSuLsSbBTWVxme6S2rdSN0oQETnZiA@mail.gmail.com>
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

Hi Adam,

On Tue, Oct 12, 2021 at 12:33 PM Adam Thomson
<Adam.Thomson.Opensource@diasemi.com> wrote:
>
> On 08 October 2021 10:46, Adam Thomson wrote:
>
> > > > Thanks for the info. So we believe, based on the event registers values
> > > > provided, it is the RTC event as that's not cleared by a power-cycle (it's in
> > > > the always-on domain). The other test would be to mask this event
> > > immediately
> > > > after an RTC based reboot and see if the long key-press then shuts down the
> > > > device. I suspect it would in that case, as per you clearing the event.
> > >
> > > Indeed if I mask the RTC alarm in IRQ_MASK_A, the intempestive reboot
> > > disappears. But that's not something we can do: the reset driver will
> > > actually be implemented in openSBI at some point where the devices are
> > > probed on-demand (the same applies to u-boot I think), so we cannot
> > > clear or mask anything at boot.
> > >
> > > >
> > > > I'm still curious as to the 16 seconds though. Would that be when the kernel
> > > > finally starts and masks/clears events (seems quite a long time)?
> > >
> > > No, the kernel is not up yet. Maybe 16sec is not the right value, I
> > > may have been influenced by the discussion here
> > > https://www.dialog-semiconductor.com/products/pmics?post_id=10052#tab-
> > > support_tab_content.
> > >
> > > It seems there is some consensus about having this reset driver be a
> > > SiFive Unmatched board specific thing: quid of the sequence I propose
> > > in this patch then? It does not mess with the RTC registers, it
> > > reboots reliably and there's no intempestive reboot: is it dangerous
> > > to use? Or do you have another alternative?
> >
> > Yes, a board specific implementation would be the way to go. We're just checking
> > through the sequence again to be absolutely sure of any pitfalls that may
> > present themselves, and will get back to you when we have something more.
>
> So having examined your sequence again it's now clearer as to what is happening.
> With the sequence you provided this is only a partial reset whereby all of the
> output rails are sequenced down then up again and restored to OTP voltages.
> However the remainder of the chip settings aren't reset as this isn't a true
> reset of the device going through full reload from OTP, so for example settings
> of regulator mode GPIO states, or IRQ mask bits would persist on the restart,
> which could have implications on system operation.

Ok, it's not perfect but I think those are settings that will get
reinitialized by the corresponding drivers while booting, contrary to
the RTC registers which are clobbered by the other method.

>
> In addition the only bits of interest for you should be:
>
>  - CONTROL_F (0x13)
>         WAKE_UP (BIT 2) = 1
>  - CONTROL_A (0x0E)
>         SYSTEM_EN (BIT 0) = 0
>
> Setting those two bits should be enough to trigger the partial reset sequence.
> The other bits you had in your sequence don't seem to be necessary or relevant.
>
> One final caveat to this approach is that there is a 16s internal timer (as you
> noted before, VDD_START) which is started when the device moves to ACTIVE mode.
> When that 16s timer expires the device will clear the WAKE_UP bit automatically.
> This means there's the outside chance that you could try the reset command
> sequence above around the same time, and that could mean you set the WAKE_UP
> bit, but it's immediately cleared again by this timer expiry before the
> SYSTEM_EN bit is set low. In that case there would be a need for an external
> event (e.g. ONKEY) to kick the system to start again.

Ok, the risk exists but the window is quite small.

After all, the solution I first proposed is not perfect, but now we
know why it works and IMO it has less drawbacks than using the RTC
registers, so I think we should go for this solution. I'll see if I
can help Nikita implement this directly in openSBI.

@Adam Thomson I had migrated the DA9063 device tree bindings to yaml,
I'll push that soon. Thanks for all your help, much appreciated.

Thanks,

Alex
