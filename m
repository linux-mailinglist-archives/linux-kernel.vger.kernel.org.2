Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B049F3EE92F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhHQJJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbhHQJJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:09:36 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B20C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 02:09:03 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id j15so8913790ila.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 02:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKxH25zZecXmbG9wFcitCEqWajfTJHKmnP0GbaZrQbc=;
        b=EJhHr94k+XtTdHgKebg3U/G/FUFrBuFOH08gFD3tUkIG6RsJlTM0I7j+u6bFlDvFqd
         dtzYvi6oUdqA8DHwzFwd3y9lBAmH4TZRoz6C6oRuOr1svPcOJgA/BiJmM8obIT19cFFl
         VbbT4ld5/QOp+phEyNBDSHJ+UYnBxzf1m9rB8n+4S3+A04Dhq8gOU2P0RVI37mvIPku0
         eGltk1oc6yKsFFlrqx3t0ZbTjG6hav3Mh75CriTq6hfUnIsEav+qa/VoVbpxBsdSc6MO
         eHGghhZwASGtZC53btYxTDQDwBdQCY/93LUcUF5EN7RQW6yHUBTCf38QduShc8mE/3hx
         iz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKxH25zZecXmbG9wFcitCEqWajfTJHKmnP0GbaZrQbc=;
        b=EtfwZd0rWeA82eByUmJTmAsFS52j++FhBKqPu5YlczQAZr/Nfp1ODA6MvN2A0vFDLc
         se1PvGXPQ1HMNKIKLeOdbbkUTPtjFUrUqfewx8V8oEAmHwB3K90koBnbyhPVgrVlAc9u
         WpRznU7gRQB4VfMkAjRVuW4b6ZpEV28WpNufBj7KEIgIWiPOyIVI/cHG6kFU3ZmLRZYY
         HU/fn+0k+ATmXs8y0SHO/5tzVrs65Uyol2EAIxjYUIFD5nLtZajzGpR+impu8b4RzVpO
         OthIi1rHtAac92fusmDR9OuONZyddl0qQyMZeVCIN7DhujqcoIsJ7KbSBbbVE8z94WOc
         3YQQ==
X-Gm-Message-State: AOAM532dkht66n15/kD/a8vqSnK4qJ5ORCKcy/Ag3/b8cGDKRG1VcDQH
        VYGvzwKdE1dgat66ZeWdsgf19MpCjpmBzxvK98U=
X-Google-Smtp-Source: ABdhPJyj0DJPGrLYmfVWwudrAHnxjIPdDDekXu/xldqANkpN9eWgGHpPCsthiIgXRCQDExAXynEg0qk37KmBJ+PC/n0=
X-Received: by 2002:a92:6802:: with SMTP id d2mr1685358ilc.40.1629191342878;
 Tue, 17 Aug 2021 02:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMLyx+CvBQbLz-xQvwLS692tx-4xOgU7b-V2J676D29yg@mail.gmail.com>
 <d983217b-e117-361c-0306-b131695bb93f@denx.de> <CAKmqyKOsUcta1cXxamJZnf01G9beCZrDKia068HR+J0AadgNiA@mail.gmail.com>
 <bff9ba97-bc26-f091-ba71-5e639af524d4@denx.de>
In-Reply-To: <bff9ba97-bc26-f091-ba71-5e639af524d4@denx.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 17 Aug 2021 19:08:36 +1000
Message-ID: <CAKmqyKPF3T_Sx+hL=4OSamLdjy=0fwmrTrVeb-GY0Ja9M=mi+Q@mail.gmail.com>
Subject: Re: Revert "video: fbdev: mxsfb: Remove driver"
To:     Marek Vasut <marex@denx.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, b.zolnierkie@samsung.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair@alistair23.me>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 5:55 PM Marek Vasut <marex@denx.de> wrote:
>
> On 8/16/21 9:34 AM, Alistair Francis wrote:
> > On Sun, Aug 15, 2021 at 10:31 PM Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 8/15/21 2:16 PM, Alistair Francis wrote:
> >>> Hello,
> >>>
> >>> Commit f225f1393f034 "video: fbdev: mxsfb: Remove driver" removed the
> >>> mxsfb fbdev driver.
> >>>
> >>> I am now working on getting mainline Linux running on the reMarkable 2
> >>> eInk reader [1]. Unfortunately the rM2 doesn't use the standard EPD
> >>> controller on the i.MX SoC, but instead uses the LCD controller.
> >>>
> >>> eInk panels are complex to control and require writing temperature
> >>> dependent waveforms. As these waveforms are proprietary [2] the rM
> >>> team runs closed source software called SWTCON in userspace to control
> >>> the panel [3].
> >>>
> >>> This closed source software expects the fbdev mxsfb driver and it
> >>> doesn't work with the DRM mxsfb driver (at least not that I can get it
> >>> to).
> >>>
> >>> The NXP fork of Linux also re-adds the fbdev driver [4], so they also
> >>> see some uses for it.
> >>>
> >>> I was wondering if the community would be open to re-adding the fbdev
> >>> mxsfb driver to mainline? It could be re-added with a different
> >>> dt-binding so that it is not used by default and only enabled for
> >>> boards when required (like for the rM2).
> >>>
> >>> 1: https://remarkable.com/store/remarkable-2
> >>> 2: https://goodereader.com/blog/e-paper/e-ink-waveforms-are-a-closely-guarded-secret
> >>> 3: https://remarkablewiki.com/tech/rm2_framebuffer
> >>> 4: https://source.codeaurora.org/external/imx/linux-imx/log/drivers/video/fbdev/mxsfb.c?h=lf-5.10.35-2.0.0
> >>
> >> +CC Sam.
> >>
> >> What sort of special thing does your proprietary userspace do that
> >> cannot be added to the DRM driver or the fbdev emulation (if needed) ?
> >
> > It's hard to tell. When using the DRM driver I get cryptic errors
> > about the frame buffer not being available.
>
> Do you have fbdev emulation enabled ? Does /dev/fbX exist ?

I do and /dev/fb0 exists

>
> What sort of messages do you get and from where ?

This is the error I get:

xochitl[252]: Error writing variable information: Invalid argument...

xochitl is the proprietary userspace code. I don't really have a good
idea of what that error would mean.

I also see this:

Framebuffer has wrong id: "mxcfb"

>
> You could run strace on the application to see how it communicates with
> the old driver via the ioctl interface and compare it with the fbdev
> emulation on the new driver, maybe there is some odd ioctl which is not
> emulated.

I had a quick look at this.

xochitl does a lot more than just controls the display, it interacts
with lots of other hardware and strace produces a lot of logs. I also
don't see the error when manually starting it, only at boot (but it
still doesn't work).

A quick run with

strace -f xochitcl

and I don't even see an access to /dev/fb0, so I'm not sure where the
accesses are coming from.

Alistair

>
> There is also NXP 5.10.35 fork, so you could try picking the fbdev
> driver from there and add printks/trace_printks/etc. into both that and
> the fbdev emulation code, to see whether how either is called and what
> is failing/missing in the emulation.
>
> > It's difficult to know
> > what is going on as I don't have access to any of the source. I
> > suspect the userspace code could be updated to use the DRM driver, but
> > we would need the reMarkable devs to do that.
> >
> > There is some effort to re-implement the proprietary user space swtcon
> > (https://github.com/timower/rM2-stuff#swtcon), but it seems to have
> > stalled. It wouldn't be impossible to get swtcon to work with the DRM
> > driver, but it would require a very large amount of reverse
> > engineering, that probably will never happen.
> >
> > I wanted to see what the thoughts were on re-adding the fbdev mxsfb
> > driver. The commit message just says that because there is a DRM
> > driver we no longer need the fbdev one, but here is a case for the
> > fbdev driver. I was thinking that continuing to support the fbdev
> > mxsfb driver wouldn't be too much of a maintenance burden (but that's
> > obviously up to you). The NXP tree also seems to think the fbdev
> > driver is worth keeping around.
>
> I don't think the NXP tree is a particularly good example of best
> practice, they don't use the mxsfb in the first place, they wrote their
> own DRM driver for the LCDIF IP, and they also keep the fbdev driver
> around, so yes, they have three drivers for the same IP in different
> state of decay and with different problems, instead of one driver that
> has all the functionality and fixes. Sigh ...
>
> I cannot decide on the fbdev thing, that's I think up to Sam. However,
> my suggestion would be to find out what is missing in the fbdev
> emulation and possibly fill that in, so we will have only one driver to
> support all the functionality.
