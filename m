Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77426339DBA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 12:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhCMLRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 06:17:44 -0500
Received: from mout.gmx.net ([212.227.17.21]:33493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231938AbhCMLRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 06:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615634256;
        bh=ErWw3iNUBXkmKUEaxamvuiE2jw+xtF0l8ArxWCMrw/I=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HvEbMkQdIE4TTJtbi3Irk/2leN5FDj8F7Ync1H8NYcjMUioYOEYBnFCa7sMIvi2S1
         P5uK1x+y9Y2i8pxFTz131q5bx4GpywZhy7XN8Zv60hPdzxUw+00mV6PAqQkDZrH5jT
         Fpwz6cMoSMVdRaX7A473LJM4nn49d/8BIU2M7hiA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MoO6C-1m56XQ1R1M-00omTx; Sat, 13
 Mar 2021 12:17:36 +0100
Date:   Sat, 13 Mar 2021 12:17:34 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <YEyfTrTFzUaXiklf@latitude>
References: <20210308212952.20774-1-andreas@kemnade.info>
 <20210310095545.GC701493@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6xrxmgrtIHvv4b2T"
Content-Disposition: inline
In-Reply-To: <20210310095545.GC701493@dell>
X-Provags-ID: V03:K1:d00HeJ+4mtPjH+2JZB/1keIPAULhidVNw3oO79j5bHYmYQwASqD
 JWgFrLuY7KdCzAt2mEyZYecxJZmz9MzMovl+TIjq82jnDZJ1AvzTWn9fYgJkHHTn8SV0gQJ
 iCtOppK1g38AR1sDEimrx3xOYof8HA4wCdlaxeJpYdWr8HNWCrkRUJnxW+v5N7WbYCMfm6A
 JThqiW/x/umrEbrh/X8LA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5BPFss3Ni9I=:Eg8ZDfw+W3LlJjzvrqUYQH
 hfck21+Sx/4r3aAUkKdJn6NX+scBoM5dG4fyZ56oDRNXVhWidgIItSM0ynPLweIFwLy/0MKqS
 0t7xyMSc2NDEFtxsPRy0x2CC6HG4iFEOEj2PiNjqgqi50xkdWIjQwBuqEoCnWhCO3PvX+F/s0
 qrXbzLh5M3cGj1NZcdg+QBqAyOSIlJQX2Y4GjAKKiaw02vhZmlyLFVEvuAJdbUafi6utBes8g
 bFc7cK+k6KJ7H0mOWFosK1ZLzRoDWugctZ9xdHUlMiCSsqG23QJ8K4F5e7V+/m4MBQX6NSyFq
 E6OYmb0rTgB7CzqPjeRTEQ5bwnspGHRd4tEPDLwmBQhKvPAuh7i/3AS9Lm25RywyO7PA24fP/
 FjM0M6vCSoBVOsfWzX+sYLDqLcbkrxYxFU4oBAIJhqQpXl9Jv1v7+j8jhzMtie12PUGwxUpoD
 qFfidzIQ+3UITPE7JmNGlRv74fZ7K6DDCyyBBOpfKDPl5L0D1senta5cdj/X8zp83lbdKa7CU
 qRpUTD8IZgHk8H7Gg7nUdXNsIlUc1/kbtExIVrZqACCZaiLgNYE+Lg4fZA+djUROMJTbrUuBQ
 PAGXuBp4cQImv4KxHrr0/nvkVNtW9TuZwioEEjB1Yv/ZAjeEMugcuVnixaKv/RI1U8HeaFwZA
 6gJeHghI/nTxFn3rO/u1akPYGTmWZ9fVoB7P/flIDm0rC23BnNQuIKsjULVaFkYsdz1e28wnf
 MqW5rgV6b528w0pa1Fb1Lj96G01CACU04Yn+PNVEvpQp45iI3xXyA4Gil61T520SP7DZxbO2K
 KWQKcU5FY9+2oVEJx1SuY87KBLCdt4JWzSkvLk101zLNgtu6n5jDPXoun7oQmGh4Fq70UreJv
 QZxHQTTU7IPgOKR3Hp8w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6xrxmgrtIHvv4b2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 10, 2021 at 09:55:45AM +0000, Lee Jones wrote:
> On Mon, 08 Mar 2021, Andreas Kemnade wrote:
[...]
> > -static const struct mfd_cell ntxec_subdevices[] =3D {
> > +static const struct mfd_cell ntxec_subdev[] =3D {
> >  	{ .name =3D "ntxec-rtc" },
> >  	{ .name =3D "ntxec-pwm" },
> >  };
> > =20
> > +static const struct mfd_cell ntxec_subdev_pwm[] =3D {
> > +	{ .name =3D "ntxec-pwm" },
> > +};
>=20
> To put across what you're trying to achieve, maybe call this:
>=20
>   ntxec_subdev_no_rtc[]
>=20
> Then if other devices are added, the semantics/intent stays the same
> and it won't have to be renamed.

Andreas, what is the full amount of functionality this version of the EC
can ever provide?

If it's only PWM, I think ntxec_subdev_pwm fits well.

[ The next subdevice that I can foresee is battery monitoring. ]


Sorry for the delay,
Jonathan

--6xrxmgrtIHvv4b2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmBMnz0ACgkQCDBEmo7z
X9t+fA//QT5K19ZzN+XVLtv3JzvokDS3hrSV5FhYld62wM1idRN8+sbrgaRN5rQ9
qILNGzDoO33og2AskIgHcCh38Cn2kZGNXgSNEbH2w+QWZhczJ70Wx/D7G5jnzgx5
vxIK4OCeHYIYbUKXJae7G65x9QFTR5nbrDue+EaOjWcfOWTjk4aK4NkjCFLNAspD
kWJSkbWN9Cz4/CDvea2kFL27AWLCBWyjheZOuBb3njRxEybYb5qcWYxubTdwuvOA
GoGy0oPIeQQ0VgS3dezZKFCb6QSfXZIJUkjYz/utxWCttCc+5IErooXZe6Vec+yR
G5ydY/iTDKao8DTntmm8iZfvrpKa5otqDYlX30BwDwNaNTQO+pfVsO/EvfN7fgFA
4z5gbuwUwd66oHpt+qXkDU42uqxcjYw5o25tNYL5gX+KX8D0P1RyUUFJWp822+Ae
aH+6F5mcf/PxY5C9lasJH2cmr/zgLj1aOCWUsra68n3MQYqCjv3sI9FJ5sVTzkyk
tU/RcCgYi8JPYaqqlZqrk74POBFTQMXpNQT6pFJmYKVKCXW9gLxlzsRKd9QDrTdd
PG3A8KKaTssG5VAZSWZ7A+Bxdj6l0Vz5Q6SvBwcG2RJ4mlXp8XM0MrXRxxYa2ePw
SuDGGayWbgXHz7sT1iS/hVcASvMf/37/g7/aJzjka4GxdO61lMM=
=/krD
-----END PGP SIGNATURE-----

--6xrxmgrtIHvv4b2T--
