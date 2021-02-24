Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8F53240E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbhBXPcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:32:25 -0500
Received: from shelob.surriel.com ([96.67.55.147]:49096 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbhBXO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:58:31 -0500
X-Greylist: delayed 662 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Feb 2021 09:58:30 EST
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lEvQq-0006j5-Se; Wed, 24 Feb 2021 09:46:28 -0500
Message-ID: <a7a85f81bd21254805bc91772530f237c9b73c04.camel@surriel.com>
Subject: Re: [PATCH v6 0/3] mm,thp,shm: limit shmem THP alloc gfp_mask
From:   Rik van Riel <riel@surriel.com>
To:     Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, xuyu@linux.alibaba.com,
        mgorman@suse.de, aarcange@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, mhocko@suse.com
Date:   Wed, 24 Feb 2021 09:46:13 -0500
In-Reply-To: <alpine.LSU.2.11.2102232329180.9202@eggly.anvils>
References: <20201124194925.623931-1-riel@surriel.com>
         <alpine.LSU.2.11.2012141226350.1925@eggly.anvils>
         <e3f67a5f-9835-2752-3d35-fb5f6d701cf1@suse.cz>
         <alpine.LSU.2.11.2102232329180.9202@eggly.anvils>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-OromBUoFm9ZFqotShFp+"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OromBUoFm9ZFqotShFp+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-02-24 at 00:41 -0800, Hugh Dickins wrote:
> On Mon, 14 Dec 2020, Vlastimil Babka wrote:
>=20
> > > (There's also a specific issue with the gfp_mask limiting: I have
> > > not yet reviewed the allowing and denying in detail, but it looks
> > > like it does not respect the caller's GFP_ZONEMASK - the gfp in
> > > shmem_getpage_gfp() and shmem_read_mapping_page_gfp() is there to
> > > satisfy the gma500, which wanted to use shmem but could only
> manage
> > > DMA32.  I doubt it wants THPS, but shmem_enabled=3Dforce forces
> them.)
>=20
> Oh, I'd forgotten all about that gma500 aspect:
> well, I can send a fixup later on.

I already have code to fix that, which somebody earlier
in this discussion convinced me to throw away. Want me
to send it as a patch 4/3 ?

--=20
All Rights Reversed.

--=-OromBUoFm9ZFqotShFp+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmA2ZrUACgkQznnekoTE
3oOn2Qf+LFKPcOreR8SAWAxKLxMeHgT3ILPYIhzzG3Ds6UPNJhV16wmoGT5PObZ5
axV6t4vGE7//wE6Gbxwhm4UEEWBawJ/Tn6R+ltr0OsisLpRuCh0exnvclCKBTRmi
PoH2YJgehkumfd+NIfsCcCGJsy+c7w/oRrPBeY8Pu1uXM86ONaOmB0TbYwFUvjEH
P+MEJNZYrUGoy0Q2ZduUXV06zKa/MFNC02wFGIHDCOd521CwMizP8EuSqk+IFCdd
47AfUIl4JYIjQr0z32GhMtY/qnedRTTM9halSZi2qHiAxo74Z2NRRI/7SJSy3saU
gN9tCjNvMXYAxUZOmOpvp3V9QJDraw==
=bbq9
-----END PGP SIGNATURE-----

--=-OromBUoFm9ZFqotShFp+--

