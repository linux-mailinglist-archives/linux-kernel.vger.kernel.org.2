Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABDA34CE91
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhC2LQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhC2LQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:16:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D01C061574;
        Mon, 29 Mar 2021 04:16:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b9so12413080wrt.8;
        Mon, 29 Mar 2021 04:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AQihHYniNz1aK+Mb8EzSQ8aiiXXwcD1vtx1NnSetokE=;
        b=CpmgBmJTBo1YRy8aVHbKgJorBDX0zR9pdgZxVHXQ+qkn0qykejsNdfBbA6JbTEICqT
         tLelFsTDcjW0hZJ/HVvqu0xfMXOGVKqejISgBvD91ucwvjh/WAEQ3aMmbLun4ruNZBhU
         InU4lTzZn8+I+LXrZiuwqYdLcujwlP/Q5RsdSWCsW4kqoVFXf+PL1RKp7mAKipHNmghw
         OWO1BG/nJKx17+Sn7OQ2PdpC6mfaUt7kSB7eo0Ws1n2z9TFDPTqWQlvpXrPVV1cquZyf
         B9rYsBncNE+qvyQH8gqP2GI5Y8Ad5/lofcaQpf3ShcTGV4GRCn63XkjUwf/ns8tvNl/8
         0Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AQihHYniNz1aK+Mb8EzSQ8aiiXXwcD1vtx1NnSetokE=;
        b=UP4ZssnwFiUsT2hQTSbgollsIxnc96cIG4/mRBh/1fzdNE/H66IY8wvc29W+bpIEqM
         TCFHylUrLY4fdVsSvkgbB3AFtUy0RCc3XWB3i0tFUAssGTbynlRswTRAeIZ6mDOyg9PA
         inllgoTbgO9ru/4lb/e6SlnaV62nSjqncERoBY9jMSEFFrIIeGQGshDRdQuN1YKAL7m5
         OQ6Y9DG1e+775X+ixviyQCWP/zqDfpO7c5hv6DgYf8AMbhYWWW0zj2DaAqaAb7UNxQKf
         xS8Pmh42qGlaIgMhMYwFlFqWJRVaMSoetC8TeSj0KHxSoCBkq4M3Cqz+5zHPaGIy7PKe
         ot9w==
X-Gm-Message-State: AOAM532jKcXEv+anHXbgYxmaqzMV3i02vZnMigvOn9TKl3UOOhkfxM66
        U/uWmQDvKt8SM9gybR60lRE=
X-Google-Smtp-Source: ABdhPJyxrHLcyVXpNXt4YFxuMZbcgowEBv/kwVAPs8P474s8n5AkInLUjIAR5NIAdEcj6/dIWnnAOg==
X-Received: by 2002:a05:6000:120f:: with SMTP id e15mr26989126wrx.129.1617016570758;
        Mon, 29 Mar 2021 04:16:10 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id t8sm30105786wrr.10.2021.03.29.04.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 04:16:10 -0700 (PDT)
To:     Nina Wu <nina-cm.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Jackson-kt.Chang@mediatek.com
References: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
 <1616743871-8087-2-git-send-email-nina-cm.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/2] soc: mediatek: Add mt8192 devapc driver
Message-ID: <365d12f3-3553-f560-2418-7f0ab764a81a@gmail.com>
Date:   Mon, 29 Mar 2021 13:16:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616743871-8087-2-git-send-email-nina-cm.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a general comment:

Please split your patch in several, one introducing changes to the existing code
base which are needed for newer SoCs (depending on the changes more then one)
and one which actually adds support for the new SoC.

More comments below.


On 26/03/2021 08:31, Nina Wu wrote:
> From: Nina Wu <Nina-CM.Wu@mediatek.com>
> 
> The hardware architecture of mt8192 devapc is slightly
> different from that of the previous IC.
> We add necessary extensions to support mt8192 and be
> back-compatible with other ICs.
> 
> Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-devapc.c | 213 ++++++++++++++++++++++++++++----------
>  1 file changed, 156 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
> index f1cea04..1e40a52 100644
> --- a/drivers/soc/mediatek/mtk-devapc.c
> +++ b/drivers/soc/mediatek/mtk-devapc.c
> @@ -15,6 +15,11 @@
>  #define VIO_MOD_TO_REG_IND(m)	((m) / 32)
>  #define VIO_MOD_TO_REG_OFF(m)	((m) % 32)
>  
> +#define FOR_EACH_SLAVE_TYPE(ctx, idx) \
> +	for ((idx) = 0; (idx) < (ctx)->slave_type_num; (idx)++)

Not really needed, please drop.

> +#define BASE(i)			(ctx->base_list[i])

same here.

> +#define VIO_IDX_NUM(i)		(ctx->vio_idx_num[i])

same here.

> +
>  struct mtk_devapc_vio_dbgs {
>  	union {
>  		u32 vio_dbg0;
> @@ -26,20 +31,28 @@ struct mtk_devapc_vio_dbgs {
>  			u32 addr_h:4;
>  			u32 resv:4;
>  		} dbg0_bits;
> +
> +		/* Not used, reference only */
> +		struct {
> +			u32 dmnid:6;
> +			u32 vio_w:1;
> +			u32 vio_r:1;
> +			u32 addr_h:4;
> +			u32 resv:20;
> +		} dbg0_bits_ver2;
>  	};
>  
>  	u32 vio_dbg1;
> +	u32 vio_dbg2;
>  };
>  
>  struct mtk_devapc_data {
> -	/* numbers of violation index */
> -	u32 vio_idx_num;
> -
>  	/* reg offset */
>  	u32 vio_mask_offset;
>  	u32 vio_sta_offset;
>  	u32 vio_dbg0_offset;
>  	u32 vio_dbg1_offset;
> +	u32 vio_dbg2_offset;
>  	u32 apc_con_offset;
>  	u32 vio_shift_sta_offset;
>  	u32 vio_shift_sel_offset;
> @@ -48,7 +61,10 @@ struct mtk_devapc_data {
>  
>  struct mtk_devapc_context {
>  	struct device *dev;
> -	void __iomem *infra_base;
> +	u32 arch_ver;
> +	u32 slave_type_num;
> +	void __iomem **base_list;
> +	u32 *vio_idx_num;
>  	struct clk *infra_clk;
>  	const struct mtk_devapc_data *data;
>  };
> @@ -56,39 +72,39 @@ struct mtk_devapc_context {
>  static void clear_vio_status(struct mtk_devapc_context *ctx)
>  {
>  	void __iomem *reg;
> -	int i;
> +	int i, j;
>  
> -	reg = ctx->infra_base + ctx->data->vio_sta_offset;
> +	FOR_EACH_SLAVE_TYPE(ctx, i) {
> +		reg = BASE(i) + ctx->data->vio_sta_offset;
>  
> -	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num) - 1; i++)
> -		writel(GENMASK(31, 0), reg + 4 * i);
> +		for (j = 0; j < VIO_MOD_TO_REG_IND(VIO_IDX_NUM(i) - 1); j++)
> +			writel(GENMASK(31, 0), reg + 4 * j);
> +
> +		writel(GENMASK(VIO_MOD_TO_REG_OFF(VIO_IDX_NUM(i) - 1), 0),
> +		       reg + 4 * j);
> +	}
>  
> -	writel(GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1, 0),
> -	       reg + 4 * i);
>  }
>  
> -static void mask_module_irq(struct mtk_devapc_context *ctx, bool mask)
> +static void mask_module_irq(void __iomem *reg, int vio_idx_num, bool mask)
>  {
> -	void __iomem *reg;
>  	u32 val;
>  	int i;
>  
> -	reg = ctx->infra_base + ctx->data->vio_mask_offset;
> -
>  	if (mask)
>  		val = GENMASK(31, 0);
>  	else
>  		val = 0;
>  
> -	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num) - 1; i++)
> +	for (i = 0; i < VIO_MOD_TO_REG_IND(vio_idx_num - 1); i++)
>  		writel(val, reg + 4 * i);
>  
>  	val = readl(reg + 4 * i);
>  	if (mask)
> -		val |= GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1,
> +		val |= GENMASK(VIO_MOD_TO_REG_OFF(vio_idx_num - 1),
>  			       0);
>  	else
> -		val &= ~GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1,
> +		val &= ~GENMASK(VIO_MOD_TO_REG_OFF(vio_idx_num - 1),
>  				0);
>  
>  	writel(val, reg + 4 * i);
> @@ -108,6 +124,8 @@ static void mask_module_irq(struct mtk_devapc_context *ctx, bool mask)
>   */
>  static int devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
>  {
> +	int i;
> +	void __iomem *reg_base;

Not needed.

>  	void __iomem *pd_vio_shift_sta_reg;
>  	void __iomem *pd_vio_shift_sel_reg;
>  	void __iomem *pd_vio_shift_con_reg;
> @@ -115,57 +133,87 @@ static int devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
>  	int ret;
>  	u32 val;
>  
> -	pd_vio_shift_sta_reg = ctx->infra_base +
> -			       ctx->data->vio_shift_sta_offset;
> -	pd_vio_shift_sel_reg = ctx->infra_base +
> -			       ctx->data->vio_shift_sel_offset;
> -	pd_vio_shift_con_reg = ctx->infra_base +
> -			       ctx->data->vio_shift_con_offset;
> +	FOR_EACH_SLAVE_TYPE(ctx, i) {
> +		reg_base = BASE(i);
>  
> -	/* Find the minimum shift group which has violation */
> -	val = readl(pd_vio_shift_sta_reg);
> -	if (!val)
> -		return false;
> +		pd_vio_shift_sta_reg = reg_base +
> +				       ctx->data->vio_shift_sta_offset;
> +		pd_vio_shift_sel_reg = reg_base +
> +				       ctx->data->vio_shift_sel_offset;
> +		pd_vio_shift_con_reg = reg_base +
> +				       ctx->data->vio_shift_con_offset;
>  
> -	min_shift_group = __ffs(val);
> +		/* Find the minimum shift group which has violation */
> +		val = readl(pd_vio_shift_sta_reg);
> +		if (!val)
> +			continue;
>  
> -	/* Assign the group to sync */
> -	writel(0x1 << min_shift_group, pd_vio_shift_sel_reg);
> +		min_shift_group = __ffs(val);
>  
> -	/* Start syncing */
> -	writel(0x1, pd_vio_shift_con_reg);
> +		/* Assign the group to sync */
> +		writel(0x1 << min_shift_group, pd_vio_shift_sel_reg);
>  
> -	ret = readl_poll_timeout(pd_vio_shift_con_reg, val, val == 0x3, 0,
> -				 PHY_DEVAPC_TIMEOUT);
> -	if (ret) {
> -		dev_err(ctx->dev, "%s: Shift violation info failed\n", __func__);
> -		return false;
> -	}
> +		/* Start syncing */
> +		writel(0x1, pd_vio_shift_con_reg);
> +
> +		ret = readl_poll_timeout(pd_vio_shift_con_reg, val, val == 0x3,
> +					 0, PHY_DEVAPC_TIMEOUT);
> +		if (ret) {
> +			dev_err(ctx->dev, "%s: Shift violation info failed\n",
> +				__func__);
> +			return -ETIMEDOUT;
> +		}
>  
> -	/* Stop syncing */
> -	writel(0x0, pd_vio_shift_con_reg);
> +		/* Stop syncing */
> +		writel(0x0, pd_vio_shift_con_reg);
>  
> -	/* Write clear */
> -	writel(0x1 << min_shift_group, pd_vio_shift_sta_reg);
> +		/* Write clear */
> +		writel(0x1 << min_shift_group, pd_vio_shift_sta_reg);
>  
> -	return true;
> +		return i;

Not sure why you change that.

> +	}
> +
> +	/* No violation found */
> +	return -ENODATA;
>  }
>  
>  /*
>   * devapc_extract_vio_dbg - extract full violation information after doing
>   *                          shift mechanism.
>   */
> -static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
> +static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx,
> +				   int vio_slave_type)
>  {
>  	struct mtk_devapc_vio_dbgs vio_dbgs;
>  	void __iomem *vio_dbg0_reg;
>  	void __iomem *vio_dbg1_reg;
> +	void __iomem *vio_dbg2_reg;
> +	u32 vio_addr, bus_id;
>  
> -	vio_dbg0_reg = ctx->infra_base + ctx->data->vio_dbg0_offset;
> -	vio_dbg1_reg = ctx->infra_base + ctx->data->vio_dbg1_offset;
> +	vio_dbg0_reg = BASE(vio_slave_type) + ctx->data->vio_dbg0_offset;
> +	vio_dbg1_reg = BASE(vio_slave_type) + ctx->data->vio_dbg1_offset;
> +	vio_dbg2_reg = BASE(vio_slave_type) + ctx->data->vio_dbg2_offset;
>  
>  	vio_dbgs.vio_dbg0 = readl(vio_dbg0_reg);
>  	vio_dbgs.vio_dbg1 = readl(vio_dbg1_reg);
> +	vio_dbgs.vio_dbg2 = readl(vio_dbg2_reg);
> +
> +	switch (ctx->arch_ver) {
> +	case 1:
> +		bus_id = vio_dbgs.dbg0_bits.mstid;
> +		vio_addr = vio_dbgs.vio_dbg1;
> +		break;
> +	case 2:
> +		bus_id = vio_dbgs.vio_dbg1;
> +		vio_addr = vio_dbgs.vio_dbg2;
> +
> +		/* To align with the bit definition of arch_ver 1 */
> +		vio_dbgs.vio_dbg0 = (vio_dbgs.vio_dbg0 << 16);
> +		break;
> +	default:
> +		/* Not Supported */
> +		return;
> +	}
>  
>  	/* Print violation information */
>  	if (vio_dbgs.dbg0_bits.vio_w)
> @@ -174,8 +222,7 @@ static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
>  		dev_info(ctx->dev, "Read Violation\n");
>  
>  	dev_info(ctx->dev, "Bus ID:0x%x, Dom ID:0x%x, Vio Addr:0x%x\n",
> -		 vio_dbgs.dbg0_bits.mstid, vio_dbgs.dbg0_bits.dmnid,
> -		 vio_dbgs.vio_dbg1);
> +		 bus_id, vio_dbgs.dbg0_bits.dmnid, vio_addr);
>  }
>  
>  /*
> @@ -186,9 +233,10 @@ static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
>  static irqreturn_t devapc_violation_irq(int irq_number, void *data)
>  {
>  	struct mtk_devapc_context *ctx = data;
> +	int vio_slave_type;
>  
> -	while (devapc_sync_vio_dbg(ctx))
> -		devapc_extract_vio_dbg(ctx);
> +	while ((vio_slave_type = devapc_sync_vio_dbg(ctx)) >= 0)
> +		devapc_extract_vio_dbg(ctx, vio_slave_type);
>  
>  	clear_vio_status(ctx);
>  
> @@ -200,9 +248,15 @@ static irqreturn_t devapc_violation_irq(int irq_number, void *data)
>   */
>  static void start_devapc(struct mtk_devapc_context *ctx)
>  {
> -	writel(BIT(31), ctx->infra_base + ctx->data->apc_con_offset);
> +	int i;
> +	void __iomem *reg_base;
>  
> -	mask_module_irq(ctx, false);
> +	FOR_EACH_SLAVE_TYPE(ctx, i) {
> +		writel(BIT(31), BASE(i) + ctx->data->apc_con_offset);
> +
> +		reg_base = BASE(i) + ctx->data->vio_mask_offset;
> +		mask_module_irq(reg_base, VIO_IDX_NUM(i), false);
> +	}
>  }
>  
>  /*
> @@ -210,13 +264,18 @@ static void start_devapc(struct mtk_devapc_context *ctx)
>   */
>  static void stop_devapc(struct mtk_devapc_context *ctx)
>  {
> -	mask_module_irq(ctx, true);
> +	int i;
> +	void __iomem *reg_base;
> +
> +	FOR_EACH_SLAVE_TYPE(ctx, i) {
> +		reg_base = BASE(i) + ctx->data->vio_mask_offset;
> +		mask_module_irq(reg_base, VIO_IDX_NUM(i), true);
>  
> -	writel(BIT(2), ctx->infra_base + ctx->data->apc_con_offset);
> +		writel(BIT(2), BASE(i) + ctx->data->apc_con_offset);
> +	}
>  }
>  
>  static const struct mtk_devapc_data devapc_mt6779 = {
> -	.vio_idx_num = 511,
>  	.vio_mask_offset = 0x0,
>  	.vio_sta_offset = 0x400,
>  	.vio_dbg0_offset = 0x900,
> @@ -227,11 +286,26 @@ static const struct mtk_devapc_data devapc_mt6779 = {
>  	.vio_shift_con_offset = 0xF20,
>  };
>  
> +static const struct mtk_devapc_data devapc_mt8192 = {
> +	.vio_mask_offset = 0x0,
> +	.vio_sta_offset = 0x400,
> +	.vio_dbg0_offset = 0x900,
> +	.vio_dbg1_offset = 0x904,
> +	.vio_dbg2_offset = 0x908,
> +	.apc_con_offset = 0xF00,
> +	.vio_shift_sta_offset = 0xF20,
> +	.vio_shift_sel_offset = 0xF30,
> +	.vio_shift_con_offset = 0xF10,
> +};
> +
>  static const struct of_device_id mtk_devapc_dt_match[] = {
>  	{
>  		.compatible = "mediatek,mt6779-devapc",
>  		.data = &devapc_mt6779,
>  	}, {
> +		.compatible = "mediatek,mt8192-devapc",
> +		.data = &devapc_mt8192,
> +	}, {
>  	},
>  };
>  
> @@ -239,6 +313,7 @@ static int mtk_devapc_probe(struct platform_device *pdev)
>  {
>  	struct device_node *node = pdev->dev.of_node;
>  	struct mtk_devapc_context *ctx;
> +	int i;
>  	u32 devapc_irq;
>  	int ret;
>  
> @@ -252,8 +327,32 @@ static int mtk_devapc_probe(struct platform_device *pdev)
>  	ctx->data = of_device_get_match_data(&pdev->dev);
>  	ctx->dev = &pdev->dev;
>  
> -	ctx->infra_base = of_iomap(node, 0);
> -	if (!ctx->infra_base)
> +	if (of_property_read_u32(node, "version", &ctx->arch_ver))
> +		return -EINVAL;
> +
> +	if (of_property_read_u32(node, "slave_type_num", &ctx->slave_type_num))

arch_ver and slave_type_num can be ddriver internal parameters set through the
DT data instead of through a new property.

> +		return -EINVAL;
> +
> +	ctx->base_list = devm_kzalloc(&pdev->dev,
> +				      sizeof(void *) * ctx->slave_type_num,
> +				      GFP_KERNEL);
> +	if (!ctx->base_list)
> +		return -ENOMEM;
> +
> +	FOR_EACH_SLAVE_TYPE(ctx, i) {
> +		BASE(i) = of_iomap(node, i);
> +		if (!BASE(i))
> +			return -EINVAL;
> +	}
> +
> +	ctx->vio_idx_num = devm_kzalloc(&pdev->dev,
> +					sizeof(u32) * ctx->slave_type_num,
> +					GFP_KERNEL);
> +	if (!ctx->vio_idx_num)
> +		return -ENOMEM;
> +
> +	if (of_property_read_u32_array(node, "vio_idx_num",
> +				       ctx->vio_idx_num, ctx->slave_type_num))
>  		return -EINVAL;
>  
>  	devapc_irq = irq_of_parse_and_map(node, 0);
> 
