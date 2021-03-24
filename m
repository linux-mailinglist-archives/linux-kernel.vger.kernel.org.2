Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4815F3474CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbhCXJjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbhCXJjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:39:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6DCC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:39:09 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6FC88580;
        Wed, 24 Mar 2021 10:39:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616578746;
        bh=OpiUjjnMJhqf4VDAVhNdufxOxaOTNCJNSAerYwkbvwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifjiNNoi8hgbYJmUPBJui6RUg+081OAs+FjyDH1k2mVsjFxDl3wD8YHzvLQD/wKAm
         y5xRfr7qa2u0Y7ov3Npew6cWruNL9NbcB7x2NS36iyJwJw5elRRBSWkR69wF5rCLmf
         NH29XFDcw94yfuZWpYkPDgihpThkjulGKilVrqLM=
Date:   Wed, 24 Mar 2021 11:38:24 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v4 1/4] drm: sun4i: dsi: Use drm_of_find_panel_or_bridge
Message-ID: <YFsIkGH2cRgWk8z9@pendragon.ideasonboard.com>
References: <20210322140152.101709-1-jagan@amarulasolutions.com>
 <20210322140152.101709-2-jagan@amarulasolutions.com>
 <YFpxYpA+EIZm7sOf@pendragon.ideasonboard.com>
 <f47bc0ad-dbd6-05b5-aaec-2e3256e3715a@sholland.org>
 <CAMty3ZDOVeMeYTsuF8n4EQTG6eEbj6e33TuTPrFiMWG4RhRdSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMty3ZDOVeMeYTsuF8n4EQTG6eEbj6e33TuTPrFiMWG4RhRdSw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On Wed, Mar 24, 2021 at 02:44:57PM +0530, Jagan Teki wrote:
> On Wed, Mar 24, 2021 at 8:18 AM Samuel Holland wrote:
> > On 3/23/21 5:53 PM, Laurent Pinchart wrote:
> > > On Mon, Mar 22, 2021 at 07:31:49PM +0530, Jagan Teki wrote:
> > >> Replace of_drm_find_panel with drm_of_find_panel_or_bridge
> > >> for finding panel, this indeed help to find the bridge if
> > >> bridge support added.
> > >>
> > >> Added NULL in bridge argument, same will replace with bridge
> > >> parameter once bridge supported.
> > >>
> > >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > >
> > > Looks good, there should be no functional change.
> >
> > Actually this breaks all existing users of this driver, see below.
> >
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > >
> > >> ---
> > >> Changes for v4, v3:
> > >> - none
> > >>
> > >>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 11 ++++++++---
> > >>  1 file changed, 8 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > >> index 4f5efcace68e..2e9e7b2d4145 100644
> > >> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > >> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > >> @@ -21,6 +21,7 @@
> > >>
> > >>  #include <drm/drm_atomic_helper.h>
> > >>  #include <drm/drm_mipi_dsi.h>
> > >> +#include <drm/drm_of.h>
> > >>  #include <drm/drm_panel.h>
> > >>  #include <drm/drm_print.h>
> > >>  #include <drm/drm_probe_helper.h>
> > >> @@ -963,10 +964,14 @@ static int sun6i_dsi_attach(struct mipi_dsi_host *host,
> > >>                          struct mipi_dsi_device *device)
> > >>  {
> > >>      struct sun6i_dsi *dsi = host_to_sun6i_dsi(host);
> > >> -    struct drm_panel *panel = of_drm_find_panel(device->dev.of_node);
> >
> > This is using the OF node of the DSI device, which is a direct child of
> > the DSI host's OF node. There is no OF graph involved.
> >
> > >> +    struct drm_panel *panel;
> > >> +    int ret;
> > >> +
> > >> +    ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 0, 0,
> > >> +                                      &panel, NULL);
> >
> > However, this function expects to find the panel using OF graph. This
> > does not work with existing device trees (PinePhone, PineTab) which do
> > not use OF graph to connect the panel. And it cannot work, because the
> > DSI host's binding specifies a single port: the input port from the
> > display engine.
> 
> Thanks for noticing this. I did understand your point and yes, I did
> mention the updated pipeline in previous versions and forgot to add it
> to this series.
> 
> Here is the updated pipeline to make it work:
> 
> https://patchwork.kernel.org/project/dri-devel/patch/20190524104252.20236-1-jagan@amarulasolutions.com/
> 
> Let me know your comments on this, so I will add a patch for the
> above-affected DTS files.

DT is an ABI, we need to ensure backward compatibility. Changes in
kernel drivers can't break devices that have an old DT.

-- 
Regards,

Laurent Pinchart
