Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9DC3AA24A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhFPRSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:18:44 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52596 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhFPRSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:18:40 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15GHGVvq021201;
        Wed, 16 Jun 2021 12:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623863791;
        bh=BSaKXYwEkkOHrbRBsZItFzUPHBO8nZkVvZZN0CdQwZc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Hl5YvhMPqofVVqTSkjSL6vBFI3KWk4xT1LhSNWedz0SoRE5d792cdVriWfHnqYBvz
         ppGRplI5xLU+vic+/SB+pZVgDMDy7kUk0aLLw4x6/hVA++EZw/Vk0chXqtlOdaLfD/
         R0W2jbzufoQ4nzyUlDl+q6EjGD8DrcDjymehYXMc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15GHGVvE046942
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jun 2021 12:16:31 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 16
 Jun 2021 12:16:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 16 Jun 2021 12:16:30 -0500
Received: from [10.250.36.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15GHGUQF105902;
        Wed, 16 Jun 2021 12:16:30 -0500
Subject: Re: [PATCH v5 1/3] arm64: dts: ti: k3-am64-main: Update TF-A's
 maximum size and node name
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210616171224.24635-1-a-govindraju@ti.com>
 <20210616171224.24635-2-a-govindraju@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <3c1776c5-6eea-5fa1-a5fd-f22846bfef08@ti.com>
Date:   Wed, 16 Jun 2021 12:16:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616171224.24635-2-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 12:12 PM, Aswath Govindraju wrote:
> The maximum size of TF-A 2.5 has been increased to 0x1c000 [1]. In order to
> account for future expansions too, increase the allocated size for TF-A to
> 0x20000, in the device tree node.
> 
> Also, update the node name to "tfa-sram".
> 
> [1] - https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=2fb5312f61a7de8b7a70e1639199c4f14a10b6f9
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Suman Anna <s-anna@ti.com>

> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index dec54243f454..e918afc2298e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -24,8 +24,8 @@
>  		#size-cells = <1>;
>  		ranges = <0x0 0x00 0x70000000 0x200000>;
>  
> -		atf-sram@0 {
> -			reg = <0x0 0x1a000>;
> +		tfa-sram@0 {
> +			reg = <0x0 0x20000>;
>  		};
>  	};
>  
> 

