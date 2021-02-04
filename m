Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAAC30F7E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbhBDQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:29:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:59038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238005AbhBDQ2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:28:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8BB14B0B3;
        Thu,  4 Feb 2021 16:27:41 +0000 (UTC)
Message-ID: <ff12c314f3c122de9f2d9f5d826fac9e5e6248dc.camel@suse.de>
Subject: Re: [PATCH v14 07/11] arm64: kdump: introduce some macroes for
 crash kernel reservation
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Chen Zhou <chenzhou10@huawei.com>, mingo@redhat.com,
        tglx@linutronix.de, rppt@kernel.org, dyoung@redhat.com,
        bhe@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        corbet@lwn.net, John.P.donnelly@oracle.com, bhsharma@redhat.com,
        prabhakar.pkin@gmail.com
Cc:     horms@verge.net.au, robh+dt@kernel.org, arnd@arndb.de,
        james.morse@arm.com, xiexiuqi@huawei.com, guohanjun@huawei.com,
        huawei.libin@huawei.com, wangkefeng.wang@huawei.com,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Date:   Thu, 04 Feb 2021 17:27:39 +0100
In-Reply-To: <a7951d7f651681fcfd45cea4f8b173c23cc34aa0.camel@suse.de>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
         <20210130071025.65258-8-chenzhou10@huawei.com>
         <a7951d7f651681fcfd45cea4f8b173c23cc34aa0.camel@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hF9DE29OJv+9/WzzoEGg"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hF9DE29OJv+9/WzzoEGg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-02-04 at 17:20 +0100, Nicolas Saenz Julienne wrote:
> Hi Chen,
>=20
> On Sat, 2021-01-30 at 15:10 +0800, Chen Zhou wrote:
> > Introduce macro CRASH_ALIGN for alignment, macro CRASH_ADDR_LOW_MAX
> > for upper bound of low crash memory, macro CRASH_ADDR_HIGH_MAX for
> > upper bound of high crash memory, use macroes instead.
> >=20
> > Besides, keep consistent with x86, use CRASH_ALIGN as the lower bound
> > of crash kernel reservation.
> >=20
> > Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> > Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> > ---
> > =C2=A0arch/arm64/include/asm/kexec.h | 6 ++++++
> > =C2=A0arch/arm64/mm/init.c           | 6 +++---
> > =C2=A02 files changed, 9 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/ke=
xec.h
> > index d24b527e8c00..3f6ecae0bc68 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> > @@ -25,6 +25,12 @@
> > =C2=A0
> >=20
> > =C2=A0#define KEXEC_ARCH KEXEC_ARCH_AARCH64
> > =C2=A0
> >=20
> > +/* 2M alignment for crash kernel regions */
> > +#define CRASH_ALIGN	SZ_2M
> > +
> > +#define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
>=20
> I wonder if you could use 'ARCH_LOW_ADDRESS_LIMIT', instead of creating a=
 new
> define.
>=20
> > +#define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
> > +
> > =C2=A0#ifndef __ASSEMBLY__
> > =C2=A0
> >=20
> > =C2=A0/**
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 709d98fea90c..912f64f505f7 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -84,8 +84,8 @@ static void __init reserve_crashkernel(void)
> > =C2=A0
> >=20
> > =C2=A0	if (crash_base =3D=3D 0) {
> > =C2=A0		/* Current arm64 boot protocol requires 2MB alignment */
> > -		crash_base =3D memblock_find_in_range(0, arm64_dma_phys_limit,
> > -				crash_size, SZ_2M);
> > +		crash_base =3D memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_LOW_MA=
X,
> > +				crash_size, CRASH_ALIGN);
>=20
> Actually we could get rid of CRASH_ADDR_LOW_MAX altogether if we used
> memblock_alloc_low() here (modulo the slight refactoring needed to accomm=
odate
> it).

Forget about these coments, I now see that you're deleting this whole funct=
ion
on the next patch and defaulting to a generic implementation. Sorry for the
noise.

Regards,
Nicolas


--=-hF9DE29OJv+9/WzzoEGg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAcIHsACgkQlfZmHno8
x/4koQf9FsJXXPPAo7MZvAypzOcOr8Kk3liIYdzd7FU2HxGgB/sYGnlYWzn5/Vsm
tA7ay+h/LbTyM2lkYLQO27T8LQxl6kaaG0AzlEpMJWZKlJoxiWak6XOtNRlDROCB
bAJ6lH8wh/DxbOKEtpYIXrCiJTiSGszErGj6qlRcGQEVe8//VeXAfVAsoR8AQ/jL
7LRgDrTbjMakT/zrOVjNtRCtA6kpv3U04bmi53C2V1cgOlowQNJQlTJ2nQBmDwmR
Vkze+pFW28MlYn70T8FEQCtehj41Sx83khwQysULZKQrGlEFOt8tlfNSlVL3muHv
WQzt8y5R5NVjm51qZRewuOlnTuVoAA==
=3xak
-----END PGP SIGNATURE-----

--=-hF9DE29OJv+9/WzzoEGg--

