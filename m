Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2333B3A495F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhFKTSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:18:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57944 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhFKTSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:18:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15BJGev0056290;
        Fri, 11 Jun 2021 14:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623439000;
        bh=0hxmq/prVT6mJzeuodL+slFKCN8TDJPlW4vaujysM80=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=g8uBqu7Fw/McYhxURLwX1N1/qbAloXOa+P6jo9WdFv4t2IJzVckZbEh2jbe8fovtq
         OgXwKbkhgHHqdCrauwdjZwd6L9fZXkran4Pb/TaP11l6dzRNS1GI70Mk2SAPGpGLNs
         x5e5RwQir7o4UYJUn/S3fve1ZblYPA36xWj90qWc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15BJGeQv097835
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jun 2021 14:16:40 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 14:16:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 11 Jun 2021 14:16:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15BJGebS001210;
        Fri, 11 Jun 2021 14:16:40 -0500
Date:   Fri, 11 Jun 2021 14:16:40 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Add SYSFW reserved ranges
 in OCRAM
Message-ID: <20210611191640.lczsliyzasjie6lm@dismantle>
References: <20210609140604.9490-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210609140604.9490-1-vigneshr@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:36-20210609, Vignesh Raghavendra wrote:
> Last 256K of OCRAM (256K@0x701c0000) is reserved for SYSFW usage. Hence
> add an entry in DT so that its not used for generic pool memory
> allocation.

Are you really sure?? I know that I had set a budget for 16K in sysfw
when I did the memory split up for sysfw of which 16k is actually used.

Not sure where this 256K bucket started off from.. am I missing
something here?


> 
> Without this certain drivers using SRAM as generic shared memory pool
> may end up being allocated memory from this range and will lead to boot
> time crash when the reserved range is accessed (due to firewall
> violation).
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index f1c42ef05e52..77b88e536534 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -16,6 +16,10 @@ oc_sram: sram@70000000 {
>  		atf-sram@0 {
>  			reg = <0x0 0x1a000>;
>  		};
> +
> +		dmsc-sram@1c0000 {
> +			reg = <0x1c0000 0x40000>;

> +		};
>  	};
>  
>  	gic500: interrupt-controller@1800000 {
> -- 
> 2.31.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
