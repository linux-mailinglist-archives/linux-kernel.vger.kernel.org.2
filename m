Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808543BB9FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhGEJSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhGEJSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:18:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2C0C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 02:15:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso11130052pjx.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 02:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69UkCOWHSMmakFavbClBD5LGETqvVrLFh8SBxi0UCyc=;
        b=kG2Kn1SNthgjjFuqDS/vlYrvSG+KdUH3d+S0dWJNzb5SiVUcg/QS4NH/vT85U5EB5m
         wKMOAJytwGz5y1KpaMv2I13/YxOekUV3eOYmov049z4H5RTJbxqrddSyPERKW48+0cCS
         1DAMHriEiuCu6ejyPGjSN5wK26FWSAzlIvk2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69UkCOWHSMmakFavbClBD5LGETqvVrLFh8SBxi0UCyc=;
        b=dIjm3XzH34FkjxcVuIhTLFpnrGfKgleunBg5Yh7c6vd+zQxZTHe5yGnLX33Xo1Xtu2
         1j5nRr/yGIss4RdC7ZJIADR/4AvuOPQri2Ym693SZUkm2oOPbzheGIu8yibntVjKAAU3
         KYDn1baexXFq78kT6YgsycEaCNsnWmN2ibhHuYMalnlrPUPjUiWfb05G9TeCpAL+ZlVU
         9Vxzht0BPDKn3Fr2MALtcWqX02sOw8gYvVDfCnAKeLYDg4WQLZfiwnDME2G2rQkyXLhS
         83YYXjT5lfpCw+WdfkcosjrpZoCJT67sUowg5uyLu91aiLat61gUoPtMLisyj3wCHSxL
         D79g==
X-Gm-Message-State: AOAM533uuUp494VSdXEWJT43IvTxitd6Rd35ws/d4Y20bq9mUYulbl7c
        01SqwFwwiJFNVYoNw3f7AaZd6x1z0QO42Q==
X-Google-Smtp-Source: ABdhPJyYN9I5E0K1lmQDLJPBVyCj9l12Ho1RfQ9GcuksyXiVAxdmi0yC3Xzy7ps3R20/5Do52wqEWQ==
X-Received: by 2002:a17:902:cecb:b029:128:e535:89f2 with SMTP id d11-20020a170902cecbb0290128e53589f2mr11748651plg.51.1625476529351;
        Mon, 05 Jul 2021 02:15:29 -0700 (PDT)
Received: from kansho.tok.corp.google.com ([2401:fa00:8f:203:cdc4:4be8:5ce4:df43])
        by smtp.gmail.com with ESMTPSA id 9sm12245176pfv.42.2021.07.05.02.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 02:15:29 -0700 (PDT)
From:   Kansho Nishida <kansho@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Shunli Wang <shunli.wang@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Kansho Nishida <kansho@chromium.org>
Subject: [PATCH v2 1/2] arm64: dts: mt8183: add audio node
Date:   Mon,  5 Jul 2021 18:15:13 +0900
Message-Id: <20210705181443.v2.1.I88a52644e47e88b15f5db9841cb084dc53c5875c@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210705091514.912355-1-kansho@chromium.org>
References: <20210705091514.912355-1-kansho@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add afe (audio front end) device node to the MT8183 dtsi.

Signed-off-by: Kansho Nishida <kansho@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 94 +++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index f90df6439c08..b06acb8d6527 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1115,10 +1115,102 @@ usb_host: usb@11200000 {
 			};
 		};
 
-		audiosys: syscon@11220000 {
+		audiosys: clock-controller@11220000 {
 			compatible = "mediatek,mt8183-audiosys", "syscon";
 			reg = <0 0x11220000 0 0x1000>;
 			#clock-cells = <1>;
+			afe: mt8183-afe-pcm {
+				compatible = "mediatek,mt8183-audio";
+				interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
+				resets = <&watchdog MT8183_TOPRGU_AUDIO_SW_RST>;
+				reset-names = "audiosys";
+				power-domains =
+					<&spm MT8183_POWER_DOMAIN_AUDIO>;
+				clocks = <&audiosys CLK_AUDIO_AFE>,
+					 <&audiosys CLK_AUDIO_DAC>,
+					 <&audiosys CLK_AUDIO_DAC_PREDIS>,
+					 <&audiosys CLK_AUDIO_ADC>,
+					 <&audiosys CLK_AUDIO_PDN_ADDA6_ADC>,
+					 <&audiosys CLK_AUDIO_22M>,
+					 <&audiosys CLK_AUDIO_24M>,
+					 <&audiosys CLK_AUDIO_APLL_TUNER>,
+					 <&audiosys CLK_AUDIO_APLL2_TUNER>,
+					 <&audiosys CLK_AUDIO_I2S1>,
+					 <&audiosys CLK_AUDIO_I2S2>,
+					 <&audiosys CLK_AUDIO_I2S3>,
+					 <&audiosys CLK_AUDIO_I2S4>,
+					 <&audiosys CLK_AUDIO_TDM>,
+					 <&audiosys CLK_AUDIO_TML>,
+					 <&infracfg CLK_INFRA_AUDIO>,
+					 <&infracfg CLK_INFRA_AUDIO_26M_BCLK>,
+					 <&topckgen CLK_TOP_MUX_AUDIO>,
+					 <&topckgen CLK_TOP_MUX_AUD_INTBUS>,
+					 <&topckgen CLK_TOP_SYSPLL_D2_D4>,
+					 <&topckgen CLK_TOP_MUX_AUD_1>,
+					 <&topckgen CLK_TOP_APLL1_CK>,
+					 <&topckgen CLK_TOP_MUX_AUD_2>,
+					 <&topckgen CLK_TOP_APLL2_CK>,
+					 <&topckgen CLK_TOP_MUX_AUD_ENG1>,
+					 <&topckgen CLK_TOP_APLL1_D8>,
+					 <&topckgen CLK_TOP_MUX_AUD_ENG2>,
+					 <&topckgen CLK_TOP_APLL2_D8>,
+					 <&topckgen CLK_TOP_MUX_APLL_I2S0>,
+					 <&topckgen CLK_TOP_MUX_APLL_I2S1>,
+					 <&topckgen CLK_TOP_MUX_APLL_I2S2>,
+					 <&topckgen CLK_TOP_MUX_APLL_I2S3>,
+					 <&topckgen CLK_TOP_MUX_APLL_I2S4>,
+					 <&topckgen CLK_TOP_MUX_APLL_I2S5>,
+					 <&topckgen CLK_TOP_APLL12_DIV0>,
+					 <&topckgen CLK_TOP_APLL12_DIV1>,
+					 <&topckgen CLK_TOP_APLL12_DIV2>,
+					 <&topckgen CLK_TOP_APLL12_DIV3>,
+					 <&topckgen CLK_TOP_APLL12_DIV4>,
+					 <&topckgen CLK_TOP_APLL12_DIVB>,
+					 /*<&topckgen CLK_TOP_APLL12_DIV5>,*/
+					 <&clk26m>;
+				clock-names = "aud_afe_clk",
+						  "aud_dac_clk",
+						  "aud_dac_predis_clk",
+						  "aud_adc_clk",
+						  "aud_adc_adda6_clk",
+						  "aud_apll22m_clk",
+						  "aud_apll24m_clk",
+						  "aud_apll1_tuner_clk",
+						  "aud_apll2_tuner_clk",
+						  "aud_i2s1_bclk_sw",
+						  "aud_i2s2_bclk_sw",
+						  "aud_i2s3_bclk_sw",
+						  "aud_i2s4_bclk_sw",
+						  "aud_tdm_clk",
+						  "aud_tml_clk",
+						  "aud_infra_clk",
+						  "mtkaif_26m_clk",
+						  "top_mux_audio",
+						  "top_mux_aud_intbus",
+						  "top_syspll_d2_d4",
+						  "top_mux_aud_1",
+						  "top_apll1_ck",
+						  "top_mux_aud_2",
+						  "top_apll2_ck",
+						  "top_mux_aud_eng1",
+						  "top_apll1_d8",
+						  "top_mux_aud_eng2",
+						  "top_apll2_d8",
+						  "top_i2s0_m_sel",
+						  "top_i2s1_m_sel",
+						  "top_i2s2_m_sel",
+						  "top_i2s3_m_sel",
+						  "top_i2s4_m_sel",
+						  "top_i2s5_m_sel",
+						  "top_apll12_div0",
+						  "top_apll12_div1",
+						  "top_apll12_div2",
+						  "top_apll12_div3",
+						  "top_apll12_div4",
+						  "top_apll12_divb",
+						  /*"top_apll12_div5",*/
+						  "top_clk26m_clk";
+			};
 		};
 
 		mmc0: mmc@11230000 {
-- 
2.32.0.93.g670b81a890-goog

