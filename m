Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA5D3EEC43
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 14:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhHQMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 08:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbhHQMRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 08:17:14 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFC9C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 05:16:41 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z1so3209814ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 05:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wefpxcHaurBW7M5LFNFrZAtpgBOixxlnwNY64544D/U=;
        b=Swx9iRFfeZ6MiwAQx6u/BshU1w2spO29F7zo/5L5JXhxy4SzmtBdkDi3nKAnm8w0vi
         8ZDDcTL2uONb/o50GwteP/PipJJk7f8jAhvdC7m6ukm6uItJIlYapPS7o8z8hyQL59EE
         5zbWsvUNYHQT0R7bN3Aj6zMoTCq4/pLUQ2aXE/C8xarGsyksyYG76ZfuOGeK9tV6if4V
         q0jp060H/YWPdsw3taHZQrYh8ERRcNi0SpR3j/CZDh9pD9j1kMx+M8Q521qbHgdtUfdP
         WWl5+1YZ5xU4SDCCV2v78H4kfhFrttvEDZ1EW9vaNwclL5ANh3vHl26E7lgI/1nxbKWN
         dyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wefpxcHaurBW7M5LFNFrZAtpgBOixxlnwNY64544D/U=;
        b=D03br12Lg4p+QgGiWe5LSqorUxNK1PQs25ku8DM1HehkVdxuMysaPm+qLSli9ISSfm
         LuaN5nuoG2rTzV9lcifpAyB7SndHMa2OfVFL8hJD3TkdSWGaI6ZIT4U1v0BvUvKJehEq
         gg4BfXeDwzwir4KF02SnpJnWwDrEaF48wuOPEJzKWD8ZXBfS8lmgkjI+wHBvNyMFog2x
         4EpbmJaQPTY2wk3pXDgAF79wob1BHQf1LTwTfnq8B3OIxvhLZQQmfdUFJcbw5465dCii
         JQ9yujOXhPm0BvqcMaLflthP7jj74mDG1RuZfTQtOt4x++b1ceJN+o9cga7EAxTbYMJr
         dyjw==
X-Gm-Message-State: AOAM532x91mRDxXLi8TxjS8cc/d0E8ZiwhnS+3ZbTKo4uwKAHCFhtDYq
        ie2yFYYlJKMRD9NVp9vNN2MG2SsqBQzLw+jtsI8=
X-Google-Smtp-Source: ABdhPJzNU4C2dbPk37TIF0X0U49RX2wXrhaPDKEoK5+xERMjzjlc+EIOP+mcwnhftQUW7Q6sdBv1sYbWESrZrDOPTfE=
X-Received: by 2002:a5d:8541:: with SMTP id b1mr2660137ios.105.1629202600822;
 Tue, 17 Aug 2021 05:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMLyx+CvBQbLz-xQvwLS692tx-4xOgU7b-V2J676D29yg@mail.gmail.com>
 <d983217b-e117-361c-0306-b131695bb93f@denx.de> <CAKmqyKOsUcta1cXxamJZnf01G9beCZrDKia068HR+J0AadgNiA@mail.gmail.com>
 <bff9ba97-bc26-f091-ba71-5e639af524d4@denx.de> <CAKmqyKPF3T_Sx+hL=4OSamLdjy=0fwmrTrVeb-GY0Ja9M=mi+Q@mail.gmail.com>
 <ab2b7f4f-3e36-461c-6a6c-02ee7ed6cb99@denx.de>
In-Reply-To: <ab2b7f4f-3e36-461c-6a6c-02ee7ed6cb99@denx.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 17 Aug 2021 22:16:14 +1000
Message-ID: <CAKmqyKN8devNyDvVL5B_dDASU3se1dSui0bsnf6gQ+CkZ_TaKg@mail.gmail.com>
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

On Tue, Aug 17, 2021 at 8:03 PM Marek Vasut <marex@denx.de> wrote:
>
> On 8/17/21 11:08 AM, Alistair Francis wrote:
> > On Mon, Aug 16, 2021 at 5:55 PM Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 8/16/21 9:34 AM, Alistair Francis wrote:
> >>> On Sun, Aug 15, 2021 at 10:31 PM Marek Vasut <marex@denx.de> wrote:
> >>>>
> >>>> On 8/15/21 2:16 PM, Alistair Francis wrote:
> >>>>> Hello,
> >>>>>
> >>>>> Commit f225f1393f034 "video: fbdev: mxsfb: Remove driver" removed the
> >>>>> mxsfb fbdev driver.
> >>>>>
> >>>>> I am now working on getting mainline Linux running on the reMarkable 2
> >>>>> eInk reader [1]. Unfortunately the rM2 doesn't use the standard EPD
> >>>>> controller on the i.MX SoC, but instead uses the LCD controller.
> >>>>>
> >>>>> eInk panels are complex to control and require writing temperature
> >>>>> dependent waveforms. As these waveforms are proprietary [2] the rM
> >>>>> team runs closed source software called SWTCON in userspace to control
> >>>>> the panel [3].
> >>>>>
> >>>>> This closed source software expects the fbdev mxsfb driver and it
> >>>>> doesn't work with the DRM mxsfb driver (at least not that I can get it
> >>>>> to).
> >>>>>
> >>>>> The NXP fork of Linux also re-adds the fbdev driver [4], so they also
> >>>>> see some uses for it.
> >>>>>
> >>>>> I was wondering if the community would be open to re-adding the fbdev
> >>>>> mxsfb driver to mainline? It could be re-added with a different
> >>>>> dt-binding so that it is not used by default and only enabled for
> >>>>> boards when required (like for the rM2).
> >>>>>
> >>>>> 1: https://remarkable.com/store/remarkable-2
> >>>>> 2: https://goodereader.com/blog/e-paper/e-ink-waveforms-are-a-closely-guarded-secret
> >>>>> 3: https://remarkablewiki.com/tech/rm2_framebuffer
> >>>>> 4: https://source.codeaurora.org/external/imx/linux-imx/log/drivers/video/fbdev/mxsfb.c?h=lf-5.10.35-2.0.0
> >>>>
> >>>> +CC Sam.
> >>>>
> >>>> What sort of special thing does your proprietary userspace do that
> >>>> cannot be added to the DRM driver or the fbdev emulation (if needed) ?
> >>>
> >>> It's hard to tell. When using the DRM driver I get cryptic errors
> >>> about the frame buffer not being available.
> >>
> >> Do you have fbdev emulation enabled ? Does /dev/fbX exist ?
> >
> > I do and /dev/fb0 exists
> >
> >>
> >> What sort of messages do you get and from where ?
> >
> > This is the error I get:
> >
> > xochitl[252]: Error writing variable information: Invalid argument...
>
> Some ioctl returns -EINVAL maybe ? strace would tell you.

Ok, good progress. When xochitl works or doesn't work I see this for
strace accesses:

```
openat(AT_FDCWD, "/dev/fb0", O_RDWR) = 5
```

That's the only access for both the working case or the non-working case.

The actual application provides this log for the not working case
(where it then hangs)

```
/usr/bin/xochitl --system
10:53.013 default                  2021-06-11T11:42:05Z
heads/releases/bertwhistle 264f47ba0 (int main(int, char**)
/usr/src/debug/xochitl/override+gitAUTOINC+264f47ba03-r0/git/src/main.cpp:294)
Registering exit handlers
10:53.018 default                  we're running on an epaper device
(int main(int, char**)
/usr/src/debug/xochitl/override+gitAUTOINC+264f47ba03-r0/git/src/main.cpp:301)
Reading waveforms from
/usr/share/remarkable/320_R349_AF0411_ED103TC2U2_VB3300-KCD_TC.wbf
Error writing variable information: Invalid argument
```

These are the EINVAL strace tells me in the not working case:

prctl(PR_CAPBSET_READ, 0x30 /* CAP_??? */) = -1 EINVAL (Invalid argument)
prctl(PR_CAPBSET_READ, 0x2c /* CAP_??? */) = -1 EINVAL (Invalid argument)
prctl(PR_CAPBSET_READ, 0x2a /* CAP_??? */) = -1 EINVAL (Invalid argument)
prctl(PR_CAPBSET_READ, 0x29 /* CAP_??? */) = -1 EINVAL (Invalid argument)
ioctl(5, FBIOPUT_VSCREENINFO, 0x4ce8e0) = -1 EINVAL (Invalid argument)

I'm guessing it's related to FBIOPUT_VSCREENINFO then, is that
something that could be added to the DRM emulation?

>
> > xochitl is the proprietary userspace code. I don't really have a good
> > idea of what that error would mean.
> >
> > I also see this:
> >
> > Framebuffer has wrong id: "mxcfb"
>
> Are you sure you're not confusing mxcfb (The freescale imx scanout
> engine) with mxsfb (The originally sgtl block, bought by freescale) ?

This is the full commit that gets everything working for me:
https://github.com/alistair23/linux/commit/ee0e684e3d776c6de98b6491d1a87d8305c44734

It includes mxcfb, but I think that is just to allow the mxsfb to compile.

>
> >> You could run strace on the application to see how it communicates with
> >> the old driver via the ioctl interface and compare it with the fbdev
> >> emulation on the new driver, maybe there is some odd ioctl which is not
> >> emulated.
> >
> > I had a quick look at this.
> >
> > xochitl does a lot more than just controls the display, it interacts
> > with lots of other hardware and strace produces a lot of logs. I also
> > don't see the error when manually starting it, only at boot (but it
> > still doesn't work).
> >
> > A quick run with
> >
> > strace -f xochitcl
> >
> > and I don't even see an access to /dev/fb0, so I'm not sure where the
> > accesses are coming from.
>
> You can try writing the output of strace to file (strace -o) for easier
> analysis. Then grep for either access to /dev/fb0 (or any symlink to it
> which might exist), or search for the mxcfb string, maybe the
> application aborts even before opening the fbdev due to some other problem.

Thanks, I figured out there was a script that I was running instead. I
can now see the /dev/fb0 access.


Alistair
