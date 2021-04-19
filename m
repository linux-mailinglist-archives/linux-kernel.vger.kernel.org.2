Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0220363916
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbhDSB2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:28:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:55420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232133AbhDSB2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:28:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 904FDAEFF;
        Mon, 19 Apr 2021 01:28:20 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 19 Apr 2021 11:28:14 +1000
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 07/12] docs: path-lookup: i_op->follow_link replaced
 with i_op->get_link
In-Reply-To: <20210316054727.25655-8-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <20210316054727.25655-8-foxhlchen@gmail.com>
Message-ID: <871rb72hch.fsf@notabene.neil.brown.name>
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

> follow_link has been replaced by get_link() which can be
> called in RCU mode.
>
> see commit: commit 6b2553918d8b ("replace ->follow_link() with
> new method that could stay in RCU mode")
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>

Reviewed-By: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


> ---
>  Documentation/filesystems/path-lookup.rst | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index af5c20fecfef..e6b6c43ff0f6 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -1060,13 +1060,11 @@ filesystem cannot successfully get a reference in=
 RCU-walk mode, it
>  must return ``-ECHILD`` and ``unlazy_walk()`` will be called to return to
>  REF-walk mode in which the filesystem is allowed to sleep.
>=20=20
> -The place for all this to happen is the ``i_op->follow_link()`` inode
> -method.  In the present mainline code this is never actually called in
> -RCU-walk mode as the rewrite is not quite complete.  It is likely that
> -in a future release this method will be passed an ``inode`` pointer when
> -called in RCU-walk mode so it both (1) knows to be careful, and (2) has =
the
> -validated pointer.  Much like the ``i_op->permission()`` method we
> -looked at previously, ``->follow_link()`` would need to be careful that
> +The place for all this to happen is the ``i_op->get_link()`` inode
> +method. This is called both in RCU-walk and REF-walk. In RCU-walk the
> +``dentry*`` argument is NULL, ``->get_link()`` can return -ECHILD to dro=
p out of
> +RCU-walk.  Much like the ``i_op->permission()`` method we
> +looked at previously, ``->get_link()`` would need to be careful that
>  all the data structures it references are safe to be accessed while
>  holding no counted reference, only the RCU lock.  Though getting a
>  reference with ``->follow_link()`` is not yet done in RCU-walk mode, the
> --=20
> 2.30.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmB83K4OHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbksiQ//XnE5L+ary/pEvObxJRRgjdGapcR/B9d+4A6U
GQOrZ+ZGWVlSA3w1bopmuJyN1SFhoXNzTEo5nL2LaDisyymiVU9tfebfzdCAnuee
IQa1GxW80h95c44BoAbdVaIdhf2Q9/XPnUNUIRxmOXB/NXSr+NRIo+0B2TTWtxdR
He4bD4VoU6a0VO0OR0ZBpmrhX21KTo3m0sRiA3mjUZ4MR6qxEnrim9+YP7WH5p5W
LsoHsQ+F5LAMA6cI6sXazCIhviVR6ebSmP9p6A+Ra1r05g+2fRtZafWnN1pZf8ok
13dSoI+Sd0Ayv0eqeZ0Fg/OhEOb1z22TJaNYxD7z+m/5IW4TBhKnXGLv2pItuJZF
sKyCrkuec3wuSXCm67qUheU30SCekvHSge/bY4FZKUAes5Z7+OiADJvvREm/J9as
ykY+NDob/GOJWZryfwzHM88nc6du/J1U/b3HaItOJHvt6hoIqo0H5O+2MS8RaMM9
xmmoquiyJ87uiiBZJKkAldrjPW9rgPPz+5rDhNFwvTPXA/TJqj/ntGQ0ZY1J2JdU
LgmBLZRYOfD6zdBA9xot1Epua3qBC2gCpUJsmMjyvyVGZ9nLl3xqdDLAtphCvYE5
xREZngB8qFS1NScGh0fyFhnRq+1kGXoxYWRZF14jDpHOVJULxnIPid6Aq4Dtd6BW
RRscibg=
=IY0x
-----END PGP SIGNATURE-----
--=-=-=--
