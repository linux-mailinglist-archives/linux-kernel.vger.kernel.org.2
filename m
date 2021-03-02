Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD1A32A7BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349598AbhCBQed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:34:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:44664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578336AbhCBOJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:09:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE020AFF9;
        Tue,  2 Mar 2021 14:09:10 +0000 (UTC)
Message-ID: <9286657b0e4873eaaaa2208364b310d82bcc0962.camel@suse.de>
Subject: Re: [RFC 02/13] driver core: Introduce MMIO configuration
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, ardb@kernel.org,
        hch@infradead.org, narmstrong@baylibre.com, dwmw2@infradead.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com, arnd@arndb.de,
        will@kernel.org
Date:   Tue, 02 Mar 2021 15:09:09 +0100
In-Reply-To: <644fd416-ab64-f1cc-ffb0-ea5649e3b600@arm.com>
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
         <20210226140305.26356-3-nsaenzjulienne@suse.de>
         <644fd416-ab64-f1cc-ffb0-ea5649e3b600@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YvPEsq9SJ5I0lHieQ2Gs"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YvPEsq9SJ5I0lHieQ2Gs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Robin,

On Tue, 2021-03-02 at 11:29 +0000, Robin Murphy wrote:
> On 2021-02-26 14:02, Nicolas Saenz Julienne wrote:
> > Some devices might inadvertently sit on buses that don't support 64bit
> > MMIO access, and need a mechanism to query these limitations without
> > prejudice to other buses in the system (i.e. defaulting to 32bit access
> > system wide isn't an option).
> >=20
> > Introduce a new bus callback, 'mmio_configure(),' which will take care
> > of populating the relevant device properties based on the bus'
> > limitations.
>=20
> Devil's advocate: there already exist workarounds for 8-bit and/or=20
> 16-bit accesses not working in various places, does it make sense for a=
=20
> 64-bit workaround to be so wildly different and disjoint?

Can you point out an example of the workarounds?

> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> > =C2=A0=C2=A0arch/Kconfig               | 8 ++++++++
> > =C2=A0=C2=A0drivers/base/dd.c          | 6 ++++++
> > =C2=A0=C2=A0include/linux/device.h     | 3 +++
> > =C2=A0=C2=A0include/linux/device/bus.h | 3 +++
> > =C2=A0=C2=A04 files changed, 20 insertions(+)
> >=20
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 2bb30673d8e6..ba7f246b6b9d 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1191,6 +1191,14 @@ config ARCH_SPLIT_ARG64
> > =C2=A0=C2=A0config ARCH_HAS_ELFCORE_COMPAT
> > =C2=A0=C2=A0	bool
> > =C2=A0=C2=A0
> >=20
> > +config ARCH_HAS_64BIT_MMIO_BROKEN
> > +	bool
> > +	depends on 64BIT
>=20
> As mentioned previously, 32-bit systems may not need the overrides for=
=20
> kernel I/O accessors, but they could still need the same workarounds for=
=20
> the memory-mapping implications (if this is to be a proper generic=20
> mechanism).

I'll keep it in mind.

> > +	default n
>
> Tip: it is always redundant to state that.

Noted!

Regards,
Nicolas


--=-YvPEsq9SJ5I0lHieQ2Gs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmA+RwUACgkQlfZmHno8
x/6DTgf/bmj475fZvD7LqvWdKkSnHyka/eRAnSEGswrw97NUvj87NWdWSWuJCy99
jQgfOUReSUE7/2VZHxWg0cHBFM4b6l6s8TQ7QghSA2urv3NhuMFRQgdQ+TgUnu27
goMc9hHjijbWSjwl1RWg/f1Ozs9RkDmBSNpFR8JJduExKkBl9JztrtOKZvsz8bWm
qgnw4asNx+UZxLERFj+HhWn7FWGWPZTjUpo0rN2tC3PKz/X3HalAm6j55D6xHWWt
ovPa2cTIdWbdGcvZ+MJ7XsI2WlElRFWhLqgtJHLnl5BybmcQAszusKU89zRI2Zfb
zd/0Xlgmzk7DuzoQzzi28mtC11XF7A==
=a14r
-----END PGP SIGNATURE-----

--=-YvPEsq9SJ5I0lHieQ2Gs--

