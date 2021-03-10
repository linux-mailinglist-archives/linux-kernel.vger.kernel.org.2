Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFAF333B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhCJLl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:41:29 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:38864 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbhCJLk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:40:57 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8709D1C0B80; Wed, 10 Mar 2021 12:40:55 +0100 (CET)
Date:   Wed, 10 Mar 2021 12:40:54 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     jikos@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        oneukum@suse.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 5.12-rc1-dontuse: Detecting known-bad commits to prevent bisect
 disasters
Message-ID: <20210310114053.GA9028@amd>
References: <20210310111039.GA7890@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20210310111039.GA7890@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I forgot to Cc lkml... Fixing that now.

Best regards,
							Pavel

> Would there be interest in a tool to detect known-bad commits
> automatically?
>=20
> Something like this?
>=20
> ".known-bad" file would have to be copied out of git at begining of
> the bisection...
>=20
> And no, I don't have right commits in the example file, I'd have to
> search for the right commits.
>=20
> Best regards,
> 							Pavel
>=20
> commit 75ad04e3fdf1d32a24e4203b628093560a2d7ac6
> Author: Pavel Machek <pavel@ucw.cz>
> Date:   Wed Mar 10 12:05:42 2021 +0100
>=20
>     Add tool for detecting known-bad commits.
>=20
> diff --git a/.known-bad b/.known-bad
> new file mode 100644
> index 000000000000..e86d6ffb260f
> --- /dev/null
> +++ b/.known-bad
> @@ -0,0 +1,4 @@
> +* 5.12-rc1 corrupts filesystems data using swap files
> +Bad: 3650b228f83adda7e5ee532e2b90429c03f7bafd
> +Fix: 3cea11cd5e3b00d91caf0b4730194039b45c5adf
> +
> diff --git a/tools/known-bad b/tools/known-bad
> new file mode 100755
> index 000000000000..36ef4f7033f4
> --- /dev/null
> +++ b/tools/known-bad
> @@ -0,0 +1,81 @@
> +#!/usr/bin/python3
> +import os
> +import sys
> +
> +def pcmd(c):
> +    return os.popen(c).readline()[:-1]
> +
> +def is_ancestor(this, anc):
> +    c1 =3D pcmd("git rev-parse %s" % this)
> +    c2 =3D pcmd("git rev-parse %s" % anc)
> +    if c1 =3D=3D c2:
> +        return True
> +    r =3D os.system("git merge-base --is-ancestor %s %s" % (this, anc))
> +    if r =3D=3D 0:
> +        return False
> +    if r =3D=3D 256:
> +        return True
> +    print("Problem searching for ancestors:", r, this, anc)
> +    sys.exit(2)
> +
> +def known_bad(this, buggy, fix):
> +    if is_ancestor(this, fix):
> +        return False
> +    if is_ancestor(this, buggy):
> +        return True
> +    return False
> +
> +def test_suite():
> +    print("Anc false: ", is_ancestor("3650b228f83adda7e5ee532e2b90429c03=
f7b9ec", "3cea11cd5e3b00d91caf0b4730194039b45c5891"))
> +    print("Anc true: ", is_ancestor("3cea11cd5e3b00d91caf0b4730194039b45=
c5891", "3650b228f83adda7e5ee532e2b90429c03f7b9ec"))
> +    print("Anc same true: ", is_ancestor("3cea11cd5e3b00d91caf0b47301940=
39b45c5891", "3cea11cd5e3b00d91caf0b4730194039b45c5891"))
> +    #print("Anc non false: ", is_ancestor("3cea11cd5e3b00d91caf0b4730194=
039b45c5891", "3cea11cd5e3b00d91caf0b4730194039b45c5892"))
> +   =20
> +    # HEAD, v5.10-rc1, v5.10-rc2
> +    print("Expect false: ", known_bad("HEAD", "3650b228f83adda7e5ee532e2=
b90429c03f7b9ec", "3cea11cd5e3b00d91caf0b4730194039b45c5891"))
> +    # v5.10, v5.10-rc1, v5.10-rc2
> +    print("Expect false: ", known_bad("2c85ebc57b3e1817b6ce1a6b703928e11=
3a90442", "3650b228f83adda7e5ee532e2b90429c03f7b9ec", "3cea11cd5e3b00d91caf=
0b4730194039b45c5891"))
> +    # v5.10-rc1, v5.10-rc1, v5.10-rc2
> +    print("Expect true: ", known_bad("3650b228f83adda7e5ee532e2b90429c03=
f7b9ec", "3650b228f83adda7e5ee532e2b90429c03f7b9ec", "3cea11cd5e3b00d91caf0=
b4730194039b45c5891"))
> +    print("Expect true: ", known_bad("3cea11cd5e3b00d91caf0b4730194039b4=
5c5891^", "3650b228f83adda7e5ee532e2b90429c03f7b9ec", "3cea11cd5e3b00d91caf=
0b4730194039b45c5891"))
> +
> +def check_fixed(title, this, bad, is_fixed):
> +    v =3D True
> +    if v: print("Problem %s... %s %s", (title, this, bad))
> +    if is_fixed:
> +        if v: print("...is fixed")
> +        return
> +    if not is_ancestor(this, bad):
> +        if v: print("...is not present")
> +        return
> +    print("Problem %s is present in current tree", title)
> +
> +def check_file(this, f):
> +    title =3D None
> +    is_fixed =3D False
> +    for l in open(f).readlines():
> +        if l[-1] =3D=3D "\n":
> +            l =3D l[:-1]
> +        if l[:2] =3D=3D "* ":
> +            if title:
> +                check_fixed(title, this, bad, is_fixed)
> +            title =3D l
> +            is_fixed =3D False
> +            continue
> +        if l[:5] =3D=3D "Bad: ":
> +            bad =3D l[5:]
> +            continue
> +        if l[:5] =3D=3D "Fix: ":
> +            print("This is a fix: ",l[5:])
> +            if not is_fixed:
> +                if is_ancestor(this, l[5:]):
> +                    is_fixed =3D True
> +            continue
> +        if l[:1] =3D=3D "#":
> +            continue
> +        print("Unrecognized line ", l)
> +
> +    check_fixed(title, this, bad, is_fixed)
> +           =20
> +test_suite()
> +check_file("HEAD", ".known-bad")
>=20
>=20



--=20
http://www.livejournal.com/~pavelmachek

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBIsEUACgkQMOfwapXb+vKOOQCfa+pgzsRAXDofxGx8NImdf6xu
4CsAnj0RFJqF6yl2vePY8cHcKH5tBi1B
=yk9a
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
