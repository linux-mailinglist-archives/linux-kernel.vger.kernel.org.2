Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C6A3F2340
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbhHSWh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 18:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhHSWhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:37:52 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375D5C061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:37:16 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id f6so2195537iox.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x86VEtZPwcNzHTJFuuZe3E742jzfGtY+fmIoJA+GPhU=;
        b=Kk0n9V9sOWJDIqbsh70A/BdzKh/8qPeQZDe0zE/SzbUUETbQoGRU+jK71pTekZV9zI
         bky7Ld2xeDRW+DQ4omevsugaoC9ZnHAKKn6kN2GQcZZbyJBL8MJgssFWlxmnEej8+ztP
         SlN/fF0BqrZ3zWZU/9vr7nv5Q65uS41N44pR7FhjoeEJWsYKfhFrp+Aq1wT+okvmYUSI
         q1F84pr36rSZCQ3+sU24frVZ8jJxMAtx+iQtFTVDGJyPPctdqVGrjadJeBfi+6muENH5
         NLMoSqHh1rEst3lkueysLr006KrFN2PWDjqP+0OvqPhCPbV1lbDgefpkIbp7cNPmnGQI
         J2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x86VEtZPwcNzHTJFuuZe3E742jzfGtY+fmIoJA+GPhU=;
        b=uGF6fAvF4P0QTpo3vf+LuBKhFwb2gqhKCLVGaIl2Eyd5EyrUmI7JK9qRgT8nG4pyt0
         gD0Dkc9RqSTFyjpWw8JMCjnWwV59isDjjWi0bxrEv/CEja8MLLR1D9UCqhPZIDLzXWaS
         7x56JhkQbICXzEnS5Aidq7QY6RLO5gyY7IdO3NLjUTyMzf/uk4UtZ2f2xWwKI1tWHDgk
         YrKxeAHVSoeh720DHGmuwyKZW0DAkOJ6Bq0wr1VLj7TYcOo8dzQpd1Wld4sgg/+KRjXO
         I8T4oCmXI2BawyvDovIiPWitfy+xBhgWM+wUkTcDYvJzGPWd1e8Joel3Hn01XaGNkvbP
         anSA==
X-Gm-Message-State: AOAM5325VGXzXI/8iqQxJqBGtAjcgyZmAEFCQb2HuQRKoHz7zdq71X5q
        CxRBioWYWK3lhXt3D0cOsbD/zll3ega2f8LY48c=
X-Google-Smtp-Source: ABdhPJzMgcv0VcR3jZXanRtFTbEwbPNgSIGb8ULBYEjIPWtTlderG0I5Fmulw+sOSYaM80GJWONy5VkBB5T640PyVGM=
X-Received: by 2002:a6b:490d:: with SMTP id u13mr13593076iob.176.1629412635600;
 Thu, 19 Aug 2021 15:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMLyx+CvBQbLz-xQvwLS692tx-4xOgU7b-V2J676D29yg@mail.gmail.com>
 <d983217b-e117-361c-0306-b131695bb93f@denx.de> <CAKmqyKOsUcta1cXxamJZnf01G9beCZrDKia068HR+J0AadgNiA@mail.gmail.com>
 <bff9ba97-bc26-f091-ba71-5e639af524d4@denx.de> <CAKmqyKPF3T_Sx+hL=4OSamLdjy=0fwmrTrVeb-GY0Ja9M=mi+Q@mail.gmail.com>
 <ab2b7f4f-3e36-461c-6a6c-02ee7ed6cb99@denx.de> <CAKmqyKN8devNyDvVL5B_dDASU3se1dSui0bsnf6gQ+CkZ_TaKg@mail.gmail.com>
 <YR1Th65KKRS4D/6+@ravnborg.org> <CAKmqyKOBYXiWwO4QJBJ9sEO5ay5QyYmO=yzvT31evB7BKeniYw@mail.gmail.com>
 <YR58MvAYYEjBQ7l5@ravnborg.org>
In-Reply-To: <YR58MvAYYEjBQ7l5@ravnborg.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 20 Aug 2021 08:36:49 +1000
Message-ID: <CAKmqyKOYk=O4ewBcL7hOz+8=gTsNzFb07m_qrNhKq9Bk2ByYrQ@mail.gmail.com>
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

On Fri, Aug 20, 2021 at 1:43 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Alistair,
>
> On Thu, Aug 19, 2021 at 07:10:00PM +1000, Alistair Francis wrote:
> > On Thu, Aug 19, 2021 at 4:38 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > > Hi Alistair,
> > >
> > > >
> > > > These are the EINVAL strace tells me in the not working case:
> > > >
> > > > prctl(PR_CAPBSET_READ, 0x30 /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > > > prctl(PR_CAPBSET_READ, 0x2c /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > > > prctl(PR_CAPBSET_READ, 0x2a /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > > > prctl(PR_CAPBSET_READ, 0x29 /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > > > ioctl(5, FBIOPUT_VSCREENINFO, 0x4ce8e0) = -1 EINVAL (Invalid argument)
> > > >
> > > > I'm guessing it's related to FBIOPUT_VSCREENINFO then, is that
> > > > something that could be added to the DRM emulation?
> > >
> > > If it turns out FBIOPUT_VSCREENINFO is the culprint it would also be
> > > good to know why we see EINVAL.
> > > One way is to sprinkle a number of printk's in fb_set_var(),
> > > then you can see how far you get before it fails.
> >
> > Thanks for the help.
> >
> > I see this line:
> >
> > ret = info->fbops->fb_check_var(var, info);
> >
> > in fb_set_var()
> >
> > returning early.
>
> Super, then next step is to annotate drm_fb_helper_check_var()
> to see where it fails.
> Try this and let us know the result.

Thanks!

After adding some prints, I realised there are already some in there
that are disabled by default. After enabling them I see this:

"fbdev emulation doesn't support changing the pixel clock, value of
pixclock is ignored"

and

"fb requested width/height/bpp can't fit in current fb request
260x1408-32 (virtual 260x23936) > 334x1405-32"

which returns EINVAL.

This is where I'm confused though. The values 334 and 1405 are taken
from the vendor and in the working fbdev driver they are using the
same values.

I tried to add a similar print to mxsfb_check_var() for the working
version, to check what the values are, but there doesn't seem to be
any equivalent of fb->width and friends.

Any ideas?

Alistair

>
>         Sam
