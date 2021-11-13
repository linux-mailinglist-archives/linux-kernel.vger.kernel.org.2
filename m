Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887C144F0C5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 03:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhKMC3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 21:29:25 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54344 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhKMC3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 21:29:23 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AD2QLrj107609;
        Fri, 12 Nov 2021 20:26:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1636770381;
        bh=NR2dJXL8YH3mZDniXHZSCA2814UrX7jc04dD4jaib38=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=euChMXKfzl4oq5aHFVa6+Ye1rdJgrH73vSEkAIkD4EyxlAyyQOyRoFcxhAM0c4u0z
         NF7sbZXSS+HSQ8Vj7g9/LisDcF1JlHk8ctQ0aYq/7AVqk8nolj3UsI39iBacOd/k6f
         A0JeBddEXOOpErJQ+6FOUcYObpZzWPT1o8c/SdyE=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AD2QLF8027638
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Nov 2021 20:26:21 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 12
 Nov 2021 20:26:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 12 Nov 2021 20:26:21 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AD2QL5v087892;
        Fri, 12 Nov 2021 20:26:21 -0600
Date:   Fri, 12 Nov 2021 20:26:21 -0600
From:   Nishanth Menon <nm@ti.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <s-anna@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: k3-j721e: correct cache-sets info
Message-ID: <20211113022621.2fosbqvmrgeen6w7@rigor>
References: <20211112063155.3485777-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211112063155.3485777-1-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:31-20211112, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> A72 Cluster has 48KB Icache, 32KB Dcache and 1MB L2 Cache
>  - ICache is 3-way set-associative
>  - Dcache is 2-way set-associative
>  - Line size are 64bytes
> 
> So correct the cache-sets info.
> 
> Fixes: 2d87061e70dea ("arm64: dts: ti: Add Support for J721E SoC")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> index 214359e7288b..a5967ba139d7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> @@ -64,7 +64,7 @@ cpu0: cpu@0 {
>  			i-cache-sets = <256>;
>  			d-cache-size = <0x8000>;
>  			d-cache-line-size = <64>;
> -			d-cache-sets = <128>;
> +			d-cache-sets = <256>;
>  			next-level-cache = <&L2_0>;
>  		};
>  
> @@ -78,7 +78,7 @@ cpu1: cpu@1 {
>  			i-cache-sets = <256>;
>  			d-cache-size = <0x8000>;
>  			d-cache-line-size = <64>;
> -			d-cache-sets = <128>;
> +			d-cache-sets = <256>;
>  			next-level-cache = <&L2_0>;
>  		};
>  	};
> -- 
> 2.25.1
> 
Arrgh.. Thank you for fixing this.

Reviewed-by: Nishanth Menon <nm@ti.com>

I think J7200 also needs fixups. Will cross check and post additional
patches depending on the ones that need it.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
