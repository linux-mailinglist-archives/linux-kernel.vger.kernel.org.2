Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBB03B9DD1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhGBI7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:59:11 -0400
Received: from mout01.posteo.de ([185.67.36.65]:45095 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231183AbhGBI7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:59:09 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 890CC240028
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 10:56:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1625216196; bh=TiLwUHSR7R0Qj3YVWzytod8xNxHzUWymnFs38evq0YU=;
        h=Date:From:To:Cc:Subject:From;
        b=GjNB7krnEHr4k1J8Q/asUpMJ3bG4aLw+w1Gf5RxxeVxEfVRCVkVWH7rmSM43gsjwf
         6b4MNRWiVIhwUqtcWn4oaq+N4+IlRrnzs/P5KWPfL0ibhltnIF0Q3ulEnzrYkcFguS
         NU+yF037JF2kU1mZWQvgs92NJQaqPQ1NSuKdwxIRfBr9+aYZ7pPmu3ddvUxsW03SCG
         svFL50HU0H0kKIBZwO9zcZgf3s6XMD43ZBpwD6m6PWh1dbJamg4cp7XQ2fGDrVIAK4
         5953D44AaJjeLbTbsQxClXoSSiwTO4/xqlDchgYWih7EKKplRbhJbrxgOn1Kj7RvKJ
         mO7yuiDKsDFDA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4GGTTW6dstz9rxS;
        Fri,  2 Jul 2021 10:56:31 +0200 (CEST)
Date:   Fri,  2 Jul 2021 08:56:31 +0000
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        Ash Logan <ash@heyquark.com>, Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] powerpc: wii.dts: Expose the OTP on this platform
Message-ID: <YN7Uv/43TwL4+9ic@latitude>
References: <20210519095044.4109-1-linkmauve@linkmauve.fr>
 <20210519095044.4109-4-linkmauve@linkmauve.fr>
 <YNe5aW55SrXFGKFV@latitude>
 <20210701195655.knbcikdga57a7epx@luna>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/oh87RkuYSLgv47m"
Content-Disposition: inline
In-Reply-To: <20210701195655.knbcikdga57a7epx@luna>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/oh87RkuYSLgv47m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 01, 2021 at 09:56:55PM +0200, Emmanuel Gil Peyrot wrote:
> On Sat, Jun 26, 2021 at 11:34:01PM +0000, Jonathan Neusch=C3=A4fer wrote:
> > On Wed, May 19, 2021 at 11:50:43AM +0200, Emmanuel Gil Peyrot wrote:
[...]
> > > +		otp@d8001ec {
> > > +			compatible =3D "nintendo,hollywood-otp";
> > > +			reg =3D <0x0d8001ec 0x8>;
> >=20
> > The OTP registers overlap with the previous node, control@d800100.
> > Not sure what's the best way to structure the devicetree in this case,
> > maybe something roughly like the following (untested, unverified):
> [snip]
>=20
> I couldn=E2=80=99t get this to work, but additionally it looks like it sh=
ould
> start 0x100 earlier and contain pic1@d800030 and gpio@d8000c0, given
> https://wiibrew.org/wiki/Hardware/Hollywood_Registers
>=20
> Would it make sense, for the time being, to reduce the size of this
> control@d800100 device to the single register currently being used by
> arch/powerpc/platforms/embedded6xx/wii.c (0xd800194, used to reboot the
> system) and leave the refactor of restart + OTP + PIC + GPIO for a
> future series?

Makes sense to me!

Jonathan

--/oh87RkuYSLgv47m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmDe1JUACgkQCDBEmo7z
X9vJqxAAyOC7GHGtEdGs0vs4QOo2/Kqcbn9qgnpKABaeF4UqeCCvRa8+mAAN3ai+
87P+gZgBZoJb/p4bYR/kP7B4AtGBBhzAFTIyO1dLzt8bZtPpCcaOBWjKRlKGHVrH
cQdBdPDTuhRbYR2iQLoweYXMiojsQqfCJVd5eEGXWEwItywRRtfZ3ZEVcPAzhNHK
vhspIhK47tFZpgEK+bJza8GDjK2mgvDZp4+hNGzwKpzcjwEPgk+G4s+yT2xN0xDn
4BP7UoER6NfpyQ5NYj81sGzcgzsWwCx9Tu/HeCA8wA30xxJQ/FUptyDw3hGuMiaM
DQcRjAHCI+Yil/U3tB8XoNFx+xbkgvKj/DY9bm+IkbsFKki0eK63PhdNI9R//QuG
zyTpzNNEvevNwtVH6stoBBLGqMDoXw2VuzgKmFkkTt0h7L7YCI5tYQ3aoZQi+tfl
wpwi+dskP0BiICvv2n0CQketiITe3b3Q+yBwwXT5chcSh+TtliwJrzHWSK+DgE2r
ixqJjg4Q6nDMsO7d8gwJTV/J3NAi3nIhIiuuFvtomqecOxq5jsnpyNRQTkFd0a19
vrG//er+o0sOSrKcgD4he3K8rBzBMOt1+ZwcCgKwmlryHqB9iMqUyBXoBLHoy8s9
CH+YMx0LNscsooI19FA595BOioLN+hlf8yprR54T5eARem3j1MQ=
=jObg
-----END PGP SIGNATURE-----

--/oh87RkuYSLgv47m--
