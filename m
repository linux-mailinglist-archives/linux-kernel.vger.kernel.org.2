Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CDB3638F2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbhDSBAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:00:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:47304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhDSBAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:00:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2FA04B1B0;
        Mon, 19 Apr 2021 01:00:07 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 19 Apr 2021 11:00:00 +1000
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 02/12] docs: path-lookup: update path_to_nameidata()
 part
In-Reply-To: <20210316054727.25655-3-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <20210316054727.25655-3-foxhlchen@gmail.com>
Message-ID: <87h7k32inj.fsf@notabene.neil.brown.name>
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

> No path_to_namei() anymore, step_into() will be called.
> Related commit: commit c99687a03a78 ("fold path_to_nameidata()
> into its only remaining caller")
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index d07766375e13..a29d714431a3 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -455,9 +455,10 @@ directly from walk_component() or from handle_dots()=
.  It calls
>  ``handle_mount()``, to check and handle mount points, in which a new
>  ``struct path`` containing a counted reference to the new dentry and a
>  reference to the new ``vfsmount`` which is only counted if it is
> -different from the previous ``vfsmount``.  It then calls
> -``path_to_nameidata()`` to install the new ``struct path`` in the
> -``struct nameidata`` and drop the unneeded references.
> +different from the previous ``vfsmount`` will be created. Then if there =
is

That "will be created" messes up the sentence.
It would probably work to put it earlier:

  It calls handle_mounts() to check and handle mount points, in which a
  new struct path is created containing a counted reference to the new
  dentry and a reference to the new vfsmount, which is only counted if
  it is different from the previous vfsmount.

(I'm not sure about the comma I put in before the 'which' - Jon often
removes my commas, and sometimes changes 'which' to 'that'...)

> +symbolic link, ``step_into()`` calls ``pick_link()`` to deal with it, ot=
herwise

"a symbolic link"

> +installs the new ``struct path`` in the ``struct nameidata`` and drop the

"it installs".  Any maybe "into the".  And "drops".

> +unneeded references.

So sentence is:
   Then if there is a symbolic link, step_into() calls pick_link() to
   deal with it, otherwise it installs the new struct path into the
   struct nameidata, and drops the unneeded references.

With those changes,
  Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown

>=20=20
>  This "hand-over-hand" sequencing of getting a reference to the new
>  dentry before dropping the reference to the previous dentry may
> --=20
> 2.30.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmB81hAOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbkScA//bSElIBXx+FPN53HuP+xDhtbove5wSI5yZ2Do
8J2M/F5qX8Tt1vZDozwpqB9gay3ufCl6U1P56vmG4ueyMCt7fzkRMVo406kUAq8+
xzuL9IuLNJgE5x4hXfHea3bYkYIcOe8Iz4DaNycYTBpYFkaYf8gqznfrHfsz61qx
bF43jDCuIKbNZalbZFwCIzc+xKLc5gA/GbABgsk/X9n1SyKkE7MMYL2FUzaLkb49
odjSzD+efXpu4oHD0nNdjolZvs0vNSV8CYqa2b3b4NAi04U7eTY8URRluRwW2j8M
zOZ9JlyaO5n989Qyy+cTUNXInf6Z4dz0PjCpJM+SdygSUDaq0DtB5g72eIeRW/Ss
2PrXvuV5MvuD4khR82QcU2HKfW8VncLbtLF45NqaKqH0EBQLDR5iUp5LXglggjZh
Z3aUTe2zz5/pzWQ3wUp0XFiW62JuTvvdvajI+lsh3j3xYI5iYHDE77IQxJP4nLwa
oP0nBJV53VifvrHhstZQhq7adTxbTYuYjEruRo30v7QqR3a54bZdsgpaFFQoGmni
hsEDh6C6n2lO2ZOk926jsUB6/us0y24DtkdF3Y7iUl1OKmIG2hqwSAc1nWiQDios
GWPdtYx3tb9kS/5lqQAHsIugYEyU1eoEvx1rU2u88uryTX9XDV5BieCsSgFiNthK
Z2a+qzI=
=Lsyj
-----END PGP SIGNATURE-----
--=-=-=--
