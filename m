Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5BF45FFDE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 16:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346741AbhK0Pev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 10:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbhK0Pcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 10:32:50 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2FC061574;
        Sat, 27 Nov 2021 07:29:35 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so51655416edc.6;
        Sat, 27 Nov 2021 07:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uZa3lGg5TVVsYTVzd3SjTqIXOm+Tj/rVIJizF1jMhDo=;
        b=Gfb1s3RJtTBdXYydL0Bj53WQBhKrUqbf+DTcezy4bxbvNBf5o0gytuMO7gefd6w8Wy
         B8H/cQ3hsXH7XFzj1HU4QD5cn2xJP4fAW7DI2J+yTCRdh6q1d0AkT8XnFI5H8uKvDlya
         jgNuWOyX9yU47p4snDazNbcOVHa4tYwTEEe+nBN3navZwwKLGkS17E8pIGqKBAN8qwwm
         v385C7AHMe7RA1kt7ibJ1yaFFXRsycmO7rkKSQdBIoe6Wo5wACTdODJlMPXF+clfW2mh
         zjiw5+J2JNVUFXqWOkm0yHQZzHlNudZejbY8f5eKXvARObtmSyJSIw1peMHCWsBYABtL
         Vxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uZa3lGg5TVVsYTVzd3SjTqIXOm+Tj/rVIJizF1jMhDo=;
        b=ZXMSQZ0Ss93QQwDQkGE2N70E3xhWHOVH6rYqEcvb3RzVLwknuUW+ivfGb2CsUDHNdx
         sHLPF+FTlov3nZfebQvO0G6sZGtviiRPQ3cDIEmtDXAMj8nZNAWP2AE1lbCBJRnDEdyh
         ZaoVJLVpWCoPRnZct9r9foxoVkSCodKutB0kIB0ZsXCG9NN4yard5hWOZonDvt1LKEeE
         Fd4fafueC1yDS2vOloP7yrr+J6tPLXTAUKkXvcQ9wuqhfbVVvaj2SkvkA2qWwqdjoq9P
         lg/DCQv8B4LuYt0Q90agbEzPYQigRYcxgMBX082Swv7X/ZdhG9dZaoV0s6+2ZAZhNhW0
         dt8Q==
X-Gm-Message-State: AOAM531S6SwTdCtRHRrBAwHBpt3NAWngtr1vzYuNG3ct1mmTUj7Ap2kj
        1ps38R3jY4dYhQgksvKbzWkEr/3X3j0=
X-Google-Smtp-Source: ABdhPJy21OW5YxatYCV4Gr34x0UNkM8gcFS2g3sPwsA5IPwmtOmFhwH92iC6nVLR2mpGPjuB2MKtJg==
X-Received: by 2002:a17:907:868f:: with SMTP id qa15mr47300758ejc.187.1638026974377;
        Sat, 27 Nov 2021 07:29:34 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h10sm5826804edj.1.2021.11.27.07.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 07:29:34 -0800 (PST)
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add spi1 pins on Quartz64 A
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211127141910.12649-1-frattaroli.nicolas@gmail.com>
 <20211127141910.12649-4-frattaroli.nicolas@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <acbd0e0a-b194-7b17-148d-49fdd348077e@gmail.com>
Date:   Sat, 27 Nov 2021 16:29:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211127141910.12649-4-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/21 3:19 PM, Nicolas Frattaroli wrote:
> The Quartz64 Model A has the SPI pins broken out on its pin
> header. The actual pins being used though are not the m0
> variant, but the m1 variant, which also lacks the cs1 pin.
> 
> This commit overrides pinctrl-0 accordingly for this board.
> 
> spi1 is intentionally left disabled, as anyone wishing to add
> SPI devices needs to edit the dts anyway, and the pins are more
> useful as GPIOs for the rest of the users.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> index 4d4b2a301b1a..166399b7f13f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> @@ -509,6 +509,11 @@ &spdif {
>  	status = "okay";
>  };
>  
> +&spi1 {

> +	pinctrl-names = "default";

With the removal off pinctrl-1 the pinctrl-names property is already
correctly defined.

+	spi1: spi@fe620000 {
+		compatible = "rockchip,rk3568-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xfe620000 0x0 0x1000>;
+		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru CLK_SPI1>, <&cru PCLK_SPI1>;
+		clock-names = "spiclk", "apb_pclk";
+		dmas = <&dmac0 22>, <&dmac0 23>;
+		dma-names = "tx", "rx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi1m0_cs0 &spi1m0_cs1 &spi1m0_pins>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};

> +	pinctrl-0 = <&spi1m1_cs0 &spi1m1_pins>;
> +};
> +
>  &tsadc {
>  	/* tshut mode 0:CRU 1:GPIO */
>  	rockchip,hw-tshut-mode = <1>;
> 
