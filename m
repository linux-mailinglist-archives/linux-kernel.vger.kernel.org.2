Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8FA3A0BC1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 07:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhFIFOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 01:14:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50522 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhFIFOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 01:14:49 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1595CmVQ063309;
        Wed, 9 Jun 2021 00:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623215568;
        bh=8nU8dx0W7UHA7c2WDGiyi7oL2CaDsAqar1u6ZM2n30Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IHlXFtRyDtg9r55tenCp+Tf+UKwB2jNb+FPTaIBC1O5uExwWt9dKleJ8baHi07+Uf
         yLWnM7m1w1huCr+aRRejiCghpNFib4ScawsSSVmXSTv3aDDHoeWZGDGybOWwjWv0aX
         JqPx2D8xFkRjjEiXtjTX1hEtazl5kfcwjKlufU3g=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1595Cm93054084
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jun 2021 00:12:48 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 9 Jun
 2021 00:12:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 9 Jun 2021 00:12:48 -0500
Received: from [10.250.234.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1595CjRq124940;
        Wed, 9 Jun 2021 00:12:46 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-main: fix ports mac properties
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210608184940.25934-1-grygorii.strashko@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <abe15d92-83a7-d60f-c4b4-81e8b9ac415a@ti.com>
Date:   Wed, 9 Jun 2021 10:42:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608184940.25934-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/21 12:19 AM, Grygorii Strashko wrote:
> The current device tree CPSW3g node adds non-zero "mac-address" property to
> the ports, which prevents random MAC address assignment to network devices
> if bootloader failed to update DT. This may cause more then one host to
> have the same MAC in the network.
> 
>  mac-address = [00 00 de ad be ef];
>  mac-address = [00 01 de ad be ef];
> 
> In addition, there is one MAC address available in eFuse registers which
> can be used for default port 1.
> 
> Hence, fix ports MAC properties by:
> - resetting "mac-address" property to 0
> - adding ti,syscon-efuse = <&main_conf 0x200> to Port 1
> 
> Fixes: 3753b12877b6 ("arm64: dts: ti: k3-am64-main: Add CPSW DT node")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index effb9d2e3c25..7f7178a7a055 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -514,7 +514,8 @@
>  				ti,mac-only;
>  				label = "port1";
>  				phys = <&phy_gmii_sel 1>;
> -				mac-address = [00 00 de ad be ef];
> +				mac-address = [00 00 00 00 00 00];
> +				ti,syscon-efuse = <&main_conf 0x200>;
>  			};
>  
>  			cpsw_port2: port@2 {
> @@ -522,7 +523,7 @@
>  				ti,mac-only;
>  				label = "port2";
>  				phys = <&phy_gmii_sel 2>;
> -				mac-address = [00 01 de ad be ef];
> +				mac-address = [00 00 00 00 00 00];
>  			};
>  		};
>  
> 
