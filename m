Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4180342AE05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhJLUks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:40:48 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:38506 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233495AbhJLUkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:40:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C3083FB03;
        Tue, 12 Oct 2021 22:38:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8r1EHILMLt56; Tue, 12 Oct 2021 22:38:41 +0200 (CEST)
Date:   Tue, 12 Oct 2021 22:38:40 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: Ignore -EPROBE_DEFER when bridge attach fails
Message-ID: <YWXyUHAeoWUeyMY4@qwark.sigxcpu.org>
References: <00493cc61d1443dab1c131c46c5890f95f6f9b25.1634068657.git.agx@sigxcpu.org>
 <YWXrPE/G6gaXA6o3@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWXrPE/G6gaXA6o3@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Oct 12, 2021 at 10:08:28PM +0200, Sam Ravnborg wrote:
> Hi Guido,
> 
> On Tue, Oct 12, 2021 at 09:58:58PM +0200, Guido Günther wrote:
> > Otherwise logs are filled with
> > 
> >   [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@30800000/mipi-dsi@30a0 0000 to encoder None-34: -517
> > 
> > when the bridge isn't ready yet.
> > 
> > Fixes: fb8d617f8fd6 ("drm/bridge: Centralize error message when bridge attach fails")
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  drivers/gpu/drm/drm_bridge.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > index a8ed66751c2d..f0508e85ae98 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -227,14 +227,15 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
> >  	bridge->encoder = NULL;
> >  	list_del(&bridge->chain_node);
> >  
> > +	if (ret != -EPROBE_DEFER) {
> >  #ifdef CONFIG_OF
> > -	DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
> > -		  bridge->of_node, encoder->name, ret);
> > +		DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
> > +			  bridge->of_node, encoder->name, ret);
> 
> It would be better to use drm_probe_err().

That's what i thought initially but since the rest here uses DRM_*
logging i stuck with it. Happy to change that though.
Cheers,
 -- Guido

> 
> 	Sam
> 
> >  #else
> > -	DRM_ERROR("failed to attach bridge to encoder %s: %d\n",
> > -		  encoder->name, ret);
> > +		DRM_ERROR("failed to attach bridge to encoder %s: %d\n",
> > +			  encoder->name, ret);
> >  #endif
> > -
> > +	}
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL(drm_bridge_attach);
> > -- 
> > 2.33.0
> 
