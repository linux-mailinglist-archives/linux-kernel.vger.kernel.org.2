Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A4E37FE21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhEMTcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhEMTcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:32:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E97C061574;
        Thu, 13 May 2021 12:31:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id c20so6019924ejm.3;
        Thu, 13 May 2021 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sIneDrztHlzfZDsDoR1ltUw2NBHkYDwnKGPP0MESg80=;
        b=Iw6gkgJs7644L2zzeRk5yF/j4VObMdQwuxqK3iE9uQrmyxGnPXKPx8H7V813PkZkgB
         yePu9rPJLQShTS9i5QDMAHXtZZ42WeO5em87tqSl0sIg1yamNyjPT2Yll+aOgxFzk1Qc
         zfcYuTis5Sd1B+aS7TOTMn3rxg0m/FJa9NF1B2rboVLfNkceVf+JMtMqrcU92U0DqQkx
         4iK9SLQvQDDZfyqdwps9p68jovyLqVmqLN4VMcrj4Q++Tepb5VhxzheRuKVP2pQaoLO4
         oyMtyJDL3msiMoRy6cpk295t0USEF6iQ+6czlahpwOvZlUF/C1My7IRfLx3xs3/Dh85m
         Ugxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sIneDrztHlzfZDsDoR1ltUw2NBHkYDwnKGPP0MESg80=;
        b=hIMARlhR8/nPj5O+a8xdB3DeLjQoSYYg+j0s9mHvc5qgb9fzm9UNPlzivR8HKMuEeg
         207NsMgGxSsozMAyKtl5z3k6DiGjn6jO8ae82fqiaThPsC+cPj051lx7ckP7kJ1WtEQQ
         y/J7H4/eQZ3uwL2RoSAzXGO7XHj9QQbW1FehBdJ2n4ZjANNQI7fQoyH6NawE5VSa38La
         cYAwULTLSkUtNhpR38kZ3jyQ+k+WkHpEioYoS6ETYU+OnN9q/pGd39pS60khme46em9O
         NTHI8BQbExB9ZP71BhylT/E4IgaKnPTzBcefD0KJUuIm0SgCgpRqt/YNMrKwpzkIEvxO
         i5sQ==
X-Gm-Message-State: AOAM533YgzMgCATQp3LzKbF7OPt4dlc+bWJk2lwXIcC+tYXJpxLSCCSt
        eFiznkg3yonqMErxNPBxfN4=
X-Google-Smtp-Source: ABdhPJxqA6G2A+/c9u5jQZTer9Dbo34u82WiGTbxaJZC5nht1fmqkJIs06E81t1e1YvC4eZN2NAZzg==
X-Received: by 2002:a17:906:17cc:: with SMTP id u12mr44465742eje.170.1620934267291;
        Thu, 13 May 2021 12:31:07 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id eb9sm2267116ejc.96.2021.05.13.12.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 12:31:06 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: Re: [PATCH] ARM: dts: sun8i: v3s: add pwm controller to v3s dts
Date:   Thu, 13 May 2021 21:31:05 +0200
Message-ID: <1631853.U6U3tl3vTp@kista>
In-Reply-To: <20210513182000.2068223-1-t.schramm@manjaro.org>
References: <20210513182000.2068223-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne =C4=8Detrtek, 13. maj 2021 ob 20:20:00 CEST je Tobias Schramm napisal(a=
):
> The Allwinner V3s and V3 SoCs feature a pwm controller identical to the
> one used in the Allwinner A20.
> This commit adds it to the V3s dtsi.
>=20
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-
v3s.dtsi
> index 770f5a25ab4c..22bc5ab4c3ca 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -433,6 +433,14 @@ wdt0: watchdog@1c20ca0 {
>  			clocks =3D <&osc24M>;
>  		};
> =20
> +		pwm: pwm@1c21400 {
> +			compatible =3D "allwinner,sun7i-a20-pwm";

Add V3s fallback compatible (as a first one) here and document it.

Best regards,
Jernej

> +			reg =3D <0x01c21400 0xc>;
> +			clocks =3D <&osc24M>;
> +			#pwm-cells =3D <3>;
> +			status =3D "disabled";
> +		};
> +
>  		lradc: lradc@1c22800 {
>  			compatible =3D "allwinner,sun4i-a10-lradc-
keys";
>  			reg =3D <0x01c22800 0x400>;
> --=20
> 2.30.1
>=20
>=20
>=20


