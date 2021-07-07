Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66183BF29A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 01:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhGGXtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 19:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhGGXte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 19:49:34 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68D5C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 16:46:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GKx0S0Ty0z9sWS;
        Thu,  8 Jul 2021 09:46:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1625701609;
        bh=kTjPnBT581ql5qqO9XNl0VtndmcR0Si+Mf2dhawMAo0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sqGV3OS+7FCeGwWDSlYiHVAgz2pRUzDF5WSsKnZuDCP81J+HNLxDQ6DWKf04QkL8Y
         2GrS7Y+dPeIZ2Z01oWwyjeqvtRv8yShjpEBamq6XjNeyrR6evxJynwADosUWwCBlWI
         QH1jozduyEmsqZnDFyedPIZsXqLQfnPfV7+P1UbUQT0dn+P1Qnd22g3SyOCqvfyPTR
         5XMT/HbBgn6q6t3U7IBDiblVMoLqWmmnBQ0WsfuZjBT3TRm4HqsYyrbo2XOaj9K4JR
         89RIXp1SooaCEVfP2DiVuIcO+o+fOlgvuBu7s/8qd+NEUlrEk5xGdE98Bm2bZ6w4ja
         88728yGGr5sBA==
Date:   Thu, 8 Jul 2021 09:46:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>, Jan Kara <jack@suse.cz>
Subject: Re: [GIT PULL] f2fs for 5.14-rc1
Message-ID: <20210708094647.7c0d3060@canb.auug.org.au>
In-Reply-To: <YOYHejl3CgABOnhP@google.com>
References: <YOYHejl3CgABOnhP@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rYOru_+sm4h=xMGuS0aRid6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rYOru_+sm4h=xMGuS0aRid6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jaegeuk,

On Wed, 7 Jul 2021 12:58:50 -0700 Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Could you please consider this pull request?
>=20
> Thanks,
>=20
> The following changes since commit bd3c9cdb21a2674dd0db70199df884828e37ab=
d4:
>=20
>   Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/arm64/linux (2021-05-14 10:52:47 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2f=
s-for-5.14-rc1
>=20
> for you to fetch changes up to 28607bf3aa6f9762b32dc7f1ed0488823c0651b8:
>=20
>   f2fs: drop dirty node pages when cp is in error status (2021-07-06 22:0=
5:06 -0700)

Its worth mentioning the semantic conflict against the ext3 tree (which
hasn't been merged by Linus yet, but presumably will be).

https://lore.kernel.org/lkml/20210623104922.30a5a3fa@canb.auug.org.au/

The ext3 commit has been rebased and is now

  1474c39351f0 ("f2fs: Convert to using invalidate_lock")

but I am still applying the mentioned merge resolution patch.
--=20
Cheers,
Stephen Rothwell

--Sig_/rYOru_+sm4h=xMGuS0aRid6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmDmPOcACgkQAVBC80lX
0GwuWwgAnGlXw7MWGnJud55varrnF25q/P+K6y78i2pwX69Ub0E7BesqVGD8FS0q
0P4SioVrBf/LBJ5/PoaQrVChhs85SpHPqLsE/Xa5A00ZJU1ylkqqEXJ4Mk67Fzo5
dYwEYVr/pvFyROMzpfFtxkxdUsOdf8cnjKiGKjQ9nAq5M8AyeCZvadpdKPX2RkIO
K710u40Bx/kpaQNV6ssAYDe8DvfwfvPXfQoH4MJ7/tvI9DVxUKTf06gprmIvYHh/
36Dx9I7uf0SQd/GS18Tay/4fxAenSaTKGv9uQSowe36kx/Hn7ZmUya4J5xxquRBZ
e+K4SY8Vllggg30Ota01NBkhof/1iQ==
=d9pS
-----END PGP SIGNATURE-----

--Sig_/rYOru_+sm4h=xMGuS0aRid6--
