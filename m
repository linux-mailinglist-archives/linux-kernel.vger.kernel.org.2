Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269E332FD13
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 21:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhCFUUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 15:20:05 -0500
Received: from mout.gmx.net ([212.227.17.22]:37229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231295AbhCFUTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 15:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615061979;
        bh=ZozLfS6BJ0lYS2UdZRAATWwJoPTuy1ci4Y/eXh0eDBo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QtjFxNo5z8BLNDP69himAHF/slWufyYcWCMKYkOr/qI7E/+ft36Vv/aHhjwv939uj
         C6lvIwiQFxxIwPeICfw/gboAKDifPq9FjUJt22RPfVl/rShlgBR8klOfXzHcZTX1dE
         G++wj3ivX+u4nHOOyzv9mFkNMo/G/dRKAg6bQ53k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1lE9H90z20-00Unex; Sat, 06
 Mar 2021 21:19:39 +0100
Date:   Sat, 6 Mar 2021 21:19:38 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <YEPj2ss13w5p+R4C@latitude>
References: <20210306181314.12673-1-andreas@kemnade.info>
 <YEPUppNWNiAMnczF@latitude>
 <20210306204219.6a7eae56@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R03366iBJ+/ZkxIE"
Content-Disposition: inline
In-Reply-To: <20210306204219.6a7eae56@aktux>
X-Provags-ID: V03:K1:UzqFT6Wz4TmCN+qoF7xmp7i8wUHJz6id7B5Dq8d3CLl0AuV7XjR
 F+Lv0Uee8PBz54CN6BrTnBQ77ejSFUvST1YrKplFvEUkaU8o4YLbC4pSPutyHjgIN2XLA1O
 RZCblE/p8tZc3Qgwp0qFtFK86RJM0r67cu2m9dk3rDcbR/vlqe/mHh+ZOgiS3RVP3mjrCzp
 D5BXiVyNDMKpgI3HRmXrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hPJyKi/tcmM=:lMV7Co39iU8AOWoOL/P8V3
 iwh4b9BL3CFCogu/4fZCreKC1fraMGRTyOx3rCso5szj+V8NyklUvFtEXvdcm36K+bz0NilJH
 oF/9LHPzTS1E0U5G5oo97tFNE0x55cNCwGL8F3b0iI52NBMmlUmrVw3x7ofAZs+/Cakvt98WV
 tt0zF4o52MJqF/ySGCGU2otBV9j9fWGmVaQnTzZVzbKedX8WtigUxpjjMdrBvKe3MyTSElDhm
 s6hsJukquhMKGRZdiQxgUSQ8R0UDo4K9aM4rxhavoPmiI7gmnweblf9+UJjGopuLjf0UKDsjq
 TzLpgiq4EsfbNS5W8z5EWEFXMuWZshPVpP1KszK15gsReKXWc/c6KfflRK2vSncdNKFrBZRdO
 4qxRP8Ss0ugcA+IAXC8oQD/fkZH9AbmOsIUzgJL54lHIik+113vNgkmyergLL3WJc4xv7J+0I
 NVZSnFq+GOfUnuL28REpjJG039P3DWyY3bzb4+2cXFClu7iYuVTpcjxNIpyz2nhFwsSl8Bggb
 smeP2NfopKn/t+YftBb6SqwBhpm3P1lwXqlLDOIg5ZHkb79IxpLFgpF2Hn2BozMIbHPpJR3f5
 WotNaZH5EmTUXxKhcOSsQKi6Zz4M4IIu+BcYqkY7aeS/+tBdob1fTzzeNf36+T0vd4l0OjT7J
 BMguxi+2qeii6IalVNUSWxO6UTQV5pi5AuWsolqK834BcIonoNjaVUmBVs42iQRfbXxxYyZzv
 Ee9OMZ2a3lujt3C3oaK8JCCAWSIG5EnpHUU6UtBBBiIJC1ZANdG+xpWQTufxIPbgSPsHtMzQl
 TeYrXe6LY6v5XNq1UsTL5sRZVS240hxE5bEC/Esf5eV7vcUWZ7+19JVmOAaSMlvqcofqmD4OP
 rXx2HdNqgRePiSTc1WVg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R03366iBJ+/ZkxIE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 06, 2021 at 08:42:19PM +0100, Andreas Kemnade wrote:
> On Sat, 6 Mar 2021 20:14:46 +0100
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:
[...]
> > > +/* some firmware versions do not ack written data, add a wrapper */
> > > +static const struct regmap_config regmap_config_noack =3D {
> > > +	.name =3D "ntxec_noack",
> > > +	.reg_bits =3D 8,
> > > +	.val_bits =3D 16,
> > > +	.cache_type =3D REGCACHE_NONE,
> > > +	.val_format_endian =3D REGMAP_ENDIAN_BIG,
> > > +	.reg_write =3D regmap_ignore_write,
> > > +	.reg_read =3D regmap_wrap_read =20
> >=20
> > Is the read wrapper necessary? It seems to me from reading regmap.h
> > that leaving .reg_read set to NULL should do the right thing, but I'm
> > not sure.
> >
> well if we want to read from it, there need to be some function for it.
> But if... I do not see anything worth to read besides of version.

Ok, with the understanding that there will be no read functionality
without the .reg_read callback, I'm fine leaving it in, even when the
particular drivers in existence don't use it.

> I think we can leave ouf val_format_endian because a lot of stuff is
> bypassed if no bus is set in regmap_init().
> There is e.g. a goto skip_format_initialization.

Dropping REGMAP_ENDIAN_BIG sounds reasonable, because this regmap
doesn't go to a byte-wise bus.


> > > +	case NTXEC_VERSION_TOLINO_SHINE2:
> > > +		has_rtc =3D false;
> > > +		ec->regmap =3D devm_regmap_init(ec->dev, NULL,
> > > +					      ec->regmap,
> > > +					      &regmap_config_noack); =20
> >=20
> > Ah=E2=80=94 A custom regmap stacked on top of the old regmap=E2=80=A6 I=
 think this
> > deserves a comment.
> >=20
> Yes, devm_regmap_init_i2c() sets a different set of callbacks depending
> on circumstances. Seems to be the easiest way to avoid duplicating too
> much code. I really hope that there are not so much devices requiring
> such a dirty stuff that adding such thing to the generic regmap code
> would be justified.

Ok, please add a short comment here or extend the one above the repmap
config struct, to save interested readers a bit of trouble. I guess "add
a wrapper" goes in right direction, but it didn't make the stacking
obvious to me when I first read it.


Thanks,
Jonathan

--R03366iBJ+/ZkxIE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmBD49MACgkQCDBEmo7z
X9uAew/9GsIDWh9HC8YVz7JeQtzHRibhMLqtQpFW+WkqrQ1K4UDXvQZO1jIbB0bc
c/v4FOTDA0qQRqhYHPcTZIU4x3Nq7Gfl5RjPE75qNPoi56eIc/iyxoRPJ36LCWSq
8Y2KiRLX9SueEe2K2zpiMz6o1NNDgoDgPshJzXZNWZEqP6zhS07MB/B9h0ncCJ/A
VkCblUqKb5bJ8zlQ1RHxJ7O9d8MV7PZ9WZrPXWE/BgC7GBfX/WMqBHjOBasozMI4
xQqbqjnHnZAAV3wfZSerGgQRIKMJR/wWHxEVUqcepttv2ovtj/cDaAzyiDstCblJ
/V7XVg54jXigNU7KdZnX0taOEB0lHxaE4XzTFypYFbzt6g5Wbq2FWc0q9LHQhVEr
uhF+9JJ9gEKMZrBFOWrlJzShXX5AIBVVM796TkM/IrZjXnQNJyQSSo0mCUZl66Q8
Cvyft490t1tLmqm8xG/n9zqMPuAeUHf53c8nZuuDO1EyBGFwqVf1mhg+P+Vif0n5
yG6OGhecz2hHRB1tUyzAzfhsiNbrn8rafNjXRyzVUCTAiy9nkTqVlFr315DAHBEN
LBgVJwbCvfYeLINKRfQ8JW4KtZxgIkyUnKy2ikf8JuNeZYxb0HYWRFYHaFJVJlPh
p6K/a9pY83tnTme/ZmQRXU/NJvUfysThDnaCsTQznGLsxg1MWAA=
=ihQv
-----END PGP SIGNATURE-----

--R03366iBJ+/ZkxIE--
