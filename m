Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7068E3E5E65
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 16:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbhHJOwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbhHJOt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:49:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B477BC061799;
        Tue, 10 Aug 2021 07:49:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m12so26646865wru.12;
        Tue, 10 Aug 2021 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qkLAa3qaTd+8nDqfmQYHkSkAUgc2KH2yxW7jHafFEGU=;
        b=C75iiIP8Jinw9T3dzyHeFsZhnT3b/VHrUjcreDn10v1lsE0miVUhACe1lClAq5tc5N
         1FlxOq9u7eTwlI8i8EBt7STg8ero3hdHZ3lSYi9h41aPQo24TJvf0rCihR20D7QpZQDo
         Y/MDjQuJ8faLOxOs5ASv+i6/DDj7y/SrWmOADCkR3XUt02UiYJyQnH0f5zJ/1w/4IO6Y
         uoY9I3Hi7FUB7oABb43pHRsjNDco4VWtPLMHwudTSbRozJYHM2HZ8uSk5zXUbSOtBgdP
         AIXDn/Q0lTeADtcjkUAX8pjLBe3CiLelEXySkplZulP4KelUCpG2LOkCTF4i9KF2u4F3
         rSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qkLAa3qaTd+8nDqfmQYHkSkAUgc2KH2yxW7jHafFEGU=;
        b=NziCVPgeo7CSmWiz6S3DJ4hWBU8155QYkgT/lfXjemNCwhbIC3Gs9iVaBYm7Ye6CIm
         VBXrb01M/hSAmKWW/Pv589ibuDqMk228QlGn7RlsAqGeFuGmAZPOgJ/d4Ys37Qj3mbhA
         XmmHIAFsNzBXTLRIlrgt0EzQfZT7+GW8VCm0kIC4yal9hWozumrAZamk/YvP7bGh4Bod
         Fq5Cp0lGZyofTGB3GIsHVkchoe1cHpuWowqBQrXt+/z8nZhK4PBxmM0fp62+TFqVV5/y
         mQD3pRUjGww75cf+ahzYuewUtocDDdM6BCLOGA9ZFYLo0D8p5hVFLKQ0d0K3gv+fi6GA
         NMag==
X-Gm-Message-State: AOAM533eLn3jgamJ5WVA0a9/iqqYzBJnpeQo0+ybwM5UK3lSETnAChBg
        n8gjsAVOiSifAGVOs+ToEzg=
X-Google-Smtp-Source: ABdhPJyGpIjjK7YDyXqguWBe5fWsAo8d3ezNZSAlt17FwtPkid466C2w4F3IrtUJvrAa8VWvNtZQrw==
X-Received: by 2002:a5d:6d0f:: with SMTP id e15mr4355140wrq.373.1628606970305;
        Tue, 10 Aug 2021 07:49:30 -0700 (PDT)
Received: from ziggy.stardust ([207.188.163.204])
        by smtp.gmail.com with ESMTPSA id n30sm26883031wra.1.2021.08.10.07.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 07:49:29 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] arm64: dts: mt8183: add audio node
To:     Kansho Nishida <kansho@chromium.org>
Cc:     Shunli Wang <shunli.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Chen-Yu Tsai <wenst@csie.org>
References: <20210706100136.1205047-1-kansho@chromium.org>
 <20210706190111.v3.1.I88a52644e47e88b15f5db9841cb084dc53c5875c@changeid>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <3db268d2-b662-8fd4-d6dd-0679fa010b71@gmail.com>
Date:   Tue, 10 Aug 2021 16:49:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210706190111.v3.1.I88a52644e47e88b15f5db9841cb084dc53c5875c@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/2021 12:01, Kansho Nishida wrote:
> Add afe (audio front end) device node to the MT8183 dtsi.
> 
> Signed-off-by: Kansho Nishida <kansho@chromium.org>

Now queued in v5.15-tmp/dts64

Please submit a patch to update the binding description. Maybe we should think
of merging the two binding descriptions into one (clock and audio part).

Regards,
Matthias

> ---
> 
> Changes in v3:
> - Use audio-controller as the audio node instead.
> 
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 94 +++++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index f90df6439c08..af895921700c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1115,10 +1115,102 @@ usb_host: usb@11200000 {
>  			};
>  		};
>  
> -		audiosys: syscon@11220000 {
> +		audiosys: audio-controller@11220000 {
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
