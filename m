Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00B7306B95
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 04:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhA1DZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 22:25:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:42416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231124AbhA1DZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 22:25:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B70A5ABDA;
        Thu, 28 Jan 2021 03:24:37 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Date:   Thu, 28 Jan 2021 14:24:31 +1100
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] docs: path-lookup: update path_to_nameidata() parth
In-Reply-To: <20210126072443.33066-3-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
 <20210126072443.33066-3-foxhlchen@gmail.com>
Message-ID: <87eei5hhg0.fsf@notabene.neil.brown.name>
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

> No path_to_namei() anymore, step_into() will be called.
> Related commit: c99687a03a78775f77d57fe9b07af4c8ec3dd03c
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index e778db767120..2ad96e1e3c49 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -455,7 +455,7 @@ In the absence of symbolic links, ``walk_component()`=
` creates a new
>  ``struct path`` containing a counted reference to the new dentry and a
>  reference to the new ``vfsmount`` which is only counted if it is
>  different from the previous ``vfsmount``.  It then calls
> -``path_to_nameidata()`` to install the new ``struct path`` in the
> +``step_into()`` to install the new ``struct path`` in the
>  ``struct nameidata`` and drop the unneeded references.

The logic describe here is now embodied by the code in step_into(), so
the change doesn't make the description any more correct.

Possibly you need to change the hero of the story from walk_component()
to step_into(), but that is just a guess.

NeilBrown


>=20=20
>  This "hand-over-hand" sequencing of getting a reference to the new
> --=20
> 2.30.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmASLm8OHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbnKphAAxI/39qkWqxQ0roEbx1nsbuSkTpV4xHN7DVjV
GkODqSc4tE4P1ZEaereO2qeNf+d8mcZNBXZiBHxAD0nRYbsqeFYmETonmvhNJf8t
hIjvwizHK1rDGt8W3S1lCyUlulUgGNIkOOVN6rYcOPHYOcBi2+IXdAGBIwlNyR7C
c+y+kX9VRIQPoeDI58x4C8z3jomU6xXycHryiMrrQjuK9dJBpZ639EyfXfzeMlZe
hdi97PYAO9a2peVmMM7wlrthscHON2Q1L3gWCMeHeUunlxL1lYqdAbeoTotS7HQi
PphdCOT+1NWtekn5ab4iQbM9OBW+ha/52JRlqPTCTByxYC9zhUIHoBTWoP5tvTpN
ENPVC9yxe4uIHYbiDACB5OBv3n4/Tk906M/EVmpxkN/no3QRBO+e4yWJ1DJMF0yR
cQXW3jagaSILuOaF9PXI36gFQ0SUPKhmhRtW9TOcUl5MdIRJa/b4f2Q4tzKv5ELR
s66kYW6gsHFaUsBspHJM12MErESKavhDcv8eHjZ4kz3cB9XiP+1eLcQnIXzrMo7d
ORAKBBQqhHtSfL++wEfsjWwGwRKwJnhprNnzdvxVnqAVu8Bllcprcst/dorOwW3f
+7keauLWaeRjz3HHcPPDxWQxCJCpYR1N8akmLf75ExQ3Xy4hKMw51zvKJ8mYBVW8
qVMhjIg=
=xU/E
-----END PGP SIGNATURE-----
--=-=-=--
