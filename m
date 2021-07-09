Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76543C2232
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhGIK3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhGIK3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:29:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F57C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 03:26:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n14so22307176lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 03:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AiaAvA+vLz3FtrBULzF8WYojeUlJAsTsVtqvKG72rx8=;
        b=n6i8wmahbKpTtiTt0jZRJpTElaUmS8kvMSaaMepN4+Z4nT1EWnUVTcrFySgZVpkyEv
         7WnelJAP3/nh8X1jVzN6ZI74Jo63Z3tjeLfj0gUuC1ngOQEQJvLLHjhKKjCggLbtlmNN
         wUjHJCZTwSVD0YxS2JqHVQkuEUSKGN6hGZUxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AiaAvA+vLz3FtrBULzF8WYojeUlJAsTsVtqvKG72rx8=;
        b=c+yQA6MMdTFjziX6i+feyU4sOiCaUjzxXXafKWMFaL95SV0s9KfF7y3g1XsOFwV5zn
         Trrf8l+/YeAP4Jyxbu8ZrZgoZJWi2g7yMpTPcKAdRH43LJjWCQyT8MeBPsoZze0s0Mpa
         A+Mpjno4UH82EyhF1AkzYL2hp56UTgJBMjQnmZg52+v5/KwRcaw1Z4p+/xk4/U6sCFhx
         Wua4SV7icc9jn+WVeoRFpXrtiTEaw6WUdDbD++6KZhbt9vNqBrOgrciaSLUVgSPNJWVl
         VYQCu4QStdOe+/tLymsu1+BkBAEOWIOk3uxTXtUyvbwHGrMin10dpnNUFXL7GKrjYUtM
         SAug==
X-Gm-Message-State: AOAM530GCUL3OLtrSYqV981lFJQeiPu/ciUX9Bq4fSs/a55GeWGMHc0N
        W70w0dbuJ2vysiDPVHxCQxllIvrJ1VKnj0z/h/FcuQ==
X-Google-Smtp-Source: ABdhPJyTbIWxzkC7SuGEvymnm5fWso+1YwVVNumQfR2/BL/A4l+vH4cT2fmxdtPEjDSgvQYB1IhmFTLBsrM2cgSPZoU=
X-Received: by 2002:a05:6512:39cb:: with SMTP id k11mr3933643lfu.587.1625826374731;
 Fri, 09 Jul 2021 03:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-18-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-18-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 9 Jul 2021 18:26:03 +0800
Message-ID: <CAGXv+5ELfV_zogQQrTWFPHezyaZ8zm5HJ8uVMi98q68vVG+WSg@mail.gmail.com>
Subject: Re: [PATCH 17/22] clk: mediatek: Add MT8195 vencsys clock support
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

On Thu, Jun 17, 2021 at 7:10 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 vencsys clock providers
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig           |  6 +++
>  drivers/clk/mediatek/Makefile          |  1 +
>  drivers/clk/mediatek/clk-mt8195-venc.c | 71 ++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-venc.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 1e89c68f6c6c..3352686d98cf 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -660,6 +660,12 @@ config COMMON_CLK_MT8195_VDOSYS1
>         help
>           This driver supports MediaTek MT8195 vdosys1 clocks.
>
> +config COMMON_CLK_MT8195_VENCSYS
> +       bool "Clock driver for MediaTek MT8195 vencsys"
> +       depends on COMMON_CLK_MT8195
> +       help
> +         This driver supports MediaTek MT8195 vencsys clocks.
> +
>  config COMMON_CLK_MT8516
>         bool "Clock driver for MediaTek MT8516"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 76c0fa837cb0..76a6b404e34b 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -93,5 +93,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_NNASYS) += clk-mt8195-nna.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VDECSYS) += clk-mt8195-vdec.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS0) += clk-mt8195-vdo0.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS1) += clk-mt8195-vdo1.o
> +obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
>  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt8195-venc.c b/drivers/clk/mediatek/clk-mt8195-venc.c
> new file mode 100644
> index 000000000000..410ca69d5759
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8195-venc.c
> @@ -0,0 +1,71 @@
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
> +static const struct mtk_gate_regs venc_cg_regs = {
> +       .set_ofs = 0x4,
> +       .clr_ofs = 0x8,
> +       .sta_ofs = 0x0,
> +};
> +
> +#define GATE_VENC(_id, _name, _parent, _shift)                 \
> +       GATE_MTK(_id, _name, _parent, &venc_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
> +
> +static const struct mtk_gate venc_clks[] = {
> +       GATE_VENC(CLK_VENC_LARB, "venc_larb", "venc_sel", 0),
> +       GATE_VENC(CLK_VENC_VENC, "venc_venc", "venc_sel", 4),
> +       GATE_VENC(CLK_VENC_JPGENC, "venc_jpgenc", "venc_sel", 8),
> +       GATE_VENC(CLK_VENC_JPGDEC, "venc_jpgdec", "venc_sel", 12),
> +       GATE_VENC(CLK_VENC_JPGDEC_C1, "venc_jpgdec_c1", "venc_sel", 16),
> +       GATE_VENC(CLK_VENC_GALS, "venc_gals", "venc_sel", 28),
> +};
> +
> +static const struct mtk_gate venc_core1_clks[] = {
> +       GATE_VENC(CLK_VENC_CORE1_LARB, "venc_core1_larb", "venc_sel", 0),
> +       GATE_VENC(CLK_VENC_CORE1_VENC, "venc_core1_venc", "venc_sel", 4),
> +       GATE_VENC(CLK_VENC_CORE1_JPGENC, "venc_core1_jpgenc", "venc_sel", 8),
> +       GATE_VENC(CLK_VENC_CORE1_JPGDEC, "venc_core1_jpgdec", "venc_sel", 12),
> +       GATE_VENC(CLK_VENC_CORE1_JPGDEC_C1, "venc_core1_jpgdec_c1", "venc_sel", 16),
> +       GATE_VENC(CLK_VENC_CORE1_GALS, "venc_core1_gals", "venc_sel", 28),
> +};

So I'm not sure why there are two sets of clocks for each endpoint.
Since this hardware block is not documented in the datasheet, maybe
you could provide some explanation? What I'm wondering is if the
first set is actually some clock gate for bus access and the second
set is the main module clock that drives the internal logic.

The general comments from the other patches apply as well.


ChenYu

> +
> +static const struct mtk_clk_desc venc_desc = {
> +       .clks = venc_clks,
> +       .num_clks = ARRAY_SIZE(venc_clks),
> +};
> +
> +static const struct mtk_clk_desc venc_core1_desc = {
> +       .clks = venc_core1_clks,
> +       .num_clks = ARRAY_SIZE(venc_core1_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt8195_venc[] = {
> +       {
> +               .compatible = "mediatek,mt8195-vencsys",
> +               .data = &venc_desc,
> +       }, {
> +               .compatible = "mediatek,mt8195-vencsys_core1",
> +               .data = &venc_core1_desc,
> +       }, {
> +               /* sentinel */
> +       }
> +};
> +
> +static struct platform_driver clk_mt8195_venc_drv = {
> +       .probe = mtk_clk_simple_probe,
> +       .driver = {
> +               .name = "clk-mt8195-venc",
> +               .of_match_table = of_match_clk_mt8195_venc,
> +       },
> +};
> +
> +builtin_platform_driver(clk_mt8195_venc_drv);
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
