Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E02A363939
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbhDSCA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:00:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:60466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhDSCA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:00:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1967B1B0;
        Mon, 19 Apr 2021 01:59:56 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 19 Apr 2021 11:59:50 +1000
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 12/12] docs: path-lookup: update symlink description
In-Reply-To: <20210316054727.25655-13-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <20210316054727.25655-13-foxhlchen@gmail.com>
Message-ID: <87mttv11bd.fsf@notabene.neil.brown.name>
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

> instead of lookup_real()/vfs_create(), i_op->lookup() and
> i_op->create() will be called directly.
>
> update vfs_open() logic
>
> should_follow_link is merged into lookup_last() or open_last_lookup()
> which returns symlink name instead of an integer.
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index eef6e9f68fba..adbc714740c2 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -1202,16 +1202,15 @@ the code.
>     it.  If the file was found in the dcache, then ``vfs_open()`` is used=
 for
>     this.  If not, then ``lookup_open()`` will either call ``atomic_open(=
)`` (if
>     the filesystem provides it) to combine the final lookup with the open=
, or
> -   will perform the separate ``lookup_real()`` and ``vfs_create()`` steps
> +   will perform the separate ``i_op->lookup()`` and ``i_op->create()`` s=
teps
>     directly.  In the later case the actual "open" of this newly found or
>     created file will be performed by ``vfs_open()``, just as if the name
>     were found in the dcache.
>=20=20
>  2. ``vfs_open()`` can fail with ``-EOPENSTALE`` if the cached information
> -   wasn't quite current enough.  Rather than restarting the lookup from
> -   the top with ``LOOKUP_REVAL`` set, ``lookup_open()`` is called instea=
d,
> -   giving the filesystem a chance to resolve small inconsistencies.
> -   If that doesn't work, only then is the lookup restarted from the top.
> +   wasn't quite current enough.  If it's in RCU-walk -ECHILD will be ret=
urned
> +   otherwise will return -ESTALE.  When -ESTALE is returned, the caller =
may

"otherwise -ESTALE is returned".
If you don't like repeating "is returned", then maybe:
  "... -ECHILD will be returned, otherwise the result is -ESTALE".


> +   retry with LOOKUP_REVAL flag set.
>=20=20
>  3. An open with O_CREAT **does** follow a symlink in the final component,
>     unlike other creation system calls (like ``mkdir``).  So the sequence=
::
> @@ -1221,8 +1220,8 @@ the code.
>=20=20
>     will create a file called ``/tmp/bar``.  This is not permitted if
>     ``O_EXCL`` is set but otherwise is handled for an O_CREAT open much
> -   like for a non-creating open: ``should_follow_link()`` returns ``1``,=
 and
> -   so does ``do_last()`` so that ``trailing_symlink()`` gets called and =
the
> +   like for a non-creating open: ``lookup_last()`` or ``open_last_lookup=
()``
> +   returns a non ``Null`` value, and ``link_path_walk()`` gets called an=
d the

"NULL", not "Null".

This those changes,
 Reviewed-by: NeilBrown <neilb@suse.de>

Thanks for a lot of all these improvements!! and apologies for the delay
in the review.

Thanks,
NeilBrown


>     open process continues on the symlink that was found.
>=20=20
>  Updating the access time
> --=20
> 2.30.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmB85BYOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmF4RAAlkzVqT7z2UCBzov4Z795P9vMHHj9iZomMRz+
OfPag//JdlNA08QVxxByeD7MetJLnL4AcSQGPUilRpvMzppXa29ryH8+mnPhHlCt
F4cU4LBVaTahefn8YlVcsqjBq4ZWEnKwy5dnVXX3TKSRCWCi2s6U8dXafwlOeRSw
D60vxABbjF8gFGDn4OSxctEgMrS46wKqhTw7OV2ctRNspm/Pq6KvT50+CkZAczSS
7ZrUQs3gx8vYDsJWri1o80x9ec5dr0fF44bKeKlhV+MlBwYwoK/mUt0T0BAdKNTt
BqVXzrg3k6zgHwGtfQuNVVCjOiDY04Khfr09Om929kfOAvmak+iqtGgyCBlIQbVx
1L5mh4NAN7n0aI9EJi+cN4BzF9cQb1oTU9buELVdfZxQz1e19irIPZ+xZuKzAO/1
2QUn74L+vbJ2iEZPoHyUCkp5iIubZ6BqZFeEN5M/eVsn1yl0mUKzSTx647RWSnTY
tTtCz3Iv1UzOk/h9olNiNwnumRHPan/B48QJp5aGVT/TirPhAb2WO5rmuAsT2jbM
zkMO7tn9rj2ksfZxlvbRHdDY+3r1ldNgbuYWtpuz18zyKO5ekh4j4RfZrc5rdj3n
v7RZpTqeoGQo5fRPbyqJ+23TaxBTQ9mHmijVjn2d/VycfeyxAApsNjDLU5QuQ9jW
xLGNd8Y=
=ExYE
-----END PGP SIGNATURE-----
--=-=-=--
