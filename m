Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7253C210D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhGIIyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 04:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhGIIyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 04:54:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A409C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 01:51:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q18so21892590lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CwMW62WAAwpmyJgQD0h1DiuOTDS2nkEHBj7w1HcY3kM=;
        b=bgFvcNDm4rzhzmnJI8gAgjkVoelxZQajuh6oKo+BWa46Q9cCE9K6N64k9sOSXxMk3+
         XIuCvLx72F3RH2GfdNyic5FiPYqIG5U5SQPmzgnv99G+/A8dxyUL2VRdJZ312q+lI7Qn
         V9zg1Ve0Sjmp8IYfmfRLzUJgG4coj1oJ2/4LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CwMW62WAAwpmyJgQD0h1DiuOTDS2nkEHBj7w1HcY3kM=;
        b=ILsK8TtWy8dJnsicp7LHyK6s3dxZU+9t6gtjP3cAfQyjnEJZc+ttoq/ZRwEqdHy0gC
         dec3C9wnXV+xiezZEOCeKran9DTQAQAtqjIzMXtEA7k7QGMqvxKfDYFz6W6Rkyi+4ySe
         Ih5S+lTVU1jhO4Lf2LKGLcgluFsuejeHGNc45/dvP/yWXG48P4iBIOAW+v7kr6ZQAcrp
         Hn9IdsP3LaBkUmBew9v7XuXqX5+l9FYTwWcDrM4OmJH+PbrMeTosJhtVHdanMA0IDxEv
         P0oCAs17Z/lGI4C65rq6FnBo+WmNtOIFLniXi5FYV+sM/otqthrHvr2TWw8j5c8c0cU0
         AI+g==
X-Gm-Message-State: AOAM530VqIwQvcjLOabwq89PoUtQUCeblUMAjoaTMYy44nIvXSD99tEL
        hxdyUDTUg85qDFJ0jUZgV4qISQzj62xq2eugzHLm4A==
X-Google-Smtp-Source: ABdhPJy2HfouwNNwkjfvfIGtS7PKmxFbKD3IPSiQtKRWJc8MEdZy4o5QBKE9wHvu2dWQOTcHB9oWvsAyTF66OmnsUz4=
X-Received: by 2002:a05:6512:3f13:: with SMTP id y19mr27455181lfa.444.1625820706714;
 Fri, 09 Jul 2021 01:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-16-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-16-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 9 Jul 2021 16:51:35 +0800
Message-ID: <CAGXv+5GHwmL82q5ibTAh_GVLPny7yzMacm34uUxdR33Pzc-t2g@mail.gmail.com>
Subject: Re: [PATCH 15/22] clk: mediatek: Add MT8195 vdosys0 clock support
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

On Thu, Jun 17, 2021 at 7:03 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 vdosys0 clock provider
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig           |   6 ++
>  drivers/clk/mediatek/Makefile          |   1 +
>  drivers/clk/mediatek/clk-mt8195-vdo0.c | 114 +++++++++++++++++++++++++
>  3 files changed, 121 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-vdo0.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index b7881b8ebb23..6602f9ba13c7 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -648,6 +648,12 @@ config COMMON_CLK_MT8195_VDECSYS
>         help
>           This driver supports MediaTek MT8195 vdecsys clocks.
>
> +config COMMON_CLK_MT8195_VDOSYS0
> +       bool "Clock driver for MediaTek MT8195 vdosys0"
> +       depends on COMMON_CLK_MT8195
> +       help
> +         This driver supports MediaTek MT8195 vdosys0 clocks.
> +

Same comments about commit log and Kconfig option.

>  config COMMON_CLK_MT8516
>         bool "Clock driver for MediaTek MT8516"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 9acfa705f1de..6aa1ba00342a 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -91,5 +91,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_MFGCFG) += clk-mt8195-mfg.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_SCP_ADSP) += clk-mt8195-scp_adsp.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_NNASYS) += clk-mt8195-nna.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VDECSYS) += clk-mt8195-vdec.o
> +obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS0) += clk-mt8195-vdo0.o
>  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
>  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
> new file mode 100644
> index 000000000000..4a34ccb0beed
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
> @@ -0,0 +1,114 @@
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

Alphabetical order within the same group please.

> +
> +#include <dt-bindings/clock/mt8195-clk.h>
> +
> +static const struct mtk_gate_regs vdo00_cg_regs = {
> +       .set_ofs = 0x104,
> +       .clr_ofs = 0x108,
> +       .sta_ofs = 0x100,
> +};
> +
> +static const struct mtk_gate_regs vdo01_cg_regs = {
> +       .set_ofs = 0x114,
> +       .clr_ofs = 0x118,
> +       .sta_ofs = 0x110,
> +};
> +
> +static const struct mtk_gate_regs vdo02_cg_regs = {
> +       .set_ofs = 0x124,
> +       .clr_ofs = 0x128,
> +       .sta_ofs = 0x120,
> +};
> +
> +#define GATE_VDO00(_id, _name, _parent, _shift)                        \
> +       GATE_MTK(_id, _name, _parent, &vdo00_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +#define GATE_VDO01(_id, _name, _parent, _shift)                        \
> +       GATE_MTK(_id, _name, _parent, &vdo01_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +#define GATE_VDO02(_id, _name, _parent, _shift)                        \
> +       GATE_MTK(_id, _name, _parent, &vdo02_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +static const struct mtk_gate vdo0_clks[] = {
> +       /* VDO00 */
> +       GATE_VDO00(CLK_VDO0_DISP_OVL0, "vdo0_disp_ovl0", "vpp_sel", 0),
> +       GATE_VDO00(CLK_VDO0_DISP_COLOR0, "vdo0_disp_color0", "vpp_sel", 2),
> +       GATE_VDO00(CLK_VDO0_DISP_COLOR1, "vdo0_disp_color1", "vpp_sel", 3),
> +       GATE_VDO00(CLK_VDO0_DISP_CCORR0, "vdo0_disp_ccorr0", "vpp_sel", 4),
> +       GATE_VDO00(CLK_VDO0_DISP_CCORR1, "vdo0_disp_ccorr1", "vpp_sel", 5),
> +       GATE_VDO00(CLK_VDO0_DISP_AAL0, "vdo0_disp_aal0", "vpp_sel", 6),
> +       GATE_VDO00(CLK_VDO0_DISP_AAL1, "vdo0_disp_aal1", "vpp_sel", 7),
> +       GATE_VDO00(CLK_VDO0_DISP_GAMMA0, "vdo0_disp_gamma0", "vpp_sel", 8),
> +       GATE_VDO00(CLK_VDO0_DISP_GAMMA1, "vdo0_disp_gamma1", "vpp_sel", 9),
> +       GATE_VDO00(CLK_VDO0_DISP_DITHER0, "vdo0_disp_dither0", "vpp_sel", 10),
> +       GATE_VDO00(CLK_VDO0_DISP_DITHER1, "vdo0_disp_dither1", "vpp_sel", 11),
> +       GATE_VDO00(CLK_VDO0_DISP_OVL1, "vdo0_disp_ovl1", "vpp_sel", 16),
> +       GATE_VDO00(CLK_VDO0_DISP_WDMA0, "vdo0_disp_wdma0", "vpp_sel", 17),
> +       GATE_VDO00(CLK_VDO0_DISP_WDMA1, "vdo0_disp_wdma1", "vpp_sel", 18),
> +       GATE_VDO00(CLK_VDO0_DISP_RDMA0, "vdo0_disp_rdma0", "vpp_sel", 19),
> +       GATE_VDO00(CLK_VDO0_DISP_RDMA1, "vdo0_disp_rdma1", "vpp_sel", 20),
> +       GATE_VDO00(CLK_VDO0_DSI0, "vdo0_dsi0", "vpp_sel", 21),
> +       GATE_VDO00(CLK_VDO0_DSI1, "vdo0_dsi1", "vpp_sel", 22),
> +       GATE_VDO00(CLK_VDO0_DSC_WRAP0, "vdo0_dsc_wrap0", "vpp_sel", 23),
> +       GATE_VDO00(CLK_VDO0_VPP_MERGE0, "vdo0_vpp_merge0", "vpp_sel", 24),
> +       GATE_VDO00(CLK_VDO0_DP_INTF0, "vdo0_dp_intf0", "vpp_sel", 25),
> +       GATE_VDO00(CLK_VDO0_DISP_MUTEX0, "vdo0_disp_mutex0", "vpp_sel", 26),
> +       GATE_VDO00(CLK_VDO0_DISP_IL_ROT0, "vdo0_disp_il_rot0", "vpp_sel", 27),
> +       GATE_VDO00(CLK_VDO0_APB_BUS, "vdo0_apb_bus", "vpp_sel", 28),
> +       GATE_VDO00(CLK_VDO0_FAKE_ENG0, "vdo0_fake_eng0", "vpp_sel", 29),
> +       GATE_VDO00(CLK_VDO0_FAKE_ENG1, "vdo0_fake_eng1", "vpp_sel", 30),
> +       /* VDO01 */
> +       GATE_VDO01(CLK_VDO0_DL_ASYNC0, "vdo0_dl_async0", "vpp_sel", 0),
> +       GATE_VDO01(CLK_VDO0_DL_ASYNC1, "vdo0_dl_async1", "vpp_sel", 1),
> +       GATE_VDO01(CLK_VDO0_DL_ASYNC2, "vdo0_dl_async2", "vpp_sel", 2),
> +       GATE_VDO01(CLK_VDO0_DL_ASYNC3, "vdo0_dl_async3", "vpp_sel", 3),
> +       GATE_VDO01(CLK_VDO0_DL_ASYNC4, "vdo0_dl_async4", "vpp_sel", 4),
> +       GATE_VDO01(CLK_VDO0_DISP_MONITOR0, "vdo0_disp_monitor0", "vpp_sel", 5),
> +       GATE_VDO01(CLK_VDO0_DISP_MONITOR1, "vdo0_disp_monitor1", "vpp_sel", 6),
> +       GATE_VDO01(CLK_VDO0_DISP_MONITOR2, "vdo0_disp_monitor2", "vpp_sel", 7),
> +       GATE_VDO01(CLK_VDO0_DISP_MONITOR3, "vdo0_disp_monitor3", "vpp_sel", 8),
> +       GATE_VDO01(CLK_VDO0_DISP_MONITOR4, "vdo0_disp_monitor4", "vpp_sel", 9),
> +       GATE_VDO01(CLK_VDO0_SMI_GALS, "vdo0_smi_gals", "vpp_sel", 10),
> +       GATE_VDO01(CLK_VDO0_SMI_COMMON, "vdo0_smi_common", "vpp_sel", 11),
> +       GATE_VDO01(CLK_VDO0_SMI_EMI, "vdo0_smi_emi", "vpp_sel", 12),
> +       GATE_VDO01(CLK_VDO0_SMI_IOMMU, "vdo0_smi_iommu", "vpp_sel", 13),
> +       GATE_VDO01(CLK_VDO0_SMI_LARB, "vdo0_smi_larb", "vpp_sel", 14),
> +       GATE_VDO01(CLK_VDO0_SMI_RSI, "vdo0_smi_rsi", "vpp_sel", 15),
> +       /* VDO02 */
> +       GATE_VDO02(CLK_VDO0_DSI0_DSI, "vdo0_dsi0_dsi", "dsi_occ_sel", 0),
> +       GATE_VDO02(CLK_VDO0_DSI1_DSI, "vdo0_dsi1_dsi", "dsi_occ_sel", 8),
> +       GATE_VDO02(CLK_VDO0_DP_INTF0_DP_INTF, "vdo0_dp_intf0_dp_intf", "edp_sel", 16),
> +};
> +
> +static const struct mtk_clk_desc vdo0_desc = {
> +       .clks = vdo0_clks,
> +       .num_clks = ARRAY_SIZE(vdo0_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt8195_vdo0[] = {
> +       {
> +               .compatible = "mediatek,mt8195-vdosys0",
> +               .data = &vdo0_desc,
> +       }, {
> +               /* sentinel */
> +       }
> +};
> +
> +static struct platform_driver clk_mt8195_vdo0_drv = {
> +       .probe = mtk_clk_simple_probe,
> +       .driver = {
> +               .name = "clk-mt8195-vdo0",
> +               .of_match_table = of_match_clk_mt8195_vdo0,
> +       },
> +};
> +

Can drop the empty line here.

Overall the code looks good.


ChenYu


> +builtin_platform_driver(clk_mt8195_vdo0_drv);
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
