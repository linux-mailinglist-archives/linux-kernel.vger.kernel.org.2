Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79208360A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhDON1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhDON1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:27:50 -0400
X-Greylist: delayed 354 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Apr 2021 06:27:27 PDT
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C1FC061574;
        Thu, 15 Apr 2021 06:27:25 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8025681E77;
        Thu, 15 Apr 2021 15:21:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1618492888;
        bh=ZONWGzYKtU8DHCzBAyEFfKxI0PsF5qLdYZOEWoxUxKQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rFO2ciQsIJnRAm72WtUX1yUdmKRSKfPKLDR/Zkra4IVdcKMG9S/2EoTdPdr1yEazy
         +V5V1F4LGvrw4RrmrpCZXFx50uaqsIYaU/af6YL3hPsgqEAjiOA99WEPKs5Vr+LNl+
         nCxoVRycYBM7p8bG1ewYdBtqr3imi2bM2JhN2lQvSMzOSP1g/4n/Zlp+4oUIqdIVGB
         4H5iVZeBMkNhxtCBLLNG4O//I+MILGLIKcLPnFx4LH5bnFmPb6o9ZlQgbofSAYYu0s
         ayRhbM9YD5mIKPKqhQIxEpzUYdiA7pLhWNGSln3l9RIHsO6UjVjxNEVFyae/Q1011+
         1dd4NJLYniHHw==
Subject: Re: [PATCH 11/13] ARM: dts: stm32: fix LTDC port node on STM32 MCU ad
 MPU
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>, arnd@arndb.de,
        robh+dt@kernel.org, jagan@amarulasolutions.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kuba@kernel.org
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
 <20210415101037.1465-12-alexandre.torgue@foss.st.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <3b39908b-a263-a5d4-f6ac-ac30ffb06269@denx.de>
Date:   Thu, 15 Apr 2021 15:21:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210415101037.1465-12-alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 12:10 PM, Alexandre Torgue wrote:
> Running "make dtbs_check W=1", some warnings are reported concerning
> LTDC port subnode:
> 
> /soc/display-controller@5a001000/port:
> unnecessary #address-cells/#size-cells without "ranges" or child "reg"
> property
> /soc/display-controller@5a001000/port: graph node has single child node
> 'endpoint', #address-cells/#size-cells are not necessary

btw could you retain diffstat on your patches ? It's useful to see which 
files changed right away.

[...]

> diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts b/arch/arm/boot/dts/stm32mp157c-dk2.dts
> index 2bc92ef3aeb9..19ef475a48fc 100644
> --- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
> @@ -82,9 +82,15 @@
>   };
>   
>   &ltdc {
> -	status = "okay";
> -
>   	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ltdc_ep0_out: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&sii9022_in>;
> +		};
> +
>   		ltdc_ep1_out: endpoint@1 {
>   			reg = <1>;
>   			remote-endpoint = <&dsi_in>;

[...]

> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
> index 64dca5b7f748..e7f10975cacf 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
> @@ -277,11 +277,7 @@
>   	status = "okay";
>   
>   	port {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		ltdc_ep0_out: endpoint@0 {
> -			reg = <0>;
> +		ltdc_ep0_out: endpoint {
>   			remote-endpoint = <&adv7513_in>;
>   		};
>   	};

I think this is wrong, the AV96 can have two displays connected to two 
ports of the LTDC, just like DK2 for example.
