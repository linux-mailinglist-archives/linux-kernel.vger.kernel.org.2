Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DFB41ABA3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbhI1JVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:21:33 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:43112 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239806AbhI1JVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:21:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id BA55BFB03;
        Tue, 28 Sep 2021 11:19:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iNT9Un6UF8NA; Tue, 28 Sep 2021 11:19:47 +0200 (CEST)
Date:   Tue, 28 Sep 2021 11:19:46 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Stefan Agner <stefan@agner.ch>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drm: mxsfb: Set proper default bus format when using a
 bridge
Message-ID: <YVLeMlQWd/lBNjsX@qwark.sigxcpu.org>
References: <YVLYh/SgBritG/RJ@qwark.sigxcpu.org>
 <1fda3b80-7df2-2ce3-b049-6773e849e9dc@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fda3b80-7df2-2ce3-b049-6773e849e9dc@denx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Sep 28, 2021 at 11:08:58AM +0200, Marek Vasut wrote:
> On 9/28/21 10:55 AM, Guido Günther wrote:
> > If a bridge doesn't do any bus format handling MEDIA_BUS_FMT_FIXED is
> > returned. Fallback to a reasonable default (MEDIA_BUS_FMT_RGB888_1X24) in
> > that case.
> > 
> > This unbreaks e.g. using mxsfb with the nwl bridge and mipi panels.
> > 
> > Fixes: b776b0f00f24 ("drm: mxsfb: Use bus_format from the nearest bridge if present")
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> > 
> > I'll look at what needs to be done in nwl separately but this also
> > unbreaks other bridge seupts that don't to format negotiation yet.
> > 
> >   drivers/gpu/drm/mxsfb/mxsfb_kms.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> > index af6c620adf6e..4ef94cf686b0 100644
> > --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> > +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> > @@ -369,6 +369,8 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
> >   			drm_atomic_get_new_bridge_state(state,
> >   							mxsfb->bridge);
> >   		bus_format = bridge_state->input_bus_cfg.format;
> > +		if (bus_format == MEDIA_BUS_FMT_FIXED)
> > +			bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> 
> Shouldn't the NWL bridge return the correct format ?

Yes it should and I'll send a separate patch for that but we currently
don't do anything meaningful at all if the bridge doesn't do format
negotiation and then fail setup in mxsfb_set_formats().

I think we should at least preserve the status quo (as we do with the
non bridge case in b776b0f00f24 too).

We could have a warning to spot drivers that don't do that yet and hence
the generic code returns MEDIA_BUS_FMT_FIXED.

Cheers,
 -- Guido
