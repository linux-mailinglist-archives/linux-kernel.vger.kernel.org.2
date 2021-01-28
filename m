Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBC8306BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 05:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhA1EFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 23:05:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:53910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231260AbhA1EEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 23:04:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1EC0DAD29;
        Thu, 28 Jan 2021 03:50:11 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Date:   Thu, 28 Jan 2021 14:50:04 +1100
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] docs: path-lookup: update i_op->put_link and
 cookie description
In-Reply-To: <20210126072443.33066-9-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
 <20210126072443.33066-9-foxhlchen@gmail.com>
Message-ID: <877dnxhg9f.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 26 2021, Fox Chen wrote:

> No inode->put_link operation anymore. We use delayed_call to
> deal with link destruction. Cookie has been replaced with
> struct delayed_call.
>
> Related commit: fceef393a538134f03b778c5d2519e670269342f
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 31 +++++++----------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index 0a362849b26f..8572300b5405 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -1068,34 +1068,21 @@ method. This is called both in RCU-walk and REF-w=
alk. In RCU-walk the
>  RCU-walk.  Much like the ``i_op->permission()`` method we
>  looked at previously, ``->get_link()`` would need to be careful that
>  all the data structures it references are safe to be accessed while
> -holding no counted reference, only the RCU lock.  Though getting a
> -reference with ``->follow_link()`` is not yet done in RCU-walk mode, the
> -code is ready to release the reference when that does happen.
> -
> -This need to drop the reference to a symlink adds significant
> -complexity.  It requires a reference to the inode so that the
> -``i_op->put_link()`` inode operation can be called.  In REF-walk, that
> -reference is kept implicitly through a reference to the dentry, so
> -keeping the ``struct path`` of the symlink is easiest.  For RCU-walk,
> -the pointer to the inode is kept separately.  To allow switching from
> -RCU-walk back to REF-walk in the middle of processing nested symlinks
> -we also need the seq number for the dentry so we can confirm that
> -switching back was safe.
> -
> -Finally, when providing a reference to a symlink, the filesystem also
> -provides an opaque "cookie" that must be passed to ``->put_link()`` so t=
hat it
> -knows what to free.  This might be the allocated memory area, or a
> -pointer to the ``struct page`` in the page cache, or something else
> -completely.  Only the filesystem knows what it is.
> +holding no counted reference, only the RCU lock.
> +
> +Finally, a callback ``struct delayed_called`` will be passed to get_link,
> +file systems can set their own put_link function and argument through
> +``set_delayed_call``. Latter on, when vfs wants to put link, it will cal=
l=20

"Later", not "Latter".

Also, I'm not sure that the "Finally" at the start of the sentence makes
sense any more.  I think it was meant to introduce the final part of the
"significant complexity", but now that significant complexity is gone.
At least, I assume it is gone.  I haven't checked to code to see if
maybe it has just been moved.

NeilBrown


> +``do_delayed_call`` to invoke that callback function with the argument.
>=20=20
>  In order for the reference to each symlink to be dropped when the walk c=
ompletes,
>  whether in RCU-walk or REF-walk, the symlink stack needs to contain,
>  along with the path remnants:
>=20=20
> -- the ``struct path`` to provide a reference to the inode in REF-walk
> -- the ``struct inode *`` to provide a reference to the inode in RCU-walk
> +- the ``struct path`` to provide a reference to the previous path
> +- the ``const char *`` to provide a reference to the to previous name
>  - the ``seq`` to allow the path to be safely switched from RCU-walk to R=
EF-walk
> -- the ``cookie`` that tells ``->put_path()`` what to put.
> +- the ``struct delayed_call`` for later invocation.
>=20=20
>  This means that each entry in the symlink stack needs to hold five
>  pointers and an integer instead of just one pointer (the path
> --=20
> 2.30.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmASNGwOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbkL7Q//dZ5/EjCGIQRKw9uOxDHaZSeO71MNyeNXdnX+
+HRaX/RyFy/BZF7Jv2rt49ulE6ZLpYeVXdJDciz9WKLKb7cJCDkG11GF6dxHOow5
zQ97/XibWZZhNKJ0gtaYtun9bVMcdqQcRql9zLO1tis4TQMngdVJzMudWPDWndBc
xfnykePCpqai/t+4HKkth5GYFfo3q0C0FsEv6DMm6rSl5lu/98PhEKEf+Ly9HVT6
d8wkido6DVLSKW3uV5TpSSQ8RaapK+IWRS6AWizd7d1RtDYleLbJ1CSc1CondpZv
qf7W7w1DEY9l2bZ0FrRfxoLra1wGiSyxXgncsAKRlkLte/KWniaZLWu6jidjbeaD
zRAmFnR6ZHFNfQ6OySN6X7ag07kApiSyw+3rEBr0mF9h7E5cGbTHn0a2vjLHERsy
OwqProHcaydHlvW6Yp9eafeARfpZgGpAU1LQXSNfWibsPKpOCDOUwcpUbkzJy8a+
VL3uWsgnAPp+w3bsNu/El7x5XeDJ2EkkgzgKvBtjO5tGCFyy7e6Ni/D30sZeoUEd
as2pbItAaZcTPutiQWB0HceajzPYoUEnoJubqsRqYJLnlSChAvLxpz8VGF9G0BRj
6LyDDzCuw+Uj2G/0GKjdzgQ5MMnAywjEFUzk7WiTsn3k9SC+HhMRPg9CIMPdNXz0
wf0GXmA=
=HReH
-----END PGP SIGNATURE-----
--=-=-=--
