Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A703CFD18
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbhGTOaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 10:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239251AbhGTOSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:18:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DC5C0613E5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:55:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m5r93-0005YD-P2; Tue, 20 Jul 2021 16:54:53 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3120:e42a:5796:3403])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 85AC7653114;
        Tue, 20 Jul 2021 14:54:52 +0000 (UTC)
Date:   Tue, 20 Jul 2021 16:54:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 3/6] arm64: dts: ti: k3-j721e: Add support for MCAN nodes
Message-ID: <20210720145451.6eby7pbfocyyfi4e@pengutronix.de>
References: <20210720141642.24999-1-a-govindraju@ti.com>
 <20210720141642.24999-4-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6jwdpencjrsa3vlk"
Content-Disposition: inline
In-Reply-To: <20210720141642.24999-4-a-govindraju@ti.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6jwdpencjrsa3vlk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.07.2021 19:46:39, Aswath Govindraju wrote:
> From: Faiz Abbas <faiz_abbas@ti.com>
>=20
> Add support for 14 MCAN controllers in main domain and 2 MCAN controllers
> present in mcu domain. All the MCAN controllers support classic CAN
> messages as well as CAN_FD messages.
>=20
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 196 ++++++++++++++++++
>  .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  28 +++
>  2 files changed, 224 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/=
dts/ti/k3-j721e-main.dtsi
> index cf3482376c1e..4215b8e6785a 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -1940,4 +1940,200 @@
>  			bus_freq =3D <1000000>;
>  		};
>  	};
> +
> +	main_mcan0: can@2701000 {
> +		compatible =3D "bosch,m_can";
> +		reg =3D <0x00 0x02701000 0x00 0x200>,
> +		      <0x00 0x02708000 0x00 0x8000>;
> +		reg-names =3D "m_can", "message_ram";
> +		power-domains =3D <&k3_pds 156 TI_SCI_PD_EXCLUSIVE>;
> +		clocks =3D <&k3_clks 156 1>, <&k3_clks 156 0>;
> +		clock-names =3D "cclk", "hclk";
> +		interrupts =3D <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names =3D "int0", "int1";
> +		bosch,mram-cfg =3D <0x0 0 0 32 0 0 1 1>;

Are you intentionally only enabling 1 TX buffer?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6jwdpencjrsa3vlk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmD247kACgkQqclaivrt
76lVTAf7BxARQemdI/grdAbkCnO19bcj3W8asUsVaoEEfO75JYMKeagw7B+D45me
WDY/I0hbL28FlSdPqVIgaiz552y4/FjdlD7KOGT4m8L9WWKHpS8QD5R6kF2UmaRv
7jr4Hsvb0ZbqkVPb5y1vr4e/EphaqaoCTuPEUqS+Mz+vK0vmyF38STY9+oEivUsW
BrnGUSCTGAQjq0fkQlFx4JkSQ1MaboEIBgYbs0PlRFYwZ2JRn0zLFmqxKt9OLoNN
ZjlPcGcqf0yP7T6ipBZreyICFdM5nbO5k+xNbrWFqzrVLiIV5OHLgZvczq9E+ZuI
ie2MC9BVaMYFk2dL7DfktZXrCvEvsA==
=/sqn
-----END PGP SIGNATURE-----

--6jwdpencjrsa3vlk--
