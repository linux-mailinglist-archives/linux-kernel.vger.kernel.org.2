Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3CB391502
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhEZKhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:37:33 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:34377 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhEZKhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:37:32 -0400
X-Greylist: delayed 1758 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2021 06:37:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=RTL0YUJC5bTgHB3rr9d5JzhmkX+MPRCkX3Z5f/ZfoIw=;
        b=H/ZH+V7fPt0bFbpnORL3NeeKS1NIF7F8GL9L5BF0Up1yA1EKow1Cgxk+rPe765clKv6DWQ56QB4fFYkhrH0kIk0voXlqMHd0LOVx5UiLeh0ZbZuZHwnZn8f3nkqvp8SxNsOBDGWLN3pRZvl1pM2oMggNf4AcWDQuNWZ1hCVFNBO0FHpt5tpSI1a3rKxGGBQNcQnl8BkuYETvqYMLgHN4pZ3kkDvsFhnR68vFPZPChvMSpB+A49rjIr6aVT3EpQQ0Eu9tiu7up+J3Jd+KRRu5eouw5sZLzwoyVIHyO/5BCfk/BdVDF3sfBRS4jd9BzFCE2WK24qUd/TXv9IvzFxLByQ==;
Received: from 1.pool85-50-22.dynamic.orange.es ([85.50.22.1] helo=[192.168.1.120])
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1llqQq-00035i-SG; Wed, 26 May 2021 12:06:34 +0200
Message-ID: <bbe198f1432488d4fcbfb84c249b4e55a50b5bd3.camel@igalia.com>
Subject: Re: [PATCH] ipac: ipoctal: fix kernel-doc syntax and remove
 filename from file headers
From:   Samuel Iglesias =?ISO-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com, rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jens.taprogge@taprogge.org, gregkh@linuxfoundation.org,
        industrypack-devel@lists.sourceforge.net
Date:   Wed, 26 May 2021 12:05:30 +0200
In-Reply-To: <20210522121944.11182-1-yashsri421@gmail.com>
References: <20210522121944.11182-1-yashsri421@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-f9pVxU9gW8q5Fs96aXmZ"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f9pVxU9gW8q5Fs96aXmZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>

Thanks,

Sam

On Sat, 2021-05-22 at 17:49 +0530, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning
> of
> kernel-doc comments.
> The header for drivers/ipack/devices/ipoctal follows this syntax, but
> the
> content inside does not comply with kernel-doc.
>=20
> This line was probably not meant for kernel-doc parsing, but is
> parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'),
> which
> causes unexpected warning from kernel-doc.
>=20
> For e.g., running scripts/kernel-doc -none on
> drivers/ipack/devices/ipoctal.h emits:
> warning: This comment starts with '/**', but isn't a kernel-doc
> comment. Refer Documentation/doc-guide/kernel-doc.rst
> =C2=A0* ipoctal.h
>=20
> Provide a simple fix by replacing this occurrence with general
> comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
>=20
> Also remove the redundant file name from the comment headers.
>=20
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> =C2=A0drivers/ipack/devices/ipoctal.c | 4 +---
> =C2=A0drivers/ipack/devices/ipoctal.h | 6 ++----
> =C2=A02 files changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/ipack/devices/ipoctal.c
> b/drivers/ipack/devices/ipoctal.c
> index 3940714e4397..2a3a94f72dfb 100644
> --- a/drivers/ipack/devices/ipoctal.c
> +++ b/drivers/ipack/devices/ipoctal.c
> @@ -1,7 +1,5 @@
> =C2=A0// SPDX-License-Identifier: GPL-2.0-only
> -/**
> - * ipoctal.c
> - *
> +/*
> =C2=A0 * driver for the GE IP-OCTAL boards
> =C2=A0 *
> =C2=A0 * Copyright (C) 2009-2012 CERN (www.cern.ch)
> diff --git a/drivers/ipack/devices/ipoctal.h
> b/drivers/ipack/devices/ipoctal.h
> index 75f83ba774a4..773dc41bd667 100644
> --- a/drivers/ipack/devices/ipoctal.h
> +++ b/drivers/ipack/devices/ipoctal.h
> @@ -1,9 +1,7 @@
> =C2=A0/* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> - * ipoctal.h
> - *
> +/*
> =C2=A0 * driver for the IPOCTAL boards
> -
> + *
> =C2=A0 * Copyright (C) 2009-2012 CERN (www.cern.ch)
> =C2=A0 * Author: Nicolas Serafini, EIC2 SA
> =C2=A0 * Author: Samuel Iglesias Gonsalvez <siglesias@igalia.com>


--=-f9pVxU9gW8q5Fs96aXmZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAmCuHWoACgkQf/S6MvF9
w0OLgg/+LV3KqR1htIZVhhQPi2+KnjqBI6fjsF6pm0aYa6P0zRf8kqSCM/Z9Gk2V
ntTgqBWOgKdlN5hyRRZnkzJsPZnqRAeglyZbJ2wfbfYE8G9hrBL75ZUmUJf/Bw2T
9HxvMHNOZM2aTG1avIHmW6J++GOiCN1ptucjHS4OEGA3cadyO8zYCO66fWH1nLtO
ls0Wzdg60OjiMtBBISFXOCgUkJNLIs1L9ug8IZIXbenrKbOhnTwnjzyy80zX44Lc
MuLAjABIixSFw6KDR+uGlJVqcNge6nHJmEze3A3b5QDrYE/1mQnuzwLjKfJTj5OU
lEFLvtDr9YmnpkRICwwn2X6n0mgSIAdNnVUP2JaVE201AsUoXWdqN2AsDLqCjE+W
6lbIt51EfRQdSI7YKm+YW2smSTe/4nKvbUDFsQmLWGjgijt6X9QSxiCdKJxlKp5L
HsHVtH60mflOlRTyHWI3kiNUIMhP51HOt3B+DhmVaszuWhE24FAS9cj+nPPCWPDk
JorrS6sxpzIRiuMV4maIfnZDiFpBS2UHzJeDmJAleBq+eU1qo9CU9huwtbzp2aY8
p0+XRTPrr8bG2h2XfOWxpghwgbz8SuVB03PRdWKZN5q99u/XUyeRgqayDH9KWBrv
ygPsw2ZvbCj9Jaa4MAjAaNz8CqfPkTz+ri+/tKpleotJMhznMGo=
=OK0d
-----END PGP SIGNATURE-----

--=-f9pVxU9gW8q5Fs96aXmZ--

