Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E4A3638E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 02:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbhDSAwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 20:52:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:45192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhDSAwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 20:52:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B572B1AE;
        Mon, 19 Apr 2021 00:52:09 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:01 +1000
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 01/12] docs: path-lookup: update follow_managed() part
In-Reply-To: <20210316054727.25655-2-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <20210316054727.25655-2-foxhlchen@gmail.com>
Message-ID: <87k0oz2j0u.fsf@notabene.neil.brown.name>
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

> No follow_managed() anymore, handle_mounts(),
> traverse_mounts(), will do the job.
> see commit 9deed3ebca24 ("new helper: traverse_mounts()")
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index c482e1619e77..d07766375e13 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -448,10 +448,11 @@ described.  If it finds a ``LAST_NORM`` component i=
t first calls
>  filesystem to revalidate the result if it is that sort of filesystem.
>  If that doesn't get a good result, it calls "``lookup_slow()``" which
>  takes ``i_rwsem``, rechecks the cache, and then asks the filesystem
> -to find a definitive answer.  Each of these will call
> -``follow_managed()`` (as described below) to handle any mount points.
> +to find a definitive answer.
>=20=20
> -In the absence of symbolic links, ``walk_component()`` creates a new
> +As the last step of ``walk_component()``, ``step_into()`` will be called=
 either
> +directly from walk_component() or from handle_dots().  It calls
> +``handle_mount()``, to check and handle mount points, in which a new

Typo - it is "handle_mounts", not "handle_mount"

With that fixed:
  Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


>  ``struct path`` containing a counted reference to the new dentry and a
>  reference to the new ``vfsmount`` which is only counted if it is
>  different from the previous ``vfsmount``.  It then calls
> @@ -535,8 +536,7 @@ covered in greater detail in autofs.txt in the Linux =
documentation
>  tree, but a few notes specifically related to path lookup are in order
>  here.
>=20=20
> -The Linux VFS has a concept of "managed" dentries which is reflected
> -in function names such as "``follow_managed()``".  There are three
> +The Linux VFS has a concept of "managed" dentries.  There are three
>  potentially interesting things about these dentries corresponding
>  to three different flags that might be set in ``dentry->d_flags``:
>=20=20
> --=20
> 2.30.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmB81DIOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbnF1hAAlBHIQl8+cJrqICzkhK5VOsom1BWwH2DvJE/i
tlqn76S2rCYAQgqzE3T7bPfCFrDPlEM0ztcx5XMYHdguU5e+pemWxJRhWfz+aJE6
kvxJcJjE/uGW+FlHY3hjVEahjrGFhhGiKQy/3NroSyedaa9LzAN8svJu45YxznxS
WABNCvYMKx/CPrnTrMcxTTT4bZeYYHYV/wksyib4YTYziNs65LARBvstRREKtDAU
58S1RA4AZbX1TwdxOILZZf/LoppMZ4ce3lb46dm/KWgtLLT3T6cr+vbeTDJy7e5T
ErthbtnJiR5//OCKOwYE67EDu/8t28e4z8gcuO6+NsqT/VY1ylXUxf0M4maUwfG0
RLZ0hgLOWXiwUPLs8icSL+MNYKHFQXlyBbPoGhzJSlQRcPABtrfrStbk2wPVHHFT
wfrcQmNLwWpnfftM94ZFmjmmh5DkleCvOljCsjTcDJNp49axas677lsmcRc8uF0N
j/vXYUvvS4zouRjRpr8Wzd3deH0sGi/r4ADtP50LxogTtYnvtiet/wMYCHhooFNi
DlYatkDmKu21rucTWa2iigKGcdgPUE6B1qT4YAGsS+wtP9dhZPAO+9cup3u7L7fP
osd7ohkVHAa6hNksD4ptc2xQPVqHmAWbiStBUCWkIg74XFVQK40YgqYlt4Dy8uHc
VHMOCww=
=btDA
-----END PGP SIGNATURE-----
--=-=-=--
