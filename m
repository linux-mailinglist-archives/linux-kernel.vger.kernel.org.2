Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7643132EDA1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCEPDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhCEPDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:03:22 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E653FC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 07:03:21 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id w34so486836pga.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 07:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mlYSW9obf6ZHWc89hkL3cxC+hIY8OuKOPTUYIiFH0A=;
        b=J6MTCpdKN6RbHYeZCKONYiDSec9HN6g5MOD48exdVQl9rBzpoKxe/fXU+ub+InlwI9
         /C/O5SHDUrqEQzJLItBfA2St18/8xW4RlUw2Vdiq6eImAdMCgIT0yqEX7IQhpqQI2vFL
         wkpDjHAah8KBj+GLj5hxch3CWWG6By1Ccf9ydjZK3219BeHiOumA8j/3qN97VUW/L05V
         52imTqTtuj3UId+UJKsPtoBYPeCQD2C/OmCtRG2e5c//Thl94OKaJ9m3pDzQGcUEUgzU
         PF4V3iTv0FNO9x5d71GxoWw8s2s1gdCsB3D8ww4Bly8RJ3Q0Mt89b9ZbdKlKlCvBG6JK
         IuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mlYSW9obf6ZHWc89hkL3cxC+hIY8OuKOPTUYIiFH0A=;
        b=omEKTyK5i2PU8/XdYq/Wv8DzCFl5v7rB04g/GblQI7g4bkwRBX7nID9vx1qB6Futig
         UvXz8HXZOJUYkCNdyFiWc1UyAB5CFiyEaeLzJetBbIZBfr+ATw/z0t38r/AY3jskXJBB
         ExbvXDM1PPH6w+VrDkS9qWD3hhb62CojECMTJPDQfuFL7nB2Cjgj+Rq4VmDclGYu3qJC
         0H17BfTVkQ2AYgB+Whtbchd90MgPp70jYuifW8ELfOTjdeVBT5vqyMmMZoEm5trnGp2R
         9DV7f10mhaLvapfs1mR9ebZdwQQDl9OaiIwH3nyiUpMfck3C3cOd9TXA7k2aCjvBK+lY
         NGKg==
X-Gm-Message-State: AOAM530D+ZM+/jKHrkaICdfmRB5Xsie4tGilYUxMCHLWoT7jjlUVJmJG
        QA06n604HlyoeA6jp+8Hn+2XmjmTS6BdrfUq4EPlnwUSSz3csLlM
X-Google-Smtp-Source: ABdhPJx2AsMoIAD1vR1ykd/0xY4yQ2cyON9Ui1Hcd4m8KbzbgFcFYC24pz+4T8epFidgoa72a1Ero5G2nRWHf8lhQ54=
X-Received: by 2002:a63:ee4b:: with SMTP id n11mr9173347pgk.265.1614956601438;
 Fri, 05 Mar 2021 07:03:21 -0800 (PST)
MIME-Version: 1.0
References: <1607651182-12307-1-git-send-email-victor.liu@nxp.com> <1607651182-12307-3-git-send-email-victor.liu@nxp.com>
In-Reply-To: <1607651182-12307-3-git-send-email-victor.liu@nxp.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 5 Mar 2021 16:03:10 +0100
Message-ID: <CAG3jFyvJZkVRs4NnDmPmGk-Qkr0voyvf3JNvKFAKDyxcCNR3Cw@mail.gmail.com>
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

Hey Liu,

This patch seems to be included in both this series and the "Add some
DRM bridge drivers support for i.MX8qm/qxp SoCs" series. Instead of
having the two series have a conflict I would suggest either merging
them (if that makes sense) or removing this patch from one of them and
explicitly stating that there is a dependency on the other series.

(the patch itself still looks good though :) )

On Fri, 11 Dec 2020 at 02:56, Liu Ying <victor.liu@nxp.com> wrote:
>
> This patch allows LVDS PHYs to be configured through
> the generic functions and through a custom structure
> added to the generic union.
>
> The parameters added here are based on common LVDS PHY
> implementation practices.  The set of parameters
> should cover all potential users.
>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v2->v3:
> * No change.
>
> v1->v2:
> * No change.
>
>  include/linux/phy/phy-lvds.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/phy/phy.h      |  4 ++++
>  2 files changed, 52 insertions(+)
>  create mode 100644 include/linux/phy/phy-lvds.h
>
> diff --git a/include/linux/phy/phy-lvds.h b/include/linux/phy/phy-lvds.h
> new file mode 100644
> index 00000000..1b5b9d6
> --- /dev/null
> +++ b/include/linux/phy/phy-lvds.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2020 NXP
> + */
> +
> +#ifndef __PHY_LVDS_H_
> +#define __PHY_LVDS_H_
> +
> +/**
> + * struct phy_configure_opts_lvds - LVDS configuration set
> + *
> + * This structure is used to represent the configuration state of a
> + * LVDS phy.
> + */
> +struct phy_configure_opts_lvds {
> +       /**
> +        * @bits_per_lane_and_dclk_cycle:
> +        *
> +        * Number of bits per data lane and differential clock cycle.
> +        */
> +       unsigned int bits_per_lane_and_dclk_cycle;
> +
> +       /**
> +        * @differential_clk_rate:
> +        *
> +        * Clock rate, in Hertz, of the LVDS differential clock.
> +        */
> +       unsigned long differential_clk_rate;
> +
> +       /**
> +        * @lanes:
> +        *
> +        * Number of active, consecutive, data lanes, starting from
> +        * lane 0, used for the transmissions.
> +        */
> +       unsigned int lanes;
> +
> +       /**
> +        * @is_slave:
> +        *
> +        * Boolean, true if the phy is a slave which works together
> +        * with a master phy to support dual link transmission,
> +        * otherwise a regular phy or a master phy.
> +        */
> +       bool is_slave;
> +};
> +
> +#endif /* __PHY_LVDS_H_ */
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index e435bdb..d450b44 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -17,6 +17,7 @@
>  #include <linux/regulator/consumer.h>
>
>  #include <linux/phy/phy-dp.h>
> +#include <linux/phy/phy-lvds.h>
>  #include <linux/phy/phy-mipi-dphy.h>
>
>  struct phy;
> @@ -51,10 +52,13 @@ enum phy_mode {
>   *             the MIPI_DPHY phy mode.
>   * @dp:                Configuration set applicable for phys supporting
>   *             the DisplayPort protocol.
> + * @lvds:      Configuration set applicable for phys supporting
> + *             the LVDS phy mode.
>   */
>  union phy_configure_opts {
>         struct phy_configure_opts_mipi_dphy     mipi_dphy;
>         struct phy_configure_opts_dp            dp;
> +       struct phy_configure_opts_lvds          lvds;
>  };
>
>  /**
> --
> 2.7.4
>
