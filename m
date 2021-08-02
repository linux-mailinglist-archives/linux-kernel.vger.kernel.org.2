Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F11D3DD64C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 15:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhHBNAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 09:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbhHBNAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 09:00:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21356C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 05:59:58 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mAXXl-0001w6-BG; Mon, 02 Aug 2021 14:59:45 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:aa0:1a4:7dc:3804:a9bc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3E8D365EB3D;
        Mon,  2 Aug 2021 12:59:42 +0000 (UTC)
Date:   Mon, 2 Aug 2021 14:59:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 1/6] arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
Message-ID: <20210802125940.w2djzwuwysco566p@pengutronix.de>
References: <20210726101012.26983-1-a-govindraju@ti.com>
 <20210726101012.26983-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xdpgrz6pysvgzjon"
Content-Disposition: inline
In-Reply-To: <20210726101012.26983-2-a-govindraju@ti.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xdpgrz6pysvgzjon
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2021 15:40:07, Aswath Govindraju wrote:
> From: Faiz Abbas <faiz_abbas@ti.com>
>=20
> Add Support for two MCAN controllers present on the am65x SOC. Both suppo=
rt
> classic CAN messages as well as CAN-FD.
>=20
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 30 +++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dt=
s/ti/k3-am65-mcu.dtsi
> index c93ff1520a0e..6445f2d976e8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -159,6 +159,36 @@
>  		};
>  	};
> =20
> +	m_can0: mcan@40528000 {
> +		compatible =3D "bosch,m_can";
> +		reg =3D <0x0 0x40528000 0x0 0x400>,
> +		      <0x0 0x40500000 0x0 0x4400>;
> +		reg-names =3D "m_can", "message_ram";
> +		power-domains =3D <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
> +		clocks =3D <&k3_clks 102 0>, <&k3_clks 102 5>;
> +		clock-names =3D "cclk", "hclk";

The binding says the first should be hclk.

|  clock-names:
|    items:
|      - const: hclk
|      - const: cclk

Please also fix in the other dts files.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xdpgrz6pysvgzjon
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmEH7DoACgkQqclaivrt
76kxjwf9Gmlc6XvgdcEz4U7PNHFbVNMc1088UadMxSH07/kQAaRW90wlWXKlQTG2
tVFCdoj5cPqT4PVeqf1k5F/N/WicVa8SHTKZcpLQz1GZLVbXmVgI6zRKJOHVtGfI
32g9po0Xol0E5kPtMusw954W0elkTGO2CuWkhQ5DwODL3GElegqKfrz3IWueiR7E
Zk8GjJRdmP1BqFiokaT+/TEOSWMrzHNXO2EYahaEO6YEoc7CjA66eP+4tmH560rs
Kgr56k7Rghl5uF843geaZinyWPJLfH04K0yDnaKIltW9aLuavAABcHITJhsNO2fS
fjR/9fVIdGaorFu77/7WjEgeFw/51A==
=O+hV
-----END PGP SIGNATURE-----

--xdpgrz6pysvgzjon--
