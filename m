Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9451E41ABC9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbhI1J3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbhI1J3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:29:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B156DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 02:28:01 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mV9Oz-0008Nk-NY; Tue, 28 Sep 2021 11:27:53 +0200
Message-ID: <3ebcbc4dba56011ddf4761dc47513dbb66fe656d.camel@pengutronix.de>
Subject: Re: [PATCH] drm: mxsfb: Set proper default bus format when using a
 bridge
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>
Cc:     Stefan Agner <stefan@agner.ch>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Tue, 28 Sep 2021 11:27:49 +0200
In-Reply-To: <YVLeMlQWd/lBNjsX@qwark.sigxcpu.org>
References: <YVLYh/SgBritG/RJ@qwark.sigxcpu.org>
         <1fda3b80-7df2-2ce3-b049-6773e849e9dc@denx.de>
         <YVLeMlQWd/lBNjsX@qwark.sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 28.09.2021 um 11:19 +0200 schrieb Guido Günther:
> Hi,
> On Tue, Sep 28, 2021 at 11:08:58AM +0200, Marek Vasut wrote:
> > On 9/28/21 10:55 AM, Guido Günther wrote:
> > > If a bridge doesn't do any bus format handling MEDIA_BUS_FMT_FIXED is
> > > returned. Fallback to a reasonable default (MEDIA_BUS_FMT_RGB888_1X24) in
> > > that case.
> > > 
> > > This unbreaks e.g. using mxsfb with the nwl bridge and mipi panels.
> > > 
> > > Fixes: b776b0f00f24 ("drm: mxsfb: Use bus_format from the nearest bridge if present")
> > > 
> > > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > > ---
> > > 
> > > I'll look at what needs to be done in nwl separately but this also
> > > unbreaks other bridge seupts that don't to format negotiation yet.
> > > 
> > >   drivers/gpu/drm/mxsfb/mxsfb_kms.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> > > index af6c620adf6e..4ef94cf686b0 100644
> > > --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> > > +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> > > @@ -369,6 +369,8 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
> > >   			drm_atomic_get_new_bridge_state(state,
> > >   							mxsfb->bridge);
> > >   		bus_format = bridge_state->input_bus_cfg.format;
> > > +		if (bus_format == MEDIA_BUS_FMT_FIXED)
> > > +			bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> > 
> > Shouldn't the NWL bridge return the correct format ?
> 
> Yes it should and I'll send a separate patch for that but we currently
> don't do anything meaningful at all if the bridge doesn't do format
> negotiation and then fail setup in mxsfb_set_formats().
> 
> I think we should at least preserve the status quo (as we do with the
> non bridge case in b776b0f00f24 too).
> 
> We could have a warning to spot drivers that don't do that yet and hence
> the generic code returns MEDIA_BUS_FMT_FIXED.
> 
That sounds sensible. Using a default format if we don't know what to
do is going to be a unpleasant surprise for those with a display
pipeline that doesn't work with the default format. So please add a
dev_warn when we are doing this fallback.

Also I would argue that the NWL fix is the patch that should go in the
stable tree. This one should only be a additional safety net, so I
would drop the Fixes tag.

Regards,
Lucas

