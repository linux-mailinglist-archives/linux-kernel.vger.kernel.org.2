Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B9832EEB2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhCEPXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhCEPXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:23:23 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A02C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 07:23:23 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 18so2354798pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 07:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pp062KYeaR4WdsQXRbsz4rfCGOxQmDJuQ9W1VEyK3XQ=;
        b=XHY3umtG6cjNXchXwqhPDXV4lVZUK0S5fW9GSsxoucPUht3GHSVNb1wK4JW20COpge
         Kqz7MFoCSZWVO/+bG0amcRbQtJqnKA/SxEu8dnIcS3ppxsfYeL0fYGNDyQn7X5OtC32f
         zqomNiWePsioBMvBJenPU/IDPJj5cifKY1PW7uFeuPe1Jwh6rVr/UYue7Fga3n8+q62d
         mm8jiMOa7hhFQw4yR2KDm2nHVXOF4Lc1l7MM0nR0PW2di4BF4UQDqczyCxesi10S5osZ
         SubotUmlI16dsQX4yxKzuccjEk1PLXzTI+H6FJD4fNTm/ok+c9zb91nzZsh+Qj76i/iB
         85xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pp062KYeaR4WdsQXRbsz4rfCGOxQmDJuQ9W1VEyK3XQ=;
        b=kWaQNGFXUCAy2IevvtEqrhObOF6rCcLHBYdc2UQqkFbEeu9QavdHSJve+zE/Icl6yR
         sNw8sL7dVveNl4BcjBizcEhKEgH2copFl2WIEwL22UAW97BXr9uHr+Smur6kBh26a4UO
         C/Mq/Uw6V2U57kQfEZD9PUSglMfb9fdOLZS+/5HvRa2X3PrhekC1+V2hmELJfwzghftT
         vYuF6OkVn9EfArxW05CkoZcvKbfznlW7TtIdbNf6gZTR9qG6Bmi/v2c3GaqEomDJJ4ds
         tSMSwtT0XeHA6gYQIKiy6Psf5iOf46nVxTeiYQaNDVy+8lPcuMN3Mb9JmHAeYALLQJCU
         eDsg==
X-Gm-Message-State: AOAM531OCzrnhXCvf6s4lAf52knu2uTcKuTZXu8nspUaZxqY3B7Is0N7
        PD2O6ro3yULqD6b5Lg+u1lGOsvDG09ELYIdLgh46vQ==
X-Google-Smtp-Source: ABdhPJz46wOWIASXT1kKWJyR4O8v/oxVpCevy3CODCbaD5IF1jfHipEWWaLk5dNiOtwqfdCpLhba8i7dJT+6NMfE55A=
X-Received: by 2002:aa7:9843:0:b029:1ed:cc86:fa0 with SMTP id
 n3-20020aa798430000b02901edcc860fa0mr9324771pfq.39.1614957803176; Fri, 05 Mar
 2021 07:23:23 -0800 (PST)
MIME-Version: 1.0
References: <1607651182-12307-1-git-send-email-victor.liu@nxp.com>
 <1607651182-12307-3-git-send-email-victor.liu@nxp.com> <CAG3jFyvJZkVRs4NnDmPmGk-Qkr0voyvf3JNvKFAKDyxcCNR3Cw@mail.gmail.com>
In-Reply-To: <CAG3jFyvJZkVRs4NnDmPmGk-Qkr0voyvf3JNvKFAKDyxcCNR3Cw@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 5 Mar 2021 16:23:12 +0100
Message-ID: <CAG3jFyuSBadaoTP+j8O9cDOCrS+SohGP1GqWdv-018gTZz_yAg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] phy: Add LVDS configuration options
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, kishon@ti.com,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        agx@sigxcpu.org, robert.chiras@nxp.com, martin.kepplinger@puri.sm
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 at 16:03, Robert Foss <robert.foss@linaro.org> wrote:
>
> Hey Liu,
>
> This patch seems to be included in both this series and the "Add some
> DRM bridge drivers support for i.MX8qm/qxp SoCs" series. Instead of
> having the two series have a conflict I would suggest either merging
> them (if that makes sense) or removing this patch from one of them and
> explicitly stating that there is a dependency on the other series.
>
> (the patch itself still looks good though :) )

After having looked through the rest of the series, and seeing it is
pretty much ready to be merged. Feel free to add my r-b to this patch.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

>
> On Fri, 11 Dec 2020 at 02:56, Liu Ying <victor.liu@nxp.com> wrote:
> >
> > This patch allows LVDS PHYs to be configured through
> > the generic functions and through a custom structure
> > added to the generic union.
> >
> > The parameters added here are based on common LVDS PHY
> > implementation practices.  The set of parameters
> > should cover all potential users.
> >
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> > v2->v3:
> > * No change.
> >
> > v1->v2:
> > * No change.
> >
> >  include/linux/phy/phy-lvds.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/phy/phy.h      |  4 ++++
> >  2 files changed, 52 insertions(+)
> >  create mode 100644 include/linux/phy/phy-lvds.h
> >
> > diff --git a/include/linux/phy/phy-lvds.h b/include/linux/phy/phy-lvds.h
> > new file mode 100644
> > index 00000000..1b5b9d6
> > --- /dev/null
> > +++ b/include/linux/phy/phy-lvds.h
> > @@ -0,0 +1,48 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright 2020 NXP
> > + */
> > +
> > +#ifndef __PHY_LVDS_H_
> > +#define __PHY_LVDS_H_
> > +
> > +/**
> > + * struct phy_configure_opts_lvds - LVDS configuration set
> > + *
> > + * This structure is used to represent the configuration state of a
> > + * LVDS phy.
> > + */
> > +struct phy_configure_opts_lvds {
> > +       /**
> > +        * @bits_per_lane_and_dclk_cycle:
> > +        *
> > +        * Number of bits per data lane and differential clock cycle.
> > +        */
> > +       unsigned int bits_per_lane_and_dclk_cycle;
> > +
> > +       /**
> > +        * @differential_clk_rate:
> > +        *
> > +        * Clock rate, in Hertz, of the LVDS differential clock.
> > +        */
> > +       unsigned long differential_clk_rate;
> > +
> > +       /**
> > +        * @lanes:
> > +        *
> > +        * Number of active, consecutive, data lanes, starting from
> > +        * lane 0, used for the transmissions.
> > +        */
> > +       unsigned int lanes;
> > +
> > +       /**
> > +        * @is_slave:
> > +        *
> > +        * Boolean, true if the phy is a slave which works together
> > +        * with a master phy to support dual link transmission,
> > +        * otherwise a regular phy or a master phy.
> > +        */
> > +       bool is_slave;
> > +};
> > +
> > +#endif /* __PHY_LVDS_H_ */
> > diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> > index e435bdb..d450b44 100644
> > --- a/include/linux/phy/phy.h
> > +++ b/include/linux/phy/phy.h
> > @@ -17,6 +17,7 @@
> >  #include <linux/regulator/consumer.h>
> >
> >  #include <linux/phy/phy-dp.h>
> > +#include <linux/phy/phy-lvds.h>
> >  #include <linux/phy/phy-mipi-dphy.h>
> >
> >  struct phy;
> > @@ -51,10 +52,13 @@ enum phy_mode {
> >   *             the MIPI_DPHY phy mode.
> >   * @dp:                Configuration set applicable for phys supporting
> >   *             the DisplayPort protocol.
> > + * @lvds:      Configuration set applicable for phys supporting
> > + *             the LVDS phy mode.
> >   */
> >  union phy_configure_opts {
> >         struct phy_configure_opts_mipi_dphy     mipi_dphy;
> >         struct phy_configure_opts_dp            dp;
> > +       struct phy_configure_opts_lvds          lvds;
> >  };
> >
> >  /**
> > --
> > 2.7.4
> >
