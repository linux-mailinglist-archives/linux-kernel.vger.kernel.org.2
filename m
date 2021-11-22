Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8F6458932
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 07:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhKVGEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 01:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhKVGEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 01:04:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94A1C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 22:01:45 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u3so75416434lfl.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 22:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lPXukOaJl5aewiB+tCI8uXsfmVBy8r1+nyP7DOdvQ/I=;
        b=T0sZ5yCsFEiw3sdUaa2VGX+rlP0hKHXxHoRXTBJysWE6RUbA4x8Up2Yht2aoAYehfs
         17VEELLu9bZUtHpXN58nmPMVav1pYTDONPs5k+/bSmI+NO7WcZxvI6sFerjD+Nq9vmKe
         FIfENSun8DRQAmpf7xo9KMNivrFstSepFEneY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPXukOaJl5aewiB+tCI8uXsfmVBy8r1+nyP7DOdvQ/I=;
        b=Tme4BXiGBn1HZQbarsAXogO92xGHG8ykVBdI9yhGKTsjql1LlHOmBYMxe8LdQ0aiPn
         FOrZkHhi71gWMElRc/+nZDIc37Ovh4daOgXI27VNo5Lm6G+uSRi2eJleBhPUYHAMWaVe
         Je+SDGrX5xqz+hJduBkUKQwneF70L2zxeijp/RuYvxRBFWJOKiIDx4o4lAkCnzJXmKQ3
         kynfcM0SOOrZ1IH50/JLNxtgCP1ucR7XEic3r9fu5PNsZOwvnqiRJqxQ39EXW4zp0J5D
         Tb9hvcAUvyUPGSwbjdXITUqYkKiJh8ZpUHFHH1+kWae9UEPhvMMo29rWP3h8jgAlgFQn
         CKIw==
X-Gm-Message-State: AOAM531U2N+4S5tGFXpkm6B3QxA/RqreZQrWbEJCFG7gOG9jFrvNCMss
        kaHT6fIV5sN513bXYHyH2yhv+rb0pECE+dACEz+hfw==
X-Google-Smtp-Source: ABdhPJw/4SmeDZBqDYlqcwvrvqfgT1rRWVjSyyrA29RQ1IxdNpKIkQ3bM9bJaZXagVgfIgqxsMUBQ6Izq9VZc3teCzU=
X-Received: by 2002:a05:6512:2111:: with SMTP id q17mr53660326lfr.371.1637560903930;
 Sun, 21 Nov 2021 22:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20211109034741.27083-1-chun-jie.chen@mediatek.com>
In-Reply-To: <20211109034741.27083-1-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 22 Nov 2021 14:01:32 +0800
Message-ID: <CAGXv+5H=ZVco7q3DLKNGJqDSZN-bDK3YPgFpN_Euc86+3TP56g@mail.gmail.com>
Subject: Re: [v1] clk: mediatek: Integrated vppsys with mtk-mmsys in MT8195
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 9, 2021 at 11:47 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Integrated vpp0 and vpp1 with mtk-mmsys driver which
> will populate device by platform_device_register_data
> to start vppsys clock driver.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
> This patch is based on v5.15-rc7 and [1].
>
> Due to the modification in [2], the vppsys clock driver will be trigger
> from mmsys driver
>
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=546235
> [2] https://patchwork.kernel.org/project/linux-mediatek/patch/20211020071448.14187-7-roy-cw.yeh@mediatek.com/
> ---
>  drivers/clk/mediatek/clk-mt8195-vpp0.c | 39 +++++++++++++++++---------
>  drivers/clk/mediatek/clk-mt8195-vpp1.c | 39 +++++++++++++++++---------
>  2 files changed, 50 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
> index c3241466a8d0..c7fec35db1e6 100644
> --- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
> +++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
> @@ -86,25 +86,36 @@ static const struct mtk_gate vpp0_clks[] = {
>         GATE_VPP0_2(CLK_VPP0_WARP1_MDP_DL_ASYNC, "vpp0_warp1_mdp_dl_async", "top_wpe_vpp", 3),
>  };
>
> -static const struct mtk_clk_desc vpp0_desc = {
> -       .clks = vpp0_clks,
> -       .num_clks = ARRAY_SIZE(vpp0_clks),
> -};
> +static int clk_mt8195_vpp0_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *node = dev->parent->of_node;
> +       struct clk_onecell_data *clk_data;
> +       int r;
>
> -static const struct of_device_id of_match_clk_mt8195_vpp0[] = {
> -       {
> -               .compatible = "mediatek,mt8195-vppsys0",
> -               .data = &vpp0_desc,

So we typically ask that old DT bindings have to be continuously supported.
I'm not sure if that applies in this case since no MT8195 devices have been
released to the public.

Assuming it's OK to not support it anymore, please also add a patch to remove
the VPPSYS compatible strings from the DT bindings.

> -       }, {
> -               /* sentinel */
> -       }
> -};
> +       clk_data = mtk_alloc_clk_data(CLK_VPP0_NR_CLK);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       r = mtk_clk_register_gates(node, vpp0_clks, ARRAY_SIZE(vpp0_clks), clk_data);
> +       if (r)
> +               goto free_vpp0_data;
> +
> +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +       if (r)
> +               goto free_vpp0_data;
> +
> +       return r;
> +
> +free_vpp0_data:
> +       mtk_free_clk_data(clk_data);

This is probably a bad idea given that clk_data is still used and could
be referenced through the registered clocks if of_clk_add_provider were
the function to fail.

> +       return r;
> +}
>
>  static struct platform_driver clk_mt8195_vpp0_drv = {
> -       .probe = mtk_clk_simple_probe,
> +       .probe = clk_mt8195_vpp0_probe,
>         .driver = {
>                 .name = "clk-mt8195-vpp0",
> -               .of_match_table = of_match_clk_mt8195_vpp0,
>         },
>  };
>  builtin_platform_driver(clk_mt8195_vpp0_drv);
> diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
> index ce0b9a40a179..40ec8c26ede6 100644
> --- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
> +++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
> @@ -84,25 +84,36 @@ static const struct mtk_gate vpp1_clks[] = {
>         GATE_VPP1_1(CLK_VPP1_VPP_SPLIT_26M, "vpp1_vpp_split_26m", "clk26m", 26),
>  };
>
> -static const struct mtk_clk_desc vpp1_desc = {
> -       .clks = vpp1_clks,
> -       .num_clks = ARRAY_SIZE(vpp1_clks),
> -};
> +static int clk_mt8195_vpp1_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *node = dev->parent->of_node;
> +       struct clk_onecell_data *clk_data;
> +       int r;
>
> -static const struct of_device_id of_match_clk_mt8195_vpp1[] = {
> -       {
> -               .compatible = "mediatek,mt8195-vppsys1",
> -               .data = &vpp1_desc,
> -       }, {
> -               /* sentinel */
> -       }
> -};
> +       clk_data = mtk_alloc_clk_data(CLK_VPP1_NR_CLK);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       r = mtk_clk_register_gates(node, vpp1_clks, ARRAY_SIZE(vpp1_clks), clk_data);
> +       if (r)
> +               goto free_vpp1_data;
> +
> +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +       if (r)
> +               goto free_vpp1_data;
> +
> +       return r;
> +
> +free_vpp1_data:
> +       mtk_free_clk_data(clk_data);
> +       return r;
> +}
>
>  static struct platform_driver clk_mt8195_vpp1_drv = {
> -       .probe = mtk_clk_simple_probe,
> +       .probe = clk_mt8195_vpp1_probe,
>         .driver = {
>                 .name = "clk-mt8195-vpp1",
> -               .of_match_table = of_match_clk_mt8195_vpp1,
>         },
>  };
>  builtin_platform_driver(clk_mt8195_vpp1_drv);
> --
> 2.18.0
>
