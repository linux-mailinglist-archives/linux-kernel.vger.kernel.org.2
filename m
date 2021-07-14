Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59B3C8641
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhGNOk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:40:58 -0400
Received: from foss.arm.com ([217.140.110.172]:35658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231977AbhGNOk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:40:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9951C31B;
        Wed, 14 Jul 2021 07:38:05 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBDF53F694;
        Wed, 14 Jul 2021 07:38:03 -0700 (PDT)
Subject: Re: [PATCH v1] arm64: dts: imx8qm: added System MMU
To:     Oliver Graute <oliver.graute@kococonnector.com>,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, aisheng.dong@nxp.com,
        fabio.estevam@nxp.com, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210714120925.23571-1-oliver.graute@kococonnector.com>
 <20210714120925.23571-3-oliver.graute@kococonnector.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d10b6230-6a7d-05c9-47ec-6defe840d827@arm.com>
Date:   Wed, 14 Jul 2021 15:37:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714120925.23571-3-oliver.graute@kococonnector.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-14 13:09, Oliver Graute wrote:
> added node for System MMU

Note that it's a bit of a dangerous game to enable an SMMU without the 
complete Stream ID topology for *all* its upstream devices also 
described, since CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT will ruin 
peoples' day. It might be more polite to add it in a disabled state 
until every "iommus" property has been filled in, so that people who do 
want to play with it for specific devices in the meantime can easily 
just flip the status (while taking the necessary precautions), but 
people who don't care won't be inadvertently affected regardless of 
their kernel config. I'm assuming an SMMU with 32 contexts has more than 
a single USB controller behind it...

Robin.

> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> ---
>   arch/arm64/boot/dts/freescale/imx8qm.dtsi | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> index 7efc0add74ea..fa827ed04e09 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> @@ -140,6 +140,23 @@
>   		method = "smc";
>   	};
>   
> +	smmu: iommu@51400000 {
> +		compatible = "arm,mmu-500";
> +		interrupt-parent = <&gic>;
> +		reg = <0 0x51400000 0 0x40000>;
> +		#global-interrupts = <1>;
> +		#iommu-cells = <2>;
> +		interrupts = <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>;
> +	};
> +
>   	timer {
>   		compatible = "arm,armv8-timer";
>   		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
> 
