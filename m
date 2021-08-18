Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0283F065A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbhHROSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:18:33 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48940 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbhHROOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:14:16 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17IEDXwh035846;
        Wed, 18 Aug 2021 09:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629296013;
        bh=efyRrMWGDBVWH4S8x4oL6voAOGjdIuqN12/Mqqc5CcE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WqOB3ZKojmwfMnjVkSh2ytySlGc/G//oq5wr3yGh4AAguJ9u/ImUHUZfSb7bnlPj+
         M5rXA4toG8vzOHh3dwixuIq5PPdwrG2YTSQnZHKr+nqQpRwRFTcIbRTpSInTZroiIB
         XuYlvMVYH+3cbI95rDHSFDz0GDjB4NzSc8pAgJIs=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17IEDXfD091019
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Aug 2021 09:13:33 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 18
 Aug 2021 09:13:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 18 Aug 2021 09:13:32 -0500
Received: from [128.247.81.242] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17IEDWFh069572;
        Wed, 18 Aug 2021 09:13:32 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-mcu: Add pinctrl
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210818111747.88569-1-christian.gmeiner@gmail.com>
From:   Dave Gerlach <d-gerlach@ti.com>
Message-ID: <13974a27-a90d-639d-d050-c97570fdf369@ti.com>
Date:   Wed, 18 Aug 2021 09:13:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818111747.88569-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/18/21 6:17 AM, Christian Gmeiner wrote:
> Add the definition of the pinctrl for the MCU domain.
> 
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> index 59cc58f7d0c8..2bb5c9ff172c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> @@ -97,4 +97,12 @@ mcu_gpio0: gpio@4201000 {
>  		clocks = <&k3_clks 79 0>;
>  		clock-names = "gpio";
>  	};
> +
> +	mcu_pmx0: pinctrl@4084000 {
> +		compatible = "pinctrl-single";
> +		reg = <0x00 0x4084000 0x00 0x84>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xffffffff>;
> +	};
>  };
> 

Reviewed-by: Dave Gerlach <d-gerlach@ti.com>

Regards,
Dave
