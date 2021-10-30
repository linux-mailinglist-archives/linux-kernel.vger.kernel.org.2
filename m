Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799FC440B76
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 21:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhJ3T2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 15:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhJ3T2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 15:28:09 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022DFC061764
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 12:25:38 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id ay21so4011301uab.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 12:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=339YdMyvVlDQzR8qX4adflLjle+i81v+0067miTPm1A=;
        b=mlopcJSMuv/TwW2eeNNhbqVn+nWVcVCFBP7c7SKby7EOWQEJ22+cniUdI5MMoozh4A
         JdHWCFCt61kBs2L8iDz/iFyCZJA9VoJgZz9/3hd85oERXB9AiwekDUcpzKueXxLPHGeZ
         G4zJC5mDv8H3+YaeM6RqiGI281IopVjSV6HklZ2ivxugcUmbw8tzV7Q/3ndiy7B79YwU
         7sAWwk5fTMgcs/ZjzWLnQAwh2PGq/LrDu1AyAMVY/yslMUZN6vA66yKHYff6JVgnv1+N
         qnADt1ZgxFpH7BGcu8kk194YbwifwrgmaCAkzCUi+rBweHCXwbm9Q9eY4TsUMg0ivLTR
         SYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=339YdMyvVlDQzR8qX4adflLjle+i81v+0067miTPm1A=;
        b=H7JEILF+CLBZCm6A6Dp98ql2oKvQ9yuQdgPNhNqtuJM8leM0KqKezHRsTtRvDRd1og
         fYEnoMacI1hin9eLwgyzLmaomNFQ2ukaBHHDBZM4Yq7Q7PqdOfrUPNxtIZSMJpTStpqn
         DBcbRxD2A9J3hBsneYpkhfYhgcEFacZvA9Cm3oiw2gy71uTRSoDWi3kx5IycjOlIGI/s
         VGpFfjwCusz8i0WS1B+kF+v+9V0wkk5tdfwDPWN4INC/egFMN2U+4H+9lraZMb5F2SBR
         fC6TuYrWHpYQsW1BeTTKd8DAn+kAGGuUOWvAWcr7D8fbhFZEfp6HiYYNmjsQaL4ckf2F
         TR/Q==
X-Gm-Message-State: AOAM532MiBCKfeeGjzY06BaWPwy7kaRYtiOgBd8roBY8+M7c+tAlF3/o
        MO9ZkDOyTpD/cPkECqK4ruEqKKVhYr5jsnRrHFBAJA==
X-Google-Smtp-Source: ABdhPJyFqdbXGPdxZ+9SomWA4bSCJ4RbHSRY8COcLw1K8qg6dICkUgpDvyeiNab2g+uE9/e36w8DQGJ9EyaaaD+IE/8=
X-Received: by 2002:a05:6102:3ece:: with SMTP id n14mr2627951vsv.55.1635621937941;
 Sat, 30 Oct 2021 12:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211028183527.3050-1-semen.protsenko@linaro.org>
 <20211028183527.3050-8-semen.protsenko@linaro.org> <1ad6b625-4388-bc78-e258-eae0b9357b96@roeck-us.net>
 <CAPLW+4kphtac24fcpVUENAMUAdHp2fkzJ0N_r_63Soq6R2VZBg@mail.gmail.com>
 <7c9a8dd4-7607-55a2-3d65-a445fa246667@roeck-us.net> <CAPLW+4kTANfSaw5g=rnJUJTMcT_J1Z8ju09kzmAPE70U_8KWDQ@mail.gmail.com>
 <d07b0269-acff-b267-b90a-732502978712@roeck-us.net>
In-Reply-To: <d07b0269-acff-b267-b90a-732502978712@roeck-us.net>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sat, 30 Oct 2021 22:25:25 +0300
Message-ID: <CAPLW+4kRLtP-esSeNOwJFDpW8puoA3mNPbZWi-tcRz6tjmiQDQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] watchdog: s3c2410: Let kernel kick watchdog
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2021 at 20:47, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 10/30/21 9:59 AM, Sam Protsenko wrote:
> > On Sat, 30 Oct 2021 at 18:14, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 10/30/21 7:29 AM, Sam Protsenko wrote:
> >>> On Fri, 29 Oct 2021 at 03:30, Guenter Roeck <linux@roeck-us.net> wrote:
> >>>>
> >>>> On 10/28/21 11:35 AM, Sam Protsenko wrote:
> >>>>> When "tmr_atboot" module param is set, the watchdog is started in
> >>>>> driver's probe. In that case, also set WDOG_HW_RUNNING bit to let
> >>>>> watchdog core driver know it's running. This way wathcdog core can kick
> >>>>> the watchdog for us (if CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED option is
> >>>>> enabled), until user space takes control.
> >>>>>
> >>>>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> >>>>> ---
> >>>>>     drivers/watchdog/s3c2410_wdt.c | 26 +++++++++++++++-----------
> >>>>>     1 file changed, 15 insertions(+), 11 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> >>>>> index ca082b1226e3..9af014ff1468 100644
> >>>>> --- a/drivers/watchdog/s3c2410_wdt.c
> >>>>> +++ b/drivers/watchdog/s3c2410_wdt.c
> >>>>> @@ -732,6 +732,21 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> >>>>>         wdt->wdt_device.bootstatus = s3c2410wdt_get_bootstatus(wdt);
> >>>>>         wdt->wdt_device.parent = dev;
> >>>>>
> >>>>> +     /*
> >>>>> +      * If "tmr_atboot" param is non-zero, start the watchdog right now. Also
> >>>>> +      * set WDOG_HW_RUNNING bit, so that watchdog core can kick the watchdog.
> >>>>> +      *
> >>>>> +      * If we're not enabling the watchdog, then ensure it is disabled if it
> >>>>> +      * has been left running from the bootloader or other source.
> >>>>> +      */
> >>>>> +     if (tmr_atboot && started == 0) {
> >>>>> +             dev_info(dev, "starting watchdog timer\n");
> >>>>> +             s3c2410wdt_start(&wdt->wdt_device);
> >>>>> +             set_bit(WDOG_HW_RUNNING, &wdt->wdt_device.status);
> >>>>> +     } else if (!tmr_atboot) {
> >>>>> +             s3c2410wdt_stop(&wdt->wdt_device);
> >>>>> +     }
> >>>>> +
> >>>>
> >>>> This doesn't cover the case where the watchdog is already enabled by the BIOS.
> >>>> In that case, WDOG_HW_RUNNING won't be set, and the watchdog will time out
> >>>> if the userspace handler is not loaded fast enough. The code should consistently
> >>>> set WDOG_HW_RUNNING if the watchdog is running.
> >>>>
> >>>
> >>> As I understand, in the case when bootloader started the watchdog, the
> >>> driver just stops it. You can see it in the code you replied to.
> >>>
> >>>       } else if (!tmr_atboot) {
> >>>               s3c2410wdt_stop(&wdt->wdt_device);
> >>>
> >>> In other words, having "tmr_atboot" module param makes it irrelevant
> >>> whether bootloader enabled WDT or no.
> >>>
> >>
> >> Sure, but I am concerned about "if (tmr_atboot && started)", which doesn't
> >> set WDOG_HW_RUNNING with your current code, and I was looking for something
> >> like
> >>
> >>          if (tmr_atboot) {
> >>                  if (!started) {
> >>                          dev_info(dev, "starting watchdog timer\n");
> >>                          s3c2410wdt_start(&wdt->wdt_device);
> >>                  }
> >>                  set_bit(WDOG_HW_RUNNING, &wdt->wdt_device.status);
> >>          } else {
> >>                  s3c2410wdt_stop(&wdt->wdt_device);
> >>          }
> >>
> >
> > Wow, I really overlooked that case. Nice catch! Not having '} else {'
> > section is vicious...
> >
> > Though if started != 0, it means s3c2410wdt_set_heartbeat() failed to
> > set wdd->timeout, and without that the watchdog core won't be able to
> > calculate correctly ping interval in watchdog_next_keepalive(), and
> > WDOG_HW_RUNNING bit won't do much good, right? So I'll probably just
> > call s3c2410wdt_stop() in that case, to be on the safe side.
> >
> > Also this 'started' variable name is misleading, I'll convert it to
> > "bool timeout_ok" while at it.
> >
>
> This driver is a mess :-(. "started" true means that the driver doesn't
> work as currently written because there is no known valid timeout. In
> reality, s3c2410wdt_set_heartbeat() should in that case select a valid
> timeout and set it. On top of that, a timeout value out of range should
> never be passed to it in the first place. The check for "if (timeout < 1)"
> is, in that context, pointless. The range check should happen in
> s3c2410wdt_max_timeout(). If that range check is invalid, ie if
> s3c2410wdt_set_heartbeat() fails even though the timeout is in the range
> of 1 ..s3c2410wdt_max_timeout(), s3c2410wdt_max_timeout() is buggy.
>
> The simplest fix (kludge/hack) might be to fail driver installation if
> s3c2410wdt_set_heartbeat() fails.
>

Thanks for suggesting that. I'll send that change along in v2.

> Guenter
