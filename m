Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9944A3BB9C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhGEJFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhGEJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:05:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B08BC061762
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 02:03:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g24so11344899pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 02:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zTANOCgDl07f+pgpXMUflI8h4nDdn4J/uu3NjZ1gbFs=;
        b=INzzGvakbbKp5o4fCYmZv2Ti2Ie6ucQSCMOZg4+/SPak6UQfXoJrVHaTOIdPQQEiwh
         uYTKynF67a5RCQCYenRyes1RrbMapyGDDRbB4AALTMHWeaHmSvWK741n6IUgWh1a6tKi
         eUKRpMryS1INEbWQjU03pXY+VbNXzpd4E9GGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zTANOCgDl07f+pgpXMUflI8h4nDdn4J/uu3NjZ1gbFs=;
        b=HT3nA6bkqjz9QLfmjNzfajx08hNbOgKTOPi5GtZnJ95bK23Exp7ncv7C3DCa0VXnSQ
         xbkk1iJhuV8dRbvLRdUcf4liE7OuNAOeXuZiXvyo9Ee9dRgSGKHKq7bOpDpw8cEDNkwU
         D+CCSBZSy6+FlGAzeF1EIdnE2DWJ50gRBj1QRQMReHIaEdysGBgT8AM4QybTWYwtCBAN
         2XNuBQTjHQgOYWwdDreloRnj5rlAXr+0oKHCtbq308dn+fOhXs2PFoVvGtzOVxrZtVw0
         KnLbXH1pr05EA2EaDx3G0OVfkx97yPh7fjSt+/vH4oMgYUd5NWNI99MuyIMFvkPUribT
         vgpA==
X-Gm-Message-State: AOAM530fpIqkdDPDg/+ANl9EwA8H3HWs7WZWtPNXKkralXocvpa9ujKn
        FDwPE0BcH3mechus4l1fXVeDzQ==
X-Google-Smtp-Source: ABdhPJz4U8RuE4T/AV7ya4qWRVLxeaYZId56hsJ5pUMFgMT7Vk1eC96suHGKqPu13PLvdtVbnYsAmQ==
X-Received: by 2002:a17:90a:d241:: with SMTP id o1mr13990092pjw.77.1625475786816;
        Mon, 05 Jul 2021 02:03:06 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:f66e:ef34:adcd:b33b])
        by smtp.gmail.com with ESMTPSA id y15sm1839895pfl.92.2021.07.05.02.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 02:03:06 -0700 (PDT)
Date:   Mon, 5 Jul 2021 17:03:02 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 05/22] clk: mediatek: Add MT8195 audio clock support
Message-ID: <YOLKxrJin5kkwiIl@google.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
 <20210616224743.5109-6-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616224743.5109-6-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 17, 2021 at 06:47:26AM +0800, Chun-Jie Chen wrote:
> Add MT8195 audio clock provider
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig          |   6 +
>  drivers/clk/mediatek/Makefile         |   1 +
>  drivers/clk/mediatek/clk-mt8195-aud.c | 198 ++++++++++++++++++++++++++
>  3 files changed, 205 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-aud.c
> 
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 6707aba3d500..e2bae9d490a4 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -588,6 +588,12 @@ config COMMON_CLK_MT8195
>  	help
>  	  This driver supports MediaTek MT8195 basic clocks.
>  
> +config COMMON_CLK_MT8195_AUDSYS
> +	bool "Clock driver for MediaTek MT8195 audsys"
> +	depends on COMMON_CLK_MT8195
> +	help
> +	  This driver supports MediaTek MT8195 audsys clocks.
> +

The clock modules aren't shared between different chips, so either we
enable support for all clock hardware in one chip or we don't. It
doesn't make sense to support just some of them. So having just one
Kconfig option and having all drivers under it is better.

>  config COMMON_CLK_MT8516
>  	bool "Clock driver for MediaTek MT8516"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index f8002d8966e1..f27c04314186 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -81,5 +81,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_SCP_ADSP) += clk-mt8192-scp_adsp.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195.o
> +obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS) += clk-mt8195-aud.o
>  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
>  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt8195-aud.c b/drivers/clk/mediatek/clk-mt8195-aud.c
> new file mode 100644
> index 000000000000..db5f80d41de0
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8195-aud.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (c) 2021 MediaTek Inc.
> +// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mt8195-clk.h>
> +
> +static const struct mtk_gate_regs aud0_cg_regs = {
> +	.set_ofs = 0x0,
> +	.clr_ofs = 0x0,
> +	.sta_ofs = 0x0,
> +};
> +
> +static const struct mtk_gate_regs aud1_cg_regs = {
> +	.set_ofs = 0x10,
> +	.clr_ofs = 0x10,
> +	.sta_ofs = 0x10,
> +};
> +
> +static const struct mtk_gate_regs aud2_cg_regs = {
> +	.set_ofs = 0x14,
> +	.clr_ofs = 0x14,
> +	.sta_ofs = 0x14,
> +};
> +
> +static const struct mtk_gate_regs aud3_cg_regs = {
> +	.set_ofs = 0x18,
> +	.clr_ofs = 0x18,
> +	.sta_ofs = 0x18,
> +};
> +
> +static const struct mtk_gate_regs aud4_cg_regs = {
> +	.set_ofs = 0x4,
> +	.clr_ofs = 0x4,
> +	.sta_ofs = 0x4,
> +};
> +
> +static const struct mtk_gate_regs aud5_cg_regs = {
> +	.set_ofs = 0xc,
> +	.clr_ofs = 0xc,
> +	.sta_ofs = 0xc,
> +};
> +
> +#define GATE_AUD0(_id, _name, _parent, _shift)			\
> +	GATE_MTK(_id, _name, _parent, &aud0_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
> +
> +#define GATE_AUD1(_id, _name, _parent, _shift)			\
> +	GATE_MTK(_id, _name, _parent, &aud1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
> +
> +#define GATE_AUD2(_id, _name, _parent, _shift)			\
> +	GATE_MTK(_id, _name, _parent, &aud2_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
> +
> +#define GATE_AUD3(_id, _name, _parent, _shift)			\
> +	GATE_MTK(_id, _name, _parent, &aud3_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
> +
> +#define GATE_AUD4(_id, _name, _parent, _shift)			\
> +	GATE_MTK(_id, _name, _parent, &aud4_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
> +
> +#define GATE_AUD5(_id, _name, _parent, _shift)			\
> +	GATE_MTK(_id, _name, _parent, &aud5_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
> +
> +static const struct mtk_gate aud_clks[] = {
> +	/* AUD0 */
> +	GATE_AUD0(CLK_AUD_AFE, "aud_afe", "a1sys_hp_sel", 2),
> +	GATE_AUD0(CLK_AUD_LRCK_CNT, "aud_lrck_cnt", "a1sys_hp_sel", 4),
> +	GATE_AUD0(CLK_AUD_SPDIFIN_TUNER_APLL, "aud_spdifin_tuner_apll", "apll4_sel", 10),
> +	GATE_AUD0(CLK_AUD_SPDIFIN_TUNER_DBG, "aud_spdifin_tuner_dbg", "apll4_sel", 11),
> +	GATE_AUD0(CLK_AUD_UL_TML, "aud_ul_tml", "a1sys_hp_sel", 18),
> +	GATE_AUD0(CLK_AUD_APLL1_TUNER, "aud_apll1_tuner", "apll1_sel", 19),
> +	GATE_AUD0(CLK_AUD_APLL2_TUNER, "aud_apll2_tuner", "apll2_sel", 20),
> +	GATE_AUD0(CLK_AUD_TOP0_SPDF, "aud_top0_spdf", "aud_iec_sel", 21),
> +	GATE_AUD0(CLK_AUD_APLL, "aud_apll", "apll1_sel", 23),
> +	GATE_AUD0(CLK_AUD_APLL2, "aud_apll2", "apll2_sel", 24),
> +	GATE_AUD0(CLK_AUD_DAC, "aud_dac", "a1sys_hp_sel", 25),
> +	GATE_AUD0(CLK_AUD_DAC_PREDIS, "aud_dac_predis", "a1sys_hp_sel", 26),
> +	GATE_AUD0(CLK_AUD_TML, "aud_tml", "a1sys_hp_sel", 27),
> +	GATE_AUD0(CLK_AUD_ADC, "aud_adc", "a1sys_hp_sel", 28),
> +	GATE_AUD0(CLK_AUD_DAC_HIRES, "aud_dac_hires", "audio_h_sel", 31),
> +	/* AUD1 */
> +	GATE_AUD1(CLK_AUD_I2SIN, "aud_i2sin", "a1sys_hp_sel", 0),
> +	GATE_AUD1(CLK_AUD_TDM_IN, "aud_tdm_in", "a1sys_hp_sel", 1),
> +	GATE_AUD1(CLK_AUD_I2S_OUT, "aud_i2s_out", "a1sys_hp_sel", 6),
> +	GATE_AUD1(CLK_AUD_TDM_OUT, "aud_tdm_out", "a1sys_hp_sel", 7),
> +	GATE_AUD1(CLK_AUD_HDMI_OUT, "aud_hdmi_out", "a1sys_hp_sel", 8),
> +	GATE_AUD1(CLK_AUD_ASRC11, "aud_asrc11", "a1sys_hp_sel", 16),
> +	GATE_AUD1(CLK_AUD_ASRC12, "aud_asrc12", "a1sys_hp_sel", 17),
> +	GATE_AUD1(CLK_AUD_MULTI_IN, "aud_multi_in", "mphone_slave_b", 19),
> +	GATE_AUD1(CLK_AUD_INTDIR, "aud_intdir", "intdir_sel", 20),
> +	GATE_AUD1(CLK_AUD_A1SYS, "aud_a1sys", "a1sys_hp_sel", 21),
> +	GATE_AUD1(CLK_AUD_A2SYS, "aud_a2sys", "a2sys_sel", 22),
> +	GATE_AUD1(CLK_AUD_PCMIF, "aud_pcmif", "a1sys_hp_sel", 24),
> +	GATE_AUD1(CLK_AUD_A3SYS, "aud_a3sys", "a3sys_sel", 30),
> +	GATE_AUD1(CLK_AUD_A4SYS, "aud_a4sys", "a4sys_sel", 31),
> +	/* AUD2 */
> +	GATE_AUD2(CLK_AUD_MEMIF_UL1, "aud_memif_ul1", "a1sys_hp_sel", 0),
> +	GATE_AUD2(CLK_AUD_MEMIF_UL2, "aud_memif_ul2", "a1sys_hp_sel", 1),
> +	GATE_AUD2(CLK_AUD_MEMIF_UL3, "aud_memif_ul3", "a1sys_hp_sel", 2),
> +	GATE_AUD2(CLK_AUD_MEMIF_UL4, "aud_memif_ul4", "a1sys_hp_sel", 3),
> +	GATE_AUD2(CLK_AUD_MEMIF_UL5, "aud_memif_ul5", "a1sys_hp_sel", 4),
> +	GATE_AUD2(CLK_AUD_MEMIF_UL6, "aud_memif_ul6", "a1sys_hp_sel", 5),
> +	GATE_AUD2(CLK_AUD_MEMIF_UL8, "aud_memif_ul8", "a1sys_hp_sel", 7),
> +	GATE_AUD2(CLK_AUD_MEMIF_UL9, "aud_memif_ul9", "a1sys_hp_sel", 8),
> +	GATE_AUD2(CLK_AUD_MEMIF_UL10, "aud_memif_ul10", "a1sys_hp_sel", 9),
> +	GATE_AUD2(CLK_AUD_MEMIF_DL2, "aud_memif_dl2", "a1sys_hp_sel", 18),
> +	GATE_AUD2(CLK_AUD_MEMIF_DL3, "aud_memif_dl3", "a1sys_hp_sel", 19),
> +	GATE_AUD2(CLK_AUD_MEMIF_DL6, "aud_memif_dl6", "a1sys_hp_sel", 22),
> +	GATE_AUD2(CLK_AUD_MEMIF_DL7, "aud_memif_dl7", "a1sys_hp_sel", 23),
> +	GATE_AUD2(CLK_AUD_MEMIF_DL8, "aud_memif_dl8", "a1sys_hp_sel", 24),
> +	GATE_AUD2(CLK_AUD_MEMIF_DL10, "aud_memif_dl10", "a1sys_hp_sel", 26),
> +	GATE_AUD2(CLK_AUD_MEMIF_DL11, "aud_memif_dl11", "a1sys_hp_sel", 27),
> +	/* AUD3 */
> +	GATE_AUD3(CLK_AUD_GASRC0, "aud_gasrc0", "asm_h_sel", 0),
> +	GATE_AUD3(CLK_AUD_GASRC1, "aud_gasrc1", "asm_h_sel", 1),
> +	GATE_AUD3(CLK_AUD_GASRC2, "aud_gasrc2", "asm_h_sel", 2),
> +	GATE_AUD3(CLK_AUD_GASRC3, "aud_gasrc3", "asm_h_sel", 3),
> +	GATE_AUD3(CLK_AUD_GASRC4, "aud_gasrc4", "asm_h_sel", 4),
> +	GATE_AUD3(CLK_AUD_GASRC5, "aud_gasrc5", "asm_h_sel", 5),
> +	GATE_AUD3(CLK_AUD_GASRC6, "aud_gasrc6", "asm_h_sel", 6),
> +	GATE_AUD3(CLK_AUD_GASRC7, "aud_gasrc7", "asm_h_sel", 7),
> +	GATE_AUD3(CLK_AUD_GASRC8, "aud_gasrc8", "asm_h_sel", 8),
> +	GATE_AUD3(CLK_AUD_GASRC9, "aud_gasrc9", "asm_h_sel", 9),
> +	GATE_AUD3(CLK_AUD_GASRC10, "aud_gasrc10", "asm_h_sel", 10),
> +	GATE_AUD3(CLK_AUD_GASRC11, "aud_gasrc11", "asm_h_sel", 11),
> +	GATE_AUD3(CLK_AUD_GASRC12, "aud_gasrc12", "asm_h_sel", 12),
> +	GATE_AUD3(CLK_AUD_GASRC13, "aud_gasrc13", "asm_h_sel", 13),
> +	GATE_AUD3(CLK_AUD_GASRC14, "aud_gasrc14", "asm_h_sel", 14),
> +	GATE_AUD3(CLK_AUD_GASRC15, "aud_gasrc15", "asm_h_sel", 15),
> +	GATE_AUD3(CLK_AUD_GASRC16, "aud_gasrc16", "asm_h_sel", 16),
> +	GATE_AUD3(CLK_AUD_GASRC17, "aud_gasrc17", "asm_h_sel", 17),
> +	GATE_AUD3(CLK_AUD_GASRC18, "aud_gasrc18", "asm_h_sel", 18),
> +	GATE_AUD3(CLK_AUD_GASRC19, "aud_gasrc19", "asm_h_sel", 19),
> +	/* AUD4 */
> +	GATE_AUD4(CLK_AUD_A1SYS_HP, "aud_a1sys_hp", "a1sys_hp_sel", 2),
> +	GATE_AUD4(CLK_AUD_AFE_DMIC1, "aud_afe_dmic1", "a1sys_hp_sel", 10),
> +	GATE_AUD4(CLK_AUD_AFE_DMIC2, "aud_afe_dmic2", "a1sys_hp_sel", 11),
> +	GATE_AUD4(CLK_AUD_AFE_DMIC3, "aud_afe_dmic3", "a1sys_hp_sel", 12),
> +	GATE_AUD4(CLK_AUD_AFE_DMIC4, "aud_afe_dmic4", "a1sys_hp_sel", 13),
> +	GATE_AUD4(CLK_AUD_AFE_26M_DMIC_TM, "aud_afe_26m_dmic_tm", "a1sys_hp_sel", 14),
> +	GATE_AUD4(CLK_AUD_UL_TML_HIRES, "aud_ul_tml_hires", "audio_h_sel", 16),
> +	GATE_AUD4(CLK_AUD_ADC_HIRES, "aud_adc_hires", "audio_h_sel", 17),
> +	GATE_AUD4(CLK_AUD_ADDA6_ADC, "aud_adda6_adc", "a1sys_hp_sel", 18),
> +	GATE_AUD4(CLK_AUD_ADDA6_ADC_HIRES, "aud_adda6_adc_hires", "audio_h_sel", 19),
> +	/* AUD5 */
> +	GATE_AUD5(CLK_AUD_LINEIN_TUNER, "aud_linein_tuner", "apll5_sel", 5),
> +	GATE_AUD5(CLK_AUD_EARC_TUNER, "aud_earc_tuner", "apll3_sel", 7),
> +};

These are all clock gates, and are all internal to the audio hardware,
i.e. not used by other drivers or modules.

So these don't actually need to be in a separate clk driver. They can be
modelled within ASoC as supplies that are automatically managed by ASoC
core. Otherwise just have them as bits that are toggled by the audio
driver's start/stop sequencing code, like they are now, but through
vastly more complicated plumbing.

Please work with the audio driver owner to see if this can be moved into
the audio driver.

Regards
ChenYu

> +
> +static int clk_mt8195_aud_probe(struct platform_device *pdev)
> +{
> +	struct clk_onecell_data *clk_data;
> +	struct device_node *node = pdev->dev.of_node;
> +	int r;
> +
> +	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	r = mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
> +	if (r)
> +		return r;
> +
> +	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +	if (r)
> +		goto err_clk_provider;
> +
> +	r = devm_of_platform_populate(&pdev->dev);
> +	if (r)
> +		goto err_plat_populate;
> +
> +	return 0;
> +
> +err_plat_populate:
> +	of_clk_del_provider(node);
> +err_clk_provider:
> +	return r;
> +}
> +
> +static const struct of_device_id of_match_clk_mt8195_aud[] = {
> +	{ .compatible = "mediatek,mt8195-audsys", },
> +	{}
> +};
> +
> +static struct platform_driver clk_mt8195_aud_drv = {
> +	.probe = clk_mt8195_aud_probe,
> +	.driver = {
> +		.name = "clk-mt8195-aud",
> +		.of_match_table = of_match_clk_mt8195_aud,
> +	},
> +};
> +
> +builtin_platform_driver(clk_mt8195_aud_drv);
> -- 
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
