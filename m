Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E623ECF76
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbhHPHfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhHPHfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:35:15 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC7C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:34:44 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id v16so6813486ilo.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJqUUGR8PyhIxyfZ2ESBZDcQCK4GlHo0+G4IlKPa0Q0=;
        b=pLhTlHI0SK1Ea/9O09yzxNiVzQ755/a4Z46UFwbsIfOMupjIB3e83WVSNZgvJaBKxO
         gn7rpz3pMH01V8YCqyeeKIopnyVHicwAnI29uyuf21pr+BmZdGq+vUG+fIU7T+lqSQLE
         MZ9itD7Ti8C747CRAblCJO2xTlH5B0G+ISGpGrJ1iesdVkJTucwqWhyByokIJ+83zWX7
         t++q8nlYH02yVRLZuTuwH1dd9RcKwYfZ0iV00CEw2WDdYLyZ/AZy6hX55u2BcHVZOPyM
         iH2P0OaDmFvRA7AYyhKIJ9ON7SAUXUFNDL+GmdA3odwAyKK8OF8HMS3bl/4tBtUPyHk3
         /GFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJqUUGR8PyhIxyfZ2ESBZDcQCK4GlHo0+G4IlKPa0Q0=;
        b=TQ5LBCWoGDAZrOyVqCPIoHGEQ1d3uBhg62JNhm510N7egnydW/8uoFjxf5skM0dLQg
         W9EEGQ+scw+y2EdeMWY1C2Vilp8RgnKhxbP13kg5Aq9KE7KIfDP1EDKXJ/Nkyd1aVCfo
         4y9++OuE4h0Je1yFDg7zS7LsTkpZlO428+K4uNcRov6z5Llpi15M4UtKjfUjb3DRVIW9
         fmdAwpopCWwQdC1E3P4GHjYQLZ1N7gyQTwP05J42s7b3mRM3EV4fTqLfe5olwKZ29vAi
         b2ynFB3F87Bc5P/td3BRKeVHm+Dm87yDMDnzOuIoqrfRMBqfnt/LMwkG51sqj6bIqnHm
         cBQg==
X-Gm-Message-State: AOAM532JXJEak1JRIw+yqnswX96GM17HrirxkFPzeN6Y5fVFpZmP7e/c
        9sU6bmcq2bAuKg2Cf6O/SXpyTZjDM4Qf6BuOl8s=
X-Google-Smtp-Source: ABdhPJzm7qfog5k/mtey0LKSMoaEBVeZbJMxm3FsFxspYM4IgEzn0SsdMM/GDmd757sGM1xbu2GrzRBWMhgPKGPcCgM=
X-Received: by 2002:a92:6802:: with SMTP id d2mr2072161ilc.40.1629099283783;
 Mon, 16 Aug 2021 00:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMLyx+CvBQbLz-xQvwLS692tx-4xOgU7b-V2J676D29yg@mail.gmail.com>
 <d983217b-e117-361c-0306-b131695bb93f@denx.de>
In-Reply-To: <d983217b-e117-361c-0306-b131695bb93f@denx.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 16 Aug 2021 17:34:17 +1000
Message-ID: <CAKmqyKOsUcta1cXxamJZnf01G9beCZrDKia068HR+J0AadgNiA@mail.gmail.com>
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

On Sun, Aug 15, 2021 at 10:31 PM Marek Vasut <marex@denx.de> wrote:
>
> On 8/15/21 2:16 PM, Alistair Francis wrote:
> > Hello,
> >
> > Commit f225f1393f034 "video: fbdev: mxsfb: Remove driver" removed the
> > mxsfb fbdev driver.
> >
> > I am now working on getting mainline Linux running on the reMarkable 2
> > eInk reader [1]. Unfortunately the rM2 doesn't use the standard EPD
> > controller on the i.MX SoC, but instead uses the LCD controller.
> >
> > eInk panels are complex to control and require writing temperature
> > dependent waveforms. As these waveforms are proprietary [2] the rM
> > team runs closed source software called SWTCON in userspace to control
> > the panel [3].
> >
> > This closed source software expects the fbdev mxsfb driver and it
> > doesn't work with the DRM mxsfb driver (at least not that I can get it
> > to).
> >
> > The NXP fork of Linux also re-adds the fbdev driver [4], so they also
> > see some uses for it.
> >
> > I was wondering if the community would be open to re-adding the fbdev
> > mxsfb driver to mainline? It could be re-added with a different
> > dt-binding so that it is not used by default and only enabled for
> > boards when required (like for the rM2).
> >
> > 1: https://remarkable.com/store/remarkable-2
> > 2: https://goodereader.com/blog/e-paper/e-ink-waveforms-are-a-closely-guarded-secret
> > 3: https://remarkablewiki.com/tech/rm2_framebuffer
> > 4: https://source.codeaurora.org/external/imx/linux-imx/log/drivers/video/fbdev/mxsfb.c?h=lf-5.10.35-2.0.0
>
> +CC Sam.
>
> What sort of special thing does your proprietary userspace do that
> cannot be added to the DRM driver or the fbdev emulation (if needed) ?

It's hard to tell. When using the DRM driver I get cryptic errors
about the frame buffer not being available. It's difficult to know
what is going on as I don't have access to any of the source. I
suspect the userspace code could be updated to use the DRM driver, but
we would need the reMarkable devs to do that.

There is some effort to re-implement the proprietary user space swtcon
(https://github.com/timower/rM2-stuff#swtcon), but it seems to have
stalled. It wouldn't be impossible to get swtcon to work with the DRM
driver, but it would require a very large amount of reverse
engineering, that probably will never happen.

I wanted to see what the thoughts were on re-adding the fbdev mxsfb
driver. The commit message just says that because there is a DRM
driver we no longer need the fbdev one, but here is a case for the
fbdev driver. I was thinking that continuing to support the fbdev
mxsfb driver wouldn't be too much of a maintenance burden (but that's
obviously up to you). The NXP tree also seems to think the fbdev
driver is worth keeping around.

Alistair
