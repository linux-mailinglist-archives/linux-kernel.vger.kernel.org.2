Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC25345FDCE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 10:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350225AbhK0J5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 04:57:09 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:48857 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354042AbhK0JzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 04:55:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J1Rj41VHzz4xbs;
        Sat, 27 Nov 2021 20:51:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1638006712;
        bh=usCd2qjYIP35CO8b4FUrLCXJOfoAeeoBkB1oYS68sdY=;
        h=From:To:Cc:Subject:Date:From;
        b=A378zKGNW5e5ewj9iteoAUSZ+/xoQ6CzSJUr9kgzrv+UdtDAV6DOWHxC/ZZ9MFDKt
         fr18FkooKVegF+QO8FNtn0f34h5CCZNdtXhL2gr1zqjNk2CDCDv4i08DKmzHbUKRB0
         8DgqeJ/vttBSwFKverR7Bd9RLuzL9Zdft6Wbe9KpMs/Uv/FMNqgue4mba6Mtygn6YT
         PEWzAaphJRymr0eLaTL4XI6rihI5FwsLEiCF+BeibCl0qeIjBUVfbqC5YwHXiK2qVX
         RouDsDL+A/BC5QGFPmbhjGPth57ViVtYFXFaBz5LS4jEd43/q6kn3NehmUsmiSBy8N
         0oLeDpluDzc2Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.16-3 tag
Date:   Sat, 27 Nov 2021 20:51:41 +1100
Message-ID: <87ilweoriq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.16:

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.16-3

for you to fetch changes up to 5bb60ea611db1e04814426ed4bd1c95d1487678e:

  powerpc/32: Fix hardlockup on vmap stack overflow (2021-11-24 21:00:51 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.16 #3

Fix KVM using a Power9 instruction on earlier CPUs, which could lead to the host SLB being
incorrectly invalidated and a subsequent host crash.

Fix kernel hardlockup on vmap stack overflow on 32-bit.

Thanks to: Christophe Leroy, Nicholas Piggin, Fabiano Rosas.

- ------------------------------------------------------------------
Christophe Leroy (1):
      powerpc/32: Fix hardlockup on vmap stack overflow

Nicholas Piggin (1):
      KVM: PPC: Book3S HV: Prevent POWER7/8 TLB flush flushing SLB


 arch/powerpc/kernel/head_32.h        | 6 +++---
 arch/powerpc/kvm/book3s_hv_builtin.c | 5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmGh/0IACgkQUevqPMjh
pYC11A//aE4RsEdrvL3TY3oEWmDoDC3xtrKub5TCopudvWubpSHEvsUzCjyLPmeO
s/5pllifG8s9LKFHqwCTTLWnfqaZkTcQMF2THLM7gGT4BjYRS0snjcXbVNaaCeNr
ByvZduLjfoGsUkWeKojQ3Kc+xAOU1oQPJfiAofyRQtUYfirYMSA89I0wXImzhEad
/vy6galPLtFXjEJiBVzLjqVFnmTMML4pHHQMF7F0pposxQNvWA73VYeov14kz98G
sOElGv3U168gd4sNsVbN3imUo5dmoOSriH+MtZEKRYMznbvb/Lq8/RvF7MXhJdlw
iTpMAuCNiCDJzn9yUJ4nRu3CEimaznN04sP107D4YEHDERDvVQoyFE6kGaT1NUsF
bIhWRU7gLURJrVNAZeabtTYa90pHdFdHIs3eNUTHW8Fyowf6Gr4CD8MZ1kb+A/wB
1MNLaOjfkOltbar/KtWz+sNpvnu8GeSUrK4bSBWyJAhDLHds250XQ6ZJcjRCtFKT
sk7sefle5nV8o2MStYQQ0i88n0ZKm3wdpAFoHgWry713p2ECZ1sWopiVDZZwxK/2
Pt94JncFV+RNG5uIf9RmXauU+R+zWIHVstiiwz5ZIOFKE6dtSwaD6BdoMuh4zNP5
fXL86D3cnhwk2F0r1kPjznjZzDFERsNMOHYkI8C8twvE/NklN1Y=
=5saw
-----END PGP SIGNATURE-----
