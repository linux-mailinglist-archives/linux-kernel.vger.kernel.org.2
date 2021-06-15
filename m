Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D723A87CF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhFORf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:35:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34925 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231274AbhFORe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:58 -0400
X-UUID: 4f017c1fe921478db264e921e3471eb5-20210616
X-UUID: 4f017c1fe921478db264e921e3471eb5-20210616
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1875419988; Wed, 16 Jun 2021 01:32:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 01:32:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 01:32:45 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <wenst@google.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Trevor Wu <trevor.wu@mediatek.com>
Subject: [PATCH 21/27] arm64: dts: mt8195: add audio related nodes
Date:   Wed, 16 Jun 2021 01:32:27 +0800
Message-ID: <20210615173233.26682-21-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trevor Wu <trevor.wu@mediatek.com>

add audio related nodes on dts and dtsi

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 286 ++++++++++++++++++++++-
 1 file changed, 285 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index d78cd4d4201b..256818c4c0bf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -230,6 +230,12 @@
 		       <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
 	};
 
+	dmic_codec: dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <2>;
+		wakeup-delay-ms = <50>;
+	};
+
 	pmu-a55 {
 		compatible = "arm,cortex-a55-pmu";
 		interrupt-parent = <&gic>;
@@ -785,8 +791,280 @@
 
 		audsys: syscon@10890000 {
 			compatible = "mediatek,mt8195-audsys", "syscon";
-			reg = <0 0x10890000 0 0x1000>;
+			reg = <0 0x10890000 0 0x10000>;
 			#clock-cells = <1>;
+
+			afe: mt8195-afe-pcm {
+				compatible = "mediatek,mt8195-audio";
+				topckgen = <&topckgen>;
+				power-domains = <&spm MT8195_POWER_DOMAIN_AUDIO>;
+				interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&clk26m>,
+					 <&apmixedsys CLK_APMIXED_APLL1>,
+					 <&apmixedsys CLK_APMIXED_APLL2>,
+					 <&apmixedsys CLK_APMIXED_APLL3>,
+					 <&apmixedsys CLK_APMIXED_APLL4>,
+					 <&apmixedsys CLK_APMIXED_APLL5>,
+					 <&apmixedsys CLK_APMIXED_HDMIRX_APLL>,
+					 <&topckgen CLK_TOP_APLL1>,
+					 <&topckgen CLK_TOP_APLL1_D4>,
+					 <&topckgen CLK_TOP_APLL2>,
+					 <&topckgen CLK_TOP_APLL2_D4>,
+					 <&topckgen CLK_TOP_APLL3>,
+					 <&topckgen CLK_TOP_APLL3_D4>,
+					 <&topckgen CLK_TOP_APLL4>,
+					 <&topckgen CLK_TOP_APLL4_D4>,
+					 <&topckgen CLK_TOP_APLL5>,
+					 <&topckgen CLK_TOP_APLL5_D4>,
+					 <&topckgen CLK_TOP_APLL12_DIV0>,
+					 <&topckgen CLK_TOP_APLL12_DIV1>,
+					 <&topckgen CLK_TOP_APLL12_DIV2>,
+					 <&topckgen CLK_TOP_APLL12_DIV3>,
+					 <&topckgen CLK_TOP_APLL12_DIV4>,
+					 <&topckgen CLK_TOP_APLL12_DIV9>,
+					 <&topckgen CLK_TOP_HDMIRX_APLL>,
+					 <&topckgen CLK_TOP_MAINPLL_D4_D4>,
+					 <&topckgen CLK_TOP_MAINPLL_D5_D2>,
+					 <&topckgen CLK_TOP_MAINPLL_D7_D2>,
+					 <&topckgen CLK_TOP_UNIVPLL_D4>,
+					 <&topckgen CLK_TOP_APLL1_SEL>,
+					 <&topckgen CLK_TOP_APLL2_SEL>,
+					 <&topckgen CLK_TOP_APLL3_SEL>,
+					 <&topckgen CLK_TOP_APLL4_SEL>,
+					 <&topckgen CLK_TOP_APLL5_SEL>,
+					 <&topckgen CLK_TOP_A1SYS_HP_SEL>,
+					 <&topckgen CLK_TOP_A2SYS_SEL>,
+					 <&topckgen CLK_TOP_A3SYS_SEL>,
+					 <&topckgen CLK_TOP_A4SYS_SEL>,
+					 <&topckgen CLK_TOP_ASM_H_SEL>,
+					 <&topckgen CLK_TOP_ASM_M_SEL>,
+					 <&topckgen CLK_TOP_ASM_L_SEL>,
+					 <&topckgen CLK_TOP_AUD_IEC_SEL>,
+					 <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
+					 <&topckgen CLK_TOP_AUDIO_H_SEL>,
+					 <&topckgen CLK_TOP_AUDIO_LOCAL_BUS_SEL>,
+					 <&topckgen CLK_TOP_DPTX_M_SEL>,
+					 <&topckgen CLK_TOP_INTDIR_SEL>,
+					 <&topckgen CLK_TOP_I2SO1_M_SEL>,
+					 <&topckgen CLK_TOP_I2SO2_M_SEL>,
+					 <&topckgen CLK_TOP_I2SI1_M_SEL>,
+					 <&topckgen CLK_TOP_I2SI2_M_SEL>,
+					 <&topckgen CLK_TOP_MPHONE_SLAVE_B>,
+					 <&topckgen CLK_TOP_CFG_26M_AUD>,
+					 <&infracfg_ao CLK_INFRA_AO_AUDIO>,
+					 <&infracfg_ao CLK_INFRA_AO_AUDIO_26M_B>,
+					 <&scp_adsp CLK_SCP_ADSP_AUDIODSP>,
+					 <&audsys CLK_AUD_AFE>,
+					 <&audsys CLK_AUD_LRCK_CNT>,
+					 <&audsys CLK_AUD_SPDIFIN_TUNER_APLL>,
+					 <&audsys CLK_AUD_SPDIFIN_TUNER_DBG>,
+					 <&audsys CLK_AUD_UL_TML>,
+					 <&audsys CLK_AUD_APLL1_TUNER>,
+					 <&audsys CLK_AUD_APLL2_TUNER>,
+					 <&audsys CLK_AUD_TOP0_SPDF>,
+					 <&audsys CLK_AUD_APLL>,
+					 <&audsys CLK_AUD_APLL2>,
+					 <&audsys CLK_AUD_DAC>,
+					 <&audsys CLK_AUD_DAC_PREDIS>,
+					 <&audsys CLK_AUD_TML>,
+					 <&audsys CLK_AUD_ADC>,
+					 <&audsys CLK_AUD_DAC_HIRES>,
+					 <&audsys CLK_AUD_A1SYS_HP>,
+					 <&audsys CLK_AUD_AFE_DMIC1>,
+					 <&audsys CLK_AUD_AFE_DMIC2>,
+					 <&audsys CLK_AUD_AFE_DMIC3>,
+					 <&audsys CLK_AUD_AFE_DMIC4>,
+					 <&audsys CLK_AUD_AFE_26M_DMIC_TM>,
+					 <&audsys CLK_AUD_UL_TML_HIRES>,
+					 <&audsys CLK_AUD_ADC_HIRES>,
+					 <&audsys CLK_AUD_ADDA6_ADC>,
+					 <&audsys CLK_AUD_ADDA6_ADC_HIRES>,
+					 <&audsys CLK_AUD_LINEIN_TUNER>,
+					 <&audsys CLK_AUD_EARC_TUNER>,
+					 <&audsys CLK_AUD_I2SIN>,
+					 <&audsys CLK_AUD_TDM_IN>,
+					 <&audsys CLK_AUD_I2S_OUT>,
+					 <&audsys CLK_AUD_TDM_OUT>,
+					 <&audsys CLK_AUD_HDMI_OUT>,
+					 <&audsys CLK_AUD_ASRC11>,
+					 <&audsys CLK_AUD_ASRC12>,
+					 <&audsys CLK_AUD_MULTI_IN>,
+					 <&audsys CLK_AUD_INTDIR>,
+					 <&audsys CLK_AUD_A1SYS>,
+					 <&audsys CLK_AUD_A2SYS>,
+					 <&audsys CLK_AUD_PCMIF>,
+					 <&audsys CLK_AUD_A3SYS>,
+					 <&audsys CLK_AUD_A4SYS>,
+					 <&audsys CLK_AUD_MEMIF_UL1>,
+					 <&audsys CLK_AUD_MEMIF_UL2>,
+					 <&audsys CLK_AUD_MEMIF_UL3>,
+					 <&audsys CLK_AUD_MEMIF_UL4>,
+					 <&audsys CLK_AUD_MEMIF_UL5>,
+					 <&audsys CLK_AUD_MEMIF_UL6>,
+					 <&audsys CLK_AUD_MEMIF_UL8>,
+					 <&audsys CLK_AUD_MEMIF_UL9>,
+					 <&audsys CLK_AUD_MEMIF_UL10>,
+					 <&audsys CLK_AUD_MEMIF_DL2>,
+					 <&audsys CLK_AUD_MEMIF_DL3>,
+					 <&audsys CLK_AUD_MEMIF_DL6>,
+					 <&audsys CLK_AUD_MEMIF_DL7>,
+					 <&audsys CLK_AUD_MEMIF_DL8>,
+					 <&audsys CLK_AUD_MEMIF_DL10>,
+					 <&audsys CLK_AUD_MEMIF_DL11>,
+					 <&audsys CLK_AUD_GASRC0>,
+					 <&audsys CLK_AUD_GASRC1>,
+					 <&audsys CLK_AUD_GASRC2>,
+					 <&audsys CLK_AUD_GASRC3>,
+					 <&audsys CLK_AUD_GASRC4>,
+					 <&audsys CLK_AUD_GASRC5>,
+					 <&audsys CLK_AUD_GASRC6>,
+					 <&audsys CLK_AUD_GASRC7>,
+					 <&audsys CLK_AUD_GASRC8>,
+					 <&audsys CLK_AUD_GASRC9>,
+					 <&audsys CLK_AUD_GASRC10>,
+					 <&audsys CLK_AUD_GASRC11>,
+					 <&audsys CLK_AUD_GASRC12>,
+					 <&audsys CLK_AUD_GASRC13>,
+					 <&audsys CLK_AUD_GASRC14>,
+					 <&audsys CLK_AUD_GASRC15>,
+					 <&audsys CLK_AUD_GASRC16>,
+					 <&audsys CLK_AUD_GASRC17>,
+					 <&audsys CLK_AUD_GASRC18>,
+					 <&audsys CLK_AUD_GASRC19>;
+				clock-names = "clk26m",
+					"apll1",
+					"apll2",
+					"apll3",
+					"apll4",
+					"apll5",
+					"hdmirx_apll",
+					"apll1_ck",
+					"apll1_d4",
+					"apll2_ck",
+					"apll2_d4",
+					"apll3_ck",
+					"apll3_d4",
+					"apll4_ck",
+					"apll4_d4",
+					"apll5_ck",
+					"apll5_d4",
+					"apll12_div0",
+					"apll12_div1",
+					"apll12_div2",
+					"apll12_div3",
+					"apll12_div4",
+					"apll12_div9",
+					"hdmirx_apll_ck",
+					"mainpll_d4_d4",
+					"mainpll_d5_d2",
+					"mainpll_d7_d2",
+					"univpll_d4",
+					"apll1_sel",
+					"apll2_sel",
+					"apll3_sel",
+					"apll4_sel",
+					"apll5_sel",
+					"a1sys_hp_sel",
+					"a2sys_sel",
+					"a3sys_sel",
+					"a4sys_sel",
+					"asm_h_sel",
+					"asm_m_sel",
+					"asm_l_sel",
+					"aud_iec_sel",
+					"aud_intbus_sel",
+					"audio_h_sel",
+					"audio_local_bus_sel",
+					"dptx_m_sel",
+					"intdir_sel",
+					"i2so1_m_sel",
+					"i2so2_m_sel",
+					"i2si1_m_sel",
+					"i2si2_m_sel",
+					"mphone_slave_b",
+					"cfg_26m_aud",
+					"infra_ao_audio",
+					"infra_ao_audio_26m_b",
+					"scp_adsp_audiodsp",
+					"aud_afe",
+					"aud_lrck_cnt",
+					"aud_spdifin_tuner_apll",
+					"aud_spdifin_tuner_dbg",
+					"aud_ul_tml",
+					"aud_apll1_tuner",
+					"aud_apll2_tuner",
+					"aud_top0_spdf",
+					"aud_apll",
+					"aud_apll2",
+					"aud_dac",
+					"aud_dac_predis",
+					"aud_tml",
+					"aud_adc",
+					"aud_dac_hires",
+					"aud_a1sys_hp",
+					"aud_afe_dmic1",
+					"aud_afe_dmic2",
+					"aud_afe_dmic3",
+					"aud_afe_dmic4",
+					"aud_afe_26m_dmic_tm",
+					"aud_ul_tml_hires",
+					"aud_adc_hires",
+					"aud_adda6_adc",
+					"aud_adda6_adc_hires",
+					"aud_linein_tuner",
+					"aud_earc_tuner",
+					"aud_i2sin",
+					"aud_tdm_in",
+					"aud_i2s_out",
+					"aud_tdm_out",
+					"aud_hdmi_out",
+					"aud_asrc11",
+					"aud_asrc12",
+					"aud_multi_in",
+					"aud_intdir",
+					"aud_a1sys",
+					"aud_a2sys",
+					"aud_pcmif",
+					"aud_a3sys",
+					"aud_a4sys",
+					"aud_memif_ul1",
+					"aud_memif_ul2",
+					"aud_memif_ul3",
+					"aud_memif_ul4",
+					"aud_memif_ul5",
+					"aud_memif_ul6",
+					"aud_memif_ul8",
+					"aud_memif_ul9",
+					"aud_memif_ul10",
+					"aud_memif_dl2",
+					"aud_memif_dl3",
+					"aud_memif_dl6",
+					"aud_memif_dl7",
+					"aud_memif_dl8",
+					"aud_memif_dl10",
+					"aud_memif_dl11",
+					"aud_gasrc0",
+					"aud_gasrc1",
+					"aud_gasrc2",
+					"aud_gasrc3",
+					"aud_gasrc4",
+					"aud_gasrc5",
+					"aud_gasrc6",
+					"aud_gasrc7",
+					"aud_gasrc8",
+					"aud_gasrc9",
+					"aud_gasrc10",
+					"aud_gasrc11",
+					"aud_gasrc12",
+					"aud_gasrc13",
+					"aud_gasrc14",
+					"aud_gasrc15",
+					"aud_gasrc16",
+					"aud_gasrc17",
+					"aud_gasrc18",
+					"aud_gasrc19";
+				status = "disabled";
+			};
 		};
 
 		audsys_src: syscon@108a0000 {
@@ -2155,4 +2433,10 @@
 		clocks = <&clk26m>;
 		clock-names = "ddc-i2c";
 	};
+
+	sound: mt8195-sound {
+		compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
+		mediatek,platform = <&afe>;
+		status = "disabled";
+	};
 };
-- 
2.18.0

