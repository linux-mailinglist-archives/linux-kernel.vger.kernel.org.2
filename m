Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5267037ABDB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhEKQZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:25:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48972 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhEKQZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:25:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14BGNlod130736;
        Tue, 11 May 2021 11:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620750227;
        bh=2S0dW+Pan00olnh4RJyxyhUbCCf+6qGyEYXhbx4w51k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=f/iYcdZWVt3ZnujhA2wskq/K5Qj7hkZAVEDxcxkb6y+q7/7IiG581oyY74K9diXvd
         7lF3GIaPqVNHlw/+KLkAOWQuYDTeRIQnVLbUsymvSFmBpMoVhi0HFipOrW0JYfWbIz
         T2CMjsEQgdtzkX4VJ4gLqekxe4DSbzyvW81lkaIs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14BGNkN7032115
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 May 2021 11:23:46 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 11
 May 2021 11:23:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 11 May 2021 11:23:46 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14BGNhI7097525;
        Tue, 11 May 2021 11:23:44 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3*: Introduce reg definition for
 interrupt routers
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        <grygorii.strashko@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210510145508.8994-1-nm@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <45c92c1d-1d58-4711-ac07-68406492b86b@ti.com>
Date:   Tue, 11 May 2021 21:53:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210510145508.8994-1-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/21 8:25 pm, Nishanth Menon wrote:
> Interrupt routers are memory mapped peripherals, that are organized
> in our dts bus hierarchy to closely represents the actual hardware
> behavior.
> 
> However, without explicitly calling out the reg property, using
> 2021.03+ dt-schema package, this exposes the following problem with
> dtbs_check:
> 
> /arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml: bus@100000:
> interrupt-controller0: {'type': 'object'} is not allowed for
> {'compatible': ['ti,sci-intr'], .....
> 
> Even though we don't use interrupt router directly via memory mapped
> registers and have to use it via the system controller, the hardware
> block is memory mapped, so describe the base address in device tree.
> 
> This is a valid, comprehensive description of hardware and permitted
> by the existing ti,sci-intr schema.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> if possible, I'd like to pick this fixup for 5.13 window..
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi        | 3 ++-
>  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi         | 3 ++-
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi        | 6 ++++--
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      | 3 ++-
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       | 6 ++++--
>  arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 3 ++-
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       | 6 ++++--
>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 3 ++-
>  8 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index b2bcbf23eefd..a49e41021573 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -373,8 +373,9 @@ main_spi4: spi@20140000 {
>  		clocks = <&k3_clks 145 0>;
>  	};
>  
> -	main_gpio_intr: interrupt-controller0 {
> +	main_gpio_intr: interrupt-controller@a00000 {
>  		compatible = "ti,sci-intr";
> +		reg = <0x00 0xa00000 0x00 0x800>;

IIRC, we are going with 0x00a00000 (0x%8x) for all regs. With that fixed for all
regs:

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh
