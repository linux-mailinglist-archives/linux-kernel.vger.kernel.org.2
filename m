Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B2E311D30
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 13:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBFMvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 07:51:39 -0500
Received: from ozlabs.org ([203.11.71.1]:46959 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhBFMvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 07:51:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DXsbJ43GRz9sVv;
        Sat,  6 Feb 2021 23:50:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1612615853;
        bh=oiKiD/snw/9+bkBo/LrWBA2HU0txJEZ2rYW7sTcHLnU=;
        h=From:To:Cc:Subject:Date:From;
        b=gz3xEXqcloGHdPByV7w3kxO/HXCqjwTOLAJEE6IwZV+gQnfU5u1jYNLW96+vDhICh
         jxRp1PucICHrrk0ueWw5twDVbt7IfrvJgxoDX1vODvbKEIMJHaG+gkhwulpWw4Y49r
         TkoqI41+FOGfAhk2WxfIqCa2gc3gZRhhQ3/JN9VCbF+kw1h1vVJwRwY9iF/yF+zmCd
         uTIG325iaUQwXWXfixg0HqZXx8tk58GjbwV1YO1trKUZttogHJJGipL66iP239Z4eM
         TeWe8xQZQ6NjQJ8XLHPMezKmHBsLCYEVM0c6BR/QIxEC+2MVWGe8hIEuOlzXBKKgAe
         UYRCcKGgD4tPw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        masahiroy@kernel.org, npiggin@gmail.com, raoni@linux.ibm.com,
        ravi.bangoria@linux.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.11-7 tag
Date:   Sat, 06 Feb 2021 23:50:45 +1100
Message-ID: <8735y9pdga.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.11:

The following changes since commit 4025c784c573cab7e3f84746cc82b8033923ec62:

  powerpc/64s: prevent recursive replay_soft_interrupts causing superfluous interrupt (2021-01-24 22:27:24 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-7

for you to fetch changes up to 24321ac668e452a4942598533d267805f291fdc9:

  powerpc/64/signal: Fix regression in __kernel_sigtramp_rt64() semantics (2021-02-02 22:14:41 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.11 #7

A fix for a change we made to __kernel_sigtramp_rt64() which confused glibc's
backtrace logic, and also changed the semantics of that symbol, which was
arguably an ABI break.

A fix for a stack overwrite in our VSX instruction emulation.

A couple of fixes for the Makefile logic in the new C VDSO.

Thanks to: Masahiro Yamada, Naveen N. Rao, Raoni Fassina Firmino, Ravi Bangoria.

- ------------------------------------------------------------------
Masahiro Yamada (2):
      powerpc/vdso: fix unnecessary rebuilds of vgettimeofday.o
      powerpc/vdso64: remove meaningless vgettimeofday.o build rule

Raoni Fassina Firmino (1):
      powerpc/64/signal: Fix regression in __kernel_sigtramp_rt64() semantics

Ravi Bangoria (1):
      powerpc/sstep: Fix array out of bound warning


 arch/powerpc/kernel/Makefile                      |  4 ++--
 arch/powerpc/kernel/vdso32/Makefile               |  5 +----
 arch/powerpc/kernel/{vdso32 => }/vdso32_wrapper.S |  0
 arch/powerpc/kernel/vdso64/Makefile               |  8 +-------
 arch/powerpc/kernel/vdso64/sigtramp.S             | 11 ++++++++++-
 arch/powerpc/kernel/vdso64/vdso64.lds.S           |  2 +-
 arch/powerpc/kernel/{vdso64 => }/vdso64_wrapper.S |  0
 arch/powerpc/lib/sstep.c                          | 14 ++++++++------
 8 files changed, 23 insertions(+), 21 deletions(-)
 rename arch/powerpc/kernel/{vdso32 => }/vdso32_wrapper.S (100%)
 rename arch/powerpc/kernel/{vdso64 => }/vdso64_wrapper.S (100%)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmAekG8ACgkQUevqPMjh
pYAHKw/+JNrzuw4P67ZqPcOMKayKAmUzBvd1ED/NBQtvtZpJS78tUVfps8DIr01g
i+UnlOohaavtGT0ARPTp7wEGL2c7vyzoNyxPdVru0x3UWq8xvnpdKfiHut7LjLot
32/aS9/rChr++JE7UeVVabYxvZJy9RSQg1DjcEi08X+LOwe2yJorME/4hVD3qjEV
FOIPbdsOOFyI3RWMsp3UFG3rwdJreHImSfZIlHUBCGHbLs5bVLC2CyoXN2UYTToS
DrD4C1R8a9wBTYcHOEJHAPCoeYHlELROeyEWbTapGGFlpMERUyhWxoEJNrkPt7Ym
3wQjlfI2g1oTu1ewi4D4QUHsnZHfwXvVAMzY84LvPRFXZrzJuvh17Dx9VD65ALfc
zyzasuecdEXlbGYilJHAA1m8Qlgm4utxzA+5BDv4UgegBVCopWjo2I1Ai+7vFo6S
58joA+G0m1E2QfbCQeEderBqe34kGMGcbzQFb8CQq7UnIG88U4JclCFbogOxDCdW
Ogu93sJpMRT2pNorBOk//clNBgdzm+PLE1uywZ7t2rLUN58SehBWM8SLDJgVWVfY
iPpN5hRJmEKhkT5Zq+l8Muvn2XsCc9jW0wZJW5k4jcEnwFfIsKBej2Qgiqm1y0D6
oFk9Wsp0K2YTo7G4ViL45r6RjlXVVfGzkK0t9LzTFV9znYaI5NE=
=dwna
-----END PGP SIGNATURE-----
