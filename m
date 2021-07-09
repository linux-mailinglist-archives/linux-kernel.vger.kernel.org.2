Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB523C224D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhGIKlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhGIKlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:41:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930A9C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 03:38:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t17so22477128lfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kr+mzl4YBf0/RmdEJ7awDHnpgGzk2lig2YhllN5tTq0=;
        b=FZ4LYicw/5tcOYffzm8t0tDPekesR/UlaYnmgU7IPabvYleTMDcQPSlWx5JsbrYdyQ
         DzJwhaB0iZafGCl5ToypD4Y9kBGMHZTbgX9KQDo+cxQipu56EgZEEXa2vuWh/9eFVpv9
         6qWjQJGmYDr5eqgWwirUNBeX+dQF39tbHe4D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kr+mzl4YBf0/RmdEJ7awDHnpgGzk2lig2YhllN5tTq0=;
        b=NBoo05HAdmqlYvTOCCqTvFtMRramfzgljYtvsVQ+mxKYjNNBPK6HhXk7Ff6OIeuU2x
         psl9DRhn04wvPHBAlVUo7E5oPp//+VAounx0MPBhFTMAEoALjteMikGZVZuTvYw/tJ+A
         Cu0y7be0bwNMpcQcNrYz/0vs3wO4YlNy/Wtgs6VQokUQRp+JogLJTbsL4XNlCqS1xead
         nZ9hIW2aEh7SiNOA4R2Aegzij2KgazMVkiKqym3ZDunnJsgoctsf8jkMiAF5ternvAWp
         1nEvOzRy/rINe5hK6ow12SMo0BSG27uUEJNY9B99waPKluV661bwilr6Fpjzxt+Jra4z
         YK8g==
X-Gm-Message-State: AOAM531Ne/aPG3SrpupTqvMQ1XP++8XxE53oZn/hafo33TxidoRBD7M/
        fW4SzE6w/qRpOHrkHU4MLjnV0OZtlJ5FjryQ4kjefg==
X-Google-Smtp-Source: ABdhPJz5V2lqK1lm3Yjt/SqYNsoS6SUNHeE/yvRazu6AV415xvrALqJtUOXg8UBG9cV+ctPKrLNIZboGOZS8Zy3KjKc=
X-Received: by 2002:a19:858b:: with SMTP id h133mr9083244lfd.656.1625827094943;
 Fri, 09 Jul 2021 03:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-19-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-19-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 9 Jul 2021 18:38:03 +0800
Message-ID: <CAGXv+5Ga+Q91OYkOvJ+5ZoFgFrvJE4VNa1o1um00HjCmp+uB8w@mail.gmail.com>
Subject: Re: [PATCH 18/22] clk: mediatek: Add MT8195 vppsys0 clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 17, 2021 at 7:10 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 vppsys0 clock provider
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig           |   6 ++
>  drivers/clk/mediatek/Makefile          |   1 +
>  drivers/clk/mediatek/clk-mt8195-vpp0.c | 112 +++++++++++++++++++++++++
>  3 files changed, 119 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-vpp0.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 3352686d98cf..2deef026fbb4 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -666,6 +666,12 @@ config COMMON_CLK_MT8195_VENCSYS
>         help
>           This driver supports MediaTek MT8195 vencsys clocks.
>
> +config COMMON_CLK_MT8195_VPPSYS0
> +       bool "Clock driver for MediaTek MT8195 vppsys0"
> +       depends on COMMON_CLK_MT8195
> +       help
> +         This driver supports MediaTek MT8195 vppsys0 clocks.
> +
>  config COMMON_CLK_MT8516
>         bool "Clock driver for MediaTek MT8516"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 76a6b404e34b..34cd7f2c71ac 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -94,5 +94,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VDECSYS) += clk-mt8195-vdec.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS0) += clk-mt8195-vdo0.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS1) += clk-mt8195-vdo1.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
> +obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS0) += clk-mt8195-vpp0.o
>  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
>  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
> new file mode 100644
> index 000000000000..cecd8fab7b7e
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
> @@ -0,0 +1,112 @@
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
> +static const struct mtk_gate_regs vpp00_cg_regs = {

Like with VDOSYS, please add a separator between the two indices.

> +       .set_ofs = 0x24,
> +       .clr_ofs = 0x28,
> +       .sta_ofs = 0x20,
> +};
> +
> +static const struct mtk_gate_regs vpp01_cg_regs = {
> +       .set_ofs = 0x30,
> +       .clr_ofs = 0x34,
> +       .sta_ofs = 0x2c,
> +};
> +
> +static const struct mtk_gate_regs vpp02_cg_regs = {
> +       .set_ofs = 0x3c,
> +       .clr_ofs = 0x40,
> +       .sta_ofs = 0x38,
> +};
> +
> +#define GATE_VPP00(_id, _name, _parent, _shift)                        \
> +       GATE_MTK(_id, _name, _parent, &vpp00_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +#define GATE_VPP01(_id, _name, _parent, _shift)                        \
> +       GATE_MTK(_id, _name, _parent, &vpp01_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +#define GATE_VPP02(_id, _name, _parent, _shift)                        \
> +       GATE_MTK(_id, _name, _parent, &vpp02_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +static const struct mtk_gate vpp0_clks[] = {
> +       /* VPP00 */
> +       GATE_VPP00(CLK_VPP0_MDP_FG, "vpp0_mdp_fg", "vpp_sel", 1),
> +       GATE_VPP00(CLK_VPP0_STITCH, "vpp0_stitch", "vpp_sel", 2),
> +       GATE_VPP00(CLK_VPP0_PADDING, "vpp0_padding", "vpp_sel", 7),
> +       GATE_VPP00(CLK_VPP0_MDP_TCC, "vpp0_mdp_tcc", "vpp_sel", 8),
> +       GATE_VPP00(CLK_VPP0_WARP0_ASYNC_TX, "vpp0_warp0_async_tx", "vpp_sel", 10),
> +       GATE_VPP00(CLK_VPP0_WARP1_ASYNC_TX, "vpp0_warp1_async_tx", "vpp_sel", 11),
> +       GATE_VPP00(CLK_VPP0_MUTEX, "vpp0_mutex", "vpp_sel", 13),
> +       GATE_VPP00(CLK_VPP0_VPP02VPP1_RELAY, "vpp0_vpp02vpp1_relay", "vpp_sel", 14),
> +       GATE_VPP00(CLK_VPP0_VPP12VPP0_ASYNC, "vpp0_vpp12vpp0_async", "vpp_sel", 15),
> +       GATE_VPP00(CLK_VPP0_MMSYSRAM_TOP, "vpp0_mmsysram_top", "vpp_sel", 16),
> +       GATE_VPP00(CLK_VPP0_MDP_AAL, "vpp0_mdp_aal", "vpp_sel", 17),
> +       GATE_VPP00(CLK_VPP0_MDP_RSZ, "vpp0_mdp_rsz", "vpp_sel", 18),
> +       /* VPP01 */
> +       GATE_VPP01(CLK_VPP0_SMI_COMMON, "vpp0_smi_common", "vpp_sel", 0),
> +       GATE_VPP01(CLK_VPP0_GALS_VDO0_LARB0, "vpp0_gals_vdo0_larb0", "vpp_sel", 1),
> +       GATE_VPP01(CLK_VPP0_GALS_VDO0_LARB1, "vpp0_gals_vdo0_larb1", "vpp_sel", 2),
> +       GATE_VPP01(CLK_VPP0_GALS_VENCSYS, "vpp0_gals_vencsys", "vpp_sel", 3),
> +       GATE_VPP01(CLK_VPP0_GALS_VENCSYS_CORE1, "vpp0_gals_vencsys_core1", "vpp_sel", 4),
> +       GATE_VPP01(CLK_VPP0_GALS_INFRA, "vpp0_gals_infra", "vpp_sel", 5),
> +       GATE_VPP01(CLK_VPP0_GALS_CAMSYS, "vpp0_gals_camsys", "vpp_sel", 6),
> +       GATE_VPP01(CLK_VPP0_GALS_VPP1_LARB5, "vpp0_gals_vpp1_larb5", "vpp_sel", 7),
> +       GATE_VPP01(CLK_VPP0_GALS_VPP1_LARB6, "vpp0_gals_vpp1_larb6", "vpp_sel", 8),
> +       GATE_VPP01(CLK_VPP0_SMI_REORDER, "vpp0_smi_reorder", "vpp_sel", 9),
> +       GATE_VPP01(CLK_VPP0_SMI_IOMMU, "vpp0_smi_iommu", "vpp_sel", 10),
> +       GATE_VPP01(CLK_VPP0_GALS_IMGSYS_CAMSYS, "vpp0_gals_imgsys_camsys", "vpp_sel", 11),
> +       GATE_VPP01(CLK_VPP0_MDP_RDMA, "vpp0_mdp_rdma", "vpp_sel", 12),
> +       GATE_VPP01(CLK_VPP0_MDP_WROT, "vpp0_mdp_wrot", "vpp_sel", 13),
> +       GATE_VPP01(CLK_VPP0_GALS_EMI0_EMI1, "vpp0_gals_emi0_emi1", "vpp_sel", 16),
> +       GATE_VPP01(CLK_VPP0_SMI_SUB_COMMON_REORDER, "vpp0_smi_sub_common_reorder", "vpp_sel", 17),
> +       GATE_VPP01(CLK_VPP0_SMI_RSI, "vpp0_smi_rsi", "vpp_sel", 18),
> +       GATE_VPP01(CLK_VPP0_SMI_COMMON_LARB4, "vpp0_smi_common_larb4", "vpp_sel", 19),
> +       GATE_VPP01(CLK_VPP0_GALS_VDEC_VDEC_CORE1, "vpp0_gals_vdec_vdec_core1", "vpp_sel", 20),
> +       GATE_VPP01(CLK_VPP0_GALS_VPP1_WPE, "vpp0_gals_vpp1_wpe", "vpp_sel", 21),
> +       GATE_VPP01(CLK_VPP0_GALS_VDO0_VDO1_VENCSYS_CORE1, "vpp0_gals_vdo0_vdo1_vencsys_core1",
> +               "vpp_sel", 22),
> +       GATE_VPP01(CLK_VPP0_FAKE_ENG, "vpp0_fake_eng", "vpp_sel", 23),
> +       GATE_VPP01(CLK_VPP0_MDP_HDR, "vpp0_mdp_hdr", "vpp_sel", 24),
> +       GATE_VPP01(CLK_VPP0_MDP_TDSHP, "vpp0_mdp_tdshp", "vpp_sel", 25),
> +       GATE_VPP01(CLK_VPP0_MDP_COLOR, "vpp0_mdp_color", "vpp_sel", 26),
> +       GATE_VPP01(CLK_VPP0_MDP_OVL, "vpp0_mdp_ovl", "vpp_sel", 27),
> +       /* VPP02 */
> +       GATE_VPP02(CLK_VPP0_WARP0_RELAY, "vpp0_warp0_relay", "wpe_vpp_sel", 0),
> +       GATE_VPP02(CLK_VPP0_WARP0_MDP_DL_ASYNC, "vpp0_warp0_mdp_dl_async", "wpe_vpp_sel", 1),
> +       GATE_VPP02(CLK_VPP0_WARP1_RELAY, "vpp0_warp1_relay", "wpe_vpp_sel", 2),
> +       GATE_VPP02(CLK_VPP0_WARP1_MDP_DL_ASYNC, "vpp0_warp1_mdp_dl_async", "wpe_vpp_sel", 3),
> +};

Unfortunately bits 0 - 11 in VPP01 and bits 1 and 3 in VPP02 are marked
as reserved in our datasheet, so I can't check the validity of them.
Same goes for bits 16-22 in VPP02 which are only marked as SMI.

Same general comments as before also apply.


ChenYu

> +
> +static const struct mtk_clk_desc vpp0_desc = {
> +       .clks = vpp0_clks,
> +       .num_clks = ARRAY_SIZE(vpp0_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt8195_vpp0[] = {
> +       {
> +               .compatible = "mediatek,mt8195-vppsys0",
> +               .data = &vpp0_desc,
> +       }, {
> +               /* sentinel */
> +       }
> +};
> +
> +static struct platform_driver clk_mt8195_vpp0_drv = {
> +       .probe = mtk_clk_simple_probe,
> +       .driver = {
> +               .name = "clk-mt8195-vpp0",
> +               .of_match_table = of_match_clk_mt8195_vpp0,
> +       },
> +};
> +
> +builtin_platform_driver(clk_mt8195_vpp0_drv);
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
