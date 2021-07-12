Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948733C539E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348219AbhGLHzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244993AbhGLHTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:19:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95897C06119C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:06:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n14so41316640lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzw8eGiTQ9ZfwmOD421rbwDrq+4AlCm04iq4FA/PsEQ=;
        b=E5ri+lATuGN+Ju+8PAyASi0H3mDgEwkR0o8yAFH/tVPrpJK0UdHeQ9HJUfDY1NucRu
         3Y6JVk1ofHqs0OQQcHI+TnykiZtK8GWjfScDBtxsttOiVszxca+yhZtMWSuHbkmhjpjn
         E4fPsqp0kD9+k51bEStKC3zwx/Z+aqFS9lMGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzw8eGiTQ9ZfwmOD421rbwDrq+4AlCm04iq4FA/PsEQ=;
        b=K160ISnASdsqllHlelcQgmlM51nrUfzHn5uzoaOMASRk7kYWg/7ebODBsc5wgZYyIE
         wYKMoBC3Ef9a9dksKud1JpmKWtbOByWcGAYUgX1R/h+v0elw8GAisEzyoOmA3aMszAH5
         mGRPgp6EHn6GsTOB6j2gCIFDGo9rpJrIvAMe1Ex6D5FJlEJ9HktLLTj2n5CpORkkrgWe
         2wPLi9wQFdOzmBoOttCr03JMm8+AMo/DccqTi/A/RMHLcH05+ywAKyuSDiDU37x7OR4q
         pD+FPboTkDpFVCDqdAc7oTLPLCmNHG8Wt2pZpZztYMOiPTA44VHaPy8cHmJ9isCCIwFq
         jV7g==
X-Gm-Message-State: AOAM533mECdD7f4rjgHz0BbA7odIaD/OvPqc1/BSQ1FG9TY1tPMb2uUG
        Auq/0pKpFslB9pVTC6ni95avjOodPZIcY4AL3Ln6zQ==
X-Google-Smtp-Source: ABdhPJyTVkhd5XY7VSQs4Oa7s61drO0U70G12qZAzkOnxAtXTuQjWQd5ptfPauzmKdtLIHSBf6AYXx3M9KXAIYVI8Uc=
X-Received: by 2002:ac2:4308:: with SMTP id l8mr41707500lfh.342.1626073599796;
 Mon, 12 Jul 2021 00:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
 <20210616224743.5109-6-chun-jie.chen@mediatek.com> <YOLKxrJin5kkwiIl@google.com>
 <3b52d1781db5b67a04cdbd18852e0857f8b73a38.camel@mediatek.com>
 <CAGXv+5FRc_hj03aqW-3XqqP5FpLX7zGwZ79-473a_HNOgrJQNA@mail.gmail.com> <c05485ad5db717afc8abb5070b33611c4d6a156f.camel@mediatek.com>
In-Reply-To: <c05485ad5db717afc8abb5070b33611c4d6a156f.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 12 Jul 2021 15:06:28 +0800
Message-ID: <CAGXv+5FCpXfq7nN0AhW4wg47XMzRdOd6DWnEpvwiBUqU8s1VDQ@mail.gmail.com>
Subject: Re: [PATCH 05/22] clk: mediatek: Add MT8195 audio clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Trevor Wu <trevor.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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

On Mon, Jul 12, 2021 at 12:35 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> On Mon, 2021-07-12 at 10:09 +0800, Chen-Yu Tsai wrote:
> > Hi,
> >
> > On Mon, Jul 12, 2021 at 9:26 AM Chun-Jie Chen
> > <chun-jie.chen@mediatek.com> wrote:
> > >
> > > On Mon, 2021-07-05 at 17:03 +0800, Chen-Yu Tsai wrote:
> > > > Hi,
> > > >
> > > > On Thu, Jun 17, 2021 at 06:47:26AM +0800, Chun-Jie Chen wrote:
> > > > > Add MT8195 audio clock provider
> > > > >
> > > > > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > > > > ---
> > > > >  drivers/clk/mediatek/Kconfig          |   6 +
> > > > >  drivers/clk/mediatek/Makefile         |   1 +
> > > > >  drivers/clk/mediatek/clk-mt8195-aud.c | 198
> > > > > ++++++++++++++++++++++++++
> > > > >  3 files changed, 205 insertions(+)
> > > > >  create mode 100644 drivers/clk/mediatek/clk-mt8195-aud.c
> > > > >
> > > > > diff --git a/drivers/clk/mediatek/Kconfig
> > > > > b/drivers/clk/mediatek/Kconfig
> > > > > index 6707aba3d500..e2bae9d490a4 100644
> > > > > --- a/drivers/clk/mediatek/Kconfig
> > > > > +++ b/drivers/clk/mediatek/Kconfig
> > > > > @@ -588,6 +588,12 @@ config COMMON_CLK_MT8195
> > > > >     help
> > > > >       This driver supports MediaTek MT8195 basic clocks.
> > > > >
> > > > > +config COMMON_CLK_MT8195_AUDSYS
> > > > > +   bool "Clock driver for MediaTek MT8195 audsys"
> > > > > +   depends on COMMON_CLK_MT8195
> > > > > +   help
> > > > > +     This driver supports MediaTek MT8195 audsys clocks.
> > > > > +
> > > >
> > > > The clock modules aren't shared between different chips, so
> > > > either we
> > > > enable support for all clock hardware in one chip or we don't. It
> > > > doesn't make sense to support just some of them. So having just
> > > > one
> > > > Kconfig option and having all drivers under it is better.
> > > >
> > > > >  config COMMON_CLK_MT8516
> > > > >     bool "Clock driver for MediaTek MT8516"
> > > > >     depends on ARCH_MEDIATEK || COMPILE_TEST
> > > > > diff --git a/drivers/clk/mediatek/Makefile
> > > > > b/drivers/clk/mediatek/Makefile
> > > > > index f8002d8966e1..f27c04314186 100644
> > > > > --- a/drivers/clk/mediatek/Makefile
> > > > > +++ b/drivers/clk/mediatek/Makefile
> > > > > @@ -81,5 +81,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_SCP_ADSP) +=
> > > > > clk-
> > > > > mt8192-scp_adsp.o
> > > > >  obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
> > > > >  obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
> > > > >  obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195.o
> > > > > +obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS) += clk-mt8195-aud.o
> > > > >  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
> > > > >  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> > > > > diff --git a/drivers/clk/mediatek/clk-mt8195-aud.c
> > > > > b/drivers/clk/mediatek/clk-mt8195-aud.c
> > > > > new file mode 100644
> > > > > index 000000000000..db5f80d41de0
> > > > > --- /dev/null
> > > > > +++ b/drivers/clk/mediatek/clk-mt8195-aud.c
> > > > > @@ -0,0 +1,198 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +//
> > > > > +// Copyright (c) 2021 MediaTek Inc.
> > > > > +// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > > > > +
> > > > > +#include <linux/clk-provider.h>
> > > > > +#include <linux/of_platform.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +
> > > > > +#include "clk-mtk.h"
> > > > > +#include "clk-gate.h"
> > > > > +
> > > > > +#include <dt-bindings/clock/mt8195-clk.h>
> > > > > +
> > > > > +static const struct mtk_gate_regs aud0_cg_regs = {
> > > > > +   .set_ofs = 0x0,
> > > > > +   .clr_ofs = 0x0,
> > > > > +   .sta_ofs = 0x0,
> > > > > +};
> > > > > +
> > > > > +static const struct mtk_gate_regs aud1_cg_regs = {
> > > > > +   .set_ofs = 0x10,
> > > > > +   .clr_ofs = 0x10,
> > > > > +   .sta_ofs = 0x10,
> > > > > +};
> > > > > +
> > > > > +static const struct mtk_gate_regs aud2_cg_regs = {
> > > > > +   .set_ofs = 0x14,
> > > > > +   .clr_ofs = 0x14,
> > > > > +   .sta_ofs = 0x14,
> > > > > +};
> > > > > +
> > > > > +static const struct mtk_gate_regs aud3_cg_regs = {
> > > > > +   .set_ofs = 0x18,
> > > > > +   .clr_ofs = 0x18,
> > > > > +   .sta_ofs = 0x18,
> > > > > +};
> > > > > +
> > > > > +static const struct mtk_gate_regs aud4_cg_regs = {
> > > > > +   .set_ofs = 0x4,
> > > > > +   .clr_ofs = 0x4,
> > > > > +   .sta_ofs = 0x4,
> > > > > +};
> > > > > +
> > > > > +static const struct mtk_gate_regs aud5_cg_regs = {
> > > > > +   .set_ofs = 0xc,
> > > > > +   .clr_ofs = 0xc,
> > > > > +   .sta_ofs = 0xc,
> > > > > +};
> > > > > +
> > > > > +#define GATE_AUD0(_id, _name, _parent, _shift)
> > > > > \
> > > > > +   GATE_MTK(_id, _name, _parent, &aud0_cg_regs, _shift,
> > > > > &mtk_clk_gate_ops_no_setclr)
> > > > > +
> > > > > +#define GATE_AUD1(_id, _name, _parent, _shift)
> > > > > \
> > > > > +   GATE_MTK(_id, _name, _parent, &aud1_cg_regs, _shift,
> > > > > &mtk_clk_gate_ops_no_setclr)
> > > > > +
> > > > > +#define GATE_AUD2(_id, _name, _parent, _shift)
> > > > > \
> > > > > +   GATE_MTK(_id, _name, _parent, &aud2_cg_regs, _shift,
> > > > > &mtk_clk_gate_ops_no_setclr)
> > > > > +
> > > > > +#define GATE_AUD3(_id, _name, _parent, _shift)
> > > > > \
> > > > > +   GATE_MTK(_id, _name, _parent, &aud3_cg_regs, _shift,
> > > > > &mtk_clk_gate_ops_no_setclr)
> > > > > +
> > > > > +#define GATE_AUD4(_id, _name, _parent, _shift)
> > > > > \
> > > > > +   GATE_MTK(_id, _name, _parent, &aud4_cg_regs, _shift,
> > > > > &mtk_clk_gate_ops_no_setclr)
> > > > > +
> > > > > +#define GATE_AUD5(_id, _name, _parent, _shift)
> > > > > \
> > > > > +   GATE_MTK(_id, _name, _parent, &aud5_cg_regs, _shift,
> > > > > &mtk_clk_gate_ops_no_setclr)
> > > > > +
> > > > > +static const struct mtk_gate aud_clks[] = {
> > > > > +   /* AUD0 */
> > > > > +   GATE_AUD0(CLK_AUD_AFE, "aud_afe", "a1sys_hp_sel", 2),
> > > > > +   GATE_AUD0(CLK_AUD_LRCK_CNT, "aud_lrck_cnt", "a1sys_hp_sel",
> > > > > 4),
> > > > > +   GATE_AUD0(CLK_AUD_SPDIFIN_TUNER_APLL,
> > > > > "aud_spdifin_tuner_apll",
> > > > > "apll4_sel", 10),
> > > > > +   GATE_AUD0(CLK_AUD_SPDIFIN_TUNER_DBG,
> > > > > "aud_spdifin_tuner_dbg",
> > > > > "apll4_sel", 11),
> > > > > +   GATE_AUD0(CLK_AUD_UL_TML, "aud_ul_tml", "a1sys_hp_sel",
> > > > > 18),
> > > > > +   GATE_AUD0(CLK_AUD_APLL1_TUNER, "aud_apll1_tuner",
> > > > > "apll1_sel",
> > > > > 19),
> > > > > +   GATE_AUD0(CLK_AUD_APLL2_TUNER, "aud_apll2_tuner",
> > > > > "apll2_sel",
> > > > > 20),
> > > > > +   GATE_AUD0(CLK_AUD_TOP0_SPDF, "aud_top0_spdf",
> > > > > "aud_iec_sel",
> > > > > 21),
> > > > > +   GATE_AUD0(CLK_AUD_APLL, "aud_apll", "apll1_sel", 23),
> > > > > +   GATE_AUD0(CLK_AUD_APLL2, "aud_apll2", "apll2_sel", 24),
> > > > > +   GATE_AUD0(CLK_AUD_DAC, "aud_dac", "a1sys_hp_sel", 25),
> > > > > +   GATE_AUD0(CLK_AUD_DAC_PREDIS, "aud_dac_predis",
> > > > > "a1sys_hp_sel",
> > > > > 26),
> > > > > +   GATE_AUD0(CLK_AUD_TML, "aud_tml", "a1sys_hp_sel", 27),
> > > > > +   GATE_AUD0(CLK_AUD_ADC, "aud_adc", "a1sys_hp_sel", 28),
> > > > > +   GATE_AUD0(CLK_AUD_DAC_HIRES, "aud_dac_hires",
> > > > > "audio_h_sel",
> > > > > 31),
> > > > > +   /* AUD1 */
> > > > > +   GATE_AUD1(CLK_AUD_I2SIN, "aud_i2sin", "a1sys_hp_sel", 0),
> > > > > +   GATE_AUD1(CLK_AUD_TDM_IN, "aud_tdm_in", "a1sys_hp_sel", 1),
> > > > > +   GATE_AUD1(CLK_AUD_I2S_OUT, "aud_i2s_out", "a1sys_hp_sel",
> > > > > 6),
> > > > > +   GATE_AUD1(CLK_AUD_TDM_OUT, "aud_tdm_out", "a1sys_hp_sel",
> > > > > 7),
> > > > > +   GATE_AUD1(CLK_AUD_HDMI_OUT, "aud_hdmi_out", "a1sys_hp_sel",
> > > > > 8),
> > > > > +   GATE_AUD1(CLK_AUD_ASRC11, "aud_asrc11", "a1sys_hp_sel",
> > > > > 16),
> > > > > +   GATE_AUD1(CLK_AUD_ASRC12, "aud_asrc12", "a1sys_hp_sel",
> > > > > 17),
> > > > > +   GATE_AUD1(CLK_AUD_MULTI_IN, "aud_multi_in",
> > > > > "mphone_slave_b",
> > > > > 19),
> > > > > +   GATE_AUD1(CLK_AUD_INTDIR, "aud_intdir", "intdir_sel", 20),
> > > > > +   GATE_AUD1(CLK_AUD_A1SYS, "aud_a1sys", "a1sys_hp_sel", 21),
> > > > > +   GATE_AUD1(CLK_AUD_A2SYS, "aud_a2sys", "a2sys_sel", 22),
> > > > > +   GATE_AUD1(CLK_AUD_PCMIF, "aud_pcmif", "a1sys_hp_sel", 24),
> > > > > +   GATE_AUD1(CLK_AUD_A3SYS, "aud_a3sys", "a3sys_sel", 30),
> > > > > +   GATE_AUD1(CLK_AUD_A4SYS, "aud_a4sys", "a4sys_sel", 31),
> > > > > +   /* AUD2 */
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_UL1, "aud_memif_ul1",
> > > > > "a1sys_hp_sel",
> > > > > 0),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_UL2, "aud_memif_ul2",
> > > > > "a1sys_hp_sel",
> > > > > 1),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_UL3, "aud_memif_ul3",
> > > > > "a1sys_hp_sel",
> > > > > 2),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_UL4, "aud_memif_ul4",
> > > > > "a1sys_hp_sel",
> > > > > 3),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_UL5, "aud_memif_ul5",
> > > > > "a1sys_hp_sel",
> > > > > 4),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_UL6, "aud_memif_ul6",
> > > > > "a1sys_hp_sel",
> > > > > 5),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_UL8, "aud_memif_ul8",
> > > > > "a1sys_hp_sel",
> > > > > 7),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_UL9, "aud_memif_ul9",
> > > > > "a1sys_hp_sel",
> > > > > 8),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_UL10, "aud_memif_ul10",
> > > > > "a1sys_hp_sel",
> > > > > 9),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_DL2, "aud_memif_dl2",
> > > > > "a1sys_hp_sel",
> > > > > 18),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_DL3, "aud_memif_dl3",
> > > > > "a1sys_hp_sel",
> > > > > 19),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_DL6, "aud_memif_dl6",
> > > > > "a1sys_hp_sel",
> > > > > 22),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_DL7, "aud_memif_dl7",
> > > > > "a1sys_hp_sel",
> > > > > 23),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_DL8, "aud_memif_dl8",
> > > > > "a1sys_hp_sel",
> > > > > 24),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_DL10, "aud_memif_dl10",
> > > > > "a1sys_hp_sel",
> > > > > 26),
> > > > > +   GATE_AUD2(CLK_AUD_MEMIF_DL11, "aud_memif_dl11",
> > > > > "a1sys_hp_sel",
> > > > > 27),
> > > > > +   /* AUD3 */
> > > > > +   GATE_AUD3(CLK_AUD_GASRC0, "aud_gasrc0", "asm_h_sel", 0),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC1, "aud_gasrc1", "asm_h_sel", 1),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC2, "aud_gasrc2", "asm_h_sel", 2),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC3, "aud_gasrc3", "asm_h_sel", 3),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC4, "aud_gasrc4", "asm_h_sel", 4),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC5, "aud_gasrc5", "asm_h_sel", 5),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC6, "aud_gasrc6", "asm_h_sel", 6),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC7, "aud_gasrc7", "asm_h_sel", 7),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC8, "aud_gasrc8", "asm_h_sel", 8),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC9, "aud_gasrc9", "asm_h_sel", 9),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC10, "aud_gasrc10", "asm_h_sel", 10),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC11, "aud_gasrc11", "asm_h_sel", 11),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC12, "aud_gasrc12", "asm_h_sel", 12),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC13, "aud_gasrc13", "asm_h_sel", 13),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC14, "aud_gasrc14", "asm_h_sel", 14),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC15, "aud_gasrc15", "asm_h_sel", 15),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC16, "aud_gasrc16", "asm_h_sel", 16),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC17, "aud_gasrc17", "asm_h_sel", 17),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC18, "aud_gasrc18", "asm_h_sel", 18),
> > > > > +   GATE_AUD3(CLK_AUD_GASRC19, "aud_gasrc19", "asm_h_sel", 19),
> > > > > +   /* AUD4 */
> > > > > +   GATE_AUD4(CLK_AUD_A1SYS_HP, "aud_a1sys_hp", "a1sys_hp_sel",
> > > > > 2),
> > > > > +   GATE_AUD4(CLK_AUD_AFE_DMIC1, "aud_afe_dmic1",
> > > > > "a1sys_hp_sel",
> > > > > 10),
> > > > > +   GATE_AUD4(CLK_AUD_AFE_DMIC2, "aud_afe_dmic2",
> > > > > "a1sys_hp_sel",
> > > > > 11),
> > > > > +   GATE_AUD4(CLK_AUD_AFE_DMIC3, "aud_afe_dmic3",
> > > > > "a1sys_hp_sel",
> > > > > 12),
> > > > > +   GATE_AUD4(CLK_AUD_AFE_DMIC4, "aud_afe_dmic4",
> > > > > "a1sys_hp_sel",
> > > > > 13),
> > > > > +   GATE_AUD4(CLK_AUD_AFE_26M_DMIC_TM, "aud_afe_26m_dmic_tm",
> > > > > "a1sys_hp_sel", 14),
> > > > > +   GATE_AUD4(CLK_AUD_UL_TML_HIRES, "aud_ul_tml_hires",
> > > > > "audio_h_sel", 16),
> > > > > +   GATE_AUD4(CLK_AUD_ADC_HIRES, "aud_adc_hires",
> > > > > "audio_h_sel",
> > > > > 17),
> > > > > +   GATE_AUD4(CLK_AUD_ADDA6_ADC, "aud_adda6_adc",
> > > > > "a1sys_hp_sel",
> > > > > 18),
> > > > > +   GATE_AUD4(CLK_AUD_ADDA6_ADC_HIRES, "aud_adda6_adc_hires",
> > > > > "audio_h_sel", 19),
> > > > > +   /* AUD5 */
> > > > > +   GATE_AUD5(CLK_AUD_LINEIN_TUNER, "aud_linein_tuner",
> > > > > "apll5_sel", 5),
> > > > > +   GATE_AUD5(CLK_AUD_EARC_TUNER, "aud_earc_tuner",
> > > > > "apll3_sel",
> > > > > 7),
> > > > > +};
> > > >
> > > > These are all clock gates, and are all internal to the audio
> > > > hardware,
> > > > i.e. not used by other drivers or modules.
> > > >
> > > > So these don't actually need to be in a separate clk driver. They
> > > > can
> > > > be
> > > > modelled within ASoC as supplies that are automatically managed
> > > > by
> > > > ASoC
> > > > core. Otherwise just have them as bits that are toggled by the
> > > > audio
> > > > driver's start/stop sequencing code, like they are now, but
> > > > through
> > > > vastly more complicated plumbing.
> > > >
> > > > Please work with the audio driver owner to see if this can be
> > > > moved
> > > > into
> > > > the audio driver.
> > > >
> > > > Regards
> > > > ChenYu
> > > >
> > >
> > > The afe device will be the child of audsys clock provider node and
> > > audsys clock driver will use devm_of_platform_populate() to
> > > populate
> > > afe device when audsys clock gates are registered successfully,
> > > It means afe will be toggled by audsys clock, do you suggest to
> > > change
> > > the toggled order?
> >
> > What I'm saying is that they shouldn't be represented as two drivers
> > and two devices in Linux. They are in the same address space, and the
> > clocks aren't used by any other hardware block. In the device tree we
> > should represent them as one unified device, unless there is a good
> > reason, such as hardware design, not to do so. In the drivers, we can
> > actually just get rid of the audsys clock driver, and have the afe
> > driver toggle the clock enable bits directly. Treat them as any other
> > "enable bits" that exist in any hardware.
> >
> >
> > ChenYu
>
> Because the parent source of audio clock gate is other clocks model in
> CCF, if we get rid of the audsys clock driver then audio driver need to
> guarantee the clock dependence by itself, that makes the control of
> audsys clock gate more complicated.

Could you elaborate on "guarantee clock dependence"?

There is no need to model the audio clock gates in the CCF. That is
actually overcomplicating things. If you really wanted to you could
still do it in the audio driver, either using the CCF, only using
ASoC supplies. The whole audio subsystem hardware is self-contained,
so the representation and driver should be as well, unless there is
a very good reason to split it up.

Also, if a clock driver is present, then maybe it should model all
clocks, not just some of them? For example, the PLLs in the audio
subsystem aren't modeled here, but handled internally in the audio
driver. So why can't the clock gates be handled there as well?

And the audio driver is already reaching into the other clock controllers
with direct references to PLLs and other clock parents, which IMO is a bad
representation. The only clocks the audio driver should reference are the
ones that actually feed the hardware directly. Anything before that should
be handled by the parent clock driver. If a specific clock rate needs to
be set, the audio driver should set it on the clock that feeds it, and
the CCF, though the CLK_SET_RATE_PARENT flag, passed the request up the
clock tree. Same thing for reparenting, it should be automatic.


Regards
ChenYu
