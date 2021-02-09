Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2099F315121
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhBIOBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:01:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:59208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhBIOBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:01:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA66EAFE2;
        Tue,  9 Feb 2021 14:00:19 +0000 (UTC)
Message-ID: <56e237a8d0646c03d4ff44e439d1b0f81c800a9b.camel@suse.de>
Subject: Re: [RFC/PATCH v2 09/16] soc: bcm: bcm2835-power: Add support for
 BCM2711's Argon ASB
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>, wahrenst@gmx.net,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        eric@anholt.net
Date:   Tue, 09 Feb 2021 15:00:18 +0100
In-Reply-To: <CAMEGJJ3i_hEAnO4rDQ+emqB=OYXetLyKh1kMRwAbUnYZ1e48VA@mail.gmail.com>
References: <20210209125912.3398-1-nsaenzjulienne@suse.de>
         <20210209125912.3398-10-nsaenzjulienne@suse.de>
         <CAMEGJJ3i_hEAnO4rDQ+emqB=OYXetLyKh1kMRwAbUnYZ1e48VA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-vLmExgH5XDAroXW33oQ4"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vLmExgH5XDAroXW33oQ4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-02-09 at 13:19 +0000, Phil Elwell wrote:
> Hi Nicolas,
>=20
> On Tue, 9 Feb 2021 at 13:00, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> >=20
> > In BCM2711 the new ARGON ASB took over V3D. The old ASB is still presen=
t
> > with the ISP and H264 bits, and V3D is in the same place in the new ASB
> > as the old one.
> >=20
> > Use the fact that 'pm->argon_asb' is populated as a hint that we're on
> > BCM2711. On top of that introduce the macro ASB_BASE() which will selec=
t
> > the correct ASB register base, based on whether we're trying to access
> > V3D and which platform we're on.
>=20
> Please don't refer to this block as ARGON - it is the IP of Raspberry
> Pi Trading and it's name is RPiVid.

OK, sorry for that. I, again, mixed both ASB names. I'll rename the Argon A=
SB
to RPiVid. How should I call the one present in older RPis?

> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > ---
> >=20
> > Changes since v1:
> > =C2=A0- Correct names
> >=20
> > =C2=A0drivers/soc/bcm/bcm2835-power.c | 68 ++++++++++++++++++++--------=
-----
> > =C2=A01 file changed, 42 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-=
power.c
> > index 59b8abfc5617..42e105758b47 100644
> > --- a/drivers/soc/bcm/bcm2835-power.c

[...]

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case BCM2835_POWER_DOMA=
IN_USB:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0PM_WRITE(PM_USB, 0);
> > @@ -626,13 +633,22 @@ static int bcm2835_power_probe(struct platform_de=
vice *pdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0power->dev =3D dev;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0power->base =3D pm->bas=
e;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0power->rpivid_asb =3D p=
m->rpivid_asb;
> > +       power->argon_asb =3D pm->argon_asb;
> >=20
> > -       id =3D ASB_READ(ASB_AXI_BRDG_ID);
> > +       id =3D ASB_READ(ASB_AXI_BRDG_ID, false);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (id !=3D 0x62726467 =
/* "BRDG" */) {
> > -               dev_err(dev, "ASB register ID returned 0x%08x\n", id);
> > +               dev_err(dev, "RPiVid ASB register ID returned 0x%08x\n"=
, id);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> >=20
> > +       if (pm->argon_asb) {
> > +               id =3D ASB_READ(ASB_AXI_BRDG_ID, true);
> > +               if (id !=3D 0x62726467 /* "BRDG" */) {
> > +                       dev_err(dev, "Argon ASB register ID returned 0x=
%08x\n", id);
> > +                       return -ENODEV;
> > +               }
> > +       }
> > +
>
> Surely these are the same register. Is this the result of a bad merge?

AFAIU There are two ASBs the old one at 0x7e00a000 and the new RPiVid one a=
t
0x7ec11000. They both can be checked for valid IDs. Note the new argument i=
n
ASB_READ().

Regards,
Nicolas


--=-vLmExgH5XDAroXW33oQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAilXIACgkQlfZmHno8
x/4YiQf+IWndOxKAscGGPf/kslh7HScKXnZucnff76qyQ3qV4RdHObcPRF9xgDoY
B3SFOOxIxcmRLHBDt7ze2OWr/hpC1JxDIcHEsAgQe91zC6TD/53HXdS3aX0nAO56
4XFP0VS1zvr7iJPbOsxrDdM13Jv6bU0K20O0AraVvoiDUGMs0ZniH7/7AgpmtZDe
yEFSun6M9UmmVY9uYRzHkk8XPRhXpECxnMewrEHfm1IUFId6Kmw7I4HwPArvTPf9
kDOi+rSofxS9ZIUgxFpWV3tRxxYAjxSx8mEHEbiF2cQZ08Vy0U4559tKS6flGh44
D1Mo6eq/KrsBsJ88VRcpKB6NcmWWug==
=PFPS
-----END PGP SIGNATURE-----

--=-vLmExgH5XDAroXW33oQ4--

