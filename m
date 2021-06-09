Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED623A0BC6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 07:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhFIFUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 01:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhFIFUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 01:20:38 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572FDC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 22:18:44 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4G0Fkm3LzRz9sSn; Wed,  9 Jun 2021 15:18:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1623215920;
        bh=I2R81KysSK5UMKwKNmC/z1RaD1s+FY3px1l0EvD/X3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YiKkOry+fjLpYXVtDn+f+MROuDDfsmnSSteQ2BUjXqkkw9CVfOKckgZrE8pxnQoTi
         8G8m9Pdd5a8tHORJV/UsQWhDg7ORlqkr6Kx7erPLic8wrq9dlqw6znhIhXWaC90CRf
         YAvxFipYjrlSblqIwc12wzjF99NwEiAXiqSD4Law=
Date:   Wed, 9 Jun 2021 14:40:59 +1000
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
Subject: Re: [PATCH v2 1/3] powerpc/mm/hash: Avoid resizing-down HPT on first
 memory hotplug
Message-ID: <YMBGW3RQOzoQxBqy@yekko>
References: <20210430143607.135005-1-leobras.c@gmail.com>
 <20210430143607.135005-2-leobras.c@gmail.com>
 <YL2obsnp4rWbW6CV@yekko>
 <648b382159009c5f4277d9b9c3f896142ea75d6c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JIXKiScEiqVqxi4e"
Content-Disposition: inline
In-Reply-To: <648b382159009c5f4277d9b9c3f896142ea75d6c.camel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JIXKiScEiqVqxi4e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 08, 2021 at 09:52:10PM -0300, Leonardo Br=E1s wrote:
> On Mon, 2021-06-07 at 15:02 +1000, David Gibson wrote:
> > On Fri, Apr 30, 2021 at 11:36:06AM -0300, Leonardo Bras wrote:
> > > Because hypervisors may need to create HPTs without knowing the
> > > guest
> > > page size, the smallest used page-size (4k) may be chosen,
> > > resulting in
> > > a HPT that is possibly bigger than needed.
> > >=20
> > > On a guest with bigger page-sizes, the amount of entries for HTP
> > > may be
> > > too high, causing the guest to ask for a HPT resize-down on the
> > > first
> > > hotplug.
> > >=20
> > > This becomes a problem when HPT resize-down fails, and causes the
> > > HPT resize to be performed on every LMB added, until HPT size is
> > > compatible to guest memory size, causing a major slowdown.
> > >=20
> > > So, avoiding HPT resizing-down on hot-add significantly improves
> > > memory
> > > hotplug times.
> > >=20
> > > As an example, hotplugging 256GB on a 129GB guest took 710s without
> > > this
> > > patch, and 21s after applied.
> > >=20
> > > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> >=20
> > Sorry it's taken me so long to look at these
> >=20
> > I don't love the extra statefulness that the 'shrinking' parameter
> > adds, but I can't see an elegant way to avoid it, so:
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> np, thanks for reviewing!

Actually... I take that back.  With the subsequent patches my
discomfort with the complexity of implementing the batching grew.

I think I can see a simpler way - although it wasn't as clear as I
thought it might be, without some deep history on this feature.

What's going on here is pretty hard to follow, because it starts in
arch-specific code (arch/powerpc/platforms/pseries/hotplug-memory.c)
where it processes the add/remove requests, then goes into generic
code __add_memory() which eventually emerges back in arch specific
code (hash__create_section_mapping()).

The HPT resizing calls are in the "inner" arch specific section,
whereas it's only the outer arch section that has the information to
batch properly.  The mutex and 'shrinking' parameter in Leonardo's
code are all about conveying information from the outer to inner
section.

Now, I think the reason I had the resize calls in the inner section
was to accomodate the notion that a) pHyp might support resizing in
future, and it could come in through a different path with its drmgr
thingy and/or b) bare metal hash architectures might want to implement
hash resizing, and this would make at least part of the path common.

Given the decreasing relevance of hash MMUs, I think we can now safely
say neither of these is ever going to happen.

Therefore, we can simplify things by moving the HPT resize calls into
the pseries LMB code, instead of create/remove_section_mapping.  Then
to do batching without extra complications we just need this logic for
all resizes (both add and remove):

	let new_hpt_order =3D expected HPT size for new mem size;

	if (new_hpt_order > current_hpt_order)
		resize to new_hpt_order

	add/remove memory

	if (new_hpt_order < current_hpt_order - 1)
		resize to new_hpt_order


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JIXKiScEiqVqxi4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmDARlkACgkQbDjKyiDZ
s5L1tRAAkuor5k1WYVSOmA9nSFxuvGLrZfHFGixzV8D5KZPdlEN7q3n7zx4XYhgl
OtbvwC6u9+K2C2m6+E4Nj/FWiycRgw7ZIBZgPSMQIzbWV4IB3UaYf72ZKT55E3q8
UONpFPaoi4xDic9lwMqUhf6vUrZ+l05GKV+osojSsNNxiSGuJ/6aOv301FSfptsK
D/lXVQYf1X2WLPWYJe2rJO3A/iWkhZ4UX0MrNRtfZ7WrRIFRuV4VCbfWqmcCuhI9
GBAGxSLB5VKRU8mTXTO1KQPLE32l0S+tknpMhAX/Vwp24E5DQDKoSBZvPIXPdi1q
QEnQT/5MokHSVd2obB944eLuylN5++PenUDbW/L+P9XyMIgvWJd6sIiFraqKOQNw
o32NJryjQ413KowxYIYa5vLVStWJ+AcQKVIIouzwKle5mGYSaBwXOh7kUjOMIFxh
QfNrOxtN5uWarxiVUbnVUM3BB425WJBP31jE+J7YnCi9tXtKAw5XBj2zaa4rxhvY
EgsUc1p3rz4PuI+jijBYI+KfBsTS6RaueB/LG4Fdl6PhIZuryfabbKSe4vtOLzUJ
ormnBmFEu9MPSpM3JoSON/UiDgjI1Ywm0W7VjtOyMc2BWXF/7E3gKSg6tMq//ePH
LaqFXRj6YlieGDbFMwNKr0aeY/KXAvGXsXMFmxYNyNaArZTbvMA=
=7p9d
-----END PGP SIGNATURE-----

--JIXKiScEiqVqxi4e--
