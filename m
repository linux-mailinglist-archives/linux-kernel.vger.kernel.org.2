Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AF53A173F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbhFIOb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:31:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37488 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbhFIObZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:31:25 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 159ETPaB020794;
        Wed, 9 Jun 2021 09:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623248966;
        bh=zV3VZ4YOASefAdKhPByngIOqwleUDUA6BN4OYuClyYM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bvWl3x8MVaXaXUNtYbKCjKDQwIEk6H1bZM3XrrcGxpXcYBIJpn4NPZ7C+UzYeBMra
         gnVxdNb2BE3vQ8c8NFZSSQsU9lsJHLo2aOuA4bpQnICKQ4uCZkk5XCUneMylc0PwRT
         RW40YRHR/NQblfwDoof8zzaFZFBVUatgwiIzPK+8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 159ETPB0113075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jun 2021 09:29:25 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 9 Jun
 2021 09:29:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 9 Jun 2021 09:29:22 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 159ETFu2012709;
        Wed, 9 Jun 2021 09:29:17 -0500
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64-main: Update the location of
 ATF in SRAM and increase its max size
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Suman Anna <s-anna@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210607133806.18158-1-a-govindraju@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <e53458a9-e5f6-6507-f95c-2406b47b5576@ti.com>
Date:   Wed, 9 Jun 2021 19:59:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210607133806.18158-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/21 7:08 pm, Aswath Govindraju wrote:
> Due to a limitation for USB DFU boot mode, SPL load address has to be less
> than  or equal to 0x70001000. So, load address of SPL and ATF have been
> moved to 0x70000000 and 0x701a0000 respectively.
> 
> Also, the maximum size of ATF has been increased to 0x1c000 [1].
> 
> Therefore, update ATF's location and maximum size accordingly in the device
> tree file.
> 
> [1] - https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=2fb5312f61a7de8b7a70e1639199c4f14a10b6f9
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index ca59d1f711f8..fcd12b6f10f6 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -13,8 +13,8 @@
>  		#size-cells = <1>;
>  		ranges = <0x0 0x00 0x70000000 0x200000>;
>  
> -		atf-sram@0 {
> -			reg = <0x0 0x1a000>;
> +		atf-sram@1a0000 {
> +			reg = <0x1a0000 0x1c000>;

After thinking a bot more, isn't size be 0x20000?
ATF is allocated with 125KB no? no point keeping the ~3 as hole IMO.

Thanks and regards,
Lokesh

>  		};
>  	};
>  
> 
