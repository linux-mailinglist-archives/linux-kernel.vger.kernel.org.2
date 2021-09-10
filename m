Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259E8406A82
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhIJLLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 07:11:02 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48744 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232415AbhIJLLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 07:11:01 -0400
X-UUID: d97ea888d37f4ea18813064501a3958d-20210910
X-UUID: d97ea888d37f4ea18813064501a3958d-20210910
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 162644141; Fri, 10 Sep 2021 19:09:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 10 Sep 2021 19:09:45 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 10 Sep 2021 19:09:45 +0800
Message-ID: <9845ce7c9c2236210d9f730a00eec7071572a0a4.camel@mediatek.com>
Subject: Re: [v2 19/24] clk: mediatek: Add MT8195 vencsys clock support
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        "Devicetree List" <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 10 Sep 2021 19:09:45 +0800
In-Reply-To: <CAGXv+5FuLTw9jmXEifkfKKYiN-vur3jBbwZWjL5m8vTkoP6VMA@mail.gmail.com>
References: <20210820111504.350-1-chun-jie.chen@mediatek.com>
         <20210820111504.350-20-chun-jie.chen@mediatek.com>
         <CAGXv+5FuLTw9jmXEifkfKKYiN-vur3jBbwZWjL5m8vTkoP6VMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-08-25 at 19:03 +0800, Chen-Yu Tsai wrote:
> On Fri, Aug 20, 2021 at 7:31 PM Chun-Jie Chen
> <chun-jie.chen@mediatek.com> wrote:
> > 
> > Add MT8195 vencsys clock controller which provide clock gate
> > control for video encoder.
> > 
> > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > ---
> >  drivers/clk/mediatek/Makefile          |  2 +-
> >  drivers/clk/mediatek/clk-mt8195-venc.c | 69
> > ++++++++++++++++++++++++++
> >  2 files changed, 70 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/clk/mediatek/clk-mt8195-venc.c
> > 
> > diff --git a/drivers/clk/mediatek/Makefile
> > b/drivers/clk/mediatek/Makefile
> > index 3c8c8cdbd3ef..82ffcc4f2c52 100644
> > --- a/drivers/clk/mediatek/Makefile
> > +++ b/drivers/clk/mediatek/Makefile
> > @@ -82,6 +82,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-
> > mt8192-vdec.o
> >  obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
> >  obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-
> > mt8195-topckgen.o clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o clk-
> > mt8195-cam.o \
> >                                         clk-mt8195-ccu.o clk-
> > mt8195-img.o clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-
> > scp_adsp.o \
> > -                                       clk-mt8195-vdec.o clk-
> > mt8195-vdo0.o clk-mt8195-vdo1.o
> > +                                       clk-mt8195-vdec.o clk-
> > mt8195-vdo0.o clk-mt8195-vdo1.o clk-mt8195-venc.o
> >  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
> >  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> > diff --git a/drivers/clk/mediatek/clk-mt8195-venc.c
> > b/drivers/clk/mediatek/clk-mt8195-venc.c
> > new file mode 100644
> > index 000000000000..10702a4ad5ff
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mt8195-venc.c
> > @@ -0,0 +1,69 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +//
> > +// Copyright (c) 2021 MediaTek Inc.
> > +// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > +
> > +#include "clk-gate.h"
> > +#include "clk-mtk.h"
> > +
> > +#include <dt-bindings/clock/mt8195-clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/platform_device.h>
> > +
> > +static const struct mtk_gate_regs venc_cg_regs = {
> > +       .set_ofs = 0x4,
> > +       .clr_ofs = 0x8,
> > +       .sta_ofs = 0x0,
> > +};
> > +
> > +#define GATE_VENC(_id, _name, _parent, _shift)                 \
> > +       GATE_MTK(_id, _name, _parent, &venc_cg_regs, _shift,
> > &mtk_clk_gate_ops_setclr_inv)
> > +
> > +static const struct mtk_gate venc_clks[] = {
> > +       GATE_VENC(CLK_VENC_LARB, "venc_larb", "top_venc", 0),
> > +       GATE_VENC(CLK_VENC_VENC, "venc_venc", "top_venc", 4),
> > +       GATE_VENC(CLK_VENC_JPGENC, "venc_jpgenc", "top_venc", 8),
> > +       GATE_VENC(CLK_VENC_JPGDEC, "venc_jpgdec", "top_venc", 12),
> > +       GATE_VENC(CLK_VENC_JPGDEC_C1, "venc_jpgdec_c1", "top_venc",
> > 16),
> > +       GATE_VENC(CLK_VENC_GALS, "venc_gals", "top_venc", 28),
> > +};
> > +
> > +static const struct mtk_gate venc_core1_clks[] = {
> > +       GATE_VENC(CLK_VENC_CORE1_LARB, "venc_core1_larb",
> > "top_venc", 0),
> > +       GATE_VENC(CLK_VENC_CORE1_VENC, "venc_core1_venc",
> > "top_venc", 4),
> > +       GATE_VENC(CLK_VENC_CORE1_JPGENC, "venc_core1_jpgenc",
> > "top_venc", 8),
> > +       GATE_VENC(CLK_VENC_CORE1_JPGDEC, "venc_core1_jpgdec",
> > "top_venc", 12),
> > +       GATE_VENC(CLK_VENC_CORE1_JPGDEC_C1, "venc_core1_jpgdec_c1",
> > "top_venc", 16),
> > +       GATE_VENC(CLK_VENC_CORE1_GALS, "venc_core1_gals",
> > "top_venc", 28),
> 
> The two hardware blocks look the same. Are there any actual
> differences?

These two hardware blocks are same, like venc core0 and core1.
Based on performance requirement we can choose to run one core or two
cores.

Thanks!
Best Regards,
Chun-Jie

> I am somewhat skeptical about using different compatible strings just
> to provide different clock names. This is normally handled with
> "clock-output-names" properties in the device tree.
> 
> ChenYu
> 
> > +};
> > +
> > +static const struct mtk_clk_desc venc_desc = {
> > +       .clks = venc_clks,
> > +       .num_clks = ARRAY_SIZE(venc_clks),
> > +};
> > +
> > +static const struct mtk_clk_desc venc_core1_desc = {
> > +       .clks = venc_core1_clks,
> > +       .num_clks = ARRAY_SIZE(venc_core1_clks),
> > +};
> > +
> > +static const struct of_device_id of_match_clk_mt8195_venc[] = {
> > +       {
> > +               .compatible = "mediatek,mt8195-vencsys",
> > +               .data = &venc_desc,
> > +       }, {
> > +               .compatible = "mediatek,mt8195-vencsys_core1",
> > +               .data = &venc_core1_desc,
> > +       }, {
> > +               /* sentinel */
> > +       }
> > +};
> > +
> > +static struct platform_driver clk_mt8195_venc_drv = {
> > +       .probe = mtk_clk_simple_probe,
> > +       .driver = {
> > +               .name = "clk-mt8195-venc",
> > +               .of_match_table = of_match_clk_mt8195_venc,
> > +       },
> > +};
> > +builtin_platform_driver(clk_mt8195_venc_drv);
> > --
> > 2.18.0
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > 
https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-mediatek__;!!CTRNKA9wMg0ARbw!y1_g6m5bndRYKNdAsx1SEqMln7Rc-AmZ63Tn_4fTkT24K04mXhjGMOYcO1ew0k99Y72C$
> >  

