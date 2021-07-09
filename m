Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AC93C20F1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 10:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhGIInv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 04:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhGIInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 04:43:49 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CABBC0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 01:41:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b40so6825143ljf.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9ysEL8huxU2AWOCNwXERtpklLMvq4dpnPKkchZzOjw=;
        b=bvBrsDokhh6s1kmHIWG5pza0A5d/C2X3XL8vsoYiZit+aPEE4TcZHLs87EbOsQKzkV
         QtDr8Z2N8K3OaTP02LITMimfFokRJYnVh0SPoeSrfGERioyEWTerDmB6B+Mz+qmBFtDa
         UGN0uiXgWSWC3RuwJ0m1h6tCt/dkBjLC0e2Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9ysEL8huxU2AWOCNwXERtpklLMvq4dpnPKkchZzOjw=;
        b=IB9zTsviE6gW5VxrGJf5Az4GggwK8bEBw+4Lpv2fz8BSMiZbkvh1VnbHNusQAxuO9r
         iF6+tdbvEQzhsUBuxHOERRKJwFE4rugd6UdQMd3+qCc7P25A3sExR6wQ5sKHxQB/OTGZ
         S8coZAJwhM2SuVtflo2DTqUp+CQCRKjyIsAdlya6FvWMR0j72gMqpDhjQ1CGyMoG7e3u
         FPyMvi1bO+AL5nIsvQuNrLeWNiRiBUjvsDLOLTmzSJOCZzTnMsB5/fJIUZmR2fm1wVq9
         6MUvq9EVawl8u/EaZJg8o+BbKSIxOOX13XXEA9k9Lc1skHshNqpTcLHO9fCVGZ4J1MQ6
         HJ7g==
X-Gm-Message-State: AOAM531Ya51o2LTi1LXFUk2s8YjiapdqSburH4O1tZ2hEF2xEdsn6sCC
        3f48ZJN2mnGgRqVZIq3eMQNkeZlbjtAOEBQIxbLLng==
X-Google-Smtp-Source: ABdhPJw0A8Xx6mxsgAmLjYXEUr5pu2iZlVFWnKdDd+TBB1ERwfLINur9fK2TnvDhO84RWMlZzkAOKWwe1xzvDg4YNTw=
X-Received: by 2002:a2e:b55b:: with SMTP id a27mr17421733ljn.251.1625820064844;
 Fri, 09 Jul 2021 01:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-15-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-15-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 9 Jul 2021 16:40:53 +0800
Message-ID: <CAGXv+5GbyKpT9mTseCc2t94UWBCoPWtrXUfd_ZqXOewhP3QEZw@mail.gmail.com>
Subject: Re: [PATCH 14/22] clk: mediatek: Add MT8195 vdecsys clock support
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

On Thu, Jun 17, 2021 at 7:02 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 vdecsys clock providers
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig           |   6 ++
>  drivers/clk/mediatek/Makefile          |   1 +
>  drivers/clk/mediatek/clk-mt8195-vdec.c | 106 +++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-vdec.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index d34517728f4a..b7881b8ebb23 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -642,6 +642,12 @@ config COMMON_CLK_MT8195_NNASYS
>         help
>           This driver supports MediaTek MT8195 nnasys clocks.
>
> +config COMMON_CLK_MT8195_VDECSYS
> +       bool "Clock driver for MediaTek MT8195 vdecsys"
> +       depends on COMMON_CLK_MT8195
> +       help
> +         This driver supports MediaTek MT8195 vdecsys clocks.
> +

Same comments about the commit log and Kconfig option.

>  config COMMON_CLK_MT8516
>         bool "Clock driver for MediaTek MT8516"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 49e585a7ac8e..9acfa705f1de 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -90,5 +90,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_IPESYS) += clk-mt8195-ipe.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_MFGCFG) += clk-mt8195-mfg.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_SCP_ADSP) += clk-mt8195-scp_adsp.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_NNASYS) += clk-mt8195-nna.o
> +obj-$(CONFIG_COMMON_CLK_MT8195_VDECSYS) += clk-mt8195-vdec.o
>  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
>  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt8195-vdec.c b/drivers/clk/mediatek/clk-mt8195-vdec.c
> new file mode 100644
> index 000000000000..9ab84e75e1a0
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8195-vdec.c
> @@ -0,0 +1,106 @@
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

Please order alphabetically. I think this applies to all the other patches.
I missed this in the earlier ones, but please fix them nonetheless.

> +
> +#include <dt-bindings/clock/mt8195-clk.h>
> +
> +static const struct mtk_gate_regs vdec0_cg_regs = {
> +       .set_ofs = 0x0,
> +       .clr_ofs = 0x4,
> +       .sta_ofs = 0x0,
> +};
> +
> +static const struct mtk_gate_regs vdec1_cg_regs = {
> +       .set_ofs = 0x200,
> +       .clr_ofs = 0x204,
> +       .sta_ofs = 0x200,
> +};
> +
> +static const struct mtk_gate_regs vdec2_cg_regs = {
> +       .set_ofs = 0x8,
> +       .clr_ofs = 0xc,
> +       .sta_ofs = 0x8,
> +};
> +
> +#define GATE_VDEC0(_id, _name, _parent, _shift)                        \
> +       GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
> +
> +#define GATE_VDEC1(_id, _name, _parent, _shift)                        \
> +       GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
> +
> +#define GATE_VDEC2(_id, _name, _parent, _shift)                        \
> +       GATE_MTK(_id, _name, _parent, &vdec2_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
> +
> +static const struct mtk_gate vdec_clks[] = {
> +       /* VDEC0 */
> +       GATE_VDEC0(CLK_VDEC_VDEC, "vdec_vdec", "vdec_sel", 0),
> +       /* VDEC1 */
> +       GATE_VDEC1(CLK_VDEC_LAT, "vdec_lat", "vdec_sel", 0),
> +       /* VDEC2 */
> +       GATE_VDEC2(CLK_VDEC_LARB1, "vdec_larb1", "vdec_sel", 0),
> +};
> +
> +static const struct mtk_gate vdec_core1_clks[] = {
> +       /* VDEC0 */
> +       GATE_VDEC0(CLK_VDEC_CORE1_VDEC, "vdec_core1_vdec", "vdec_sel", 0),
> +       /* VDEC1 */
> +       GATE_VDEC1(CLK_VDEC_CORE1_LAT, "vdec_core1_lat", "vdec_sel", 0),
> +       /* VDEC2 */
> +       GATE_VDEC2(CLK_VDEC_CORE1_LARB1, "vdec_core1_larb1", "vdec_sel", 0),
> +};
> +
> +static const struct mtk_gate vdec_soc_clks[] = {
> +       /* VDEC0 */
> +       GATE_VDEC0(CLK_VDEC_SOC_VDEC, "vdec_soc_vdec", "vdec_sel", 0),
> +       /* VDEC1 */
> +       GATE_VDEC1(CLK_VDEC_SOC_LAT, "vdec_soc_lat", "vdec_sel", 0),
> +       /* VDEC2 */
> +       GATE_VDEC2(CLK_VDEC_SOC_LARB1, "vdec_soc_larb1", "vdec_sel", 0),
> +};
> +
> +static const struct mtk_clk_desc vdec_desc = {
> +       .clks = vdec_clks,
> +       .num_clks = ARRAY_SIZE(vdec_clks),
> +};
> +
> +static const struct mtk_clk_desc vdec_core1_desc = {
> +       .clks = vdec_core1_clks,
> +       .num_clks = ARRAY_SIZE(vdec_core1_clks),
> +};
> +
> +static const struct mtk_clk_desc vdec_soc_desc = {
> +       .clks = vdec_soc_clks,
> +       .num_clks = ARRAY_SIZE(vdec_soc_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt8195_vdec[] = {
> +       {
> +               .compatible = "mediatek,mt8195-vdecsys",
> +               .data = &vdec_desc,
> +       }, {
> +               .compatible = "mediatek,mt8195-vdecsys_core1",
> +               .data = &vdec_core1_desc,
> +       }, {
> +               .compatible = "mediatek,mt8195-vdecsys_soc",
> +               .data = &vdec_soc_desc,
> +       }, {
> +               /* sentinel */
> +       }
> +};
> +
> +static struct platform_driver clk_mt8195_vdec_drv = {
> +       .probe = mtk_clk_simple_probe,
> +       .driver = {
> +               .name = "clk-mt8195-vdec",
> +               .of_match_table = of_match_clk_mt8195_vdec,
> +       },
> +};
> +

Nit: you could drop the empty line here. Same in the other patches.

ChenYu


> +builtin_platform_driver(clk_mt8195_vdec_drv);
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
