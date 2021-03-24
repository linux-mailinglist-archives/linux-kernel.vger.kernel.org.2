Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA71347981
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbhCXNWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:22:34 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:51150 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbhCXNV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:21:57 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F585r6cDpz1qtfD;
        Wed, 24 Mar 2021 14:21:52 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F585r4y3wz1qsk8;
        Wed, 24 Mar 2021 14:21:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Ec622X1yBJ6V; Wed, 24 Mar 2021 14:21:50 +0100 (CET)
X-Auth-Info: Wy0aHOg7MRsGS0dgJhi4wXhn+NlMDJsLXSIT1LPaZwE=
Received: from [10.88.0.186] (dslb-084-056-254-233.084.056.pools.vodafone-ip.de [84.56.254.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 24 Mar 2021 14:21:50 +0100 (CET)
Subject: Re: [PATCH v3 2/2] drm: bridge: Add TI SN65DSI83/84/85 DSI to LVDS
 bridge
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amarula@amarulasolutions.com
References: <20210214174453.104616-1-jagan@amarulasolutions.com>
 <20210214174453.104616-2-jagan@amarulasolutions.com>
From:   Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
Message-ID: <8cac7848-3a8e-c597-1efc-c67fb6daba25@denx.de>
Date:   Wed, 24 Mar 2021 14:21:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210214174453.104616-2-jagan@amarulasolutions.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On 2021-02-14 18:44, Jagan Teki wrote:
[...]
> +static void sn65dsi_enable(struct drm_bridge *bridge)
> +{
> +	struct sn65dsi *sn = bridge_to_sn65dsi(bridge);
> +	struct drm_display_mode *mode = bridge_to_mode(bridge);
> +	int bpp = mipi_dsi_pixel_format_to_bpp(sn->dsi->format);
> +	unsigned int lanes = sn->dsi->lanes;
> +	unsigned int pixel_clk = mode->clock * 1000;
> +	unsigned int dsi_clk = pixel_clk * bpp / (lanes * 2);
> +	unsigned int val;
> +
> +	/* reset SOFT_RESET bit */
> +	regmap_write(sn->regmap, SN65DSI_SOFT_RESET, 0x0);
> +
> +	msleep(10);
> +
> +	/* reset PLL_EN bit */
> +	regmap_write(sn->regmap, SN65DSI_CLK_PLL, 0x0);
> +
> +	msleep(10);
> +
> +	/* setup lvds clock */
> +	val = sn65dsi_get_clk_range(0, 5, pixel_clk, 25000000, 25000000);
> +	if (val < 0) {

val is unsigned int, so it can never be negative so this condition is 
always false. Same error further down in that function as well.

regards,
Claudius
