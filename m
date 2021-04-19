Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0543638F8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhDSBEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:04:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:48378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhDSBE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:04:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7E2AFABD0;
        Mon, 19 Apr 2021 01:03:57 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 19 Apr 2021 11:03:51 +1000
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 03/12] docs: path-lookup: update path_mountpoint() part
In-Reply-To: <20210316054727.25655-4-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <20210316054727.25655-4-foxhlchen@gmail.com>
Message-ID: <87eef72ih4.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 16 2021, Fox Chen wrote:

> path_mountpoint() doesn't exist anymore. Have been folded
> into path_lookup_at when flag is set with LOOKUP_MOUNTPOINT.
> Check commit: commit 161aff1d93abf0e ("LOOKUP_MOUNTPOINT: fold
> path_mountpointat() into path_lookupat()")
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index a29d714431a3..b6a301b78121 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -472,7 +472,7 @@ Handling the final component
>  ``nd->last_type`` to refer to the final component of the path.  It does
>  not call ``walk_component()`` that last time.  Handling that final
>  component remains for the caller to sort out. Those callers are
> -``path_lookupat()``, ``path_parentat()``, ``path_mountpoint()`` and
> +``path_lookupat()``, ``path_parentat()`` and
>  ``path_openat()`` each of which handles the differing requirements of
>  different system calls.
>=20=20
> @@ -488,12 +488,10 @@ perform their operation.
>  object is wanted such as by ``stat()`` or ``chmod()``.  It essentially j=
ust
>  calls ``walk_component()`` on the final component through a call to
>  ``lookup_last()``.  ``path_lookupat()`` returns just the final dentry.
> -
> -``path_mountpoint()`` handles the special case of unmounting which must
> -not try to revalidate the mounted filesystem.  It effectively
> -contains, through a call to ``mountpoint_last()``, an alternate
> -implementation of ``lookup_slow()`` which skips that step.  This is
> -important when unmounting a filesystem that is inaccessible, such as
> +It is worth noting that when flag ``LOOKUP_MOUNTPOINT`` is set,
> +``path_lookupat()`` will unset LOOKUP_JUMPED in nameidata so that in the=
 further

I would say "subsequent" rather than "further".

Either way:
 Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


> +path traversal ``d_weak_revalidate()`` won't be called.
> +This is important when unmounting a filesystem that is inaccessible, suc=
h as
>  one provided by a dead NFS server.
>=20=20
>  Finally ``path_openat()`` is used for the ``open()`` system call; it
> --=20
> 2.30.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmB81vcOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbkiiw/7BTf52crr3ZQthQ+WuVTdElGsxY2ZjpR5AwbO
D6KmVqx3OMJuWiFwF15ND9d8PqHvib6gwJbSWCckGWrJJLjJ4m6PEpbpEhl16D7W
mn/YS/p8UzX5GClYslaPLK7UTGl34WZcGXBBnSRrP88MS+p5yeKWU5p+kMMk+b+D
ZfpbNiNpxrM02ZErgiPsZyb189IVWB4VviMP0RW8s2PF2h2xK9d64jlsa/03F+tQ
WCzrPJE6AiASA2oJjS29zvHLawOXrrt+dhdEJY8uNEFORclxmc8Y45BCexnig94D
at+Rj6jx19nIFuurzal504XssHj51qVJSoDi38EjjWG3/PQJ2ZTyTZx0kS8taOvW
N7fv0zVosSzmDkmERYljjZBnbSNlKWSjcTG2Xu8AGsFT8Q9G4hxRX+zwXrYnQgP/
gVkQ0GuRolK+bgNxkfTgTTeu66UWCCBa8rPwHi6lozItzpbDyk786CZBTi+kh41T
YbgTxXysCErrDTujqPtlQBp5PrTWe8HZ7HOTzsdrqiiA8MZU+4tvHZz+c9piwqi/
+YSZbI+CGxkEQbnt8TVkUpAz701+V3zUPp+Rn/agkr69h+ojLMRso594ZUe3k3wM
KQOaD5svAQDSDkO+X5K5NCFGXWdP3h1cnZfG42ILd4q0O5UfiO4zjZkS8pdKbtz8
UqJK8LQ=
=TmPT
-----END PGP SIGNATURE-----
--=-=-=--
