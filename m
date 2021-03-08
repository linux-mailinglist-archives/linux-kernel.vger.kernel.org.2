Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6480333054F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 01:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhCHA2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 19:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233353AbhCHA1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 19:27:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68B7D64FB7;
        Mon,  8 Mar 2021 00:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615163275;
        bh=SiK+/6MIOgzcJ2vpx7jERuI8qZ6eOOkh6x7rUIsEf3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8jKtxKemmtg15tBCd70bVQXQL68TquyZyM4OY8xfr8YoMSP8PUVybBiH+iaJqcwV
         trA5jZXvZG+BkeX+fjw9AfTtqpU86sbiB1avdS9mq8U+k4sBWH+M8kSNjpS3kVaGBR
         3D97DpnQ5L/Z0ely8o2zJvSTaBv8zpGP3jQhZp5fmU0JxGdMguKBOK5nwJEb7myVm0
         ejkrLzbIii7sqj75DV/sqyalgCM0N81lzc0TQrADrSbevQ67H/R/jJG67Cu23F3Cwq
         vMKF+8Nn7WDIvABog23nHUku2UkOg1mKDuPDCZkZdFWErn6a/Nf4FekSOCWTMFEOUa
         bZOrzVS0zD5Bw==
Date:   Mon, 8 Mar 2021 08:27:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: imx8m: add pmu node
Message-ID: <20210308002748.GJ543@dragon>
References: <20210223031445.8577-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223031445.8577-1-alice.guo@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 11:14:45AM +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Adding pmu node supports to use perf tool to monitor the CPU performance
> of the inmate cell when enabling Jailhouse and running dual Linux OS.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk-inmate.dts | 7 +++++++

Upstream doesn't have this file.

Shawn

>  arch/arm64/boot/dts/freescale/imx8mn-evk-inmate.dts | 8 ++++++++
>  arch/arm64/boot/dts/freescale/imx8mp-evk-inmate.dts | 8 ++++++++
>  arch/arm64/boot/dts/freescale/imx8mq-evk-inmate.dts | 7 +++++++
>  4 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk-inmate.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk-inmate.dts
> index fe9d96131045..6afccc2c140e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk-inmate.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk-inmate.dts
> @@ -48,6 +48,13 @@
>  		};
>  	};
> 
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7
> +			     (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
> +		interrupt-affinity = <&A53_2>, <&A53_3>;
> +	};
> +
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk-inmate.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk-inmate.dts
> index 584c1fa19f56..f2434ad369dc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk-inmate.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk-inmate.dts
> @@ -48,6 +48,14 @@
>  		};
>  	};
> 
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 7
> +			     (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
> +		interrupt-affinity = <&A53_2>, <&A53_3>;
> +	};
> +
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk-inmate.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk-inmate.dts
> index 277ef70f2903..be538f510340 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk-inmate.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk-inmate.dts
> @@ -48,6 +48,14 @@
>  		};
>  	};
> 
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 7
> +			     (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
> +		interrupt-affinity = <&A53_2>, <&A53_3>;
> +	};
> +
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk-inmate.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk-inmate.dts
> index b1db63cdb98c..57e0ab2bf4d3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk-inmate.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk-inmate.dts
> @@ -48,6 +48,13 @@
>  		};
>  	};
> 
> +	pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-parent = <&gic>;
> +		interrupt-affinity = <&A53_2>, <&A53_3>;
> +	};
> +
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
> --
> 2.17.1
> 
