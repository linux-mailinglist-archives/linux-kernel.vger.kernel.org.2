Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97E136800D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhDVMHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhDVMHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:07:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85756C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:07:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p6so37874611wrn.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jhpmYTg4Vp1LA+W35IrfrjHI/xFsmZ2K+o/m22RJAh0=;
        b=I4EVfUDwG6tP/g+tDNNNvRZX+z1HoktzTyRPsYZhGx3dL2jZC+BvVi5UDRI1nzzZev
         jbQ+Zbvvnd2evsfTandf0RwP0/rxByagLLwUCbxYnaYwhHlQTr0rfA5o6rl5UDBmcVO4
         ID4UieIx7envlEfMeg7YLfH3aXbtS1sqsT09K/kp2RpUjeM14fV2Xim9XRHQ+5tLTICj
         CSWPswWmNIZKwcN/P4fYF5S/0jnjqsc8WKULl98daJZXMFxftHeigQ1vpLjh9TzQcuRy
         ebwbG8saRt7VK5Ljp0xOXCg7vQpbrrl0vBbNvntRcGXCMIuAubfRch4WDjuq3o0dtYSs
         slhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jhpmYTg4Vp1LA+W35IrfrjHI/xFsmZ2K+o/m22RJAh0=;
        b=Bva35iSAKEdFSWUmVpFv3gpDrybgkZJFhz9rk9J84An466KdrLfc0uoFEj9uoSKP4e
         bTOnNtHJS4BAfXTCBGBnI90zehqr98usLRgHOduFPbNdx5l8xL6JppGGT6zhw0aJoaoO
         qoXLsrfQXLVc56IwoTBGAlnuJze1Qy9Iph0TyIMdY47vJE21R9A8WwubuPZnP9uArgh1
         5kWLYLYeRJ/+/5YQnDBD1MpwL0oyxxETNNv7asmUXzjwBm3uLKqRH5UhhkQjapgq9WLJ
         Pnd6DwV5tpTf9cJXzgiI2qa3onFvKqDL5C2FoUqtYWdCec4vMpaXsbyJUU5r8EgTCIWM
         wETQ==
X-Gm-Message-State: AOAM530rpd5fscPlboXTF3LFVZL0qsx6FYPk9SEI9WhWXz9xLMFmJav4
        lz7T2jaMiSkTVsuRLWHYU2sGrw==
X-Google-Smtp-Source: ABdhPJxKV4nRhgozkIzL0OgqkoJfaQIrmU05LEiL/estxrSrhr0s6lCR+8/jyaEeBARScjFTNYZagw==
X-Received: by 2002:a5d:6e06:: with SMTP id h6mr3731212wrz.201.1619093226139;
        Thu, 22 Apr 2021 05:07:06 -0700 (PDT)
Received: from [10.1.3.29] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g3sm3289419wrp.46.2021.04.22.05.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 05:07:05 -0700 (PDT)
Subject: Re: [PATCH v2] drm/bridge: nwl-dsi: Get MIPI DSI controller and PHY
 ready in ->mode_set()
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
References: <1619068455-1932-1-git-send-email-victor.liu@nxp.com>
 <36441ffb-2a79-f965-efc8-042844bc349d@baylibre.com>
 <460bdf3547942fdca82a19e164162187917e4d57.camel@nxp.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <178556dc-a011-e1e6-4147-dbf584672d32@baylibre.com>
Date:   Thu, 22 Apr 2021 14:07:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <460bdf3547942fdca82a19e164162187917e4d57.camel@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/04/2021 11:31, Liu Ying wrote:
> Hi Neil,
> 
> On Thu, 2021-04-22 at 10:48 +0200, Neil Armstrong wrote:
>> Hi,
>>
>> On 22/04/2021 07:14, Liu Ying wrote:
>>> Some MIPI DSI panel drivers like 'raydium,rm68200' send
>>> MIPI_DCS_SET_DISPLAY_ON commands in panel_funcs->prepare(), which
>>> requires the MIPI DSI controller and PHY to be ready beforehand.
>>> Without this patch, the nwl-dsi driver gets the MIPI DSI controller
>>> and PHY ready in bridge_funcs->pre_enable(), which happens after
>>> the panel_funcs->prepare(). So, this patch shifts the bridge operation
>>> ealier from bridge_funcs->pre_enable() to bridge_funcs->mode_set().
>>
>> This makes sense, this is how we do on the synopsys dw mipi dsi driver.
>>
>>> This way, more MIPI DSI panels can connect to this nwl-dsi bridge.
>>> Care is taken to make sure bridge_funcs->mode_set()/atomic_disable()
>>> are called in pairs, which includes removing a check on unchanged HS
>>> clock rate and forcing a full modeset when only connector's DPMS is
>>> brought out of "Off" status.
>>
>> I would split the changes in multiple patches to clarify the changes.
> 
> Maybe, I can split this into the below 3 patches:
> 1) Remove a check on unchanged HS clock rate from ->mode_set().
> 2) Force a full modeset when only connector's DPMS is brought out of
> "Off" status. This will be done in ->atomic_check() together with the
> fixup for H/VSYNC polarities.
> 3) Shift the bridge operation as the last step.
> 
> I'll mention that 1) & 2) are needed by 3) in their commit message.

Sure, you can also put this split explanation in the cover letter.

> 
> Does this split-up sound reasonable?

Yes makes sense, thanks

Neil

> 
> Thanks,
> Liu Ying
> 
>>
>> Neil
>>
>>> Cc: Andrzej Hajda <a.hajda@samsung.com>
>>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>>> Cc: Robert Foss <robert.foss@linaro.org>
>>> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
>>> Cc: Jonas Karlman <jonas@kwiboo.se>
>>> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
>>> Cc: David Airlie <airlied@linux.ie>
>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>> Cc: Guido Günther <agx@sigxcpu.org>
>>> Cc: Robert Chiras <robert.chiras@nxp.com>
>>> Cc: NXP Linux Team <linux-imx@nxp.com>
>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>> ---
>>> v1->v2:
>>> * Fix commit message typo - s/unchange/unchanged/
>>>
>>>  drivers/gpu/drm/bridge/nwl-dsi.c | 86 +++++++++++++++++++++-------------------
>>>  1 file changed, 46 insertions(+), 40 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
>>> index be6bfc5..229f0b1 100644
>>> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
>>> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
>>> @@ -21,6 +21,7 @@
>>>  #include <linux/sys_soc.h>
>>>  #include <linux/time64.h>
>>>  
>>> +#include <drm/drm_atomic_state_helper.h>
>>>  #include <drm/drm_bridge.h>
>>>  #include <drm/drm_mipi_dsi.h>
>>>  #include <drm/drm_of.h>
>>> @@ -661,7 +662,7 @@ static irqreturn_t nwl_dsi_irq_handler(int irq, void *data)
>>>  	return IRQ_HANDLED;
>>>  }
>>>  
>>> -static int nwl_dsi_enable(struct nwl_dsi *dsi)
>>> +static int nwl_dsi_mode_set(struct nwl_dsi *dsi)
>>>  {
>>>  	struct device *dev = dsi->dev;
>>>  	union phy_configure_opts *phy_cfg = &dsi->phy_cfg;
>>> @@ -748,7 +749,9 @@ static int nwl_dsi_disable(struct nwl_dsi *dsi)
>>>  	return 0;
>>>  }
>>>  
>>> -static void nwl_dsi_bridge_disable(struct drm_bridge *bridge)
>>> +static void
>>> +nwl_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
>>> +			      struct drm_bridge_state *old_bridge_state)
>>>  {
>>>  	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
>>>  	int ret;
>>> @@ -809,17 +812,6 @@ static int nwl_dsi_get_dphy_params(struct nwl_dsi *dsi,
>>>  	return 0;
>>>  }
>>>  
>>> -static bool nwl_dsi_bridge_mode_fixup(struct drm_bridge *bridge,
>>> -				      const struct drm_display_mode *mode,
>>> -				      struct drm_display_mode *adjusted_mode)
>>> -{
>>> -	/* At least LCDIF + NWL needs active high sync */
>>> -	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
>>> -	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
>>> -
>>> -	return true;
>>> -}
>>> -
>>>  static enum drm_mode_status
>>>  nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>>>  			  const struct drm_display_info *info,
>>> @@ -837,6 +829,29 @@ nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>>>  	return MODE_OK;
>>>  }
>>>  
>>> +static int nwl_dsi_bridge_atomic_check(struct drm_bridge *bridge,
>>> +				       struct drm_bridge_state *bridge_state,
>>> +				       struct drm_crtc_state *crtc_state,
>>> +				       struct drm_connector_state *conn_state)
>>> +{
>>> +	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
>>> +
>>> +	/* At least LCDIF + NWL needs active high sync */
>>> +	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
>>> +	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
>>> +
>>> +	/*
>>> +	 * Do a full modeset if crtc_state->active is changed to be true.
>>> +	 * This ensures our ->mode_set() is called to get the DSI controller
>>> +	 * and the PHY ready to send DCS commands, when only the connector's
>>> +	 * DPMS is brought out of "Off" status.
>>> +	 */
>>> +	if (crtc_state->active_changed && crtc_state->active)
>>> +		crtc_state->mode_changed = true;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static void
>>>  nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
>>>  			const struct drm_display_mode *mode,
>>> @@ -852,13 +867,6 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
>>>  	if (ret < 0)
>>>  		return;
>>>  
>>> -	/*
>>> -	 * If hs clock is unchanged, we're all good - all parameters are
>>> -	 * derived from it atm.
>>> -	 */
>>> -	if (new_cfg.mipi_dphy.hs_clk_rate == dsi->phy_cfg.mipi_dphy.hs_clk_rate)
>>> -		return;
>>> -
>>>  	phy_ref_rate = clk_get_rate(dsi->phy_ref_clk);
>>>  	DRM_DEV_DEBUG_DRIVER(dev, "PHY at ref rate: %lu\n", phy_ref_rate);
>>>  	/* Save the new desired phy config */
>>> @@ -866,14 +874,8 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
>>>  
>>>  	memcpy(&dsi->mode, adjusted_mode, sizeof(dsi->mode));
>>>  	drm_mode_debug_printmodeline(adjusted_mode);
>>> -}
>>>  
>>> -static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
>>> -{
>>> -	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
>>> -	int ret;
>>> -
>>> -	pm_runtime_get_sync(dsi->dev);
>>> +	pm_runtime_get_sync(dev);
>>>  
>>>  	if (clk_prepare_enable(dsi->lcdif_clk) < 0)
>>>  		return;
>>> @@ -883,27 +885,29 @@ static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
>>>  	/* Step 1 from DSI reset-out instructions */
>>>  	ret = reset_control_deassert(dsi->rst_pclk);
>>>  	if (ret < 0) {
>>> -		DRM_DEV_ERROR(dsi->dev, "Failed to deassert PCLK: %d\n", ret);
>>> +		DRM_DEV_ERROR(dev, "Failed to deassert PCLK: %d\n", ret);
>>>  		return;
>>>  	}
>>>  
>>>  	/* Step 2 from DSI reset-out instructions */
>>> -	nwl_dsi_enable(dsi);
>>> +	nwl_dsi_mode_set(dsi);
>>>  
>>>  	/* Step 3 from DSI reset-out instructions */
>>>  	ret = reset_control_deassert(dsi->rst_esc);
>>>  	if (ret < 0) {
>>> -		DRM_DEV_ERROR(dsi->dev, "Failed to deassert ESC: %d\n", ret);
>>> +		DRM_DEV_ERROR(dev, "Failed to deassert ESC: %d\n", ret);
>>>  		return;
>>>  	}
>>>  	ret = reset_control_deassert(dsi->rst_byte);
>>>  	if (ret < 0) {
>>> -		DRM_DEV_ERROR(dsi->dev, "Failed to deassert BYTE: %d\n", ret);
>>> +		DRM_DEV_ERROR(dev, "Failed to deassert BYTE: %d\n", ret);
>>>  		return;
>>>  	}
>>>  }
>>>  
>>> -static void nwl_dsi_bridge_enable(struct drm_bridge *bridge)
>>> +static void
>>> +nwl_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
>>> +			     struct drm_bridge_state *old_bridge_state)
>>>  {
>>>  	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
>>>  	int ret;
>>> @@ -948,14 +952,16 @@ static void nwl_dsi_bridge_detach(struct drm_bridge *bridge)
>>>  }
>>>  
>>>  static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
>>> -	.pre_enable = nwl_dsi_bridge_pre_enable,
>>> -	.enable     = nwl_dsi_bridge_enable,
>>> -	.disable    = nwl_dsi_bridge_disable,
>>> -	.mode_fixup = nwl_dsi_bridge_mode_fixup,
>>> -	.mode_set   = nwl_dsi_bridge_mode_set,
>>> -	.mode_valid = nwl_dsi_bridge_mode_valid,
>>> -	.attach	    = nwl_dsi_bridge_attach,
>>> -	.detach	    = nwl_dsi_bridge_detach,
>>> +	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
>>> +	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
>>> +	.atomic_reset		= drm_atomic_helper_bridge_reset,
>>> +	.atomic_check		= nwl_dsi_bridge_atomic_check,
>>> +	.atomic_enable		= nwl_dsi_bridge_atomic_enable,
>>> +	.atomic_disable		= nwl_dsi_bridge_atomic_disable,
>>> +	.mode_set		= nwl_dsi_bridge_mode_set,
>>> +	.mode_valid		= nwl_dsi_bridge_mode_valid,
>>> +	.attach			= nwl_dsi_bridge_attach,
>>> +	.detach			= nwl_dsi_bridge_detach,
>>>  };
>>>  
>>>  static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
>>>
> 

