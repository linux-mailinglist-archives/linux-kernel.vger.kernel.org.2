Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE189436C79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 23:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhJUVNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 17:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhJUVNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 17:13:47 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C8CC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 14:11:30 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v7so2455023ybq.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 14:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSqNmBmwNnZiz7NUUt6h5WqgJhP/Ov1sKBBTlbjHzNY=;
        b=XRsGY/xy50TtHIKbHoxMdCj0ZTTbuI00ENgALELUtUY5fWYRIggNJL5E9D5BcumiGv
         Ei4UdmBQiheCtzLfGJlbaFYE5i12T1IQTwLpPvfigWcSqRkugP1/kX/Pjq2XsNGTSP44
         PFr1T8N2/vslAGg9WT7uTPZ59vePFQjJmmHNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSqNmBmwNnZiz7NUUt6h5WqgJhP/Ov1sKBBTlbjHzNY=;
        b=4hNt6FlrqHLpWWt8nQvfABhGENivvVg7dN2i3xcnOsO0rwybO2M0HU0V+3JNSM84Fx
         KBFOViJ+rLWLSkYSQcvSoRniLcbjG13QVdQPU6PJK97EUYLd6XWvcWI4aR3QMPK1vP+N
         j3ahEDR14M8lNDDn9ou627Ik/ei92BBfHENyd7wXSf0Jh9g1wkg3SBppHWZDK0mio4Bi
         hEIV8oYFtqFg3oTXP1feloJlaqKTeWeOzLHv0eb0E6kIOZ8hYLRfJwSUt0IB12Mmxgk0
         IxnMKmBo5/Ej/bQpSJla7nbK5mWcCO1fKb2kHgeIRUP6HHac+6z7zG8OYgmwVeWkdaQF
         SagQ==
X-Gm-Message-State: AOAM532nwrYyXemr5NZlzXB1L87E6vi10KmNyBqh+Bemqkz/qZiZbQSa
        0TjJxbYrXp4AdjkDxnINuaG7AMSH5e5MCCzZShbolA==
X-Google-Smtp-Source: ABdhPJw0QcM0HApDBgJuV+OEUNHeWA+ga7NCtmdlz6dOcp04yOURrxn6vryKN9YFFkgXuaysz4ZPOkJdVmJ3cN8N41g=
X-Received: by 2002:a25:5044:: with SMTP id e65mr8298612ybb.57.1634850689972;
 Thu, 21 Oct 2021 14:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211016095644.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
 <20211016095644.2.I44ee57ef73528243acf8f29af8d2416b810e1a9d@changeid> <CAD=FV=XXOY_Rded_j6oysDkZ=e7_Gc1SPKPbkLK2DBdoKHWuKA@mail.gmail.com>
In-Reply-To: <CAD=FV=XXOY_Rded_j6oysDkZ=e7_Gc1SPKPbkLK2DBdoKHWuKA@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Thu, 21 Oct 2021 14:11:19 -0700
Message-ID: <CA+cxXh=R3U2uz2x0Mef3LZ-mta-+F9TXD0F+RGd5mDTWQOgZvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: parade-ps8640: Populate devices on aux-bus
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Mon, Oct 18, 2021 at 1:43 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sat, Oct 16, 2021 at 9:57 AM Philip Chen <philipchen@chromium.org> wrote:
> >
> > Conventionally, panel is listed under the root in the device tree.
> > When userland asks for display mode, ps8640 bridge is responsible
> > for returning EDID when ps8640_bridge_get_edid() is called.
> >
> > Now enable a new option of listing the panel under "aux-bus" of ps8640
> > bridge node in the device tree. In this case, panel driver can retrieve
> > EDID by triggering AUX transactions, without ps8640_bridge_get_edid()
> > calls at all.
> >
> > To prevent the "old" and "new" options from interfering with each
> > other's logic flow, disable DRM_BRIDGE_OP_EDID when the new option
> > is taken.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/bridge/parade-ps8640.c | 52 ++++++++++++++++++++------
> >  1 file changed, 40 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> > index acfe1bf0f936..98884f799ea8 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/regulator/consumer.h>
> >
> >  #include <drm/drm_bridge.h>
> > +#include <drm/drm_dp_aux_bus.h>
>
> You need a `select DRM_DP_AUX_BUS` in the Kconfig to avoid the errors
> that the build robot found for you.
Thanks for the tip!
I also found "select REGMAP_I2C" seems to be missing for ps8640.
although the build robot didn't complain.
Should I post a fix-up?

>
>
> >  #include <drm/drm_dp_helper.h>
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_of.h>
> > @@ -149,6 +150,24 @@ static inline struct ps8640 *aux_to_ps8640(struct drm_dp_aux *aux)
> >         return container_of(aux, struct ps8640, aux);
> >  }
> >
> > +static bool ps8640_of_panel_on_aux_bus(struct device *dev)
> > +{
> > +       struct device_node *bus, *panel;
> > +
> > +       if (!dev->of_node)
> > +               return false;
>
> You probably don't need the above check. I think things would be
> pretty broken if we didn't have an "of_node".
Removed in v2.
PTAL.
>
>
> > +       bus = of_get_child_by_name(dev->of_node, "aux-bus");
> > +       if (!bus)
> > +               return false;
> > +
> > +       panel = of_get_child_by_name(bus, "panel");
>
> of_node_put(bus);
Added in v2.
PTAL.

>
>
> > +       if (!panel)
> > +               return false;
>
> of_node_put(panel);
Added in v2.
PTAL.
>
>
> Other than the above, this looks reasonable to me.
>
> -Doug
