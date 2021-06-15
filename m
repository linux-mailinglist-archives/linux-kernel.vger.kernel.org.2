Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34363A8651
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhFOQYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:24:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33586 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFOQYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:24:53 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15FGMh1f108085;
        Tue, 15 Jun 2021 11:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623774163;
        bh=wGVUQ55PmqJON7xlCT6V4UA7WmkkpWbU+WHVCO3D95I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=S7l9NCrR96NAPvkrSbt+Ce9uxQ1lVh38XyRL35M2wUka90AW1BPLi/ORqu/igP24/
         2hd5eGeVB69cRFPGZY+7FxFX6mjZXs5+1+IYmfs4XpSuSab/H3nAD5hgg4AZCL+n9D
         WCkdKm5oNwWgwbUn8RuLW/OtRH1x3kEhqsqj7JEc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15FGMhlB045507
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jun 2021 11:22:43 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 11:22:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 15 Jun 2021 11:22:43 -0500
Received: from [10.250.35.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15FGMhr6021735;
        Tue, 15 Jun 2021 11:22:43 -0500
Subject: Re: [PATCH v3 1/3] dts: ti: k3-am64-main: Update TF-A's maximum size
 and node name
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210615155115.28902-1-a-govindraju@ti.com>
 <20210615155115.28902-2-a-govindraju@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <879de360-f574-0d45-dd01-066578ff6458@ti.com>
Date:   Tue, 15 Jun 2021 11:22:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210615155115.28902-2-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/21 10:51 AM, Aswath Govindraju wrote:
> The maximum size of TF-A 2.5 has been increased to 0x1c000 [1]. Therefore,
> update this accordingly in the device tree node.
> 
> Also, update the node name to "tfa-sram".
> 
> [1] - https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=2fb5312f61a7de8b7a70e1639199c4f14a10b6f9
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Reviewed-by: Suman Anna <s-anna@ti.com>

Patch title should start with arm64: following the standard convention.
Sorry missed this in the prior review. Otherwise, everything LGTM.

regards
Suman

> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index dec54243f454..693fe24e7f7a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -24,8 +24,8 @@
>  		#size-cells = <1>;
>  		ranges = <0x0 0x00 0x70000000 0x200000>;
>  
> -		atf-sram@0 {
> -			reg = <0x0 0x1a000>;
> +		tfa-sram@0 {
> +			reg = <0x0 0x1c000>;
>  		};
>  	};
>  
> 

