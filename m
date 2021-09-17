Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2F40F6FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243027AbhIQMCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:02:38 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54960 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242369AbhIQMCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:02:36 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mRCYK-0005JE-GG; Fri, 17 Sep 2021 14:01:12 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH] arm64: dts: rockchip: move aliases to rk356x dtsi
Date:   Fri, 17 Sep 2021 14:01:11 +0200
Message-ID: <2397289.mVTDCA6dLn@diego>
In-Reply-To: <20210917110528.24454-1-michael.riesch@wolfvision.net>
References: <20210917110528.24454-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Am Freitag, 17. September 2021, 13:05:28 CEST schrieb Michael Riesch:
> In order to ensure deterministic probe order over different boards,
> move the aliases of on-SoC components to the corresponding dtsi
> files.

please read the git history on the other Rockchip SoCs. We just moved
the aliases on them _to_ the board-files, as requested by
arm-soc maintainers ;-)


Heiko


> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 6 ------
>  arch/arm64/boot/dts/rockchip/rk3566.dtsi           | 4 ++++
>  arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts   | 7 -------
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi           | 5 +++++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi           | 2 ++
>  5 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> index a244f7b87e38..156bbb8aa4c4 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> @@ -10,12 +10,6 @@
>  	model = "Pine64 RK3566 Quartz64-A Board";
>  	compatible = "pine64,quartz64-a", "rockchip,rk3566";
>  
> -	aliases {
> -		ethernet0 = &gmac1;
> -		mmc0 = &sdmmc0;
> -		mmc1 = &sdhci;
> -	};
> -
>  	chosen: chosen {
>  		stdout-path = "serial2:1500000n8";
>  	};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> index 3839eef5e4f7..c1b3841caa77 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> @@ -4,6 +4,10 @@
>  
>  / {
>  	compatible = "rockchip,rk3566";
> +
> +	aliases {
> +		ethernet0 = &gmac1;
> +	};
>  };
>  
>  &power {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> index 184e2aa2416a..218f85af730c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> @@ -13,13 +13,6 @@
>  	model = "Rockchip RK3568 EVB1 DDR4 V10 Board";
>  	compatible = "rockchip,rk3568-evb1-v10", "rockchip,rk3568";
>  
> -	aliases {
> -		ethernet0 = &gmac0;
> -		ethernet1 = &gmac1;
> -		mmc0 = &sdmmc0;
> -		mmc1 = &sdhci;
> -	};
> -
>  	chosen: chosen {
>  		stdout-path = "serial2:1500000n8";
>  	};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 2fd313a295f8..dd0e800cf752 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -8,6 +8,11 @@
>  / {
>  	compatible = "rockchip,rk3568";
>  
> +	aliases {
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +	};
> +
>  	qos_pcie3x1: qos@fe190080 {
>  		compatible = "rockchip,rk3568-qos", "syscon";
>  		reg = <0x0 0xfe190080 0x0 0x20>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index e42fbac6147b..bb0540d3008c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -29,6 +29,8 @@
>  		i2c3 = &i2c3;
>  		i2c4 = &i2c4;
>  		i2c5 = &i2c5;
> +		mmc0 = &sdmmc0;
> +		mmc1 = &sdhci;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
>  		serial2 = &uart2;
> 




