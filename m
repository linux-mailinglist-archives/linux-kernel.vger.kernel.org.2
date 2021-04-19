Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B62363906
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbhDSBRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:17:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:51710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhDSBRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:17:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18E11AC87;
        Mon, 19 Apr 2021 01:17:17 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 19 Apr 2021 11:17:10 +1000
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 04/12] docs: path-lookup: update do_last() part
In-Reply-To: <20210316054727.25655-5-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <20210316054727.25655-5-foxhlchen@gmail.com>
Message-ID: <87blab2hux.fsf@notabene.neil.brown.name>
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

> traling_symlink() was merged into lookup_last, do_last().
>
> do_last() has later been split into open_last_lookups()
> and do_open().
>
> see related commit: commit c5971b8c6354 ("take post-lookup
> part of do_last() out of loop")
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 35 ++++++++++++-----------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index b6a301b78121..a65cb477d524 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -495,11 +495,11 @@ This is important when unmounting a filesystem that=
 is inaccessible, such as
>  one provided by a dead NFS server.
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
> @@ -1199,26 +1199,27 @@ symlink.
>  This case is handled by the relevant caller of ``link_path_walk()``, suc=
h as
>  ``path_lookupat()`` using a loop that calls ``link_path_walk()``, and th=
en
>  handles the final component.  If the final component is a symlink
> -that needs to be followed, then ``trailing_symlink()`` is called to set
> -things up properly and the loop repeats, calling ``link_path_walk()``
> -again.  This could loop as many as 40 times if the last component of
> -each symlink is another symlink.
> +that needs to be followed, then ``open_last_lookups()`` is
> +called to set things up properly and the loop repeats, calling
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

This para no longer makes sense.
There is only one function that examines the final compoenent:
step_into()
It is called from open_last_lookups() directly and indirectly from
lookup_last() through walk_component().
But saying that here might be duplicating earlier text.

I think the key point in the para is that convention of returning a
'char *name' if a symlink was found.  The rest might now be redundant.

I think this needs a larger revision.

Thanks,
NeilBrown


>=20=20
> -Of these, ``do_last()`` is the most interesting as it is used for
> -opening a file.  Part of ``do_last()`` runs with ``i_rwsem`` held and th=
is
> -part is in a separate function: ``lookup_open()``.
> +Of these, ``open_last_lookups()`` is the most interesting as it works in=
 tandem
> +with ``do_open()`` for opening a file.  Part of ``open_last_lookups()`` =
runs
> +with ``i_rwsem`` held and this part is in a separate function: ``lookup_=
open()``.
>=20=20
> -Explaining ``do_last()`` completely is beyond the scope of this article,
> -but a few highlights should help those interested in exploring the
> -code.
> +Explaining ``open_last_lookups()`` and ``do_open()`` completely is beyon=
d the scope
> +of this article, but a few highlights should help those interested in ex=
ploring
> +the code.
>=20=20
> -1. Rather than just finding the target file, ``do_last()`` needs to open
> +1. Rather than just finding the target file, ``do_open()`` is used after
> +   ``open_last_lookup()`` to open
>     it.  If the file was found in the dcache, then ``vfs_open()`` is used=
 for
>     this.  If not, then ``lookup_open()`` will either call ``atomic_open(=
)`` (if
>     the filesystem provides it) to combine the final lookup with the open=
, or
> --=20
> 2.30.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmB82hYOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbnefQ//YpFTysJ/eH0mWTEZaewsQUR/EfipMA2dQkcM
//kemQdc2T+gVthX02J6nnXedSOH6A2ARFb3AKyQsLsQf9RR8ABPkQfaxkYkwvG3
Igp2nCFRbjyvKc9oRwZduxb90GvZ57TBZfFP4dRoWPGGEtI/naFe0wjERqBqPOM6
t/Ei17nuZnHfNcOohHv9d+Xc+UvumIsvmIlEDVv7qzbslCA6YClauwixsdMAibt/
UoFtpmANxdqlA08WuxRQN5kc65uqnPL6qVMfOcc8OqKkQuy1l1MmAh0GwbnAKJm/
XEeRl9lf+W2nP5PtZpD1KPOgLUvB6aBF2f3j/KFUD+ey5MOkQzJhbJrUGuMu+ofn
Ph2d1GLa6LD5LReHgsda0HjWZdcetUa/xyFo7xXegSQZyEKopRM30qVF8g+VHbSV
0Arp0oO5cjrAG8BXbfmrDFj799DNEqP2cNivP7KMp9hdYmBBEHU5pWCpzlzqGHQs
6xcUX0ghZHfzsNX8E2QYENnFIBvVFnlb2DNWkwTEKFnbpbCT9RYQIErWQ02jyTDS
UPGSdQagJS7VFQb/aOEFU1szDxJiBuEibpBD3sgRyeQo1fCpiJGuzU4GP5R1XX3G
EBgrFVFhBNckKC+l1s8WgU9dIFgdlpGBu7t2qaWzSV0+EhuhqaQ2RMuE0ozmM0Xr
5Qc2BBg=
=RAyQ
-----END PGP SIGNATURE-----
--=-=-=--
