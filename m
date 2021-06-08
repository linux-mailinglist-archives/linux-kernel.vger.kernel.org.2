Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EEB39EE0C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 07:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFHFW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 01:22:56 -0400
Received: from gecko.sbs.de ([194.138.37.40]:42705 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFHFWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 01:22:55 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1585KSnf025820
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jun 2021 07:20:29 +0200
Received: from [167.87.44.81] ([167.87.44.81])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1585KPh6026575;
        Tue, 8 Jun 2021 07:20:25 +0200
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: am65: align ti,pindir-d0-out-d1-in
 property with dt-shema
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210608051414.14873-1-a-govindraju@ti.com>
 <20210608051414.14873-2-a-govindraju@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8d466cbc-eb35-42a8-d4d6-5bcf44cf965e@siemens.com>
Date:   Tue, 8 Jun 2021 07:20:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608051414.14873-2-a-govindraju@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.06.21 07:14, Aswath Govindraju wrote:
> ti,pindir-d0-out-d1-in property is expected to be of type boolean.
> Therefore, fix the property accordingly.
> 

Is there a patch for Documentation/devicetree/bindings/spi/omap-spi.txt
on the way as well that makes this even clearer?

> Fixes: e180f76d0641 ("arm64: dts: ti: Add support for Siemens IOT2050 boards")
> Fixes: 5da94b50475a ("arm64: dts: ti: k3-am654: Enable main domain McSPI0")
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 +-
>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index f4ec9ed52939..23d51b6a9cf2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -575,7 +575,7 @@
>  
>  	#address-cells = <1>;
>  	#size-cells= <0>;
> -	ti,pindir-d0-out-d1-in = <1>;
> +	ti,pindir-d0-out-d1-in;
>  };
>  

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

>  &tscadc0 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index eddb2ffb93ca..1b947e2c2e74 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -299,7 +299,7 @@
>  	pinctrl-0 = <&main_spi0_pins_default>;
>  	#address-cells = <1>;
>  	#size-cells= <0>;
> -	ti,pindir-d0-out-d1-in = <1>;
> +	ti,pindir-d0-out-d1-in;
>  
>  	flash@0{
>  		compatible = "jedec,spi-nor";
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
