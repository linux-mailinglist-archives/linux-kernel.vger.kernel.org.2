Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A714363923
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhDSBlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:41:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:56946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhDSBlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:41:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 812E8AC87;
        Mon, 19 Apr 2021 01:41:06 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 19 Apr 2021 11:41:00 +1000
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 09/12] docs: path-lookup: no get_link()
In-Reply-To: <20210316054727.25655-10-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <20210316054727.25655-10-foxhlchen@gmail.com>
Message-ID: <87v98j126r.fsf@notabene.neil.brown.name>
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

> no get_link() anymore. we have step_into() and pick_link().
>
> walk_component() will call step_into(), in turn call pick_link,
> and return symlink name.
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index 8ab95dd9046e..0d41c61f7e4f 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -1103,12 +1103,10 @@ doesn't need to notice.  Getting this ``name`` va=
riable on and off the
>  stack is very straightforward; pushing and popping the references is
>  a little more complex.
>=20=20
> -When a symlink is found, ``walk_component()`` returns the value ``1``
> -(``0`` is returned for any other sort of success, and a negative number
> -is, as usual, an error indicator).  This causes ``get_link()`` to be
> -called; it then gets the link from the filesystem.  Providing that
> -operation is successful, the old path ``name`` is placed on the stack,
> -and the new value is used as the ``name`` for a while.  When the end of
> +When a symlink is found, ``walk_component()`` calls ``pick_link()``,

walk_component() calls pick_link() via step_into()
??

> +it then gets the link from the filesystem returning new path ``name``.

"which returns the link from the filesystem."

With those changes (assuming you agree with them)

 Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


> +Providing that operation is successful, the old path ``name`` is placed =
on the
> +stack, and the new value is used as the ``name`` for a while.  When the =
end of
>  the path is found (i.e. ``*name`` is ``'\0'``) the old ``name`` is resto=
red
>  off the stack and path walking continues.
>=20=20
> --=20
> 2.30.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmB836wOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbkhlQ/+KEDT1Qg5sJP/HbvSh+uqKcRG74YFfZp64srx
RGr3aAOIGIxL860sROvxmUl7QvYjNVnYBN6w4tEGIU4WEr7rpRAHGup3OQ11sH6D
8PolYl8ZtdrOFz9x1KDH09xFHdBYlufOgWY8/7Mh+0v/Kw+yKDmwavXGxyUkmOmD
nEQBAdfyYHeqKcm6eG0A2J2T+NYoSwcONBXycWk2+1qDSlr1A3iC+fTYPpH/lpWZ
9zb/d5kMvBFozSXSsCnUEgNX3rxpEiISaLgpDv41e4/k/pk08weFR54i/F7aE6JJ
JsAiLTjFPcsw9v2Zov0YUJIsH8yJAatZXvM5mxXI0gKas/FIIRyrxqYmBjdpzGKI
8XadNQfeHwh+GmMqCuyRphd6hDsbYHgZbb+rEtIAslvn4cXGFHzOQt6tuosl52Nz
UhVe64R1TQFU+nkqLK45W0eNTGn3Bd/SVHN4srmzOxb/RxAjM8UR78WFglI2AsbX
YpkpRA+1V5yXVEHA7VOYXTz6rZgYhIVyO57mWoSCFIk8Oq9KGgOjUT+cNBr1Ncwa
d4xSx9Rg223PEz3Jrz4pYGLa+0LQfkd6Xm/2TWgSH9bdJKLzHfk8GPHCg35L1Wg9
2fMD1zRGRv+W0y+lv/sA8VHIufPne3mw7NV6b9VN9rtijt1sHizvZKY2YT5qZso0
MRWiNRo=
=qvPS
-----END PGP SIGNATURE-----
--=-=-=--
