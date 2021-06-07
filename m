Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1253039D451
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 07:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhFGF0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 01:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhFGF0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 01:26:48 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942F8C061787
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 22:24:57 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4Fz1yt1SJKz9sW6; Mon,  7 Jun 2021 15:24:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1623043494;
        bh=Db/33+ZRQvbX4Z5I2x0IuwO21Vu9InXrQOrqi54qW8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mAwh/FU+We3MkeUeoKa+58B37e5LoDDAAa1zqgWJZOLlYcdKyJOl2PpCzkTE5jp9T
         wQZgIySP0eMLVd9gvlsDTiCc160OqZy9O+Ni0WjSvHxVwm31rXlcWQvPLpfqHrkaD+
         3Isvy/NnBeRP2Qpe217gyYGg8LmdOTrUQkDsZEro=
Date:   Mon, 7 Jun 2021 15:20:12 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] powerpc/mm/hash: Avoid multiple HPT resize-downs
 on memory hotunplug
Message-ID: <YL2sjKM7ByS0Xeko@yekko>
References: <20210430143607.135005-1-leobras.c@gmail.com>
 <20210430143607.135005-4-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ZECP14T/IR0xvzZ"
Content-Disposition: inline
In-Reply-To: <20210430143607.135005-4-leobras.c@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ZECP14T/IR0xvzZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 30, 2021 at 11:36:10AM -0300, Leonardo Bras wrote:
> During memory hotunplug, after each LMB is removed, the HPT may be
> resized-down if it would map a max of 4 times the current amount of memor=
y.
> (2 shifts, due to introduced histeresis)
>=20
> It usually is not an issue, but it can take a lot of time if HPT
> resizing-down fails. This happens  because resize-down failures
> usually repeat at each LMB removal, until there are no more bolted entries
> conflict, which can take a while to happen.
>=20
> This can be solved by doing a single HPT resize at the end of memory
> hotunplug, after all requested entries are removed.
>=20
> To make this happen, it's necessary to temporarily disable all HPT
> resize-downs before hotunplug, re-enable them after hotunplug ends,
> and then resize-down HPT to the current memory size.
>=20
> As an example, hotunplugging 256GB from a 385GB guest took 621s without
> this patch, and 100s after applied.
>=20
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>

Hrm.  This looks correct, but it seems overly complicated.

AFAICT, the resize calls that this adds should in practice be the
*only* times we call resize, all the calls from the lower level code
should be suppressed.  In which case can't we just remove those calls
entirely, and not deal with the clunky locking and exclusion here.
That should also remove the need for the 'shrinking' parameter in 1/3.

> ---
>  arch/powerpc/include/asm/book3s/64/hash.h     |  2 +
>  arch/powerpc/mm/book3s64/hash_utils.c         | 45 +++++++++++++++++--
>  .../platforms/pseries/hotplug-memory.c        | 26 +++++++++++
>  3 files changed, 70 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/inc=
lude/asm/book3s/64/hash.h
> index fad4af8b8543..6cd66e7e98c9 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -256,6 +256,8 @@ int hash__create_section_mapping(unsigned long start,=
 unsigned long end,
>  int hash__remove_section_mapping(unsigned long start, unsigned long end);
> =20
>  void hash_batch_expand_prepare(unsigned long newsize);
> +void hash_batch_shrink_begin(void);
> +void hash_batch_shrink_end(void);
> =20
>  #endif /* !__ASSEMBLY__ */
>  #endif /* __KERNEL__ */
> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book=
3s64/hash_utils.c
> index 3fa395b3fe57..73ecd0f61acd 100644
> --- a/arch/powerpc/mm/book3s64/hash_utils.c
> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> @@ -795,6 +795,9 @@ static unsigned long __init htab_get_table_size(void)
>  }
> =20
>  #ifdef CONFIG_MEMORY_HOTPLUG
> +
> +static DEFINE_MUTEX(hpt_resize_down_lock);
> +
>  static int resize_hpt_for_hotplug(unsigned long new_mem_size, bool shrin=
king)
>  {
>  	unsigned target_hpt_shift;
> @@ -805,7 +808,7 @@ static int resize_hpt_for_hotplug(unsigned long new_m=
em_size, bool shrinking)
>  	target_hpt_shift =3D htab_shift_for_mem_size(new_mem_size);
> =20
>  	if (shrinking) {
> -
> +		int ret;
>  		/*
>  		 * To avoid lots of HPT resizes if memory size is fluctuating
>  		 * across a boundary, we deliberately have some hysterisis
> @@ -818,10 +821,20 @@ static int resize_hpt_for_hotplug(unsigned long new=
_mem_size, bool shrinking)
>  		if (target_hpt_shift >=3D ppc64_pft_size - 1)
>  			return 0;
> =20
> -	} else if (target_hpt_shift <=3D ppc64_pft_size) {
> -		return 0;
> +		/* When batch removing entries, only resizes HPT at the end. */
> +
> +		if (!mutex_trylock(&hpt_resize_down_lock))
> +			return 0;
> +
> +		ret =3D mmu_hash_ops.resize_hpt(target_hpt_shift);
> +
> +		mutex_unlock(&hpt_resize_down_lock);
> +		return ret;
>  	}
> =20
> +	if (target_hpt_shift <=3D ppc64_pft_size)
> +		return 0;
> +
>  	return mmu_hash_ops.resize_hpt(target_hpt_shift);
>  }
> =20
> @@ -879,6 +892,32 @@ void hash_batch_expand_prepare(unsigned long newsize)
>  			break;
>  	}
>  }
> +
> +void hash_batch_shrink_begin(void)
> +{
> +	/* Disable HPT resize-down during hot-unplug */
> +	mutex_lock(&hpt_resize_down_lock);
> +}
> +
> +void hash_batch_shrink_end(void)
> +{
> +	const u64 starting_size =3D ppc64_pft_size;
> +	unsigned long newsize;
> +
> +	newsize =3D memblock_phys_mem_size();
> +	/* Resize to smallest SHIFT possible */
> +	while (resize_hpt_for_hotplug(newsize, true) =3D=3D -ENOSPC) {
> +		newsize *=3D 2;
> +		pr_warn("Hash collision while resizing HPT\n");
> +
> +		/* Do not try to resize to the starting size, or bigger value */
> +		if (htab_shift_for_mem_size(newsize) >=3D starting_size)
> +			break;
> +	}
> +
> +	/* Re-enables HPT resize-down after hot-unplug */
> +	mutex_unlock(&hpt_resize_down_lock);
> +}
>  #endif /* CONFIG_MEMORY_HOTPLUG */
> =20
>  static void __init hash_init_partition_table(phys_addr_t hash_table,
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/power=
pc/platforms/pseries/hotplug-memory.c
> index 48b2cfe4ce69..44bc50d72353 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -426,6 +426,9 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_r=
emove)
>  		return -EINVAL;
>  	}
> =20
> +	if (!radix_enabled())
> +		hash_batch_shrink_begin();
> +
>  	for_each_drmem_lmb(lmb) {
>  		rc =3D dlpar_remove_lmb(lmb);
>  		if (rc)
> @@ -471,6 +474,9 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_r=
emove)
>  		rc =3D 0;
>  	}
> =20
> +	if (!radix_enabled())
> +		hash_batch_shrink_end();
> +
>  	return rc;
>  }
> =20
> @@ -533,6 +539,9 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remo=
ve, u32 drc_index)
>  	if (lmbs_available < lmbs_to_remove)
>  		return -EINVAL;
> =20
> +	if (!radix_enabled())
> +		hash_batch_shrink_begin();
> +
>  	for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
>  		if (!(lmb->flags & DRCONF_MEM_ASSIGNED))
>  			continue;
> @@ -573,6 +582,9 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remo=
ve, u32 drc_index)
>  		}
>  	}
> =20
> +	if (!radix_enabled())
> +		hash_batch_shrink_end();
> +
>  	return rc;
>  }
> =20
> @@ -703,6 +715,9 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
>  	if (lmbs_added !=3D lmbs_to_add) {
>  		pr_err("Memory hot-add failed, removing any added LMBs\n");
> =20
> +		if (!radix_enabled())
> +			hash_batch_shrink_begin();
> +
>  		for_each_drmem_lmb(lmb) {
>  			if (!drmem_lmb_reserved(lmb))
>  				continue;
> @@ -716,6 +731,10 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
> =20
>  			drmem_remove_lmb_reservation(lmb);
>  		}
> +
> +		if (!radix_enabled())
> +			hash_batch_shrink_end();
> +
>  		rc =3D -EINVAL;
>  	} else {
>  		for_each_drmem_lmb(lmb) {
> @@ -817,6 +836,9 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u3=
2 drc_index)
>  	if (rc) {
>  		pr_err("Memory indexed-count-add failed, removing any added LMBs\n");
> =20
> +		if (!radix_enabled())
> +			hash_batch_shrink_begin();
> +
>  		for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
>  			if (!drmem_lmb_reserved(lmb))
>  				continue;
> @@ -830,6 +852,10 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u=
32 drc_index)
> =20
>  			drmem_remove_lmb_reservation(lmb);
>  		}
> +
> +		if (!radix_enabled())
> +			hash_batch_shrink_end();
> +
>  		rc =3D -EINVAL;
>  	} else {
>  		for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7ZECP14T/IR0xvzZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC9rIgACgkQbDjKyiDZ
s5LkihAAmkOkI+8UziKCfkESyFWukbpidLenPL0zD3SweNzn/IdRI2sbZdZjdH0B
wms68gnaS9xMQOPexEzNhJXg13vSBVo7hVeH91xs2KQRkH+HLyx8/t/txDZgSgtk
QNAatWkgev/UJDTwLzMFb0+mFY4JsVhf5bcxx+y4OAkyS1t7mIKATV7YnYjlfc7k
ezE1LwffSAFOinAy7hN7qcKnQtCfx8WI1hCwHmH+/Lss3gGfk/Tz/T4pkiSOcBvP
CaJFM3vDWw9fU5+VPTk/0uB4NnpSFRvwmGrHcoIPuMLw7DiFoVqWFzHUfmfIjdJ2
+Q8K9vg8f4cbecvNbqMohsmryA7PZze7CN+ZYoJcqdwBvZIJpqn94jODSdtGN8hp
Po64ejOG25kMAa31qfeSWH9uYcyaNwRP5wiAGvQ2d1qQG+qilo+NZy6HI2uDmUDd
1DUhL8PU4SSKicPCa0m7sXjZ3X6EVyzpirgNWYeQtzehO4Fk65uRDSZq79iKK6cS
l/JRBxP+JCttskcE7m2Gxh3g5s+NzWq4k30CwKjpAf5BMo7pFtmWOA0NacohoPBr
zvXydMnjtQYrfbwNcUJwUZ1eGo8e2qKXTDzlo2OEKMMjMzpQ4GD2iCUmOvBA8gJ8
YUX4ONRw5CCMvSSGdzgrEafLLNoU7AGwCFbqq4lfcDHlrMDycho=
=SvzB
-----END PGP SIGNATURE-----

--7ZECP14T/IR0xvzZ--
