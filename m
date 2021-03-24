Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E00C347507
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhCXJts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbhCXJtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:49:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F67BC0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:49:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hq27so31770958ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q2TNkdIQ/zqP4vTBESLhTRQ8ElDlSEpihHNWHVVdOWw=;
        b=S7+rpvwNmh3R0GucjXGfeKomhZ1GYmSIiZRFBQZs+DNgNJlAQYPIEbkKvfxfE7jqgJ
         Xp5ioShGHBPMpZz2X1rnpZdsQEU4OyXOOH9TerN/74vfVbeTt6VxpfxlJnR4b+dNky51
         O5YVnDX4eu+q9Ul9Q7CK5XSLe281AwPBrNHFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2TNkdIQ/zqP4vTBESLhTRQ8ElDlSEpihHNWHVVdOWw=;
        b=EZidwUzqCw8fIG0naQcay1stn+XeeHDZqOLnTWabdfsUIwOfi8CYz01X5e9/01W94o
         TEmzYHd/XKa6f+uVzEDlo4tRU5Gw1+YBVFxt29WXd2KGpqvwbc0Ihm8IkDfX+UWD541e
         WB1QEZo57rCkXDOPZ5Yh6OBD/DYo/KC9a/g94dX6WljYU1opNJ8wH44/HkEGn+qxcrTz
         oy9NP4R+o5I9ObqrRFWDS5X9wAu0f/eeOg5u2C/QNspg7rkb7P5/SfjIQIeNk5nTHoxA
         HPok5vm2cxdWt1fV4KsMAHYgOkh1hmVuJk638NHIwaUVWSiWJaFsLUln6fshK/AExSH4
         3WGw==
X-Gm-Message-State: AOAM532syqNzd+5vjal9FDFIziHOimNUVLwrzlhLi73Xfo4Py76u7hWr
        FQ2zs5LgRz1ZeiW54aXs4V+oE/vNiXCVbBIKKzk4Ug==
X-Google-Smtp-Source: ABdhPJxT/mrB/QVLHNjBduRmjrJ94vDchGyD6p3if3yVTDDUhEZVii5KLyc4Gnw0eC6LPMdYKW6Vv8fzGXaNaflz2qw=
X-Received: by 2002:a17:907:104f:: with SMTP id oy15mr2758052ejb.252.1616579362156;
 Wed, 24 Mar 2021 02:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210322140152.101709-1-jagan@amarulasolutions.com>
 <20210322140152.101709-2-jagan@amarulasolutions.com> <YFpxYpA+EIZm7sOf@pendragon.ideasonboard.com>
 <f47bc0ad-dbd6-05b5-aaec-2e3256e3715a@sholland.org> <CAMty3ZDOVeMeYTsuF8n4EQTG6eEbj6e33TuTPrFiMWG4RhRdSw@mail.gmail.com>
 <YFsIkGH2cRgWk8z9@pendragon.ideasonboard.com>
In-Reply-To: <YFsIkGH2cRgWk8z9@pendragon.ideasonboard.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 24 Mar 2021 15:19:10 +0530
Message-ID: <CAMty3ZBGnz_a4_HO_TZ-zPNJwHMcVJyrBi3kZX2=a6G47Ze-yw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] drm: sun4i: dsi: Use drm_of_find_panel_or_bridge
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Samuel Holland <samuel@sholland.org>,
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

Hi Laurent,

On Wed, Mar 24, 2021 at 3:09 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Jagan,
>
> On Wed, Mar 24, 2021 at 02:44:57PM +0530, Jagan Teki wrote:
> > On Wed, Mar 24, 2021 at 8:18 AM Samuel Holland wrote:
> > > On 3/23/21 5:53 PM, Laurent Pinchart wrote:
> > > > On Mon, Mar 22, 2021 at 07:31:49PM +0530, Jagan Teki wrote:
> > > >> Replace of_drm_find_panel with drm_of_find_panel_or_bridge
> > > >> for finding panel, this indeed help to find the bridge if
> > > >> bridge support added.
> > > >>
> > > >> Added NULL in bridge argument, same will replace with bridge
> > > >> parameter once bridge supported.
> > > >>
> > > >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > >
> > > > Looks good, there should be no functional change.
> > >
> > > Actually this breaks all existing users of this driver, see below.
> > >
> > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > >
> > > >> ---
> > > >> Changes for v4, v3:
> > > >> - none
> > > >>
> > > >>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 11 ++++++++---
> > > >>  1 file changed, 8 insertions(+), 3 deletions(-)
> > > >>
> > > >> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > >> index 4f5efcace68e..2e9e7b2d4145 100644
> > > >> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > >> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > >> @@ -21,6 +21,7 @@
> > > >>
> > > >>  #include <drm/drm_atomic_helper.h>
> > > >>  #include <drm/drm_mipi_dsi.h>
> > > >> +#include <drm/drm_of.h>
> > > >>  #include <drm/drm_panel.h>
> > > >>  #include <drm/drm_print.h>
> > > >>  #include <drm/drm_probe_helper.h>
> > > >> @@ -963,10 +964,14 @@ static int sun6i_dsi_attach(struct mipi_dsi_host *host,
> > > >>                          struct mipi_dsi_device *device)
> > > >>  {
> > > >>      struct sun6i_dsi *dsi = host_to_sun6i_dsi(host);
> > > >> -    struct drm_panel *panel = of_drm_find_panel(device->dev.of_node);
> > >
> > > This is using the OF node of the DSI device, which is a direct child of
> > > the DSI host's OF node. There is no OF graph involved.
> > >
> > > >> +    struct drm_panel *panel;
> > > >> +    int ret;
> > > >> +
> > > >> +    ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 0, 0,
> > > >> +                                      &panel, NULL);
> > >
> > > However, this function expects to find the panel using OF graph. This
> > > does not work with existing device trees (PinePhone, PineTab) which do
> > > not use OF graph to connect the panel. And it cannot work, because the
> > > DSI host's binding specifies a single port: the input port from the
> > > display engine.
> >
> > Thanks for noticing this. I did understand your point and yes, I did
> > mention the updated pipeline in previous versions and forgot to add it
> > to this series.
> >
> > Here is the updated pipeline to make it work:
> >
> > https://patchwork.kernel.org/project/dri-devel/patch/20190524104252.20236-1-jagan@amarulasolutions.com/
> >
> > Let me know your comments on this, so I will add a patch for the
> > above-affected DTS files.
>
> DT is an ABI, we need to ensure backward compatibility. Changes in
> kernel drivers can't break devices that have an old DT.

Thanks for your point.

So, we need to choose APIs that would compatible with the old DT and
new DT changes. Am I correct?

Jagan.
