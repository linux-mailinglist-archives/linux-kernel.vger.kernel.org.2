Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE4B363932
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbhDSBzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:55:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:59770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhDSBzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:55:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1C45ABC7;
        Mon, 19 Apr 2021 01:55:01 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 19 Apr 2021 11:54:54 +1000
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 11/12] docs: path-lookup: update get_link()
 ->follow_link description
In-Reply-To: <20210316054727.25655-12-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <20210316054727.25655-12-foxhlchen@gmail.com>
Message-ID: <87pmyr11jl.fsf@notabene.neil.brown.name>
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

> get_link() is merged into pick_link(). i_op->follow_link is
> replaced with i_op->get_link(). get_link() can return ERR_PTR(0)
> which equals NULL.
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index abd0153e2415..eef6e9f68fba 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -1134,10 +1134,10 @@ Symlinks with no final component
>=20=20
>  A pair of special-case symlinks deserve a little further explanation.
>  Both result in a new ``struct path`` (with mount and dentry) being set
> -up in the ``nameidata``, and result in ``get_link()`` returning ``NULL``.
> +up in the ``nameidata``, and result in ``pick_link()`` returning ``NULL`=
`.
>=20=20
>  The more obvious case is a symlink to "``/``".  All symlinks starting
> -with "``/``" are detected in ``get_link()`` which resets the ``nameidata=
``
> +with "``/``" are detected in ``pick_link()`` which resets the ``nameidat=
a``
>  to point to the effective filesystem root.  If the symlink only
>  contains "``/``" then there is nothing more to do, no components at all,
>  so ``NULL`` is returned to indicate that the symlink can be released and
> @@ -1154,12 +1154,11 @@ something that looks like a symlink.  It is reall=
y a reference to the
>  target file, not just the name of it.  When you ``readlink`` these
>  objects you get a name that might refer to the same file - unless it
>  has been unlinked or mounted over.  When ``walk_component()`` follows
> -one of these, the ``->follow_link()`` method in "procfs" doesn't return
> +one of these, the ``->get_link()`` method in "procfs" doesn't return
>  a string name, but instead calls ``nd_jump_link()`` which updates the
> -``nameidata`` in place to point to that target.  ``->follow_link()`` then
> -returns ``NULL``.  Again there is no final component and ``get_link()``
> -reports this by leaving the ``last_type`` field of ``nameidata`` as
> -``LAST_BIND``.
> +``nameidata`` in place to point to that target.  ``->get_link()`` then
> +returns ``0``.  Again there is no final component and ``pick_link()``

Why did you change NULL to 0?  ->get_link returns a pointer.

Without that change:
  Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


> +returns NULL.
>=20=20
>  Following the symlink in the final component
>  --------------------------------------------
> --=20
> 2.30.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmB84u4OHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigblHCA/+PoT2sALptZxtCi1d15m/VDPm1FhIuHLSla46
IM4UO8sAgZww+wy/1CnyQ03jBjDvCvd46JHMWUQ8M1qfoKKhMpAPkF/Cfnidm2Dt
RsvxfoEfjuu+nP2kCTltpihO0QsyVDOF5hvAMRnOufBH86ldwWndxILRD2SQU8+f
4mKUVmE5jQX3JoD6Vx2HLzHil/oZOAh3vk8ohv5uvScEaGqkLkvbUa7ufs7n0UHI
ICeA3Uoo6kT79hwhDI7ujVD4sBSX86IUGJEYafxyRM5VlHMGJ4/1/9i6lvThNPEP
OdI0kE40VFXmNCFQTmrbLFkucMz+zL9mHMVCjKZEVZPgkxSP2FRwTP7p5xFo31Tf
2GcJFOMGRf6H7phA6hyAJaynETHtWiBnd6TSFRQN1W4DKH0duPsbOvDX0rpe5uES
PEy2ykGr97KMayE8Bm38JHvBHZGLwA1FdRfDS+YPgoEQlxQzDyVd1Qm97J8XZt6q
qVSmnkFuQAiu/BTHde5erzWwMe0oewpWA3IYf8QBWW2a8aI0ZfK1zPZkglNa76nX
aBixEu1VWRORCjEaJeUcaXLtXDE50ed7Mrs0DRZ3IwJOj9DlCd21VKg4REOkdY7C
YxsLPXNUMGn0H5U7qgDNVkz19vOJ4UQO/iy2XXZxqBaF20lMu+Hl9o/+1DN3cc1y
KW3R6eA=
=2ZTZ
-----END PGP SIGNATURE-----
--=-=-=--
