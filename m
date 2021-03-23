Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD87346957
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhCWTx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbhCWTxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:53:12 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41787C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:53:12 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 95AE0B1D;
        Tue, 23 Mar 2021 20:53:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616529188;
        bh=YwlqFRn0M9BFPQVdD6FUntyPjZt77vZr8VZHyyOCrsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8BEzzazZmkIYLZPdUQuuBsmom2pF1ocb+rZbxV6fjucBH78VhbZCMrAKhvwr64Dp
         aD9JWfQ1AznsC2BpTV6k8e0WARjOD8qf2BGqoqnOHjOGLtQ7K8B1rTuCGK190nlwyy
         CgSNrLJSa0vzzkV25c/eJakIocK8GOoHRqypogOU=
Date:   Tue, 23 Mar 2021 21:52:26 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v3 3/4] drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
Message-ID: <YFpG+hK7W+4bpp0A@pendragon.ideasonboard.com>
References: <20201102181144.3469197-1-swboyd@chromium.org>
 <20201102181144.3469197-4-swboyd@chromium.org>
 <YFKc23MwUQAosCs8@pendragon.ideasonboard.com>
 <161646947526.2972785.6883720652669260316@swboyd.mtv.corp.google.com>
 <CAD=FV=U+-spmAxFeDNxhCuB6O=gUvO_==ozg-OGn=2vkUWgL4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=U+-spmAxFeDNxhCuB6O=gUvO_==ozg-OGn=2vkUWgL4Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Tue, Mar 23, 2021 at 12:07:27PM -0700, Doug Anderson wrote:
> On Mon, Mar 22, 2021 at 8:17 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Laurent Pinchart (2021-03-17 17:20:43)
> > > Hi Stephen,
> > >
> > > Reviving a bit of an old thread, for a question.
> > >
> > > On Mon, Nov 02, 2020 at 10:11:43AM -0800, Stephen Boyd wrote:
> > > > @@ -265,6 +267,23 @@ connector_to_ti_sn_bridge(struct drm_connector *connector)
> > > >  static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
> > > >  {
> > > >       struct ti_sn_bridge *pdata = connector_to_ti_sn_bridge(connector);
> > > > +     struct edid *edid = pdata->edid;
> > > > +     int num, ret;
> > > > +
> > > > +     if (!edid) {
> > > > +             pm_runtime_get_sync(pdata->dev);
> > > > +             edid = pdata->edid = drm_get_edid(connector, &pdata->aux.ddc);
> > > > +             pm_runtime_put(pdata->dev);
> > >
> > > Is there any specific reason to use the indirect access method, compared
> > > to the direct method that translates access to an I2C ancillary address
> > > to an I2C-over-AUX transaction (see page 20 of SLLSEH2B) ? The direct
> > > method seems it would be more efficient.
> >
> > No I don't think it matters. I was just using the existing support code
> > that Sean wrote instead of digging into the details. Maybe Sean ran into
> > something earlier and abandoned that approach?
> 
> From reading the docs, it sounds as if there _could_ be a reason to
> use the indirect method. Specifically if the i2c host that the bridge
> is on doesn't support clock stretching then the direct method wouldn't
> work according to the docs. Is that something that we'd have to
> reasonably worry about?

I'm not sure. I'm going through BSP code that uses the direct method,
and I was wondering if it was just an implementation detail. Once I get
the display working on this board, I'll try to find time to compare the
two methods, to see if there's a significatant performance improvement
from the direct method. If there isn't, I won't bother.

-- 
Regards,

Laurent Pinchart
