Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DE841FCAF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 17:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhJBPVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 11:21:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56714 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbhJBPVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 11:21:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id ADC021F44931
Received: by earth.universe (Postfix, from userid 1000)
        id C2AD73C0CA8; Sat,  2 Oct 2021 17:19:33 +0200 (CEST)
Date:   Sat, 2 Oct 2021 17:19:33 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH] ARM: dts: imx6dl-b1x5v2: drop unsupported vcc-supply for
 MPL3115A2
Message-ID: <20211002151933.4p47qostpheldpr3@earth.universe>
References: <20210920182227.339577-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pwvhzfyyfezbrgkg"
Content-Disposition: inline
In-Reply-To: <20210920182227.339577-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pwvhzfyyfezbrgkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 20, 2021 at 08:22:27PM +0200, Krzysztof Kozlowski wrote:
> The MPL3115A2 I2C pressure sensor driver does not take a VCC regulator.
> The bindings are so far trivial, but the datasheet does not have a VCC
> pin.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

FWIW &reg_3v3_acm is connected to VDD obviously, but it's an
always-on regulator without any means to control it, so there
is no need to describe it.

-- Sebastian

>  arch/arm/boot/dts/imx6dl-b1x5v2.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/imx6dl-b1x5v2.dtsi b/arch/arm/boot/dts/imx=
6dl-b1x5v2.dtsi
> index a326a331508e..f028b6a191df 100644
> --- a/arch/arm/boot/dts/imx6dl-b1x5v2.dtsi
> +++ b/arch/arm/boot/dts/imx6dl-b1x5v2.dtsi
> @@ -47,7 +47,6 @@ &i2c5 {
>  	mpl3115a2: pressure-sensor@60 {
>  		compatible =3D "fsl,mpl3115";
>  		reg =3D <0x60>;
> -		vcc-supply =3D <&reg_3v3_acm>;
> =20
>  		/*
>  		 * The MPL3115 interrupts are connected to pin 22 and 23
> --=20
> 2.30.2
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--pwvhzfyyfezbrgkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFYeHkACgkQ2O7X88g7
+pqtIg//fMGCTweMUgdK4LAWx2sOeLerSt14MdRQnyVK6/8qmjIn1gj+mlg4EU3b
rF9lEFypzxCdZ2o8GQFewDJ66PXV90Wz9iBP75dgxnZPTyWDAm8pgoYDC95CWiSZ
/br+4/78IZV5fdHlDb5D74rKwWcjE9pFGNLCtBmAXBwLeF11hJsy6WZduMPsyB+v
qzFh+ZUi46p3KyWYNEPrlemJ9dtrfDGvL/ANtDtBdNp/hGRtY2Rra5vpYoxA7KbT
TO0uzwH1P4S4N9v6xijFv6B1jPCboimPqCf3eG2yQ8OVoF1tQSf0dcPnYLxceUKA
pjfkCoZeEjD2nNAiP1GJtj0pOdtkG90w5WnMhfPPv1wyW9Cc8HkI79TX4cV8IRla
Ce+838uCediYcItroEWZTQ1lPl5f91bbMSs9mOiHJCT/r/ZGVUlg66iTDrc7pXYo
x6sonqCuozJEf66lcLedAwNkkUMbH0QmK4+rJ1K8iv8X4/H/NxPYwvqI2RHiWLWn
PGSQZg1zVMYJGEyCzwVOBEoZ9RNhti8vszkooLQdu9+Y2NdGYs5WIAtfBNsjMuM5
WPo0AKhSThgvgYB+SbQ1KiKcN66uiQJAsheOoiiDwqTi4TEZm9ujE1ZlT+ky5Yix
GAQ2H2Q7y84mewlNe9fmG21ziuZU8vELC7SaVykwJz2BdXjETBk=
=3+Ry
-----END PGP SIGNATURE-----

--pwvhzfyyfezbrgkg--
