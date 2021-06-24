Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2F83B2ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhFXMUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:20:40 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:40946 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhFXMUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:20:39 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 175DF532;
        Thu, 24 Jun 2021 14:18:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1624537099;
        bh=Pvzdh5EKasv+EhamsaZeQjLwFhVZYZUYQUwo4R3jNro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKzRJ4N/JQpXZJyg2P/IgnI/e+TlgJ58dYfChYbMxfgrMTCYAlpbXTKuELqp5AhyZ
         FXfMxuqtPZ14JbZ8Ag6stzgxKOk4FC7Qe+qVQtMsD3W1q2+ucFVamN6qi4UtFXp/uK
         0LPadT2QUAo7DZJ58dw+igRZYl8j+NYrpn/x7FPE=
Date:   Thu, 24 Jun 2021 15:17:48 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Milco Pratesi <milco.pratesi@engicam.com>,
        Anthony Brandon <anthony@amarulasolutions.com>,
        linux-phy@lists.infradead.org, Fancy Fang <chen.fang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [RFC PATCH 2/9] drm: bridge: Add Samsung SEC MIPI DSIM bridge
 driver
Message-ID: <YNR37NWkxq0mZyq5@pendragon.ideasonboard.com>
References: <20210621072424.111733-1-jagan@amarulasolutions.com>
 <20210621072424.111733-3-jagan@amarulasolutions.com>
 <YNO0LHNVSWjrh1ZS@pendragon.ideasonboard.com>
 <CAOMZO5Ahbu4mohtMDOQOv_y5B_TDesbdYEUZTF1RL7_y-bS+RA@mail.gmail.com>
 <CAMty3ZAtObU-bf6FuxvSBaZn2cotj_NxASW9g9on-kBJ7iW3OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMty3ZAtObU-bf6FuxvSBaZn2cotj_NxASW9g9on-kBJ7iW3OA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On Thu, Jun 24, 2021 at 05:42:43PM +0530, Jagan Teki wrote:
> On Thu, Jun 24, 2021 at 8:18 AM Fabio Estevam wrote:
> > On Wed, Jun 23, 2021 at 7:23 PM Laurent Pinchart wrote:
> >
> > > Looking at the register set, it seems to match the Exynos 5433,
> > > supported by drivers/gpu/drm/exynos/exynos_drm_dsi.c. Can we leverage
> > > that driver instead of adding a new one for the same IP core ?
> >
> > Yes. there was an attempt from Michael in this direction:
> > https://patchwork.kernel.org/project/dri-devel/cover/20200911135413.3654800-1-m.tretter@pengutronix.de/
> 
> Thanks for the reference, I will check it out and see I can send any
> updated versions wrt my i.MX8MM platform.

Thanks.

I had a brief look at the exynos driver, and I think it should be turned
into a DRM bridge as part of this rework to be used with the i.MX8MM.

Is there someone from Samsung who could assist, at least to test the
changes ?

-- 
Regards,

Laurent Pinchart
