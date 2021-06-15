Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A923A88D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhFOSvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:51:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48478 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhFOSvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:51:07 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15FImx6R083332;
        Tue, 15 Jun 2021 13:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623782939;
        bh=sGTfVXTf9Uv8YPu2HvI7M/XSUBbbQy70yqibgg7DH7w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BB7rPRsPltYZRhD/xQufUS9cWXfnFpAiktfsuiWh3W7Il8trFos1+DEBWTMXLuR13
         NSYBuwXAe4JfJiypEoxfo6Z1DZ6DTPUCH6090+G0+NvSRbrnisdf0roc2ISzZ5TQTz
         ZucM9JVmjBWz99wG/5bHA7Vu12EfQ7eIBtfXTfn0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15FImxHq006693
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jun 2021 13:48:59 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 13:48:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 15 Jun 2021 13:48:59 -0500
Received: from [10.250.35.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15FImxhx126745;
        Tue, 15 Jun 2021 13:48:59 -0500
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: k3-am64-main: Update the location
 of TF-A
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210615174325.22853-1-a-govindraju@ti.com>
 <20210615174325.22853-4-a-govindraju@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <f9b2c66b-31e4-84c7-c364-debdd7e4196e@ti.com>
Date:   Tue, 15 Jun 2021 13:48:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210615174325.22853-4-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/21 12:43 PM, Aswath Govindraju wrote:
> Due to a limitation for USB DFU boot mode, SPL load address has to be less
> than  or equal to 0x70001000. So, load address of SPL and TF-A have been
> moved to 0x70000000 and 0x701c4000 respectively.
> 
> Therefore, update TF-A's location in the device tree node.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Suman Anna <s-anna@ti.com>

> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 6a883f4349cb..7ab3652dfdfb 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -24,8 +24,8 @@
>  		#size-cells = <1>;
>  		ranges = <0x0 0x00 0x70000000 0x200000>;
>  
> -		tfa-sram@0 {
> -			reg = <0x0 0x1c000>;
> +		tfa-sram@1c4000 {
> +			reg = <0x1c4000 0x1c000>;
>  		};
>  
>  		dmsc-sram@1e0000 {
> 

