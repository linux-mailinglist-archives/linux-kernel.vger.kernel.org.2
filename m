Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9B73097AD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 19:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhA3Sv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 13:51:57 -0500
Received: from mout.gmx.net ([212.227.17.22]:57345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231715AbhA3Svy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 13:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612032591;
        bh=pclPnpYLdC+dLvepA/sMNjeeUKX1+hC69GlNQVNIAog=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=aqdM5+/6kn5DSgRSlEajDDKJ1+Oejya3kyzwQpo9Qxu1nk/vMdxSTI5jKMgZDDklP
         NtC0bOkepM7I4F1G8VVWyBgqBXgyeMBopgSi4Napylx8yE3mE5Dtto3G+fhOcplygw
         N8SlSU7S345JT1nTUbOAHhab1pH1xGs1QUJNj6h8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysW2-1lsoiD0nCc-00w1AD; Sat, 30
 Jan 2021 19:49:51 +0100
Date:   Sat, 30 Jan 2021 19:49:49 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan Neuschaefer <j.neuschaefer@gmx.net>,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mtd: spi-nor: core: fix/remove references to spi-nor.c
Message-ID: <YBWqTRLCfXyKNptd@latitude>
References: <20210126092516.1431913-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wI9p3h9l5IyRJxxJ"
Content-Disposition: inline
In-Reply-To: <20210126092516.1431913-1-f.suligoi@asem.it>
X-Provags-ID: V03:K1:V66xgt7nTLghDjmzC9TWw+/LZoNamcHZ1uDpCoUn3hoFn7nokFy
 5OPeAczuXCgsu3egzEuDMZR+kHcU56XSE4FgXnHGYZZ7g9JkmIFoCeapodHN37owK3TpzLu
 H3ITIQCheOXOB5EXOB6rj7js/+k8zGTWCPZj1avnpxHZD8wQwcUJEELoUIa/A4CSGYGH6aa
 rJWmefanGHcCltzbY/Cow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WiEUPf7FMRc=:DJVkcdsJp2PoVokcHLbwOl
 dXA4HEMPzky5gzVUd/bCkyTgpnbPGLKo10qSXqp9w9PxrgX6Qs8B2WvnoA3e7+AuXVZQO0Qoe
 RRsKIYlb1Kbdo/mk77ytzUfHG/Bp9Yi7NgiuTMnTAa9GSy4mHxm9CwgRRLjaqswVY0Ga99m4E
 YrS9jqSSgN/SMtttqvvZukN9tRbxtMAVufykN93oQufN8T6UOR24AEXY14FXuf6w+6hEYTzoT
 gjRay8hCUrqclvroxi3yvwFmQ1dSHeagTS2HEpZXxSgvYyG6utfgi16nroKcnH7HBWcvwBesU
 /y/h7ydiPdKbLoi3x3aAZlK+HcrV2HmYLm0/sZ5iCYA+LnLn4EQpKO4rh2jX1IrTsOuFgqNdR
 7HZ8PhGScRPBXLeI1SpT0BdfX9wZg/HwpK7XVqpfxXNnl5D1n4lg/Z57NMMFvZmn7exJ8hccm
 lkzlITT1S1AvKeBT/x/jfpHl6bWNsUSvD6Isl9XFafnR+3o/iw31WHSyOy2DcQvI6QpO1KvKC
 l/7PE3pxxgkySYbdhi6qJD/iUeDB+ixgUGmyfzKNDTo9ULpo7dsgwtRJtiHXc/yKNkGIteHiD
 zsG/VDPrcTb4mSRkJYFOoJ+rUUWoKYUDvYvaZekgFiIzISLBe5yNa37Zd0cnglqSDrX4HKfcg
 jFTVCyIbersobWr0bgEVdqQbjhxZN0Kdl7i3TDYgSVky5CqoxkfzvpStvkepyqr8ofJplu1h/
 ZTKgFxmwFB9yyY8H/na22032BBxuFFLI4e8Deo5bPgZoQ0CcX4Qumjx/mxmz/3jnLOq4vXk5q
 1c6NJpYLEedVSAq54Pu/+Nrt98wMIFEmwpbt4BzUalU4BQY6mELkf4mJuMp+FwkG61EHeFbXo
 DN1sv9Wl8ysB/8R3lOAg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wI9p3h9l5IyRJxxJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 26, 2021 at 10:25:16AM +0100, Flavio Suligoi wrote:
> The old file:
>=20
> drivers/mtd/spi-nor/spi-nor.c
>=20
> is not more present and now some of its code is
> contained in:
>=20
> drivers/mtd/spi-nor/core.c
>=20
> This patch fix/remove the references to the old
> spi-nor.c file.
>=20
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Thanks.


>  Documentation/driver-api/mtd/spi-nor.rst | 2 +-
>  drivers/mtd/spi-nor/core.c               | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/driver-api/mtd/spi-nor.rst b/Documentation/dri=
ver-api/mtd/spi-nor.rst
> index 4a3adca417fd..bf2db371d3fb 100644
> --- a/Documentation/driver-api/mtd/spi-nor.rst
> +++ b/Documentation/driver-api/mtd/spi-nor.rst
> @@ -61,7 +61,7 @@ Part III - How can drivers use the framework?
> =20
>  The main API is spi_nor_scan(). Before you call the hook, a driver should
>  initialize the necessary fields for spi_nor{}. Please see
> -drivers/mtd/spi-nor/spi-nor.c for detail. Please also refer to spi-fsl-q=
spi.c
> +drivers/mtd/spi-nor/core.c for detail. Please also refer to spi-fsl-qspi=
=2Ec
>  when you want to write a new driver for a SPI NOR controller.
>  Another API is spi_nor_restore(), this is used to restore the status of =
SPI
>  flash chip such as addressing mode. Call it whenever detach the driver f=
rom
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 20df44b753da..6ae7d4c2d2b6 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3701,8 +3701,8 @@ static void spi_nor_shutdown(struct spi_mem *spimem)
>   * encourage new users to add support to the spi-nor library, and simply=
 bind
>   * against a generic string here (e.g., "jedec,spi-nor").
>   *
> - * Many flash names are kept here in this list (as well as in spi-nor.c)=
 to
> - * keep them available as module aliases for existing platforms.
> + * Many flash names are kept here in this list to keep them available
> + * as module aliases for existing platforms.
>   */
>  static const struct spi_device_id spi_nor_dev_ids[] =3D {
>  	/*
> --=20
> 2.25.1
>=20

--wI9p3h9l5IyRJxxJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmAVqj8ACgkQCDBEmo7z
X9uYtQ/+Kyf6rbT8uYEzJDIpKYjRo1XokEoanbc2YkMTFeZiFLCH4XnNTl26QeBo
TDTxGZ6SXWbH7e1hYnu5nEHPA/Ld56ah3kZvC1ncNWAiPxj5dlnYabs13u5NjpoI
Dehw2xVq7Cj5XhOsItu7SgcVL/agydg72xgoEXOEXejrD2d4TFGp3a2KfGu33Fh2
7oN25wb8P06wJPrM8aWZWC5jb+iDDOURsJD32bXDufGKISF09UrbLvpo3+H5LL8F
SVGYOvaFidk8sEHb65Lp91lyG4EMicZM7ItHtmkLKAhBaCgE2wrBVqoeFsWO0TBe
4ONikf9nZMGKaIHhG6i8+ou2xcKvx00ilpTvSxUCOPbSmwkUbTnFnDWfKm+2gpGP
nRCSfhybqoVV55iMjVsnpkVS5laahk+nIY0M9U+GjEX0bSzDPcsDpmH7PrczIoHx
3TxWNfe1auFbAuLT0zGdtgcw0jujdVPe8qWggeVbnxp2t+tecylx5lep6NgxS7Tj
Yxqmuv+l+rtZhetcbIqLZ/tpKPaMD9hTpP7iM8gUTBL6xaaxbLuZgRpkjFZCO6Vb
3CK6rwqE2uG73Ut5Ln32GyBwl8etpw+StMn4QA0urLK6f0QIApJXqEQM8t/wSRoz
t/OJRElGzFBj3sL1YmMl3FyeBMfzO50/eFcgIJPit3y4UYIdPV4=
=q3ZK
-----END PGP SIGNATURE-----

--wI9p3h9l5IyRJxxJ--
