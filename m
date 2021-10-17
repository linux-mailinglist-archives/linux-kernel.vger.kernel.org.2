Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2944307CE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 12:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbhJQKPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 06:15:43 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50660 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232218AbhJQKPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 06:15:42 -0400
Received: from p508fd4f7.dip0.t-ipconnect.de ([80.143.212.247] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mc3AW-0002VM-QE; Sun, 17 Oct 2021 12:13:28 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add idle cooling devices
Date:   Sun, 17 Oct 2021 12:13:27 +0200
Message-ID: <2808512.kKcWQYovEV@phil>
In-Reply-To: <20211001161728.1729664-1-daniel.lezcano@linaro.org>
References: <20211001161728.1729664-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am Freitag, 1. Oktober 2021, 18:17:28 CEST schrieb Daniel Lezcano:
> The thermal framework accepts now the cpu idle cooling device as an
> alternative when the cpufreq cooling device fails.
> 
> Add the node in the DT so the cooling devices will be present and the
> platforms can extend the thermal zone definition to add them.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 3871c7fd83b0..9ac232ffd284 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -124,6 +124,11 @@ cpu_b0: cpu@100 {
>  			#cooling-cells = <2>; /* min followed by max */
>  			dynamic-power-coefficient = <436>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			thermal-idle {
> +				#cooling-cells = <2>;
> +				duration-us = <10000>;
> +				exit-latency-us = <500>;
> +			};

I guess the basic question would be where do the duration
and exit-latency values come from. And also what happened
to cpu_l0-l3 (aka the little cores)?

Heiko

>  		};
>  
>  		cpu_b1: cpu@101 {
> @@ -136,6 +141,11 @@ cpu_b1: cpu@101 {
>  			#cooling-cells = <2>; /* min followed by max */
>  			dynamic-power-coefficient = <436>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			thermal-idle {
> +				#cooling-cells = <2>;
> +				duration-us = <10000>;
> +				exit-latency-us = <500>;
> +			};
>  		};
>  
>  		idle-states {
> 




