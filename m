Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E898534744F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhCXJPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbhCXJPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:15:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7287C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:15:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h10so26717736edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zsFZ3U+MTNyWBA6xTX8iF9xhpZHq3owuoQogBCZG32k=;
        b=SFaIWTPXjQmFIZdTzls7n3rZGu4qFTSI7ywPxkxDafUt+AG1O9zJ6P1P/a/TiI2mWP
         JyFpey4vtoBKpJMOf9daf8sVPp1ktAftF5yUmUQoRacS6+vGRKilP4xu9aRHgZ14jCE2
         voQErrwf259SU9J9GSKws7cwMszh3ta43hPQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsFZ3U+MTNyWBA6xTX8iF9xhpZHq3owuoQogBCZG32k=;
        b=CVVUjek3zB0UwzPxRbdmmR2a71tjqCtJYot64Nf8UwN1ChnD9c+Gmhn0iSL7h5A/P+
         cBKoi68qwwPVU4KRIklVMYdphOkuT6kofUy13Ni2A+c6OYRxkfXVvxQcxh1PHfgeE45H
         FBtAQTP2FqlctVs8K6K0QXu8IwC2JEaDMsK+lirTTRvayo9WYUpolQjAnEy5nqAbT8ta
         EXgBhdVCx6b4XqNAOfX9zCcTQS+8Xf7TnmHJa0m7rXQsaKZ338jShCA/1utgPyeDig25
         pbjNratyeAPYCmFW4HhSS5+qxJM2JniZ7LcQjQlZhOetiZHLkajxWPPTyBjCCdwV3Tt2
         Zbmw==
X-Gm-Message-State: AOAM531bYsntpKiI9o6T7cPFW33e4CNpKdmlUcNn2qKepYhqsUQRO202
        suRDn3DfPDx6O3jDAshYOhlX5YCOOKLqOBCR/8oAlw==
X-Google-Smtp-Source: ABdhPJzmOXx9kgtZw4VSF8lAJqdI06RPrtHvtgVdVzxXyy5P7sR9NmJCv5xvsQKHo/odSeVeUt60nl7GZ+W71/v/OPI=
X-Received: by 2002:a05:6402:4244:: with SMTP id g4mr2349372edb.204.1616577308579;
 Wed, 24 Mar 2021 02:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210322140152.101709-1-jagan@amarulasolutions.com>
 <20210322140152.101709-2-jagan@amarulasolutions.com> <YFpxYpA+EIZm7sOf@pendragon.ideasonboard.com>
 <f47bc0ad-dbd6-05b5-aaec-2e3256e3715a@sholland.org>
In-Reply-To: <f47bc0ad-dbd6-05b5-aaec-2e3256e3715a@sholland.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 24 Mar 2021 14:44:57 +0530
Message-ID: <CAMty3ZDOVeMeYTsuF8n4EQTG6eEbj6e33TuTPrFiMWG4RhRdSw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] drm: sun4i: dsi: Use drm_of_find_panel_or_bridge
To:     Samuel Holland <samuel@sholland.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 8:18 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 3/23/21 5:53 PM, Laurent Pinchart wrote:
> > Hi Jagan,
> >
> > Thank you for the patch.
> >
> > On Mon, Mar 22, 2021 at 07:31:49PM +0530, Jagan Teki wrote:
> >> Replace of_drm_find_panel with drm_of_find_panel_or_bridge
> >> for finding panel, this indeed help to find the bridge if
> >> bridge support added.
> >>
> >> Added NULL in bridge argument, same will replace with bridge
> >> parameter once bridge supported.
> >>
> >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > Looks good, there should be no functional change.
>
> Actually this breaks all existing users of this driver, see below.
>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> >> ---
> >> Changes for v4, v3:
> >> - none
> >>
> >>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 11 ++++++++---
> >>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> >> index 4f5efcace68e..2e9e7b2d4145 100644
> >> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> >> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> >> @@ -21,6 +21,7 @@
> >>
> >>  #include <drm/drm_atomic_helper.h>
> >>  #include <drm/drm_mipi_dsi.h>
> >> +#include <drm/drm_of.h>
> >>  #include <drm/drm_panel.h>
> >>  #include <drm/drm_print.h>
> >>  #include <drm/drm_probe_helper.h>
> >> @@ -963,10 +964,14 @@ static int sun6i_dsi_attach(struct mipi_dsi_host *host,
> >>                          struct mipi_dsi_device *device)
> >>  {
> >>      struct sun6i_dsi *dsi = host_to_sun6i_dsi(host);
> >> -    struct drm_panel *panel = of_drm_find_panel(device->dev.of_node);
>
> This is using the OF node of the DSI device, which is a direct child of
> the DSI host's OF node. There is no OF graph involved.
>
> >> +    struct drm_panel *panel;
> >> +    int ret;
> >> +
> >> +    ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 0, 0,
> >> +                                      &panel, NULL);
>
> However, this function expects to find the panel using OF graph. This
> does not work with existing device trees (PinePhone, PineTab) which do
> not use OF graph to connect the panel. And it cannot work, because the
> DSI host's binding specifies a single port: the input port from the
> display engine.

Thanks for noticing this. I did understand your point and yes, I did
mention the updated pipeline in previous versions and forgot to add it
to this series.

Here is the updated pipeline to make it work:

https://patchwork.kernel.org/project/dri-devel/patch/20190524104252.20236-1-jagan@amarulasolutions.com/

Let me know your comments on this, so I will add a patch for the
above-affected DTS files.

Jagan.
