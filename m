Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B971E3F746B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbhHYLfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbhHYLfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:35:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCABC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:34:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so52257567lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDNGfADHAqW6vSVlz7z9lC+759YNOq26F+TEFjneqXI=;
        b=LfqWM8T2PML+0536NAS/u9pr1ZJOBG4YF6BOmFEF+hQBvW3hK4gGQUYeo39T1ELqTc
         h5OqsmgMTYI5rNchO9dVFP4xGsJiV8IhRu3s1DwFDkSMg9GT97Aa5gVx6mmgcAtThhzT
         zkKAtRW8NQ7dANIexfOSm9iWe4v6IebYHE0SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDNGfADHAqW6vSVlz7z9lC+759YNOq26F+TEFjneqXI=;
        b=LaKHJmAAaWs2JHvN8DAnkostXsoHNeVJwtGgoW9lFXGkrhcuavDy+EfrRRjlRqSAlf
         HzIf4EL0Ch7JM5JnXMqyx5G1m94Q2cLtRRs+TSNv7bNq/RLA7QLp7AHbOqsZ2begTZts
         +P7Jy846DEcGy41jh0Ba8H9Z+LCHWOmsFMLI/0Z79inE0Dq4xZwxOY8tXPptLN+q1Ivr
         HqdQZZflw28IfXD9XHsPKsNx814iP4UjZeLH6Z2w1sFOulMHqN5UnISErRzNXjT1jQQM
         /LIEyN6TLQOtM3Jms/axaK/BZx/peyMhf1N9eH8ivAH6b53Y60fpzaJcvkUzjp51u3LN
         7TWQ==
X-Gm-Message-State: AOAM531BDoDXmH4f3b4pGI9AFRHQt+ZxmX98Eov37kn1o2j8ZVDlv3gJ
        DBL9dIyKjUCzVWUc219iKyMipa9GBmdZ/uYSL50KZA==
X-Google-Smtp-Source: ABdhPJyiPUzB1QHt1uTMIGAUhYhCllBCwB6KIF0su+UxU1/HFotnND4NVHz0RbcTfLQX8r9T/kVOhDvFKrdXMTwxjG4=
X-Received: by 2002:ac2:4116:: with SMTP id b22mr33375322lfi.587.1629891293357;
 Wed, 25 Aug 2021 04:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111504.350-1-chun-jie.chen@mediatek.com> <20210820111504.350-23-chun-jie.chen@mediatek.com>
In-Reply-To: <20210820111504.350-23-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 25 Aug 2021 19:34:42 +0800
Message-ID: <CAGXv+5Fde-Ka3qzaQR799AYTooKJWMgEkYio4cRLG4_1hasFXg@mail.gmail.com>
Subject: Re: [v2 22/24] clk: mediatek: Add MT8195 wpesys clock support
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

On Fri, Aug 20, 2021 at 7:33 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 wpesys clock controllers which provide clock gate
> control in Wrapping Engine.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Makefile         |   2 +-
>  drivers/clk/mediatek/clk-mt8195-wpe.c | 143 ++++++++++++++++++++++++++
>  2 files changed, 144 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-wpe.c
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 402a809ff6ac..dfe7047c6795 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -83,6 +83,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o clk-mt8195-cam.o \
>                                         clk-mt8195-ccu.o clk-mt8195-img.o clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-scp_adsp.o \
>                                         clk-mt8195-vdec.o clk-mt8195-vdo0.o clk-mt8195-vdo1.o clk-mt8195-venc.o clk-mt8195-vpp0.o \
> -                                       clk-mt8195-vpp1.o
> +                                       clk-mt8195-vpp1.o clk-mt8195-wpe.o
>  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
>  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt8195-wpe.c b/drivers/clk/mediatek/clk-mt8195-wpe.c
> new file mode 100644
> index 000000000000..7e92a3cab497
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8195-wpe.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Copyright (c) 2021 MediaTek Inc.
> +// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +
> +#include <dt-bindings/clock/mt8195-clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
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
> +       GATE_WPE(CLK_WPE_VPP0, "wpe_vpp0", "top_wpe_vpp", 16),
> +       GATE_WPE(CLK_WPE_VPP1, "wpe_vpp1", "top_wpe_vpp", 17),
> +       GATE_WPE(CLK_WPE_SMI_LARB7, "wpe_smi_larb7", "top_wpe_vpp", 18),
> +       GATE_WPE(CLK_WPE_SMI_LARB8, "wpe_smi_larb8", "top_wpe_vpp", 19),
> +       GATE_WPE(CLK_WPE_EVENT_TX, "wpe_event_tx", "top_wpe_vpp", 20),
> +       GATE_WPE(CLK_WPE_SMI_LARB7_P, "wpe_smi_larb7_p", "top_wpe_vpp", 24),
> +       GATE_WPE(CLK_WPE_SMI_LARB8_P, "wpe_smi_larb8_p", "top_wpe_vpp", 25),
> +};
> +
> +static const struct mtk_gate wpe_vpp0_clks[] = {
> +       /* WPE_VPP0 */
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_VGEN, "wpe_vpp0_vgen", "top_img", 0),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_EXT, "wpe_vpp0_ext", "top_img", 1),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_VFC, "wpe_vpp0_vfc", "top_img", 2),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH0_TOP, "wpe_vpp0_cach0_top", "top_img", 3),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH0_DMA, "wpe_vpp0_cach0_dma", "top_img", 4),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH1_TOP, "wpe_vpp0_cach1_top", "top_img", 5),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH1_DMA, "wpe_vpp0_cach1_dma", "top_img", 6),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH2_TOP, "wpe_vpp0_cach2_top", "top_img", 7),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH2_DMA, "wpe_vpp0_cach2_dma", "top_img", 8),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH3_TOP, "wpe_vpp0_cach3_top", "top_img", 9),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_CACH3_DMA, "wpe_vpp0_cach3_dma", "top_img", 10),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_PSP, "wpe_vpp0_psp", "top_img", 11),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_PSP2, "wpe_vpp0_psp2", "top_img", 12),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_SYNC, "wpe_vpp0_sync", "top_img", 13),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_C24, "wpe_vpp0_c24", "top_img", 14),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_MDP_CROP, "wpe_vpp0_mdp_crop", "top_img", 15),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_ISP_CROP, "wpe_vpp0_isp_crop", "top_img", 16),
> +       GATE_WPE_VPP0(CLK_WPE_VPP0_TOP, "wpe_vpp0_top", "top_img", 17),
> +       /* WPE_VPP1 */
> +       GATE_WPE_VPP1(CLK_WPE_VPP0_VECI, "wpe_vpp0_veci", "top_img", 0),
> +       GATE_WPE_VPP1(CLK_WPE_VPP0_VEC2I, "wpe_vpp0_vec2i", "top_img", 1),
> +       GATE_WPE_VPP1(CLK_WPE_VPP0_VEC3I, "wpe_vpp0_vec3i", "top_img", 2),
> +       GATE_WPE_VPP1(CLK_WPE_VPP0_WPEO, "wpe_vpp0_wpeo", "top_img", 3),
> +       GATE_WPE_VPP1(CLK_WPE_VPP0_MSKO, "wpe_vpp0_msko", "top_img", 4),
> +};
> +
> +static const struct mtk_gate wpe_vpp1_clks[] = {
> +       /* WPE_VPP0 */
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_VGEN, "wpe_vpp1_vgen", "top_img", 0),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_EXT, "wpe_vpp1_ext", "top_img", 1),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_VFC, "wpe_vpp1_vfc", "top_img", 2),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH0_TOP, "wpe_vpp1_cach0_top", "top_img", 3),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH0_DMA, "wpe_vpp1_cach0_dma", "top_img", 4),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH1_TOP, "wpe_vpp1_cach1_top", "top_img", 5),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH1_DMA, "wpe_vpp1_cach1_dma", "top_img", 6),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH2_TOP, "wpe_vpp1_cach2_top", "top_img", 7),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH2_DMA, "wpe_vpp1_cach2_dma", "top_img", 8),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH3_TOP, "wpe_vpp1_cach3_top", "top_img", 9),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_CACH3_DMA, "wpe_vpp1_cach3_dma", "top_img", 10),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_PSP, "wpe_vpp1_psp", "top_img", 11),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_PSP2, "wpe_vpp1_psp2", "top_img", 12),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_SYNC, "wpe_vpp1_sync", "top_img", 13),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_C24, "wpe_vpp1_c24", "top_img", 14),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_MDP_CROP, "wpe_vpp1_mdp_crop", "top_img", 15),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_ISP_CROP, "wpe_vpp1_isp_crop", "top_img", 16),
> +       GATE_WPE_VPP0(CLK_WPE_VPP1_TOP, "wpe_vpp1_top", "top_img", 17),
> +       /* WPE_VPP1 */
> +       GATE_WPE_VPP1(CLK_WPE_VPP1_VECI, "wpe_vpp1_veci", "top_img", 0),
> +       GATE_WPE_VPP1(CLK_WPE_VPP1_VEC2I, "wpe_vpp1_vec2i", "top_img", 1),
> +       GATE_WPE_VPP1(CLK_WPE_VPP1_VEC3I, "wpe_vpp1_vec3i", "top_img", 2),
> +       GATE_WPE_VPP1(CLK_WPE_VPP1_WPEO, "wpe_vpp1_wpeo", "top_img", 3),
> +       GATE_WPE_VPP1(CLK_WPE_VPP1_MSKO, "wpe_vpp1_msko", "top_img", 4),

(Reply to correct patch revision...)

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
> +builtin_platform_driver(clk_mt8195_wpe_drv);
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
