Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F518306BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 05:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhA1EF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 23:05:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:53908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231259AbhA1EEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 23:04:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A82D6AF82;
        Thu, 28 Jan 2021 03:50:36 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Date:   Thu, 28 Jan 2021 14:50:30 +1100
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] docs: path-lookup: update do_last() part
In-Reply-To: <20210126072443.33066-5-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
 <20210126072443.33066-5-foxhlchen@gmail.com>
Message-ID: <875z3hhg8p.fsf@notabene.neil.brown.name>
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

> traling_symlink() was merged into lookup_last, do_last().
>
> do_last() has later been split into open_last_lookups()
> and do_open().
>
> see related commit: c5971b8c6354a95c9ee7eb722928af5000bac247
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 34 +++++++++++------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index 4e77c8520fa9..1f05b1417a55 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -496,11 +496,11 @@ one provided by a dead NFS server.  In the current =
kernel, path_mountpoint
>  has been merged into ``path_lookup_at()`` with a new flag LOOKUP_MOUNTPO=
INT.
>=20=20
>  Finally ``path_openat()`` is used for the ``open()`` system call; it
> -contains, in support functions starting with "``do_last()``", all the
> +contains, in support functions starting with "``open_last_lookups()``", =
all the
>  complexity needed to handle the different subtleties of O_CREAT (with
>  or without O_EXCL), final "``/``" characters, and trailing symbolic
>  links.  We will revisit this in the final part of this series, which
> -focuses on those symbolic links.  "``do_last()``" will sometimes, but
> +focuses on those symbolic links.  "``open_last_lookups()``" will sometim=
es, but
>  not always, take ``i_rwsem``, depending on what it finds.
>=20=20
>  Each of these, or the functions which call them, need to be alert to
> @@ -1201,26 +1201,26 @@ symlink.
>  This case is handled by the relevant caller of ``link_path_walk()``, suc=
h as
>  ``path_lookupat()`` using a loop that calls ``link_path_walk()``, and th=
en
>  handles the final component.  If the final component is a symlink
> -that needs to be followed, then ``trailing_symlink()`` is called to set
> -things up properly and the loop repeats, calling ``link_path_walk()``
> -again.  This could loop as many as 40 times if the last component of
> -each symlink is another symlink.
> +that needs to be followed, then ``open_last_lookups()`` and ``do_open()`=
` is
> +called to set things up properly and the loop repeats, calling

This implies that do_open() is inside the loop (in path_openat()).  But
it isn't, it comes after the loop.

(I haven't closely examined this rest of this patch).

NeilBrown


> +``link_path_walk()`` again.  This could loop as many as 40 times if the =
last
> +component of each symlink is another symlink.
>=20=20
>  The various functions that examine the final component and possibly
> -report that it is a symlink are ``lookup_last()``, ``mountpoint_last()``
> -and ``do_last()``, each of which use the same convention as
> -``walk_component()`` of returning ``1`` if a symlink was found that needs
> -to be followed.
> +report that it is a symlink are ``lookup_last()``, ``open_last_lookups()=
``
> +, each of which use the same convention as
> +``walk_component()`` of returning ``char *name`` if a symlink was found =
that
> +needs to be followed.
>=20=20
> -Of these, ``do_last()`` is the most interesting as it is used for
> -opening a file.  Part of ``do_last()`` runs with ``i_rwsem`` held and th=
is
> -part is in a separate function: ``lookup_open()``.
> +Of these, ``open_last_lookups()``, ``do_open()`` is the most interesting=
 as it is
> +used for opening a file.  Part of ``open_last_lookups()`` runs with ``i_=
rwsem``
> +held and this part is in a separate function: ``lookup_open()``.
>=20=20
> -Explaining ``do_last()`` completely is beyond the scope of this article,
> -but a few highlights should help those interested in exploring the
> -code.
> +Explaining ``open_last_lookups()``, ``do_open()`` completely is beyond t=
he scope
> +of this article, but a few highlights should help those interested in ex=
ploring
> +the code.
>=20=20
> -1. Rather than just finding the target file, ``do_last()`` needs to open
> +1. Rather than just finding the target file, ``do_open()`` needs to open
>     it.  If the file was found in the dcache, then ``vfs_open()`` is used=
 for
>     this.  If not, then ``lookup_open()`` will either call ``atomic_open(=
)`` (if
>     the filesystem provides it) to combine the final lookup with the open=
, or
> --=20
> 2.30.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmASNIYOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmddRAAw28JyGI4YjJoVUS0B5R4frhT+rE/efN8zDgU
Yi2pcckfdt/uTZDSNPkXiOnhTZwfvHgAUblhBkAvxnkdhdE7NeaQmFtwBu7mMU2I
l60+UR/mH/5KKoxUiYLcEf6mOi8DyGD5tibGst8Xm322iJbg1+yPMzW6KwRekLfv
WXLIr4xoIAMwNdTzynzXnJjhrc4yLE9LL8lwj0wr8JturTvvOKcNk44mDZS6vIr0
aXU+J9xLDLOX5S8Fh/Oc8IYr1z99MDCOpZ1Bc06g+6iW0izLIL+DxhIV21Oje0ts
+pS1pxchzIB4gQa8CilEQ+Rzach/8YXOnfSJUmXLTHz/m8SxTPIBprgd2fp/3nEK
/rwuElDSPFuziySkVMqJ4cnrCe8fiZNSU8qMdwk2RyiI4BkaD0BCU3wibv0vOF9f
k2uHHqyH+c1fXTjwCCBuKdjAIOL+6v25uShoVze5gk7Amr0XXXZTHUnZXVq1x0Ve
C7wBekOWzYq5E8LE0Vo2FIz9phKlkFGhe5owcNPe8ZAYQVIkIJiOWGotaGw7tNR/
QV/Jmni+FzLuI+ZWjShTwiFwGFBhCSYrfKpMPSYBDB6vONQtAIhFUSlmdYFApVbS
eYUWaIEhQMBrwWJYkGuaWjdyti6XrhkJvkIldmEQ1xXejrfNNabZ+Mif3VMj7oL0
5FQX7zo=
=CAWi
-----END PGP SIGNATURE-----
--=-=-=--
