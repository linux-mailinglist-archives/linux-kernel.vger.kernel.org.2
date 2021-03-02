Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E73532A778
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449207AbhCBQQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:16:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:45296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381426AbhCBNi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:38:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C33C4ACBC;
        Tue,  2 Mar 2021 13:38:16 +0000 (UTC)
Message-ID: <ad6361433104d703338d2005cd8f3714508bccbb.camel@suse.de>
Subject: Re: [RFC 09/13] iommu/arm-smmu: Make use of
 dev_64bit_mmio_supported()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, ardb@kernel.org,
        hch@infradead.org, narmstrong@baylibre.com, dwmw2@infradead.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com, arnd@arndb.de,
        will@kernel.org
Date:   Tue, 02 Mar 2021 14:38:14 +0100
In-Reply-To: <3a4cf13f-c098-9ff3-6c0e-2c94daae452b@arm.com>
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
         <20210226140305.26356-10-nsaenzjulienne@suse.de>
         <3a4cf13f-c098-9ff3-6c0e-2c94daae452b@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wN85PY7iiGVDnz4rnxxC"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wN85PY7iiGVDnz4rnxxC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Robin, thanks for taking the time to look at this.

On Tue, 2021-03-02 at 11:07 +0000, Robin Murphy wrote:
> On 2021-02-26 14:03, Nicolas Saenz Julienne wrote:
> > Some arm SMMU implementations might sit on a bus that doesn't support
> > 64bit memory accesses. In that case default to using hi_lo_{readq,
> > writeq}() and BUG if such platform tries to use AArch64 formats as they
> > rely on writeq()'s atomicity.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> > =C2=A0=C2=A0drivers/iommu/arm/arm-smmu/arm-smmu.c | 9 +++++++++
> > =C2=A0=C2=A0drivers/iommu/arm/arm-smmu/arm-smmu.h | 9 +++++++--
> > =C2=A0=C2=A02 files changed, 16 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/=
arm-smmu/arm-smmu.c
> > index d8c6bfde6a61..239ff42b20c3 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -1889,6 +1889,15 @@ static int arm_smmu_device_cfg_probe(struct arm_=
smmu_device *smmu)
> > =C2=A0=C2=A0			smmu->features |=3D ARM_SMMU_FEAT_FMT_AARCH64_64K;
> > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0
> >=20
> > +	/*
> > +	 * 64bit accesses not possible through the interconnect, AArch64
> > +	 * formats depend on it.
> > +	 */
> > +	BUG_ON(!dev_64bit_mmio_supported(smmu->dev) &&
> > +	       smmu->features & (ARM_SMMU_FEAT_FMT_AARCH64_4K |
> > +				ARM_SMMU_FEAT_FMT_AARCH64_16K |
> > +				ARM_SMMU_FEAT_FMT_AARCH64_64K));
>=20
> No. Crashing the kernel in a probe routine which is free to fail is=20
> unacceptable either way, but guaranteeing failure in the case that the=
=20
> workaround *would* be required is doubly so.
>=20
> Basically, this logic is backwards - if you really wanted to handle it=
=20
> generically, this would be the point at which you'd need to actively=20
> suppress all the detected hardware features which depend on 64-bit=20
> atomicity, not complain about them.

Understood.

> > +
> > =C2=A0=C2=A0	if (smmu->impl && smmu->impl->cfg_probe) {
> > =C2=A0=C2=A0		ret =3D smmu->impl->cfg_probe(smmu);
> > =C2=A0=C2=A0		if (ret)
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/=
arm-smmu/arm-smmu.h
> > index d2a2d1bc58ba..997d13a21717 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > @@ -477,15 +477,20 @@ static inline void arm_smmu_writel(struct arm_smm=
u_device *smmu, int page,
> > =C2=A0=C2=A0{
> > =C2=A0=C2=A0	if (smmu->impl && unlikely(smmu->impl->write_reg))
> > =C2=A0=C2=A0		smmu->impl->write_reg(smmu, page, offset, val);
> > -	else
> > +	else if (dev_64bit_mmio_supported(smmu->dev))
> > =C2=A0=C2=A0		writel_relaxed(val, arm_smmu_page(smmu, page) + offset);
> > +	else
> > +		hi_lo_writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
>=20
> As Arnd pointed out, this is in completely the wrong place. Also, in=20

Yes, sorry for that, not too proud of it.

> general it doesn't work if the implementation already needs a hook to=20
> filter or override register accesses for any other reason. TBH I'm not=
=20

I'm not sure I get your point here, 'smmu->impl' has precedence over the MM=
IO
capability check. Custom implementations would still get their callbacks.

> convinced that this isn't *more* of a mess than handling it on a=20
> SoC-specific basis...

I see your point.

Just to explain why I went to these lengths: my understanding is that the
specifics of how to perform 32bit accesses to SMMU's 64bit registers is def=
ined
in spec. So it made sense to move it into the non implementation dependent =
side
of the driver.

All in all, I'll think of something simpler.

Regards,
Nicolas


--=-wN85PY7iiGVDnz4rnxxC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmA+P8YACgkQlfZmHno8
x/4StQgAkLUKE6F/7yFab1Ti1xLuHnbi95BqA747fmb/x/LUnVKSRs05zbtCn10z
M9gK+LYnbYRHIXrqL4GHWBJG/R+qF3XVKoNHAk5dfrctCaGnVujGrfxSTB4lkH/z
gbbKlXo8UHkTk6QnIE5XgmGz+2RgLP2yCx7XtWvKRpLRgTP4fsbC7M0wxERzBIEn
VFnoM2a/eKGP3j2spN6TVy2AdXaBu89kosJ50ytD8AwSTrD9eNx15fBzy5w1sqrw
gZNA3lSp0VbqRSb1G2Efa/tSkHW38Rb7YWOdf6sY6fBIT9VXW2QpHxolv3DurPk4
0JbQK4vEzXdARdgCN/rrhB9UgL8FdA==
=teKv
-----END PGP SIGNATURE-----

--=-wN85PY7iiGVDnz4rnxxC--

