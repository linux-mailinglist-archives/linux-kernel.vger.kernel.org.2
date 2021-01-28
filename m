Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E406306B87
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 04:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhA1DVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 22:21:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:41626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhA1DVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 22:21:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99583ACB7;
        Thu, 28 Jan 2021 03:21:06 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Date:   Thu, 28 Jan 2021 14:20:59 +1100
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] docs: path-lookup: update follow_managed() part
In-Reply-To: <20210126072443.33066-2-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
 <20210126072443.33066-2-foxhlchen@gmail.com>
Message-ID: <87h7n1hhlw.fsf@notabene.neil.brown.name>
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

> No follow_managed() anymore, handle_mounts(),
> traverse_mounts(), will do the job.
> see commit: 9deed3ebca244663530782631834e706a86a8c8f
>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/fi=
lesystems/path-lookup.rst
> index c482e1619e77..e778db767120 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -448,8 +448,8 @@ described.  If it finds a ``LAST_NORM`` component it =
first calls
>  filesystem to revalidate the result if it is that sort of filesystem.
>  If that doesn't get a good result, it calls "``lookup_slow()``" which
>  takes ``i_rwsem``, rechecks the cache, and then asks the filesystem
> -to find a definitive answer.  Each of these will call
> -``follow_managed()`` (as described below) to handle any mount points.
> +to find a definitive answer.  In ``step_into()``, ``handle_mount()`` wil=
l be=20
> +called to handle any mount point.

The text now introduces step_into() without any hint as to why that is
relevant at this point.
It is a bit awkward to explain succinctly because while lookup_fast and
lookup_slow return a dentry which is passed to step_into(), handle_dots()
calls step_into() itself.

This is a general problem with this sort of documentation.  It weaves a
story and when the code changes, you might need to completely re-weave
the story.

I don't have a good suggestion for how to fix this text, but at the
least it needs to be made clear the walk_component() calls step_into(),
either directly or via handle_dots().

>=20=20
>  In the absence of symbolic links, ``walk_component()`` creates a new
>  ``struct path`` containing a counted reference to the new dentry and a
> @@ -536,7 +536,7 @@ tree, but a few notes specifically related to path lo=
okup are in order
>  here.
>=20=20
>  The Linux VFS has a concept of "managed" dentries which is reflected
> -in function names such as "``follow_managed()``".  There are three
> +in function names such as "``traverse_mounts()``".  There are three

Here you've completely broken the story.  Saying

  The VFS has a concept of "managed" dentries which is reflected in
  function names like "traverse_mounts()"

makes no sense at all.
Again, I cannot offer any quick fix.

NeilBrown


>  potentially interesting things about these dentries corresponding
>  to three different flags that might be set in ``dentry->d_flags``:
>=20=20
> --=20
> 2.30.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmASLZsOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigblPYQ//Y6coOk2lqWxVQzOZwNT9+fpXG+LxEuX1qLqy
YvXoCrdMBlTb3w9zZtarnlp7OkxdsgIGmxMfJGSbJcCSsTQ9FlATnG2S5Ch7Y3wD
8iBx5mZZPKPzwTwMwRQ9GwSFTP5+oWHQ9yy94ywOylzZTjrQw13kp8eN+aLXnt6Q
ZzKz86wXanc7uo+nNeX6zuVsLB41T5C7s5AqXaiLJ3XL4YiiH+LyuGsNCpbKXbEm
xOtmbsWhEB5kg0GwkiuWd2zRazhpIK9pal1JID3K2fyh2MEu26CNR0/ZBLeaamHM
I5Vy5N2IZfPVCTTUw9ta1nCW8x+NIh7ybvGYsQ2hsG1CYJzTM+KDv4nlgk4cZOOu
qztXFopoUTcOBAlEhUFCkwS7VfYilw2ybgk6AJwauljdzF5PPNoc4nOB2o+ysZoo
7rmdQ9WZx98zdace4JvqcOXzr+qytalZ8h/oFtasfV7PiuDmGp/O0INmuvVXOcqj
F8Arz70IDtzEwPhc9liTDPcqJL/NBx6Bcmns3EKSPMZ00hWaozLTlKXkL0UVHz/E
7k3TJdimeO8HvFpTw2j8oEMkuJqAolutxGuSnSkqfDJZ6Iqcy0+c8Z5m9Hs6JJ6R
MdN4oejU7RuHgG1VVhjrc4QrBmSN0axS2kbAszYtTjAZslN58AyA8k67bLMKVoaV
friCJks=
=d1+s
-----END PGP SIGNATURE-----
--=-=-=--
