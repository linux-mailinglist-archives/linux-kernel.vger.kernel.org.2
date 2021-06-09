Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277033A15FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbhFINtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:49:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53554 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhFINtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:49:47 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 159DliYZ001608;
        Wed, 9 Jun 2021 08:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623246464;
        bh=r81EU4YF9chVd2IZTA3TUdq4Zmxh9TGeZjs2q9m+MBs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UQqr66EFN8exKq9pMM5lyRHN+Qa1wg9WAKXMXHxtnpkfap6Wt6dat0F3vwTaU+4yZ
         7x+wk9y2VYqIbZHZ3IBRYrCmtzkMWiKefbJkZuxPMs834EQbB/UA2r3U1R4KUQnkSe
         YQIF340v3eGKO5/2IH+rDUe08KDcUtHXcnGgTmKs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 159DliEl003702
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jun 2021 08:47:44 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 9 Jun
 2021 08:47:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 9 Jun 2021 08:47:44 -0500
Received: from [10.250.234.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 159Dld5r126278;
        Wed, 9 Jun 2021 08:47:41 -0500
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am642-evm: align
 ti,pindir-d0-out-d1-in property with dt-shema
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210608051414.14873-1-a-govindraju@ti.com>
 <20210608051414.14873-3-a-govindraju@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <d7f97a1e-4870-9837-3cc6-f6788310ec54@ti.com>
Date:   Wed, 9 Jun 2021 19:17:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608051414.14873-3-a-govindraju@ti.com>
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
> Fixes: 4fb6c04683aa ("arm64: dts: ti: k3-am642-evm: Add support for SPI EEPROM")
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index dad0efa961ed..2fd0de905e61 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -334,7 +334,7 @@
>  &main_spi0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_spi0_pins_default>;
> -	ti,pindir-d0-out-d1-in = <1>;
> +	ti,pindir-d0-out-d1-in;
>  	eeprom@0 {
>  		compatible = "microchip,93lc46b";
>  		reg = <0>;
> 
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
