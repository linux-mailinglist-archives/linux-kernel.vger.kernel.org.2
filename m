Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AFE42D694
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhJNJ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhJNJ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:59:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A4FC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 02:57:20 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p68so3010733iof.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 02:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OZvA6vOCLe0vq1IOFdw9MbIuy04wehYkABusPOOkvWs=;
        b=nj99OwYtQYofo66YE9oGGAlKqR0StH4OFhjgnBjjRxq2BTK0hKdKl+0xq5V4qslSSS
         vK4CecV8dQlgQoKNOlmmgXmQARHrO/R0W5JKOtvGpdJDTq0TL5LYftjAhG4tthO6nYzK
         TgxcSUrmgtR/NkokI1+EOFLoIw5UxFoyT+rCG7bRJ+6dkUU9fEyF8Ss1mqOVueOHLyWe
         HUV03WhwIRM9PKHtgn62irGapZhKVmJz006wMlRGbkn4c0eQX/gHG6IuStGinBVeYgUp
         jFca117fHhpvzir6AvfrJPYX0ZjiIk5Gnhfuho+dA3GZJL7OJsvCBQ7nrhpF/7GJYsgV
         PwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZvA6vOCLe0vq1IOFdw9MbIuy04wehYkABusPOOkvWs=;
        b=WxDN5nO4j102jrIamnO9C9/z47daS4yeHsIeq22DLcLEvmJ+iUUeiYxf76qZ92h/Bq
         Xb0rxBM6vn0aKv8tEWFjMilDhB+rGJIn7/FpFT6cLN+kaJYYoB57sXv3RA38B3PxK6Jk
         ljQ7X4Vpn+pl0ivnxiZHANMPQlaYjfyz7rlH8+4zgaVumwQ6GBKXdgC5lqSyYrHdQYIj
         w8ZEQ1mhBL2xSZx0X8pb3J6U8qbxpjYEO6SjgLXHderq3q2lgEtzAXEWc+1L2YNjXg+y
         iMKp3rrXyF36jzIs9nb/ejN6mpzM1zSy9Pi7JyKbUWvDVYXJmKIF9jYGPgNvau+TxzKD
         hlTg==
X-Gm-Message-State: AOAM533uI95PrcOvO41fi+e7hmp/AM3NeljmGOtpQXRW8TKNEyl1yzOG
        7OJ8xEu1bRtD0rS2a0KXlb8rSjorZm+IHKZXVZk=
X-Google-Smtp-Source: ABdhPJznhuD2wn/mF3MaGPcGhssi4eCHMwzjrwVERh1LZVOOYW30Yd/TVEo1+T7pC10cFF122/4ltVCS9fJ4oOCEkvM=
X-Received: by 2002:a02:2124:: with SMTP id e36mr3327316jaa.35.1634205439528;
 Thu, 14 Oct 2021 02:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMLyx+CvBQbLz-xQvwLS692tx-4xOgU7b-V2J676D29yg@mail.gmail.com>
 <d983217b-e117-361c-0306-b131695bb93f@denx.de> <CAKmqyKOsUcta1cXxamJZnf01G9beCZrDKia068HR+J0AadgNiA@mail.gmail.com>
 <bff9ba97-bc26-f091-ba71-5e639af524d4@denx.de> <CAKmqyKPF3T_Sx+hL=4OSamLdjy=0fwmrTrVeb-GY0Ja9M=mi+Q@mail.gmail.com>
 <ab2b7f4f-3e36-461c-6a6c-02ee7ed6cb99@denx.de> <CAKmqyKN8devNyDvVL5B_dDASU3se1dSui0bsnf6gQ+CkZ_TaKg@mail.gmail.com>
 <YR1Th65KKRS4D/6+@ravnborg.org> <CAKmqyKOBYXiWwO4QJBJ9sEO5ay5QyYmO=yzvT31evB7BKeniYw@mail.gmail.com>
 <YR58MvAYYEjBQ7l5@ravnborg.org> <CAKmqyKOYk=O4ewBcL7hOz+8=gTsNzFb07m_qrNhKq9Bk2ByYrQ@mail.gmail.com>
In-Reply-To: <CAKmqyKOYk=O4ewBcL7hOz+8=gTsNzFb07m_qrNhKq9Bk2ByYrQ@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 14 Oct 2021 19:56:00 +1000
Message-ID: <CAKmqyKP0cxOpD6HnuS5mwKbpoP8npQiMvqZNx91e+UmKUv2gRQ@mail.gmail.com>
Subject: Re: Revert "video: fbdev: mxsfb: Remove driver"
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, b.zolnierkie@samsung.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 8:36 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Fri, Aug 20, 2021 at 1:43 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Alistair,
> >
> > On Thu, Aug 19, 2021 at 07:10:00PM +1000, Alistair Francis wrote:
> > > On Thu, Aug 19, 2021 at 4:38 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> > > >
> > > > Hi Alistair,
> > > >
> > > > >
> > > > > These are the EINVAL strace tells me in the not working case:
> > > > >
> > > > > prctl(PR_CAPBSET_READ, 0x30 /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > > > > prctl(PR_CAPBSET_READ, 0x2c /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > > > > prctl(PR_CAPBSET_READ, 0x2a /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > > > > prctl(PR_CAPBSET_READ, 0x29 /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > > > > ioctl(5, FBIOPUT_VSCREENINFO, 0x4ce8e0) = -1 EINVAL (Invalid argument)
> > > > >
> > > > > I'm guessing it's related to FBIOPUT_VSCREENINFO then, is that
> > > > > something that could be added to the DRM emulation?
> > > >
> > > > If it turns out FBIOPUT_VSCREENINFO is the culprint it would also be
> > > > good to know why we see EINVAL.
> > > > One way is to sprinkle a number of printk's in fb_set_var(),
> > > > then you can see how far you get before it fails.
> > >
> > > Thanks for the help.
> > >
> > > I see this line:
> > >
> > > ret = info->fbops->fb_check_var(var, info);
> > >
> > > in fb_set_var()
> > >
> > > returning early.
> >
> > Super, then next step is to annotate drm_fb_helper_check_var()
> > to see where it fails.
> > Try this and let us know the result.
>
> Thanks!
>
> After adding some prints, I realised there are already some in there
> that are disabled by default. After enabling them I see this:
>
> "fbdev emulation doesn't support changing the pixel clock, value of
> pixclock is ignored"
>
> and
>
> "fb requested width/height/bpp can't fit in current fb request
> 260x1408-32 (virtual 260x23936) > 334x1405-32"
>
> which returns EINVAL.
>
> This is where I'm confused though. The values 334 and 1405 are taken
> from the vendor and in the working fbdev driver they are using the
> same values.
>
> I tried to add a similar print to mxsfb_check_var() for the working
> version, to check what the values are, but there doesn't seem to be
> any equivalent of fb->width and friends.

I dug into this some more.

In the working mxsfb and non-working fbdev emulation the userspace
software sets:

xres: 260
yres: 1408
xres_virtual: 260
yres_virtual: 23936

That passes the old mxsfb_check_var() and works.

While that fails the new fbdev emulation check. Even increasing the
width and height from 334x14085 to 260x23936 doesn't help as I get a
range of other errors and no display. Just removing the check also
doesn't work and results in kernel panics.

It seems there is some difference in handling the resolutions between
the mxsfb driver and the fbdev emulation on the new DRM driver. I'm
just not sure what the difference is.

Alistair
