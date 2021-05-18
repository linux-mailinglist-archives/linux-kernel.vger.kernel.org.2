Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6EC38784E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349027AbhERMDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:03:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37180 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348965AbhERMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:02:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14IC1Xoe022496;
        Tue, 18 May 2021 07:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621339293;
        bh=1lel3gH0yK6JEo4QIhQRWSw3/QbFc7G9njZHvEgNBFE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xPC0UHk/RcfYKAVu0CpYyg7/EPR7Bxsui16JxeuFrrOLdQFmlGN22+PQGkLiyEddR
         QklKyWyrltKOgpKefdtRqT3NdHTM5SZh6H9oGeMiG9XXI6w1qhxIidIPDzTVmfACgs
         FZuW/8cQpxu+NE0ISYgTifkbV3+KkjI/r2hTjgXk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14IC1XgD126896
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 May 2021 07:01:33 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 18
 May 2021 07:01:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 18 May 2021 07:01:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14IC1X7v021298;
        Tue, 18 May 2021 07:01:33 -0500
Date:   Tue, 18 May 2021 07:01:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Gowtham Tammana <g-tammana@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64-main: Enable crypto
 accelerator
Message-ID: <20210518120133.73qmsd6uu6dwtjfu@backshift>
References: <20210518062630.144154-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210518062630.144154-1-vaibhavgupta40@gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:56-20210518, Vaibhav Gupta wrote:
> From: Vaibhav Gupta <v_gupta@ti.com>
> 
> Add the node for SA2UL including the random number generator.
> 
> [v_gupta@ti.com: Add address ranges entry in cbass_main]
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Vaibhav Gupta <v_gupta@ti.com>


I see that you have missed the series Suman posted in [1]. It has a few
cleanups of interest.

> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 25 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am64.dtsi      |  1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 25b702303637..adbc3c0673f3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -160,6 +160,31 @@ k3_reset: reset-controller {
>  		};
>  	};
>  
> +	main_crypto: crypto@40900000 {
> +		compatible = "ti,am64-sa2ul";
> +		reg = <0x0 0x40900000 0x0 0x1200>;
> +		power-domains = <&k3_pds 133 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 133 0>, <&k3_clks 133 1>, <&k3_clks 133 2>;
> +		clock-names = "pka_in_clk" , "x1_clk" , "x2_clk";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x0 0x040900000 0x00 0x040900000 0x0 0x30000>;
> +
> +		status = "okay";
drop this..
> +
> +		dmas = <&main_pktdma 0xc001 15>, <&main_pktdma 0x4002 15>,
> +				<&main_pktdma 0x4003 15>;
> +		dma-names = "tx", "rx1", "rx2";
> +
> +		eip76d_rng: rng@40910000 {
> +			compatible = "inside-secure,safexcel-eip76";
> +			reg = <0x0 0x40910000 0x0 0x80>;
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&k3_clks 133 2>;
> +			clock-names = "x2_clk";
> +		};
> +	};
> +
>  	main_pmx0: pinctrl@f4000 {
>  		compatible = "pinctrl-single";
>  		reg = <0x00 0xf4000 0x00 0x2d0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
> index 0ae8c844c482..e2bea44a16c5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
> @@ -85,6 +85,7 @@ cbass_main: bus@f4000 {
>  			 <0x00 0x78000000 0x00 0x78000000 0x00 0x00800000>, /* Main R5FSS */
>  			 <0x06 0x00000000 0x06 0x00000000 0x01 0x00000000>, /* PCIe DAT1 */
>  			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
> +			 <0x00 0x40900000 0x00 0x40900000 0x00 0x00030000>, /* SA2UL */
>  
>  			 /* MCU Domain Range */
>  			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>;


I think you might have missed the discussion here:[1]
a) Could I suggest you co-ordinate with Suman as to which series should
   I consider? Suman's looks a lot complete..
b) Considering the potential for TF-A booting Linux without u-boot on HS
   devices, may I suggest making sure that the dts board files for evm have the
   nodes disabled by default?

[1] https://lore.kernel.org/linux-arm-kernel/20210514221148.m42zldo6lfxn5l4m@underfed/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
