Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C4A3B96DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 22:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhGAUHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 16:07:44 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:44740 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGAUHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 16:07:41 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jul 2021 16:07:40 EDT
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 06CA9F40443; Thu,  1 Jul 2021 21:56:55 +0200 (CEST)
Date:   Thu, 1 Jul 2021 21:56:55 +0200
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        Ash Logan <ash@heyquark.com>, Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] powerpc: wii.dts: Expose the OTP on this platform
Message-ID: <20210701195655.knbcikdga57a7epx@luna>
Jabber-ID: linkmauve@linkmauve.fr
References: <20210519095044.4109-1-linkmauve@linkmauve.fr>
 <20210519095044.4109-4-linkmauve@linkmauve.fr>
 <YNe5aW55SrXFGKFV@latitude>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5xpqystiypqfkjaq"
Content-Disposition: inline
In-Reply-To: <YNe5aW55SrXFGKFV@latitude>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5xpqystiypqfkjaq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 26, 2021 at 11:34:01PM +0000, Jonathan Neusch=C3=A4fer wrote:
> On Wed, May 19, 2021 at 11:50:43AM +0200, Emmanuel Gil Peyrot wrote:
> > This can be used by the newly-added nintendo-otp nvmem module.
> >=20
> > Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> > ---
> >  arch/powerpc/boot/dts/wii.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.=
dts
> > index aaa381da1906..7837c4a3f09c 100644
> > --- a/arch/powerpc/boot/dts/wii.dts
> > +++ b/arch/powerpc/boot/dts/wii.dts
> > @@ -219,6 +219,11 @@ control@d800100 {
> >  			reg =3D <0x0d800100 0x300>;
> >  		};
> > =20
> > +		otp@d8001ec {
> > +			compatible =3D "nintendo,hollywood-otp";
> > +			reg =3D <0x0d8001ec 0x8>;
>=20
> The OTP registers overlap with the previous node, control@d800100.
> Not sure what's the best way to structure the devicetree in this case,
> maybe something roughly like the following (untested, unverified):
[snip]

I couldn=E2=80=99t get this to work, but additionally it looks like it shou=
ld
start 0x100 earlier and contain pic1@d800030 and gpio@d8000c0, given
https://wiibrew.org/wiki/Hardware/Hollywood_Registers

Would it make sense, for the time being, to reduce the size of this
control@d800100 device to the single register currently being used by
arch/powerpc/platforms/embedded6xx/wii.c (0xd800194, used to reboot the
system) and leave the refactor of restart + OTP + PIC + GPIO for a
future series?

Thanks,

--=20
Emmanuel Gil Peyrot

--5xpqystiypqfkjaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEjrVT1SzTln43kCLJOWgfYkb2LpAFAmDeHgQACgkQOWgfYkb2
LpBR1wgAo8/AW14uyzt1Z177k6xWkLqlqUXPSqvRzsrEbtn4t/IlewtlPOrwBntP
v9cBf82hjFyNeKZMOGD/3Hka8bXBlsqrcVZUEPxUYuty6f+qsQ96AIYeVdN+S4It
8wquNDtGA3VIJY6xxD+sDE+GplNH5WeUO/dhLqXxlSDi52fSyUK/mc6DIcXHC+q8
f+RW6VDgVVVrJdhofhvHoO/2g0BwKNWOmfyv70RXUvZq+mT6lI3liEkEeAm8TyxP
4logyZ9vZYg/LhjceqHTnppXl5XyBPeOznBVbygdeJh7igBfRsh6Pz2ISgYeS51N
YhJjzLcGv44IlTttJz1GkRzIwHj0wg==
=zJte
-----END PGP SIGNATURE-----

--5xpqystiypqfkjaq--
