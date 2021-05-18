Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E55387659
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348425AbhERKXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241324AbhERKXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:23:30 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEC7C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:22:03 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s19so9283495oic.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgNCqOV/CCOI6J9GnT06cA7Lm5fHc8EXs726Iu9SFXk=;
        b=Und6DTmi6+JC8lyxtMMrolCO0VskVsOgl8v6ggSH6G/57bx/ac6noLLWv5XeohAOAY
         WwF385Q3GgXU6Cl9KXVtQwgSusACUY0qHHGv8KepyTGXjqwxJZIUKQ8WszfWZmgaP8DR
         8XvFXB0idW5GiH8j6ATyz4fpZkBseTrxorgtmNanGdT5jMJsUwUMF7ALmLRkEo+2yA2Z
         DesCVLoJDgXLC/GELALn+au9MY/9dw3gCkVxLxjC7e7YOkjhP1yoMgHeB/g0qY55tr1S
         aBMZmn5dSvYdcuZuMyUV2Qe+CfPhOmNsEciYHUxPzq0HVLAecwnhenvFuh3x1C3V+f/T
         rzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgNCqOV/CCOI6J9GnT06cA7Lm5fHc8EXs726Iu9SFXk=;
        b=ixwC72Znrsa7fidjF9ttWJD8bzFbbWiZ3nB3tYpT37xaM9O9Yk6HiWQqKtRI3eh79u
         ODN/DlG/nSuwPJaZgM+XOm8IRJWO5Mf6qyBNUC+5V2enQypBGrwcBDvF9Ki+ynHKRTsy
         ipLXDMcjLXkB5l34ZsSKEkSHVLRC/GuRScBVA89LzNTMs4NjgWH0loVEJv625c6jNIsT
         vlqCP5ax695zT52WVgaPRfPghQp9mV2y28Kdi2ORgOhUmaYHn0tBYNTf2+r/mePe0Kzx
         qCLCndOU165MDvyIPTJajS+rAvVqMbUh1p9lrjSpjURuJ7wa+v9N/PJyKL2/RWDV4TRH
         RT3Q==
X-Gm-Message-State: AOAM5318lqHeTUJcp8KRMRsWbG4/nI1ImCSsntcCad/RiwyJzdAtGfrd
        /psLXWhJkgPrOgNbAGKjwzcLnOaFWQtLBEbrv3ssIQ==
X-Google-Smtp-Source: ABdhPJzyyOqu1Vri3RDwKBVk41z58dRYRW0SLb+miIEQYLjkfUt4XbZdQ9c0p1CmvKk9C0xn+XyVaSKg9woVvLQVAio=
X-Received: by 2002:aca:dc07:: with SMTP id t7mr2911154oig.164.1621333323192;
 Tue, 18 May 2021 03:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210516135531.2203-1-dariobin@libero.it> <20210516135531.2203-2-dariobin@libero.it>
 <CAHp75Vd8875hRNk1JK6gkmfxjqxBSu4cRNE1zJt9TyEW7TvsMg@mail.gmail.com>
 <20210517225713.GB2936462@x1> <960608833.161310.1621330718253@mail1.libero.it>
In-Reply-To: <960608833.161310.1621330718253@mail1.libero.it>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Tue, 18 May 2021 03:21:52 -0700
Message-ID: <CAPgEAj42Dvb=qHvViEMz4Uy0V0Ted5GCojLua0pVn4hZ850AGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: core: configure pinmux from pins debug file
To:     Dario Binacchi <dariobin@libero.it>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 2:38 AM Dario Binacchi <dariobin@libero.it> wrote:
>
> Hi,
>
> > Il 18/05/2021 00:57 Drew Fustini <drew@beagleboard.org> ha scritto:
> >
> >
> > On Mon, May 17, 2021 at 11:02:00PM +0300, Andy Shevchenko wrote:
> > > On Sun, May 16, 2021 at 7:43 PM Dario Binacchi <dariobin@libero.it> wrote:
> > > >
> > > > The MPUs of some architectures (e.g AM335x) must be in privileged
> > > > operating mode to write on the pinmux
> > >
> > > pinmux is not pin configuration. You need to rethink the approach.
> > >
> > > > registers. In such cases, where
> > > > writes will not work from user space, now it can be done from the pins
> > > > debug file if the platform driver exports the pin_dbg_set() helper among
> > > > the registered operations.
> > >
> > > Drew, is it similar to what you are trying to achieve?
> >
> > Yes, I would say this similar to what I was trying to accomplish: being
> > able to change contents of conf_<module>_<pin> register [table 9-60]
> > from userspace.
> >
> > However, I was specifically looking to change bits 2:0 which is mux
> > mode. My motivation was to allow BeagleBone users to easily switch
> > between pin functions on the expansion headers during runtime to make
> > rapid prototyping with a breadboard easier (such as changing header pin
> > from GPIO to SPI mode). Most of the header pins have 7 different modes.
> >
> > Ultimately, the solution I settled on with feedback from this list was
> > to create pinmux-select debugfs file that can activate desired fucntion:
> > 6199f6becc86 ("pinctrl: pinmux: Add pinmux-select debugfs file")
> >
> > Bits 6:3 are related to what this subsystem would refer to as pin conf
> > such as slew, input enable and bias. Thus it might make sense to expose
> > something like a select-pinconf file to activate pin conf settings from
> > userspace. This would require using 'pinconf-single' compatible.
> >
> > I fixed pinctrl-single bug regarding pinconf last year so it should be
> > possible to use 'pinconf-single' compatible for the am33xx_pinmux node:
> > f46fe79ff1b6 ("pinctrl-single: fix pcs_parse_pinconf() return value")
> >
>
> In the kernel version 4.1.6 that I am using on my custom board, I have fixed
> the commit f07512e615dd ("pinctrl/pinconfig: add debug interface"). However,
> this feature was later removed (https://lore.kernel.org/patchwork/patch/1033755/).
> Do you think it is better to bring that functionality back to life or the submitted
> patch could be fine too?

Wow, I had no idea there used to be a pinconf-config debugfs file.  I
would have been interested in using it if it had still existed.

Regarding your patch, I think it could be helpful to be able to set
the conf_<module>_<pin> registers directly through debugfs as I can
imagine situations where it would be useful for testing.  It is a bit
dangerous as the person using it has to be careful not to change the
wrong bits, but they would need to have debugfs mounted and
permissions to write to it.   I suppose it depends on what others
maintainers like Linus and Tony think about whether that is an
acceptable solution.

thanks,
drew
