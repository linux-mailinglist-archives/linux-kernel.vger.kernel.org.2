Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF2F3F4986
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhHWLR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbhHWLRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:17:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DCCC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:17:08 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p38so37271977lfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8iLaZTWeQJl6iGd266WbOlLff6luDbqFrxB/cAn80YQ=;
        b=TcCgBTHb/Rs9nRpQG++G77unwTBKtjJ4Dp7AZlW7FIncIs94bCVvQ5U4sDTfvgf9Xt
         KV9b4PeuzP5DeplauxcUhcDxI+g8ZQ5ax6ytlADE2+L1eWBrNdaOeAtgMjjwwoHQiosB
         Sj4NtVNfk2tA4/djiKPnhoeM1poW2B29JjvWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8iLaZTWeQJl6iGd266WbOlLff6luDbqFrxB/cAn80YQ=;
        b=Nq/MA+MxgxgSMRHmYjEri6tYndvfLtzyB7j+1i9bMw5BH4ztNUiiOyztGNhtGJ/Bnc
         /GGuWr6NIR9v+gxJWIu6ThkN6V3imOIsb8o+sv7cr6eeQVbkmIa4+TJZyfCeTwrCNZoR
         gBecYXLpO/t18mgTDILuYkZEYRj8nxCNBab1v8yIRqYnIFO+h0JAGRWrR+9HWaHS5TA6
         OBaf/hrYK1daTyLtRkBCwkJGLBNsF+B5hspqGjYGQWle1hWUuCkjrtGRhyQbDVAplkhW
         ymv3f+hUsTLAzTecswGSDhZW4jcerspKhOAiHOg5cePbV0tKJ3QItCd6U1TRoTLWT/xd
         sVpg==
X-Gm-Message-State: AOAM533hEAk9/ZBiKyoUwPDbF5DBk/uBQVdiTM15+DFaWqgEv6579gn6
        giP8+3bAB9XSikkuIC3aeE3TUb5uPKTEdd8E1DUpcw==
X-Google-Smtp-Source: ABdhPJxMxt92OJ2YG0/F1XWWeVdd/8FS5KcGSQF5fZ9YbMu+oL61YlsJqouyFzi4LPLGPqg4hSE5facaGcpocjicWqg=
X-Received: by 2002:a05:6512:3b98:: with SMTP id g24mr17084296lfv.276.1629717427045;
 Mon, 23 Aug 2021 04:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111504.350-1-chun-jie.chen@mediatek.com> <20210820111504.350-8-chun-jie.chen@mediatek.com>
In-Reply-To: <20210820111504.350-8-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 23 Aug 2021 19:16:56 +0800
Message-ID: <CAGXv+5GaUBWV0tD4uP6Gx6Pg7BvF_Dzp5pdV73b_0MD1kYr03A@mail.gmail.com>
Subject: Re: [v2 07/24] clk: mediatek: Add MT8195 topckgen clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 7:20 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 topckgen clock controller which provides muxes, dividers
> to handle variety clock selection in other IP blocks.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
> The changes as follow:
> 1. remove 1 on 1 divider
> 2. merge parent source data in muxes
> 3. add some comment if the clock is not model by CCF or has special flag
> 4. remove _SEL suffix in clock name
> ---
>  drivers/clk/mediatek/Makefile              |    2 +-
>  drivers/clk/mediatek/clk-mt8195-topckgen.c | 1298 ++++++++++++++++++++
>  2 files changed, 1299 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-topckgen.c
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index d4157cfca865..a142342a0cea 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -80,6 +80,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_MSDC) += clk-mt8192-msdc.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_SCP_ADSP) += clk-mt8192-scp_adsp.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
> -obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o
> +obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o
>  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
>  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> new file mode 100644
> index 000000000000..3cf113544f59
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> @@ -0,0 +1,1298 @@

[...]

> +static const char * const dsp_parents[] = {
> +       "clk26m",
> +       "univpll_d6_d2",
> +       "univpll_d4_d2",
> +       "univpll_d5",
> +       "univpll_d4",
> +       "mmpll_d4",
> +       "mainpll_d3",
> +       "univpll_d3"
> +};
> +
> +static const char * const dsp1_parents[] = {
> +       "clk26m",
> +       "univpll_d6_d2",
> +       "mainpll_d4_d2",
> +       "univpll_d5",
> +       "mmpll_d5",
> +       "univpll_d4",
> +       "mainpll_d3",
> +       "univpll_d3"
> +};
> +
> +static const char * const dsp2_parents[] = {
> +       "clk26m",
> +       "univpll_d6_d2",
> +       "univpll_d4_d2",
> +       "mainpll_d4",
> +       "univpll_d4",
> +       "mmpll_d4",
> +       "mainpll_d3",
> +       "univpll_d3"
> +};
> +
> +static const char * const dsp3_parents[] = {
> +       "clk26m",
> +       "univpll_d6_d2",
> +       "univpll_d4_d2",
> +       "univpll_d5",
> +       "univpll_d4",
> +       "mmpll_d4",
> +       "mainpll_d3",
> +       "univpll_d3"
> +};

dsp3_parents looks like it matches dsp_parents. If so, please deduplicate.

[...]

> +static const struct mtk_mux top_mtk_muxes[] = {

[...]

> +       /* CLK_CFG_29 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_DVIO_DGI_REF, "top_dvio_dgi_ref",
> +               dvio_dgi_ref_parents, 0x017C, 0x0180, 0x0184, 0, 3, 7, 0x010, 20),
> +       MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_ULPOSC, "top_ulposc",
> +               ulposc_parents, 0x017C, 0x0180, 0x0184, 8, 2, 15, 0x010, 21, CLK_IS_CRITICAL),
> +       MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_ULPOSC_CORE, "top_ulposc_core",
> +               ulposc_core_parents, 0x017C, 0x0180, 0x0184, 16, 2, 23, 0x010, 22, CLK_IS_CRITICAL),
> +       MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SRCK, "top_srck",
> +               srck_parents, 0x017C, 0x0180, 0x0184, 24, 1, 31, 0x010, 23, CLK_IS_CRITICAL),

Any comments regarding the three critical clocks?

> +       /*
> +        * the clocks in CLK_CFG_30 ~ 37 are backup clock source, no need to handled
> +        * by Linux.
> +        */
> +};
> +
> +static struct mtk_composite top_muxes[] = {
> +       /* CLK_MISC_CFG_3 */
> +       MUX(CLK_TOP_MFG_CK_FAST_REF, "mfg_ck_fast_ref", mfg_fast_parents, 0x0250, 8, 1),
> +};
> +
> +/*
> + * apll12_div5 ~ 9 are not used in MT8195.
> + */
> +static const struct mtk_composite top_adj_divs[] = {
> +       DIV_GATE(CLK_TOP_APLL12_DIV0, "apll12_div0", "top_i2si1_mck", 0x0320, 0, 0x0328, 8, 0),
> +       DIV_GATE(CLK_TOP_APLL12_DIV1, "apll12_div1", "top_i2si2_mck", 0x0320, 1, 0x0328, 8, 8),
> +       DIV_GATE(CLK_TOP_APLL12_DIV2, "apll12_div2", "top_i2so1_mck", 0x0320, 2, 0x0328, 8, 16),
> +       DIV_GATE(CLK_TOP_APLL12_DIV3, "apll12_div3", "top_i2so2_mck", 0x0320, 3, 0x0328, 8, 24),
> +       DIV_GATE(CLK_TOP_APLL12_DIV4, "apll12_div4", "top_aud_iec_clk", 0x0320, 4, 0x0334, 8, 0),

The comment could be inlined here directly:

          /* apll12_div5 ~ 9 are not used in MT8195 */

> +       DIV_GATE(CLK_TOP_APLL12_DIV9, "apll12_div9", "top_dptx_mck", 0x0320, 9, 0x0338, 8, 8),
> +};
> +
> +static const struct mtk_gate_regs top0_cg_regs = {
> +       .set_ofs = 0x238,
> +       .clr_ofs = 0x238,
> +       .sta_ofs = 0x238,
> +};
> +
> +static const struct mtk_gate_regs top1_cg_regs = {
> +       .set_ofs = 0x250,
> +       .clr_ofs = 0x250,
> +       .sta_ofs = 0x250,
> +};
> +
> +#define GATE_TOP0_FLAGS(_id, _name, _parent, _shift, _flag)            \
> +       GATE_MTK_FLAGS(_id, _name, _parent, &top0_cg_regs, _shift,      \
> +               &mtk_clk_gate_ops_no_setclr_inv, _flag)
> +
> +#define GATE_TOP0(_id, _name, _parent, _shift)                 \
> +       GATE_TOP0_FLAGS(_id, _name, _parent, _shift, 0)
> +
> +#define GATE_TOP1(_id, _name, _parent, _shift)                 \
> +       GATE_MTK(_id, _name, _parent, &top1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
> +
> +/*
> + * cfg_axi_east, cfg_axi_east_north, cfg_axi_north and cfg_axi_south
> + * are peripheral bus clock branches.
> + */
> +static const struct mtk_gate top_clks[] = {
> +       /* TOP0 */
> +       GATE_TOP0(CLK_TOP_CFG_VPP0, "cfg_vpp0", "top_vpp", 0),
> +       GATE_TOP0(CLK_TOP_CFG_VPP1, "cfg_vpp1", "top_vpp", 1),
> +       GATE_TOP0(CLK_TOP_CFG_VDO0, "cfg_vdo0", "top_vpp", 2),
> +       GATE_TOP0(CLK_TOP_CFG_VDO1, "cfg_vdo1", "top_vpp", 3),
> +       GATE_TOP0(CLK_TOP_CFG_UNIPLL_SES, "cfg_unipll_ses", "univpll_d2", 4),
> +       GATE_TOP0(CLK_TOP_CFG_26M_VPP0, "cfg_26m_vpp0", "clk26m", 5),
> +       GATE_TOP0(CLK_TOP_CFG_26M_VPP1, "cfg_26m_vpp1", "clk26m", 6),
> +       GATE_TOP0(CLK_TOP_CFG_26M_AUD, "cfg_26m_aud", "clk26m", 9),
> +       GATE_TOP0_FLAGS(CLK_TOP_CFG_AXI_EAST, "cfg_axi_east", "top_axi", 10, CLK_IS_CRITICAL),
> +       GATE_TOP0_FLAGS(CLK_TOP_CFG_AXI_EAST_NORTH, "cfg_axi_east_north", "top_axi", 11,
> +               CLK_IS_CRITICAL),
> +       GATE_TOP0_FLAGS(CLK_TOP_CFG_AXI_NORTH, "cfg_axi_north", "top_axi", 12, CLK_IS_CRITICAL),
> +       GATE_TOP0_FLAGS(CLK_TOP_CFG_AXI_SOUTH, "cfg_axi_south", "top_axi", 13, CLK_IS_CRITICAL),
> +       GATE_TOP0(CLK_TOP_CFG_EXT_TEST, "cfg_ext_test", "msdcpll_d2", 15),
> +       /* TOP1 */
> +       GATE_TOP1(CLK_TOP_SSUSB_REF, "ssusb_ref", "clk26m", 0),
> +       GATE_TOP1(CLK_TOP_SSUSB_PHY_REF, "ssusb_phy_ref", "clk26m", 1),
> +       GATE_TOP1(CLK_TOP_SSUSB_P1_REF, "ssusb_p1_ref", "clk26m", 2),
> +       GATE_TOP1(CLK_TOP_SSUSB_PHY_P1_REF, "ssusb_phy_p1_ref", "clk26m", 3),
> +       GATE_TOP1(CLK_TOP_SSUSB_P2_REF, "ssusb_p2_ref", "clk26m", 4),
> +       GATE_TOP1(CLK_TOP_SSUSB_PHY_P2_REF, "ssusb_phy_p2_ref", "clk26m", 5),
> +       GATE_TOP1(CLK_TOP_SSUSB_P3_REF, "ssusb_p3_ref", "clk26m", 6),
> +       GATE_TOP1(CLK_TOP_SSUSB_PHY_P3_REF, "ssusb_phy_p3_ref", "clk26m", 7),
> +};
> +
> +static struct clk_onecell_data *top_clk_data;
> +
> +static void clk_mt8195_top_init_early(struct device_node *node)
> +{
> +       int i;
> +
> +       top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> +       if (!top_clk_data)
> +               return;
> +
> +       for (i = 0; i < CLK_TOP_NR_CLK; i++)
> +               top_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
> +
> +       mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);

It's still not clear to me why this is needed...

> +
> +       if (of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data)) {
> +               mtk_free_clk_data(top_clk_data);
> +               top_clk_data = NULL;
> +       }
> +}
> +
> +CLK_OF_DECLARE_DRIVER(mt8195_topckgen, "mediatek,mt8195-topckgen",
> +                       clk_mt8195_top_init_early);
> +
> +static const struct of_device_id of_match_clk_mt8195_topck[] = {
> +       { .compatible = "mediatek,mt8195-topckgen", },
> +       {}
> +};
> +
> +static int clk_mt8195_topck_probe(struct platform_device *pdev)
> +{
> +       struct device_node *node = pdev->dev.of_node;
> +       int r;
> +       void __iomem *base;
> +
> +       if (!top_clk_data)
> +               return -EFAULT;

-ENODEV is more appropriate. -EFAULT signals a bad address (access).

See include/uapi/asm-generic/errno-base.h

> +
> +       base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
> +                                       top_clk_data);
> +       mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);

And this second invocation will fail because the same clocks have already
been registered. It seems like this invocation is enough to have "clk26m_d2"
registered before all of its children.

If so then CLK_OF_DECLARE_DRIVER is not necessary, that part could be
dropped, and the clk_data initialization moved into this probe function.
And `top_early_divs` could be merged with `top_divs`.

> +       mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
> +       mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node,
> +                                       &mt8195_clk_lock, top_clk_data);
> +       mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
> +                                       &mt8195_clk_lock, top_clk_data);
> +       mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
> +                                       &mt8195_clk_lock, top_clk_data);

Please align wrapped lines with the opening parenthesis.


Regards
ChenYu

> +       r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
> +       if (r)
> +               return r;
> +
> +       return of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
> +}
> +
> +static struct platform_driver clk_mt8195_topck_drv = {
> +       .probe = clk_mt8195_topck_probe,
> +       .driver = {
> +               .name = "clk-mt8195-topck",
> +               .of_match_table = of_match_clk_mt8195_topck,
> +       },
> +};
> +builtin_platform_driver(clk_mt8195_topck_drv);
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
