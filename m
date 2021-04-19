Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4743F363920
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhDSBh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:37:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:56682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232133AbhDSBh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:37:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50ADFAC87;
        Mon, 19 Apr 2021 01:37:27 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:21 +1000
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 08/12] docs: path-lookup: update i_op->put_link and
 cookie description
In-Reply-To: <20210316054727.25655-9-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <20210316054727.25655-9-foxhlchen@gmail.com>
Message-ID: <87y2df12cu.fsf@notabene.neil.brown.name>
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

> No inode->put_link operation anymore. We use delayed_call to
> deal with link destruction. Cookie has been replaced with
> struct delayed_call.
>
> Related commit: commit fceef393a538 ("switch ->get_link() to
> delayed_call, kill ->put_link()")
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 30 ++++++-----------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index e6b6c43ff0f6..8ab95dd9046e 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -1066,34 +1066,20 @@ method. This is called both in RCU-walk and REF-w=
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
> +holding no counted reference, only the RCU lock. A callback
> +``struct delayed_called`` will be passed to get_link,

I'd put a ":", not "," at the end of above line.

> +file systems can set their own put_link function and argument through
> +``set_delayed_call``. Later on, when vfs wants to put link, it will call

() after function names please, both above and below.

Also:  "when VFS want to put the link"

With these changes:
 Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
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
> 2.30.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmB83tEOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbk79Q//d8vMY2hgQWHNxdc6tN/sWYseNntWofsHCAqo
hOSC+X7VQZmttU7OwtR3/xE0L4mS4RA6aE+ji5p+94wLev2REow5s2NjKzdc8/Is
btLgFg4W3hX2HqmIXAYmV2AEhnlFfBJgy90W54sN1X3+xRtq0vKINHVGmNsPmjHE
otPXrwI7Nwq9bXIceThFl7oPNYzsmy8IA9gnQPFSKFAPJ95gSzqyTbfDA/rdqMG1
wYEsc0akHPgaUZxtB7fuweTqFW4z2QV+pC8+yBtwsNScSgZDNgviUmUbmYrNn5Np
jC7K0hZijkzd4CTb6BvK8LVuq6XDJPu3RngBcdLvSlpunEbtHXSgYktIlIlIKrNb
7ywcKbidmDtMw4p89TjRIPs/EZDAavRqU/Nj9JVkuJj9A3nzuCZ8MUAFfmdP71aa
pcftycbZGWoO148UkwqrgXK8yMQnLcV+hWs9Quf1w7+DReIdzEBp54nKYKmocg3Z
jAwWqqVcMNtw8Mt4IF1Y8RJykZYSkwo+MrcmQGi/F7FuoLWuhcPDzT+k2CQhqzZW
5MLHJZ3QZehp72xGB9iJEQs5Ow5LAK1Ty6popqPbM0TTZB9rkxK94PuleqTrJbzW
wFzzsYvyX52eMmhNeAryi6FVbMGNtREAPmxbt9LQdDSbtdg1ghxbIoS88tS7pMly
4jYolRo=
=7t34
-----END PGP SIGNATURE-----
--=-=-=--
