Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A8B3CDEA3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 17:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345617AbhGSPEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 11:04:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60944 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343717AbhGSOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:42:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16JFNRrj095302;
        Mon, 19 Jul 2021 10:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626708207;
        bh=+lxuCFG7CjSWwyH88HP6Xk82R9fNuIwH8NsBGZrwyAY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=HOSw8CRzAkxyPC4CGVTqX9eCRIovDPwQYAA8eNewjIhMKkp4ql484xvKNSRG00SyY
         zLE3uckzk54wOubU5oYfsr3LtVShP36MHCm5nBi2r5lOT7GV32zE0ksEKdHeIvc2Dw
         3jyW5q4gkSbt348aPyl2EgiKYXNyVBVEhEav9DFk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16JFNRC1116311
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Jul 2021 10:23:27 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 19
 Jul 2021 10:23:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 19 Jul 2021 10:23:27 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16JFNQk0032744;
        Mon, 19 Jul 2021 10:23:26 -0500
Date:   Mon, 19 Jul 2021 10:23:26 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
CC:     <kristo@kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] arm64: dts: ti: k3-am642-sk: Add ecap0 node
Message-ID: <20210719152326.op7ii76nvk5sve2a@fringe>
References: <20210719085402.28569-1-lokeshvutla@ti.com>
 <20210719085402.28569-4-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210719085402.28569-4-lokeshvutla@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:24-20210719, Lokesh Vutla wrote:
> ecap0 can be configured to use pad ECAP0_IN_APWM_OUT (D18) which has a
> signal connected to Pin 1 of J3. Add support for adding this pinmux so
> that pwm can be observed on pin 1 of Header J3
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index d3aa2901e6fd..eb0d10e6e787 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -210,6 +210,12 @@ AM64X_IOPAD(0x0028, PIN_INPUT, 0) /* (M17) OSPI0_D7 */
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
>  &mcu_uart0 {
> @@ -453,3 +459,9 @@ &pcie0_rc {
>  &pcie0_ep {
>  	status = "disabled";
>  };
> +
> +&ecap0 {
> +	/* PWM is available on Pin 1 of header J3 */
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
