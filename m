Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4902E3369CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 02:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCKBgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 20:36:44 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46052 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCKBg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 20:36:29 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12B1aLtH047253;
        Wed, 10 Mar 2021 19:36:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615426581;
        bh=2Ssx+pprOrgmo15xXR8HsrA9jVwC66quZAm2MNaM2AM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QhA0BDNRhXyeuGmX84GvwpsmoSeuxRHuCZJUgPXDw/2fOgMeRSr1rLj7GFcxU9nzj
         MjZidq5PsFYBefAezjG8lV+bIbIu16u466nkRIqOQ2GWjHPDmj3cJGWTfMrhsoApWu
         vLvQkRavee54QXtX4eFnz7B6nIHvayJX3FIJIDlM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12B1aKMH089021
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 19:36:21 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 19:36:20 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 19:36:20 -0600
Received: from [10.250.50.222] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12B1aKFg123710;
        Wed, 10 Mar 2021 19:36:20 -0600
Subject: Re: [PATCH] arm64: dts: ti: k3-am65-mcu: Add RTI watchdog entry
To:     Jan Kiszka <jan.kiszka@web.de>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <279c20fa-6e5e-4f88-9cd1-f76297a28a19@web.de>
From:   "Bajjuri, Praneeth" <praneeth@ti.com>
Message-ID: <9097f361-419f-995f-2f05-d17a949af1cb@ti.com>
Date:   Wed, 10 Mar 2021 19:36:20 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <279c20fa-6e5e-4f88-9cd1-f76297a28a19@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/2021 6:49 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Add the DT entry for a watchdog based on RTI1.
> 
> On SR1.0 silicon, it requires additional firmware on the MCU R5F cores
> to handle the expiry, e.g. https://github.com/siemens/k3-rti-wdt. As
> this firmware will also lock the power domain to protect it against
> premature shutdown, mark it shared.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Acked-by: Praneeth Bajjuri <praneeth@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 7454c8cec0cc..903796bf7d64 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -308,4 +308,13 @@ mcu_r5fss0_core1: r5f@41400000 {
>   			ti,loczrama = <1>;
>   		};
>   	};
> +
> +	mcu_rti1: rti@40610000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x0 0x40610000 0x0 0x100>;
> +		clocks = <&k3_clks 135 0>;
> +		power-domains = <&k3_pds 135 TI_SCI_PD_SHARED>;
> +		assigned-clocks = <&k3_clks 135 0>;
> +		assigned-clock-parents = <&k3_clks 135 4>;
> +	};
>   };
> --
> 2.26.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
