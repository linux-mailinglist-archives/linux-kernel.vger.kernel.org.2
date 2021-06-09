Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC8F3A160A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbhFINu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:50:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36682 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbhFINuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:50:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 159DmrsV041042;
        Wed, 9 Jun 2021 08:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623246533;
        bh=eDuAtLYmqR7daxNV3cens825Hyy16ytC5ebXfF6P7Q0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cTVlnqNIqReJHpbUGQiKog3Z34uoOWkt0SW4pdM/KRuB09d0XDCh4luoQLfR5vNzZ
         fuAj40YLo5DhXKx17ASqWwSmar8hgUAOrB9CHlznh7D0Sy/5pH6jahu8mUFXql01Cn
         /cfNrk/8ZTaEA5uU8o2IisiohvLkc2b0FLxEgw3Y=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 159Dmrb0107038
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jun 2021 08:48:53 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 9 Jun
 2021 08:48:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 9 Jun 2021 08:48:52 -0500
Received: from [10.250.234.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 159DmnbY009248;
        Wed, 9 Jun 2021 08:48:50 -0500
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: am65: align ti,pindir-d0-out-d1-in
 property with dt-shema
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210608051414.14873-1-a-govindraju@ti.com>
 <20210608051414.14873-2-a-govindraju@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <793e8672-d337-21c5-3f75-d12684c678f1@ti.com>
Date:   Wed, 9 Jun 2021 19:18:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608051414.14873-2-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/21 10:44 AM, Aswath Govindraju wrote:
> ti,pindir-d0-out-d1-in property is expected to be of type boolean.
> Therefore, fix the property accordingly.
> 
> Fixes: e180f76d0641 ("arm64: dts: ti: Add support for Siemens IOT2050 boards")
> Fixes: 5da94b50475a ("arm64: dts: ti: k3-am654: Enable main domain McSPI0")
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 +-
>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index f4ec9ed52939..23d51b6a9cf2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -575,7 +575,7 @@
>  
>  	#address-cells = <1>;
>  	#size-cells= <0>;
> -	ti,pindir-d0-out-d1-in = <1>;
> +	ti,pindir-d0-out-d1-in;
>  };
>  
>  &tscadc0 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index eddb2ffb93ca..1b947e2c2e74 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -299,7 +299,7 @@
>  	pinctrl-0 = <&main_spi0_pins_default>;
>  	#address-cells = <1>;
>  	#size-cells= <0>;
> -	ti,pindir-d0-out-d1-in = <1>;
> +	ti,pindir-d0-out-d1-in;
>  
>  	flash@0{
>  		compatible = "jedec,spi-nor";


Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>


Regards
Vignesh
