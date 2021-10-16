Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD43D4304F3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 22:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244627AbhJPUrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 16:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244610AbhJPUrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 16:47:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E162C061765;
        Sat, 16 Oct 2021 13:45:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t16so52856418eds.9;
        Sat, 16 Oct 2021 13:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fu6K+GZ9xLTyYQLWrFx/0iIfiXjMLM2SCui+AM5Mbc8=;
        b=EFsqsAQxpJ3zv4WS4UTsCRibnv+ZDvvFCNY8B88DNPA3Hg0228WduKQBy83yXToYgf
         RygtHGEhxO6hGgo+DFFM2XGvskm7IBch+qwS0bp3dvYtLIcQ5rOukHvsEu03i27mg5pM
         l/tbDS3bK4KswEDlaJHySDXZoXA0RfTF+9DeJEZGSILJ9zSPYE+Q8H+vpIWDnwbAY5Qc
         4jaTE0HL39cXS3n9FIMGE78scOu0GXQgF60J5uasku0TOQPelRk9/7N5UL4asH2rCX7k
         ms8rHDqdt9J7vPkJljLxC7gSJqT963YJUfaGgtwwi8Sc1lD1khbuLId1BwYNMmA4Dvjm
         0cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fu6K+GZ9xLTyYQLWrFx/0iIfiXjMLM2SCui+AM5Mbc8=;
        b=IZDUjVpnkLU1gGWj/FmM8pPzD5mUbJHSAiJUFnuAztZ7iPazjaVa0zDbGSJSGYeDT4
         HSKqcZ+KYows/RPUEgWa1JZK1EhUHJ7RG7/1WoHvCtIr3OIvOS5clwVoVUZWcGmsgPCV
         XSmr6FqImxZ6Nf4lBggPa+2kmkXUFh517KUeAnn5ORj3yzkFpkCOR9zZMLxbdb6RQzgS
         nwWin7onmJyVoJ/pVjYjKpZvLp4hU8x7SeBX0gDh7BNC3EuljXNvRi5OgHftM26WUfWG
         +RUUcYrVMaFi92CZdhn8t9egJWfaDOnfDI/HCtJHJM9pJDS0Y04xHZw6EgUYCji21ri9
         T9QA==
X-Gm-Message-State: AOAM5308txN7ud6H+aOeN1EoiqiW6TEmxIxym2mJ2eazI0wZ9MF8TgBp
        NfEehYY+9NlG2ggBmZNAM94=
X-Google-Smtp-Source: ABdhPJxVlU9ZEpsGINQGU1CkZIrC2ZhGVPrpYYA3Kwhv3wXmwq8NH815+a9NppEBqb1jqkXwZ8FXUQ==
X-Received: by 2002:aa7:cd8b:: with SMTP id x11mr29824268edv.384.1634417106073;
        Sat, 16 Oct 2021 13:45:06 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i10sm7542783edl.15.2021.10.16.13.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 13:45:05 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64: dts: rk3328: add gpu opp table
To:     Trevor Woerner <twoerner@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        David Wu <david.wu@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Cameron Nemo <cnemo@tutanota.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
References: <20211016154548.29555-1-twoerner@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <67c7c3c6-b946-a6bc-24fd-85f56bcec7f3@gmail.com>
Date:   Sat, 16 Oct 2021 22:45:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211016154548.29555-1-twoerner@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/21 5:45 PM, Trevor Woerner wrote:
> Add an operating-points table and cooling entry to the GPU on the
> RK3328 SoC to improve its performance. According to its datasheet[1]
> the maximum frequency of the Mali-450 MP2 GPU found on the RK3328 SoC
> is 500MHz.
> 
> On my rock64 device, under x11, glmark2-es2 performance increased from
> around 60 to just over 100. Same device running glmark2-es2 under
> wayland/weston improved from just over 100 to just over 200.
> 
> [1] https://rockchip.fr/RK3328%20datasheet%20V1.2.pdf
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 26 +++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index 8c821acb21ff..5e1dcf71e414 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -532,7 +532,8 @@ map0 {
>  					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>  							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>  							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  					contribution = <4096>;
>  				};
>  			};
> @@ -617,6 +618,29 @@ gpu: gpu@ff300000 {
>  		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
>  		clock-names = "bus", "core";
>  		resets = <&cru SRST_GPU_A>;
> +		operating-points-v2 = <&gpu_opp_table>;
> +		#cooling-cells = <2>;
> +	};
> +

> +	gpu_opp_table: gpu-opp-table {

After the conversion to YAML of the Operating Performance Points(OPP)
binding the operating-points-v2 property expects the nodename to have
the '^opp-table(-[a-z0-9]+)?$' format.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/opp/opp-v2.yaml

> +		compatible = "operating-points-v2";
> +
> +		opp-200000000 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <1100000>;
> +		};
> +		opp-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			opp-microvolt = <1100000>;
> +		};
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-microvolt = <1100000>;
> +		};
> +		opp-500000000 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			opp-microvolt = <1100000>;
> +		};
>  	};

opp-microvolt has the same value for every node vs. table below?

See also previous discussion:

https://lore.kernel.org/linux-rockchip/3c95c29b-6c07-5945-ac22-d683997e1ca0@arm.com/

Is that now fixed/checked?

Copy from manufacturer tree:

	gpu_opp_table: gpu-opp-table {
		compatible = "operating-points-v2";

		rockchip,leakage-voltage-sel = <
			1   10    0
			11  254   1
		>;
		nvmem-cells = <&logic_leakage>;
		nvmem-cell-names = "gpu_leakage";

		opp-200000000 {
			opp-hz = /bits/ 64 <200000000>;
			opp-microvolt = <950000>;
			opp-microvolt-L0 = <950000>;
			opp-microvolt-L1 = <950000>;
		};
		opp-300000000 {
			opp-hz = /bits/ 64 <300000000>;
			opp-microvolt = <975000>;
			opp-microvolt-L0 = <975000>;
			opp-microvolt-L1 = <950000>;
		};
		opp-400000000 {
			opp-hz = /bits/ 64 <400000000>;
			opp-microvolt = <1050000>;
			opp-microvolt-L0 = <1050000>;
			opp-microvolt-L1 = <1025000>;
		};
		opp-500000000 {
			opp-hz = /bits/ 64 <500000000>;
			opp-microvolt = <1150000>;
			opp-microvolt-L0 = <1150000>;
			opp-microvolt-L1 = <1100000>;
		};
	};
>  
>  	h265e_mmu: iommu@ff330200 {
> 
