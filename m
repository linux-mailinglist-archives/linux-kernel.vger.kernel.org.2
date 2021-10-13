Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F8742B8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbhJMH0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:26:22 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:52308 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233938AbhJMH0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:26:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 03792FB03;
        Wed, 13 Oct 2021 09:24:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Em9WVIhHY5eG; Wed, 13 Oct 2021 09:24:12 +0200 (CEST)
Date:   Wed, 13 Oct 2021 09:24:11 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Andrzej Hajda <andrzej.hajda@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: Ignore -EPROBE_DEFER when bridge attach fails
Message-ID: <YWaJm4u5fWbLHIea@qwark.sigxcpu.org>
References: <00493cc61d1443dab1c131c46c5890f95f6f9b25.1634068657.git.agx@sigxcpu.org>
 <YWXtQ778N/rn+Jnu@pendragon.ideasonboard.com>
 <YWX0UPyw+5OBsBA6@qwark.sigxcpu.org>
 <78425826-1c28-4cb5-ba1f-23c6492a3810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78425826-1c28-4cb5-ba1f-23c6492a3810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Oct 13, 2021 at 08:48:32AM +0200, Andrzej Hajda wrote:
> On 12.10.2021 22:47, Guido Günther wrote:
> > Hi Laurent,
> > On Tue, Oct 12, 2021 at 11:17:07PM +0300, Laurent Pinchart wrote:
> > > Hi Guido,
> > > 
> > > Thank you for the patch.
> > > 
> > > On Tue, Oct 12, 2021 at 09:58:58PM +0200, Guido Günther wrote:
> > > > Otherwise logs are filled with
> > > > 
> > > >    [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@30800000/mipi-dsi@30a0 0000 to encoder None-34: -517
> > > > 
> > > > when the bridge isn't ready yet.
> > > > 
> > > > Fixes: fb8d617f8fd6 ("drm/bridge: Centralize error message when bridge attach fails")
> > > > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > > > ---
> > > >   drivers/gpu/drm/drm_bridge.c | 11 ++++++-----
> > > >   1 file changed, 6 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > > > index a8ed66751c2d..f0508e85ae98 100644
> > > > --- a/drivers/gpu/drm/drm_bridge.c
> > > > +++ b/drivers/gpu/drm/drm_bridge.c
> > > > @@ -227,14 +227,15 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
> > > >   	bridge->encoder = NULL;
> > > >   	list_del(&bridge->chain_node);
> > > > +	if (ret != -EPROBE_DEFER) {
> > > >   #ifdef CONFIG_OF
> > > > -	DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
> > > > -		  bridge->of_node, encoder->name, ret);
> > > > +		DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
> > > > +			  bridge->of_node, encoder->name, ret);
> > > >   #else
> > > > -	DRM_ERROR("failed to attach bridge to encoder %s: %d\n",
> > > > -		  encoder->name, ret);
> > > > +		DRM_ERROR("failed to attach bridge to encoder %s: %d\n",
> > > > +			  encoder->name, ret);
> > > >   #endif
> > > > -
> > > > +	}
> > > 
> > > This looks fine as such, but I'm concerned about the direction it's
> > > taking. Ideally, probe deferral should happen at probe time, way before
> > > the bridge is attached. Doing otherwise is a step in the wrong direction
> > > in my opinion, and something we'll end up regretting when we'll feel the
> > > pain it inflicts.
> > 
> > The particular case I'm seeing this is the nwl driver probe deferrals if
> > the panel bridge isn't ready (which needs a bunch of components
> > (dsi, panel, backlight wrapped led, ...) and it probes fine later on so I
> > wonder where you see the actual error cause? That downstream of the
> > bridge isn't ready or that the display controller is already attaching
> > the bridge?
> 
> So it is something wrong there, nwl should not publish bridge interface
> until it gather its resources (the panel in this case).

That helps, I'll look at that. Thanks!
 -- Guido

> 
> Regards
> Andrzej
> 
> 
> > 
> > Cheers,
> >   -- Guido
> > 
> > > 
> > > >   	return ret;
> > > >   }
> > > >   EXPORT_SYMBOL(drm_bridge_attach);
> > > 
> > > -- 
> > > Regards,
> > > 
> > > Laurent Pinchart
> > > 
> 
