Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F5435F76
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhJUKpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJUKpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:45:32 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949C6C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:43:16 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z69so221035iof.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sqFYM8Y8N+0n85VDv0lIm7lzRUiiR+pxeNMgLYx3XGI=;
        b=HCLh1LVhEg80yCpmFvHC2H9/lSdxQq0fIeOMRXUENuTd72vgGfRLWXdmyjizyUkeqX
         b3E68OOV64nmPnshhYHrbBPCNVNd8zKNIcf1BVYxOEnt38xuFvHLUpLxFP5ieE3pIy0Q
         FHp/kVNb1ezrvFVinQVg+/SZp76ZKiCAdGfUGnJKGieRz47Hfamy4DpdX3Fk1KllQwy1
         k5w06O5NJeJvcrF/hkpFJ1lzu/saQfDhevuCTh626HhQdfgE9vLyWkq7L9A6HdKT3b26
         s/ZyOjrnwBGnpcLzn8iSlmUbhzYTCHIS1/6FyIpiEHkTP5ts7+6Mn0xmtuPuEP/MgmcL
         Ib3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqFYM8Y8N+0n85VDv0lIm7lzRUiiR+pxeNMgLYx3XGI=;
        b=qPJ3ShqOYp+mJFatS1SPQH1qwRmbRGG4uUnjUQCyufVDY9iRXMnn8NslHO34lhrIat
         WtUwJL3kuLSe04SvfPzh0kpKkzLg8YJSmLFqt2b6Y8Hsrvdy62AuaEJGFmGrNhf0xgeX
         Pz2RbzCCng79VRMN23s4jiDHEjxTgzt/rij2iV0xZptEHPgdSSUD7T570dgqbzrglP45
         UTizah5PP7pqxFnOR7NY7UPV4+fa/njHgLoDnybpzSL0lFydBd9pchIGqTSQRPNzqz0V
         YAH3fZSBCeRoWzOzkQf0WS4YGk76597pZhF0UGHqVgUs949qDxZqcvI4mbpjiSX1tqcs
         1Bhg==
X-Gm-Message-State: AOAM5302Y/1mDmhsuvLrgj91QhPnllG2b9N9NypFC04uFvWQWlDF8vTw
        w3B13ZrFkYCGxJSxRThUu8NdXadxSIADGt4T0fw=
X-Google-Smtp-Source: ABdhPJwEH7Ag2EuI9mT6D4ecxbvITbrJVe4CQaEedvUwxRV5CKXD/ooNhYs33VvnAXvdg6kEQQFHadkVX/KKWOAb8pk=
X-Received: by 2002:a02:a786:: with SMTP id e6mr3189681jaj.117.1634812996041;
 Thu, 21 Oct 2021 03:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMLyx+CvBQbLz-xQvwLS692tx-4xOgU7b-V2J676D29yg@mail.gmail.com>
 <d983217b-e117-361c-0306-b131695bb93f@denx.de> <CAKmqyKOsUcta1cXxamJZnf01G9beCZrDKia068HR+J0AadgNiA@mail.gmail.com>
 <bff9ba97-bc26-f091-ba71-5e639af524d4@denx.de> <CAKmqyKPF3T_Sx+hL=4OSamLdjy=0fwmrTrVeb-GY0Ja9M=mi+Q@mail.gmail.com>
 <ab2b7f4f-3e36-461c-6a6c-02ee7ed6cb99@denx.de> <CAKmqyKN8devNyDvVL5B_dDASU3se1dSui0bsnf6gQ+CkZ_TaKg@mail.gmail.com>
 <YR1Th65KKRS4D/6+@ravnborg.org> <CAKmqyKOBYXiWwO4QJBJ9sEO5ay5QyYmO=yzvT31evB7BKeniYw@mail.gmail.com>
 <YR58MvAYYEjBQ7l5@ravnborg.org> <CAKmqyKOYk=O4ewBcL7hOz+8=gTsNzFb07m_qrNhKq9Bk2ByYrQ@mail.gmail.com>
 <CAKmqyKP0cxOpD6HnuS5mwKbpoP8npQiMvqZNx91e+UmKUv2gRQ@mail.gmail.com>
In-Reply-To: <CAKmqyKP0cxOpD6HnuS5mwKbpoP8npQiMvqZNx91e+UmKUv2gRQ@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 21 Oct 2021 20:42:49 +1000
Message-ID: <CAKmqyKPCP45O5_gjCFwUs8jU4NrDnjAeLs7OYAE4j-LEUw+Hzg@mail.gmail.com>
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

On Thu, Oct 14, 2021 at 7:56 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Fri, Aug 20, 2021 at 8:36 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Fri, Aug 20, 2021 at 1:43 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > > Hi Alistair,
> > >
> > > On Thu, Aug 19, 2021 at 07:10:00PM +1000, Alistair Francis wrote:
> > > > On Thu, Aug 19, 2021 at 4:38 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> > > > >
> > > > > Hi Alistair,
> > > > >
> > > > > >
> > > > > > These are the EINVAL strace tells me in the not working case:
> > > > > >
> > > > > > prctl(PR_CAPBSET_READ, 0x30 /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > > > > > prctl(PR_CAPBSET_READ, 0x2c /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > > > > > prctl(PR_CAPBSET_READ, 0x2a /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > > > > > prctl(PR_CAPBSET_READ, 0x29 /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > > > > > ioctl(5, FBIOPUT_VSCREENINFO, 0x4ce8e0) = -1 EINVAL (Invalid argument)
> > > > > >
> > > > > > I'm guessing it's related to FBIOPUT_VSCREENINFO then, is that
> > > > > > something that could be added to the DRM emulation?
> > > > >
> > > > > If it turns out FBIOPUT_VSCREENINFO is the culprint it would also be
> > > > > good to know why we see EINVAL.
> > > > > One way is to sprinkle a number of printk's in fb_set_var(),
> > > > > then you can see how far you get before it fails.
> > > >
> > > > Thanks for the help.
> > > >
> > > > I see this line:
> > > >
> > > > ret = info->fbops->fb_check_var(var, info);
> > > >
> > > > in fb_set_var()
> > > >
> > > > returning early.
> > >
> > > Super, then next step is to annotate drm_fb_helper_check_var()
> > > to see where it fails.
> > > Try this and let us know the result.
> >
> > Thanks!
> >
> > After adding some prints, I realised there are already some in there
> > that are disabled by default. After enabling them I see this:
> >
> > "fbdev emulation doesn't support changing the pixel clock, value of
> > pixclock is ignored"
> >
> > and
> >
> > "fb requested width/height/bpp can't fit in current fb request
> > 260x1408-32 (virtual 260x23936) > 334x1405-32"
> >
> > which returns EINVAL.
> >
> > This is where I'm confused though. The values 334 and 1405 are taken
> > from the vendor and in the working fbdev driver they are using the
> > same values.
> >
> > I tried to add a similar print to mxsfb_check_var() for the working
> > version, to check what the values are, but there doesn't seem to be
> > any equivalent of fb->width and friends.
>
> I dug into this some more.
>
> In the working mxsfb and non-working fbdev emulation the userspace
> software sets:
>
> xres: 260
> yres: 1408
> xres_virtual: 260
> yres_virtual: 23936
>
> That passes the old mxsfb_check_var() and works.
>
> While that fails the new fbdev emulation check. Even increasing the
> width and height from 334x14085 to 260x23936 doesn't help as I get a
> range of other errors and no display. Just removing the check also
> doesn't work and results in kernel panics.
>
> It seems there is some difference in handling the resolutions between
> the mxsfb driver and the fbdev emulation on the new DRM driver. I'm
> just not sure what the difference is.

There is some progress to reverse engineer the userspace code, this is
the call that is failing:
https://github.com/matteodelabre/waved/blob/main/src/display.cpp#L628
. The values being passed in are set above:
https://github.com/matteodelabre/waved/blob/main/src/display.cpp#L118
. The code is setting a virtual y_res based on 17 frames.

The comment in drm_fb_helper.c::drm_fb_helper_check_var(), "Changes
struct fb_var_screeninfo are currently not pushed back to KMS, hence
fail if different settings are requested." probably sums up the issue.
It seems like the FB emulation doesn't support the number of frames.

I don't have a good idea of if this could be done with the emulation
though, or if re-adding the mxsfb driver is the better option.

>
> Alistair
