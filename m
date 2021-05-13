Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7886537FE03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhEMT0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEMT0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:26:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904E8C061574;
        Thu, 13 May 2021 12:25:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t4so41476188ejo.0;
        Thu, 13 May 2021 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdjAwHav9XHkb4OJTI/S/82n2MEHOGNSzd+9Q7MwBlI=;
        b=VJTyhp3yPi6WTFmkeb7a0Q1W9ISu0fgTvI5N9deWIgpATsg/N6NO69OeO7GRKxt1ch
         dmyAGpCDTB5+Zk6s7ITyrmG6Yf7Nhd+qxB16TcPIhCGPQWqvSz/Ijzx+bucXrtk/jgCo
         MXdSXzp876UaR+Dh6XwLtqpqAtq7AhtD4ZYb7KYdkWqJnIehLsrQ8kAYgJMOCfcdSzZ9
         pAp575NilIjAArMK0micLRvkpm8HTsIEKTcbs+16eiPsnGJzXzkfNJ/w3T3e/d1JTIEx
         cCWfGu0YKTd6sCqm4bEAMJYieHtRayKRNU7en0HVzVp5xcepNsnyRp3tAUrg4NScwH/S
         JiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdjAwHav9XHkb4OJTI/S/82n2MEHOGNSzd+9Q7MwBlI=;
        b=Y/FfLAVk271CDeZMasq3JAYL5P5+9ouObouTquhJ0eHVLbAVhXaPljpSBgoqtoBeIt
         PdmDlzlqzic2sHJCzPFJPczb5B8Zl2uhbUYOGWMaRAAaeUnnMVfceh8EmdPkRSlBQptU
         f9WqEkeNKZYONJ3961pgsdeLoJpqkLI2odGKq1FObxgnCrlMNt3nWSELlgl6/Agru1hb
         Tf2s+nunyO8xCCzGQicAf9dfeJfzBATkT8y7ZYE9R8rWRJl8OonkG/eBHVPU0U8GZo95
         SRjXSMN8lMYlDaYbgAIgHARJPnvIaEiBwZJY1I6RiuB2rYpxGbBNlg1tKIx2hbJhSYnf
         j+og==
X-Gm-Message-State: AOAM532++G5NtTIWZOD8CYJoe3Bzz3EPwwIFDk/lFLYuxYXMQ5WxThGT
        VxnS+78+NwEr4F9T0UOS9Jj54O5OvkM=
X-Google-Smtp-Source: ABdhPJx985AJNAIN12coIvRDsCCnCxb11Q2pIexJUFbevqajxiLAKNiXVG2c+BCNswJEgCbZbXu9EA==
X-Received: by 2002:a17:906:f894:: with SMTP id lg20mr7994685ejb.355.1620933906272;
        Thu, 13 May 2021 12:25:06 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id ch30sm2916975edb.92.2021.05.13.12.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 12:25:05 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: Re: [PATCH 4/4] ARM: dts: sun8i: V3: add I2S interface to V3 dts
Date:   Thu, 13 May 2021 21:25:04 +0200
Message-ID: <2916483.liAivg88ip@kista>
In-Reply-To: <20210513190949.2069235-5-t.schramm@manjaro.org>
References: <20210513190949.2069235-1-t.schramm@manjaro.org> <20210513190949.2069235-5-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 13. maj 2021 ob 21:09:49 CEST je Tobias Schramm napisal(a=
):
> The Allwinner V3 SoC features an I2S interface. The I2C peripheral is

I2C -> I2S

> identical to that in the Allwinner H3 SoC.
> This commit adds it to the Allwinner V3 dts.
>=20
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  arch/arm/boot/dts/sun8i-v3.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-v3.dtsi b/arch/arm/boot/dts/sun8i-
v3.dtsi
> index c279e13583ba..0061c49523f2 100644
> --- a/arch/arm/boot/dts/sun8i-v3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3.dtsi
> @@ -1,10 +1,30 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
>   * Copyright (C) 2019 Icenowy Zheng <icenowy@aosc.io>
> + * Copyright (C) 2021 Tobias Schramm <t.schramm@manjaro.org>

It's uncommon to add additional copyrights just for one node, but ok.

>   */
> =20
>  #include "sun8i-v3s.dtsi"
> =20
> +/ {
> +	soc {
> +			i2s0: i2s@1c22000 {
> +				#sound-dai-cells =3D <0>;
> +				compatible =3D "allwinner,sun8i-h3-
i2s";

You have to add v3s compatible as a fallback (and document it in devicetree=
=20
documentation).

Best regards,
Jernej

> +				reg =3D <0x01c22000 0x400>;
> +				interrupts =3D <GIC_SPI 13=20
IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&ccu CLK_BUS_I2S0>,=20
<&ccu CLK_I2S0>;
> +				clock-names =3D "apb", "mod";
> +				dmas =3D <&dma 3>, <&dma 3>;
> +				dma-names =3D "rx", "tx";
> +				pinctrl-names =3D "default";
> +				pinctrl-0 =3D <&i2s0_pins>;
> +				resets =3D <&ccu RST_BUS_I2S0>;
> +				status =3D "disabled";
> +			};
> +	};
> +};
> +
>  &ccu {
>  	compatible =3D "allwinner,sun8i-v3-ccu";
>  };
> @@ -25,6 +45,11 @@ external_mdio: mdio@2 {
>  &pio {
>  	compatible =3D "allwinner,sun8i-v3-pinctrl";
> =20
> +	i2s0_pins: i2s0-pins {
> +		pins =3D "PG10", "PG11", "PG12", "PG13";
> +		function =3D "i2s";
> +	};
> +
>  	uart1_pg_pins: uart1-pg-pins {
>  		pins =3D "PG6", "PG7";
>  		function =3D "uart1";
> --=20
> 2.30.1
>=20
>=20
>=20


