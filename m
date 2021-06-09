Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14903A0C2A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhFIGKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:10:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49099 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232209AbhFIGKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:10:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4G0Grh1tDCz9sRf; Wed,  9 Jun 2021 16:08:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1623218932;
        bh=zMBN5dUHeVSexpTWTBruELzP24ku4FDDcQkso9GAa2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yv4zdTTfZ4CMY+/g4dd3fFuZL2X05/zOYIdeBioEvckTFh5Cryrz+fBrQktzNyGs5
         t0B0+ruWT/N08bU4MmCKYjCqB4uxhWxu4KHPeErhxeCF370Z3eRYryrQWCwvdhXAQP
         hRpt6KJ/ByEBy+JFosg/b1/g8ftFRNvHl268kKKE=
Date:   Wed, 9 Jun 2021 16:08:48 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
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
Message-ID: <YMBa8Ms9rL795OdS@yekko>
References: <20210430143607.135005-1-leobras.c@gmail.com>
 <20210430143607.135005-4-leobras.c@gmail.com>
 <YL2sjKM7ByS0Xeko@yekko>
 <fa7a0e981a067445beb1ae01d53db932990717b7.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GYNQ/kifoVnYIDex"
Content-Disposition: inline
In-Reply-To: <fa7a0e981a067445beb1ae01d53db932990717b7.camel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GYNQ/kifoVnYIDex
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 02:30:36AM -0300, Leonardo Br=E1s wrote:
> On Mon, 2021-06-07 at 15:20 +1000, David Gibson wrote:
> > On Fri, Apr 30, 2021 at 11:36:10AM -0300, Leonardo Bras wrote:
> > > During memory hotunplug, after each LMB is removed, the HPT may be
> > > resized-down if it would map a max of 4 times the current amount of
> > > memory.
> > > (2 shifts, due to introduced histeresis)
> > >=20
> > > It usually is not an issue, but it can take a lot of time if HPT
> > > resizing-down fails. This happens=A0 because resize-down failures
> > > usually repeat at each LMB removal, until there are no more bolted
> > > entries
> > > conflict, which can take a while to happen.
> > >=20
> > > This can be solved by doing a single HPT resize at the end of
> > > memory
> > > hotunplug, after all requested entries are removed.
> > >=20
> > > To make this happen, it's necessary to temporarily disable all HPT
> > > resize-downs before hotunplug, re-enable them after hotunplug ends,
> > > and then resize-down HPT to the current memory size.
> > >=20
> > > As an example, hotunplugging 256GB from a 385GB guest took 621s
> > > without
> > > this patch, and 100s after applied.
> > >=20
> > > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> >=20
> > Hrm.=A0 This looks correct, but it seems overly complicated.
> >=20
> > AFAICT, the resize calls that this adds should in practice be the
> > *only* times we call resize, all the calls from the lower level code
> > should be suppressed.=A0
>=20
> That's correct.
>=20
> >  In which case can't we just remove those calls
> > entirely, and not deal with the clunky locking and exclusion here.
> > That should also remove the need for the 'shrinking' parameter in
> > 1/3.
>=20
>=20
> If I get your suggestion correctly, you suggest something like:
> 1 - Never calling resize_hpt_for_hotplug() in
> hash__remove_section_mapping(), thus not needing the srinking
> parameter.
> 2 - Functions in hotplug-memory.c that call dlpar_remove_lmb() would in
> fact call another function to do the batch resize_hpt_for_hotplug() for
> them

Basically, yes.

> If so, that assumes that no other function that currently calls
> resize_hpt_for_hotplug() under another path, or if they do, it does not
> need to actually resize the HPT.
>=20
> Is the above correct?
>=20
> There are some examples of functions that currently call
> resize_hpt_for_hotplug() by another path:
>=20
> add_memory_driver_managed
> 	virtio_mem_add_memory
> 	dev_dax_kmem_probe

Oh... virtio-mem.  I didn't think of that.


> reserve_additional_memory
> 	balloon_process
> 	add_ballooned_pages

AFAICT this comes from drivers/xen, and Xen has never been a thing on
POWER.

> __add_memory
> 	probe_store

So this is a sysfs triggered memory add.  If the user is doing this
manually, then I think it's reasonable for them to manually manage the
HPT size as well, which they can do through debugfs.  I think it might
also be used my drmgr under pHyp, but pHyp doesn't support HPT
resizing.

> __remove_memory
> 	pseries_remove_memblock

Huh, this one comes through OF_RECONFIG_DETACH_NODE.  I don't really
know when those happen, but I strongly suspect it's only under pHyp
again.

> remove_memory
> 	dev_dax_kmem_remove
> 	virtio_mem_remove_memory

virtio-mem again.

> memunmap_pages
> 	pci_p2pdma_add_resource
> 	virtio_fs_setup_dax

And virtio-fs in dax mode.  Didn't think of that either.


Ugh, yeah, I'm used to the world where the platform provides the only
way of hotplugging memory, but virtio-mem does indeed provide another
one, and we could indeed need to manage the HPT size based on that.
Drat, so moving all the HPT resizing handling up into
pseries/hotplug-memory.c won't work.

I still think we can simplify the communication between the stuff in
the pseries hotplug code and the actual hash resizing.  In your draft
there are kind of 3 ways the information is conveyed: the mutex
suppresses HPT shrinks, pre-growing past what we need prevents HPT
grows, and the 'shrinking' flag handles some edge cases.

I suggest instead a single flag that will suppress all the current
resizes.  Not sure it technically has to be an atomic mutex, but
that's probably the obvious safe choice.  Then have a "resize up to
target" and "resize down to target" that ignore that suppression and
are no-ops if the target is in the other direction.
Then you should be able to make the path for pseries hotplugs be:

	suppress other resizes

	resize up to target

	do the actual adds or removes

	resize down to target

	unsuppress other resizes


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GYNQ/kifoVnYIDex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmDAWu4ACgkQbDjKyiDZ
s5IZdRAAwOwgZ6dYIpOLXDclhHx4Gzd2DLYRzlmZq5nOmbSRXRMSD0zcQ/lZtErI
Oq7WmfPqqYlRmeC54d8zJsjf8tserDB6en5ev04oeZmdmBE/OV9FNYaZLfE73Vfx
oCCWEHKNm9aBza1essJh5/chU3sQXbY5FuboQLzsPBnN27HeTj6hK9p2qqHW+LBm
CXn1bTiAuvg6ONKU8ZRhuqTvqM+OnLXCU8/Jllluc8Q2rdAYIDyGlyFxD28d0hgO
uo6LmVINS0woliRhcMIFg5uAobOd1bqcb1xoWyIsXLsWVwMbxVsmK6idCptuozOM
GAlVXP57yZl+aGDgsRJ081sJq7e1AxQv8hlA5v/SNUo53koJpKt7ZAXY7x8TCKVJ
HsJrLfNmzOYvbZb/J4DecTJwCtSXRH1RM4VZEEji0MNxBc0u8GkBikRpqY3SgpDg
dgjJrR0B810mBfPYfJc+jKqSwXGCFqsCDWJX5zjaqxsYKgyLip8zIHE1BjeoGrNu
si3m5uFji3Po7OYP98Tu1AR4FmyU1dR5cGTX65g6/5GQGN209brbQRf9tYYDT9iA
d2z9/rt/YhoOa9X6qJkEQM5t+BY+O/8PBLqtXkl9Z5kjSWylO8ln+aQ7ZbVlwNWc
KgQkhdXKU5GXoC5sU8OYFYVrj65Ksc7Ic+2RjxHLEVHxnUGlNDc=
=GVzq
-----END PGP SIGNATURE-----

--GYNQ/kifoVnYIDex--
