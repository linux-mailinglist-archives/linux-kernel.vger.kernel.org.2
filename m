Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CED306C04
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 05:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhA1EO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 23:14:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:60148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhA1EOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 23:14:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73B49ABDA;
        Thu, 28 Jan 2021 03:53:46 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Date:   Thu, 28 Jan 2021 14:53:40 +1100
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] docs: path-lookup: i_op->follow_link replaced
 with i_op->get_link
In-Reply-To: <20210126072443.33066-8-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
 <20210126072443.33066-8-foxhlchen@gmail.com>
Message-ID: <8735ylhg3f.fsf@notabene.neil.brown.name>
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

> follow_link has been replaced by get_link() which can be
> called in RCU mode.
>
> see commit: 6b2553918d8b4e6de9853fd6315bec7271a2e592
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index 25d2a5a59f45..0a362849b26f 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -1062,13 +1062,11 @@ filesystem cannot successfully get a reference in=
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
> +``dentry*`` argument is NULL, ``->get_link()`` can return -ECHILD to drop
> +RCU-walk.  Much like the ``i_op->permission()`` method we

The phrase "drop RCU-walk" isn't consistent with the rest of the text.
It talks about "dropping down to REF-walk", so you could write "dropping
out of RCU-walk", but not just "dropping RCU-walk".

NeilBrown


> +looked at previously, ``->get_link()`` would need to be careful that
>  all the data structures it references are safe to be accessed while
>  holding no counted reference, only the RCU lock.  Though getting a
>  reference with ``->follow_link()`` is not yet done in RCU-walk mode, the
> --=20
> 2.30.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmASNUQOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmZRQ//XLYLM06bPmySmfV+5mnL2d0l4e+4B7qRfJ7a
4Bj3/wPxQxNXCP2Ie2t4Y/sxyQS2/kDRiTN+RUd86rV4RYDrJC3ZKP51GhQK+DIy
dHsYONxHCVlKMRBpkkD2KKungJcKTGPVCCIrs9s8AgStFgDAUyc5z0Wr5ucffCV9
QjF1DQg97nCMAbhzH1DUO9QG6LMKdVcG2b9g4ujr9dhYeakbKBJWzDRRAh9mu8uH
eN/StIztthsP6tWhK8W92L24Br+dOFm6NtLonuEQygMkMdIdigth9iY3k0Po1Hrz
SajJ8M7YCPPjyuyEX80FxNDRIbfzjrT+49udFPi/63NJHxTP9AamaU719D77szn/
AuDKLIjn0gpJUYgcJt13GxO8rfkuYq8S0CxqC7jezJo2BOFJM5yR6nd8ZTwYfk+r
b5n21zUc+ycEPW0jbk7/hUTZobKRMd5z8xeOIbRRJLlrH3BB1NJItz7TL1cudJ68
S+jk3jz0j/tk9F0dG1YiDX82KfEZTpipd31ffwfV9Mnj+PG7KvL0B2B7pumeAc9h
lYTZW7bO7LkEOKgUTMmk+gXlbpljp4ohoFqQhY45SJlWjuLn0f5IL+VKj7FN/F2J
+Vk2nCl52syQZNr7LQVfPl2WPakC+v1Kqy//yJhOV8nHmjJ3LQXw2tzM7DeUlm/L
0xDimpY=
=4lEM
-----END PGP SIGNATURE-----
--=-=-=--
