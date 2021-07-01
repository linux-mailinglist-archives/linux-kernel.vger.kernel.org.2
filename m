Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0473B961A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 20:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhGASXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 14:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbhGASXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 14:23:17 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD9FC061762;
        Thu,  1 Jul 2021 11:20:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so7426773wms.1;
        Thu, 01 Jul 2021 11:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AMftSGfD02OUyEuz7LoC3Zz1MSCEdM4XzT0g1jVjTuU=;
        b=H4aGs5w3mukwLmaDwPl32T6m6Iv7EecgCY6XuCURcmT4Ae9zKM+BZL9oB2FXSMLOBF
         KguCwU0Fd87uoAf06f7KZAgo4kuSMomWYQGE5l2nwezHXkzwMla3Aa3cBvCtQyCLVp9c
         Z1Xw5USW2xJDP8qspegmOx7vtlsNS4RzvcQboIYJQMEeukZh/f06LjFTA4k53jpaogrB
         0lGIIKdvMkHG8jiQWVNJeosLhd2K7wX/5d8atCeReCzzgSCZrESiozbHVMIjK3tM6f4O
         NMR4CfiJ4RxmNX9oVR7OFaFLgz662zcBGPNIfkKJUxEhUr7EIoFZk/8cPxdObtOM9f+f
         DMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AMftSGfD02OUyEuz7LoC3Zz1MSCEdM4XzT0g1jVjTuU=;
        b=PnnwY/MjaORVkDyWQrgOFuA2Tsd5q2XusiLJjxU3oV+K1z1l1y/NJLFvRZ6k7CujkG
         kxPc7ZuUoqLBZkohkpLBIiXg/bdB6HuWlK/6ouqdJGCs5ord1V2OCSlDhq/np6flSLwY
         aOb0aUE/nzzjc9qkPO0oRK6g/wf8psCnUB5gn7TbNKQTEQa5Teqv/QxqPhPDuAmjy6TH
         m5OVQw7cxbSlNBTxAT9rQXTGDA7FMsEqq14tUgBVx4Mhjq7Fs7v53feV9iK/L2cJ1DWq
         oChwpGt7bxaQP/E22jJvJcld+/V1Ks9M1CXwoVElsjMmAIBAFBG/TeIMLwh10t0y3f6Z
         F/QQ==
X-Gm-Message-State: AOAM532rRYdn8QKA3/dNqiiTdAFZAph3KpCce/Zr3w+N4kqFykHjH4xX
        pCCVzFfGQFU4fRNVZhDSAjM=
X-Google-Smtp-Source: ABdhPJz2R0JQQlC0/ugw4zGK6F1lSSMuS3dzMwOZgf97/e/+IhDofmyKSRkr2WBurRIYWcIzOC33vQ==
X-Received: by 2002:a05:600c:3652:: with SMTP id y18mr12166531wmq.63.1625163644676;
        Thu, 01 Jul 2021 11:20:44 -0700 (PDT)
Received: from ziggy.stardust ([213.195.127.100])
        by smtp.gmail.com with ESMTPSA id r18sm854836wmh.23.2021.07.01.11.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 11:20:44 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64: dts: mt8183: add audio node
To:     Kansho Nishida <kansho@chromium.org>
Cc:     linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Shunli Wang <shunli.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Eddie Huang <eddie.huang@mediatek.com>
References: <20210630090710.1873559-1-kansho@chromium.org>
 <20210630180652.1.I88a52644e47e88b15f5db9841cb084dc53c5875c@changeid>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <716ab7a7-937d-df88-8d3c-8d35df473b4e@gmail.com>
Date:   Thu, 1 Jul 2021 20:20:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210630180652.1.I88a52644e47e88b15f5db9841cb084dc53c5875c@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/06/2021 11:07, Kansho Nishida wrote:
> Add afe (audio front end) device node to the MT8183 dtsi.
> 
> Signed-off-by: Kansho Nishida <kansho@chromium.org>
> ---
> 
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 94 +++++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index f90df6439c08..b06acb8d6527 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1115,10 +1115,102 @@ usb_host: usb@11200000 {
>  			};
>  		};
>  
> -		audiosys: syscon@11220000 {
> +		audiosys: clock-controller@11220000 {

Why do you change it from sysecon to clock-controller?

Regards,
Matthias

>  			compatible = "mediatek,mt8183-audiosys", "syscon";
>  			reg = <0 0x11220000 0 0x1000>;
>  			#clock-cells = <1>;
> +			afe: mt8183-afe-pcm {
> +				compatible = "mediatek,mt8183-audio";
> +				interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
> +				resets = <&watchdog MT8183_TOPRGU_AUDIO_SW_RST>;
> +				reset-names = "audiosys";
> +				power-domains =
> +					<&spm MT8183_POWER_DOMAIN_AUDIO>;
> +				clocks = <&audiosys CLK_AUDIO_AFE>,
> +					 <&audiosys CLK_AUDIO_DAC>,
> +					 <&audiosys CLK_AUDIO_DAC_PREDIS>,
> +					 <&audiosys CLK_AUDIO_ADC>,
> +					 <&audiosys CLK_AUDIO_PDN_ADDA6_ADC>,
> +					 <&audiosys CLK_AUDIO_22M>,
> +					 <&audiosys CLK_AUDIO_24M>,
> +					 <&audiosys CLK_AUDIO_APLL_TUNER>,
> +					 <&audiosys CLK_AUDIO_APLL2_TUNER>,
> +					 <&audiosys CLK_AUDIO_I2S1>,
> +					 <&audiosys CLK_AUDIO_I2S2>,
> +					 <&audiosys CLK_AUDIO_I2S3>,
> +					 <&audiosys CLK_AUDIO_I2S4>,
> +					 <&audiosys CLK_AUDIO_TDM>,
> +					 <&audiosys CLK_AUDIO_TML>,
> +					 <&infracfg CLK_INFRA_AUDIO>,
> +					 <&infracfg CLK_INFRA_AUDIO_26M_BCLK>,
> +					 <&topckgen CLK_TOP_MUX_AUDIO>,
> +					 <&topckgen CLK_TOP_MUX_AUD_INTBUS>,
> +					 <&topckgen CLK_TOP_SYSPLL_D2_D4>,
> +					 <&topckgen CLK_TOP_MUX_AUD_1>,
> +					 <&topckgen CLK_TOP_APLL1_CK>,
> +					 <&topckgen CLK_TOP_MUX_AUD_2>,
> +					 <&topckgen CLK_TOP_APLL2_CK>,
> +					 <&topckgen CLK_TOP_MUX_AUD_ENG1>,
> +					 <&topckgen CLK_TOP_APLL1_D8>,
> +					 <&topckgen CLK_TOP_MUX_AUD_ENG2>,
> +					 <&topckgen CLK_TOP_APLL2_D8>,
> +					 <&topckgen CLK_TOP_MUX_APLL_I2S0>,
> +					 <&topckgen CLK_TOP_MUX_APLL_I2S1>,
> +					 <&topckgen CLK_TOP_MUX_APLL_I2S2>,
> +					 <&topckgen CLK_TOP_MUX_APLL_I2S3>,
> +					 <&topckgen CLK_TOP_MUX_APLL_I2S4>,
> +					 <&topckgen CLK_TOP_MUX_APLL_I2S5>,
> +					 <&topckgen CLK_TOP_APLL12_DIV0>,
> +					 <&topckgen CLK_TOP_APLL12_DIV1>,
> +					 <&topckgen CLK_TOP_APLL12_DIV2>,
> +					 <&topckgen CLK_TOP_APLL12_DIV3>,
> +					 <&topckgen CLK_TOP_APLL12_DIV4>,
> +					 <&topckgen CLK_TOP_APLL12_DIVB>,
> +					 /*<&topckgen CLK_TOP_APLL12_DIV5>,*/
> +					 <&clk26m>;
> +				clock-names = "aud_afe_clk",
> +						  "aud_dac_clk",
> +						  "aud_dac_predis_clk",
> +						  "aud_adc_clk",
> +						  "aud_adc_adda6_clk",
> +						  "aud_apll22m_clk",
> +						  "aud_apll24m_clk",
> +						  "aud_apll1_tuner_clk",
> +						  "aud_apll2_tuner_clk",
> +						  "aud_i2s1_bclk_sw",
> +						  "aud_i2s2_bclk_sw",
> +						  "aud_i2s3_bclk_sw",
> +						  "aud_i2s4_bclk_sw",
> +						  "aud_tdm_clk",
> +						  "aud_tml_clk",
> +						  "aud_infra_clk",
> +						  "mtkaif_26m_clk",
> +						  "top_mux_audio",
> +						  "top_mux_aud_intbus",
> +						  "top_syspll_d2_d4",
> +						  "top_mux_aud_1",
> +						  "top_apll1_ck",
> +						  "top_mux_aud_2",
> +						  "top_apll2_ck",
> +						  "top_mux_aud_eng1",
> +						  "top_apll1_d8",
> +						  "top_mux_aud_eng2",
> +						  "top_apll2_d8",
> +						  "top_i2s0_m_sel",
> +						  "top_i2s1_m_sel",
> +						  "top_i2s2_m_sel",
> +						  "top_i2s3_m_sel",
> +						  "top_i2s4_m_sel",
> +						  "top_i2s5_m_sel",
> +						  "top_apll12_div0",
> +						  "top_apll12_div1",
> +						  "top_apll12_div2",
> +						  "top_apll12_div3",
> +						  "top_apll12_div4",
> +						  "top_apll12_divb",
> +						  /*"top_apll12_div5",*/
> +						  "top_clk26m_clk";
> +			};
>  		};
>  
>  		mmc0: mmc@11230000 {
> 
