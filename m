Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B2D458645
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 21:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhKUUUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 15:20:10 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55629 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231347AbhKUUUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 15:20:09 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 91BB75C00FB;
        Sun, 21 Nov 2021 15:17:03 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Sun, 21 Nov 2021 15:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=y8ljUZIDaYJs8wCxLlCkyDpCokhi
        6fOAzyABQKgphx4=; b=D5n2pLksMEKQKdT6D9ppiRW+8MdLmzPWza32y9G6FWHa
        iYE2ldhBrClqvd/iWCh/JjRaNdBhmnPGrI/4RK6i4dLJ/FfflhGnAlLi9ANAxdf7
        l7VPgwWMaozlH9GhNaIZARAA06UeJJnwCoBp86feMJzJYYQH2Okc9qPEF3WVlLb7
        59dTi6Yppy8NTncCWThILlbiitFR4r3bbHiYOM7l1CIiFI967XgW3O5Aa8sQas1G
        d7NfmFhomqVau73XERDV4LhjknQ7tXigB2MjS6/tqIECwMnG1R8rc18kn/1LtaBj
        u3PO7ERtqiN8JL9SHQPhkZDQoTmbOzeybQcdPhJ+mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=y8ljUZ
        IDaYJs8wCxLlCkyDpCokhi6fOAzyABQKgphx4=; b=PDgrKFPkXHoTs37jsViGnO
        9j9CoufsBMdfkGO3eDDFFE3Ctd57p35P7cuLZe1uBLaI22tm8v1SjjwkGhpJdnhF
        niYEXZQJs2nm5MdrB6plB3QVM0KQLow3Oc8uIdimTRA774aZ3pvlhYe8ZQDxg2sV
        PeCkJInXSQ9OVIUn/wdvC2hE+CTOIHTom5Sn87+/VUYMqMAomKZVTicWhykxIgo1
        Gcy8c8UNUfn2xavSEr2MgYTGszqiQuB0Hqf+HaB9BFhPJYVktMB76lILxi0h8b+u
        +UpLLFLH9+DGSuvpQSH24iVd+ivBJZa4jnhYYUIhc16y/Af7kCA3+83GMI29OBVw
        ==
X-ME-Sender: <xms:P6maYfgSqMXxeBycBuNg8zD9uWCgrMeVXy7N__Z3cr3gnwKvNskMBQ>
    <xme:P6maYcD_MP6wbn1rI-FpSoE0kc1kUKayB8u7MLGYZiKVdtrQkNIBcpPLy8zr1KQYF
    ZckP1nA_X-ObKwQK7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgedvgddufeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:P6maYfG8A3061NimDm8l_gZh8lBeIPjZkD9PRnHtNfq_7IRBtOtdew>
    <xmx:P6maYcRkZwfNCErPY4L2QnlLcTy7B20_U6JiW4js7oJMnsSgueuBtA>
    <xmx:P6maYczDgSQg4C147o82w8G1qHSTZEOpLyBxSlxQTI3wBapWmcFp8w>
    <xmx:P6maYbr6IFF_zXrlm8s_ydFqvTzS2_6y-rJMKMMFZlvBcXgUAVd0GA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0BB2F274055A; Sun, 21 Nov 2021 15:17:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <3bfce993-2535-4301-b5da-e2c7f9b48511@www.fastmail.com>
In-Reply-To: <20211121180758.29477-4-j@jannau.net>
References: <20211121180758.29477-1-j@jannau.net>
 <20211121180758.29477-4-j@jannau.net>
Date:   Sun, 21 Nov 2021 21:16:21 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Janne Grunau" <j@jannau.net>, "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     "Mark Kettenis" <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: apple: t8103: Add i2c and cd321x nodes
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 21, 2021, at 19:07, Janne Grunau wrote:
> i2c0, i2c1 and i2c3 are used on all M1 devices, i2c2 is only used on
> the 2020 Mac Mini and 13-inch MacBook Pro. All devices have identical
> i2c addresses for the cd321x' and use the same i2c bus.

This should really be two commits: One for the i2c nodes and the other
one to add the cd321x nodes.

>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  arch/arm64/boot/dts/apple/t8103-j274.dts  |  4 ++
>  arch/arm64/boot/dts/apple/t8103-j293.dts  |  4 ++
>  arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 18 ++++++
>  arch/arm64/boot/dts/apple/t8103.dtsi      | 73 +++++++++++++++++++++++
>  4 files changed, 99 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/apple/t8103-j274.dts 
> b/arch/arm64/boot/dts/apple/t8103-j274.dts
> index 9e01ef70039d..2cd429efba5b 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j274.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j274.dts
> @@ -39,3 +39,7 @@ ethernet0: ethernet@0,0 {
>  		local-mac-address = [00 10 18 00 00 00];
>  	};
>  };
> +
> +&i2c2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts 
> b/arch/arm64/boot/dts/apple/t8103-j293.dts
> index 466035f00b69..a3b084d50da3 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j293.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j293.dts
> @@ -31,3 +31,7 @@ &pcie0_dart_2 {
> 
>  /delete-node/ &port01;
>  /delete-node/ &port02;
> +
> +&i2c2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi 
> b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> index 53d22b434d76..5f748f3f60d2 100644
> --- a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> @@ -39,6 +39,24 @@ &serial0 {
>  	status = "okay";
>  };
> 
> +&i2c0 {
> +	hpm0: tps6598x@38 {
> +		compatible = "apple,cd321x";
> +		reg = <0x38>;
> +		interrupt-parent = <&pinctrl_ap>;
> +		interrupts = <106 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "irq";
> +	};
> +
> +	hpm1: tps6598x@3f {
> +		compatible = "apple,cd321x";
> +		reg = <0x3f>;
> +		interrupt-parent = <&pinctrl_ap>;
> +		interrupts = <106 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "irq";
> +	};
> +};
> +
>  /*
>   * Force the bus number assignments so that we can declare some of the
>   * on-board devices and properties that are populated by the bootloader
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi 
> b/arch/arm64/boot/dts/apple/t8103.dtsi
> index c320c8baeb41..6c6dd988bd60 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -126,6 +126,59 @@ serial0: serial@235200000 {
>  			status = "disabled";
>  		};
> 
> +		i2c0: i2c@235010000 {
> +			compatible = "apple,t8103-i2c", "apple,i2c";
> +			reg = <0x2 0x35010000 0x0 0x4000>;
> +			clocks = <&clk24>;
> +			clock-names = "ref";

I don't think we need the clock name here.

> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 627 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-0 = <&i2c0_pins>;
> +			pinctrl-names = "default";
> +			#address-cells = <0x1>;
> +			#size-cells = <0x0>;
> +		};
> +
> +		i2c1: i2c@235014000 {
> +			compatible = "apple,t8103-i2c", "apple,i2c";
> +			reg = <0x2 0x35014000 0x0 0x4000>;
> +			clocks = <&clk24>;
> +			clock-names = "ref";
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 628 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-0 = <&i2c1_pins>;
> +			pinctrl-names = "default";
> +			#address-cells = <0x1>;
> +			#size-cells = <0x0>;
> +		};
> +
> +		i2c2: i2c@235018000 {
> +			compatible = "apple,t8103-i2c", "apple,i2c";
> +			reg = <0x2 0x35018000 0x0 0x4000>;
> +			clocks = <&clk24>;
> +			clock-names = "ref";
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 628 IRQ_TYPE_LEVEL_HIGH>;

Shouldn't this be 629? 628 is already used for i2c1.

> +			pinctrl-0 = <&i2c2_pins>;
> +			pinctrl-names = "default";
> +			#address-cells = <0x1>;
> +			#size-cells = <0x0>;
> +			status = "disabled"; /* not used in all devices */
> +		};
> +
> +		i2c3: i2c@23501c000 {
> +			compatible = "apple,t8103-i2c", "apple,i2c";
> +			reg = <0x2 0x3501c000 0x0 0x4000>;
> +			clocks = <&clk24>;
> +			clock-names = "ref";
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 630 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-0 = <&i2c3_pins>;
> +			pinctrl-names = "default";
> +			#address-cells = <0x1>;
> +			#size-cells = <0x0>;
> +		};
> +
>  		aic: interrupt-controller@23b100000 {
>  			compatible = "apple,t8103-aic", "apple,aic";
>  			#interrupt-cells = <3>;
> @@ -153,6 +206,26 @@ pinctrl_ap: pinctrl@23c100000 {
>  				     <AIC_IRQ 195 IRQ_TYPE_LEVEL_HIGH>,
>  				     <AIC_IRQ 196 IRQ_TYPE_LEVEL_HIGH>;
> 
> +			i2c0_pins: i2c0-pins {
> +				pinmux = <APPLE_PINMUX(192, 1)>,
> +					 <APPLE_PINMUX(188, 1)>;
> +			};
> +
> +			i2c1_pins: i2c1-pins {
> +				pinmux = <APPLE_PINMUX(201, 1)>,
> +					 <APPLE_PINMUX(199, 1)>;
> +			};
> +
> +			i2c2_pins: i2c2-pins {
> +				pinmux = <APPLE_PINMUX(163, 1)>,
> +					 <APPLE_PINMUX(162, 1)>;
> +			};
> +
> +			i2c3_pins: i2c3-pins {
> +				pinmux = <APPLE_PINMUX(73, 1)>,
> +					 <APPLE_PINMUX(72, 1)>;
> +			};
> +
>  			pcie_pins: pcie-pins {
>  				pinmux = <APPLE_PINMUX(150, 1)>,
>  					 <APPLE_PINMUX(151, 1)>,
> -- 
> 2.34.0
