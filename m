Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE16044A7CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 08:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243716AbhKIHtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 02:49:04 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:34075 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbhKIHtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 02:49:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HpKmQ6GsRz4xbC;
        Tue,  9 Nov 2021 18:46:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1636443975;
        bh=n9dHDk0YBEKFfEaMS7CMQX25dWhUY5DatH27i0dtU7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HdpaYpcoVo/S7nDXeURN8t1SsbJhcZudBlhpnmo0FRjRH/ufv2bfjSrn+5dwwzB50
         HEoeels2AlLM0n/CamrD8f2ojoffSNR3XOtbs80lLgcE1J8pZjQPPu15EI6Z1PkKxn
         w2AyrnyP/vrGrBKB3WnV8r1GdnIGT40HjpEAhVzaKwA2VHW+76bojioo+jSA7HJQNi
         vQ2f7yEyW4wHPoNW+9qKsown0RcphXew4JwMFibGVf3zGpqWkgWD3Pvapfla0yIreM
         k1T0GS38f7q8oGlS9ZJe0N1cmNBE5U++wIOpnGq/q5HHJcqwBOhveVc2oToqCuPMD6
         I2Z/NRveYpILg==
Date:   Tue, 9 Nov 2021 18:46:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: arch/nds32/kernel/vdso/gettimeofday.c:246:13: error: no
 previous prototype for '__vdso_gettimeofday'
Message-ID: <20211109184613.0a9aa3c9@canb.auug.org.au>
In-Reply-To: <202111091310.etMHozC9-lkp@intel.com>
References: <202111091310.etMHozC9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/G3edjO6ygZKX2rIiwycazkK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G3edjO6ygZKX2rIiwycazkK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 9 Nov 2021 13:17:19 +0800 kernel test robot <lkp@intel.com> wrote:
>
> First bad commit (maybe !=3D root cause):
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   d2f38a3c6507b2520101f9a3807ed98f1bdc545a
> commit: 20fbb11fe4ea99e02d77824613f1438bea456683 don't make the syscall c=
hecking produce errors from warnings
> date:   9 weeks ago

Its very unlikely to be that commit (since all it does it turn some
errors into warnings):

commit 20fbb11fe4ea99e02d77824613f1438bea456683
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Mon Sep 6 15:47:02 2021 +1000

    don't make the syscall checking produce errors from warnings
   =20
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index b7609958ee36..fd9777f63f14 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -266,4 +266,4 @@ syscall_list() {
 }
=20
 (ignore_list && syscall_list $(dirname $0)/../arch/x86/entry/syscalls/sysc=
all_32.tbl) | \
-$* -E -x c - > /dev/null
+$* -Wno-error -E -x c - > /dev/null


When did this start failing?  That commit has been in Linus' tree for 9
weeks ...
--=20
Cheers,
Stephen Rothwell

--Sig_/G3edjO6ygZKX2rIiwycazkK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGKJ0UACgkQAVBC80lX
0GxhqQgAkMDtCrb+4bzk7fLXpyC6u8VNVSL6/3LBIZikP20biq1tFHt3WZ37E0Fp
AASfCWtZKz0gXu3upBWVpa54bKRxKIpFkljPC0ukLNzeFM+1Ni7SjP2OdvkLYO3o
wNgOSyl7E5QM2NRSac5j24mRP28JL8J71cHqCELUriCWvJ/tcpU4hglBhctoBmeT
39WU14qwV4wXWp8Twp+4oIyPJUYmIZy+RoSASieyl3YB122cQQUjare/DpOdv6aP
JyWxa6Yp39I9Cn2FeETfTjOcjd4s44sNX5h1snSha3GAs8DRYvnJPycT6+mhjeBa
fAuI6iSIV47pmGCm+6MFi2ELOkZ6ug==
=rjPq
-----END PGP SIGNATURE-----

--Sig_/G3edjO6ygZKX2rIiwycazkK--
