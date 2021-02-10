Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93112316715
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhBJMr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhBJMqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:46:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB87C061786;
        Wed, 10 Feb 2021 04:46:02 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 7so2407757wrz.0;
        Wed, 10 Feb 2021 04:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rjLWgX3Eg/gC3RV2khv5c8f9NWNyEch31NnXlurt3Ss=;
        b=GSU8nJJHRxGKxEYvAVHgEZ99IaPo0P82K2x/ng7rcD0jt+NV3L03A27i1H57yxSIxh
         /ix5ODPDpCQiJftDGoj9wOWsLSy5xcMrn+tClntvA+wmxdJmfrzx/MUqJJiXEwHDeC0I
         dtbDh2tJORkIrYHkE0g9fUS4N7old4ebGv+D75QpkkmjRxu5mBL4hkboAi4chmFY1GCe
         Y2dfPmWdzLtFxoNTJ9JD7aJkXPQY2iwoVdYi1dtnv87ZxOfDg2VxkIe6rfQj0mrAKf3Z
         HpJwhtERMHvMhNT7nvtQiVT7CsRyqedvV18w1GxtWP3xZNK7/ghrnLa+gxewO8yaMSeU
         lzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rjLWgX3Eg/gC3RV2khv5c8f9NWNyEch31NnXlurt3Ss=;
        b=XQD+J3CWZkOCaoKxZgvq4F6rPAyPbAt1gkxXewuLbk/2P7pqeW0U92c3MgOo0Ge+hj
         YQgWfZIzumaGAiWQzmO0DWm5JReqXhCThSEC7J7rkYxewodEV7lXLvcNlSHn/joPs0vG
         KCAfLh8KxmIk+YTRURPiSi8gJlDthBNS0WTi8f4f0szslQtOrzBK3pdy4lHz9hSbN0hY
         D7lcpfDbx41Em9pUhrId68FTqpQcz5jsRNMjWFJ54wnsjZafnpubq8Vjaqq99wyhZRhu
         2COX2YSj+8zd5LLWF/JzaVQodjGQwf3sbwHV+z5EH4JSdf8kzXKDmnlR8sWxiL17RjDw
         caMA==
X-Gm-Message-State: AOAM531oS+GPgJFnTtSqS+51NVeAAAFNuFCevmHVt/bxd4+izJL5zFbV
        O/aqkdZR4x360co/iadf558=
X-Google-Smtp-Source: ABdhPJyGB+U3gO1kAGzHQsdpRDV8svemT3zKAyNPWMoEzioiHLuUbNy6AOhrhPwCNeE3NNBWZeMhYA==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr3334138wru.178.1612961161574;
        Wed, 10 Feb 2021 04:46:01 -0800 (PST)
Received: from ziggy.stardust (static-188-169-27-46.ipcom.comunitel.net. [46.27.169.188])
        by smtp.gmail.com with ESMTPSA id f17sm2826671wrx.57.2021.02.10.04.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 04:46:01 -0800 (PST)
To:     Weiyi Lu <weiyi.lu@mediatek.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
 <1608642587-15634-11-git-send-email-weiyi.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v6 10/22] clk: mediatek: Add MT8192 basic clocks support
Message-ID: <b16e4693-1dc6-e13c-3cc9-feb5005179dd@gmail.com>
Date:   Wed, 10 Feb 2021 13:46:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1608642587-15634-11-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/2020 14:09, Weiyi Lu wrote:
> Add MT8192 basic clock providers, include topckgen, apmixedsys,
> infracfg and pericfg.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig      |    8 +
>  drivers/clk/mediatek/Makefile     |    1 +
>  drivers/clk/mediatek/clk-mt8192.c | 1326 +++++++++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/clk-mux.h    |   15 +
>  4 files changed, 1350 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8192.c
> 

[...]

> +static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
> +{
> +	struct clk_onecell_data *clk_data;
> +	struct device_node *node = pdev->dev.of_node;
> +	int r;
> +
> +	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
> +	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
> +	if (r)
> +		return r;
> +
> +	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +}
> +
> +static const struct of_device_id of_match_clk_mt8192[] = {
> +	{
> +		.compatible = "mediatek,mt8192-apmixedsys",
> +		.data = clk_mt8192_apmixed_probe,
> +	}, {
> +		.compatible = "mediatek,mt8192-topckgen",
> +		.data = clk_mt8192_top_probe,
> +	}, {
> +		.compatible = "mediatek,mt8192-infracfg",
> +		.data = clk_mt8192_infra_probe,
> +	}, {
> +		.compatible = "mediatek,mt8192-pericfg",
> +		.data = clk_mt8192_peri_probe,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
> +static int clk_mt8192_probe(struct platform_device *pdev)
> +{
> +	int (*clk_probe)(struct platform_device *pdev);
> +	int r;
> +
> +	clk_probe = of_device_get_match_data(&pdev->dev);
> +	if (!clk_probe)
> +		return -EINVAL;
> +
> +	r = clk_probe(pdev);
> +	if (r)
> +		dev_err(&pdev->dev, "could not register clock provider: %s: %d\n", pdev->name, r);
> +
> +	return r;
> +}
> +
> +static struct platform_driver clk_mt8192_drv = {
> +	.probe = clk_mt8192_probe,
> +	.driver = {
> +		.name = "clk-mt8192",
> +		.of_match_table = of_match_clk_mt8192,
> +	},
> +};
> +
> +static int __init clk_mt8192_init(void)
> +{
> +	return platform_driver_register(&clk_mt8192_drv);
> +}
> +
> +arch_initcall(clk_mt8192_init);

Do we really need all these clocks that early?
Why don't we use CLK_OF_DECLARE_DRIVER() then and why do we initialize some
clocks CLK_OF_DECLARE_DRIVER and other with arch_initcall?

I know that this is in other drivers for MediaTek SoCs, but that does not mean
it's the right approach.


> diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
> index f5625f4..afbc7df 100644
> --- a/drivers/clk/mediatek/clk-mux.h
> +++ b/drivers/clk/mediatek/clk-mux.h
> @@ -77,6 +77,21 @@ struct mtk_mux {
>  			_width, _gate, _upd_ofs, _upd,			\
>  			CLK_SET_RATE_PARENT)
>  
> +#define MUX_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,		\
> +			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
> +			_upd_ofs, _upd, _flags)				\
> +		GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
> +			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
> +			0, _upd_ofs, _upd, _flags,			\
> +			mtk_mux_clr_set_upd_ops)
> +
> +#define MUX_CLR_SET_UPD(_id, _name, _parents, _mux_ofs,			\
> +			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
> +			_upd_ofs, _upd)					\
> +		MUX_CLR_SET_UPD_FLAGS(_id, _name, _parents,		\
> +			_mux_ofs, _mux_set_ofs, _mux_clr_ofs, _shift,	\
> +			_width, _upd_ofs, _upd,	CLK_SET_RATE_PARENT)
> +

Why can't we do something like:

#define MUX_CLR_SET_UPD(_id, _name, _parents, _mux_ofs,			\
			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
			_upd_ofs, _upd)					\
		GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
			0, _upd_ofs, _upd, CLK_SET_RATE_PARENT,			\
			mtk_mux_clr_set_upd_ops)

>  struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
>  				 struct regmap *regmap,
>  				 spinlock_t *lock);
> 
