Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBDB40C7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhIOPN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:13:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35036 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhIOPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:13:28 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18FFBxml010177;
        Wed, 15 Sep 2021 10:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631718719;
        bh=Noc3Vg1u4OEnmLXjCiSBH2Vbn3a+JN5Yh0ZigrDpems=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sUJAhIGAzzW3FG9m6quq1YhD82iowiyT8KfFt9pZ3LMG0nHOgmno0ZztiHac/0ktI
         mrDpdop3BlaxubGsmJLeQQoxHA8ubAzypDjPotr6xrPF7p0CNO7537EtYFp7fvbZs6
         fRRkIqeIBJin/owiLCl4Ee8Nwf6Mcj7ii+QkFSkU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18FFBxQ1046872
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 10:11:59 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 10:11:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 10:11:58 -0500
Received: from [10.250.232.51] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18FFBtFN103656;
        Wed, 15 Sep 2021 10:11:56 -0500
Subject: Re: [PATCH] arm64: dts: ti: ti-k3*: Introduce aliases for mmc nodes
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <20210915135415.5706-1-nm@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <22d8a179-cc6c-0be6-1580-cb2a5a749417@ti.com>
Date:   Wed, 15 Sep 2021 20:41:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915135415.5706-1-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/21 7:24 pm, Nishanth Menon wrote:
> Since probe order of mmc can vary depending on device tree dependencies,
> Lets try and introduce a consistent definition of what mmc0, 1 are
> across platforms.
> 
> NOTE: Certain platforms may choose to have overrides due to various
> legacy reasons, we permit that in the board specific alias definition.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>

>  arch/arm64/boot/dts/ti/k3-am64.dtsi  | 2 ++
>  arch/arm64/boot/dts/ti/k3-am65.dtsi  | 2 ++
>  arch/arm64/boot/dts/ti/k3-j7200.dtsi | 2 ++
>  arch/arm64/boot/dts/ti/k3-j721e.dtsi | 3 +++
>  4 files changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
> index de6805b0c72c..120974726be8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
> @@ -30,6 +30,8 @@ aliases {
>  		serial8 = &main_uart6;
>  		ethernet0 = &cpsw_port1;
>  		ethernet1 = &cpsw_port2;
> +		mmc0 = &sdhci0;
> +		mmc1 = &sdhci1;
>  	};
>  
>  	chosen { };
> diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> index a9fc1af03f27..a58a39fa42db 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> @@ -31,6 +31,8 @@ aliases {
>  		i2c4 = &main_i2c2;
>  		i2c5 = &main_i2c3;
>  		ethernet0 = &cpsw_port1;
> +		mmc0 = &sdhci0;
> +		mmc1 = &sdhci1;
>  	};
>  
>  	chosen { };
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> index b7005b803149..47567cb260c2 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> @@ -30,6 +30,8 @@ aliases {
>  		serial9 = &main_uart7;
>  		serial10 = &main_uart8;
>  		serial11 = &main_uart9;
> +		mmc0 = &main_sdhci0;
> +		mmc1 = &main_sdhci1;
>  	};
>  
>  	chosen { };
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> index f0587fde147e..214359e7288b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> @@ -31,6 +31,9 @@ aliases {
>  		serial10 = &main_uart8;
>  		serial11 = &main_uart9;
>  		ethernet0 = &cpsw_port1;
> +		mmc0 = &main_sdhci0;
> +		mmc1 = &main_sdhci1;
> +		mmc2 = &main_sdhci2;
>  	};
>  
>  	chosen { };
> 

