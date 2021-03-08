Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675AE3319FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 23:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCHWHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 17:07:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:57489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhCHWHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 17:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615241251;
        bh=fjMPL0zFL9snrZWjjmFEV24/0x+pU31NQTF3KYEF5ek=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=l2AQFb8kDltgNlDyNl86zbA6Idkxf7it23oQCeMzZCLy5FK1X0n+iqgBBbCSLs3OQ
         Nv1s9upaiy4g/VmDgyHyF7IRMTZJ58bd94zpwQjOaOSCSUdtWssCCfr1Ia7YmESMdf
         oPrfkXt4xiwDbj7BH2J3SUvdj9auRW32oE+g6dE8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0JM-1m3Q9j16VM-00kR6c; Mon, 08
 Mar 2021 23:07:31 +0100
Date:   Mon, 8 Mar 2021 23:07:30 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     j.neuschaefer@gmx.net, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <YEagIqFSjGv3DDwq@latitude>
References: <20210308212952.20774-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qx9bk7+IN93x26sr"
Content-Disposition: inline
In-Reply-To: <20210308212952.20774-1-andreas@kemnade.info>
X-Provags-ID: V03:K1:LxJlgRdYD6bVpD5+WpaYB73lFXdqJB6Q48AMkjrJpqmrPbyyB/W
 PkLjTnrkzudKebAZb/IWtVqKu7L2GCuLMbYZk0f6fVxs8ko1CcPb/rsuj4zGnzrmeB6Xjyg
 p2ueEZAc3dCS1+3X6yqnrbvirtGku8e6mfdikYcWD9VFX0w081HB8NWS38IcZdmzdKlryi/
 EJQ4NtHkXR4Jv6cNC8VLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bCytuduw1mI=:YJQDUKCYh4zL+3lG8o8blp
 0i41TnxGyauokoutHI5ZPWpVzEeKUeB/6Rwf9ZMaz0TqO1/SnX+PNcj4ModBWpqEVnRi9JNIP
 M7FQI+eTv55Sbqpcu8oQeEGFXHi/XDDPeCchzU+OWW81AMf60+4de1jGRTbotl2pHt9QWXGJj
 rAji9jORhBQe0SZZcuBLuNhvJMGkC7iKLeYhQOhF8QabUFRVwbw0pBzX/gXx0HsHkLejOiO+w
 JWVkt99+Iocpbt3VvDeWHznA/8X49WtRI0/iNSA2im/Gkz0Du1HhOC3UtcUaVMlUuHsQit3Kk
 bdCPqRC/xe+X63qMCpSN+7G3xgTpd928Y+eHhdXNEsxYTs5IJTB1U2QDkr4eGpJ83P7LgDKyT
 DLbsKe5dRZ0K/gMi4BE5Aueolvz5Mxj438NDEAbY5xYlzytRpLgmbUT1FVy8PNLzvpNg8DQ6W
 H7M75kH/lC/SYZBhwgiVBlmg8ftsUDia/xFxt4hzr5jblWbP8ShkEzlRT7Ra4HkCnRHdO+5Gd
 N/87VeLTFUZ8Jp9KcAA1Lkk91q+HqPH+UvLLxoLjMsuXfOiAJtJm7138uLWs+Dt9qocbF9pVq
 rDl33VLiGPRJqHG6yGO2vOqT/ddHSSkrnMVQpamGNz9B6cyXr4mb3/86i2ovyW5msHMVtI610
 ZZlUUnGowSYobT3qdbkpJyBnKubthCEMWrqHEZv/NBsjzaVWzhJRwST7qSoaUy1r1OYh5Q5nZ
 CReoj/DBIvHdarAIjdbxvSBjqYJVJHmGAdCTp+akRpVFhGqVtRH5NPZIB8YAE1GsOJSgFgtsb
 7vkYKyuW7SUXNIeiHuTh1ysIclIgS3ssvDd1TqZum0lTTra+3z21gFKKqUjtypMZOPKf2xWe4
 v6Mn9mtchwa0/Exntlkw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qx9bk7+IN93x26sr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 08, 2021 at 10:29:52PM +0100, Andreas Kemnade wrote:
> Add the version of the EC in the Tolino Shine 2 HD
> to the supported versions. It seems not to have an RTC
> and does not ack data written to it.
> The vendor kernel happily ignores write errors, using
> I2C via userspace i2c-set also shows the error.
> So add a quirk to ignore that error.
>=20
> PWM can be successfully configured despite of that error.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
[...]
>  	ec =3D devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
> @@ -137,6 +174,16 @@ static int ntxec_probe(struct i2c_client *client)
>  	/* Bail out if we encounter an unknown firmware version */
>  	switch (version) {
>  	case NTXEC_VERSION_KOBO_AURA:
> +		has_rtc =3D true;
> +		break;
> +	case NTXEC_VERSION_TOLINO_SHINE2:
> +		has_rtc =3D false;
> +		/* Another regmap stacked on top of the other */

"[...] on top of the first", perhaps

> +		ec->regmap =3D devm_regmap_init(ec->dev, NULL,
> +					      ec->regmap,
> +					      &regmap_config_noack);
> +		if (IS_ERR(ec->regmap))
> +			return PTR_ERR(ec->regmap);

In any case,

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

--Qx9bk7+IN93x26sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmBGoBoACgkQCDBEmo7z
X9vdnhAArtzeQk7O+n8dLYndtciZifv13aTgr4l7NWaKRltk4h+d0ul07hMmOAKg
R3LUE5yglRe8w55EAxEeDYCuCfL7oQDvO3A4+S9vQ8n379B/ugU9ff6GBlLA1DZU
RoRZxaUjHZA1WraPSW7/8+E5oZW5UqOT3e59vKhcmhBhqjlQC0XOf2d+v0WT1dpZ
Zuk/wEXorz/H88XstuQbhc8aSOQLSWGTRLApEb2KlSe9IEiSsctCq4Z9ak4sFldF
UdYuMravQtRfr0C4MnxnfYcdz/LJhSC9Z5Zm6L9Pi3fRntrLXsMW7jmk6qgkdTRh
s8Ju5/oPvEP1F3GO3vwGLGmILOyc4QwXNH1m2Wwtfsakr1gD1rPt/youG1X2lxmb
mu0ei9OxSVUtexyHzgrAHMGWbstyZfQCleI0etk2LnDyVDGnO+27yC+V/coW73cB
nb5tRnTIy/TYcwGaFJbbk84I2yN1MH9BGYuq011zzF12Jho04wD0NvRhbiSriMMV
O8fQPmqfTRjRpOOuZmAlDyG2iqvOJYK0IU0mtJH0EiLID4lF1980W2cKfBqPIx58
dXgVeMhd50XYvTSWBziA8rCut4R3IH4YiBMqKxj9LoXBlKXPOm4XHdbCxwXoNdSb
/2SJDNHVlnIhylgQC3t6eG5Bpc+RLasvS8zTW4PxxTQ8n9xpIFU=
=+i9v
-----END PGP SIGNATURE-----

--Qx9bk7+IN93x26sr--
