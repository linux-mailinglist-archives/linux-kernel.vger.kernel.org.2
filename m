Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939ED42329D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbhJEVGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:06:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48621 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhJEVGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:06:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633467852; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=aohmKDHxUizr7g+KEYfcZAY/l/qhbTXOBdBr8mlBho4=;
 b=MDVG6ekKeTP/CR9KukOInEdbh2D1WoreE2ak25bwA1gAI7GQAAtVJhZtSHmZRPM+vvrAKoP8
 XFPtRz18sOvu162mYlAm4scMnkM3DAXJiSqV9SX1L5ywUwCBFIUrEcjtpctzykX3ej2jdOLf
 ar46CHeHFoFI/9nta0sb1Mncq2U=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 615cbdc78ea00a941fe1d62d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 21:04:07
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B887DC4361A; Tue,  5 Oct 2021 21:04:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2F91C43460;
        Tue,  5 Oct 2021 21:04:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Oct 2021 14:04:05 -0700
From:   abhinavk@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Freedreno] [PATCH v3 4/5] drm/msm/dp: Store each subblock in the
 io region
In-Reply-To: <20211001174400.981707-5-bjorn.andersson@linaro.org>
References: <20211001174400.981707-1-bjorn.andersson@linaro.org>
 <20211001174400.981707-5-bjorn.andersson@linaro.org>
Message-ID: <18a6085ad9807223cdd557a96ed71360@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-01 10:43, Bjorn Andersson wrote:
> Not all platforms has DP_P0 at offset 0x1000 from the beginning of the
> DP block. So split the dss_io_data memory region into a set of
> sub-regions, to make it possible in the next patch to specify each of
> the sub-regions individually.
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> ---
> 
> Changes since v2:
> - Skipped the unnecessary reorder in struct dss_io_region
> 
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 64 +++++++++--------------------
>  drivers/gpu/drm/msm/dp/dp_parser.c  | 28 +++++++++++--
>  drivers/gpu/drm/msm/dp/dp_parser.h  |  9 +++-
>  3 files changed, 53 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c
> b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index cc2bb8295329..6ae9b29044b6 100644
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
> +	msm_disp_snapshot_add_block(disp_state, dss->ahb.len, dss->ahb.base,
> "dp_ahb");
> +	msm_disp_snapshot_add_block(disp_state, dss->aux.len, dss->aux.base,
> "dp_aux");
> +	msm_disp_snapshot_add_block(disp_state, dss->link.len,
> dss->link.base, "dp_link");
> +	msm_disp_snapshot_add_block(disp_state, dss->p0.len, dss->p0.base, 
> "dp_p0");
>  }
I like this part, devcoredump will look pretty clean and well separated 
with this.

> 
>  static inline u32 dp_read_aux(struct dp_catalog_private *catalog, u32 
> offset)
>  {
> -	offset += MSM_DP_CONTROLLER_AUX_OFFSET;
> -	return readl_relaxed(catalog->io->dp_controller.base + offset);
> +	return readl_relaxed(catalog->io->dp_controller.aux.base + offset);
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
> +	writel(data, catalog->io->dp_controller.aux.base + offset);
>  }
> 
>  static inline u32 dp_read_ahb(struct dp_catalog_private *catalog, u32 
> offset)
>  {
> -	offset += MSM_DP_CONTROLLER_AHB_OFFSET;
> -	return readl_relaxed(catalog->io->dp_controller.base + offset);
> +	return readl_relaxed(catalog->io->dp_controller.ahb.base + offset);
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
> +	writel(data, catalog->io->dp_controller.ahb.base + offset);
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
> +	writel(data, catalog->io->dp_controller.p0.base + offset);
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
> +	return readl_relaxed(catalog->io->dp_controller.p0.base + offset);
>  }
> 
>  static inline u32 dp_read_link(struct dp_catalog_private *catalog, u32 
> offset)
>  {
> -	offset += MSM_DP_CONTROLLER_LINK_OFFSET;
> -	return readl_relaxed(catalog->io->dp_controller.base + offset);
> +	return readl_relaxed(catalog->io->dp_controller.link.base + offset);
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
> +	writel(data, catalog->io->dp_controller.link.base + offset);
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
> +	dump_regs(io->ahb.base, io->ahb.len);
> 
>  	pr_info("AUXCLK regs\n");
> -	offset = MSM_DP_CONTROLLER_AUX_OFFSET;
> -	len = MSM_DP_CONTROLLER_AUX_SIZE;
> -	dump_regs(catalog->io->dp_controller.base + offset, len);
> +	dump_regs(io->aux.base, io->aux.len);
> 
>  	pr_info("LCLK regs\n");
> -	offset = MSM_DP_CONTROLLER_LINK_OFFSET;
> -	len = MSM_DP_CONTROLLER_LINK_SIZE;
> -	dump_regs(catalog->io->dp_controller.base + offset, len);
> +	dump_regs(io->link.base, io->link.len);
> 
>  	pr_info("P0CLK regs\n");
> -	offset = MSM_DP_CONTROLLER_P0_OFFSET;
> -	len = MSM_DP_CONTROLLER_P0_SIZE;
> -	dump_regs(catalog->io->dp_controller.base + offset, len);
> +	dump_regs(io->p0.base, io->p0.len);
>  }
> 
>  u32 dp_catalog_aux_get_irq(struct dp_catalog *dp_catalog)
> @@ -493,8 +471,7 @@ int dp_catalog_ctrl_set_pattern(struct dp_catalog
> *dp_catalog,
>  	bit = BIT(pattern - 1) << DP_MAINLINK_READY_LINK_TRAINING_SHIFT;
> 
>  	/* Poll for mainlink ready status */
> -	ret = readx_poll_timeout(readl, catalog->io->dp_controller.base +
> -					MSM_DP_CONTROLLER_LINK_OFFSET +
> +	ret = readx_poll_timeout(readl, catalog->io->dp_controller.link.base 
> +
>  					REG_DP_MAINLINK_READY,
>  					data, data & bit,
>  					POLLING_SLEEP_US, POLLING_TIMEOUT_US);
> @@ -541,8 +518,7 @@ bool dp_catalog_ctrl_mainlink_ready(struct
> dp_catalog *dp_catalog)
>  				struct dp_catalog_private, dp_catalog);
> 
>  	/* Poll for mainlink ready status */
> -	ret = readl_poll_timeout(catalog->io->dp_controller.base +
> -				MSM_DP_CONTROLLER_LINK_OFFSET +
> +	ret = readl_poll_timeout(catalog->io->dp_controller.link.base +
>  				REG_DP_MAINLINK_READY,
>  				data, data & DP_MAINLINK_READY_FOR_VIDEO,
>  				POLLING_SLEEP_US, POLLING_TIMEOUT_US);
> diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c
> b/drivers/gpu/drm/msm/dp/dp_parser.c
> index c05ba1990218..1f084b2b5bd3 100644
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
> @@ -37,9 +46,22 @@ static int dp_parser_ctrl_res(struct dp_parser 
> *parser)
>  	struct dp_io *io = &parser->io;
>  	struct dss_io_data *dss = &io->dp_controller;
> 
> -	dss->base = dp_ioremap(pdev, 0, &dss->len);
> -	if (IS_ERR(dss->base))
> -		return PTR_ERR(dss->base);
> +	dss->ahb.base = dp_ioremap(pdev, 0, &dss->ahb.len);
> +	if (IS_ERR(dss->ahb.base))
> +		return PTR_ERR(dss->ahb.base);
> +
> +	if (dss->ahb.len < DP_DEFAULT_P0_OFFSET + DP_DEFAULT_P0_SIZE) {
> +		DRM_ERROR("legacy memory region not large enough\n");
> +		return -EINVAL;
> +	}
> +
> +	dss->ahb.len = DP_DEFAULT_AHB_SIZE;
> +	dss->aux.base = dss->ahb.base + DP_DEFAULT_AUX_OFFSET;
> +	dss->aux.len = DP_DEFAULT_AUX_SIZE;
> +	dss->link.base = dss->ahb.base + DP_DEFAULT_LINK_OFFSET;
> +	dss->link.len = DP_DEFAULT_LINK_SIZE;
> +	dss->p0.base = dss->ahb.base + DP_DEFAULT_P0_OFFSET;
> +	dss->p0.len = DP_DEFAULT_P0_SIZE;
> 
>  	io->phy = devm_phy_get(&pdev->dev, "dp");
>  	if (IS_ERR(io->phy))
> diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h
> b/drivers/gpu/drm/msm/dp/dp_parser.h
> index dc62e70b1640..dac10923abde 100644
> --- a/drivers/gpu/drm/msm/dp/dp_parser.h
> +++ b/drivers/gpu/drm/msm/dp/dp_parser.h
> @@ -25,11 +25,18 @@ enum dp_pm_type {
>  	DP_MAX_PM
>  };
> 
> -struct dss_io_data {
> +struct dss_io_region {
>  	size_t len;
>  	void __iomem *base;
>  };
> 
> +struct dss_io_data {
> +	struct dss_io_region ahb;
> +	struct dss_io_region aux;
> +	struct dss_io_region link;
> +	struct dss_io_region p0;
> +};
> +
>  static inline const char *dp_parser_pm_name(enum dp_pm_type module)
>  {
>  	switch (module) {
