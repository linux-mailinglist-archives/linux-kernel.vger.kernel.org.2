Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5686B3FCB09
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 17:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbhHaPtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 11:49:32 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53146 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhHaPtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 11:49:31 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1mL5zw-0006Gd-R1; Tue, 31 Aug 2021 11:48:28 -0400
Message-ID: <a6ee1edfb13e1b666789f1857842c4ac025b1f40.camel@surriel.com>
Subject: Re: [PATCH] mm,vmscan: fix divide by zero in get_scan_count
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        stable@kernel.org, Chris Down <chris@chrisdown.name>
Date:   Tue, 31 Aug 2021 11:48:28 -0400
In-Reply-To: <YS39aci6yhjIplLx@dhcp22.suse.cz>
References: <20210826220149.058089c6@imladris.surriel.com>
         <YS1EA3U4XXH7X0qz@cmpxchg.org> <YS39aci6yhjIplLx@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-uZQ16ZnxuqAD9cMNKUrq"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uZQ16ZnxuqAD9cMNKUrq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-08-31 at 11:59 +0200, Michal Hocko wrote:
> On Mon 30-08-21 16:48:03, Johannes Weiner wrote:
>=20
>=20
> > Or go back to not taking the branch in the first place when there
> > is
> > no protection in effect...
> >=20
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 6247f6f4469a..9c200bb3ae51 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2547,7 +2547,7 @@ static void get_scan_count(struct lruvec
> > *lruvec, struct scan_control *sc,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0mem_cgroup_protection(sc->target_mem_cgroup, mem=
cg,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &min, &low);
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (min || low) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (min || (!sc->memcg_low_reclaim && low)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
/*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * Scale a cgroup's reclaim pressure by
> > proportioning
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * its current usage to its memory.low or
> > memory.min
>=20
> This is slightly more complex to read but it is also better than +1
> trick.

We could also fold it into the helper function, with
mem_cgroup_protection deciding whether to use low or
min for the protection limit, and then we key the rest
of our decisions off that.

Wait a minute, that's pretty much what mem_cgroup_protection
looked like before f56ce412a59d ("mm: memcontrol: fix occasional
OOMs due to proportional memory.low reclaim")

Now I'm confused how that changeset works.

Before f56ce412a59d, mem_cgroup_protection would return
memcg->memory.emin if sc->memcg_low_reclaim is true, and
memcg->memory.elow when not.

After f56ce412a59d, we still do the same thing. We just
also set sc->memcg_low_skipped so we know to come back
if we could not hit our target without skipping groups
with memory.low protection...

--=20
All Rights Reversed.

--=-uZQ16ZnxuqAD9cMNKUrq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmEuT0wACgkQznnekoTE
3oMNkQgArgplVGq77to07aWXH9+ApUXY21a0WY9aY5T9HxawsoLRnDaDSpQL5a3E
dRW0UsFytvNQytBDYersxAuxdnunMe06TvFC70MDP4yzW68WXDr+yzQ2X0RZU55U
DwwyWYr8cIfIo83eSbGnqFswdOC2ihtEmvIc4mK1r1XKXEGWvHuusrP0DyTPfe+M
u8QtjnWBS5XUTkpmtk1NYUay2kFiE557rx2+OwHp2uO04iE6c1xWQCkkUX29/LSn
yaMojBpoz5uM8/QNN1zqF/Zq+ta2NaFvyQiEoh2V/lKsRsbfDQ6j20oZaBpmDAxc
8ZJ2WOCkpJfKWH8e8wTx6dnSzD7iMg==
=BgbF
-----END PGP SIGNATURE-----

--=-uZQ16ZnxuqAD9cMNKUrq--

