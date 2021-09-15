Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BC240BFDC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 08:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236469AbhIOGzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 02:55:18 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49568
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236408AbhIOGzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 02:55:16 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 524C43F335
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 06:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631688832;
        bh=zgj1bg0TOISgmSFeFk8bkiVKhlsq6w0PjXe4nsd/Sx0=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=OCqV+AZyPKJik4zFCasOH/bjT1c2dObsSAOcvNgP/gNTYB8Tj92ZB075n5C1KkZ3U
         68jPMzLzpgkzHQYTiIyNRCfr2kyp8FRxoK7u0PJe/GG19ih0nT/vQxKcvKj4E4qCJN
         9xrqltApTvY2XmYgxrGDApat7ZgTAtyu7+RU0ujlbSCaX0hV5DhYBJLdftotkUmAet
         stuzq9zKbWdWvby6NtpeVplcYKGOyabFFvL3fG6UOMc6z02+S/zS1xhXrI9NHx8BWw
         nIVRfFwWxo/lo/V3RwfvTNBQnYsRR8sxySM+fnPOgcWbMyZ0zdcJoDUR73d7mI74jS
         UYGgfolR6CWHA==
Received: by mail-ej1-f71.google.com with SMTP id bx10-20020a170906a1ca00b005c341820edeso973696ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 23:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zgj1bg0TOISgmSFeFk8bkiVKhlsq6w0PjXe4nsd/Sx0=;
        b=yBAeSSvVieBG3vZTlY8pAhmWcFpuatweSzHFcLULJRk3l1QzI1QO841lVNeOlvQ9FV
         k7L4IZ7EJooirr4HqjkZtOBkWl2xRhH52dxVizT/1w6zip7KC1zANz3L7Gubj23x7duL
         6h6dEL1lEYpzkB50z2c76tWJd0yf/KknOUb8uTh9Ah19479PgL7LNp51TjTFTAzWNais
         Uiqgz4fP2dGU9YTLqfJmPn75SzE3NNfaVcmki6Zjdx1DwU4pnv2ouBUYDcNWAqpqXKH4
         j5Pjb99s/cGkzsrNECIRPWw33Kd1EbCeOuWI4m/beSIJAH0iJ4VHdk5O+oLBSs/gAgkP
         jMoA==
X-Gm-Message-State: AOAM533OqR9syc5d2cLj4H9y88dw0qXkOfMwHzwnxHQaGAmk0k3C3LBU
        xynIGt268Ol/SPKWgkoefd4PwojKoALxrbsuP65UAnijEBxmMAZvDfSGyzeTEg12eKtve/vxDdy
        wwXObjGBw/6urkGKHdY8c6bDsIBf7dTBEeRGysa7D+A==
X-Received: by 2002:aa7:d74f:: with SMTP id a15mr19011720eds.374.1631688831429;
        Tue, 14 Sep 2021 23:53:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFMYERbXIzk3hfGcQwONfolCg8zUBk0tLGpGq7TUe9zqPXqi8Wr1vFOOoJiI+VKdVJY9dKug==
X-Received: by 2002:aa7:d74f:: with SMTP id a15mr19011682eds.374.1631688831028;
        Tue, 14 Sep 2021 23:53:51 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id i11sm6582028edu.32.2021.09.14.23.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 23:53:37 -0700 (PDT)
Subject: Re: [PATCH v4 1/8] ARM: dts: omap: Fixup GPMC child nodes
To:     Roger Quadros <rogerq@kernel.org>, tony@atomide.com
Cc:     robh+dt@kernel.org, grygorii.strashko@ti.com, nm@ti.com,
        lokeshvutla@ti.com, nsekhar@ti.com, miquel.raynal@bootlin.com,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210914122705.15421-1-rogerq@kernel.org>
 <20210914122705.15421-2-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <0f1f9c86-8375-5d4e-9514-76d27fc12afb@canonical.com>
Date:   Wed, 15 Sep 2021 08:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914122705.15421-2-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2021 14:26, Roger Quadros wrote:
> Fixes up the GPMC child nodes to prevent dtbs_check errors
> after device tree binding conversion to yaml.
> 
> - Use reg address as node name
> - gpmc,cycle2cycle-samecsen and gpmc,cycle2cycle-diffcsen are
>   boolean properties.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  .../boot/dts/logicpd-som-lv-baseboard.dtsi    |  2 +-
>  .../boot/dts/logicpd-torpedo-37xx-devkit.dts  |  2 +-
>  .../boot/dts/logicpd-torpedo-baseboard.dtsi   |  2 +-
>  arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi     | 62 +++++++++----------
>  arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi     | 59 +++++++++---------
>  arch/arm/boot/dts/omap-zoom-common.dtsi       | 16 ++---
>  arch/arm/boot/dts/omap2430-sdp.dts            |  6 +-
>  arch/arm/boot/dts/omap3-cm-t3x30.dtsi         |  6 +-
>  .../arm/boot/dts/omap3-devkit8000-common.dtsi |  4 +-
>  arch/arm/boot/dts/omap3-evm-37xx.dts          |  1 +
>  arch/arm/boot/dts/omap3-evm-common.dtsi       |  9 ---
>  .../boot/dts/omap3-evm-processor-common.dtsi  |  5 +-
>  arch/arm/boot/dts/omap3-evm.dts               |  1 +
>  arch/arm/boot/dts/omap3-igep0020-common.dtsi  |  5 +-
>  arch/arm/boot/dts/omap3-ldp.dts               |  5 +-
>  arch/arm/boot/dts/omap3-n900.dts              |  2 +-
>  .../dts/omap3-overo-chestnut43-common.dtsi    |  6 +-
>  .../arm/boot/dts/omap3-overo-tobi-common.dtsi |  6 +-
>  .../boot/dts/omap3-overo-tobiduo-common.dtsi  |  8 +--
>  arch/arm/boot/dts/omap3-sb-t35.dtsi           |  4 +-
>  arch/arm/boot/dts/omap4-duovero-parlor.dts    |  6 +-
>  21 files changed, 105 insertions(+), 112 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi b/arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi
> index 7d0468a23781..f2364cb114c5 100644
> --- a/arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi
> +++ b/arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi
> @@ -65,7 +65,7 @@
>  		  1 0 0x2c000000 0x1000000	/* CS1: 16MB for LAN9221 */
>  		  2 0 0x10000000 0x2000000>;    /* CS2: 32MB for NOR */
>  
> -	ethernet@gpmc {
> +	gpmc_ethernet: ethernet@1,0 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&lan9221_pins>;
>  		interrupt-parent = <&gpio5>;
> diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
> index 5532db04046c..6357915d207b 100644
> --- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
> +++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
> @@ -4,8 +4,8 @@
>  
>  #include "omap36xx.dtsi"
>  #include "logicpd-torpedo-som.dtsi"
> -#include "omap-gpmc-smsc9221.dtsi"
>  #include "logicpd-torpedo-baseboard.dtsi"
> +#include "omap-gpmc-smsc9221.dtsi"
>  
>  / {
>  	model = "LogicPD Zoom DM3730 Torpedo + Wireless Development Kit";
> diff --git a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
> index 533a47bc4a53..05049a34b6f1 100644
> --- a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
> +++ b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
> @@ -95,7 +95,7 @@
>  	ranges = <0 0 0x30000000 0x1000000	/* CS0: 16MB for NAND */
>  		  1 0 0x2c000000 0x1000000>;	/* CS1: 16MB for LAN9221 */
>  
> -	ethernet@gpmc {
> +	gpmc_ethernet: ethernet@1,0 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&lan9221_pins>;
>  		interrupt-parent = <&gpio5>;
> diff --git a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
> index ded7e8fec9eb..2a462cb65a7d 100644
> --- a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
> +++ b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
> @@ -20,36 +20,34 @@
>  	};
>  };
>  
> -&gpmc {
> -	ethernet@gpmc {
> -		compatible = "smsc,lan9221", "smsc,lan9115";
> -		bank-width = <2>;
> -		gpmc,device-width = <1>;
> -		gpmc,cycle2cycle-samecsen = <1>;
> -		gpmc,cycle2cycle-diffcsen = <1>;
> -		gpmc,cs-on-ns = <5>;
> -		gpmc,cs-rd-off-ns = <150>;
> -		gpmc,cs-wr-off-ns = <150>;
> -		gpmc,adv-on-ns = <0>;
> -		gpmc,adv-rd-off-ns = <15>;
> -		gpmc,adv-wr-off-ns = <40>;
> -		gpmc,oe-on-ns = <45>;
> -		gpmc,oe-off-ns = <140>;
> -		gpmc,we-on-ns = <45>;
> -		gpmc,we-off-ns = <140>;
> -		gpmc,rd-cycle-ns = <155>;
> -		gpmc,wr-cycle-ns = <155>;
> -		gpmc,access-ns = <120>;
> -		gpmc,page-burst-access-ns = <20>;
> -		gpmc,bus-turnaround-ns = <75>;
> -		gpmc,cycle2cycle-delay-ns = <75>;
> -		gpmc,wait-monitoring-ns = <0>;
> -		gpmc,clk-activation-ns = <0>;
> -		gpmc,wr-data-mux-bus-ns = <0>;
> -		gpmc,wr-access-ns = <0>;
> -		vddvario-supply = <&vddvario>;
> -		vdd33a-supply = <&vdd33a>;
> -		reg-io-width = <4>;
> -		smsc,save-mac-address;
> -	};
> +&gpmc_ethernet {

The same comments as before - this is difficult to review because you
mix up indentation. First, override by label, then do the fixup (or vice
versa). You ignored the comment last time.

Best regards,
Krzysztof
