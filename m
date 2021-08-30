Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA5F3FB6EA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbhH3NZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 09:25:22 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45798 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhH3NZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 09:25:21 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1mKhGx-0008HT-Gs; Mon, 30 Aug 2021 09:24:23 -0400
Message-ID: <d77b816458f9df3839345f0ee0144b797ec176be.camel@surriel.com>
Subject: Re: [PATCH] mm,vmscan: fix divide by zero in get_scan_count
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        stable@kernel.org, Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Mon, 30 Aug 2021 09:24:22 -0400
In-Reply-To: <YSzB9q1kVjKce7ly@dhcp22.suse.cz>
References: <20210826220149.058089c6@imladris.surriel.com>
         <YSzB9q1kVjKce7ly@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/uvygdDFQnPrPTOwi7qF"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/uvygdDFQnPrPTOwi7qF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-08-30 at 13:33 +0200, Michal Hocko wrote:
> On Thu 26-08-21 22:01:49, Rik van Riel wrote:
> > Changeset f56ce412a59d ("mm: memcontrol: fix occasional OOMs due to
> > proportional memory.low reclaim") introduced a divide by zero
> > corner
> > case when oomd is being used in combination with cgroup memory.low
> > protection.
> >=20
> > When oomd decides to kill a cgroup, it will force the cgroup memory
> > to be reclaimed after killing the tasks, by writing to the
> > memory.max
> > file for that cgroup, forcing the remaining page cache and
> > reclaimable
> > slab to be reclaimed down to zero.
> >=20
> > Previously, on cgroups with some memory.low protection that would
> > result
> > in the memory being reclaimed down to the memory.low limit, or
> > likely not
> > at all, having the page cache reclaimed asynchronously later.
> >=20
> > With f56ce412a59d the oomd write to memory.max tries to reclaim all
> > the
> > way down to zero, which may race with another reclaimer, to the
> > point of
> > ending up with the divide by zero below.
> >=20
> > This patch implements the obvious fix.
>=20
> I must be missing something but how can cgroup_size be ever 0 when it
> is
> max(cgroup_size, protection) and protection !=3D 0?

Going into the condition we use if (low || min), where
it is possible for low > 0 && min =3D=3D 0.

Inside the conditional, we can end up testing against
min.

--=20
All Rights Reversed.

--=-/uvygdDFQnPrPTOwi7qF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmEs3AYACgkQznnekoTE
3oOYSQf7BU32gfB5rnz9drsdzvYBU1XZwNk1uMzS34QeiiioQ9jj6l79Q7qWOOSX
w9mThSCMrddEUO8t6HC1zQnp62OFMXx1wYfD7mSmNt3Kk4AL88Yjs9r+PbkwwCeA
2BXj92pvWmIrPjuLwbnfY56DrgBn4PfrrR2fGkWXUO3NT47zGD2K0MdWo9pKm0sl
vGOMQKBhWFpfvgETJodL4BThuI66RivSNtWUAK39Ys2EvOxqIo0xngEl3QC7zwik
9ouW9cwA6cmTU9Wt559qtkui+ZHFpMJSlME5oxRdLmlj1vF0BQrBxAyP36Cp78x3
ReJbFnl3CIQintU/JFemhC/9UX/GRQ==
=q6Bd
-----END PGP SIGNATURE-----

--=-/uvygdDFQnPrPTOwi7qF--

