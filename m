Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D191C428954
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbhJKJEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbhJKJD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:03:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046AEC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 02:01:59 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mZrBu-0005tB-0R; Mon, 11 Oct 2021 11:01:50 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mZrBs-0002N4-4R; Mon, 11 Oct 2021 11:01:48 +0200
Date:   Mon, 11 Oct 2021 11:01:48 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/3] drm: panel-simple: Add support for the Innolux
 G070Y2-T02 panel
Message-ID: <20211011090148.GA28262@pengutronix.de>
References: <20210930100501.15690-1-o.rempel@pengutronix.de>
 <20210930100501.15690-2-o.rempel@pengutronix.de>
 <YWGxbKm/5r/J1Vi6@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWGxbKm/5r/J1Vi6@ravnborg.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:00:14 up 235 days, 12:24, 140 users,  load average: 0.70, 0.28,
 0.26
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 05:12:44PM +0200, Sam Ravnborg wrote:
> Hi Oleksij, Robin,
> 
> On Thu, Sep 30, 2021 at 12:05:00PM +0200, Oleksij Rempel wrote:
> > Add compatible and timings for the Innolux G070Y2-T02 panel. It is 7"
> > WVGA (800x480) TFT LCD panel with TTL interface and a backlight unit.
> > 
> > Co-Developed-by: Robin van der Gracht <robin@protonic.nl>
> > Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index 9b6c4e6c38a1..a03b60f6fa99 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -2524,6 +2524,19 @@ static const struct panel_desc innolux_g070y2_l01 = {
> >  	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> >  };
> >  
> > +static const struct panel_desc innolux_g070y2_t02 = {
> > +	.modes = &innolux_at070tn92_mode,
> 
> It is suprising to see that the innolux_g070y2_t02 uses the mode
> innolux_at070tn92_mode.
> Is it on purpose?

yes.

> If yes then I would expect the changelog to say so.
> 
> In most (all?) other cases the panel provide their own mode.

It works with same timing values. What is the preferred way, add own
mode or extend the changelog?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
