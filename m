Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13043E4173
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhHIIQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233853AbhHIIQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:16:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D16E61056;
        Mon,  9 Aug 2021 08:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628496995;
        bh=Uc410ukGR38DA8yxPgvyY/khZPNN121wh2ES85u3arY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5Eg4duG5OszBVXZa1zxa1ps4nf52e8utmvHT1Genz0R8CJbcwbN5i/EBeRUAJU67
         s4vt95iOzyxiJkbrgXkp0YkOFrQuhT0q6OxnCZ1/p48pp/YFBpjzPN8Ixi0Cl/OctU
         k9YoNuILeILl1Go1kgxKatwmu9y9oFc/UcE8LbxipfYijFgu4Lb5/RmUdV/unqvKaA
         pPiiWow0yrge4CmO8Ke2Bw7iaGwyisAHsXRCIybjS+hXGkJyLH156YaU05cqYkaa4n
         ohbA5kG3SfmYGDNZgbafbyU1zlgLDO7y0j536auwDNsz3f55MjyFtW2dZz3iVi7jzU
         IaJ1idaeqaUvw==
Date:   Mon, 9 Aug 2021 16:16:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8qm: add smmu node
Message-ID: <20210809081628.GT30984@dragon>
References: <20210807104517.24066-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807104517.24066-1-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2021 at 06:45:17PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8QM has an iommu unit: SMMU-V2(mmu-500), add it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> index aebbe2b84aa1..b8ffd5be6a3e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> @@ -165,6 +165,22 @@ iomuxc: pinctrl {
>  
>  	};
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

Use macro to make it more readable.

Shawn

> +	};
> +
>  	/* sorted in register address */
>  	#include "imx8-ss-img.dtsi"
>  	#include "imx8-ss-dma.dtsi"
> -- 
> 2.30.0
> 
