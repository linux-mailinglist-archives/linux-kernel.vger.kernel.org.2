Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121DB44C17F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhKJMrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJMrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:47:01 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDB5C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:44:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id B493E1F45477
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1636548252; bh=UMtO2IEIb9liiv4GEnJ/KRnLSOBjGePRppyxukrmtSY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mNvXs4akh9UACLvEBnjWYlK+qVtuLUFHG7bIgyZ/5u3gbZp3izHdr2jRkstgFD8m4
         PnMPiV+7r+GNcq7RUmpHqto+K6vh8oD42HlSNJajwrDqM9v9VtJMbEj8MQYAd3RILj
         N4nKoKG65IWr7s9xPu3lzhDjXVNaPh3+Nm90M73dGvB7fj7UaX4ZK5HjiHHB+UiF5G
         Zi9Qw/1z+td7m2M9fyfjNQASCb8yMd7ROc5TgEkbErWKmwCJ4dwr4x+6pEaAmxIWVN
         1jnLgyWYJ8IVd/DQxVC7n/SLZ/T2deD/RpAHznlmKeBGJEoRDWmTuCa0QTPyAatHSB
         R/DCoca2NGcMA==
Subject: Re: [PATCH v2 2/3] drm/bridge: parade-ps8640: Move real poweroff
 action to new function
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, a.hajda@samsung.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
References: <20211102093618.114928-1-angelogioacchino.delregno@collabora.com>
 <20211102093618.114928-2-angelogioacchino.delregno@collabora.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <d2fe91c8-ab29-7706-80f4-fe6619f07327@collabora.com>
Date:   Wed, 10 Nov 2021 14:44:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211102093618.114928-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.11.21 11:36, AngeloGioacchino Del Regno wrote:
> In preparation for varying the poweron error handling in function
> ps8640_bridge_poweron(), move function ps8640_bridge_poweroff() up
> and also move the actual logic to power off the chip to a new
> __ps8640_bridge_poweroff() function.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/gpu/drm/bridge/parade-ps8640.c | 37 ++++++++++++++------------
>   1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 8c5402947b3c..41f5d511d516 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -293,6 +293,26 @@ static int ps8640_bridge_vdo_control(struct ps8640 *ps_bridge,
>   	return 0;
>   }
>   
> +static void __ps8640_bridge_poweroff(struct ps8640 *ps_bridge)
> +{
> +	gpiod_set_value(ps_bridge->gpio_reset, 1);
> +	gpiod_set_value(ps_bridge->gpio_powerdown, 1);
> +	if (regulator_bulk_disable(ARRAY_SIZE(ps_bridge->supplies),
> +				   ps_bridge->supplies)) {
> +		DRM_ERROR("cannot disable regulators\n");
> +	}

That '{' is redundant

Thanks,
Danfa

> +}
> +
> +static void ps8640_bridge_poweroff(struct ps8640 *ps_bridge)
> +{
> +	if (!ps_bridge->powered)
> +		return;
> +
> +	__ps8640_bridge_poweroff(ps_bridge);
> +
> +	ps_bridge->powered = false;
> +}
> +
>   static int ps8640_bridge_poweron(struct ps8640 *ps_bridge)
>   {
>   	struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];
> @@ -361,23 +381,6 @@ static int ps8640_bridge_poweron(struct ps8640 *ps_bridge)
>   	return ret;
>   }
>   
> -static void ps8640_bridge_poweroff(struct ps8640 *ps_bridge)
> -{
> -	int ret;
> -
> -	if (!ps_bridge->powered)
> -		return;
> -
> -	gpiod_set_value(ps_bridge->gpio_reset, 1);
> -	gpiod_set_value(ps_bridge->gpio_powerdown, 1);
> -	ret = regulator_bulk_disable(ARRAY_SIZE(ps_bridge->supplies),
> -				     ps_bridge->supplies);
> -	if (ret < 0)
> -		DRM_ERROR("cannot disable regulators %d\n", ret);
> -
> -	ps_bridge->powered = false;
> -}
> -
>   static void ps8640_pre_enable(struct drm_bridge *bridge)
>   {
>   	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
> 
