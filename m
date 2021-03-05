Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE99632EFC2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhCEQMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:12:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50280 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCEQMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:12:37 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 125GCVLK111354;
        Fri, 5 Mar 2021 10:12:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614960751;
        bh=pOppNCEoPstfDrrdFFuISm0AZlchJLIgzlwfWglHmro=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=CvH+Etqu6zObqGo6/wmIOxKl/T1Rcc+ykCh62KM/7nl8YEmgBWFJ2MLrmM26pYiz8
         qu6ThRuiOvnz/4WOPuFtuDRqdO0Iy3IxTHEjS7vQJ2vXXfNee17DFXiW5OxuA4OZKM
         e5cBluxladvi6chx8T3IXkF3CpxSTEdJw1DIrSrs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 125GCV3l031684
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Mar 2021 10:12:31 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 5 Mar
 2021 10:12:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 5 Mar 2021 10:12:31 -0600
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 125GCS07039586;
        Fri, 5 Mar 2021 10:12:29 -0600
Subject: Re: [PATCH v2 2/3] arm64: dts: ti: am654-base-board: Enable 8D-8D-8D
 mode on OSPI
To:     Pratyush Yadav <p.yadav@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210305153926.3479-1-p.yadav@ti.com>
 <20210305153926.3479-3-p.yadav@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <df1610bc-fbcc-9ebb-e8d2-24f2d69aba00@ti.com>
Date:   Fri, 5 Mar 2021 21:42:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210305153926.3479-3-p.yadav@ti.com>
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
>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index fe3043943906..9e87fb313a54 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -483,9 +483,9 @@ &ospi0 {
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
