Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98B1365C48
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhDTPe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhDTPe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:34:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA1C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:33:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j5so37116010wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2RUcpYL/40xZk/Fwbeu/5LDtsqSdVxolXOdE5oj/SaE=;
        b=jW47qVb6Sff7g5KDuO7kOczbtJ5s5+TLXXsMdeI166bWCOqCuoQj7VR9abtIsYgTIy
         YfKtSbCeXok6vje9cNwY93AibypKuQ4Or8ZoZs59Y+VXChEkWRPrNkAo9p/qGMcGLt1Y
         91oJxfHsMbelUceeOO5BRvIXHirptUPRCIIRRbc79MZfze20JlZW/dVNHd4T92yeMXsw
         IKhPqXVFCVqDcWWiINRVTM45twBj2WUlYeEpLOeg4sT/H+bFiFqHYUzFl2wCzDdldidH
         6fBYuwKtM8c/bgoEZvSXo58vPe47cIzuLiukkqtUQgYBYEd+iZS8wXsZH0pdmNC9WsAy
         O/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2RUcpYL/40xZk/Fwbeu/5LDtsqSdVxolXOdE5oj/SaE=;
        b=LkDSKmyP4zYka63AQIyEMjMQxQ1uB25y+sYWI58wvg99OKmAXrZtLf4Ur7PByvTMZk
         O09SveFIquJrBdt3LpC7yUjGa5GDMO8d+GccRR0oCPe/srGNfOlmegiwSNq8PjUYWev7
         J2PaXoXOTNJJbKZ+un/I8VeeVko7TZkRdhbZzzUH6DofiiGxRcGrccNXmCAvIrG/rHOc
         /GbPC0OgjlqN+1zs7KlD3zPhBH6fAyMDdRS6YwH6tZdcKDTEr74IPnhrEYaccGU033Qf
         jUz3iaLbOn2s7OjIPz4CVki7WMHsf7QHBvAAisrakpBQtQoctOGRbzSD4X/1tLLrhbm9
         MF5g==
X-Gm-Message-State: AOAM533wH9LicQfbBeocd6xGAltdzQUiNwSi9+qKgtF6eID2TCEIw3GB
        t/ogtRoX8UhCypczkW0Z3NjoYw==
X-Google-Smtp-Source: ABdhPJy5l0gIuB65i1nz6DiiogsfamvF/J/BoQblaMJkVSqvHrVhib9McmSo7ecHx7lP56sGnoOphw==
X-Received: by 2002:adf:b1d3:: with SMTP id r19mr22055115wra.97.1618932834092;
        Tue, 20 Apr 2021 08:33:54 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:b4:316d:263e:1360? ([2a01:e0a:90c:e290:b4:316d:263e:1360])
        by smtp.gmail.com with ESMTPSA id p18sm26966711wrs.68.2021.04.20.08.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 08:33:53 -0700 (PDT)
Subject: Re: [PATCH v11 2/4] arm64: dts: mt8183: Add node for the Mali GPU
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     devicetree@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>, fshao@chromium.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        boris.brezillon@collabora.com, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org, Matthias Brugger <matthias.bgg@gmail.com>,
        hoegsberg@chromium.org, linux-arm-kernel@lists.infradead.org
References: <20210126011759.1605641-1-drinkcat@chromium.org>
 <20210126091747.v11.2.I9f45f5c1f975422d58b5904d11546349e9ccdc94@changeid>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <1a37f9be-8ec8-893a-e2fc-f0739948f71f@baylibre.com>
Date:   Tue, 20 Apr 2021 17:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210126091747.v11.2.I9f45f5c1f975422d58b5904d11546349e9ccdc94@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2021 02:17, Nicolas Boichat wrote:
> Add a basic GPU node for mt8183.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
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
> Changes in v11:
>  - mt8183*.dts: remove incorrect supply-names
> 
> Changes in v10: None
> Changes in v9: None
> Changes in v8: None
> Changes in v7: None
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
> Changes in v3: None
> Changes in v2:
>  - Use sram instead of mali_sram as SRAM supply name.
>  - Rename mali@ to gpu@.
> 
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   5 +
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   5 +
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 105 ++++++++++++++++++
>  3 files changed, 115 insertions(+)
> 

If you re-spin, you can also add the same changes to mt8183-pumpkin.dts :
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index eb6e595c2975..cc23e5df391e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -68,6 +68,11 @@ &auxadc {
        status = "okay";
 };

+&gpu {
+       mali-supply = <&mt6358_vgpu_reg>;
+       sram-supply = <&mt6358_vsram_gpu_reg>;
+};
+
 &i2c0 {
        pinctrl-names = "default";
        pinctrl-0 = <&i2c_pins_0>;

I did a boot-test of the platform with panfrost and drm-misc-next and it worked fine.

Thanks,
Neil

> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> index cba2d8933e79..1cfbea5a0101 100644
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
> index bf2ad1294dd3..a38315b604df 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -249,6 +249,11 @@ &cpu7 {
>  	proc-supply = <&mt6358_vproc11_reg>;
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
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 5b782a4769e7..5430e05e18a0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -964,6 +964,111 @@ mfgcfg: syscon@13000000 {
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
> +		gpu_opp_table: opp_table0 {
> +			compatible = "operating-points-v2";
> +			opp-shared;
> +
> +			opp-300000000 {
> +				opp-hz = /bits/ 64 <300000000>;
> +				opp-microvolt = <625000>, <850000>;
> +			};
> +
> +			opp-320000000 {
> +				opp-hz = /bits/ 64 <320000000>;
> +				opp-microvolt = <631250>, <850000>;
> +			};
> +
> +			opp-340000000 {
> +				opp-hz = /bits/ 64 <340000000>;
> +				opp-microvolt = <637500>, <850000>;
> +			};
> +
> +			opp-360000000 {
> +				opp-hz = /bits/ 64 <360000000>;
> +				opp-microvolt = <643750>, <850000>;
> +			};
> +
> +			opp-380000000 {
> +				opp-hz = /bits/ 64 <380000000>;
> +				opp-microvolt = <650000>, <850000>;
> +			};
> +
> +			opp-400000000 {
> +				opp-hz = /bits/ 64 <400000000>;
> +				opp-microvolt = <656250>, <850000>;
> +			};
> +
> +			opp-420000000 {
> +				opp-hz = /bits/ 64 <420000000>;
> +				opp-microvolt = <662500>, <850000>;
> +			};
> +
> +			opp-460000000 {
> +				opp-hz = /bits/ 64 <460000000>;
> +				opp-microvolt = <675000>, <850000>;
> +			};
> +
> +			opp-500000000 {
> +				opp-hz = /bits/ 64 <500000000>;
> +				opp-microvolt = <687500>, <850000>;
> +			};
> +
> +			opp-540000000 {
> +				opp-hz = /bits/ 64 <540000000>;
> +				opp-microvolt = <700000>, <850000>;
> +			};
> +
> +			opp-580000000 {
> +				opp-hz = /bits/ 64 <580000000>;
> +				opp-microvolt = <712500>, <850000>;
> +			};
> +
> +			opp-620000000 {
> +				opp-hz = /bits/ 64 <620000000>;
> +				opp-microvolt = <725000>, <850000>;
> +			};
> +
> +			opp-653000000 {
> +				opp-hz = /bits/ 64 <653000000>;
> +				opp-microvolt = <743750>, <850000>;
> +			};
> +
> +			opp-698000000 {
> +				opp-hz = /bits/ 64 <698000000>;
> +				opp-microvolt = <768750>, <868750>;
> +			};
> +
> +			opp-743000000 {
> +				opp-hz = /bits/ 64 <743000000>;
> +				opp-microvolt = <793750>, <893750>;
> +			};
> +
> +			opp-800000000 {
> +				opp-hz = /bits/ 64 <800000000>;
> +				opp-microvolt = <825000>, <925000>;
> +			};
> +		};
> +
>  		mmsys: syscon@14000000 {
>  			compatible = "mediatek,mt8183-mmsys", "syscon";
>  			reg = <0 0x14000000 0 0x1000>;
> 

