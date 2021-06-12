Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1143A4D77
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 10:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhFLID1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 04:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhFLIDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 04:03:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54525611C9;
        Sat, 12 Jun 2021 08:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623484886;
        bh=MGNqkWJ1sCuzKDQbg57dAyp2wtRQv0/ZqUAW5Jfi9eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dhu6f1t80BM4fx5b2mO6wlHdXBGlthT6XOhSgqkAmt8IOdwLmNpXNJtjksGG/dybG
         PNwz2Ta0R7x4wytFlhW0XTzEpRyWPxmAelbB2x+LCeDG+jvA+KhDFG5o5q9gDgK2a/
         FY0uj8yopQFSekDsKMMItADEtSw/3zenhISefz2JGlNET8N2iFPCVUMK4gNJIJIOvN
         sBQkOfsn1YZuX0HVsu4yx1yil0u1UyVx09IIt7cjRgnfPb1IawlfKHl+6251YzGwNY
         446jrcH7BXbRWr4L/44/Ad5HssIRzGY9WPW5EwOAHBcJPjyWZRLzOtrqLBH+UCAzSs
         4s/K31XasOS0g==
Date:   Sat, 12 Jun 2021 16:01:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     alice.guo@nxp.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: imx8mx: move soc device into ocotp
Message-ID: <20210612080120.GA29138@dragon>
References: <1623089112-27069-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623089112-27069-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 02:05:12AM +0800, Robin Gong wrote:
> move soc device into ocotp device node instead of the parent device
> of the all devices which located in 'soc@0', otherwise, all probed
> children devices will be reorder to dmp_list again once 'imx8mx-soc'
> device defered probed, which may break driver's suspend/resume sequence,
> such as imx_spdif and fsl_spdif, hence the later would suspended before
> the former as below and endless interrupt may never be handled since
> clock has been disabled already in the later.
> 
> [    1.930598] calling  fsl_spdif_driver_init+0x0/0x20 @ 1
> [    1.955712] initcall fsl_spdif_driver_init+0x0/0x20 returned 0 after 24512 usecs
> [    1.981963] calling  imx_spdif_driver_init+0x0/0x20 @ 1
> [    1.986600] initcall imx_spdif_driver_init+0x0/0x20 returned 0 after 4509 usecs
> [    2.901408]   #0: imx-spdif
> [   21.151529] fsl-spdif-dai 30090000.spdif: calling platform_pm_suspend+0x0/0x70 @ 470, parent: 30000000.bus
> [   21.161189] fsl-spdif-dai 30090000.spdif: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
> [   21.474311] imx-spdif sound-spdif: calling platform_pm_suspend+0x0/0x70 @ 470, parent: platform
> [   21.483024] imx-spdif sound-spdif: platform_pm_suspend+0x0/0x70 returned 0 after 9 usecs

DT is written as a description of hardware, not for resolving Linux
specific issue.

Shawn

> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 12 ++++++++----
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 13 +++++++++----
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++----
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 12 ++++++++----
>  4 files changed, 34 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index e7648c3..9ef0554 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -257,13 +257,11 @@
>  	};
>  
>  	soc@0 {
> -		compatible = "fsl,imx8mm-soc", "simple-bus";
> +		compatible = "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0x0 0x0 0x0 0x3e000000>;
>  		dma-ranges = <0x40000000 0x0 0x40000000 0xc0000000>;
> -		nvmem-cells = <&imx8mm_uid>;
> -		nvmem-cell-names = "soc_unique_id";
>  
>  		aips1: bus@30000000 {
>  			compatible = "fsl,aips-bus", "simple-bus";
> @@ -522,7 +520,7 @@
>  			};
>  
>  			ocotp: efuse@30350000 {
> -				compatible = "fsl,imx8mm-ocotp", "syscon";
> +				compatible = "fsl,imx8mm-ocotp", "syscon", "simple-mfd";
>  				reg = <0x30350000 0x10000>;
>  				clocks = <&clk IMX8MM_CLK_OCOTP_ROOT>;
>  				/* For nvmem subnodes */
> @@ -540,6 +538,12 @@
>  				fec_mac_address: mac-address@90 {
>  					reg = <0x90 6>;
>  				};
> +
> +				imx8mm_soc: imx8mm-soc {
> +					compatible = "fsl,imx8mm-soc";
> +					nvmem-cells = <&imx8mm_uid>;
> +					nvmem-cell-names = "soc_unique_id";
> +				};
>  			};
>  
>  			anatop: anatop@30360000 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index d4231e0..f82905c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -241,13 +241,11 @@
>  	};
>  
>  	soc@0 {
> -		compatible = "fsl,imx8mn-soc", "simple-bus";
> +		compatible = "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0x0 0x0 0x0 0x3e000000>;
>  		dma-ranges = <0x40000000 0x0 0x40000000 0xc0000000>;
> -		nvmem-cells = <&imx8mn_uid>;
> -		nvmem-cell-names = "soc_unique_id";
>  
>  		aips1: bus@30000000 {
>  			compatible = "fsl,aips-bus", "simple-bus";
> @@ -528,7 +526,8 @@
>  			};
>  
>  			ocotp: efuse@30350000 {
> -				compatible = "fsl,imx8mn-ocotp", "fsl,imx8mm-ocotp", "syscon";
> +				compatible = "fsl,imx8mn-ocotp", "fsl,imx8mm-ocotp", "syscon",
> +						"simple-mfd";
>  				reg = <0x30350000 0x10000>;
>  				clocks = <&clk IMX8MN_CLK_OCOTP_ROOT>;
>  				#address-cells = <1>;
> @@ -545,6 +544,12 @@
>  				fec_mac_address: mac-address@90 {
>  					reg = <0x90 6>;
>  				};
> +
> +				imx8mn_soc: imx8mn-soc {
> +					compatible = "fsl,imx8mn-soc";
> +					nvmem-cells = <&imx8mn_uid>;
> +					nvmem-cell-names = "soc_unique_id";
> +				};
>  			};
>  
>  			anatop: anatop@30360000 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 9f7c7f5..d113691 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -220,12 +220,10 @@
>  	};
>  
>  	soc@0 {
> -		compatible = "fsl,imx8mp-soc", "simple-bus";
> +		compatible = "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0x0 0x0 0x0 0x3e000000>;
> -		nvmem-cells = <&imx8mp_uid>;
> -		nvmem-cell-names = "soc_unique_id";
>  
>  		aips1: bus@30000000 {
>  			compatible = "fsl,aips-bus", "simple-bus";
> @@ -341,7 +339,8 @@
>  			};
>  
>  			ocotp: efuse@30350000 {
> -				compatible = "fsl,imx8mp-ocotp", "fsl,imx8mm-ocotp", "syscon";
> +				compatible = "fsl,imx8mp-ocotp", "fsl,imx8mm-ocotp", "syscon",
> +						"simple-mfd";
>  				reg = <0x30350000 0x10000>;
>  				clocks = <&clk IMX8MP_CLK_OCOTP_ROOT>;
>  				/* For nvmem subnodes */
> @@ -359,6 +358,12 @@
>  				eth_mac1: mac-address@90 {
>  					reg = <0x90 6>;
>  				};
> +
> +				imx8mp_soc: imx8mp-soc {
> +					compatible = "fsl,imx8mp-soc";
> +					nvmem-cells = <&imx8mp_uid>;
> +					nvmem-cell-names = "soc_unique_id";
> +				};
>  			};
>  
>  			anatop: anatop@30360000 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 91df9c5..8cfbc77 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -287,13 +287,11 @@
>  	};
>  
>  	soc@0 {
> -		compatible = "fsl,imx8mq-soc", "simple-bus";
> +		compatible = "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0x0 0x0 0x0 0x3e000000>;
>  		dma-ranges = <0x40000000 0x0 0x40000000 0xc0000000>;
> -		nvmem-cells = <&imx8mq_uid>;
> -		nvmem-cell-names = "soc_unique_id";
>  
>  		bus@30000000 { /* AIPS1 */
>  			compatible = "fsl,aips-bus", "simple-bus";
> @@ -554,7 +552,7 @@
>  			};
>  
>  			ocotp: efuse@30350000 {
> -				compatible = "fsl,imx8mq-ocotp", "syscon";
> +				compatible = "fsl,imx8mq-ocotp", "syscon", "simple-mfd";
>  				reg = <0x30350000 0x10000>;
>  				clocks = <&clk IMX8MQ_CLK_OCOTP_ROOT>;
>  				#address-cells = <1>;
> @@ -571,6 +569,12 @@
>  				fec_mac_address: mac-address@90 {
>  					reg = <0x90 6>;
>  				};
> +
> +				imx8mq_soc: imx8mq-soc {
> +					compatible = "fsl,imx8mq-soc";
> +					nvmem-cells = <&imx8mq_uid>;
> +					nvmem-cell-names = "soc_unique_id";
> +				};
>  			};
>  
>  			anatop: syscon@30360000 {
> -- 
> 2.7.4
> 
