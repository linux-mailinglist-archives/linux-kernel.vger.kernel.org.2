Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229033D1F37
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 09:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhGVHD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 03:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 03:03:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230DBC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 00:44:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m16so7064378lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 00:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/BZs8YtQNf6CcZ2xOd1z/rpvz1CIBbwt7bmK+VhdAc=;
        b=X8FNgxatxA80XAcxqAfdT9J94v7dNHIHr0D7uXUYiyB0eJ+EE6b4pFADXADtft1tHh
         WkCDgAj7CrmOPnE/17pI7ukVtGlBcosOOe06dlurIfjIuEgPx5Bo6YqZDvnX/QKMQcWi
         nRscWA0Z94AMuisfWXptx4Jnj/CoQCsZBRVVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/BZs8YtQNf6CcZ2xOd1z/rpvz1CIBbwt7bmK+VhdAc=;
        b=YoudJS1LMPt3cTbEVf8FOjGVfPxWzYdkmBliLb8OV6kDcptqkMhcONlqMItbGiTIRu
         T7EsbnM9x1r9tx5JOYrg8iDkXCjNfzGdiIY6d31yZWfIcqDmTIrpGJf6LoxNqTcXxMqJ
         uogxTP6mgHLkQQl9YWtIAcGk7kU+84t1A7YVgeSs5J7KSaAgcg8DrQ3QexokCmZ8EAAv
         9nYm82sBX7GqxVrgPJMqACnRcxWKkD5uQqv5mveYhV7UhpxJQ45ECDzE5/YQABYIK0lU
         BdyCNkmepr57i+fmsB2zeZQJQ303hRF1OlQpk+fcg3gFOAHeDUVUAsjwUv/ayL3RWXzR
         v28w==
X-Gm-Message-State: AOAM532cl6hq4+75JMW5Rv0btuWMlAg3OkFNenWqXPAmnNcNSqgVlhOq
        6vuj9HXVNdc+uBPAwVpoo4VUIjrq5Mm8GehcQf0E3A==
X-Google-Smtp-Source: ABdhPJyf7JkYACTkRxZUmSuRHBwZlHyZGVYDehTpTsv4Mh2a9ICcqw5pX0PixZuEBAjdms7V0iDiwcu3qU/7JigrXT0=
X-Received: by 2002:a05:6512:3f13:: with SMTP id y19mr28118495lfa.444.1626939867184;
 Thu, 22 Jul 2021 00:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
 <20210616224743.5109-5-chun-jie.chen@mediatek.com> <CAGXv+5ELvHXE-r-5Y1mugL=y85_oBGXvO4hXG0K9zgaPt_JDZg@mail.gmail.com>
 <1626913060.1546.4.camel@mtksdaap41>
In-Reply-To: <1626913060.1546.4.camel@mtksdaap41>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 22 Jul 2021 15:44:15 +0800
Message-ID: <CAGXv+5ETdg+SfLDtbjmSwvjxdAr3+0eWmyPR9+ev=05XdoU7wQ@mail.gmail.com>
Subject: Re: [PATCH 04/22] clk: mediatek: Add MT8195 basic clocks support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems your reply included HTML, which means that it never reached
the mailing lists. Please always use plaintext only.

On Thu, Jul 22, 2021 at 08:17:40AM +0800, Chun-Jie Chen wrote:
> On Fri, 2021-07-02 at 19:44 +0800, Chen-Yu Tsai wrote:
> > > On Thu, Jun 17, 2021 at 7:05 AM Chun-Jie Chen
> > > <chun-jie.chen@mediatek.com> wrote:
> >
> > > > >
> > >
> > > > > Add MT8195 basic clock providers, include topckgen, apmixedsys,
> > > > > infracfg_ao and pericfg_ao.
> > > > >
> > >
> > > > > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > > > > ---
> > > > >  drivers/clk/mediatek/Kconfig      |    8 +
> > > > >  drivers/clk/mediatek/Makefile     |    1 +
> > > > >  drivers/clk/mediatek/clk-mt8195.c | 1958
> > > > > +++++++++++++++++++++++++++++
> > > > >  3 files changed, 1967 insertions(+)
> > > > >  create mode 100644 drivers/clk/mediatek/clk-mt8195.c
> > > > >
> > >
> > > > > diff --git a/drivers/clk/mediatek/Kconfig
> > > > > b/drivers/clk/mediatek/Kconfig
> > > > > index 576babd86f98..6707aba3d500 100644
> > > > > --- a/drivers/clk/mediatek/Kconfig
> > > > > +++ b/drivers/clk/mediatek/Kconfig
> > > > > @@ -580,6 +580,14 @@ config COMMON_CLK_MT8192_VENCSYS
> > > > >         help
> > > > >           This driver supports MediaTek MT8192 vencsys clocks.
> > > > >
> > >
> > > > > +config COMMON_CLK_MT8195
> > > > > +       bool "Clock driver for MediaTek MT8195"
> > > > > +       depends on ARM64 || COMPILE_TEST
> > > > > +       select COMMON_CLK_MEDIATEK
> > > > > +       default ARM64
> > > > > +       help
> > > > > +         This driver supports MediaTek MT8195 basic clocks.
> > > > > +
> > > > >  config COMMON_CLK_MT8516
> > > > >         bool "Clock driver for MediaTek MT8516"
> > > > >         depends on ARCH_MEDIATEK || COMPILE_TEST
> > > > > diff --git a/drivers/clk/mediatek/Makefile
> > > > > b/drivers/clk/mediatek/Makefile
> > > > > index 15bc045f0b71..f8002d8966e1 100644
> > > > > --- a/drivers/clk/mediatek/Makefile
> > > > > +++ b/drivers/clk/mediatek/Makefile
> > > > > @@ -80,5 +80,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_MSDC) += clk-
> > > > > mt8192-msdc.o
> > > > >  obj-$(CONFIG_COMMON_CLK_MT8192_SCP_ADSP) +=
> > > clk-mt8192-scp_adsp.o
> > > > >  obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
> > > > >  obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
> > > > > +obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195.o
> > > > >  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
> > > > >  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> > > > > diff --git a/drivers/clk/mediatek/clk-mt8195.c
> > > > > b/drivers/clk/mediatek/clk-mt8195.c
> > > > > new file mode 100644
> > > > > index 000000000000..aea9ebe4c051
> > > > > --- /dev/null
> > > > > +++ b/drivers/clk/mediatek/clk-mt8195.c
> > > > > @@ -0,0 +1,1958 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +//
> > > > > +// Copyright (c) 2021 MediaTek Inc.
> > > > > +// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > > > > +
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/mfd/syscon.h>
> > > > > +#include <linux/of.h>
> > > > > +#include <linux/of_address.h>
> > > > > +#include <linux/of_device.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/slab.h>
> > > > > +
> > > > > +#include "clk-mtk.h"
> > > > > +#include "clk-mux.h"
> > > > > +#include "clk-gate.h"
> > > > > +
> > > > > +#include <dt-bindings/clock/mt8195-clk.h>
> > > > > +
> > > > > +static DEFINE_SPINLOCK(mt8195_clk_lock);
> > > > > +
> > > > > +static const struct mtk_fixed_clk top_fixed_clks[] = {
> > > > > +       FIXED_CLK(CLK_TOP_IN_DGI, "in_dgi", NULL, 165000000),
> > > > > +       FIXED_CLK(CLK_TOP_ULPOSC, "ulposc", NULL, 248000000),
> > > > > +       FIXED_CLK(CLK_TOP_ULPOSC2, "ulposc2", NULL, 326000000),
> > > > > +       FIXED_CLK(CLK_TOP_MEM_466M, "mem_466m", NULL,
> > > 533000000),
> > > > > +       FIXED_CLK(CLK_TOP_MPHONE_SLAVE_B, "mphone_slave_b",
> > > NULL,
> > > > > 49152000),
> > > > > +       FIXED_CLK(CLK_TOP_PEXTP_PIPE, "pextp_pipe", NULL,
> > > > > 250000000),
> > > > > +       FIXED_CLK(CLK_TOP_UFS_RX_SYMBOL, "ufs_rx_symbol", NULL,
> > > > > 166000000),
> > > > > +       FIXED_CLK(CLK_TOP_UFS_TX_SYMBOL, "ufs_tx_symbol", NULL,
> > > > > 166000000),
> > > > > +       FIXED_CLK(CLK_TOP_SSUSB_U3PHY_P1_P_P0,
> > > > > "ssusb_u3phy_p1_p_p0", NULL, 131000000),
> > > > > +       FIXED_CLK(CLK_TOP_UFS_RX_SYMBOL1, "ufs_rx_symbol1",
> > > NULL,
> > > > > 166000000),
> > > > > +       FIXED_CLK(CLK_TOP_FPC, "fpc", NULL, 50000000),
> > > > > +       FIXED_CLK(CLK_TOP_HDMIRX_P, "hdmirx_p", NULL,
> > > 594000000),
> >
> > >
> >
> > > I assume these are fixed PLLs? They should have inputs (parents).
> > >
> >
> > > Moreover, at least ULPOSC and ULPOSC2 look like they are in
> > > APMIXEDSYS
> > >
> >
>
> The clock in top_fixed_clks is special clock that generated from the
> specific hardware block, not PLLs in APMIXEDSYS. ULPOSC and ULPOSC2 has
> configuration register in APMIXEDSYS, but their clock source are not
> "clk26m" (other plls in APMIXEDSYS in is generated from "clk26m")

I see. Surely they have some input though. It would be nice to be able
to have them described.

> > > > > +};T
> > > > > +
> > > > > +static const struct mtk_fixed_factor top_early_divs[] = {
> > > > > +       FACTOR(CLK_TOP_CLK26M_D2, "clk26m_d2", "clk26m", 1, 2),
> > > > > +};
> > > > > +
> > > > > +static const struct mtk_fixed_factor top_divs[] = {
> > > > > +       FACTOR(CLK_TOP_CLK26M_D52, "clk26m_d52", "clk26m", 1,
> > > 52),
> > > > > +       FACTOR(CLK_TOP_IN_DGI_D2, "in_dgi_d2", "in_dgi", 1, 2),
> > > > > +       FACTOR(CLK_TOP_IN_DGI_D4, "in_dgi_d4", "in_dgi", 1, 4),
> > > > > +       FACTOR(CLK_TOP_IN_DGI_D6, "in_dgi_d6", "in_dgi", 1, 6),
> > > > > +       FACTOR(CLK_TOP_IN_DGI_D8, "in_dgi_d8", "in_dgi", 1, 8),
> > > > > +       FACTOR(CLK_TOP_MFGPLL_OPP, "mfgpll_opp", "mfgpll", 1,
> > > 1),
> > > > > +       FACTOR(CLK_TOP_MAINPLL, "mainpll_ck", "mainpll", 1, 1),
> >
> > >
> >
> > > Why are this and other 1:1 factor clks needed? They look like
> > > placeholders.
> > > Please remove them.
>
>
>
> These 1:1 factors make more readable between dividers. For example,
> CLK_APMIXED_MAINPLL and CLK_TOP_MAINPLL_D3 is not easy to see the
> relation, but CLK_TOP_MAINPLL and CLK_TOP_MAINPLL_D3 is more clear to
> see the relation.

If the clocks are named appropriately, it should be clear that "mainpll_dX"
is derived from "mainpll". We really don't need an extra "mainpll_ck" in
between.

The only thing gained here is having the parent clock in the same driver.
But that is only a problem because we are directly using global clock names
for parent names. This isn't the preferred way for clock parenting.

For proper parenting, the driver should be using `struct clk_parent_data`
if possible, or using of_clk_get_parent_name() or of_clk_get_hw() manually
to get the parent's global name or a reference to it. This is something
the clk drivers should slowly be converted to doing.

I'm not saying we should do everything now, but we can start by getting
rid of some of the excess baggage.

[...]

> > > > > +static const char * const dsp7_parents[] = {
> > > > > +       "clk26m",
> > > > > +       "univpll_d6_d2",
> > > > > +       "univpll_d4_d2",
> > > > > +       "univpll_d5",
> > > > > +       "univpll_d4",
> > > > > +       "mmpll_d4",
> > > > > +       "mainpll_d3",
> > > > > +       "univpll_d3"
> > > > > +};
> >
> > >
> >
> > > If dsp~dsp7_parents are all the same, please merge them and share
> > one
> > > instance. And since they are located a bit far from the clock
> > > definitions
> > > in this file, please add comments describing which clocks share the
> > > same
> > > set of parents.
> > >
> >
>
> I will merge it if they can share the same parent source data (include
> you mention below), thanks for your comment.

Great!

[...]

Tip: You can trim out portions of the original email from your reply, like
what I did here, so that the emails are shorter. Keeping just the bits that
are relevant to the discussion is better for the reader. In cases here a
lot of it are related cases, you could keep just the one nearest to your
reply.

> > > > > +static const char * const spinor_parents[] = {
> > > > > +       "clk26m",
> >
> > >
> >
> > > Datasheet says first parent is "univpll_d5_d8". Please check with
> > > hardware
> > > engineers. If the datasheet is wrong please add a comment saying so.
> > >
> >
> >
> > > > > +       "clk26m_d2",
> > > > > +       "mainpll_d7_d8",
> > > > > +       "univpll_d6_d8"
> > > > > +};
> > > > > +
>
> The parent source here is correct, but not update to the latest in
> datasheet.

For future reference, could you leave a comment stating that the datasheet
has not been updated then? Please include the version of the datasheet.

> > > > > +static const char * const dvio_dgi_ref_parents[] = {
> > > > > +       "clk26m",
> > > > > +       "in_dgi",
> > > > > +       "in_dgi_d2",
> > > > > +       "in_dgi_d4",
> > > > > +       "in_dgi_d6",
> > > > > +       "in_dgi_d8",
> > > > > +       "mmpll_d4_d4"
> > > > > +};
> > > > > +
> > > > > +static const char * const srck_parents[] = {
> > > > > +       "ulposc_d10",
> > > > > +       "clk26m"
> > > > > +};
> > > > > +
> > > > > +static const char * const rsvd1_parents[] = {
> > > > > +       "clk26m",
> > > > > +       "mainpll_d4_d4",
> > > > > +       "mainpll_d5_d4",
> > > > > +       "mainpll_d6_d4",
> > > > > +       "mainpll_d7_d4",
> > > > > +       "univpll_d6_d4",
> >
> > >
> >
> > > These are completely different from the datasheet. Please check.
> > >
> >
> >
> > > > > +       "ulposc",
> > > > > +       "ulposc2"
> > > > > +};
> > > > > +
>
> The parent source here is correct, but not update to the latest in
> datasheet.

Same for this one.

> > > > > +static const char * const mfg_fast_parents[] = {
> > > > > +       "mfg_sel",
> > > > > +       "mfgpll_opp"
> > > > > +};
> > > > > +
> > > > > +static const struct mtk_mux top_mtk_muxes[] = {
> > > > > +       /* CLK_CFG_0 */
> > > > > +       MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI_SEL, "axi_sel",
> >
> > >
> >
> > > Please drop the "_sel" suffix from the clock names. It would have
> > > made
> > > sense if this were purely a mux, and there was another clock gate.
> > > But
> > > since the driver combines the two components into one
> > representation,
> > > please just drop the suffix that implies just a mux. This goes for
> > > all
> > > clocks in the series and also the macro bindings.
> >
>
>
>
> If we move the "_sel" suffix from clock names, it's hard to represent
> this mux with gate control. Do you think revise it to "XXX_sel_gate" in
> CCF name but keep the binding name because change the binding name need
> all CCF consumer changes.

Please elaborate. Does the "type" of the clock matter? All that is
really needed is that the name is unique, matches the datasheet more or
less, and describes the usage or purpose of the clock.

For example, on Allwinner sunxi platforms, we don't include the type
of the clock in the clock names. Only the base clock name is used.
That is because the clocks are modeled as composite-ish clocks, so
only one clock is needed to describe a full mux+divider+gate.

On other platforms, the clock driver deliberately uses base clock types,
mux, div, and gate, to build up a representation of the full clock unit.
In these cases, we end up with "XXX_mux", "XXX_div", and "XXX_gate".

Since the Mediatek clock driver is more like the first case, I would
prefer to see clock names with just the base name, and none of the
typing.

And regarding binding names, please change them as well. Right now the
only place that needs to be changed are the header files. This is the
time to get them right.

> > > > > +               axi_parents, 0x020, 0x024, 0x028, 0, 3, 7, 0x04,
> > > 0,
> > > > > CLK_IS_CRITICAL),
> > > > > +       MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SPM_SEL, "spm_sel",
> > > > > +               spm_parents, 0x020, 0x024, 0x028, 8, 2, 15,
> > > 0x04,
> > > > > 1, CLK_IS_CRITICAL),
> >
> > >
> >
> > > Where is the SCP clock?
>
>
>
> Because SCP is always on and no other clock gates need to reference it,
> so move it.

Please add a comment as a placeholder then. The comment could simply
state "clock is always on and should not be handled by Linux".

[...]

> > > > > +       /* CLK_CFG_11 */
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_SEL, "usb_sel",
> >
> > >
> >
> > > The datasheet lists these as "usb_top" and "usb_top_Xp". Please keep
> > > the name
> > > the same as the datasheet so it is easy to search for. Also note the
> > > discrepency
> > > between the macro name and the clock name. Same goes for the three
> > > other USB
> > > clocks.
>
>
>
> Do you think revise the name the same as datasheet in CCF name but keep
> binding name?

Please have them match each other. The whole point of keeping names
consistent is to be able to search for them easily.

> > >
> >
> >
> > > > > +               usb_parents, 0x0A4, 0x0A8, 0x0AC, 0, 2, 7, 0x08,
> > > > > 12),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SSUSB_XHCI_SEL,
> > > > > "ssusb_xhci_sel",
> > > > > +               ssusb_xhci_parents, 0x0A4, 0x0A8, 0x0AC, 8, 2,
> > > 15,
> > > > > 0x08, 13),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_1P_SEL, "usb_1p_sel",
> > > > > +               usb_1p_parents, 0x0A4, 0x0A8, 0x0AC, 16, 2, 23,
> > > > > 0x08, 14),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SSUSB_XHCI_1P_SEL,
> > > > > "ssusb_xhci_1p_sel",
> > > > > +               ssusb_xhci_1p_parents, 0x0A4, 0x0A8, 0x0AC, 24,
> > > 2,
> > > > > 31, 0x08, 15),
> > > > > +       /* CLK_CFG_12 */
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_2P_SEL, "usb_2p_sel",
> > > > > +               usb_2p_parents, 0x0B0, 0x0B4, 0x0B8, 0, 2, 7,
> > > 0x08,
> > > > > 16),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SSUSB_XHCI_2P_SEL,
> > > > > "ssusb_xhci_2p_sel",
> > > > > +               ssusb_xhci_2p_parents, 0x0B0, 0x0B4, 0x0B8, 8,
> > > 2,
> > > > > 15, 0x08, 17),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_3P_SEL, "usb_3p_sel",
> > > > > +               usb_3p_parents, 0x0B0, 0x0B4, 0x0B8, 16, 2, 23,
> > > > > 0x08, 18),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SSUSB_XHCI_3P_SEL,
> > > > > "ssusb_xhci_3p_sel",
> > > > > +               ssusb_xhci_3p_parents, 0x0B0, 0x0B4, 0x0B8, 24,
> > > 2,
> > > > > 31, 0x08, 19),
> > > > > +       /* CLK_CFG_13 */
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_I2C_SEL, "i2c_sel",
> > > > > +               i2c_parents, 0x0BC, 0x0C0, 0x0C4, 0, 2, 7, 0x08,
> > > > > 20),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF_SEL, "seninf_sel",
> > > > > +               seninf_parents, 0x0BC, 0x0C0, 0x0C4, 8, 3, 15,
> > > > > 0x08, 21),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF1_SEL,
> > > "seninf1_sel",
> > > > > +               seninf1_parents, 0x0BC, 0x0C0, 0x0C4, 16, 3, 23,
> > > > > 0x08, 22),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF2_SEL,
> > > "seninf2_sel",
> > > > > +               seninf2_parents, 0x0BC, 0x0C0, 0x0C4, 24, 3, 31,
> > > > > 0x08, 23),
> > > > > +       /* CLK_CFG_14 */
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF3_SEL,
> > > "seninf3_sel",
> > > > > +               seninf3_parents, 0x0C8, 0x0CC, 0x0D0, 0, 3, 7,
> > > > > 0x08, 24),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_GCPU_SEL, "gcpu_sel",
> > > > > +               gcpu_parents, 0x0C8, 0x0CC, 0x0D0, 8, 3, 15,
> > > 0x08,
> > > > > 25),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_DXCC_SEL, "dxcc_sel",
> > > > > +               dxcc_parents, 0x0C8, 0x0CC, 0x0D0, 16, 2, 23,
> > > 0x08,
> > > > > 26),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_DPMAIF_SEL, "dpmaif_sel",
> > > > > +               dpmaif_parents, 0x0C8, 0x0CC, 0x0D0, 24, 3, 31,
> > > > > 0x08, 27),
> > > > > +       /* CLK_CFG_15 */
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_AES_UFSFDE_SEL,
> > > > > "aes_ufsfde_sel",
> > > > > +               aes_ufsfde_parents, 0x0D4, 0x0D8, 0x0DC, 0, 3,
> > > 7,
> > > > > 0x08, 28),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_UFS_SEL, "ufs_sel",
> > > > > +               ufs_parents, 0x0D4, 0x0D8, 0x0DC, 8, 3, 15,
> > > 0x08,
> > > > > 29),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_UFS_TICK1US_SEL,
> > > > > "ufs_tick1us_sel",
> > > > > +               ufs_tick1us_parents, 0x0D4, 0x0D8, 0x0DC, 16, 1,
> > > > > 23, 0x08, 30),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_UFS_MP_SAP_SEL,
> > > > > "ufs_mp_sap_sel",
> > > > > +               ufs_mp_sap_parents, 0x0D4, 0x0D8, 0x0DC, 24, 1,
> > > 31,
> > > > > 0x08, 31),
> > > > > +       /* CLK_CFG_16 */
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_VENC_SEL, "venc_sel",
> > > > > +               venc_parents, 0x0E0, 0x0E4, 0x0E8, 0, 4, 7,
> > > 0x0C,
> > > > > 0),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_VDEC_SEL, "vdec_sel",
> > > > > +               vdec_parents, 0x0E0, 0x0E4, 0x0E8, 8, 4, 15,
> > > 0x0C,
> > > > > 1),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_PWM_SEL, "pwm_sel",
> > > > > +               pwm_parents, 0x0E0, 0x0E4, 0x0E8, 16, 1, 23,
> > > 0x0C,
> > > > > 2),
> >
> > >
> >
> > > MCU clock? Not sure what it's supposed to be called since the naming
> > > has a
> > > slightly different format.
> > >
> >
> > > If you are skipping clocks, please leave a comment in the list
> > > explaining
> > > why.
> > >
> >
> > "mcupm" is another micro-processor and is always on, and no others
> > clock gates need to reference it, so remove it.

Please add a comment, just like in the SCP clock case.

> > > > > +       /* CLK_CFG_17 */
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SPMI_P_MST_SEL,
> > > > > "spmi_p_mst_sel",
> > > > > +               spmi_p_mst_parents, 0x0EC, 0x0F0, 0x0F4, 0, 4,
> > > 7,
> > > > > 0x0C, 4),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SPMI_M_MST_SEL,
> > > > > "spmi_m_mst_sel",
> > > > > +               spmi_m_mst_parents, 0x0EC, 0x0F0, 0x0F4, 8, 4,
> > > 15,
> > > > > 0x0C, 5),
> >
> > >
> >
> > > DVFSRC clock?
> > >
> >
> > "DVFSRC" IP block is always on  and no others clock gates need to
> > reference it, so remove it.

This one as well.

[...]

> > > > > +       /* CLK_CFG_24 */
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_APLL5_SEL, "apll5_sel",
> > > > > +               apll5_parents, 0x0140, 0x0144, 0x0148, 0, 1, 7,
> > > > > 0x010, 0),
> >
> > >
> >
> > > For the APLLs, you will need to differentiate them from the actual
> > > PLLs in
> > > the APMIXEDSYS block.
> > >
> >
> > APLLX providers more precise clock so it has more configuration
> > register, but it still has same control flow like other PLLs in
> > APMIXEDSYS.

I think what I meant was, because I asked to remove the "_sel" suffix,
the global clock names here now collide with the ones in APMIXEDSYS.
So what I was asking was the names here need to be changed, maybe to
something like "top_apllX".

> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_I2SO1_M_SEL,
> > > "i2so1_m_sel",
> > > > > +               i2so1_m_parents, 0x0140, 0x0144, 0x0148, 8, 3,
> > > 15,
> > > > > 0x010, 1),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_I2SO2_M_SEL,
> > > "i2so2_m_sel",
> > > > > +               i2so2_m_parents, 0x0140, 0x0144, 0x0148, 16, 3,
> > > 23,
> > > > > 0x010, 2),
> >
> > >
> >
> > > I2SO4_M?
> > >
> >
> >
> > > > > +       /* CLK_CFG_25 */
> >
> > >
> >
> > > I2SO5_M?
> > >
> >
> >
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_I2SI1_M_SEL,
> > > "i2si1_m_sel",
> > > > > +               i2si1_m_parents, 0x014C, 0x0150, 0x0154, 8, 3,
> > > 15,
> > > > > 0x010, 5),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_I2SI2_M_SEL,
> > > "i2si2_m_sel",
> > > > > +               i2si2_m_parents, 0x014C, 0x0150, 0x0154, 16, 3,
> > > 23,
> > > > > 0x010, 6),
> >
> > >
> >
> > > I2SI4_M?
> > >
> >
> >
> > > > > +       /* CLK_CFG_26 */
> >
> > >
> >
> > > I2SI5_M?
> > >
> >
> > I2SO4/I2SO5/I2SI4_M/I2SI5_M is not used in MT8195, so remove it here.

Please add comments as placeholders for them. The comment could state
that the clock is unused in the hardware design, so it was skipped.

> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_DPTX_M_SEL, "dptx_m_sel",
> > > > > +               dptx_m_parents, 0x0158, 0x015C, 0x0160, 8, 3,
> > > 15,
> > > > > 0x010, 9),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_IEC_SEL,
> > > "aud_iec_sel",
> > > > > +               aud_iec_parents, 0x0158, 0x015C, 0x0160, 16, 3,
> > > 23,
> > > > > 0x010, 10),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_A1SYS_HP_SEL,
> > > "a1sys_hp_sel",
> > > > > +               a1sys_hp_parents, 0x0158, 0x015C, 0x0160, 24, 1,
> > > > > 31, 0x010, 11),
> > > > > +       /* CLK_CFG_27 */
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_A2SYS_SEL, "a2sys_sel",
> > > > > +               a2sys_parents, 0x0164, 0x0168, 0x016C, 0, 1, 7,
> > > > > 0x010, 12),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_A3SYS_SEL, "a3sys_sel",
> > > > > +               a3sys_parents, 0x0164, 0x0168, 0x016C, 8, 3, 15,
> > > > > 0x010, 13),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_A4SYS_SEL, "a4sys_sel",
> > > > > +               a4sys_parents, 0x0164, 0x0168, 0x016C, 16, 3,
> > > 23,
> > > > > 0x010, 14),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SPINFI_B_SEL,
> > > "spinfi_b_sel",
> > > > > +               spinfi_b_parents, 0x0164, 0x0168, 0x016C, 24, 3,
> > > > > 31, 0x010, 15),
> > > > > +       /* CLK_CFG_28 */
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_NFI1X_SEL, "nfi1x_sel",
> > > > > +               nfi1x_parents, 0x0170, 0x0174, 0x0178, 0, 3, 7,
> > > > > 0x010, 16),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_ECC_SEL, "ecc_sel",
> > > > > +               ecc_parents, 0x0170, 0x0174, 0x0178, 8, 3, 15,
> > > > > 0x010, 17),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO_LOCAL_BUS_SEL,
> > > > > "audio_local_bus_sel",
> > > > > +               audio_local_bus_parents, 0x0170, 0x0174, 0x0178,
> > > > > 16, 4, 23, 0x010, 18),
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SPINOR_SEL, "spinor_sel",
> > > > > +               spinor_parents, 0x0170, 0x0174, 0x0178, 24, 2,
> > > 31,
> > > > > 0x010, 19),
> > > > > +       /* CLK_CFG_29 */
> > > > > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_DVIO_DGI_REF_SEL,
> > > > > "dvio_dgi_ref_sel",
> > > > > +               dvio_dgi_ref_parents, 0x017C, 0x0180, 0x0184, 0,
> > > 3,
> > > > > 7, 0x010, 20),
> >
> > >
> >
> > > ULPOSC and ULPOSC_CORE?
> > >
> >
>
>
>
> ULPOSC and ULPOSC_CORE is always on and no other clock gate needs to
> reference it, so just remove it.

Please add placeholder comments describing them, specifically why they
are missing from the driver. Are the clocks used at all in the hardware
design? If so then it might be better to add them to the clock driver.

Also, even if they, including SCP and MCU above, are always on, it might
still be nice to have driver support for them, just to be able to read
their state from Linux. We could have CLK_IS_CRITICAL set so they don't
get disabled, and CLK_GET_RATE_NOCACHE if the clocks are expected to be
changed by firmware running alongside of Linux.

> > > > > +       MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SRCK_SEL,
> > > "srck_sel",
> > > > > +               srck_parents, 0x017C, 0x0180, 0x0184, 24, 1, 31,
> > > > > 0x010, 23, CLK_IS_CRITICAL),
> >
> > >
> >
> > > What happened to CLK_CFG_30~36?
> > >
> >
>
> The muxes in CLK_CFG_30 ~ 36 are not used, so just remove it from CCF.

Please add placeholder comments about them.

> > > > > +       /* CLK_CFG_37 */
> > > > > +       MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_RSVD1_SEL,
> > > "rsvd1_sel",
> > > > > +               rsvd1_parents, 0x01DC, 0x01E0, 0x01E4, 0, 3, 7,
> > > > > 0x014, 20, CLK_IS_CRITICAL),
> >
> > >
> >
> > > What about the other three?
> > >
> >
>
>
> "rsvd2" and "rsvd3" is not used, so remove it.

Same here.

To be honest, a "rsvd", which I interpret as "reserved", clock being
used seems kind of contradicting. Do we know what hardware is using
rsvd1?

> > > > > +};
> > > > > +
> > > > > +static struct mtk_composite top_muxes[] = {
> > > > > +       /* CLK_MISC_CFG_3 */
> > > > > +       MUX(CLK_TOP_MFG_FAST_SEL, "mfg_fast_sel",
> > > mfg_fast_parents,
> > > > > 0x0250, 8, 1),
> > > > > +};
> > > > > +
> > > > > +static const struct mtk_composite top_adj_divs[] = {
> > > > > +       DIV_GATE(CLK_TOP_APLL12_DIV0, "apll12_div0",
> > > "i2si1_m_sel",
> > > > > 0x0320, 0, 0x0328, 8, 0),
> > > > > +       DIV_GATE(CLK_TOP_APLL12_DIV1, "apll12_div1",
> > > "i2si2_m_sel",
> > > > > 0x0320, 1, 0x0328, 8, 8),
> > > > > +       DIV_GATE(CLK_TOP_APLL12_DIV2, "apll12_div2",
> > > "i2so1_m_sel",
> > > > > 0x0320, 2, 0x0328, 8, 16),
> > > > > +       DIV_GATE(CLK_TOP_APLL12_DIV3, "apll12_div3",
> > > "i2so2_m_sel",
> > > > > 0x0320, 3, 0x0328, 8, 24),
> > > > > +       DIV_GATE(CLK_TOP_APLL12_DIV4, "apll12_div4",
> > > "aud_iec_sel",
> > > > > 0x0320, 4, 0x0334, 8, 0),
> >
> > >
> >
> > > What about 5~8?
> > >
> >
> > div5 ~ 8 are not used in MT8195, so remove it.

Placeholder comments please.

[...]

> > > > > +static const struct mtk_gate_regs top0_cg_regs = {
> > > > > +       .set_ofs = 0x238,
> > > > > +       .clr_ofs = 0x238,
> > > > > +       .sta_ofs = 0x238,
> > > > > +};
> > > > > +
> > > > > +static const struct mtk_gate_regs top1_cg_regs = {
> > > > > +       .set_ofs = 0x250,
> > > > > +       .clr_ofs = 0x250,
> > > > > +       .sta_ofs = 0x250,
> > > > > +};
> > > > > +
> > > > > +#define GATE_TOP0_FLAGS(_id, _name, _parent, _shift,
> > > > > _flag)            \
> > > > > +       GATE_MTK_FLAGS(_id, _name, _parent, &top0_cg_regs,
> > > > > _shift,      \
> > > > > +               &mtk_clk_gate_ops_no_setclr_inv, _flag)
> > > > > +
> > > > > +#define GATE_TOP0(_id, _name, _parent,
> > > _shift)                 \
> > > > > +       GATE_TOP0_FLAGS(_id, _name, _parent, _shift, 0)
> > > > > +
> > > > > +#define GATE_TOP1(_id, _name, _parent,
> > > _shift)                 \
> > > > > +       GATE_MTK(_id, _name, _parent, &top1_cg_regs, _shift,
> > > > > &mtk_clk_gate_ops_no_setclr_inv)
> > > > > +
> > > > > +static const struct mtk_gate top_clks[] = {
> > > > > +       /* TOP0 */
> > > > > +       GATE_TOP0(CLK_TOP_CFG_VPP0, "cfg_vpp0", "vpp_sel", 0),
> > > > > +       GATE_TOP0(CLK_TOP_CFG_VPP1, "cfg_vpp1", "vpp_sel", 1),
> > > > > +       GATE_TOP0(CLK_TOP_CFG_VDO0, "cfg_vdo0", "vpp_sel", 2),
> > > > > +       GATE_TOP0(CLK_TOP_CFG_VDO1, "cfg_vdo1", "vpp_sel", 3),
> > > > > +       GATE_TOP0(CLK_TOP_CFG_UNIPLL_SES, "cfg_unipll_ses",
> > > > > "univpll_d2", 4),
> > > > > +       GATE_TOP0(CLK_TOP_CFG_26M_VPP0, "cfg_26m_vpp0",
> > > "clk26m",
> > > > > 5),
> > > > > +       GATE_TOP0(CLK_TOP_CFG_26M_VPP1, "cfg_26m_vpp1",
> > > "clk26m",
> > > > > 6),
> > > > > +       GATE_TOP0(CLK_TOP_CFG_26M_AUD, "cfg_26m_aud", "clk26m",
> > > 9),
> > > > > +       GATE_TOP0_FLAGS(CLK_TOP_CFG_AXI_EAST, "cfg_axi_east",
> > > > > "axi_sel", 10, CLK_IS_CRITICAL),
> > > > > +       GATE_TOP0_FLAGS(CLK_TOP_CFG_AXI_EAST_NORTH,
> > > > > "cfg_axi_east_north", "axi_sel", 11,
> > > > > +               CLK_IS_CRITICAL),
> > > > > +       GATE_TOP0_FLAGS(CLK_TOP_CFG_AXI_NORTH, "cfg_axi_north",
> > > > > "axi_sel", 12, CLK_IS_CRITICAL),
> > > > > +       GATE_TOP0_FLAGS(CLK_TOP_CFG_AXI_SOUTH, "cfg_axi_south",
> > > > > "axi_sel", 13, CLK_IS_CRITICAL),
> > > > > +       GATE_TOP0(CLK_TOP_CFG_EXT_TEST, "cfg_ext_test",
> > > > > "msdcpll_d2", 15),
> > > > > +       /* TOP1 */
> > > > > +       GATE_TOP1(CLK_TOP_SSUSB_REF, "ssusb_ref", "clk26m", 0),
> > > > > +       GATE_TOP1(CLK_TOP_SSUSB_PHY_REF, "ssusb_phy_ref",
> > > "clk26m",
> > > > > 1),
> > > > > +       GATE_TOP1(CLK_TOP_SSUSB_P1_REF, "ssusb_p1_ref",
> > > "clk26m",
> > > > > 2),
> > > > > +       GATE_TOP1(CLK_TOP_SSUSB_PHY_P1_REF, "ssusb_phy_p1_ref",
> > > > > "clk26m", 3),
> > > > > +       GATE_TOP1(CLK_TOP_SSUSB_P2_REF, "ssusb_p2_ref",
> > > "clk26m",
> > > > > 4),
> > > > > +       GATE_TOP1(CLK_TOP_SSUSB_PHY_P2_REF, "ssusb_phy_p2_ref",
> > > > > "clk26m", 5),
> > > > > +       GATE_TOP1(CLK_TOP_SSUSB_P3_REF, "ssusb_p3_ref",
> > > "clk26m",
> > > > > 6),
> > > > > +       GATE_TOP1(CLK_TOP_SSUSB_PHY_P3_REF, "ssusb_phy_p3_ref",
> > > > > "clk26m", 7),
> > > > > +};
> >
> > >
> >
> > > These should be grouped with the other TOPCKGEN clocks. Another
> > > reason to
> > > split this driver into multiple ones.
> > >
> >
>
>
>
> These clocks are "clock gate" in TOPCKGEN, so we separate the data of
> "clock gate" from "clock mux".

Right, but it gets really confusing when the driver is mixing clocks
from different clock controllers. Code that gets used together should
be grouped together. In this case, code for the same hardware block
should be grouped together. So please split the drivers up if they end
up being really big, and then group the remaining ones by hardware
block first, then type second.

> > > > > +
> > > > > +static const struct mtk_gate_regs apmixed_cg_regs = {
> > > > > +       .set_ofs = 0x8,
> > > > > +       .clr_ofs = 0x8,
> > > > > +       .sta_ofs = 0x8,
> > > > > +};
> > > > > +
> > > > > +#define GATE_APMIXED(_id, _name, _parent,
> > > > > _shift)                      \
> > > > > +       GATE_MTK(_id, _name, _parent, &apmixed_cg_regs, _shift,
> > > > > &mtk_clk_gate_ops_no_setclr_inv)
> > > > > +
> > > > > +static const struct mtk_gate apmixed_clks[] = {
> > > > > +       GATE_APMIXED(CLK_APMIXED_PLL_SSUSB26M, "pll_ssusb26m",
> > > > > "clk26m", 1),
> > > > > +};
> > > > > +
> > > > > +#define MT8195_PLL_FMAX                (3800UL * MHZ)
> > > > > +#define MT8195_PLL_FMIN                (1500UL * MHZ)
> > > > > +#define MT8195_INTEGER_BITS    8
> > > > > +
> > > > > +#define PLL(_id, _name, _reg, _pwr_reg, _en_mask,
> > > _flags,      \
> > > > > +                       _rst_bar_mask, _pcwbits, _pd_reg,
> > > > > _pd_shift,    \
> > > > > +                       _tuner_reg, _tuner_en_reg,
> > > > > _tuner_en_bit,       \
> > > > > +                       _pcw_reg, _pcw_shift,
> > > > > _pcw_chg_reg,                             \
> > > > > +                       _en_reg, _pll_en_bit)
> > > > > {                                 \
> > > > > +               .id =
> > > > > _id,                                              \
> > > > > +               .name =
> > > > > _name,                                          \
> > > > > +               .reg =
> > > > > _reg,                                            \
> > > > > +               .pwr_reg =
> > > > > _pwr_reg,                                    \
> > > > > +               .en_mask =
> > > > > _en_mask,                                    \
> > > > > +               .flags =
> > > > > _flags,                                        \
> > > > > +               .rst_bar_mask =
> > > > > _rst_bar_mask,                          \
> > > > > +               .fmax =
> > > > > MT8195_PLL_FMAX,                                \
> > > > > +               .fmin =
> > > > > MT8195_PLL_FMIN,                                \
> > > > > +               .pcwbits =
> > > > > _pcwbits,                                    \
> > > > > +               .pcwibits =
> > > > > MT8195_INTEGER_BITS,                        \
> > > > > +               .pd_reg =
> > > > > _pd_reg,                                      \
> > > > > +               .pd_shift =
> > > > > _pd_shift,                                  \
> > > > > +               .tuner_reg =
> > > > > _tuner_reg,                                \
> > > > > +               .tuner_en_reg =
> > > > > _tuner_en_reg,                          \
> > > > > +               .tuner_en_bit =
> > > > > _tuner_en_bit,                          \
> > > > > +               .pcw_reg =
> > > > > _pcw_reg,                                    \
> > > > > +               .pcw_shift =
> > > > > _pcw_shift,                                \
> > > > > +               .pcw_chg_reg =
> > > > > _pcw_chg_reg,                            \
> > > > > +               .en_reg =
> > > > > _en_reg,                                      \
> > > > > +               .pll_en_bit =
> > > > > _pll_en_bit,                              \
> > > > > +       }
> > > > > +
> > > > > +static const struct mtk_pll_data plls[] = {
> > > > > +       PLL(CLK_APMIXED_NNAPLL, "nnapll", 0x0390, 0x03a0, 0,
> > > > > +               0, 0, 22, 0x0398, 24, 0, 0, 0, 0x0398, 0,
> > > 0x0398,
> > > > > 0, 9),
> > > > > +       PLL(CLK_APMIXED_RESPLL, "respll", 0x0190, 0x0320, 0,
> > > > > +               0, 0, 22, 0x0198, 24, 0, 0, 0, 0x0198, 0,
> > > 0x0198,
> > > > > 0, 9),
> > > > > +       PLL(CLK_APMIXED_ETHPLL, "ethpll", 0x0360, 0x0370, 0,
> > > > > +               0, 0, 22, 0x0368, 24, 0, 0, 0, 0x0368, 0,
> > > 0x0368,
> > > > > 0, 9),
> > > > > +       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0710, 0x0720, 0,
> > > > > +               0, 0, 22, 0x0718, 24, 0, 0, 0, 0x0718, 0,
> > > 0x0718,
> > > > > 0, 9),
> > > > > +       PLL(CLK_APMIXED_TVDPLL1, "tvdpll1", 0x00a0, 0x00b0, 0,
> > > > > +               0, 0, 22, 0x00a8, 24, 0, 0, 0, 0x00a8, 0,
> > > 0x00a8,
> > > > > 0, 9),
> > > > > +       PLL(CLK_APMIXED_TVDPLL2, "tvdpll2", 0x00c0, 0x00d0, 0,
> > > > > +               0, 0, 22, 0x00c8, 24, 0, 0, 0, 0x00c8, 0,
> > > 0x00c8,
> > > > > 0, 9),
> > > > > +       PLL(CLK_APMIXED_MMPLL, "mmpll", 0x00e0, 0x00f0,
> > > 0xff000000,
> > > > > +               HAVE_RST_BAR, BIT(23), 22, 0x00e8, 24, 0, 0, 0,
> > > > > 0x00e8, 0, 0x00e8, 0, 9),
> > > > > +       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x01d0, 0x01e0,
> > > > > 0xff000000,
> > > > > +               HAVE_RST_BAR, BIT(23), 22, 0x01d8, 24, 0, 0, 0,
> > > > > 0x01d8, 0, 0x01d8, 0, 9),
> > > > > +       PLL(CLK_APMIXED_VDECPLL, "vdecpll", 0x0890, 0x08a0, 0,
> > > > > +               0, 0, 22, 0x0898, 24, 0, 0, 0, 0x0898, 0,
> > > 0x0898,
> > > > > 0, 9),
> > > > > +       PLL(CLK_APMIXED_IMGPLL, "imgpll", 0x0100, 0x0110, 0,
> > > > > +               0, 0, 22, 0x0108, 24, 0, 0, 0, 0x0108, 0,
> > > 0x0108,
> > > > > 0, 9),
> > > > > +       PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x01f0, 0x0700,
> > > > > 0xff000000,
> > > > > +               HAVE_RST_BAR, BIT(23), 22, 0x01f8, 24, 0, 0, 0,
> > > > > 0x01f8, 0, 0x01f8, 0, 9),
> > > > > +       PLL(CLK_APMIXED_HDMIPLL1, "hdmipll1", 0x08c0, 0x08d0,
> > > 0,
> > > > > +               0, 0, 22, 0x08c8, 24, 0, 0, 0, 0x08c8, 0,
> > > 0x08c8,
> > > > > 0, 9),
> > > > > +       PLL(CLK_APMIXED_HDMIPLL2, "hdmipll2", 0x0870, 0x0880,
> > > 0,
> > > > > +               0, 0, 22, 0x0878, 24, 0, 0, 0, 0x0878, 0,
> > > 0x0878,
> > > > > 0, 9),
> > > > > +       PLL(CLK_APMIXED_HDMIRX_APLL, "hdmirx_apll", 0x08e0,
> > > 0x0dd4,
> > > > > 0,
> > > > > +               0, 0, 32, 0x08e8, 24, 0, 0, 0, 0x08ec, 0,
> > > 0x08e8,
> > > > > 0, 9),
> > > > > +       PLL(CLK_APMIXED_USB1PLL, "usb1pll", 0x01a0, 0x01b0, 0,
> > > > > +               0, 0, 22, 0x01a8, 24, 0, 0, 0, 0x01a8, 0,
> > > 0x01a8,
> > > > > 0, 9),
> > > > > +       PLL(CLK_APMIXED_ADSPPLL, "adsppll", 0x07e0, 0x07f0, 0,
> > > > > +               0, 0, 22, 0x07e8, 24, 0, 0, 0, 0x07e8, 0,
> > > 0x07e8,
> > > > > 0, 9),
> > > > > +       PLL(CLK_APMIXED_APLL1, "apll1", 0x07c0, 0x0dc0, 0,
> > > > > +               0, 0, 32, 0x07c8, 24, 0x0470, 0x0000, 12,
> > > 0x07cc,
> > > > > 0, 0x07c8, 0, 9),
> > > > > +       PLL(CLK_APMIXED_APLL2, "apll2", 0x0780, 0x0dc4, 0,
> > > > > +               0, 0, 32, 0x0788, 24, 0x0474, 0x0000, 13,
> > > 0x078c,
> > > > > 0, 0x0788, 0, 9),
> > > > > +       PLL(CLK_APMIXED_APLL3, "apll3", 0x0760, 0x0dc8, 0,
> > > > > +               0, 0, 32, 0x0768, 24, 0x0478, 0x0000, 14,
> > > 0x076c,
> > > > > 0, 0x0768, 0, 9),
> > > > > +       PLL(CLK_APMIXED_APLL4, "apll4", 0x0740, 0x0dcc, 0,
> > > > > +               0, 0, 32, 0x0748, 24, 0x047C, 0x0000, 15,
> > > 0x074c,
> > > > > 0, 0x0748, 0, 9),
> > > > > +       PLL(CLK_APMIXED_APLL5, "apll5", 0x07a0, 0x0dd0,
> > > 0x100000,
> > > > > +               0, 0, 32, 0x07a8, 24, 0x0480, 0x0000, 16,
> > > 0x07ac,
> > > > > 0, 0x07a8, 0, 9),
> > > > > +       PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x0340, 0x0350, 0,
> > > > > +               0, 0, 22, 0x0348, 24, 0, 0, 0, 0x0348, 0,
> > > 0x0348,
> > > > > 0, 9),
> > > > > +       PLL(CLK_APMIXED_DGIPLL, "dgipll", 0x0150, 0x0160, 0,
> > > > > +               0, 0, 22, 0x0158, 24, 0, 0, 0, 0x0158, 0,
> > > 0x0158,
> > > > > 0, 9),
> > > > > +};
> > > > > +
> > > > > +static struct clk_onecell_data *top_clk_data;
> > > > > +
> > > > > +static void clk_mt8195_top_init_early(struct device_node
> > > *node)
> > > > > +{
> > > > > +       int i;
> > > > > +
> > > > > +       top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> > > > > +       if (!top_clk_data)
> > > > > +               return;
> > > > > +
> > > > > +       for (i = 0; i < CLK_TOP_NR_CLK; i++)
> > > > > +               top_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
> > > > > +
> > > > > +       mtk_clk_register_factors(top_early_divs,
> > > > > ARRAY_SIZE(top_early_divs), top_clk_data);
> > > > > +
> > > > > +       of_clk_add_provider(node, of_clk_src_onecell_get,
> > > > > top_clk_data);
> > > > > +}
> > > > > +
> > > > > +CLK_OF_DECLARE_DRIVER(mt8195_topckgen,
> > > "mediatek,mt8195-topckgen",
> > > > > +                       clk_mt8195_top_init_early);
> > > > > +
> > > > > +static int clk_mt8195_top_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +       struct device_node *node = pdev->dev.of_node;
> > > > > +       int r;
> > > > > +       void __iomem *base;
> > > > > +
> > > > > +       base = devm_platform_ioremap_resource(pdev, 0);
> > > > > +       if (IS_ERR(base))
> > > > > +               return PTR_ERR(base);
> > > > > +
> > > > > +       mtk_clk_register_fixed_clks(top_fixed_clks,
> > > > > ARRAY_SIZE(top_fixed_clks),
> > > > > +                       top_clk_data);
> > > > > +       mtk_clk_register_factors(top_early_divs,
> > > > > ARRAY_SIZE(top_early_divs), top_clk_data);
> > > > > +       mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs),
> > > > > top_clk_data);
> > > > > +       mtk_clk_register_muxes(top_mtk_muxes,
> > > > > ARRAY_SIZE(top_mtk_muxes), node,
> > > > > +                       &mt8195_clk_lock, top_clk_data);
> > > > > +       mtk_clk_register_composites(top_muxes,
> > > > > ARRAY_SIZE(top_muxes), base,
> > > > > +                       &mt8195_clk_lock, top_clk_data);
> > > > > +       mtk_clk_register_composites(top_adj_divs,
> > > > > ARRAY_SIZE(top_adj_divs), base,
> > > > > +                       &mt8195_clk_lock, top_clk_data);
> >
> > >
> >
> > > Future work: these functions probably should be made to return
> > > errors.
> > >
> >
> >
> > > > > +       r = mtk_clk_register_gates(node, top_clks,
> > > > > ARRAY_SIZE(top_clks), top_clk_data);
> > > > > +       if (r)
> > > > > +               return r;
> > > > > +
> > > > > +       return of_clk_add_provider(node, of_clk_src_onecell_get,
> > > > > top_clk_data);
> > > > > +}
> > > > > +
> > > > > +static int clk_mt8195_infra_ao_probe(struct platform_device
> > > *pdev)
> > > > > +{
> > > > > +       struct clk_onecell_data *clk_data;
> > > > > +       struct device_node *node = pdev->dev.of_node;
> > > > > +       int r;
> > > > > +
> > > > > +       clk_data = mtk_alloc_clk_data(CLK_INFRA_AO_NR_CLK);
> > > > > +       if (!clk_data)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       r = mtk_clk_register_gates(node, infra_ao_clks,
> > > > > ARRAY_SIZE(infra_ao_clks), clk_data);
> > > > > +       if (r)
> > > > > +               return r;
> > > > > +
> > > > > +       return of_clk_add_provider(node, of_clk_src_onecell_get,
> > > > > clk_data);
> >
> > >
> >
> > > You are leaking clk_data if mtk_clk_register_gates() or
> > > of_clk_add_provider()
> > > fail.
> > >
> >
>
>
>
> Ok, I will fix it include you mention below, thanks for you comment.
>
>
> > > > > +}
> > > > > +
> > > > > +static int clk_mt8195_apmixed_probe(struct platform_device
> > > *pdev)
> > > > > +{
> > > > > +       struct clk_onecell_data *clk_data;
> > > > > +       struct device_node *node = pdev->dev.of_node;
> > > > > +       int r;
> > > > > +
> > > > > +       clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> > > > > +       if (!clk_data)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls),
> > > > > clk_data);
> > > > > +       r = mtk_clk_register_gates(node, apmixed_clks,
> > > > > ARRAY_SIZE(apmixed_clks), clk_data);
> > > > > +       if (r)
> > > > > +               return r;
> > > > > +
> > > > > +       return of_clk_add_provider(node, of_clk_src_onecell_get,
> > > > > clk_data);
> >
> > >
> >
> > > Same here.
> > >
> >
> >
> > > > > +}
> > > > > +
> > > > > +static int clk_mt8195_peri_ao_probe(struct platform_device
> > > *pdev)
> > > > > +{
> > > > > +       struct clk_onecell_data *clk_data;
> > > > > +       struct device_node *node = pdev->dev.of_node;
> > > > > +       int r;
> > > > > +
> > > > > +       clk_data = mtk_alloc_clk_data(CLK_PERI_AO_NR_CLK);
> > > > > +       if (!clk_data)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       r = mtk_clk_register_gates(node, peri_ao_clks,
> > > > > ARRAY_SIZE(peri_ao_clks), clk_data);
> > > > > +       if (r)
> > > > > +               return r;
> > > > > +
> > > > > +       return of_clk_add_provider(node, of_clk_src_onecell_get,
> > > > > clk_data);
> >
> > >
> >
> > > And here.
> > >
> >
> >
> > > > > +}
> > > > > +
> > > > > +static const struct of_device_id of_match_clk_mt8195[] = {
> > > > > +       {
> > > > > +               .compatible = "mediatek,mt8195-apmixedsys",
> > > > > +               .data = clk_mt8195_apmixed_probe,
> > > > > +       }, {
> > > > > +               .compatible = "mediatek,mt8195-topckgen",
> > > > > +               .data = clk_mt8195_top_probe,
> > > > > +       }, {
> > > > > +               .compatible = "mediatek,mt8195-infracfg_ao",
> > > > > +               .data = clk_mt8195_infra_ao_probe,
> > > > > +       }, {
> > > > > +               .compatible = "mediatek,mt8195-pericfg_ao",
> > > > > +               .data = clk_mt8195_peri_ao_probe,
> >
> > >
> >
> > > This file contains four drivers. They do not have depend on each
> > > other,
> > > and do not need to be in the same file. Please split them into
> > > different
> > > files and preferably different patches so people reading them don't
> > > have
> > > to look through unrelated data. Then you don't need the pointer to
> > > the
> > > probe function.
> > >
> >
>
>
>
> Ok, I will split to different driver.
>
>
> > > You can keep them under the same Kconfig symbol.
> > >
> >
> >
> > > > > +       }, {
> > > > > +               /* sentinel */
> > > > > +       }
> > > > > +};
> > > > > +
> > > > > +static int clk_mt8195_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +       int (*clk_probe)(struct platform_device *pdev);
> > > > > +       int r;
> > > > > +
> > > > > +       clk_probe = of_device_get_match_data(&pdev->dev);
> > > > > +       if (!clk_probe)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       r = clk_probe(pdev);
> > > > > +       if (r)
> > > > > +               dev_err(&pdev->dev,
> > > > > +                       "could not register clock provider: %s:
> > > > > %d\n",
> > > > > +                       pdev->name, r);
> > > > > +
> > > > > +       return r;
> > > > > +}
> > > > > +
> > > > > +static struct platform_driver clk_mt8195_drv = {
> > > > > +       .probe = clk_mt8195_probe,
> > > > > +       .driver = {
> > > > > +               .name = "clk-mt8195",
> > > > > +               .of_match_table = of_match_clk_mt8195,
> > > > > +       },
> > > > > +};
> > > > > +
> > > > > +static int __init clk_mt8195_init(void)
> > > > > +{
> > > > > +       return platform_driver_register(&clk_mt8195_drv);
> > > > > +}
> > > > > +
> > > > > +arch_initcall(clk_mt8195_init);
> >
> > >
> >
> > > Is there any particular reason for arch_initcall?
> > >
> >
>
>
> APMIXEDSYS/TOPCKGEN are clock source of others IP block and
> PERICFG/INFRACFG provide peripheral and bus clocks control, so we want
> to init early.

Sure, but this should really be done through standard dependency
handling, and not trying to sequence them by hand.

Is there an observable benefit to having arch_initcall() vs the standard
order with builtin_platform_driver()? If so, this should be documented
here as a justifcation for arch_initcall().


Regards
ChenYu
