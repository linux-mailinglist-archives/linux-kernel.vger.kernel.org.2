Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE31C3A15E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbhFINqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:46:20 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:39601 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhFINqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:46:13 -0400
Received: by mail-wr1-f47.google.com with SMTP id l2so25581157wrw.6;
        Wed, 09 Jun 2021 06:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n8iUSjIzEYKCRymtsdy+1FlOJ14Uww078JrSjb+FdLY=;
        b=t6Vz75tl6+IaT0JTE7YB9MZzA2ROhL0e5D4m+rUsfUGm7AB50Hl1YAstUPTKZUaKXK
         pvSt5/whEqV/bHBkGkY/hRFv7VFVNVRI3KEIv0i7JEnTPP3btDNjke3LZAm9iMbWDrIE
         c1bzVWkScc0rhfHiscuOtJP7gMVHFC4N1ErL1VT/PCgXykA5ESoN5I7Oh8KiogrdFI1z
         iUrr91YKExHseM/nUN/94AJoddgRX5Qg1Nv+29I1QFG3Gaty9r2MBnz2EHvY2ibrbYnl
         jUqMxoZV7HlPowQljMwbHuip54SImGtcqcKt6yZYZGYE0KZYe920vR24lbRUN6alUcYW
         DsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n8iUSjIzEYKCRymtsdy+1FlOJ14Uww078JrSjb+FdLY=;
        b=Y6jrWYtpac4Vk+SexG2VImUtQgeKyNDCebtfdomI8E+hagBTGxxpXZUOi9KdsMDUZs
         JPWr8jy4yOY1jwo/R+UqPdv+CItyjFD3r9pghFIktpksJvHE+rtdS5qTPpnTeeYz1tUp
         m7SvI90XadR8DghiL07zHOEFexsl9Jqc3aEw839iIgMiyPAl6cQ6go9J2/O1pa0sh1gr
         pK1rmWbK5RZ9kwv/2PprhKhEYKoIYUtIHLpT5xFpebf58qQQel+/MHfF8tXpZHjrYTvY
         8++wC1iKNqNbziZQbDGgtfH+m7s7giK0bQgCDox9GyV0KQMo6wkb+sHSVMB5Jb9RXPzK
         J80A==
X-Gm-Message-State: AOAM530k+XAOfu8EfYFL5gG0Glg//raxWI//85/R7nvZ17aS4p+2E5qs
        xJMaTh2IHR6MjdaBO7Jht9LfuVMdsgPD3IaQ
X-Google-Smtp-Source: ABdhPJxOhY+bBjVXmBhQIgz/cXa6r56wruGNA2HNBmroMC4prHAARKEhbwZe/zPaWVRRqxZxgXTPYg==
X-Received: by 2002:adf:f28b:: with SMTP id k11mr27431363wro.89.1623246183569;
        Wed, 09 Jun 2021 06:43:03 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
        by smtp.gmail.com with ESMTPSA id w8sm25924956wre.70.2021.06.09.06.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:43:03 -0700 (PDT)
Subject: Re: [PATCH v14] arm64: dts: mt8183: Add node for the Mali GPU
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        hoegsberg@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        boris.brezillon@collabora.com,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        fshao@chromium.org, hsinyi@chromium.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20210521200038.v14.1.I9f45f5c1f975422d58b5904d11546349e9ccdc94@changeid>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <8e1be63b-8086-c98b-cfb6-61236936fa14@gmail.com>
Date:   Wed, 9 Jun 2021 15:43:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210521200038.v14.1.I9f45f5c1f975422d58b5904d11546349e9ccdc94@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/05/2021 14:00, Nicolas Boichat wrote:
> Add a basic GPU node for mt8183, as well as OPP table.
> 
> Note that with the current panfrost driver, devfreq is not
> actually functional, as the we do not have platform-specific
> support for >1 supplies. Also, we are missing code to handle
> frequency change, as the GPU frequency needs to be switched
> away to a stable 26Mhz clock during the transition.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Applied to v5.13-next/dts64

Thanks!

> ---
> The binding we use with out-of-tree Mali drivers includes more
> clocks, this is used for devfreq: the out-of-tree driver switches
> clk_mux to clk_sub_parent (26Mhz), adjusts clk_main_parent, then
> switches clk_mux back to clk_main_parent:
> (see https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbase_runtime_pm.c#423)
> clocks =
>         <&topckgen CLK_TOP_MFGPLL_CK>,
>         <&topckgen CLK_TOP_MUX_MFG>,
>         <&clk26m>,
>         <&mfgcfg CLK_MFG_BG3D>;
> clock-names =
>         "clk_main_parent",
>         "clk_mux",
>         "clk_sub_parent",
>         "subsys_mfg_cg";
> (based on discussions, this probably belongs in the clock core)
> 
> This only matters for devfreq, that is disabled anyway as we don't
> have platform-specific code to handle >1 supplies.
> 
> Changes in v14:
>  - Move gpu_opp_table from soc to root "/" node of dts.
> 
> Changes in v12:
>  - Add gpu node to mt8183-pumpkin.dts as well (Neil Armstrong).
> 
> Changes in v11:
>  - mt8183*.dts: remove incorrect supply-names
> 
> Changes in v6:
>  - Add gpu regulators to kukui dtsi as well.
>  - Power domains are now attached to spm, not scpsys
>  - Drop R-B.
> 
> Changes in v5:
>  - Rename "2d" power domain to "core2" (keep R-B again).
> 
> Changes in v4:
>  - Add power-domain-names to describe the 3 domains.
>    (kept Alyssa's reviewed-by as the change is minor)
> 
> Changes in v2:
>  - Use sram instead of mali_sram as SRAM supply name.
>  - Rename mali@ to gpu@.
> 
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   5 +
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   5 +
>  .../boot/dts/mediatek/mt8183-pumpkin.dts      |   5 +
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 105 ++++++++++++++++++
>  4 files changed, 120 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> index edff1e03e6fe..7bc0a6a7fadf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> @@ -42,6 +42,11 @@ &auxadc {
>  	status = "okay";
>  };
>  
> +&gpu {
> +	mali-supply = <&mt6358_vgpu_reg>;
> +	sram-supply = <&mt6358_vsram_gpu_reg>;
> +};
> +
>  &i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c_pins_0>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index ff56bcfa3370..e4e54be1c2b2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -279,6 +279,11 @@ dsi_out: endpoint {
>  	};
>  };
>  
> +&gpu {
> +	mali-supply = <&mt6358_vgpu_reg>;
> +	sram-supply = <&mt6358_vsram_gpu_reg>;
> +};
> +
>  &i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c0_pins>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> index 0aff5eb52e88..ee912825cfc6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> @@ -68,6 +68,11 @@ &auxadc {
>  	status = "okay";
>  };
>  
> +&gpu {
> +	mali-supply = <&mt6358_vgpu_reg>;
> +	sram-supply = <&mt6358_vsram_gpu_reg>;
> +};
> +
>  &i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c_pins_0>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index c5e822b6b77a..0afd351f9a9b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -197,6 +197,91 @@ CLUSTER_SLEEP1: cluster-sleep-1 {
>  		};
>  	};
>  
> +	gpu_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			opp-microvolt = <625000>, <850000>;
> +		};
> +
> +		opp-320000000 {
> +			opp-hz = /bits/ 64 <320000000>;
> +			opp-microvolt = <631250>, <850000>;
> +		};
> +
> +		opp-340000000 {
> +			opp-hz = /bits/ 64 <340000000>;
> +			opp-microvolt = <637500>, <850000>;
> +		};
> +
> +		opp-360000000 {
> +			opp-hz = /bits/ 64 <360000000>;
> +			opp-microvolt = <643750>, <850000>;
> +		};
> +
> +		opp-380000000 {
> +			opp-hz = /bits/ 64 <380000000>;
> +			opp-microvolt = <650000>, <850000>;
> +		};
> +
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-microvolt = <656250>, <850000>;
> +		};
> +
> +		opp-420000000 {
> +			opp-hz = /bits/ 64 <420000000>;
> +			opp-microvolt = <662500>, <850000>;
> +		};
> +
> +		opp-460000000 {
> +			opp-hz = /bits/ 64 <460000000>;
> +			opp-microvolt = <675000>, <850000>;
> +		};
> +
> +		opp-500000000 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			opp-microvolt = <687500>, <850000>;
> +		};
> +
> +		opp-540000000 {
> +			opp-hz = /bits/ 64 <540000000>;
> +			opp-microvolt = <700000>, <850000>;
> +		};
> +
> +		opp-580000000 {
> +			opp-hz = /bits/ 64 <580000000>;
> +			opp-microvolt = <712500>, <850000>;
> +		};
> +
> +		opp-620000000 {
> +			opp-hz = /bits/ 64 <620000000>;
> +			opp-microvolt = <725000>, <850000>;
> +		};
> +
> +		opp-653000000 {
> +			opp-hz = /bits/ 64 <653000000>;
> +			opp-microvolt = <743750>, <850000>;
> +		};
> +
> +		opp-698000000 {
> +			opp-hz = /bits/ 64 <698000000>;
> +			opp-microvolt = <768750>, <868750>;
> +		};
> +
> +		opp-743000000 {
> +			opp-hz = /bits/ 64 <743000000>;
> +			opp-microvolt = <793750>, <893750>;
> +		};
> +
> +		opp-800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt = <825000>, <925000>;
> +		};
> +	};
> +
>  	pmu-a53 {
>  		compatible = "arm,cortex-a53-pmu";
>  		interrupt-parent = <&gic>;
> @@ -1118,6 +1203,26 @@ mfgcfg: syscon@13000000 {
>  			#clock-cells = <1>;
>  		};
>  
> +		gpu: gpu@13040000 {
> +			compatible = "mediatek,mt8183-mali", "arm,mali-bifrost";
> +			reg = <0 0x13040000 0 0x4000>;
> +			interrupts =
> +				<GIC_SPI 280 IRQ_TYPE_LEVEL_LOW>,
> +				<GIC_SPI 279 IRQ_TYPE_LEVEL_LOW>,
> +				<GIC_SPI 278 IRQ_TYPE_LEVEL_LOW>;
> +			interrupt-names = "job", "mmu", "gpu";
> +
> +			clocks = <&topckgen CLK_TOP_MFGPLL_CK>;
> +
> +			power-domains =
> +				<&spm MT8183_POWER_DOMAIN_MFG_CORE0>,
> +				<&spm MT8183_POWER_DOMAIN_MFG_CORE1>,
> +				<&spm MT8183_POWER_DOMAIN_MFG_2D>;
> +			power-domain-names = "core0", "core1", "core2";
> +
> +			operating-points-v2 = <&gpu_opp_table>;
> +		};
> +
>  		mmsys: syscon@14000000 {
>  			compatible = "mediatek,mt8183-mmsys", "syscon";
>  			reg = <0 0x14000000 0 0x1000>;
> 
