Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFF33CE12D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 18:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348459AbhGSPYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 11:24:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60910 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245751AbhGSOmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:42:43 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16JFNGH6095237;
        Mon, 19 Jul 2021 10:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626708196;
        bh=SnbXbZbg8sJCPDZO07qBskaz03vLbJY1g1+HRtsgibU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BZrIM7jJ++gE9O09HMFtuydg4lvnS7iPsirs1AvpWs0X1R8BvY318E4642lk2Wi8t
         sCB5H8utq25LfqsDQOb89VzGtjbI2xMk6gX4bv2+RUXHsbOn2Q9pXuZoMuxZ5Ey3rC
         /SGJCoX//UsBZFkpUEm4IKTNUS4hLpg5PBz6hSKw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16JFNGN6066603
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Jul 2021 10:23:16 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 19
 Jul 2021 10:23:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 19 Jul 2021 10:23:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16JFNGtZ083674;
        Mon, 19 Jul 2021 10:23:16 -0500
Date:   Mon, 19 Jul 2021 10:23:16 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
CC:     <kristo@kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: dts: ti: k3-am642-evm: Add ecap0 node
Message-ID: <20210719152316.h3l4dlypmdlzb34q@depose>
References: <20210719085402.28569-1-lokeshvutla@ti.com>
 <20210719085402.28569-5-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210719085402.28569-5-lokeshvutla@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:24-20210719, Lokesh Vutla wrote:
> ecap0 can be configured to use pad ECAP0_IN_APWM_OUT (D18) which has a
> signal connected to Pin 1 of J12 on EVM. Add support for adding this
> pinmux so that pwm can be observed on pin 1 of Header J12
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index 030712221188..7da1238cb1d6 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -288,6 +288,12 @@ AM64X_IOPAD(0x0028, PIN_INPUT, 0) /* (M17) OSPI0_D7 */
>  			AM64X_IOPAD(0x0008, PIN_INPUT, 0) /* (N19) OSPI0_DQS */
>  		>;
>  	};
> +
> +	main_ecap0_pins_default: main-ecap0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0270, PIN_INPUT, 0) /* (D18) ECAP0_IN_APWM_OUT */
> +		>;
> +	};
>  };
>  
>  &main_uart0 {
> @@ -574,3 +580,9 @@ &pcie0_ep {
>  	num-lanes = <1>;
>  	status = "disabled";
>  };
> +
> +&ecap0 {
> +	/* PWM is available on Pin 1 of header J12 */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_ecap0_pins_default>;
> +};
> -- 
> 2.30.0
> 

Do the other ecap and pwm nodes need to be disabled since they may not
be pinned out?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
