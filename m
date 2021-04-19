Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAEB36390C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbhDSBW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:22:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhDSBW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:22:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7221BAC79;
        Mon, 19 Apr 2021 01:22:28 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 19 Apr 2021 11:22:22 +1000
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 06/12] docs: path-lookup: Add macro name to symlink
 limit description
In-Reply-To: <20210316054727.25655-7-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <20210316054727.25655-7-foxhlchen@gmail.com>
Message-ID: <875z0j2hm9.fsf@notabene.neil.brown.name>
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

> Add macro name MAXSYMLINKS to the symlink limit description, so
> that it is consistent with path name length description above.
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown

> ---
>  Documentation/filesystems/path-lookup.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index 66697db74955..af5c20fecfef 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -992,8 +992,8 @@ is 4096.  There are a number of reasons for this limi=
t; not letting the
>  kernel spend too much time on just one path is one of them.  With
>  symbolic links you can effectively generate much longer paths so some
>  sort of limit is needed for the same reason.  Linux imposes a limit of
> -at most 40 symlinks in any one path lookup.  It previously imposed a
> -further limit of eight on the maximum depth of recursion, but that was
> +at most 40 (MAXSYMLINKS) symlinks in any one path lookup.  It previously=
 imposed
> +a further limit of eight on the maximum depth of recursion, but that was
>  raised to 40 when a separate stack was implemented, so there is now
>  just the one limit.
>=20=20
> --=20
> 2.30.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmB8204OHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbll0BAAxAkcuSwygyC2EySl49TyLBmXGhClYhXtIvG+
eSaFOOJLsn4d0t/F+lfrTCDrMYdJFvtrONYqrhXuuAmqvRktHVVr6aT7ptGJhLRm
wD4D7NhtbZc+sywj2ov53BgvMewqRJACR/4yIJn//HO7I/QoLvlnDAy/5LpvowPy
0dZg1vId27wJ+iXoejR6c//4ebo2KwKDO5XFdHfmvfFuUnN2NVqo93FexquJSx1k
DhMoem4xS9m9Q0neCeG9ne8/AxwGXBOJamKzo//YLBvIAGCnvN0KD0YJvq7EShm1
DQBs5aRXGbpzBhuqnTFJ5c/ZegWZL8JZpil4CgKsLnrkCtxF6NLIbG6XLp7Mjezt
56rfTuVawkQQbKX+HVNU6p7+J0BJJ1yVHkiaQdd6jhAvlGVwazl3b3iMj6q5+l6m
SiCsdzH2beBrDB3gjd1j7SBnP7NxhW8+SZ9oty73XpjfiN5LnywJXb//mDRaOazy
u6NGDSg4NnE9TzFnk+EQuMB9Qqfze7854YywyJU0XxJBBDb4DdbY0GcEuHOWvahp
CrnpMmjmhwy/JB0G0US/tR4IXtlD+Y0frM+WuaL9NOnenI7MoP+XezGXRxoBuBDT
11o4LIuZxLWwY/tPzBK+/UpUffsZBwlx2mMxsaBvsEaqBYDeS+hnWjUwc6UcOhGH
0BSf04o=
=u3T4
-----END PGP SIGNATURE-----
--=-=-=--
