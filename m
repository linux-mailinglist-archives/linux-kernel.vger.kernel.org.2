Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E173BE095
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 03:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhGGBen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 21:34:43 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:57052 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhGGBem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 21:34:42 -0400
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jul 2021 21:34:41 EDT
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id C2218828;
        Wed,  7 Jul 2021 09:23:51 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.39] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P30160T139874211661568S1625621030052233_;
        Wed, 07 Jul 2021 09:23:51 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <bf364529817dce1bbbc56a7b0d2126e9>
X-RL-SENDER: algea.cao@rock-chips.com
X-SENDER: algea.cao@rock-chips.com
X-LOGIN-NAME: algea.cao@rock-chips.com
X-FST-TO: kernel@collabora.com
X-RCPT-COUNT: 12
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/2=5d_drm/rockchip=3a_dw=5fhdmi=3a_add_rk?=
 =?UTF-8?B?MzU2OCBzdXBwb3J044CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgtcm9ja2No?=
 =?UTF-8?Q?ip-bounces+algea=2ecao=3drock-chips=2ecom=40lists=2einfradead=2eo?=
 =?UTF-8?B?cmfku6Plj5HjgJE=?=
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20210705140304.652929-1-benjamin.gaignard@collabora.com>
 <20210705140304.652929-3-benjamin.gaignard@collabora.com>
From:   crj <algea.cao@rock-chips.com>
Message-ID: <f6d23bb9-fd31-7dd5-e8b9-aa24310e25da@rock-chips.com>
Date:   Wed, 7 Jul 2021 09:23:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20210705140304.652929-3-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

         RK3568 hdmi phy ref clock source is HPLL. HPLL must be set when 
switching resolution or plugging.

Whether to add the configuration for HPLL?


         Thanks!


在 2021/7/5 22:03, Benjamin Gaignard 写道:
> Add a new dw_hdmi_plat_data struct and new compatible for rk3568.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>   drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 28 +++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index 830bdd5e9b7ce..5817c3a9fe64b 100644
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
> @@ -467,6 +471,19 @@ static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
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
> @@ -480,6 +497,9 @@ static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {
>   	{ .compatible = "rockchip,rk3399-dw-hdmi",
>   	  .data = &rk3399_hdmi_drv_data
>   	},
> +	{ .compatible = "rockchip,rk3568-dw-hdmi",
> +	  .data = &rk3568_hdmi_drv_data
> +	},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, dw_hdmi_rockchip_dt_ids);
> @@ -536,6 +556,14 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
>   		return ret;
>   	}
>   
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


