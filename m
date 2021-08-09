Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4DD3E450A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbhHILpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:45:03 -0400
Received: from foss.arm.com ([217.140.110.172]:58992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233512AbhHILpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:45:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 756896D;
        Mon,  9 Aug 2021 04:44:41 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03CB93F40C;
        Mon,  9 Aug 2021 04:44:37 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: imx8qm: add smmu node
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20210807104517.24066-1-peng.fan@oss.nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <57fc0247-808d-1c83-2ec9-840a48af025a@arm.com>
Date:   Mon, 9 Aug 2021 12:44:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210807104517.24066-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-07 11:45, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8QM has an iommu unit: SMMU-V2(mmu-500), add it.

Given CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT, you may want to add 
this in a disabled state until you've filled in all the "iommus" 
properties for the client devices. Otherwise, be prepared to hear from 
people reporting issues bisected to this patch ;)

Robin.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   arch/arm64/boot/dts/freescale/imx8qm.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> index aebbe2b84aa1..b8ffd5be6a3e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> @@ -165,6 +165,22 @@ iomuxc: pinctrl {
>   
>   	};
>   
> +	smmu: iommu@51400000 {
> +		compatible = "arm,mmu-500";
> +		reg = <0 0x51400000 0 0x40000>;
> +		#iommu-cells = <2>;
> +		#global-interrupts = <1>;
> +		interrupts = <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> +			     <0 32 4>;
> +	};
> +
>   	/* sorted in register address */
>   	#include "imx8-ss-img.dtsi"
>   	#include "imx8-ss-dma.dtsi"
> 
