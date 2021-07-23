Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0032E3D4186
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 22:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhGWTst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 15:48:49 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:28547 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhGWTss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 15:48:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627072161; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=LNh1spEpcNUiP+ZsaBW6Q5BApnpcRDbEsLqwfEK9mG8=;
 b=CKLLKHx8nw/9tBTEtijWX/ERHFa1+VJ8SqNqtEH45WmF/3VRBkGlVElOjRanxlt9Ul8+bm3Q
 q1GTfT4giGwjLIJo2wiREzenFxRuZL9OGlxVJyDMu8NJtVdUukbYxctv6uRd6D8CFBTMjpTJ
 5s7BMy++RzwIt6KdlQYvNOmyirs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60fb26a0e31d882d18a037ef (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 23 Jul 2021 20:29:20
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C9C9EC43143; Fri, 23 Jul 2021 20:29:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E659FC433F1;
        Fri, 23 Jul 2021 20:29:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 23 Jul 2021 13:29:18 -0700
From:   abhinavk@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        freedreno@lists.freedesktop.org,
        Chandan Uddaraju <chandanu@codeaurora.org>
Subject: Re: [Freedreno] [PATCH 4/5] drm/msm/dp: Store each subblock in the io
 region
In-Reply-To: <20210722024227.3313096-5-bjorn.andersson@linaro.org>
References: <20210722024227.3313096-1-bjorn.andersson@linaro.org>
 <20210722024227.3313096-5-bjorn.andersson@linaro.org>
Message-ID: <1124ffa07a34344ed313d437479e0216@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-21 19:42, Bjorn Andersson wrote:
> Not all platforms has DP_P0 at offset 0x1000 from the beginning of the
> DP block. So dss_io_data into representing each of the sub-regions, to
> make it possible in the next patch to specify each of the sub-regions
> individually.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Same comments as Stephen on this 
https://patchwork.freedesktop.org/patch/445655/
> ---
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 64 +++++++++--------------------
>  drivers/gpu/drm/msm/dp/dp_parser.c  | 30 ++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_parser.h  | 10 ++++-
>  3 files changed, 54 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c
> b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index ca96e3514790..23458b0ddc37 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -24,15 +24,6 @@
>  #define DP_INTERRUPT_STATUS_ACK_SHIFT	1
>  #define DP_INTERRUPT_STATUS_MASK_SHIFT	2
> 
> -#define MSM_DP_CONTROLLER_AHB_OFFSET	0x0000
> -#define MSM_DP_CONTROLLER_AHB_SIZE	0x0200
> -#define MSM_DP_CONTROLLER_AUX_OFFSET	0x0200
> -#define MSM_DP_CONTROLLER_AUX_SIZE	0x0200
> -#define MSM_DP_CONTROLLER_LINK_OFFSET	0x0400
> -#define MSM_DP_CONTROLLER_LINK_SIZE	0x0C00
> -#define MSM_DP_CONTROLLER_P0_OFFSET	0x1000
> -#define MSM_DP_CONTROLLER_P0_SIZE	0x0400
> -
>  #define DP_INTERRUPT_STATUS1 \
>  	(DP_INTR_AUX_I2C_DONE| \
>  	DP_INTR_WRONG_ADDR | DP_INTR_TIMEOUT | \
> @@ -66,82 +57,77 @@ void dp_catalog_snapshot(struct dp_catalog
> *dp_catalog, struct msm_disp_state *d
>  {
>  	struct dp_catalog_private *catalog = container_of(dp_catalog,
>  			struct dp_catalog_private, dp_catalog);
> +	struct dss_io_data *dss = &catalog->io->dp_controller;
> 
> -	msm_disp_snapshot_add_block(disp_state, 
> catalog->io->dp_controller.len,
> -			catalog->io->dp_controller.base, "dp_ctrl");
> +	msm_disp_snapshot_add_block(disp_state, dss->ahb_len, dss->ahb, 
> "dp_ahb");
> +	msm_disp_snapshot_add_block(disp_state, dss->aux_len, dss->aux, 
> "dp_aux");
> +	msm_disp_snapshot_add_block(disp_state, dss->link_len, dss->link, 
> "dp_link");
> +	msm_disp_snapshot_add_block(disp_state, dss->p0_len, dss->p0, 
> "dp_p0");
>  }
> 
>  static inline u32 dp_read_aux(struct dp_catalog_private *catalog, u32 
> offset)
>  {
> -	offset += MSM_DP_CONTROLLER_AUX_OFFSET;
> -	return readl_relaxed(catalog->io->dp_controller.base + offset);
> +	return readl_relaxed(catalog->io->dp_controller.aux + offset);
>  }
> 
>  static inline void dp_write_aux(struct dp_catalog_private *catalog,
>  			       u32 offset, u32 data)
>  {
> -	offset += MSM_DP_CONTROLLER_AUX_OFFSET;
>  	/*
>  	 * To make sure aux reg writes happens before any other operation,
>  	 * this function uses writel() instread of writel_relaxed()
>  	 */
> -	writel(data, catalog->io->dp_controller.base + offset);
> +	writel(data, catalog->io->dp_controller.aux + offset);
>  }
> 
>  static inline u32 dp_read_ahb(struct dp_catalog_private *catalog, u32 
> offset)
>  {
> -	offset += MSM_DP_CONTROLLER_AHB_OFFSET;
> -	return readl_relaxed(catalog->io->dp_controller.base + offset);
> +	return readl_relaxed(catalog->io->dp_controller.ahb + offset);
>  }
> 
>  static inline void dp_write_ahb(struct dp_catalog_private *catalog,
>  			       u32 offset, u32 data)
>  {
> -	offset += MSM_DP_CONTROLLER_AHB_OFFSET;
>  	/*
>  	 * To make sure phy reg writes happens before any other operation,
>  	 * this function uses writel() instread of writel_relaxed()
>  	 */
> -	writel(data, catalog->io->dp_controller.base + offset);
> +	writel(data, catalog->io->dp_controller.ahb + offset);
>  }
> 
>  static inline void dp_write_p0(struct dp_catalog_private *catalog,
>  			       u32 offset, u32 data)
>  {
> -	offset += MSM_DP_CONTROLLER_P0_OFFSET;
>  	/*
>  	 * To make sure interface reg writes happens before any other 
> operation,
>  	 * this function uses writel() instread of writel_relaxed()
>  	 */
> -	writel(data, catalog->io->dp_controller.base + offset);
> +	writel(data, catalog->io->dp_controller.p0 + offset);
>  }
> 
>  static inline u32 dp_read_p0(struct dp_catalog_private *catalog,
>  			       u32 offset)
>  {
> -	offset += MSM_DP_CONTROLLER_P0_OFFSET;
>  	/*
>  	 * To make sure interface reg writes happens before any other 
> operation,
>  	 * this function uses writel() instread of writel_relaxed()
>  	 */
> -	return readl_relaxed(catalog->io->dp_controller.base + offset);
> +	return readl_relaxed(catalog->io->dp_controller.p0 + offset);
>  }
> 
>  static inline u32 dp_read_link(struct dp_catalog_private *catalog, u32 
> offset)
>  {
> -	offset += MSM_DP_CONTROLLER_LINK_OFFSET;
> -	return readl_relaxed(catalog->io->dp_controller.base + offset);
> +	return readl_relaxed(catalog->io->dp_controller.link + offset);
>  }
> 
>  static inline void dp_write_link(struct dp_catalog_private *catalog,
>  			       u32 offset, u32 data)
>  {
> -	offset += MSM_DP_CONTROLLER_LINK_OFFSET;
>  	/*
>  	 * To make sure link reg writes happens before any other operation,
>  	 * this function uses writel() instread of writel_relaxed()
>  	 */
> -	writel(data, catalog->io->dp_controller.base + offset);
> +	writel(data, catalog->io->dp_controller.link + offset);
>  }
> 
>  /* aux related catalog functions */
> @@ -276,29 +262,21 @@ static void dump_regs(void __iomem *base, int 
> len)
> 
>  void dp_catalog_dump_regs(struct dp_catalog *dp_catalog)
>  {
> -	u32 offset, len;
>  	struct dp_catalog_private *catalog = container_of(dp_catalog,
>  		struct dp_catalog_private, dp_catalog);
> +	struct dss_io_data *io = &catalog->io->dp_controller;
> 
>  	pr_info("AHB regs\n");
> -	offset = MSM_DP_CONTROLLER_AHB_OFFSET;
> -	len = MSM_DP_CONTROLLER_AHB_SIZE;
> -	dump_regs(catalog->io->dp_controller.base + offset, len);
> +	dump_regs(io->ahb, io->ahb_len);
> 
>  	pr_info("AUXCLK regs\n");
> -	offset = MSM_DP_CONTROLLER_AUX_OFFSET;
> -	len = MSM_DP_CONTROLLER_AUX_SIZE;
> -	dump_regs(catalog->io->dp_controller.base + offset, len);
> +	dump_regs(io->aux, io->aux_len);
> 
>  	pr_info("LCLK regs\n");
> -	offset = MSM_DP_CONTROLLER_LINK_OFFSET;
> -	len = MSM_DP_CONTROLLER_LINK_SIZE;
> -	dump_regs(catalog->io->dp_controller.base + offset, len);
> +	dump_regs(io->link, io->link_len);
> 
>  	pr_info("P0CLK regs\n");
> -	offset = MSM_DP_CONTROLLER_P0_OFFSET;
> -	len = MSM_DP_CONTROLLER_P0_SIZE;
> -	dump_regs(catalog->io->dp_controller.base + offset, len);
> +	dump_regs(io->p0, io->p0_len);
>  }
> 
>  u32 dp_catalog_aux_get_irq(struct dp_catalog *dp_catalog)
> @@ -492,8 +470,7 @@ int dp_catalog_ctrl_set_pattern(struct dp_catalog
> *dp_catalog,
>  	bit = BIT(pattern - 1) << DP_MAINLINK_READY_LINK_TRAINING_SHIFT;
> 
>  	/* Poll for mainlink ready status */
> -	ret = readx_poll_timeout(readl, catalog->io->dp_controller.base +
> -					MSM_DP_CONTROLLER_LINK_OFFSET +
> +	ret = readx_poll_timeout(readl, catalog->io->dp_controller.link +
>  					REG_DP_MAINLINK_READY,
>  					data, data & bit,
>  					POLLING_SLEEP_US, POLLING_TIMEOUT_US);
> @@ -540,8 +517,7 @@ bool dp_catalog_ctrl_mainlink_ready(struct
> dp_catalog *dp_catalog)
>  				struct dp_catalog_private, dp_catalog);
> 
>  	/* Poll for mainlink ready status */
> -	ret = readl_poll_timeout(catalog->io->dp_controller.base +
> -				MSM_DP_CONTROLLER_LINK_OFFSET +
> +	ret = readl_poll_timeout(catalog->io->dp_controller.link +
>  				REG_DP_MAINLINK_READY,
>  				data, data & DP_MAINLINK_READY_FOR_VIDEO,
>  				POLLING_SLEEP_US, POLLING_TIMEOUT_US);
> diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c
> b/drivers/gpu/drm/msm/dp/dp_parser.c
> index e68dacef547c..1a10901ae574 100644
> --- a/drivers/gpu/drm/msm/dp/dp_parser.c
> +++ b/drivers/gpu/drm/msm/dp/dp_parser.c
> @@ -11,6 +11,15 @@
>  #include "dp_parser.h"
>  #include "dp_reg.h"
> 
> +#define DP_DEFAULT_AHB_OFFSET	0x0000
> +#define DP_DEFAULT_AHB_SIZE	0x0200
> +#define DP_DEFAULT_AUX_OFFSET	0x0200
> +#define DP_DEFAULT_AUX_SIZE	0x0200
> +#define DP_DEFAULT_LINK_OFFSET	0x0400
> +#define DP_DEFAULT_LINK_SIZE	0x0C00
> +#define DP_DEFAULT_P0_OFFSET	0x1000
> +#define DP_DEFAULT_P0_SIZE	0x0400
> +
>  static const struct dp_regulator_cfg sdm845_dp_reg_cfg = {
>  	.num = 2,
>  	.regs = {
> @@ -48,12 +57,25 @@ static int dp_parser_ctrl_res(struct dp_parser 
> *parser)
>  	struct dp_io *io = &parser->io;
>  	struct dss_io_data *dss = &io->dp_controller;
> 
> -	dss->base = dp_ioremap(pdev, 0, &dss->len);
> -	if (IS_ERR(dss->base)) {
> -		DRM_ERROR("unable to remap dp io region: %pe\n", dss->base);
> -		return PTR_ERR(dss->base);
> +	dss->ahb = dp_ioremap(pdev, 0, &dss->ahb_len);
> +	if (IS_ERR(dss->ahb)) {
> +		DRM_ERROR("unable to remap ahb region: %pe\n", dss->ahb);
> +		return PTR_ERR(dss->ahb);
>  	}
> 
> +	if (dss->ahb_len < DP_DEFAULT_P0_OFFSET + DP_DEFAULT_P0_SIZE) {
> +		DRM_ERROR("legacy memory region not large enough\n");
> +		return -EINVAL;
> +	}
> +
> +	dss->ahb_len = DP_DEFAULT_AHB_SIZE;
> +	dss->aux = dss->ahb + DP_DEFAULT_AUX_OFFSET;
> +	dss->aux_len = DP_DEFAULT_AUX_SIZE;
> +	dss->link = dss->ahb + DP_DEFAULT_LINK_OFFSET;
> +	dss->link_len = DP_DEFAULT_LINK_SIZE;
> +	dss->p0 = dss->ahb + DP_DEFAULT_P0_OFFSET;
> +	dss->p0_len = DP_DEFAULT_P0_SIZE;
> +
>  	io->phy = devm_phy_get(&pdev->dev, "dp");
>  	if (IS_ERR(io->phy))
>  		return PTR_ERR(io->phy);
> diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h
> b/drivers/gpu/drm/msm/dp/dp_parser.h
> index dc62e70b1640..3266b529c090 100644
> --- a/drivers/gpu/drm/msm/dp/dp_parser.h
> +++ b/drivers/gpu/drm/msm/dp/dp_parser.h
> @@ -26,8 +26,14 @@ enum dp_pm_type {
>  };
> 
>  struct dss_io_data {
> -	size_t len;
> -	void __iomem *base;
> +	void __iomem *ahb;
> +	size_t ahb_len;
> +	void __iomem *aux;
> +	size_t aux_len;
> +	void __iomem *link;
> +	size_t link_len;
> +	void __iomem *p0;
> +	size_t p0_len;
>  };
> 
>  static inline const char *dp_parser_pm_name(enum dp_pm_type module)
