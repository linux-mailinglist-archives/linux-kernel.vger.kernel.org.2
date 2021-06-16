Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F543AA250
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhFPRTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:19:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52688 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhFPRT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:19:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15GHHIQ6021377;
        Wed, 16 Jun 2021 12:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623863838;
        bh=g08R8YAYS+crz+j2DoAruFPuUHrLBilmKq04zADtWWQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=itAfZGrpEgm0CUSPv8jHC2Srlwig4+s0yWNOn8Cne+6yJoRLjDBRUKGJXcgb1enN6
         ihYxKg7Ia0fffWTuvkpNtLHVDW93ZO7YQnUaHgGrm/ZVoQ8ca6IczNB1RWq4I0Mx8X
         C+fsRsVl2SyD8arctNkR8hDqGxi1/96n8LCRt0AA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15GHHIoN018075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jun 2021 12:17:18 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 16
 Jun 2021 12:17:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 16 Jun 2021 12:17:18 -0500
Received: from [10.250.36.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15GHHIAA051464;
        Wed, 16 Jun 2021 12:17:18 -0500
Subject: Re: [PATCH v5 3/3] arm64: dts: ti: k3-am64-main: Update the location
 of TF-A in compliance with U-Boot v2021.10
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210616171224.24635-1-a-govindraju@ti.com>
 <20210616171224.24635-4-a-govindraju@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <88d521fb-0852-7433-42d6-e847b4fa73b2@ti.com>
Date:   Wed, 16 Jun 2021 12:17:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616171224.24635-4-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 12:12 PM, Aswath Govindraju wrote:
> Due to a limitation for USB DFU boot mode, SPL load address has to be less
> than  or equal to 0x70001000. So, load address of SPL and TF-A have been
> moved to 0x70000000 and 0x701c0000 respectively, in U-Boot version 2021.10.
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
> index 27888ee6f039..62d2b8fff67d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -24,8 +24,8 @@
>  		#size-cells = <1>;
>  		ranges = <0x0 0x00 0x70000000 0x200000>;
>  
> -		tfa-sram@0 {
> -			reg = <0x0 0x20000>;
> +		tfa-sram@1c0000 {
> +			reg = <0x1c0000 0x20000>;
>  		};
>  
>  		dmsc-sram@1e0000 {
> 

