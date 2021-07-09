Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04783C227A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhGIKsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhGIKsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:48:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F991C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 03:45:47 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f30so22462176lfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 03:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C6mnLkibuTq3O3RIj/A8hWNd/xjHPJDMjDp1O/G3Qf8=;
        b=LzauGJ/W0SJTz14zlRSNp3tG3n9Ws3VCF9I3Gog1j48Ial81lRhuyOJirZjXtkPrP+
         AixliN35gUn87RpjY/M1wP5drdEFDx0DidjeHpy0NUBPRCTf4I7F8iwvXNjRajr+JTNN
         Q6k1Aqwq55REnZXeSgNZwNlz7EsQUbgevJ/0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C6mnLkibuTq3O3RIj/A8hWNd/xjHPJDMjDp1O/G3Qf8=;
        b=fdwWr3AmiAi+PHXGMI3COib7fsXLVz6gz0v1xbB17tC2ZDflDtIgop+grtJ7vQrmh2
         91Dj0sajVXxfow7M6KzyZ1IClFzQtaSjTYgR4KRPKQGoJXyZO7ttHgBUzW5XGSZQ+9x6
         4wjqurmKFNi5CoVz6U27cHWk/4M0Dhq6PxSRWb70iShOI4byQIyNwYVyyMXwxHuQBbeV
         nCnXE++wOQtItxDjgwMxttpmWu8QasuBSu2hELi582OfwSzhsgtiwkHwvjz2pIbehTol
         tmQ53AaQ81g7YyZ9bk5BN0i5sBBdMlxQIlbkDViT1OtxquDq0oZ+7MwVR9e5gDRnMWjk
         UwNg==
X-Gm-Message-State: AOAM532RNqCD+85OvvWCjWotc4lcXQxCfxwOTx/5kjZ04NBL71MRsgOX
        G5mkDBnMryYuH+F9J6IqKVkO9Q/T/yeyLuxw/JnV/w==
X-Google-Smtp-Source: ABdhPJx7RqOTMWa8I+UjEb9qnMaV29Z5bjjjl2WI7vBQRSsRr6A1xwWtK7BUmL37N4gurtLIBXKjiVTD256GsKYP1Jc=
X-Received: by 2002:a05:6512:1303:: with SMTP id x3mr27753514lfu.276.1625827545601;
 Fri, 09 Jul 2021 03:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-20-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-20-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 9 Jul 2021 18:45:34 +0800
Message-ID: <CAGXv+5EyKJ=-hY+-kzzeFOZhSwiTTmGPi-4ux01hyimJfoEJRw@mail.gmail.com>
Subject: Re: [PATCH 19/22] clk: mediatek: Add MT8195 vppsys1 clock support
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

On Thu, Jun 17, 2021 at 7:00 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 vppsys1 clock provider
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig           |   6 ++
>  drivers/clk/mediatek/Makefile          |   1 +
>  drivers/clk/mediatek/clk-mt8195-vpp1.c | 110 +++++++++++++++++++++++++
>  3 files changed, 117 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-vpp1.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 2deef026fbb4..91b1c19da1ab 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -672,6 +672,12 @@ config COMMON_CLK_MT8195_VPPSYS0
>         help
>           This driver supports MediaTek MT8195 vppsys0 clocks.
>
> +config COMMON_CLK_MT8195_VPPSYS1
> +       bool "Clock driver for MediaTek MT8195 vppsys1"
> +       depends on COMMON_CLK_MT8195
> +       help
> +         This driver supports MediaTek MT8195 vppsys1 clocks.
> +
>  config COMMON_CLK_MT8516
>         bool "Clock driver for MediaTek MT8516"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 34cd7f2c71ac..fbf57473bb91 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -95,5 +95,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS0) += clk-mt8195-vdo0.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS1) += clk-mt8195-vdo1.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS0) += clk-mt8195-vpp0.o
> +obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS1) += clk-mt8195-vpp1.o
>  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
>  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
> new file mode 100644
> index 000000000000..0650ba86d5b6
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
> @@ -0,0 +1,110 @@
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
> +static const struct mtk_gate_regs vpp10_cg_regs = {

Again, please add a separator.

> +       .set_ofs = 0x104,
> +       .clr_ofs = 0x108,
> +       .sta_ofs = 0x100,
> +};
> +
> +static const struct mtk_gate_regs vpp11_cg_regs = {
> +       .set_ofs = 0x114,
> +       .clr_ofs = 0x118,
> +       .sta_ofs = 0x110,
> +};
> +
> +#define GATE_VPP10(_id, _name, _parent, _shift)                        \
> +       GATE_MTK(_id, _name, _parent, &vpp10_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +#define GATE_VPP11(_id, _name, _parent, _shift)                        \
> +       GATE_MTK(_id, _name, _parent, &vpp11_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +static const struct mtk_gate vpp1_clks[] = {
> +       /* VPP10 */
> +       GATE_VPP10(CLK_VPP1_SVPP1_MDP_OVL, "vpp1_svpp1_mdp_ovl", "vpp_sel", 0),
> +       GATE_VPP10(CLK_VPP1_SVPP1_MDP_TCC, "vpp1_svpp1_mdp_tcc", "vpp_sel", 1),
> +       GATE_VPP10(CLK_VPP1_SVPP1_MDP_WROT, "vpp1_svpp1_mdp_wrot", "vpp_sel", 2),
> +       GATE_VPP10(CLK_VPP1_SVPP1_VPP_PAD, "vpp1_svpp1_vpp_pad", "vpp_sel", 3),
> +       GATE_VPP10(CLK_VPP1_SVPP2_MDP_WROT, "vpp1_svpp2_mdp_wrot", "vpp_sel", 4),
> +       GATE_VPP10(CLK_VPP1_SVPP2_VPP_PAD, "vpp1_svpp2_vpp_pad", "vpp_sel", 5),
> +       GATE_VPP10(CLK_VPP1_SVPP3_MDP_WROT, "vpp1_svpp3_mdp_wrot", "vpp_sel", 6),
> +       GATE_VPP10(CLK_VPP1_SVPP3_VPP_PAD, "vpp1_svpp3_vpp_pad", "vpp_sel", 7),
> +       GATE_VPP10(CLK_VPP1_SVPP1_MDP_RDMA, "vpp1_svpp1_mdp_rdma", "vpp_sel", 8),
> +       GATE_VPP10(CLK_VPP1_SVPP1_MDP_FG, "vpp1_svpp1_mdp_fg", "vpp_sel", 9),
> +       GATE_VPP10(CLK_VPP1_SVPP2_MDP_RDMA, "vpp1_svpp2_mdp_rdma", "vpp_sel", 10),
> +       GATE_VPP10(CLK_VPP1_SVPP2_MDP_FG, "vpp1_svpp2_mdp_fg", "vpp_sel", 11),
> +       GATE_VPP10(CLK_VPP1_SVPP3_MDP_RDMA, "vpp1_svpp3_mdp_rdma", "vpp_sel", 12),
> +       GATE_VPP10(CLK_VPP1_SVPP3_MDP_FG, "vpp1_svpp3_mdp_fg", "vpp_sel", 13),
> +       GATE_VPP10(CLK_VPP1_VPP_SPLIT, "vpp1_vpp_split", "vpp_sel", 14),
> +       GATE_VPP10(CLK_VPP1_SVPP2_VDO0_DL_RELAY, "vpp1_svpp2_vdo0_dl_relay", "vpp_sel", 15),
> +       GATE_VPP10(CLK_VPP1_SVPP1_MDP_TDSHP, "vpp1_svpp1_mdp_tdshp", "vpp_sel", 16),
> +       GATE_VPP10(CLK_VPP1_SVPP1_MDP_COLOR, "vpp1_svpp1_mdp_color", "vpp_sel", 17),
> +       GATE_VPP10(CLK_VPP1_SVPP3_VDO1_DL_RELAY, "vpp1_svpp3_vdo1_dl_relay", "vpp_sel", 18),
> +       GATE_VPP10(CLK_VPP1_SVPP2_VPP_MERGE, "vpp1_svpp2_vpp_merge", "vpp_sel", 19),
> +       GATE_VPP10(CLK_VPP1_SVPP2_MDP_COLOR, "vpp1_svpp2_mdp_color", "vpp_sel", 20),
> +       GATE_VPP10(CLK_VPP1_VPPSYS1_GALS, "vpp1_vppsys1_gals", "vpp_sel", 21),
> +       GATE_VPP10(CLK_VPP1_SVPP3_VPP_MERGE, "vpp1_svpp3_vpp_merge", "vpp_sel", 22),
> +       GATE_VPP10(CLK_VPP1_SVPP3_MDP_COLOR, "vpp1_svpp3_mdp_color", "vpp_sel", 23),
> +       GATE_VPP10(CLK_VPP1_VPPSYS1_LARB, "vpp1_vppsys1_larb", "vpp_sel", 24),
> +       GATE_VPP10(CLK_VPP1_SVPP1_MDP_RSZ, "vpp1_svpp1_mdp_rsz", "vpp_sel", 25),
> +       GATE_VPP10(CLK_VPP1_SVPP1_MDP_HDR, "vpp1_svpp1_mdp_hdr", "vpp_sel", 26),
> +       GATE_VPP10(CLK_VPP1_SVPP1_MDP_AAL, "vpp1_svpp1_mdp_aal", "vpp_sel", 27),
> +       GATE_VPP10(CLK_VPP1_SVPP2_MDP_HDR, "vpp1_svpp2_mdp_hdr", "vpp_sel", 28),
> +       GATE_VPP10(CLK_VPP1_SVPP2_MDP_AAL, "vpp1_svpp2_mdp_aal", "vpp_sel", 29),
> +       GATE_VPP10(CLK_VPP1_DL_ASYNC, "vpp1_dl_async", "vpp_sel", 30),
> +       GATE_VPP10(CLK_VPP1_LARB5_FAKE_ENG, "vpp1_larb5_fake_eng", "vpp_sel", 31),
> +       /* VPP11 */
> +       GATE_VPP11(CLK_VPP1_SVPP3_MDP_HDR, "vpp1_svpp3_mdp_hdr", "vpp_sel", 0),
> +       GATE_VPP11(CLK_VPP1_SVPP3_MDP_AAL, "vpp1_svpp3_mdp_aal", "vpp_sel", 1),
> +       GATE_VPP11(CLK_VPP1_SVPP2_VDO1_DL_RELAY, "vpp1_svpp2_vdo1_dl_relay", "vpp_sel", 2),
> +       GATE_VPP11(CLK_VPP1_LARB6_FAKE_ENG, "vpp1_larb6_fake_eng", "vpp_sel", 3),
> +       GATE_VPP11(CLK_VPP1_SVPP2_MDP_RSZ, "vpp1_svpp2_mdp_rsz", "vpp_sel", 4),
> +       GATE_VPP11(CLK_VPP1_SVPP3_MDP_RSZ, "vpp1_svpp3_mdp_rsz", "vpp_sel", 5),
> +       GATE_VPP11(CLK_VPP1_SVPP3_VDO0_DL_RELAY, "vpp1_svpp3_vdo0_dl_relay", "vpp_sel", 6),
> +       GATE_VPP11(CLK_VPP1_DISP_MUTEX, "vpp1_disp_mutex", "vpp_sel", 7),
> +       GATE_VPP11(CLK_VPP1_SVPP2_MDP_TDSHP, "vpp1_svpp2_mdp_tdshp", "vpp_sel", 8),
> +       GATE_VPP11(CLK_VPP1_SVPP3_MDP_TDSHP, "vpp1_svpp3_mdp_tdshp", "vpp_sel", 9),
> +       GATE_VPP11(CLK_VPP1_VPP0_DL1_RELAY, "vpp1_vpp0_dl1_relay", "vpp_sel", 10),
> +       GATE_VPP11(CLK_VPP1_HDMI_META, "vpp1_hdmi_meta", "hdmirx_p", 11),
> +       GATE_VPP11(CLK_VPP1_VPP_SPLIT_HDMI, "vpp1_vpp_split_hdmi", "hdmirx_p", 12),
> +       GATE_VPP11(CLK_VPP1_DGI_IN, "vpp1_dgi_in", "in_dgi", 13),
> +       GATE_VPP11(CLK_VPP1_DGI_OUT, "vpp1_dgi_out", "dgi_out_sel", 14),
> +       GATE_VPP11(CLK_VPP1_VPP_SPLIT_DGI, "vpp1_vpp_split_dgi", "dgi_out_sel", 15),
> +       GATE_VPP11(CLK_VPP1_VPP0_DL_ASYNC, "vpp1_vpp0_dl_async", "vpp_sel", 16),
> +       GATE_VPP11(CLK_VPP1_VPP0_DL_RELAY, "vpp1_vpp0_dl_relay", "vpp_sel", 17),
> +       GATE_VPP11(CLK_VPP1_VPP_SPLIT_26M, "vpp1_vpp_split_26m", "clk26m", 26),

The last two aren't in the datasheet.

Same general comments apply.


ChenYu

> +};
> +
> +static const struct mtk_clk_desc vpp1_desc = {
> +       .clks = vpp1_clks,
> +       .num_clks = ARRAY_SIZE(vpp1_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt8195_vpp1[] = {
> +       {
> +               .compatible = "mediatek,mt8195-vppsys1",
> +               .data = &vpp1_desc,
> +       }, {
> +               /* sentinel */
> +       }
> +};
> +
> +static struct platform_driver clk_mt8195_vpp1_drv = {
> +       .probe = mtk_clk_simple_probe,
> +       .driver = {
> +               .name = "clk-mt8195-vpp1",
> +               .of_match_table = of_match_clk_mt8195_vpp1,
> +       },
> +};
> +
> +builtin_platform_driver(clk_mt8195_vpp1_drv);
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
