Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3322A36392E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbhDSBsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:48:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:58452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhDSBsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:48:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED7E8AEFF;
        Mon, 19 Apr 2021 01:47:40 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 19 Apr 2021 11:47:34 +1000
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 10/12] docs: path-lookup: update WALK_GET, WALK_PUT desc
In-Reply-To: <20210316054727.25655-11-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <20210316054727.25655-11-foxhlchen@gmail.com>
Message-ID: <87sg3n11vt.fsf@notabene.neil.brown.name>
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

> WALK_GET is changed to WALK_TRAILING with a different meaning.
> Here it should be WALK_NOFOLLOW. WALK_PUT dosn't exist, we have
> WALK_MORE.
>
> WALK_PUT =3D=3D !WALK_MORE
>
> And there is not should_follow_link().
>
> Related commits:
> commit 8c4efe22e7c4 ("namei: invert the meaning of WALK_FOLLOW")
> commit 1c4ff1a87e46 ("namei: invert WALK_PUT logics")
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index 0d41c61f7e4f..abd0153e2415 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -1123,13 +1123,11 @@ stack in ``walk_component()`` immediately when th=
e symlink is found;
>  old symlink as it walks that last component.  So it is quite
>  convenient for ``walk_component()`` to release the old symlink and pop
>  the references just before pushing the reference information for the
> -new symlink.  It is guided in this by two flags; ``WALK_GET``, which
> -gives it permission to follow a symlink if it finds one, and
> -``WALK_PUT``, which tells it to release the current symlink after it has=
 been
> -followed.  ``WALK_PUT`` is tested first, leading to a call to
> -``put_link()``.  ``WALK_GET`` is tested subsequently (by
> -``should_follow_link()``) leading to a call to ``pick_link()`` which sets
> -up the stack frame.
> +new symlink.  It is guided in this by two flags; ``WALK_NOFOLLOW``, which

There are 3 flags now.  You haven't documented WALK_TRAIlING.


> +suggests whether to follow a symlink if it finds one, and

I don't think it is a suggestion.

.. which forbits it from following a symlink if it finds one, and
WALK_MORE which indicates that it is yet too early to release the
current symlink.

> +``WALK_MORE``, which tells whether to release the current symlink after =
it has
> +been followed.  ``WALK_MORE`` is tested first, leading to a call to
> +``put_link()``.

I don't think that "tested first" sentence is relevant any more.

Thanks,
NeilBrown

>=20=20
>  Symlinks with no final component
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --=20
> 2.30.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmB84TYOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigblJwg//XFPq5YDJo4/GIPlHyRw7y6SO7XK2UjDJNeYG
VE5dYZvQgwJw5p1G/GYvMDwCAv7wVpayYfyfC0pImwhz30MUzdmjG9obioi3L03g
aCqlxCKG/4Q7Vnh02r/8ehc4uC+eGPlM2nZA/CbxVQWE0hLML6J6Qu/F4kyczxP/
9fTuBGDtMl4rrqjdnc+erUCwEw9syFY039MCBshkc2rla/7UpevLiyHNcVnaz/tr
RnuaauFCm6asyPjf8a3iOSmkk96byMHDTFlxZSeNsBpzUHLVducZYng01kG5q0zG
f4snDhqb2TZzYWO11ykPIZbBDD+HW/6ZfgJSKFiMDO23v5RysZ3v0JNV46gU84Wm
m+7TnvSTMg3OyOXmswHWJauwbC3LxySF+/ay78iah41PfKk3XQIAAJBafJyJPziV
VVJKxK4EdIUmbG4BmQFEar7aP20iYhvd1UVY845/km/bJrQkjTx/JllqeAATur/p
xpzc4ZcX/DgK+Wv6eZN/GNjiPyvei//wgmasuHdKC01tH0TZS0lAdQdCOFe+MdhP
7AVGsNT6EuSWNVDE4c9BawJvqMf3CETsUtKM9T3We2UtoQYRlaLiywziI84hpQmE
tJzA20U5cHwGUdYWfF8fLKOpBoAaZaqcldI+u+Ge5XUSJpP801m3BDAlabVIqRKo
upOEzWw=
=B3Jb
-----END PGP SIGNATURE-----
--=-=-=--
