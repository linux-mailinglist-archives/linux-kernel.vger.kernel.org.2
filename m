Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2868633453B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhCJRfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:35:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45368 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhCJRen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:34:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AHYYgw031257;
        Wed, 10 Mar 2021 11:34:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615397674;
        bh=+p/u5nK7EFO7bfVybM8fCJ8w2Wt1hcRrMflilr6AVio=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wFUSYIKCVYBr5Py1sIWj8f78LeXi1A3J1CpR/jcgdhvrSVy/hSEIcCKbuPLK6LRFd
         eKNA+SKSd+NtIvBDgIKfSyM+pCXnx/dYlxqPRJdpjWNqz7AElfLkjHYLbUAzqDDBzO
         mOXdXKlZJxsEcFcnMUsDdBAwJmy0YL7ialPV1/3Y=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AHYY1m021998
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 11:34:34 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 11:34:33 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 11:34:33 -0600
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AHYU6K009051;
        Wed, 10 Mar 2021 11:34:31 -0600
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am64-main: Add OSPI node
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210309130514.11740-1-vigneshr@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <4a41ecf2-2203-f3db-f728-fc0d1b0426c6@ti.com>
Date:   Wed, 10 Mar 2021 23:04:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309130514.11740-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth

On 3/9/21 6:35 PM, Vignesh Raghavendra wrote:
> AM64 SoC has a single Octal SPI (OSPI) instance under Flash SubSystem
> (FSS).  Add DT entry for the same.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---

Please ignore the series. I see some instabilities in my testing... Will
repost once I have addressed them. Sorry for the noise.


Regards
Vignesh

>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 25 ++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 5f85950daef7..bcec4fa444b5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -402,4 +402,29 @@ sdhci1: mmc@fa00000 {
>  		ti,otap-del-sel-ddr50 = <0x9>;
>  		ti,clkbuf-sel = <0x7>;
>  	};
> +
> +	fss: bus@fc00000 {
> +		compatible = "simple-bus";
> +		reg = <0x00 0x0fc00000 0x00 0x70000>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ospi0: spi@fc40000 {
> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
> +			reg = <0x00 0x0fc40000 0x00 0x100>,
> +			      <0x05 0x00000000 0x01 0x00000000>;
> +			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> +			cdns,fifo-depth = <256>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x0>;
> +			#address-cells = <0x1>;
> +			#size-cells = <0x0>;
> +			clocks = <&k3_clks 75 6>;
> +			assigned-clocks = <&k3_clks 75 6>;
> +			assigned-clock-parents = <&k3_clks 75 7>;
> +			assigned-clock-rates = <166666666>;
> +			power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
> +		};
> +	};
>  };
> 
