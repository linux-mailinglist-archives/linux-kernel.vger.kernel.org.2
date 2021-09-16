Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8FF40D9AB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbhIPMTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:19:33 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:49298 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbhIPMTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:19:33 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Sep 2021 08:19:32 EDT
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 256ABF40B33; Thu, 16 Sep 2021 14:12:41 +0200 (CEST)
Date:   Thu, 16 Sep 2021 14:12:40 +0200
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: NVMEM_NINTENDO_OTP should depend on WII
Message-ID: <20210916121240.okknaglns4bjmczp@luna>
Jabber-ID: linkmauve@linkmauve.fr
References: <01318920709dddc4d85fe895e2083ca0eee234d8.1631611652.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4qla4vdo44bvrd6u"
Content-Disposition: inline
In-Reply-To: <01318920709dddc4d85fe895e2083ca0eee234d8.1631611652.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4qla4vdo44bvrd6u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, thanks for this patch, once the Wii=A0U platform will be added it will
need an additional test for WIIU, but for now this is:

Reviewed-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>

On Tue, Sep 14, 2021 at 11:29:49AM +0200, Geert Uytterhoeven wrote:
> The Nintendo Wii and Wii U OTP is only present on Nintendo Wii and Wii U
> consoles.  Hence add a dependency on WII, to prevent asking the user
> about this driver when configuring a kernel without Nintendo Wii and Wii
> U console support.
>=20
> Fixes: 3683b761fe3a10ad ("nvmem: nintendo-otp: Add new driver for the Wii=
 and Wii U OTP")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/nvmem/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 39854d43758be3fb..da414617a54d4b99 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -109,6 +109,7 @@ config MTK_EFUSE
> =20
>  config NVMEM_NINTENDO_OTP
>  	tristate "Nintendo Wii and Wii U OTP Support"
> +	depends on WII || COMPILE_TEST
>  	help
>  	  This is a driver exposing the OTP of a Nintendo Wii or Wii U console.
> =20
> --=20
> 2.25.1

--=20
Emmanuel Gil Peyrot

--4qla4vdo44bvrd6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEjrVT1SzTln43kCLJOWgfYkb2LpAFAmFDNLQACgkQOWgfYkb2
LpA6OQgAqnp5vZBBdcMfXSA8IEnqzcZRa0PHdW/d3FK7bczJocUPNc4mvQFexP0t
7AuWaXNMOEWq2xOd05eggwhSQgB2OMZ/wtA63fKOrP5gq1QdzSN5hDzM2ew1MnyR
x8x/CoMc4JOk/mmbZFSTiYx8wC3M37uCkfugZdS0actXv/2kuiWfPhUIvvlrZG92
ebYlFUQMhQX43c62Au0DUCwRy0VQJW2+lRVlIHghtrSUfey1m79qfICnt5+g5Llv
DA0kchTFuBpyO2s3pGAmKnd3fCOQ8jBtqLgg3ZJNrqbfwnl3ezoS7f0tw8qQeBQy
4VVzKdfPm7I3b9Od3GDm8Suv9HIvtg==
=6DDx
-----END PGP SIGNATURE-----

--4qla4vdo44bvrd6u--
