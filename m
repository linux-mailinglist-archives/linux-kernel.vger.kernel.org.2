Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71955314B69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhBIJWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:22:37 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:51467 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhBIJSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:18:54 -0500
X-Greylist: delayed 2261 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2021 04:18:52 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=EHfugH9XivOgwbFxjFGfRr2+8dLxzVrXiyw4/2iiY4w=;
        b=rTrRTMHOPDuwIxWtw7aIjMBHkkT7lE+AP44+kwH9vNtTO/tq8IxdAjx3Ai7NoUbYmsGRJt1TAeetR+R6xc2Dvb3sBNVsN5ERMRO81CmiQxEdlndENLpS+ipqS1t1qAINLAnYsJhOub8QUY3JOlA3jHvW3zyaXMDQDLiWKIssx6PETFrIEai9Fyq80VCY2J0HEoA28xWiOhhuF2gl/lnLWcR8M/9674Elqr3Xadaenmuhwe71LSvkZ1MzId66pkvW1i68eKvsoCZMpAqXxRXDz4NIuoKNoqGY0GDNafYm9irl7E9/xhBO9TXM0Z8YFDIvApJVdvni1UDqLKclxCHMyw==;
Received: from cm-staticip-85-152-0-72.telecable.es ([85.152.0.72] helo=[192.168.1.24])
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1l9OZK-0007Pc-Qx; Tue, 09 Feb 2021 09:40:22 +0100
Message-ID: <e86534902fce9b82d2a69b7ec24e697b43c9ef6f.camel@igalia.com>
Subject: Re: [Industrypack-devel] [PATCH v1 1/2] ipack: Fail earlier for
 drivers without probe function
From:   Samuel Iglesias =?ISO-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        industrypack-devel@lists.sourceforge.net
Date:   Tue, 09 Feb 2021 09:40:12 +0100
In-Reply-To: <20210207215556.96371-1-uwe@kleine-koenig.org>
References: <20210207215556.96371-1-uwe@kleine-koenig.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ybWTpaw5+5TbSdnTJkdz"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ybWTpaw5+5TbSdnTJkdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

Thanks for the patches!

Patch series is,

Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>

Greg, Would you mind picking this patch series through your char-misc
tree?

Thanks!

Sam

On Sun, 2021-02-07 at 22:55 +0100, Uwe Kleine-K=C3=B6nig wrote:
> A driver without a probe function isn't useful as it can never be
> used.
> Let registering such a driver fail already instead of failing every
> binding.
>=20
> This is only cosmetic as there is no ipack driver without a probe
> function.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> ---
> =C2=A0drivers/ipack/ipack.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/ipack/ipack.c b/drivers/ipack/ipack.c
> index 9267a85fee18..eabc4d08792a 100644
> --- a/drivers/ipack/ipack.c
> +++ b/drivers/ipack/ipack.c
> @@ -64,9 +64,6 @@ static int ipack_bus_probe(struct device *device)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ipack_device *dev =
=3D to_ipack_dev(device);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ipack_driver *drv =
=3D to_ipack_driver(device->driver);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!drv->ops->probe)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return -EINVAL;
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return drv->ops->probe(de=
v);
> =C2=A0}
> =C2=A0
> @@ -252,6 +249,9 @@ EXPORT_SYMBOL_GPL(ipack_bus_unregister);
> =C2=A0int ipack_driver_register(struct ipack_driver *edrv, struct module
> *owner,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 const char *name)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!edrv->ops->probe)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return -EINVAL;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0edrv->driver.owner =3D ow=
ner;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0edrv->driver.name =3D nam=
e;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0edrv->driver.bus =3D &ipa=
ck_bus_type;
>=20
> base-commit: 5c8fe583cce542aa0b84adc939ce85293de36e5e


--=-ybWTpaw5+5TbSdnTJkdz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAmAiSmwACgkQf/S6MvF9
w0NpLhAAlZd76bSRHVVsXi9EWry22SPjAm4dpqXqRBzt9M1oQGy3yAuqa0KMmHqO
l2K6CAKQ5I2cPHM+PSjGOpbi9WBmBqmS15ksp/jnIa2DDNBUhCFmC2rRAViuUDVJ
y/N+HJSw5iZQ3UHOPwNSKgkYOnbadhXSVZU/vh6p1PpbsUD9Za9s1MobQ19vje+T
kdz9jaGJ8mfKUu+CjDV7FwVi66Wpz0/iPIN/yQWqNQLPbnDQ/XVFo9won6NHroON
5Wi8m67neOSCIZaDxpxTjD2fbm78ChaaJbB7+vXSmgdMVyKf/baY8qldVBuR7pzp
It1edlBffuj9WXjgxY99o8/30KL01zoWWuZs+SsrkRwa5b07JWv9xsmUlD4bS+QD
QGfoRVdlQdPVqGrdt88TJrEhjr8BjqBPbS/az3uWai+ZvVdf0lOrFPbyiF/QRscg
t+Hb2GxsKha83sHvrV91Po8kww1Zko0yrjNuti+vHIskh7+kYsFcDIJGducAVKqh
NVV3fPxf2hYZeMtwggIDlO112+Btmhk5m86QnhnTa2b2tRIM8ksWW26gjHLK0DUv
tx9HPXYakM0BrtfiozRP6CRZWr9bWidUuVFTh4ixya2amzinBWkeVSCWKaTTkGNN
gW7ClYBPFWfNEqTcusqCv+E2waazZaSqFRxV8sf6kM3pawGn24g=
=sAkw
-----END PGP SIGNATURE-----

--=-ybWTpaw5+5TbSdnTJkdz--

