Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E558343B09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhCVH4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:56:15 -0400
Received: from ozlabs.org ([203.11.71.1]:57155 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhCVHzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:55:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4F3myR33Mhz9sW4; Mon, 22 Mar 2021 18:55:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1616399743;
        bh=iXW50wXRudKRGwTFh9sWa1KF8w7414Xekxwj8VRKjGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pvdzhb++ltYujkrwSxE6Q4MI6Vj6NkhxsuAMgIP3WuRvci4mROa0uBm9mANBByMSA
         rBOMuukSCqr4FTqIGC2qGO6+vf23Yy4hMBFAFi/QQUOKGjBBDY2SQw3NoJW4inecKd
         2PO9SYypWY+mDqiSnDplzHVJrSXS6h3YQk0m4z2c=
Date:   Mon, 22 Mar 2021 17:49:53 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mike Rapoport <rppt@kernel.org>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powerpc/mm/hash: Avoid resizing-down HPT on first
 memory hotplug
Message-ID: <YFg+Edy6dfmZx3lr@yekko.fritz.box>
References: <20210312072940.598696-1-leobras.c@gmail.com>
 <20210312072940.598696-2-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+KZWWyDCgmkgJp5r"
Content-Disposition: inline
In-Reply-To: <20210312072940.598696-2-leobras.c@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+KZWWyDCgmkgJp5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 12, 2021 at 04:29:39AM -0300, Leonardo Bras wrote:
> Because hypervisors may need to create HPTs without knowing the guest
> page size, the smallest used page-size (4k) may be chosen, resulting in
> a HPT that is possibly bigger than needed.
>=20
> On a guest with bigger page-sizes, the amount of entries for HTP may be
> too high, causing the guest to ask for a HPT resize-down on the first
> hotplug.
>=20
> This becomes a problem when HPT resize-down fails, and causes the
> HPT resize to be performed on every LMB added, until HPT size is
> compatible to guest memory size, causing a major slowdown.
>=20
> So, avoiding HPT resizing-down on hot-add significantly improves memory
> hotplug times.
>=20
> As an example, hotplugging 256GB on a 129GB guest took 710s without this
> patch, and 21s after applied.
>=20
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>

I don't love this approach.  Adding the extra flag at this level seems
a bit inelegant, and it means we're passing up an easy opportunity to
reduce our resource footprint on the host.

But... maybe we'll have to do it.  I'd like to see if we can get
things to work well enough with just the "batching" to avoid multiple
resize attempts first.

> ---
>  arch/powerpc/mm/book3s64/hash_utils.c | 36 ++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book=
3s64/hash_utils.c
> index 73b06adb6eeb..cfb3ec164f56 100644
> --- a/arch/powerpc/mm/book3s64/hash_utils.c
> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> @@ -794,7 +794,7 @@ static unsigned long __init htab_get_table_size(void)
>  }
> =20
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -static int resize_hpt_for_hotplug(unsigned long new_mem_size)
> +static int resize_hpt_for_hotplug(unsigned long new_mem_size, bool shrin=
king)
>  {
>  	unsigned target_hpt_shift;
> =20
> @@ -803,19 +803,25 @@ static int resize_hpt_for_hotplug(unsigned long new=
_mem_size)
> =20
>  	target_hpt_shift =3D htab_shift_for_mem_size(new_mem_size);
> =20
> -	/*
> -	 * To avoid lots of HPT resizes if memory size is fluctuating
> -	 * across a boundary, we deliberately have some hysterisis
> -	 * here: we immediately increase the HPT size if the target
> -	 * shift exceeds the current shift, but we won't attempt to
> -	 * reduce unless the target shift is at least 2 below the
> -	 * current shift
> -	 */
> -	if (target_hpt_shift > ppc64_pft_size ||
> -	    target_hpt_shift < ppc64_pft_size - 1)
> -		return mmu_hash_ops.resize_hpt(target_hpt_shift);
> +	if (shrinking) {
> =20
> -	return 0;
> +		/*
> +		 * To avoid lots of HPT resizes if memory size is fluctuating
> +		 * across a boundary, we deliberately have some hysterisis
> +		 * here: we immediately increase the HPT size if the target
> +		 * shift exceeds the current shift, but we won't attempt to
> +		 * reduce unless the target shift is at least 2 below the
> +		 * current shift
> +		 */
> +
> +		if (target_hpt_shift >=3D ppc64_pft_size - 1)
> +			return 0;
> +
> +	} else if (target_hpt_shift <=3D ppc64_pft_size) {
> +		return 0;
> +	}
> +
> +	return mmu_hash_ops.resize_hpt(target_hpt_shift);
>  }
> =20
>  int hash__create_section_mapping(unsigned long start, unsigned long end,
> @@ -828,7 +834,7 @@ int hash__create_section_mapping(unsigned long start,=
 unsigned long end,
>  		return -1;
>  	}
> =20
> -	resize_hpt_for_hotplug(memblock_phys_mem_size());
> +	resize_hpt_for_hotplug(memblock_phys_mem_size(), false);
> =20
>  	rc =3D htab_bolt_mapping(start, end, __pa(start),
>  			       pgprot_val(prot), mmu_linear_psize,
> @@ -847,7 +853,7 @@ int hash__remove_section_mapping(unsigned long start,=
 unsigned long end)
>  	int rc =3D htab_remove_mapping(start, end, mmu_linear_psize,
>  				     mmu_kernel_ssize);
> =20
> -	if (resize_hpt_for_hotplug(memblock_phys_mem_size()) =3D=3D -ENOSPC)
> +	if (resize_hpt_for_hotplug(memblock_phys_mem_size(), true) =3D=3D -ENOS=
PC)
>  		pr_warn("Hash collision while resizing HPT\n");
> =20
>  	return rc;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+KZWWyDCgmkgJp5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmBYPhEACgkQbDjKyiDZ
s5IfmRAAkCGhA/1ADH9AQ3Hx1wiRHoiu833INxVLW2AVVsUXk9KyjBvH1eZnPZUa
fJksevzl+qul4PFGNLl5CrKzpGm+jpjsqZFLQgD9e5xoOYZTl7QeF23nBdCSKEQ3
L34lXek6H8i3iVAfHzDmi9kI0S4ot7BCK4OZwAPgrC649z5uJX194VRo7CCo0HQz
kSnGtPD4TmTtOxPGI242FFUjAr+kh2Kur7i/oIaCgk5AqJP4cQP7L8t/eh82kaFW
VHzs9NAajopKvo8fy8pdOsqzOiSsE0Xj7+L94awCz4vfOIc3I3Ch6pjIQDwhn+gJ
ZoKYtbq0ests9THu5Doq5ZBr4jQBdFgy1wOhUsc1ModlcSXNbp5rtY1X5u++ipu0
KNVXFhasoD6m2ZsFCMYs/z3U6Wk8DFyVk+GHH/l6H5WfLFAYmHKIWgR9yGcJCIh1
JuhXuN8B1FHsm91ztApx5twTcId3p8dh4ZuDUOoiLh0j0V+L9oyOd+XZh+RCcD3H
ltqqevM2gw0/tBhXtV+7jADGTbpITvXSs0fId/sEVnVsTLqdSgYewF7qgT6DSwZC
qxoYmVDEIJvaYk/9+CczywkYcgwVph7XcC8K0IM49utByC0HXGbSWbY+W0RdIe5h
9W32smfBQn2wwdCfKV/4qVV7PDYMwmFf1i19KXjgDjEDQ2Sg8as=
=zQSa
-----END PGP SIGNATURE-----

--+KZWWyDCgmkgJp5r--
