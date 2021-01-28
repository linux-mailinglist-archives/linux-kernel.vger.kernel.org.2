Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343B7306BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 04:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhA1D3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 22:29:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:43382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231144AbhA1D3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 22:29:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9ED6ABDA;
        Thu, 28 Jan 2021 03:28:57 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Date:   Thu, 28 Jan 2021 14:28:51 +1100
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] docs: path-lookup: update path_mountpoint() part
In-Reply-To: <20210126072443.33066-4-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
 <20210126072443.33066-4-foxhlchen@gmail.com>
Message-ID: <87bld9hh8s.fsf@notabene.neil.brown.name>
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

> path_mountpoint() doesn't exist anymore. Have been folded
> into path_lookup_at when flag is set with LOOKUP_MOUNTPOINT.
> check out commit:161aff1d93abf0e5b5e9dbca88928998c155f677
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index 2ad96e1e3c49..4e77c8520fa9 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -492,7 +492,8 @@ not try to revalidate the mounted filesystem.  It eff=
ectively
>  contains, through a call to ``mountpoint_last()``, an alternate
>  implementation of ``lookup_slow()`` which skips that step.  This is
>  important when unmounting a filesystem that is inaccessible, such as
> -one provided by a dead NFS server.
> +one provided by a dead NFS server.  In the current kernel, path_mountpoi=
nt
> +has been merged into ``path_lookup_at()`` with a new flag LOOKUP_MOUNTPO=
INT.

You've taken a very different approach here.  Rather than re-telling the
story you have added a note (like a foot-note) that the details have
changed, withouy trying to re-weave the story.  The is easier to get
right, but doesn't produce as nice a result.

Maybe this is a good approach, it depends on how much effort you are
willing/able to spend on the task.

IF you do stick with this approach:  it is "path_lookupat", not
"path_lookup_at".

NeilBrown


>=20=20
>  Finally ``path_openat()`` is used for the ``open()`` system call; it
>  contains, in support functions starting with "``do_last()``", all the
> --=20
> 2.30.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmASL3QOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbk7LBAAoHzg9hUgx9WXb5zNozeNQKVpGYXIKC4XWwAW
E6DABgVNaeeh7KCzuInQ2LJocXyAejC4oPd6D45yEQSZJ90VBMicsnYYnQ7QphFL
g4ahxIWyow8AGNZDRsWbnkZ3qOu9ebnPj+o5q5KzOIyvv/e20zfDAK5sLJSfzByt
RSvNh2p/IQQC+onb7GlSUFWz38Vjw06+UrOajJGxVVTE8epN2xQT8ZGpsQC04O+h
nGy/DVPvuTxWH4gHbolqCuh51sRERRZmNs9RHA3SCFYNcwXf+fMDnogOuAhNPiDM
ZaubUJhGbQuYoGwN+AJnnXK5lagCj4+FkLkM54aleIhvPp1wCyJReZh82ORvEyie
+Eyw6d61xInhfz0OgWNylqS30VA8i3L006yId5oILJt2nj94QC02LO/v9khRw8wG
SKMWwvgvMJDotcy+SH1dM40QsPFewp5tt+hjlbLabVcNamPt+gV57NVrmpkDaeyS
qzUv7liyKcTx0BIyh/1awIJtE5Wlla0HgQRvYAHGCMYc3XtjlPPGc1tzzHUGyFZN
xsaczIAJnbqndcWUjPqbkpfBmrLEilB6bt6E+/2efrFV7i8759h6P4QSsnF3VrNo
/o/DvRlf58eiJxzVhhgiVIqiYll+g4+Wn2IdVLXE5IFY2XuR0ykvd0wTsSmYPYuw
srTvWCY=
=DlKb
-----END PGP SIGNATURE-----
--=-=-=--
