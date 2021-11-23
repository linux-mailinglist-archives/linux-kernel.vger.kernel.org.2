Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030AA45A680
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbhKWP14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbhKWP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:27:55 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21842C061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:24:47 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so15794585otv.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JpD5WpIhxDUkbt7w6TL55id0u6co4l+62l9b76Ql6yE=;
        b=NrvF4QqjjfGRaiXEftlCeh5hxtQmd/oBn8N6nYo5xZ61CYUhYy2sp8YjyvMYtf+6r4
         AMA1D4ejWYPVAjO64DEhhEK/rzT8aAE5SHIZaUzrSOg3Q3xgvYPloH6zeAtO0BLpy7ut
         AzzshMD452L//bSolQHlO9U3xa76E5tN6NLy+EfBPl1Nykcu+6FggNLRVjOZIN9iE4uu
         vrhsQwoMyRUq/Bu4yjKl+TjDaM/mwAA66o/oL5cGHWzgDVEItwXjQ5028TCtHPMHMQ1v
         H/Hra52DAt9DYh+GfPYI2Hg8VXegkaB+6LArISAiq4YClmERQJgXJ+YDJbLECmaocmmk
         a7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JpD5WpIhxDUkbt7w6TL55id0u6co4l+62l9b76Ql6yE=;
        b=Z6+ANc4b6e92Ofp2pFkds6202igTWPBonXSsMNs+8hJuHqRVR2SgBlbLfbCD55bRop
         /15KYmMNCDZWZudwfxoxvr0L6sgGK8x0Rl9h6D/BeFfKNYcMXgCXo5ub9MVtkXY1ClfQ
         pMBLFVYRESvMq0fMksGintm11ooXG845a5CkMQyZ1z+80BmDATM9mMA2Ow/MopyK/2lO
         vHGZqRKvYT8WThTkry8zU65QkQLX7SVVlZ/FqWvaXnMCsralckFYUkurwcGODtBCaN3j
         De0GElRUk15hbzP0PxM68gEatQfg58470iV6ZVmT8I7lZPqigvnHOYMz1/0x+wFiKVOy
         X8VQ==
X-Gm-Message-State: AOAM532H2PkCkigrLhAjb+ZwxY4CZpCtFOxLLnMjKCMO1im0f3k3/lEn
        g2dbherHK0bfYYBmDA/318QXxA==
X-Google-Smtp-Source: ABdhPJxSqKyEA2wbIvfDs5E8BVg1B50eu94EXrlDS3SC+PEBF0OrHZ1r0uSnSUNP25yuwBMFrfZePg==
X-Received: by 2002:a05:6830:4392:: with SMTP id s18mr5399396otv.168.1637681086407;
        Tue, 23 Nov 2021 07:24:46 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r3sm2191435oti.51.2021.11.23.07.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:24:45 -0800 (PST)
Date:   Tue, 23 Nov 2021 07:26:28 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dang Huynh <danct12@riseup.net>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dts: treewide: Drop input-name property
Message-ID: <YZ0IJGJwy6O9ATpW@ripper>
References: <20211123065158.1383182-1-danct12@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123065158.1383182-1-danct12@riseup.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22 Nov 22:51 PST 2021, Dang Huynh wrote:

> This property doesn't seem to exist in the documentation nor
> in source code, but for some reason it is defined in a bunch
> of device trees.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>

Many thanks for the cleanup Dang. Unfortunately 32-bit Qcom, 64-bit
Qcom, the Mediatek and the sun8i changes goes through different
maintainer trees.

So if you could split this in 3 different patches that would make it
easier for us maintainers.

Thanks,
Bjorn

> ---
>  arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts          | 1 -
>  arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts             | 1 -
>  arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts     | 1 -
>  arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts              | 1 -
>  arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dts         | 1 -
>  arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts        | 1 -
>  arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts        | 1 -
>  arch/arm/boot/dts/sun8i-h3-nanopi.dtsi                       | 1 -
>  arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi             | 1 -
>  arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts            | 1 -
>  arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi     | 1 -
>  arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi   | 1 -
>  arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts              | 3 ---
>  arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi    | 2 --
>  arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi        | 1 -
>  arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts | 1 -
>  16 files changed, 19 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
> index f8c97efc61fc..0cee62c7b8b0 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
> @@ -19,7 +19,6 @@ chosen {
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&gpio_keys_pin_a>;
> diff --git a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
> index ea15b645b229..6d77e0f8ca4d 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
> @@ -20,7 +20,6 @@ chosen {
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&gpio_keys_pin_a>;
> diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> index 30ee913faae6..069136170198 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> @@ -450,7 +450,6 @@ bcrmf@1 {
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&gpio_keys_pin_a>;
> diff --git a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
> index 003f0fa9c857..96e1c978b878 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
> @@ -349,7 +349,6 @@ bluetooth {
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&gpio_keys_pin_a>;
> diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dts
> index 398a3eaf306b..79e2cfbbb1ba 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dts
> @@ -20,7 +20,6 @@ chosen {
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&gpio_keys_pin_a>;
> diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
> index b4dd85bd4faf..e66937e3f7dd 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
> @@ -20,7 +20,6 @@ chosen {
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&gpio_keys_pin_a>;
> diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
> index 9743beebd84d..a62e5c25b23c 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
> @@ -20,7 +20,6 @@ chosen {
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&gpio_keys_pin_a>;
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
> index c7c3e7d8b3c8..1eabc69462d4 100644
> --- a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
> @@ -75,7 +75,6 @@ led-1 {
>  
>  	r_gpio_keys {
>  		compatible = "gpio-keys";
> -		input-name = "k1";
>  
>  		k1 {
>  			label = "k1";
> diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> index fcddec14738d..7a717f926929 100644
> --- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> @@ -25,7 +25,6 @@ optee: optee@4fd00000 {
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&gpio_keys_default>;
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
> index 69fcb6b0398d..84558ab5fe86 100644
> --- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
> @@ -42,7 +42,6 @@ framebuffer0: framebuffer@3404000 {
>  
>  	gpio_keys {
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		autorepeat;
> diff --git a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
> index 3a3790a52a2c..cc038f9b641f 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
> @@ -62,7 +62,6 @@ divclk4: divclk4 {
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  		autorepeat;
>  
>  		volupkey {
> diff --git a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
> index 7cc564d8ca7c..dde7ed159c4d 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
> @@ -29,7 +29,6 @@ / {
>  
>  	gpio_keys {
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		autorepeat;
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> index 3d495ce3f46a..dc5b9b274df3 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> @@ -29,7 +29,6 @@ extcon_usb: extcon-usb {
>  
>  	gpio-hall-sensors {
>  		compatible = "gpio-keys";
> -		input-name = "hall-sensors";
>  		label = "Hall sensors";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&hall_sensor1_default>;
> @@ -46,7 +45,6 @@ hall-sensor1 {
>  
>  	gpio-kb-extra-keys {
>  		compatible = "gpio-keys";
> -		input-name = "extra-kb-keys";
>  		label = "Keyboard extra keys";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&gpio_kb_pins_extra>;
> @@ -102,7 +100,6 @@ alt {
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		input-name = "side-buttons";
>  		label = "Side buttons";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> index 91e391282181..47488a1aecae 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> @@ -93,7 +93,6 @@ vph_pwr: vph-pwr-regulator {
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  		label = "Side buttons";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&vol_down_pin_a>, <&cam_focus_pin_a>,
> @@ -126,7 +125,6 @@ camera-focus {
>  
>  	gpio-hall-sensor {
>  		compatible = "gpio-keys";
> -		input-name = "hall-sensors";
>  		label = "Hall sensors";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&hall_sensor0_default>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> index e90c9ec84675..42af1fade461 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> @@ -90,7 +90,6 @@ cam_vana_rear_vreg: cam_vana_rear_vreg {
>  	gpio_keys {
>  		status = "okay";
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> index 45eab0235d66..871ccbba445b 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> @@ -42,7 +42,6 @@ extcon_usb: extcon-usb {
>  	gpio-keys {
>  		status = "okay";
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		autorepeat;
> -- 
> 2.34.0
> 
