Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6AD344F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhCVSt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:49:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhCVSsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:48:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D087DAD80;
        Mon, 22 Mar 2021 18:48:44 +0000 (UTC)
Message-ID: <b1f86df8e895304785d73b24d9e7e1aace332502.camel@suse.de>
Subject: Re: [PATCH v3 2/2] arm64: mm: reserve CMA and crashkernel in
 ZONE_DMA32
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jon Masters <jcm@jonmasters.org>, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 22 Mar 2021 19:48:43 +0100
In-Reply-To: <d2cde732-a6d5-65d3-843a-e2f3fe498fde@jonmasters.org>
References: <20191107095611.18429-1-nsaenzjulienne@suse.de>
         <20191107095611.18429-3-nsaenzjulienne@suse.de>
         <4f094513-507d-566d-a0e2-a30ea36f64c9@jonmasters.org>
         <d2cde732-a6d5-65d3-843a-e2f3fe498fde@jonmasters.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9iHYFcF7AG5JS/g9N0on"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9iHYFcF7AG5JS/g9N0on
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-03-22 at 14:40 -0400, Jon Masters wrote:
> On 3/22/21 2:34 PM, Jon Masters wrote:
> > Hi Nicolas,
> >=20
> > On 11/7/19 4:56 AM, Nicolas Saenz Julienne wrote:
> > > With the introduction of ZONE_DMA in arm64 we moved the default CMA a=
nd
> > > crashkernel reservation into that area. This caused a regression on b=
ig
> > > machines that need big CMA and crashkernel reservations. Note that
> > > ZONE_DMA is only 1GB big.
> > >=20
> > > Restore the previous behavior as the wide majority of devices are OK
> > > with reserving these in ZONE_DMA32. The ones that need them in ZONE_D=
MA
> > > will configure it explicitly.
> > >=20
> > > Reported-by: Qian Cai <cai@lca.pw>
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > ---
> > > =C2=A0 arch/arm64/mm/init.c | 4 ++--
> > > =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > index 580d1052ac34..8385d3c0733f 100644
> > > --- a/arch/arm64/mm/init.c
> > > +++ b/arch/arm64/mm/init.c
> > > @@ -88,7 +88,7 @@ static void __init reserve_crashkernel(void)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (crash_base =3D=3D 0) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Current arm=
64 boot protocol requires 2MB alignment */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crash_base =3D memblock_f=
ind_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crash_base =3D memblock_f=
ind_in_range(0, arm64_dma32_phys_limit,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crash_size, SZ_2M);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (crash_base=
 =3D=3D 0) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> > > @@ -454,7 +454,7 @@ void __init arm64_memblock_init(void)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 high_memory =3D __va(memblock_end_of_D=
RAM() - 1) + 1;
> > > -=C2=A0=C2=A0=C2=A0 dma_contiguous_reserve(arm64_dma_phys_limit ? :=
=20
> > > arm64_dma32_phys_limit);
> > > +=C2=A0=C2=A0=C2=A0 dma_contiguous_reserve(arm64_dma32_phys_limit);
> > > =C2=A0 }
> > > =C2=A0 void __init bootmem_init(void)
> >=20
> > Can we get a bit more of a backstory about what the regression was on=
=20
> > larger machines? If the 32-bit DMA region is too small, but the machine=
=20
> > otherwise has plenty of memory, the crashkernel reservation will fail.=
=20
> > Most e.g. enterprise users aren't going to respond to that situation by=
=20
> > determining the placement manually, they'll just not have a crashkernel=
.
>=20
> Nevermind, looks like Catalin already changed this logic in Jan 2021 by=
=20
> removing arm64_dma32_phys_limit and I'm out of date.

Also see this series (already merged):

https://lore.kernel.org/linux-arm-kernel/20201119175400.9995-1-nsaenzjulien=
ne@suse.de/

Regads,
Nicolas


--=-9iHYFcF7AG5JS/g9N0on
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBY5osACgkQlfZmHno8
x/5wPAf/WA4vj1kbrX0NtO4qTprFN/IA4jdplzDtN3CTgiXbuscV6xJjsbby0l7B
aq73lCWc7WDGlUdg92a3tBc3VwcAngl2Hl/HwSD36Gj1EHkFzF0BY/AGgs6sy7FI
4vQk/EjKja5Wqe9OI9urmoP0J6hgcreNaROxldg0NzGH5iop/sdX5T7PtBK6yO1D
YKarQbCuke2PP5CTJzfKDaaJ7kuXQWCe7bBlrlKbqZftZbd68DbHD0Viis5A5Wfj
sny7asDVXjiVWEX688VANHnAeUnJJprPheU67vTlD9n8tqRxqpmEeDvE3V3clph3
QFCQLxKnmArwDaHhNM3raRFLJphGkw==
=M3gO
-----END PGP SIGNATURE-----

--=-9iHYFcF7AG5JS/g9N0on--

