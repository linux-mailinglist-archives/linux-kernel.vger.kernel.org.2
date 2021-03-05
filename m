Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AF732EFC5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhCEQMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:12:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58058 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhCEQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:12:23 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 125GC6UJ060375;
        Fri, 5 Mar 2021 10:12:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614960726;
        bh=2scub0axRnNHX3bcSX6skqxz08B/s2H4bhtRdQbF+T8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=vjIuyoQj/CtoMLTSv4LiqXeGuKi7LAspxrDIJLaAqDCFaEHXmh9pPCuSM+4ZFcrbM
         P1inp/RgvawR+d6ejPc7Bbz+98BnkSuf0zE06EKsYmoCOgLnHsS0QrgG9TkIC3SgKC
         RiZJct2J5i4j5iAGmMiBb3a0cONY4+bYonUx/dTY=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 125GC616031082
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Mar 2021 10:12:06 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 5 Mar
 2021 10:12:06 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 5 Mar 2021 10:12:06 -0600
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 125GC34S094599;
        Fri, 5 Mar 2021 10:12:04 -0600
Subject: Re: [PATCH v2 1/3] arm64: dts: ti: k3-j721e-som-p0: Enable 8D-8D-8D
 mode on OSPI
To:     Pratyush Yadav <p.yadav@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210305153926.3479-1-p.yadav@ti.com>
 <20210305153926.3479-2-p.yadav@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <ede8878d-a25c-7424-11ae-313aacd99e07@ti.com>
Date:   Fri, 5 Mar 2021 21:42:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210305153926.3479-2-p.yadav@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/21 9:09 PM, Pratyush Yadav wrote:
> Set the Tx bus width to 8 so 8D-8D-8D mode can be selected. Change the
> frequency to 25 MHz. This is the frequency that the flash has been
> successfully tested with in Octal DTR mode. The total performance should
> still increase since 8D-8D-8D mode should be at least twice as fast as
> 1S-1S-8S mode.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
> 

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

> Notes:
>     No changes in v2.
> 
>  arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> index 57720e6a04c5..2fee2906183d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> @@ -174,9 +174,9 @@ &ospi0 {
>  	flash@0{
>  		compatible = "jedec,spi-nor";
>  		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <8>;
>  		spi-rx-bus-width = <8>;
> -		spi-max-frequency = <40000000>;
> +		spi-max-frequency = <25000000>;
>  		cdns,tshsl-ns = <60>;
>  		cdns,tsd2d-ns = <60>;
>  		cdns,tchsh-ns = <60>;
> 
