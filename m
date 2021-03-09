Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8683332B69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhCIQDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:03:52 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54496 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhCIQDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:03:19 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129G3Beh028524;
        Tue, 9 Mar 2021 10:03:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615305791;
        bh=4hhxkjA1GUSlJ4fSgkfLzUPVRyyLISlExfEv+Ir5Io8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AfLciXCwbMveen/74cVeBKXZFPADkQOrSVZqdxUAmGdYhxt6pvyZ6OdsgG8IEMI4c
         0VPNhcigEIPGZe0ffGsusCHYWyJJUxBD2kvG0lhj+8M4VLQNNiuG4Ouo4NHaMS7CVS
         GN/qDaPqh05Xu5rJ23bFnJReCMUwrxdxYJPCxwOU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129G3B0a058254
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 10:03:11 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 10:03:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 9 Mar 2021 10:03:11 -0600
Received: from [10.250.234.4] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129G37V6027939;
        Tue, 9 Mar 2021 10:03:08 -0600
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721e-main: Update the speed modes
 supported and their itap delay values for MMCSD subsystems
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210305054104.10153-1-a-govindraju@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <065ad1b1-97a6-bb30-26c8-a488d3918e26@ti.com>
Date:   Tue, 9 Mar 2021 21:33:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210305054104.10153-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/03/21 11:11 am, Aswath Govindraju wrote:
> According to latest errata of J721e [1], HS400 mode is not supported
> in MMCSD0 subsystem (i2024) and SDR104 mode is not supported in MMCSD1/2
> subsystems (i2090). Therefore, replace mmc-hs400-1_8v with mmc-hs200-1_8v
> in MMCSD0 subsystem and add a sdhci mask to disable SDR104 speed mode.
> 
> Also, update the itap delay values for all the MMCSD subsystems according
> the latest J721e data sheet[2]
> 
> [1] - https://www.ti.com/lit/er/sprz455/sprz455.pdf
> [2] - https://www.ti.com/lit/ds/symlink/tda4vm.pdf
> 
> Fixes: cd48ce86a4d0 ("arm64: dts: ti: k3-j721e-common-proc-board: Add support for SD card UHS modes")
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> 
> Changes since v1:
> - Corrected the fixes tag to latest commit that makes changes to the
>   sdhci DT nodes.
> 
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 8c84dafb7125..f1e7da3dfa27 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -1042,13 +1042,16 @@
>  		assigned-clocks = <&k3_clks 91 1>;
>  		assigned-clock-parents = <&k3_clks 91 2>;
>  		bus-width = <8>;
> -		mmc-hs400-1_8v;
> +		mmc-hs200-1_8v;
>  		mmc-ddr-1_8v;
>  		ti,otap-del-sel-legacy = <0xf>;
>  		ti,otap-del-sel-mmc-hs = <0xf>;
>  		ti,otap-del-sel-ddr52 = <0x5>;
>  		ti,otap-del-sel-hs200 = <0x6>;
>  		ti,otap-del-sel-hs400 = <0x0>;
> +		ti,itap-del-sel-legacy = <0x10>;
> +		ti,itap-del-sel-mmc-hs = <0xa>;
> +		ti,itap-del-sel-ddr52 = <0x3>;
>  		ti,trm-icp = <0x8>;
>  		ti,strobe-sel = <0x77>;
>  		dma-coherent;
> @@ -1069,9 +1072,15 @@
>  		ti,otap-del-sel-sdr25 = <0xf>;
>  		ti,otap-del-sel-sdr50 = <0xc>;
>  		ti,otap-del-sel-ddr50 = <0xc>;
> +		ti,itap-del-sel-legacy = <0x0>;
> +		ti,itap-del-sel-sd-hs = <0x0>;
> +		ti,itap-del-sel-sdr12 = <0x0>;
> +		ti,itap-del-sel-sdr25 = <0x0>;
> +		ti,itap-del-sel-ddr50 = <0x2>;
>  		ti,trm-icp = <0x8>;
>  		ti,clkbuf-sel = <0x7>;
>  		dma-coherent;
> +		sdhci-caps-mask = <0x2 0x0>;
>  	};
>  
>  	main_sdhci2: mmc@4f98000 {
> @@ -1089,9 +1098,15 @@
>  		ti,otap-del-sel-sdr25 = <0xf>;
>  		ti,otap-del-sel-sdr50 = <0xc>;
>  		ti,otap-del-sel-ddr50 = <0xc>;
> +		ti,itap-del-sel-legacy = <0x0>;
> +		ti,itap-del-sel-sd-hs = <0x0>;
> +		ti,itap-del-sel-sdr12 = <0x0>;
> +		ti,itap-del-sel-sdr25 = <0x0>;
> +		ti,itap-del-sel-ddr50 = <0x2>;
>  		ti,trm-icp = <0x8>;
>  		ti,clkbuf-sel = <0x7>;
>  		dma-coherent;
> +		sdhci-caps-mask = <0x2 0x0>;
>  	};
>  
>  	usbss0: cdns-usb@4104000 {
> 
