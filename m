Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BA83C6FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 13:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhGMLnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 07:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbhGMLnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:43:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A58FC0613DD;
        Tue, 13 Jul 2021 04:40:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y21-20020a7bc1950000b02902161fccabf1so1401039wmi.2;
        Tue, 13 Jul 2021 04:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y85wNOtup5hmkCmTfLo1pIpQShIZxRh6DcPrPzi4Ol4=;
        b=YwuIbl+0FSKIRy3WwoIS7w4iUYVf3dnRDGgv33bj6Hij0BnxVWbphZn1bpgpcEgFfh
         IDKr4p16DEwBdLfCIzhWXIyZdJd71+xfo6pKH4P6tgdCja8jIV9lBGct6C3L2xTBDrWL
         3mdgEO83Mif3eTMJiG0RyXe/RRcjhncA9t+VDMgItfpu0/v0LobiH5JylvILh16cjgDc
         t0WEKux/2SRyaWgixRe7gd+uPpNVg7veO9wl5CvJ98B2wnY0xU8HZBeM5iUqyri+2bsa
         r6V+gkU+9oob4xkqgg2BvaFmtDOB6y5ZWJKh30mKvAiEmlmucsuH3hCxZ6XVvp97Fnj2
         ejxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y85wNOtup5hmkCmTfLo1pIpQShIZxRh6DcPrPzi4Ol4=;
        b=XmZCWvkG9JzG9uxstaQA41UXWMPsbIN2n/VCSdtB87jL/XmOfNBCkNEIpH66p3acAj
         6yrLH42a7k/hZiYpKs42oLoXUntObrhE9e3zXB1cXAVTRJqLFWngT2k0IN//TyV45Pcx
         KvnOus8Hi6MYdAdPDAqLfV0ZVYszeiaJx6nCAa6dppkkY223zDnweTKBxAYhvuIAWimH
         rhLluV5S4yUSidCmqriU4Y764PrivSFLp1yHUEzMAoEYdYH5YCPVXjOartySG+l8mZJR
         UajoS/X2UfoBkiwngnYu8HtdffVaTzD6fzhyAIsIgeYs/Ugrqnq2cooV3ug0do5x1Lqy
         EF+w==
X-Gm-Message-State: AOAM531KM8eMmOR5nifoWXqsxerm6z+nfZKpcN9Q/Rjh/vfbcjkGdRRt
        Rz4kcCmUlZCJMlzM7/fm3w==
X-Google-Smtp-Source: ABdhPJxZXyl/yIp04pwFo98is7aZrayOSjjNfIszAcOIsR5PYVsPF3guD0dMbpg0o0JYYkbyr0nuAQ==
X-Received: by 2002:a1c:7411:: with SMTP id p17mr19925287wmc.116.1626176455013;
        Tue, 13 Jul 2021 04:40:55 -0700 (PDT)
Received: from [192.168.200.247] (ip5b429fd6.dynamic.kabel-deutschland.de. [91.66.159.214])
        by smtp.gmail.com with ESMTPSA id t15sm17193008wrx.17.2021.07.13.04.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 04:40:54 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] drm/rockchip: dw_hdmi: add rk3568 support
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, algea.cao@rock-chips.com,
        andy.yan@rock-chips.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20210707120323.401785-1-benjamin.gaignard@collabora.com>
 <20210707120323.401785-3-benjamin.gaignard@collabora.com>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <a8c5a263-26a6-d4bf-47e7-9266ca1ae5a8@gmail.com>
Date:   Tue, 13 Jul 2021 13:40:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707120323.401785-3-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Am 07.07.21 um 14:03 schrieb Benjamin Gaignard:
> Add a new dw_hdmi_plat_data struct and new compatible for rk3568.
> This version of the HDMI hardware block need two clocks to provide
> phy reference clock: hclk_vio and hclk.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 2:
> - Add the clocks needed for the phy.

If got Alega's comment correct, it wasn't about the hclks.
It looks like for this variant, there is another reference clock 
required (for the phy) like vpll is already (looks like downstream uses 
HPLL ( = "HDMI-PLL" ?) for that - which also has to switch the frequency 
according the the drm mode rate - the two clocks you added here are get 
just enabled (and disabled) here.

Alega, Andy: Is it really required to enable hclk_vio and hclk(_vop) in 
the hdmi driver? Are they required to be enabled for the other output 
variants (i.e. mipi, dsi, rgb ....) as well and shouldn't better be 
enabled in the (not-yet existing) vop2 driver?

Overall: I'm not sure of the benefit of adding this hdmi variant for a 
SoC where the display driver isn't implemented upstream yet. The "VOP2" 
IP seems widely new and should probably be ported first. (even if the 
HDMI part seems a low hanging fruit according to the vendor sources)

Best,
Alex

> 
>   drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 68 +++++++++++++++++++++
>   1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index 830bdd5e9b7ce..dc0e255e45745 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -50,6 +50,10 @@
>   #define RK3399_GRF_SOC_CON20		0x6250
>   #define RK3399_HDMI_LCDC_SEL		BIT(6)
>   
> +#define RK3568_GRF_VO_CON1		0x0364
> +#define RK3568_HDMI_SDAIN_MSK		BIT(15)
> +#define RK3568_HDMI_SCLIN_MSK		BIT(14)
> +
>   #define HIWORD_UPDATE(val, mask)	(val | (mask) << 16)
>   
>   /**
> @@ -71,6 +75,8 @@ struct rockchip_hdmi {
>   	const struct rockchip_hdmi_chip_data *chip_data;
>   	struct clk *vpll_clk;
>   	struct clk *grf_clk;
> +	struct clk *hclk_vio;
> +	struct clk *hclk_vop;
>   	struct dw_hdmi *hdmi;
>   	struct phy *phy;
>   };
> @@ -216,6 +222,26 @@ static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
>   		return PTR_ERR(hdmi->grf_clk);
>   	}
>   
> +	hdmi->hclk_vio = devm_clk_get(hdmi->dev, "hclk_vio");
> +	if (PTR_ERR(hdmi->hclk_vio) == -ENOENT) {
> +		hdmi->hclk_vio = NULL;
> +	} else if (PTR_ERR(hdmi->hclk_vio) == -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(hdmi->hclk_vio)) {
> +		dev_err(hdmi->dev, "failed to get hclk_vio clock\n");
> +		return PTR_ERR(hdmi->hclk_vio);
> +	}
> +
> +	hdmi->hclk_vop = devm_clk_get(hdmi->dev, "hclk");
> +	if (PTR_ERR(hdmi->hclk_vop) == -ENOENT) {
> +		hdmi->hclk_vop = NULL;
> +	} else if (PTR_ERR(hdmi->hclk_vop) == -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(hdmi->hclk_vop)) {
> +		dev_err(hdmi->dev, "failed to get hclk_vop clock\n");
> +		return PTR_ERR(hdmi->hclk_vop);
> +	}
> +
>   	return 0;
>   }
>   
> @@ -467,6 +493,19 @@ static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
>   	.use_drm_infoframe = true,
>   };
>   
> +static struct rockchip_hdmi_chip_data rk3568_chip_data = {
> +	.lcdsel_grf_reg = -1,
> +};
> +
> +static const struct dw_hdmi_plat_data rk3568_hdmi_drv_data = {
> +	.mode_valid = dw_hdmi_rockchip_mode_valid,
> +	.mpll_cfg   = rockchip_mpll_cfg,
> +	.cur_ctr    = rockchip_cur_ctr,
> +	.phy_config = rockchip_phy_config,
> +	.phy_data = &rk3568_chip_data,
> +	.use_drm_infoframe = true,
> +};
> +
>   static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {
>   	{ .compatible = "rockchip,rk3228-dw-hdmi",
>   	  .data = &rk3228_hdmi_drv_data
> @@ -480,6 +519,9 @@ static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {
>   	{ .compatible = "rockchip,rk3399-dw-hdmi",
>   	  .data = &rk3399_hdmi_drv_data
>   	},
> +	{ .compatible = "rockchip,rk3568-dw-hdmi",
> +	  .data = &rk3568_hdmi_drv_data
> +	},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, dw_hdmi_rockchip_dt_ids);
> @@ -536,6 +578,28 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
>   		return ret;
>   	}
>   
> +	ret = clk_prepare_enable(hdmi->hclk_vio);
> +	if (ret) {
> +		dev_err(hdmi->dev, "Failed to enable HDMI hclk_vio: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(hdmi->hclk_vop);
> +	if (ret) {
> +		dev_err(hdmi->dev, "Failed to enable HDMI hclk_vop: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	if (hdmi->chip_data == &rk3568_chip_data) {
> +		regmap_write(hdmi->regmap, RK3568_GRF_VO_CON1,
> +			     HIWORD_UPDATE(RK3568_HDMI_SDAIN_MSK |
> +					   RK3568_HDMI_SCLIN_MSK,
> +					   RK3568_HDMI_SDAIN_MSK |
> +					   RK3568_HDMI_SCLIN_MSK));
> +	}
> +
>   	hdmi->phy = devm_phy_optional_get(dev, "hdmi");
>   	if (IS_ERR(hdmi->phy)) {
>   		ret = PTR_ERR(hdmi->phy);
> @@ -559,6 +623,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
>   		ret = PTR_ERR(hdmi->hdmi);
>   		drm_encoder_cleanup(encoder);
>   		clk_disable_unprepare(hdmi->vpll_clk);
> +		clk_disable_unprepare(hdmi->hclk_vio);
> +		clk_disable_unprepare(hdmi->hclk_vop);
>   	}
>   
>   	return ret;
> @@ -571,6 +637,8 @@ static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
>   
>   	dw_hdmi_unbind(hdmi->hdmi);
>   	clk_disable_unprepare(hdmi->vpll_clk);
> +	clk_disable_unprepare(hdmi->hclk_vio);
> +	clk_disable_unprepare(hdmi->hclk_vop);
>   }
>   
>   static const struct component_ops dw_hdmi_rockchip_ops = {
> 

