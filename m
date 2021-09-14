Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD1F40A4DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbhINDsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhINDsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:48:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A553C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:47:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c8so25714663lfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FrBxgBJRIesKND2p4JWvyIyYZLW/EMVyaSJmvlgnc7M=;
        b=hFHoSCP4ZqBnTi0Je/dZuxWAYVe7ahmUT4ouDeZycYplQc6eWdFD6XLD4NVCulZFWn
         PLY1K05Cb/vRU8mBrnLE2p2aORqauAvngf2sAIg1fDDu3BfqXGZNvV5uv8/5tUzw/4YG
         qzqfs3OpWUH8fEA0rF8C67mzCR11vhF0u0qwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrBxgBJRIesKND2p4JWvyIyYZLW/EMVyaSJmvlgnc7M=;
        b=KVDPvK3GZ9trU/gMPjh/Tl3Lt+2i5L5H7IZQDWDbqHcFgo2yUY56RqzStp98HXTHB+
         H9GmQAjNzPhDrROlHBiXH/Qksh1WoReqndRrKP82Vsw7A5bmcpMsUkf39/SLUvlnkCep
         +gYdI4+GUMWMycBIuP7cGXiqC3sSsZ5lptQ+OBy6ldyHJTWP0rfNjWxhqkJYbxBwiNU2
         GO7t3Uwkj0ZWwMtCNFOY9ntYnb/o94ONAfp272zXZMaGxizujYd4I0YuptiSyuT5LiUa
         AqyOOzZJHcUuc1g+3sr3Z3s4yaxaTD48NaqiH+zTmE9FTOD2G2hCqeQPdt0FAAi5gHop
         lGLg==
X-Gm-Message-State: AOAM531ZowlCJtV+nlWykcM7gRKCqFV8r0xscemLF/S6JiLK4SktpbP2
        flE6DpGfO1BF/dfJ3bnrWT0D6Jo0MBpvp3FG9VuPJQ==
X-Google-Smtp-Source: ABdhPJw482RoH9R6kRaipVn2e5KT3JCWphlUZk+qJMjpQ/6Io5WzkeCO15gJ697X6Umup8yBeDalVv6S5cdtlV2Q7OQ=
X-Received: by 2002:ac2:4204:: with SMTP id y4mr11315813lfh.501.1631591251353;
 Mon, 13 Sep 2021 20:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111504.350-1-chun-jie.chen@mediatek.com>
 <20210820111504.350-20-chun-jie.chen@mediatek.com> <CAGXv+5FuLTw9jmXEifkfKKYiN-vur3jBbwZWjL5m8vTkoP6VMA@mail.gmail.com>
 <9845ce7c9c2236210d9f730a00eec7071572a0a4.camel@mediatek.com>
In-Reply-To: <9845ce7c9c2236210d9f730a00eec7071572a0a4.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 14 Sep 2021 11:47:20 +0800
Message-ID: <CAGXv+5Es7PjoBaKQ3u3zU3oxof3j8Lr=Xf2E0-WF51Mn8Y4TSg@mail.gmail.com>
Subject: Re: [v2 19/24] clk: mediatek: Add MT8195 vencsys clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 7:09 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> On Wed, 2021-08-25 at 19:03 +0800, Chen-Yu Tsai wrote:
> > On Fri, Aug 20, 2021 at 7:31 PM Chun-Jie Chen
> > <chun-jie.chen@mediatek.com> wrote:
> > >
> > > Add MT8195 vencsys clock controller which provide clock gate
> > > control for video encoder.
> > >
> > > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > > ---
> > >  drivers/clk/mediatek/Makefile          |  2 +-
> > >  drivers/clk/mediatek/clk-mt8195-venc.c | 69
> > > ++++++++++++++++++++++++++
> > >  2 files changed, 70 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/clk/mediatek/clk-mt8195-venc.c
> > >
> > > diff --git a/drivers/clk/mediatek/Makefile
> > > b/drivers/clk/mediatek/Makefile
> > > index 3c8c8cdbd3ef..82ffcc4f2c52 100644
> > > --- a/drivers/clk/mediatek/Makefile
> > > +++ b/drivers/clk/mediatek/Makefile
> > > @@ -82,6 +82,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-
> > > mt8192-vdec.o
> > >  obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
> > >  obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-
> > > mt8195-topckgen.o clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o clk-
> > > mt8195-cam.o \
> > >                                         clk-mt8195-ccu.o clk-
> > > mt8195-img.o clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-
> > > scp_adsp.o \
> > > -                                       clk-mt8195-vdec.o clk-
> > > mt8195-vdo0.o clk-mt8195-vdo1.o
> > > +                                       clk-mt8195-vdec.o clk-
> > > mt8195-vdo0.o clk-mt8195-vdo1.o clk-mt8195-venc.o
> > >  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
> > >  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> > > diff --git a/drivers/clk/mediatek/clk-mt8195-venc.c
> > > b/drivers/clk/mediatek/clk-mt8195-venc.c
> > > new file mode 100644
> > > index 000000000000..10702a4ad5ff
> > > --- /dev/null
> > > +++ b/drivers/clk/mediatek/clk-mt8195-venc.c
> > > @@ -0,0 +1,69 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > +//
> > > +// Copyright (c) 2021 MediaTek Inc.
> > > +// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > > +
> > > +#include "clk-gate.h"
> > > +#include "clk-mtk.h"
> > > +
> > > +#include <dt-bindings/clock/mt8195-clk.h>
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +static const struct mtk_gate_regs venc_cg_regs = {
> > > +       .set_ofs = 0x4,
> > > +       .clr_ofs = 0x8,
> > > +       .sta_ofs = 0x0,
> > > +};
> > > +
> > > +#define GATE_VENC(_id, _name, _parent, _shift)                 \
> > > +       GATE_MTK(_id, _name, _parent, &venc_cg_regs, _shift,
> > > &mtk_clk_gate_ops_setclr_inv)
> > > +
> > > +static const struct mtk_gate venc_clks[] = {
> > > +       GATE_VENC(CLK_VENC_LARB, "venc_larb", "top_venc", 0),
> > > +       GATE_VENC(CLK_VENC_VENC, "venc_venc", "top_venc", 4),
> > > +       GATE_VENC(CLK_VENC_JPGENC, "venc_jpgenc", "top_venc", 8),
> > > +       GATE_VENC(CLK_VENC_JPGDEC, "venc_jpgdec", "top_venc", 12),
> > > +       GATE_VENC(CLK_VENC_JPGDEC_C1, "venc_jpgdec_c1", "top_venc",
> > > 16),
> > > +       GATE_VENC(CLK_VENC_GALS, "venc_gals", "top_venc", 28),
> > > +};
> > > +
> > > +static const struct mtk_gate venc_core1_clks[] = {
> > > +       GATE_VENC(CLK_VENC_CORE1_LARB, "venc_core1_larb",
> > > "top_venc", 0),
> > > +       GATE_VENC(CLK_VENC_CORE1_VENC, "venc_core1_venc",
> > > "top_venc", 4),
> > > +       GATE_VENC(CLK_VENC_CORE1_JPGENC, "venc_core1_jpgenc",
> > > "top_venc", 8),
> > > +       GATE_VENC(CLK_VENC_CORE1_JPGDEC, "venc_core1_jpgdec",
> > > "top_venc", 12),
> > > +       GATE_VENC(CLK_VENC_CORE1_JPGDEC_C1, "venc_core1_jpgdec_c1",
> > > "top_venc", 16),
> > > +       GATE_VENC(CLK_VENC_CORE1_GALS, "venc_core1_gals",
> > > "top_venc", 28),
> >
> > The two hardware blocks look the same. Are there any actual
> > differences?
>
> These two hardware blocks are same, like venc core0 and core1.
> Based on performance requirement we can choose to run one core or two
> cores.

What I meant was "are these two clock controllers the same"? If so
then we shouldn't be using compatible strings to distinguish them.

ChenYu

> Thanks!
> Best Regards,
> Chun-Jie
>
> > I am somewhat skeptical about using different compatible strings just
> > to provide different clock names. This is normally handled with
> > "clock-output-names" properties in the device tree.
> >
> > ChenYu
> >
> > > +};
> > > +
> > > +static const struct mtk_clk_desc venc_desc = {
> > > +       .clks = venc_clks,
> > > +       .num_clks = ARRAY_SIZE(venc_clks),
> > > +};
> > > +
> > > +static const struct mtk_clk_desc venc_core1_desc = {
> > > +       .clks = venc_core1_clks,
> > > +       .num_clks = ARRAY_SIZE(venc_core1_clks),
> > > +};
> > > +
> > > +static const struct of_device_id of_match_clk_mt8195_venc[] = {
> > > +       {
> > > +               .compatible = "mediatek,mt8195-vencsys",
> > > +               .data = &venc_desc,
> > > +       }, {
> > > +               .compatible = "mediatek,mt8195-vencsys_core1",
> > > +               .data = &venc_core1_desc,
> > > +       }, {
> > > +               /* sentinel */
> > > +       }
> > > +};
> > > +
> > > +static struct platform_driver clk_mt8195_venc_drv = {
> > > +       .probe = mtk_clk_simple_probe,
> > > +       .driver = {
> > > +               .name = "clk-mt8195-venc",
> > > +               .of_match_table = of_match_clk_mt8195_venc,
> > > +       },
> > > +};
> > > +builtin_platform_driver(clk_mt8195_venc_drv);
> > > --
> > > 2.18.0
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > >
> https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-mediatek__;!!CTRNKA9wMg0ARbw!y1_g6m5bndRYKNdAsx1SEqMln7Rc-AmZ63Tn_4fTkT24K04mXhjGMOYcO1ew0k99Y72C$
> > >
>
