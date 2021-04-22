Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1F6367CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbhDVImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:42:45 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:45434 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhDVImo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:42:44 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E23B61C0B7A; Thu, 22 Apr 2021 10:42:08 +0200 (CEST)
Date:   Thu, 22 Apr 2021 10:42:08 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 055/190] Revert "fs: ocfs: remove unnecessary assertion
 in dlm_migrate_lockres"
Message-ID: <20210422084208.GB5316@amd>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-56-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-56-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2021-04-21 14:58:50, Greg Kroah-Hartman wrote:
> This reverts commit 67e2d2eb542338145a2e0b2336c1cdabd2424fd3.
>=20
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).

This patch is correct AFAICT.
								Pavel

> index f105746063ed..f89dcf9b6217 100644
> --- a/fs/ocfs2/dlm/dlmmaster.c
> +++ b/fs/ocfs2/dlm/dlmmaster.c
> @@ -2554,6 +2554,8 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
>  	if (!dlm_grab(dlm))
>  		return -EINVAL;
> =20
> +	BUG_ON(target =3D=3D O2NM_MAX_NODES);
> +
>  	name =3D res->lockname.name;
>  	namelen =3D res->lockname.len;
> =20

--=20
http://www.livejournal.com/~pavelmachek

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCBNuAACgkQMOfwapXb+vIHpgCgwxP0uw6d6FX5YFQo7Bji0a4f
y5QAoK02fHQWPtTd9l+6V7p0dk/6pQuM
=mT4y
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
