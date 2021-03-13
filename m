Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B486B339DC5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 12:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhCMLZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 06:25:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:41381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233486AbhCMLZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 06:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615634705;
        bh=7EuL1Y3qIgUCVlAbxxRxezgVj19mNP5psnN/b8+JwTM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CQ1z5COg54geRnRSAjCvEUsEgbpeUDIuq9gdjC1AKUCZ6qhZqBhHZ9ZF6LE8Qeq8L
         6fw9WMs2ciSZtt8av8BnQjkQF1yi+ZKbz1lQEMMLeQzHttTR3u93MStKHAcwi1pZA7
         rzfXdOWN0IPCmDlY19STgbH8ZQvMntH3Rwf44U5U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmUHj-1m38aG0BEH-00iTYs; Sat, 13
 Mar 2021 12:25:05 +0100
Date:   Sat, 13 Mar 2021 12:25:04 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     j.neuschaefer@gmx.net, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <YEyhEG96E41Q967E@latitude>
References: <20210313104258.17111-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qIRk1fK7k0/AsWzA"
Content-Disposition: inline
In-Reply-To: <20210313104258.17111-1-andreas@kemnade.info>
X-Provags-ID: V03:K1:G2VlvsFt51zpuh6IXPRmEBBX8IKFpQjLlyTpD9J4vDTiDSx5nCs
 S+U5JFH1xc5bYfaPGsIGQgZIJr3x4bHwzw5n22wQlSetxu4EJR/lgkOnVwiPTtG6IhYvQ94
 oRgropUQgVJsUnVqAWamiKJhwoe6rYI6eadNsZLhpP5wm+7R5hAlrfBKcyEAR66ejBTBW6u
 ZKbnqUxrQC8fKchmv5WnQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Eb+9Dx5cuAY=:tWOAnaBEhqYmeLMd827Y1t
 nUXJ3I35z7mu3aioYX/FZwO4hPH3BU6CE3Zls/KfLVJinuuWuf4hyosxGJkmGmKpMMurLbsOa
 aBknqA5S22Z5Tpmze895p8AAR/zcVK4/NRtTvrdT2eF5oyU4ceg2XMfS8ZkQlE2qt8hA68W2n
 rVro5VZBPmQ0KZ/3quaXObAyy5+t7OzScyTsVrVmjaPTwEFpaZ2Q0ROWMpdNvqYiLqlYPrgeG
 bkSn0ClA3UEfWDgExNFDEIJSvvSciC0ysprlRJvLuXTfv0Iti04ORJnv1Q4sUoe82+6jBIDp2
 IX5rW8EwnKq0ZFXArIJsjUDEgxNYUs9zkGkiQx5ze+RSIa9rUBk8EUw40aANQJAPLeiJGNJjQ
 wEgTZ28udLVsqoAdmNCzJsoSIDiYGImrPMypwEvcfMHf1QirX3HBrKCt10hCwYRgFGS8US0HG
 ggnvz2D3vVKqFXeesxQTkVeadiODEALDnBDqBTdABDdiHXboyguArrdyRiT2n+YbJSoSDhaHi
 d59xMByOFKq/313XzYPFsjOWXcLj74IHTojsqiCcT0uTgTdNMm59kNI/mxOpq8pQ65NE5JR2s
 Kz+HdUWsC1BVPkpV0ur44dQsXKJnEVOMLrV4K0Uq+oy7M6Dswy1UZBaKFLX/Ul0jsKXs24lTf
 R81TuWNT9UGwPguocRA+r9MAA+iCtWk2XmOQqDJ4jlqrmfGKFphmTFfGOtztW9zAYm+pWlrbn
 kdNTvRcUP4IEpe8YPPVwoBH2VnXdabT+ipgYApeuZBDE/GJMc9YDQeOkm20j7oWa+EJBfLztT
 aQ0nwdZQvS3/y2SExFGsseKfD2t2K+ibSytVTcrbpvv0Nxu2zFkM6lrEWEPOZRzT+tkzV3aCl
 tSOzQWeSIt7wbhHsDGSg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qIRk1fK7k0/AsWzA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 13, 2021 at 11:42:58AM +0100, Andreas Kemnade wrote:
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
> Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
[...]
> +static const struct mfd_cell ntxec_subdev_no_rtc[] =3D {
> +	{ .name =3D "ntxec-pwm" },
> +};

I left a comment/question about 'no_rtc' vs. 'pwm' in the other thread.


> -	res =3D devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE, ntxec_subdev=
ices,
> -				   ARRAY_SIZE(ntxec_subdevices), NULL, 0, NULL);
> +	res =3D devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE,
> +				   subdevs, n_subdevs,
> +				   NULL, 0, NULL);

The last two lines might as well be one, width-wise.


This version of the patch looks nice and short :)
Jonathan

--qIRk1fK7k0/AsWzA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmBMoRAACgkQCDBEmo7z
X9thuQ//XYAt8vpYkdqpb3K+o3GeLBxUIBK5DHivXk0r7z9uHuoYzKOUX8wUcYkB
tNxrujKJe8YQhE0ItoBYQqPTOXslEMKC4UELPbhLBqYC3+IqKpti7oXDGd0z2Pjd
GYr3f61bQQ1hLlBIn2tWL20L+0daoVyifMAucgvZ8zKUvBvteCAmLcSkekLhnkZl
75bb2vAOSEI+iRuP/OT6IufFo3ZsBqtyOP/tiV5JVWQppw8bXnDRNfqz0F2Qsn0M
2TmXrw9gmeYXupzgIsGME9W/OmEEQp3ujddMF98deFxuFBibPu4HPlSb9RFEeyyi
Jntu6QT/Jwap4hJMpVwF/p1fM3V4IP34QDI87h6iBqFyX08rO3mRqwqSAoimlkKB
q9NuXkPO5bK+Qk2hxcBsSYk4jPfsp3ISTFbbJm1tigCjgu0bUmqvQriQ/CcI9/aS
2d8oW816wxhufTLKkdo/MSz8LrVB4lH36fUEFfOlyBpJzw4BqurkV1xeo7GOMbEP
s+B8ys2mD+kPmL+KsAKYuUJxJeGrkQve9DhYWKbxaX+x+2b//N0IkwN566LthKnI
klt5vRU+qqBjnN614FQs7Jp6BEFb+B0RzSjQNBbi0dOW8d10o66/RdJZDz81kvj7
JBFcLYVaYAkH5tr59z/0MocjmzGLkr3A+saMGjEP0XeRUXphCSc=
=0T1u
-----END PGP SIGNATURE-----

--qIRk1fK7k0/AsWzA--
