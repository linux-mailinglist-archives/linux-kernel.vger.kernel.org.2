Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AEE3F49D7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbhHWLdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbhHWLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:33:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5FFC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:33:11 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id o10so37235659lfr.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MW19KR6JHeN+V/OR9mBbkqr7/LqjGaRzgW8W26OZPA4=;
        b=ZlzhmpKv+6qNbGY94ygX8jelfK4X1/tlWFNGKfygY9yz/Coh0IxOrl7aqwsN/+wzkY
         F3jIPhAv0cXHWmlDMy9P8veQq9IEvi4fDYHUxW1Zb6sb58loK7+7Bd94J7wfIgvb5sda
         uzQSLuawyI8o687yc5mDExFBMZMOadAMSsKt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MW19KR6JHeN+V/OR9mBbkqr7/LqjGaRzgW8W26OZPA4=;
        b=nG7cnN2iCmICHys+bwMjEz6R4M3sWpHc0sS2t8vKw1MfiWXlm6Z3ENbrvfVgPBxjXZ
         u1kC709XesTTRNlxwcQZj+qwUKCtsCO9GYqgWnHTTBe3QWzUxhCUA+H9NdaJkEEkgHxH
         cQuaoudjBmYpf8uskyev3BxfNFSkpMGO13z9j/6FsSH1xEnPLqHiEuIJSoIw4Wne0D6Y
         tpyAnmap71QJPHZAljLaXNGpV1rlBHoneYMH4Wh7XgpvUMCVty30RPpGChTkGKm81I/r
         L7KXUVRvEnyQsKu82vdl8F4EYDwfbyEiN/BubMsvCaTeytL4X1rZM2YK2uDs4PkIuvOI
         HUHw==
X-Gm-Message-State: AOAM531IeNRkphb5j9iWQsMeNfh5r8JrnuroKSsLFwQs1bTDvmjyOrTq
        jHD1GJH2P/3dcueqoj4gdGKbHr0TPcJv9aeUL/H1uA==
X-Google-Smtp-Source: ABdhPJyfTyy0L7GfRTWBEhpLaRiolRrzCwuDfUhJQuYn7CwHfyh/OhhdPlK1eFY+G+YkOhH8B3w0cLEMGlnI7RxDiLk=
X-Received: by 2002:ac2:4116:: with SMTP id b22mr25196454lfi.587.1629718388936;
 Mon, 23 Aug 2021 04:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111504.350-1-chun-jie.chen@mediatek.com> <20210820111504.350-10-chun-jie.chen@mediatek.com>
In-Reply-To: <20210820111504.350-10-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 23 Aug 2021 19:32:57 +0800
Message-ID: <CAGXv+5Hz0_LXz+k9dDgojUH79gzUYhXhWf275yU0hE1bzNNJOA@mail.gmail.com>
Subject: Re: [v2 09/24] clk: mediatek: Add MT8195 infrastructure clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
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

On Fri, Aug 20, 2021 at 7:21 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 infrastructure clock controller which provides
> clock gate control for basic IP like pwm, uart, spi and so on.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Makefile              |   2 +-
>  drivers/clk/mediatek/clk-mt8195-infra_ao.c | 211 +++++++++++++++++++++
>  2 files changed, 212 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-infra_ao.c
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index d5ee396dcded..c5a80645f10e 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -80,6 +80,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_MSDC) += clk-mt8192-msdc.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_SCP_ADSP) += clk-mt8192-scp_adsp.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
> -obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o clk-mt8195-peri_ao.o
> +obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o

Same thing about line width.

>  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
>  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
> new file mode 100644
> index 000000000000..a5794c65f743
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
> @@ -0,0 +1,211 @@
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
> +static const struct mtk_gate_regs infra_ao0_cg_regs = {
> +       .set_ofs = 0x80,
> +       .clr_ofs = 0x84,
> +       .sta_ofs = 0x90,
> +};
> +
> +static const struct mtk_gate_regs infra_ao1_cg_regs = {
> +       .set_ofs = 0x88,
> +       .clr_ofs = 0x8c,
> +       .sta_ofs = 0x94,
> +};
> +
> +static const struct mtk_gate_regs infra_ao2_cg_regs = {
> +       .set_ofs = 0xa4,
> +       .clr_ofs = 0xa8,
> +       .sta_ofs = 0xac,
> +};
> +
> +static const struct mtk_gate_regs infra_ao3_cg_regs = {
> +       .set_ofs = 0xc0,
> +       .clr_ofs = 0xc4,
> +       .sta_ofs = 0xc8,
> +};
> +
> +static const struct mtk_gate_regs infra_ao4_cg_regs = {
> +       .set_ofs = 0xe0,
> +       .clr_ofs = 0xe4,
> +       .sta_ofs = 0xe8,
> +};
> +
> +#define GATE_INFRA_AO0_FLAGS(_id, _name, _parent, _shift, _flag)                \
> +       GATE_MTK_FLAGS(_id, _name, _parent, &infra_ao0_cg_regs, _shift, \
> +               &mtk_clk_gate_ops_setclr, _flag)
> +
> +#define GATE_INFRA_AO0(_id, _name, _parent, _shift)    \
> +       GATE_INFRA_AO0_FLAGS(_id, _name, _parent, _shift, 0)
> +
> +#define GATE_INFRA_AO1_FLAGS(_id, _name, _parent, _shift, _flag)               \
> +       GATE_MTK_FLAGS(_id, _name, _parent, &infra_ao1_cg_regs, _shift, \
> +               &mtk_clk_gate_ops_setclr, _flag)
> +
> +#define GATE_INFRA_AO1(_id, _name, _parent, _shift)    \
> +       GATE_INFRA_AO1_FLAGS(_id, _name, _parent, _shift, 0)
> +
> +#define GATE_INFRA_AO2(_id, _name, _parent, _shift)                    \
> +       GATE_MTK(_id, _name, _parent, &infra_ao2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +#define GATE_INFRA_AO3_FLAGS(_id, _name, _parent, _shift, _flag)               \
> +       GATE_MTK_FLAGS(_id, _name, _parent, &infra_ao3_cg_regs, _shift, \
> +               &mtk_clk_gate_ops_setclr, _flag)
> +
> +#define GATE_INFRA_AO3(_id, _name, _parent, _shift)    \
> +       GATE_INFRA_AO3_FLAGS(_id, _name, _parent, _shift, 0)
> +
> +#define GATE_INFRA_AO4_FLAGS(_id, _name, _parent, _shift, _flag)               \
> +       GATE_MTK_FLAGS(_id, _name, _parent, &infra_ao4_cg_regs, _shift, \
> +               &mtk_clk_gate_ops_setclr, _flag)
> +
> +#define GATE_INFRA_AO4(_id, _name, _parent, _shift)    \
> +       GATE_INFRA_AO4_FLAGS(_id, _name, _parent, _shift, 0)
> +
> +/*
> + * infra_ao_sej is main clock is for secure engin with JTAG support.

                                                   ^ Typo?

> + * infra_133m_m_peri and infra_66m_m_peri are main clocks of peripheral.
> + * infra_device_apc and infra_device_apc_sync are for device access permission control module.

Since this is quite far from the clock definition, could you split this
comment and inline them before the actual definition instead? That would
make it easier to reference together.

> + */
> +static const struct mtk_gate infra_ao_clks[] = {
> +       /* INFRA_AO0 */
> +       GATE_INFRA_AO0(CLK_INFRA_AO_PMIC_TMR, "infra_ao_pmic_tmr", "top_pwrap_ulposc", 0),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_PMIC_AP, "infra_ao_pmic_ap", "top_pwrap_ulposc", 1),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_PMIC_MD, "infra_ao_pmic_md", "top_pwrap_ulposc", 2),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_PMIC_CONN, "infra_ao_pmic_conn", "top_pwrap_ulposc", 3),
> +       GATE_INFRA_AO0_FLAGS(CLK_INFRA_AO_SEJ, "infra_ao_sej", "top_axi", 5, CLK_IS_CRITICAL),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_APXGPT, "infra_ao_apxgpt", "top_axi", 6),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_GCE, "infra_ao_gce", "top_axi", 8),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_GCE2, "infra_ao_gce2", "top_axi", 9),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_THERM, "infra_ao_therm", "top_axi", 10),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_PWM_H, "infra_ao_pwm_h", "top_axi", 15),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_PWM1, "infra_ao_pwm1", "top_pwm", 16),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_PWM2, "infra_ao_pwm2", "top_pwm", 17),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_PWM3, "infra_ao_pwm3", "top_pwm", 18),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_PWM4, "infra_ao_pwm4", "top_pwm", 19),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_PWM, "infra_ao_pwm", "top_pwm", 21),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_UART0, "infra_ao_uart0", "top_uart", 22),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_UART1, "infra_ao_uart1", "top_uart", 23),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_UART2, "infra_ao_uart2", "top_uart", 24),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_UART3, "infra_ao_uart3", "top_uart", 25),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_UART4, "infra_ao_uart4", "top_uart", 26),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_GCE_26M, "infra_ao_gce_26m", "clk26m", 27),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_CQ_DMA_FPC, "infra_ao_cq_dma_fpc", "fpc", 28),
> +       GATE_INFRA_AO0(CLK_INFRA_AO_UART5, "infra_ao_uart5", "top_uart", 29),
> +       /* INFRA_AO1 */
> +       GATE_INFRA_AO1(CLK_INFRA_AO_HDMI_26M, "infra_ao_hdmi_26m", "clk26m", 0),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_SPI0, "infra_ao_spi0", "top_spi", 1),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_MSDC0, "infra_ao_msdc0", "top_msdc50_0_hclk", 2),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_MSDC1, "infra_ao_msdc1", "top_axi", 4),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_CG1_MSDC2, "infra_ao_cg1_msdc2", "top_axi", 5),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_MSDC0_SRC, "infra_ao_msdc0_src", "top_msdc50_0", 6),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_TRNG, "infra_ao_trng", "top_axi", 9),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_AUXADC, "infra_ao_auxadc", "clk26m", 10),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_CPUM, "infra_ao_cpum", "top_axi", 11),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_HDMI_32K, "infra_ao_hdmi_32k", "clk32k", 12),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_CEC_66M_H, "infra_ao_cec_66m_h", "top_axi", 13),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_IRRX, "infra_ao_irrx", "top_axi", 14),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_PCIE_TL_26M, "infra_ao_pcie_tl_26m", "clk26m", 15),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_MSDC1_SRC, "infra_ao_msdc1_src", "top_msdc30_1", 16),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_CEC_66M_B, "infra_ao_cec_66m_b", "top_axi", 17),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_PCIE_TL_96M, "infra_ao_pcie_tl_96m", "top_tl", 18),
> +       GATE_INFRA_AO1_FLAGS(CLK_INFRA_AO_DEVICE_APC, "infra_ao_device_apc", "top_axi", 20,
> +               CLK_IS_CRITICAL),

Please align wrapped lines with opening parenthesis.

> +       GATE_INFRA_AO1(CLK_INFRA_AO_ECC_66M_H, "infra_ao_ecc_66m_h", "top_axi", 23),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_DEBUGSYS, "infra_ao_debugsys", "top_axi", 24),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_AUDIO, "infra_ao_audio", "top_axi", 25),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_PCIE_TL_32K, "infra_ao_pcie_tl_32k", "clk32k", 26),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_DBG_TRACE, "infra_ao_dbg_trace", "top_axi", 29),
> +       GATE_INFRA_AO1(CLK_INFRA_AO_DRAMC_F26M, "infra_ao_dramc_f26m", "clk26m", 31),
> +       /* INFRA_AO2 */
> +       GATE_INFRA_AO2(CLK_INFRA_AO_IRTX, "infra_ao_irtx", "top_axi", 0),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_SSUSB, "infra_ao_ssusb", "top_usb_top", 1),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_DISP_PWM, "infra_ao_disp_pwm", "top_disp_pwm0", 2),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_CLDMA_B, "infra_ao_cldma_b", "top_axi", 3),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_AUDIO_26M_B, "infra_ao_audio_26m_b", "clk26m", 4),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_SPI1, "infra_ao_spi1", "top_spi", 6),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_SPI2, "infra_ao_spi2", "top_spi", 9),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_SPI3, "infra_ao_spi3", "top_spi", 10),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_UNIPRO_SYS, "infra_ao_unipro_sys", "top_ufs", 11),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_UNIPRO_TICK, "infra_ao_unipro_tick", "top_ufs_tick1us", 12),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_UFS_MP_SAP_B, "infra_ao_ufs_mp_sap_b", "top_ufs_mp_sap_cfg",
> +               13),

same here.

> +       GATE_INFRA_AO2(CLK_INFRA_AO_PWRMCU, "infra_ao_pwrmcu", "top_pwrmcu", 15),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_PWRMCU_BUS_H, "infra_ao_pwrmcu_bus_h", "top_axi", 17),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_APDMA_B, "infra_ao_apdma_b", "top_axi", 18),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_SPI4, "infra_ao_spi4", "top_spi", 25),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_SPI5, "infra_ao_spi5", "top_spi", 26),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_CQ_DMA, "infra_ao_cq_dma", "top_axi", 27),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_AES_UFSFDE, "infra_ao_aes_ufsfde", "top_ufs", 28),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_AES, "infra_ao_aes", "top_aes_ufsfde", 29),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_UFS_TICK, "infra_ao_ufs_tick", "top_ufs_tick1us", 30),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_SSUSB_XHCI, "infra_ao_ssusb_xhci", "top_ssusb_xhci", 31),
> +       /* INFRA_AO3 */
> +       GATE_INFRA_AO3(CLK_INFRA_AO_MSDC0_SELF, "infra_ao_msdc0f", "top_msdc50_0", 0),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_MSDC1_SELF, "infra_ao_msdc1f", "top_msdc50_0", 1),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_MSDC2_SELF, "infra_ao_msdc2f", "top_msdc50_0", 2),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_I2S_DMA, "infra_ao_i2s_dma", "top_axi", 5),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_AP_MSDC0, "infra_ao_ap_msdc0", "top_msdc50_0", 7),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_MD_MSDC0, "infra_ao_md_msdc0", "top_msdc50_0", 8),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_CG3_MSDC2, "infra_ao_cg3_msdc2", "top_msdc30_2", 9),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_GCPU, "infra_ao_gcpu", "top_gcpu", 10),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_PCIE_PERI_26M, "infra_ao_pcie_peri_26m", "clk26m", 15),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_GCPU_66M_B, "infra_ao_gcpu_66m_b", "top_axi", 16),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_GCPU_133M_B, "infra_ao_gcpu_133m_b", "top_axi", 17),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_DISP_PWM1, "infra_ao_disp_pwm1", "top_disp_pwm1", 20),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_FBIST2FPC, "infra_ao_fbist2fpc", "top_msdc50_0", 24),
> +       GATE_INFRA_AO3_FLAGS(CLK_INFRA_AO_DEVICE_APC_SYNC, "infra_ao_device_apc_sync", "top_axi",
> +               25, CLK_IS_CRITICAL),

And here.

> +       GATE_INFRA_AO3(CLK_INFRA_AO_PCIE_P1_PERI_26M, "infra_ao_pcie_p1_peri_26m", "clk26m", 26),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_SPIS0, "infra_ao_spis0", "top_spis", 28),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_SPIS1, "infra_ao_spis1", "top_spis", 29),
> +       /* INFRA_AO4 */
> +       GATE_INFRA_AO4_FLAGS(CLK_INFRA_AO_133M_M_PERI, "infra_ao_133m_m_peri", "top_axi", 0,
> +               CLK_IS_CRITICAL),
> +       GATE_INFRA_AO4_FLAGS(CLK_INFRA_AO_66M_M_PERI, "infra_ao_66m_m_peri", "top_spi", 1,
> +               CLK_IS_CRITICAL),
> +       GATE_INFRA_AO4(CLK_INFRA_AO_PCIE_PL_P_250M_P0, "infra_ao_pcie_pl_p_250m_p0", "pextp_pipe",
> +               7),

And these.

> +       GATE_INFRA_AO4(CLK_INFRA_AO_PCIE_PL_P_250M_P1, "infra_ao_pcie_pl_p_250m_p1",
> +               "ssusb_u3phy_p1_p_p0", 8),
> +       GATE_INFRA_AO4(CLK_INFRA_AO_PCIE_P1_TL_96M, "infra_ao_pcie_p1_tl_96m", "top_tl_p1", 17),
> +       GATE_INFRA_AO4(CLK_INFRA_AO_AES_MSDCFDE_0P, "infra_ao_aes_msdcfde_0p", "top_aes_msdcfde",
> +               18),

Ditto.

> +       GATE_INFRA_AO4(CLK_INFRA_AO_UFS_TX_SYMBOL, "infra_ao_ufs_tx_symbol", "ufs_tx_symbol", 22),
> +       GATE_INFRA_AO4(CLK_INFRA_AO_UFS_RX_SYMBOL, "infra_ao_ufs_rx_symbol", "ufs_rx_symbol", 23),
> +       GATE_INFRA_AO4(CLK_INFRA_AO_UFS_RX_SYMBOL1, "infra_ao_ufs_rx_symbol1", "ufs_rx_symbol1",
> +               24),

Ditto.

Since this is already going past 80 characters and close to 100, I would
just keep them on the same line. Having just one or two fields wrapped
on a few lines actually makes it harder to read. I would probably keep
the "CLK_INFRA_AO_DEVICE_APC_SYNC" line wrapped, since that line is way
longer.


Regards
ChenYu

> +       GATE_INFRA_AO4(CLK_INFRA_AO_PERI_UFS_MEM_SUB, "infra_ao_peri_ufs_mem_sub", "mem_466m", 31),
> +};
> +
> +static const struct mtk_clk_desc infra_ao_desc = {
> +       .clks = infra_ao_clks,
> +       .num_clks = ARRAY_SIZE(infra_ao_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt8195_infra_ao[] = {
> +       {
> +               .compatible = "mediatek,mt8195-infracfg_ao",
> +               .data = &infra_ao_desc,
> +       }, {
> +               /* sentinel */
> +       }
> +};
> +
> +static struct platform_driver clk_mt8195_infra_ao_drv = {
> +       .probe = mtk_clk_simple_probe,
> +       .driver = {
> +               .name = "clk-mt8195-infra_ao",
> +               .of_match_table = of_match_clk_mt8195_infra_ao,
> +       },
> +};
> +builtin_platform_driver(clk_mt8195_infra_ao_drv);
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
