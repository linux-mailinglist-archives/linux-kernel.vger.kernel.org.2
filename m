Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0126305C75
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbhA0NGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:06:39 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39575 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbhA0NDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:03:53 -0500
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5B6B9E0007;
        Wed, 27 Jan 2021 13:03:04 +0000 (UTC)
Date:   Wed, 27 Jan 2021 14:03:03 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] soc: sunxi: mbus: Remove DE2 display engine
 compatibles
Message-ID: <YBFkh/faoPnTRZtl@aptenodytes>
References: <20210115175831.1184260-1-paul.kocialkowski@bootlin.com>
 <20210115175831.1184260-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bbVqFsb3TWznXX56"
Content-Disposition: inline
In-Reply-To: <20210115175831.1184260-2-paul.kocialkowski@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bbVqFsb3TWznXX56
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri 15 Jan 21, 18:58, Paul Kocialkowski wrote:
> The DE2 display engine hardware takes physical addresses that do not
> need PHYS_BASE subtracted. As a result, they should not be present
> on the mbus driver match list. Remove them.
>=20
> This was tested on the A83T, along with the patch allowing the DMA
> range map to be non-NULL and restores a working display.

Could we get this merged ASAP (in this RC cycle), hopefully with the patch
that superseded 1/2 from this series so that we don't end up with either
CSI or DE2 broken in the next release?

Cheers,

Paul

> Fixes: b4bdc4fbf8d0 ("soc: sunxi: Deal with the MBUS DMA offsets in a cen=
tral place")
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/soc/sunxi/sunxi_mbus.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/soc/sunxi/sunxi_mbus.c b/drivers/soc/sunxi/sunxi_mbu=
s.c
> index e9925c8487d7..d90e4a264b6f 100644
> --- a/drivers/soc/sunxi/sunxi_mbus.c
> +++ b/drivers/soc/sunxi/sunxi_mbus.c
> @@ -23,12 +23,7 @@ static const char * const sunxi_mbus_devices[] =3D {
>  	"allwinner,sun7i-a20-display-engine",
>  	"allwinner,sun8i-a23-display-engine",
>  	"allwinner,sun8i-a33-display-engine",
> -	"allwinner,sun8i-a83t-display-engine",
> -	"allwinner,sun8i-h3-display-engine",
> -	"allwinner,sun8i-r40-display-engine",
> -	"allwinner,sun8i-v3s-display-engine",
>  	"allwinner,sun9i-a80-display-engine",
> -	"allwinner,sun50i-a64-display-engine",
> =20
>  	/*
>  	 * And now we have the regular devices connected to the MBUS
> --=20
> 2.30.0
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--bbVqFsb3TWznXX56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmARZIcACgkQ3cLmz3+f
v9Emzwf+P8S2dFpKeB4P2PR3KW+FmVA7hWSXJBmQLEE4uG4DGUjORSMotAWQO4Qq
V1Gz1A1cd/eaRD9IvH/YC5mJqi1cP87bqZFmrD1LIrGgG5EdiSXKMYPLqnxtMY9W
XzraXD+Yau2dBlz4c4/r4X4rwQL7zmwssVoTheKHD9NlC8CG9+EuggFJ5tjCm0P+
+bsrm8xVpFwq9iI09tU9aqjOe9C5hh9EwjkD+2k6rcJubWHDPgUXV4ID9wBWrf3u
C3eWR2qxK9dM1dGibTjYStM5GHBCunIEH11VcN6j0ZayIRNmLqeqWimw0+mJ5qrr
X5PE5cbITJLLMvJjSZikSzW6Drno3g==
=AG+n
-----END PGP SIGNATURE-----

--bbVqFsb3TWznXX56--
