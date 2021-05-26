Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1520339150E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhEZKiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:38:07 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:34391 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhEZKhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=+/YJ/WEHoAhNR9jjGARfV2K3rbovariynAgNjvTSGvY=;
        b=MXApUS5JNozr7uyNBgT4c38W0dA+0POQTzR2QX/terafuWCP+DR+KG8Fak6jbuxwqDPBli8xF2rBhBh2+WxypDJ5odPUfuA9EAB01+dzHEUDavp40mFURj4hIQyQ+Wh44lJKrYtGktaOWp59qy1AE3HkhkvAgBDYwvLEIXuU5gbAqjIsdJwQELIE4ABcphiicvJAMaJGDmcQwWX3c4qDtcCr8Xb2dZ8LrgIU628qzsVDWVFICTo6g7cBZ2AfrKJeEhk5REzSDKMtm09cs863Srm3gvHJw6xvpQm3ZBfiLvAF6l5ted2kK+Bin2u9RzW6JdS9dnxznJUoEcSuKxTIiw==;
Received: from 1.pool85-50-22.dynamic.orange.es ([85.50.22.1] helo=[192.168.1.120])
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1llqRF-0003DR-JQ; Wed, 26 May 2021 12:06:58 +0200
Message-ID: <6d9175eb7ac9c4c1278b65f7f6c272910498eca4.camel@igalia.com>
Subject: Re: [PATCH] ipac: tpci200: fix kernel-doc syntax and remove
 filename from file header
From:   Samuel Iglesias =?ISO-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com, rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jens.taprogge@taprogge.org, gregkh@linuxfoundation.org,
        industrypack-devel@lists.sourceforge.net
Date:   Wed, 26 May 2021 12:05:44 +0200
In-Reply-To: <20210522124051.12540-1-yashsri421@gmail.com>
References: <20210522124051.12540-1-yashsri421@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-gi5bHNGvoa4ucqi1PAyk"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gi5bHNGvoa4ucqi1PAyk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>

Thanks,

Sam

On Sat, 2021-05-22 at 18:10 +0530, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning
> of
> kernel-doc comments.
> The header for drivers/ipack/carriers/tpci200 follows this syntax,
> but the
> content inside does not comply with kernel-doc.
>=20
> This line was probably not meant for kernel-doc parsing, but is
> parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'),
> which
> causes unexpected warning from kernel-doc.
>=20
> For e.g., running scripts/kernel-doc -none on
> drivers/ipack/carriers/tpci200.c emits:
> warning: This comment starts with '/**', but isn't a kernel-doc
> comment. Refer Documentation/doc-guide/kernel-doc.rst
> =C2=A0* tpci200.c
>=20
> Provide a simple fix by replacing this occurrence with general
> comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
>=20
> Also remove the redundant file name from the comment headers.
>=20
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> =C2=A0drivers/ipack/carriers/tpci200.c | 4 +---
> =C2=A0drivers/ipack/carriers/tpci200.h | 4 +---
> =C2=A02 files changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/ipack/carriers/tpci200.c
> b/drivers/ipack/carriers/tpci200.c
> index ec71063fff76..a867906777bd 100644
> --- a/drivers/ipack/carriers/tpci200.c
> +++ b/drivers/ipack/carriers/tpci200.c
> @@ -1,7 +1,5 @@
> =C2=A0// SPDX-License-Identifier: GPL-2.0-only
> -/**
> - * tpci200.c
> - *
> +/*
> =C2=A0 * driver for the TEWS TPCI-200 device
> =C2=A0 *
> =C2=A0 * Copyright (C) 2009-2012 CERN (www.cern.ch)
> diff --git a/drivers/ipack/carriers/tpci200.h
> b/drivers/ipack/carriers/tpci200.h
> index 2619f827e33f..e79ac64abcff 100644
> --- a/drivers/ipack/carriers/tpci200.h
> +++ b/drivers/ipack/carriers/tpci200.h
> @@ -1,7 +1,5 @@
> =C2=A0/* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> - * tpci200.h
> - *
> +/*
> =C2=A0 * driver for the carrier TEWS TPCI-200
> =C2=A0 *
> =C2=A0 * Copyright (C) 2009-2012 CERN (www.cern.ch)


--=-gi5bHNGvoa4ucqi1PAyk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAmCuHXgACgkQf/S6MvF9
w0N3fA/+LD+Bn2pyb2u7ibeLxX9w1PGMgdsccbhgvmLycYhT2uaxvXQDzCOqT2rd
NX5T4IIaXnbX4rnbqLzK8HWP3kBxXdg4M3hjyi+9j4Iihqj0tlyRWFFbSOKnizE1
klQo+khxIPxDVszHMPXM2BAjVvi1oXpgIQjhxs+7MLUgItKtJAgNf1dJj7/mgSOz
NUnFW3lAKD/Ox/MCwxCFE6Rv/o5dCWTtLLQnzHrW8pxfDxS94lsd3wjrIWNrYqYh
M7Yj817wpTueKhLmn/ZndTO6Tfd6QgDVVH7go8Ljh4Uwy4k0425UlAXrgaNqjmny
X/+Gu0FijEL9RHy7GnosnjuF6hIPakz4cbktXF+xOvT1W/0DG/Pei4zcuo6zPo64
HNfjvjGdM1zzzlp9WaZkreIj9Z5eICvJjEgDjIaJhWcX2v/dCq6mskzIFtid+pu4
3RKtdZyB3Mhsb2H5mh7Vbr+svbvSZXDenmHJ7RYd3C4ZMcjYwdnLlCvxF43xqQfw
69fxFnWesg94H1X/S/3mLNpWPMDMIFgWpnVW0Y9bvVyosCY6yszK9W3qVSV+1+ak
8QUXlAIOFHut3UoXW0PvOIn+OjiauxVPnqoKa+6ZBv8Os0VZ82M7QZI9AhXpun0V
CYxm4GAlCfFRUVE8CicLHKh2gIuakakEOJ4eLg+LGupaSruC8dc=
=qDYf
-----END PGP SIGNATURE-----

--=-gi5bHNGvoa4ucqi1PAyk--

