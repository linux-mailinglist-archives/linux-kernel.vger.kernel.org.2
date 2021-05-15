Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FD7381A60
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 20:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhEOSCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 14:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhEOSCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 14:02:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B65C061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 11:00:50 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lhyam-0004jX-AE; Sat, 15 May 2021 20:00:48 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lhyal-0005bT-G8; Sat, 15 May 2021 20:00:47 +0200
Date:   Sat, 15 May 2021 20:00:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thorsten Scherer <t.scherer@eckelmann.de>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] siox: Simplify error handling via dev_err_probe()
Message-ID: <20210515180047.mmwhm4wajf6dr4kt@pengutronix.de>
References: <20210515082017.1127580-1-t.scherer@eckelmann.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="frejqyo4ppldb22c"
Content-Disposition: inline
In-Reply-To: <20210515082017.1127580-1-t.scherer@eckelmann.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--frejqyo4ppldb22c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thorsten,

your mail is whitespace damaged and cannot be applied directly. As you
used git-send-email this is probably a case for Eckelmann IT ...

On Sat, May 15, 2021 at 10:20:17AM +0200, Thorsten Scherer wrote:
> a787e5400a1c ("driver core: add device probe log helper") introduced a
> helper for a common error checking pattern.  Use it.

Please test your patch using scripts/checkpatch and fix the issued
errors (or argument why you chose not to follow its recommendations).

> Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>
> ---
>  drivers/siox/siox-bus-gpio.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/siox/siox-bus-gpio.c b/drivers/siox/siox-bus-gpio.c
> index 46b4cda36bac..aeefeb725524 100644
> --- a/drivers/siox/siox-bus-gpio.c
> +++ b/drivers/siox/siox-bus-gpio.c
> @@ -102,29 +102,29 @@ static int siox_gpio_probe(struct platform_device *=
pdev)
>=20
>         ddata->din =3D devm_gpiod_get(dev, "din", GPIOD_IN);
>         if (IS_ERR(ddata->din)) {
> -               ret =3D PTR_ERR(ddata->din);
> -               dev_err(dev, "Failed to get %s GPIO: %d\n", "din", ret);
> +               ret =3D dev_err_probe(dev, PTR_ERR(ddata->din),
> +                                   "Failed to get din GPIO\n");

Huh, I'm surprised. I did

diff --git a/drivers/siox/siox-bus-gpio.c b/drivers/siox/siox-bus-gpio.c
index aeefeb725524..b97fde71a6a0 100644
--- a/drivers/siox/siox-bus-gpio.c
+++ b/drivers/siox/siox-bus-gpio.c
@@ -103,28 +103,28 @@ static int siox_gpio_probe(struct platform_device *pd=
ev)
 	ddata->din =3D devm_gpiod_get(dev, "din", GPIOD_IN);
 	if (IS_ERR(ddata->din)) {
 		ret =3D dev_err_probe(dev, PTR_ERR(ddata->din),
-				    "Failed to get din GPIO\n");
+				    "Failed to get %s GPIO\n", "din");
 		goto err;
 	}
=20
 	ddata->dout =3D devm_gpiod_get(dev, "dout", GPIOD_OUT_LOW);
 	if (IS_ERR(ddata->dout)) {
 		ret =3D dev_err_probe(dev, PTR_ERR(ddata->dout),
-				    "Failed to get dout GPIO\n");
+				    "Failed to get %s GPIO\n", "dout");
 		goto err;
 	}
=20
 	ddata->dclk =3D devm_gpiod_get(dev, "dclk", GPIOD_OUT_LOW);
 	if (IS_ERR(ddata->dclk)) {
 		ret =3D dev_err_probe(dev, PTR_ERR(ddata->dclk),
-				    "Failed to get dclk GPIO\n");
+				    "Failed to get %s GPIO\n", "dclk");
 		goto err;
 	}
=20
 	ddata->dld =3D devm_gpiod_get(dev, "dld", GPIOD_OUT_LOW);
 	if (IS_ERR(ddata->dld)) {
 		ret =3D dev_err_probe(dev, PTR_ERR(ddata->dld),
-				    "Failed to get dld GPIO\n");
+				    "Failed to get %s GPIO\n", "dld");
 		goto err;
 	}
=20
on top of your patch and the binary size increased (using ARCH=3Darm and
gcc 7.3.1). So no objection from me to get rid of this idiom.

>                 goto err;
>         }
>=20
>         ddata->dout =3D devm_gpiod_get(dev, "dout", GPIOD_OUT_LOW);
>         if (IS_ERR(ddata->dout)) {
> -               ret =3D PTR_ERR(ddata->dout);
> -               dev_err(dev, "Failed to get %s GPIO: %d\n", "dout", ret);
> +               ret =3D dev_err_probe(dev, PTR_ERR(ddata->dout),
> +                                   "Failed to get dout GPIO\n");
>                 goto err;
>         }
>=20
>         ddata->dclk =3D devm_gpiod_get(dev, "dclk", GPIOD_OUT_LOW);
>         if (IS_ERR(ddata->dclk)) {
> -               ret =3D PTR_ERR(ddata->dclk);
> -               dev_err(dev, "Failed to get %s GPIO: %d\n", "dclk", ret);
> +               ret =3D dev_err_probe(dev, PTR_ERR(ddata->dclk),
> +                                   "Failed to get dclk GPIO\n");
>                 goto err;
>         }
>=20
>         ddata->dld =3D devm_gpiod_get(dev, "dld", GPIOD_OUT_LOW);
>         if (IS_ERR(ddata->dld)) {
> -               ret =3D PTR_ERR(ddata->dld);
> -               dev_err(dev, "Failed to get %s GPIO: %d\n", "dld", ret);
> +               ret =3D dev_err_probe(dev, PTR_ERR(ddata->dld),
> +                                   "Failed to get dld GPIO\n");
>                 goto err;
>         }
>=20
> @@ -134,7 +134,8 @@ static int siox_gpio_probe(struct platform_device *pd=
ev)
>=20
>         ret =3D siox_master_register(smaster);
>         if (ret) {
> -               dev_err(dev, "Failed to register siox master: %d\n", ret);
> +               dev_err_probe(dev, ret,
> +                             "Failed to register siox master\n");
>  err:
>                 siox_master_put(smaster);
>         }
> --
> 2.29.2
>=20
> Eckelmann AG
> Vorstand: Dipl.-Ing. Peter Frankenbach (Sprecher) Dipl.-Wi.-Ing. Philipp =
Eckelmann
> Dr.-Ing. Marco M?nchhof

Another issue for your IT department: Tell them please to not append
latin1 encoded footers to mails that don't declare an encoding (and so
are implicitly ASCII only). I didn't check but I assume this will earn
you a few spam assassin points ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--frejqyo4ppldb22c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCgDEwACgkQwfwUeK3K
7AlWdAf/b06M3MXROhaoEVThzCnKvpjz5L9rvD3oBp6i/HF8JaL4J8UAjw/ueqQV
EOsZZbUNeA5cC/aVoEiWeIvI4PHzHPL+1q0TdLkXUhkJhDdzffqSR39llWHaBim9
Z43+zTcbXk12HfJGU1rVhfvgP/iYYOB4M2s2Bfc9v1KhbFBF/ptSRnelnGfimdvJ
LYPirdyvlopj4XUBRCXJ0YEBbBXqMQ3uEksHOJZmSwOXC108Z8OkiZ1fVHPwM84w
pFikjmQVV5mI67NtA1nTuWmsJn7KJabgi+rRRcIZfXxU6dzb90RhFlAjC0OgsXOm
p3KOn2nu/BryAc0Oh4fAYcX5OYTBJw==
=8mYs
-----END PGP SIGNATURE-----

--frejqyo4ppldb22c--
