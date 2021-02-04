Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C120A30F796
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhBDQVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:21:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:55082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237756AbhBDQU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:20:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52306ABD5;
        Thu,  4 Feb 2021 16:20:14 +0000 (UTC)
Message-ID: <a7951d7f651681fcfd45cea4f8b173c23cc34aa0.camel@suse.de>
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
Date:   Thu, 04 Feb 2021 17:20:11 +0100
In-Reply-To: <20210130071025.65258-8-chenzhou10@huawei.com>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
         <20210130071025.65258-8-chenzhou10@huawei.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LxuFd/trEQUkJJT19YKS"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LxuFd/trEQUkJJT19YKS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chen,

On Sat, 2021-01-30 at 15:10 +0800, Chen Zhou wrote:
> Introduce macro CRASH_ALIGN for alignment, macro CRASH_ADDR_LOW_MAX
> for upper bound of low crash memory, macro CRASH_ADDR_HIGH_MAX for
> upper bound of high crash memory, use macroes instead.
>=20
> Besides, keep consistent with x86, use CRASH_ALIGN as the lower bound
> of crash kernel reservation.
>=20
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> ---
> =C2=A0arch/arm64/include/asm/kexec.h | 6 ++++++
> =C2=A0arch/arm64/mm/init.c           | 6 +++---
> =C2=A02 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexe=
c.h
> index d24b527e8c00..3f6ecae0bc68 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -25,6 +25,12 @@
> =C2=A0
>=20
> =C2=A0#define KEXEC_ARCH KEXEC_ARCH_AARCH64
> =C2=A0
>=20
> +/* 2M alignment for crash kernel regions */
> +#define CRASH_ALIGN	SZ_2M
> +
> +#define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit

I wonder if you could use 'ARCH_LOW_ADDRESS_LIMIT', instead of creating a n=
ew
define.

> +#define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
> +
> =C2=A0#ifndef __ASSEMBLY__
> =C2=A0
>=20
> =C2=A0/**
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 709d98fea90c..912f64f505f7 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -84,8 +84,8 @@ static void __init reserve_crashkernel(void)
> =C2=A0
>=20
> =C2=A0	if (crash_base =3D=3D 0) {
> =C2=A0		/* Current arm64 boot protocol requires 2MB alignment */
> -		crash_base =3D memblock_find_in_range(0, arm64_dma_phys_limit,
> -				crash_size, SZ_2M);
> +		crash_base =3D memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_LOW_MAX,
> +				crash_size, CRASH_ALIGN);

Actually we could get rid of CRASH_ADDR_LOW_MAX altogether if we used
memblock_alloc_low() here (modulo the slight refactoring needed to accommod=
ate
it).

Regards,
Nicolas


--=-LxuFd/trEQUkJJT19YKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAcHrsACgkQlfZmHno8
x/4VFQf/Za2F0DPLs/4XStKKvgiOXxh7Z9VuNZK+TFpC0un67QwVwZs12jI0F4Bs
Jdh8uz9B956OAwGio8TCE/HQs00jz7y68lfAAkDbLBLEA3BWqb6yrPOwmKa1pLy6
bn8xcIZX5m3gLj6AwEKQe1LKYaZrUV1PsW/rxDIH/ky7po51hf5f/q/72PnRVtkd
9jq9LYIfaCE+OvY6zxaxI7YrwjkXTMzMcliRmpO2PWZcWsW8DzsYJeqjOafs1+39
/UIjey5IdcNvrVQv373Ep2wVRIl7NMgPC6wc/2JiJ1MFedxStWZuj6tDizpy5y5Z
sT7HzaCsxzMdMrmDwqzGELGWOpI0AQ==
=ZCRh
-----END PGP SIGNATURE-----

--=-LxuFd/trEQUkJJT19YKS--

