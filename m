Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113BA42354F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbhJFBB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 21:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbhJFBB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 21:01:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC515C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 17:59:35 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 059BE581;
        Wed,  6 Oct 2021 02:59:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1633481973;
        bh=l+rjQCwGSyO9yFVWNn3k5VoiRZiXyt/OvwCdmBBkbIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=paeRZwqyBlSZYkzgJ9sRpDHvCCejFY33YXZ973CdSOdB9Lcdu7JHDfVOiLXezm/ZM
         Q073WIMbnCkoVtsQwmhgPz1FFbvhnpGUDbyxMjpBmetbphhwlwcAp0U3ou3pK5RSQz
         TJfxjOypdDXomdcFr/KAa28rCEIzOxlsDUhvpNss=
Date:   Wed, 6 Oct 2021 03:59:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] drm/bridge: ti-sn65dsi86: Add NO_CONNECTOR support
Message-ID: <YVz07YIXzFMwl8iR@pendragon.ideasonboard.com>
References: <20210920225801.227211-1-robdclark@gmail.com>
 <20210920225801.227211-4-robdclark@gmail.com>
 <YUvN3j0v+8NMjNte@pendragon.ideasonboard.com>
 <CAF6AEGviyfX6+c-CB5gMXqRQfHhvb5L8t++-VkZpvS3r9qDNoA@mail.gmail.com>
 <YU03M+CXJ+ALi8De@pendragon.ideasonboard.com>
 <CAD=FV=UU1_ZR0K9XEgkTM2M55FgmqoH=ciU5a_oCC+W2NPdZ-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=UU1_ZR0K9XEgkTM2M55FgmqoH=ciU5a_oCC+W2NPdZ-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Fri, Oct 01, 2021 at 11:02:54AM -0700, Doug Anderson wrote:
> On Thu, Sep 23, 2021 at 7:26 PM Laurent Pinchart wrote:
> >
> > > > >  err_conn_init:
> > > > >       drm_dp_aux_unregister(&pdata->aux);
> > > > >       return ret;
> > > > > @@ -792,9 +790,30 @@ static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
> > > > >       regmap_write(pdata->regmap, SN_DSIA_CLK_FREQ_REG, val);
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * Find the connector and fish out the bpc from display_info.  It would
> > > > > + * be nice if we could get this instead from drm_bridge_state, but that
> > > > > + * doesn't yet appear to be the case.
> > > >
> > > > You already have a bus format in the bridge state, from which you can
> > > > derive the bpp. Could you give it a try ?
> > >
> > > Possibly the bridge should be converted to ->atomic_enable(), etc..
> > > I'll leave that for another time
> >
> > It should be fairly straightforward, and would avoid the hack below.
> 
> Given this point of controversy, my inclination is to wait and not
> apply this patch now. I don't think there's anything urgent here,
> right? Worst case eventually Laurent might pick it up in his patch
> series? At least we know it will work with the MSM driver once patch
> #1 lands. :-)

I've recorded the task for my upcoming work on the ti-sn65dsi86 driver.

-- 
Regards,

Laurent Pinchart
