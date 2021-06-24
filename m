Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2ED3B2F61
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhFXMx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:53:58 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41890 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFXMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:53:55 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7EA40501;
        Thu, 24 Jun 2021 14:51:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1624539095;
        bh=FyM+hUpA+ywRvZffMmTR6lQUvy56qO0lVXxmkkg6Xew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ku9nJvuUoGHtfvBSCPhZUnzsdZa9u8aUgOKXavhhvXazoNEHeJUmF+XnBUufyEyDw
         1VHzjJ+WKBohebiGedt87kbvxgGtmC9Ks0TSZ0H3ZF7iuIwMiv1vnU+XO21x8VHK+M
         SbVH2U84hYAwshMTNJ4e+pgpSJ5ks/Bcldv3ZRVk=
Date:   Thu, 24 Jun 2021 15:51:05 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jonathan Liu <net147@gmail.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: Move drm_bridge_add into probe
Message-ID: <YNR/uQrS75s5BILs@pendragon.ideasonboard.com>
References: <20210203091306.140518-1-jagan@amarulasolutions.com>
 <CANwerB1Bev8Ljta9OyO6vAKsQqHHmaJnjV1YRGmY4bVk_J6xZA@mail.gmail.com>
 <CAMty3ZAY7Ez9UYvfftSmqLEVWgN7xE5HevqfWirmrExZH=RMWA@mail.gmail.com>
 <CANwerB1AiiT3oXCpwP83M1=ES9M-yQoLuZO5f=eVxA42MkEbiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANwerB1AiiT3oXCpwP83M1=ES9M-yQoLuZO5f=eVxA42MkEbiA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing Maxime Ripard.

Maxime, is this similar to the issue we've recently discussed with the
VC4 DSI encoder ?

On Thu, Jun 24, 2021 at 10:39:48PM +1000, Jonathan Liu wrote:
> On Thu, 24 Jun 2021 at 22:34, Jagan Teki wrote:
> > On Fri, Jun 18, 2021 at 6:40 PM Jonathan Liu wrote:
> > > On Wed, 3 Feb 2021 at 09:13, Jagan Teki wrote:
> > > > @@ -1167,6 +1151,20 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
> > > >         dw_mipi_dsi_debugfs_init(dsi);
> > > >         pm_runtime_enable(dev);
> > > >
> > > > +       ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0,
> > > > +                                         &panel, &bridge);
> > > > +       if (ret)
> > > > +               return ERR_PTR(ret);
> > >
> > > On RK3399 if the error is EPROBE_DEFER, __dw_mipi_dsi_probe can be
> > > called again and result in the following errors:
> > > [    0.717589] debugfs: Directory 'ff960000.mipi' with parent '/' already present!
> > > [    0.717601] dw-mipi-dsi-rockchip ff960000.mipi: failed to create debugfs root
> > > [    0.717606] dw-mipi-dsi-rockchip ff960000.mipi: Unbalanced pm_runtime_enable!
> >
> > Is this when you test bridge on rk3399 or panel?
> 
> MIPI-DSI to LVDS bridge.

-- 
Regards,

Laurent Pinchart
