Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E8F309870
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 22:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhA3VWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 16:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhA3VWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 16:22:21 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FEFC061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 13:21:41 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id b20so6897125ljo.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 13:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OLWHP5uIeHtH/PXlg2tlgcv8JFrhZJ4lrJ+/6QlsXg=;
        b=TkwE6cDIlq3Ulq8HgLNEIM6EYrtozp42Sm0p/p4zDaSl5J0I8sZ4KmQlXefAdYicY+
         GyABmIneBgRIbZRP699lCQa+5zUti3bUF0tlnzaZ/iB5FP8xI65c+cEObASDkktuXEvP
         zqb/w602mz1S4euF85t2YVTDSoo8aJDoQ6pJVN5XjVEsMPPq7hQpijTUBa3cahpSu+/4
         zG/VvNdm5n0/IbgkrADrBsguCxbtCKcaq14+zE9mawYjnSqZhCptTK1CwlFgzXlWU7Ma
         Wwj6NkFIPkZVV9dmCdXyhIaJc7MisffmdM5ViSM9nh894lOtqPOR0AWs8vDKuysuD1RP
         lovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OLWHP5uIeHtH/PXlg2tlgcv8JFrhZJ4lrJ+/6QlsXg=;
        b=C/CysdoQxseku/15OdTPWOXzA6P5gjYB9zl/V0GIsfeN2qO5kkPHfm2G9xqujeSOok
         7WzQ/TgdTEZH5wmL+CVPTUoDIkGRAlt8uYvRWR96Fnjs9ptfIja4W+AgWWE7nlKngQUn
         GirYhfDmTaElhspB07fyDq8PEEG5RK6HbAGOHVkz5GdZ/mfqnyvVX0/lFdgltd1JNe6A
         YPt9mA8Yio3zIcojzppXkkuchPeppNQ8+H97/rulmWuC+BsCgQCUMvUqLYtW5Hc02ugB
         hYVMo/QZBlN9bDv+YGh3RU2ty0cBzX6NI5og5biXdPQrIwlcvHvpPsaFo90lYRaWIS/t
         N7+g==
X-Gm-Message-State: AOAM533fy71+TcL52wQeRrzEEGY+XAy0eydhq9s6/EVWoJXMzTivYNcm
        J4MUJKRsyvlmDl7qjXmdA2lWNqXiX5JDycMXPeQ=
X-Google-Smtp-Source: ABdhPJxMctLHhEr5QovTAK8vnfklN4wZPyhd9VVDt5AXngNpDGuuasMi5rBdEgIW290rZ3IgrRYdvzJKPTwLXWBWhBs=
X-Received: by 2002:a2e:993:: with SMTP id 141mr5224764ljj.372.1612041699687;
 Sat, 30 Jan 2021 13:21:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1598331148.git.joe@perches.com> <e96626cd1301ff44e5101e0e5913d8439b425c9f.1598331148.git.joe@perches.com>
 <49b8e2550e661d5f8a5d0b353ec23819cdcae3d2.camel@perches.com>
In-Reply-To: <49b8e2550e661d5f8a5d0b353ec23819cdcae3d2.camel@perches.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Sat, 30 Jan 2021 22:21:28 +0100
Message-ID: <CAMeQTsaaL7bGxp+hYyAzD2e8ibrszcSkUcYmMToOaxYu1iEmdA@mail.gmail.com>
Subject: Re: [PATCH 09/29] drm/gma500: Avoid comma separated statements
To:     Joe Perches <joe@perches.com>
Cc:     Jiri Kosina <trivial@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 7:47 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> > Use semicolons and braces.
>
> Ping?

This entire file is going away so perhaps just drop the patch to avoid
a conflict.

-Patrik

>
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  drivers/gpu/drm/gma500/mdfld_intel_display.c | 44 +++++++++++++-------
> >  1 file changed, 28 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/gma500/mdfld_intel_display.c b/drivers/gpu/drm/gma500/mdfld_intel_display.c
> > index aae2d358364c..bfa330df9443 100644
> > --- a/drivers/gpu/drm/gma500/mdfld_intel_display.c
> > +++ b/drivers/gpu/drm/gma500/mdfld_intel_display.c
> > @@ -824,33 +824,45 @@ static int mdfld_crtc_mode_set(struct drm_crtc *crtc,
> >               if ((ksel == KSEL_CRYSTAL_19) || (ksel == KSEL_BYPASS_19)) {
> >                       refclk = 19200;
> >
> >
> > -                     if (is_mipi || is_mipi2)
> > -                             clk_n = 1, clk_p2 = 8;
> > -                     else if (is_hdmi)
> > -                             clk_n = 1, clk_p2 = 10;
> > +                     if (is_mipi || is_mipi2) {
> > +                             clk_n = 1;
> > +                             clk_p2 = 8;
> > +                     } else if (is_hdmi) {
> > +                             clk_n = 1;
> > +                             clk_p2 = 10;
> > +                     }
> >               } else if (ksel == KSEL_BYPASS_25) {
> >                       refclk = 25000;
> >
> >
> > -                     if (is_mipi || is_mipi2)
> > -                             clk_n = 1, clk_p2 = 8;
> > -                     else if (is_hdmi)
> > -                             clk_n = 1, clk_p2 = 10;
> > +                     if (is_mipi || is_mipi2) {
> > +                             clk_n = 1;
> > +                             clk_p2 = 8;
> > +                     } else if (is_hdmi) {
> > +                             clk_n = 1;
> > +                             clk_p2 = 10;
> > +                     }
> >               } else if ((ksel == KSEL_BYPASS_83_100) &&
> >                                       dev_priv->core_freq == 166) {
> >                       refclk = 83000;
> >
> >
> > -                     if (is_mipi || is_mipi2)
> > -                             clk_n = 4, clk_p2 = 8;
> > -                     else if (is_hdmi)
> > -                             clk_n = 4, clk_p2 = 10;
> > +                     if (is_mipi || is_mipi2) {
> > +                             clk_n = 4;
> > +                             clk_p2 = 8;
> > +                     } else if (is_hdmi) {
> > +                             clk_n = 4;
> > +                             clk_p2 = 10;
> > +                     }
> >               } else if ((ksel == KSEL_BYPASS_83_100) &&
> >                                       (dev_priv->core_freq == 100 ||
> >                                       dev_priv->core_freq == 200)) {
> >                       refclk = 100000;
> > -                     if (is_mipi || is_mipi2)
> > -                             clk_n = 4, clk_p2 = 8;
> > -                     else if (is_hdmi)
> > -                             clk_n = 4, clk_p2 = 10;
> > +                     if (is_mipi || is_mipi2) {
> > +                             clk_n = 4;
> > +                             clk_p2 = 8;
> > +                     } else if (is_hdmi) {
> > +                             clk_n = 4;
> > +                             clk_p2 = 10;
> > +                     }
> >               }
> >
> >
> >               if (is_mipi)
>
>
