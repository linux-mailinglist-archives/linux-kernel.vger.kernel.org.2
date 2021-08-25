Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9847A3F7458
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbhHYL1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240429AbhHYL1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:27:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C94C0617AD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:26:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z2so52268510lft.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ad8sfEanI/P2gqbx0+RDbxQL5YHtRuIij9aFXTHy9SM=;
        b=Ab9HX+wBnW7YX1DmSEzGOoUTQoNnMPzJvtFS1gLT/kY0w68ruHVyx7iixeb8cytVle
         nnWKMnSI1o1/qnLFDtxEXAZPbnkZLtyyQwhJo3NbZu/IIi0vMgkVtqH1chWiZIFrf+Ob
         FRnIDpxiRSLBLAJtj+5Aj6H7C18gLTcPIbXHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ad8sfEanI/P2gqbx0+RDbxQL5YHtRuIij9aFXTHy9SM=;
        b=UUBzhObJXrfiu5XDYmYePlBRrEE3L20uGQ/4w7ez0Jb8p5YoI7Njbj5qxD7sgyWAyz
         0bmlPHAmB/moAaVACsTFsYO1mUO3SuMPr8nwh97NZWc36TqxZ28xCNkLqFyDPqcBqrOj
         1od4LQwxUv55c9Y6NKruZhrDmTx1Rt6P3jvEO3NkdTti9ZtReLGSyOoa+yzFQFvAncki
         me/6VdfDfSoBXTXQ4yPyPv86S5eXOP1iE/Rdu8/+wILYeIet60bW2aOl94aNWxeAUTB/
         +aoYXisxbOpsQ01hFxmWmpC1OpsiELfHfIJUb/0UtG6F52UkhWq0j+FlpilYG30Qr7pG
         VIhw==
X-Gm-Message-State: AOAM530VynHWpaSvkAByRwm/LOxTnbIY7aF/QAmE9d7h1tiQegfGz/H6
        /z5u6nItBPSpkzbg9SwYCaAQgpk3IqrHzqEQN0Q0og==
X-Google-Smtp-Source: ABdhPJyBUeWb/mVP1WV8hy3oYPf+OxksTnXXt/xsvr4fpVlwURrml+Df/UncNKjD5Lm8Q3HHzxK/2fnm1rGokYsOmIo=
X-Received: by 2002:a05:6512:456:: with SMTP id y22mr32018328lfk.647.1629890792018;
 Wed, 25 Aug 2021 04:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-21-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-21-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 25 Aug 2021 19:26:21 +0800
Message-ID: <CAGXv+5GF6e+uo31TaStjsR_baJC2Tug_zkaZpw_Ww76HBV0aSQ@mail.gmail.com>
Subject: Re: [PATCH 20/22] clk: mediatek: Add MT8195 wpesys clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
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

On Thu, Jun 17, 2021 at 7:12 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 wpesys clock providers
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig          |   6 ++
>  drivers/clk/mediatek/Makefile         |   1 +
>  drivers/clk/mediatek/clk-mt8195-wpe.c | 145 ++++++++++++++++++++++++++
>  3 files changed, 152 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-wpe.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 91b1c19da1ab..5089bacdf0a5 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -678,6 +678,12 @@ config COMMON_CLK_MT8195_VPPSYS1
>         help
>           This driver supports MediaTek MT8195 vppsys1 clocks.
>
> +config COMMON_CLK_MT8195_WPESYS
> +       bool "Clock driver for MediaTek MT8195 wpesys"
> +       depends on COMMON_CLK_MT8195
> +       help
> +         This driver supports MediaTek MT8195 wpesys clocks.
> +
>  config COMMON_CLK_MT8516
>         bool "Clock driver for MediaTek MT8516"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index fbf57473bb91..32cfb0030d92 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -96,5 +96,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS1) += clk-mt8195-vdo1.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS0) += clk-mt8195-vpp0.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS1) += clk-mt8195-vpp1.o
> +obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
>  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
>  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt8195-wpe.c b/drivers/clk/mediatek/clk-mt8195-wpe.c
> new file mode 100644
> index 000000000000..99e8b1297ef7
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8195-wpe.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (c) 2021 MediaTek Inc.
> +// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mt8195-clk.h>
> +
> +static const struct mtk_gate_regs wpe_cg_regs = {
> +       .set_ofs = 0x0,
> +       .clr_ofs = 0x0,
> +       .sta_ofs = 0x0,
> +};
> +
> +static const struct mtk_gate_regs wpe_vpp0_cg_regs = {
> +       .set_ofs = 0x58,
> +       .clr_ofs = 0x58,
> +       .sta_ofs = 0x58,
> +};
> +
> +static const struct mtk_gate_regs wpe_vpp1_cg_regs = {
> +       .set_ofs = 0x5c,
> +       .clr_ofs = 0x5c,
> +       .sta_ofs = 0x5c,
> +};
> +
> +#define GATE_WPE(_id, _name, _parent, _shift)                  \
> +       GATE_MTK(_id, _name, _parent, &wpe_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
> +
> +#define GATE_WPE_VPP0(_id, _name, _parent, _shift)                     \
> +       GATE_MTK(_id, _name, _parent, &wpe_vpp0_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
> +
> +#define GATE_WPE_VPP1(_id, _name, _parent, _shift)                     \
> +       GATE_MTK(_id, _name, _parent, &wpe_vpp1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
> +
> +static const struct mtk_gate wpe_clks[] = {
> +       GATE_WPE(CLK_WPE_VPP0, "wpe_vpp0", "wpe_vpp_sel", 16),
> +       GATE_WPE(CLK_WPE_VPP1, "wpe_vpp1", "wpe_vpp_sel", 17),
> +       GATE_WPE(CLK_WPE_SMI_LARB7, "wpe_smi_larb7", "wpe_vpp_sel", 18),
> +       GATE_WPE(CLK_WPE_SMI_LARB8, "wpe_smi_larb8", "wpe_vpp_sel", 19),
> +       GATE_WPE(CLK_WPE_EVENT_TX, "wpe_event_tx", "wpe_vpp_sel", 20),
> +       GATE_WPE(CLK_WPE_SMI_LARB7_P, "wpe_smi_larb7_p", "wpe_vpp_sel", 24),
> +       GATE_WPE(CLK_WPE_SMI_LARB8_P, "wpe_smi_larb8_p", "wpe_vpp_sel", 25),
> +};
> +
> +static const struct mtk_gate wpe_vpp0_clks[] = {
> +       /* WPE_VPP0 */
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_VGEN, "wpe_vpp0_vgen", "img_sel", 0),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_EXT, "wpe_vpp0_ext", "img_sel", 1),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_VFC, "wpe_vpp0_vfc", "img_sel", 2),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH0_TOP, "wpe_vpp0_cach0_top", "img_sel", 3),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH0_DMA, "wpe_vpp0_cach0_dma", "img_sel", 4),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH1_TOP, "wpe_vpp0_cach1_top", "img_sel", 5),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH1_DMA, "wpe_vpp0_cach1_dma", "img_sel", 6),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH2_TOP, "wpe_vpp0_cach2_top", "img_sel", 7),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH2_DMA, "wpe_vpp0_cach2_dma", "img_sel", 8),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH3_TOP, "wpe_vpp0_cach3_top", "img_sel", 9),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH3_DMA, "wpe_vpp0_cach3_dma", "img_sel", 10),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_PSP, "wpe_vpp0_psp", "img_sel", 11),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_PSP2, "wpe_vpp0_psp2", "img_sel", 12),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_SYNC, "wpe_vpp0_sync", "img_sel", 13),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_C24, "wpe_vpp0_c24", "img_sel", 14),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_MDP_CROP, "wpe_vpp0_mdp_crop", "img_sel", 15),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_ISP_CROP, "wpe_vpp0_isp_crop", "img_sel", 16),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_TOP, "wpe_vpp0_top", "img_sel", 17),
> +       /* WPE_VPP1 */
> +       GATE_WPE_VPP1(CLK_WPE_VPP0_VECI, "wpe_vpp0_veci", "img_sel", 0),
> +       GATE_WPE_VPP1(CLK_WPE_VPP0_VEC2I, "wpe_vpp0_vec2i", "img_sel", 1),
> +       GATE_WPE_VPP1(CLK_WPE_VPP0_VEC3I, "wpe_vpp0_vec3i", "img_sel", 2),
> +       GATE_WPE_VPP1(CLK_WPE_VPP0_WPEO, "wpe_vpp0_wpeo", "img_sel", 3),
> +       GATE_WPE_VPP1(CLK_WPE_VPP0_MSKO, "wpe_vpp0_msko", "img_sel", 4),
> +};
> +
> +static const struct mtk_gate wpe_vpp1_clks[] = {
> +       /* WPE_VPP0 */
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_VGEN, "wpe_vpp1_vgen", "img_sel", 0),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_EXT, "wpe_vpp1_ext", "img_sel", 1),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_VFC, "wpe_vpp1_vfc", "img_sel", 2),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH0_TOP, "wpe_vpp1_cach0_top", "img_sel", 3),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH0_DMA, "wpe_vpp1_cach0_dma", "img_sel", 4),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH1_TOP, "wpe_vpp1_cach1_top", "img_sel", 5),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH1_DMA, "wpe_vpp1_cach1_dma", "img_sel", 6),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH2_TOP, "wpe_vpp1_cach2_top", "img_sel", 7),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH2_DMA, "wpe_vpp1_cach2_dma", "img_sel", 8),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH3_TOP, "wpe_vpp1_cach3_top", "img_sel", 9),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH3_DMA, "wpe_vpp1_cach3_dma", "img_sel", 10),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_PSP, "wpe_vpp1_psp", "img_sel", 11),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_PSP2, "wpe_vpp1_psp2", "img_sel", 12),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_SYNC, "wpe_vpp1_sync", "img_sel", 13),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_C24, "wpe_vpp1_c24", "img_sel", 14),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_MDP_CROP, "wpe_vpp1_mdp_crop", "img_sel", 15),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_ISP_CROP, "wpe_vpp1_isp_crop", "img_sel", 16),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_TOP, "wpe_vpp1_top", "img_sel", 17),
> +       /* WPE_VPP1 */
> +       GATE_WPE_VPP1(CLK_WPE_VPP1_VECI, "wpe_vpp1_veci", "img_sel", 0),
> +       GATE_WPE_VPP1(CLK_WPE_VPP1_VEC2I, "wpe_vpp1_vec2i", "img_sel", 1),
> +       GATE_WPE_VPP1(CLK_WPE_VPP1_VEC3I, "wpe_vpp1_vec3i", "img_sel", 2),
> +       GATE_WPE_VPP1(CLK_WPE_VPP1_WPEO, "wpe_vpp1_wpeo", "img_sel", 3),
> +       GATE_WPE_VPP1(CLK_WPE_VPP1_MSKO, "wpe_vpp1_msko", "img_sel", 4),
> +};
> +
> +static const struct mtk_clk_desc wpe_desc = {
> +       .clks = wpe_clks,
> +       .num_clks = ARRAY_SIZE(wpe_clks),
> +};
> +
> +static const struct mtk_clk_desc wpe_vpp0_desc = {
> +       .clks = wpe_vpp0_clks,
> +       .num_clks = ARRAY_SIZE(wpe_vpp0_clks),
> +};
> +
> +static const struct mtk_clk_desc wpe_vpp1_desc = {
> +       .clks = wpe_vpp1_clks,
> +       .num_clks = ARRAY_SIZE(wpe_vpp1_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt8195_wpe[] = {
> +       {
> +               .compatible = "mediatek,mt8195-wpesys",
> +               .data = &wpe_desc,
> +       }, {
> +               .compatible = "mediatek,mt8195-wpesys_vpp0",
> +               .data = &wpe_vpp0_desc,
> +       }, {
> +               .compatible = "mediatek,mt8195-wpesys_vpp1",
> +               .data = &wpe_vpp1_desc,

Same comment as vencsys patch: wpesys_vpp0 and wpesys_vpp1 look the same.
Are they identical hardware blocks? Are different compatible strings
really needed?

I suggest adding clock-output-names to the device tree, and patching
mtk_clk_register_gates_with_dev() to try to get a clock name from the
device tree, and falling back to the predefined name in the list.
Something like:

<---------------
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 74890759e98c..71e856c22960 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -125,11 +125,15 @@ int mtk_clk_register_gates_with_dev(struct
device_node *node,

        for (i = 0; i < num; i++) {
                const struct mtk_gate *gate = &clks[i];
+               const char *name = gate->name;

                if (!IS_ERR_OR_NULL(clk_data->clks[gate->id]))
                        continue;

-               clk = mtk_clk_register_gate(gate->name, gate->parent_name,
+               of_property_read_string(node, "clock-output-names", gate->id,
+                                       &name);
+
+               clk = mtk_clk_register_gate(name, gate->parent_name,
                                regmap,
                                gate->regs->set_ofs,
                                gate->regs->clr_ofs,
<---------------
(tabs replaced with spaces, do not apply directly)


ChenYu


> +       }, {
> +               /* sentinel */
> +       }
> +};
> +
> +static struct platform_driver clk_mt8195_wpe_drv = {
> +       .probe = mtk_clk_simple_probe,
> +       .driver = {
> +               .name = "clk-mt8195-wpe",
> +               .of_match_table = of_match_clk_mt8195_wpe,
> +       },
> +};
> +
> +builtin_platform_driver(clk_mt8195_wpe_drv);
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
