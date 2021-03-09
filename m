Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E841333266C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhCINRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:17:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35270 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCINRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:17:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129DH4rK009351;
        Tue, 9 Mar 2021 07:17:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615295824;
        bh=AjPtZIF0wddKrmfcHbmIFLOGj6T5JDk3vhSc61d801k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=VdkajMbZwEqXQEz3UfK/OMvr+cMKJdVVBYFgfzXONX6UH+X/x2HholTYWV1GKnJQZ
         sNxQfYjCTogUc6wA2hmtEyQqolTmbbmBzkuNfgyIeWobDSrphI+jrUH4Chsrq/jvFe
         39cSenMzhGqn3RAuOUunMDOgYT+xViDdUkeoUO+s=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129DH47D019037
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 07:17:04 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 07:17:03 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 9 Mar 2021 07:17:03 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129DH3XI081818;
        Tue, 9 Mar 2021 07:17:03 -0600
Date:   Tue, 9 Mar 2021 18:47:02 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am64-main: Add OSPI node
Message-ID: <20210309131702.szl6kjiyn746xyf5@ti.com>
References: <20210309130514.11740-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210309130514.11740-1-vigneshr@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/21 06:35PM, Vignesh Raghavendra wrote:
> AM64 SoC has a single Octal SPI (OSPI) instance under Flash SubSystem
> (FSS).  Add DT entry for the same.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> ---
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
> -- 
> 2.30.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
