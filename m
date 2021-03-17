Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B48633EE3E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhCQKXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:23:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhCQKWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:22:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D3F064EE1;
        Wed, 17 Mar 2021 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615976572;
        bh=desTsx3WQtjTaVBjhTB+jOTKBQ4fVjhRjO2BfJzcTvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uXWROD1l0QOnrXuCYjcLc4/v2MYTS0MwDMSd1ekyiUJ89MDjNelAY0o5t77I0zkam
         CLm01YdIrPgKjQzcfcCcPpRQZzm9ZIO2ywGBPKv8k+2maxCepIZFNRkqCxszU5JRnH
         OPM7O9/qIjOqaGzm2SKAPl5eRnVt/ziIU//lRqzH+wfmJhT4ZAx6PZPQ5EVX5k55ss
         sZnVQKwsIqWKvBu+nDrHJqLE2806MBQ1UZTBeWrSpFng878P0gmi2BE+HvInRYE9AP
         4MpaCOoDj6Wvj1lJW+D3HgKBVrNgfVmlhWuZUWnG96a7R77FB+JzZfk1wDuSXd/sq7
         XakProKWsCPUQ==
Date:   Wed, 17 Mar 2021 15:52:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        robh+dt@kernel.org, a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agx@sigxcpu.org,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm,
        robert.foss@linaro.org
Subject: Re: [PATCH v4 2/5] phy: Add LVDS configuration options
Message-ID: <YFHYeZ/ZVqNiG/yo@vkoul-mobl.Dlink>
References: <1615175541-29009-1-git-send-email-victor.liu@nxp.com>
 <1615175541-29009-3-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615175541-29009-3-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-03-21, 11:52, Liu Ying wrote:
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
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v3->v4:
> * Add Robert's R-b tag.
> 
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
> +	/**
> +	 * @bits_per_lane_and_dclk_cycle:
> +	 *
> +	 * Number of bits per data lane and differential clock cycle.
> +	 */

Can we have these in kernel-doc style please, similar to style in linux/phy/phy.h

> +	unsigned int bits_per_lane_and_dclk_cycle;
> +
> +	/**
> +	 * @differential_clk_rate:
> +	 *
> +	 * Clock rate, in Hertz, of the LVDS differential clock.
> +	 */
> +	unsigned long differential_clk_rate;
> +
> +	/**
> +	 * @lanes:
> +	 *
> +	 * Number of active, consecutive, data lanes, starting from
> +	 * lane 0, used for the transmissions.
> +	 */
> +	unsigned int lanes;
> +
> +	/**
> +	 * @is_slave:
> +	 *
> +	 * Boolean, true if the phy is a slave which works together
> +	 * with a master phy to support dual link transmission,
> +	 * otherwise a regular phy or a master phy.
> +	 */
> +	bool is_slave;
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
>   *		the MIPI_DPHY phy mode.
>   * @dp:		Configuration set applicable for phys supporting
>   *		the DisplayPort protocol.
> + * @lvds:	Configuration set applicable for phys supporting
> + *		the LVDS phy mode.
>   */
>  union phy_configure_opts {
>  	struct phy_configure_opts_mipi_dphy	mipi_dphy;
>  	struct phy_configure_opts_dp		dp;
> +	struct phy_configure_opts_lvds		lvds;
>  };
>  
>  /**
> -- 
> 2.7.4

-- 
~Vinod
