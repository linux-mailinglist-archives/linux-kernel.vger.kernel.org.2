Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D842944C18C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhKJMvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhKJMvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:51:20 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD84C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:48:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id A47AA1F45536
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1636548511; bh=jwsdJub026Wwb55SAebMDORQGiD7sU4q5d/5s4UeTkg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sOaxVK8iLM1IIiBSNuKl6RpdA3raabAR4Ef1dztCdzH8+31hU+41orsEBRtAJa5ZD
         lzais0ceb8fIGpwmYySyCXqg5WDtNTwqOsgbUEBrxHF1/l0/umaNzTQ90nTBGJNN3t
         3Gavr8rcHvETpLlBtSuUUlW6w4cMVq19fUfGw084oPfHF2IgpvgmVhg6xtyRlr/gAA
         pF8SJb+mHHNJ3wHyuznBSr+gctQ1Tamq2N3WS4eUYuCbF8OMkO9xcyxcZIyHKV108k
         3uaPHvwWLwtk6zR5qwJPAzhsrlPoXY5lxetg9LfdnJjBzIGQxUSbecR3T1HoJ18Se9
         7w+D6MwjybfsQ==
Subject: Re: [PATCH v2 3/3] drm/bridge: parade-ps8640: Perform full poweroff
 if poweron fails
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, a.hajda@samsung.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
References: <20211102093618.114928-1-angelogioacchino.delregno@collabora.com>
 <20211102093618.114928-3-angelogioacchino.delregno@collabora.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <6a1ee7d7-abc7-ed9f-fca0-91a0950b13a8@collabora.com>
Date:   Wed, 10 Nov 2021 14:48:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211102093618.114928-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.11.21 11:36, AngeloGioacchino Del Regno wrote:
> In function ps8640_bridge_poweron(), in case of a failure not relative
> to the regulators enablement, the code was disabling the regulators but
> the gpio changes that happened during the poweron sequence were not
> being reverted back to a clean poweroff state.
> 
> Since it is expected that, when we enter ps8640_bridge_poweron(), the
> powerdown and reset GPIOs are both in active state exactly as they were
> left in the poweroff function before, we can simply call function
> __ps8640_bridge_poweroff() in the failure case, reverting every change
> that was done during the power on sequence.
> 
> Of course it was chosen to call the poweroff function instead of adding
> code to revert the GPIO changes to the poweron one to avoid duplicating
> code, as we would be doing exactly what the poweroff function does.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

> ---
>   drivers/gpu/drm/bridge/parade-ps8640.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 41f5d511d516..ef1b51d8b676 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -344,7 +344,7 @@ static int ps8640_bridge_poweron(struct ps8640 *ps_bridge)
>   
>   	if (ret < 0) {
>   		DRM_ERROR("failed read PAGE2_GPIO_H: %d\n", ret);
> -		goto err_regulators_disable;
> +		goto err_poweroff;
>   	}
>   
>   	msleep(50);
> @@ -360,23 +360,22 @@ static int ps8640_bridge_poweron(struct ps8640 *ps_bridge)
>   	ret = regmap_update_bits(map, PAGE2_MCS_EN, MCS_EN, 0);
>   	if (ret < 0) {
>   		DRM_ERROR("failed write PAGE2_MCS_EN: %d\n", ret);
> -		goto err_regulators_disable;
> +		goto err_poweroff;
>   	}
>   
>   	/* Switch access edp panel's edid through i2c */
>   	ret = regmap_write(map, PAGE2_I2C_BYPASS, I2C_BYPASS_EN);
>   	if (ret < 0) {
>   		DRM_ERROR("failed write PAGE2_I2C_BYPASS: %d\n", ret);
> -		goto err_regulators_disable;
> +		goto err_poweroff;
>   	}
>   
>   	ps_bridge->powered = true;
>   
>   	return 0;
>   
> -err_regulators_disable:
> -	regulator_bulk_disable(ARRAY_SIZE(ps_bridge->supplies),
> -			       ps_bridge->supplies);
> +err_poweroff:
> +	__ps8640_bridge_poweroff(ps_bridge);
>   
>   	return ret;
>   }
> 
