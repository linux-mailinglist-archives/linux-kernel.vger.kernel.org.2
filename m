Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931ED35AE78
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhDJOoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:44:10 -0400
Received: from ozlabs.org ([203.11.71.1]:60057 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234587AbhDJOoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:44:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FHd6d1rKxz9sVt;
        Sun, 11 Apr 2021 00:43:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1618065833;
        bh=/eP42BTmaH5j9syWdkGNscqVoeuxbCGIhn38imuuwU0=;
        h=From:To:Cc:Subject:Date:From;
        b=VXbjvpuhngUwFF2lpH+mmsnIMAN84ZzUkAb68S7HsjPA26uGZ5a9rHGBoJkSJKdyG
         l7F7DpI4TR573D9CqGfS/9e6TGojvcZu3y0mRWTVfLCt4XXwNQEwwlHT5CLelw5i0u
         DMeImR80o1Hlu6/JOFfmowIsYVPe0e3ogXhAuVB5DW+GmFGFeCTG1cyuAMbm9g0Cn6
         y+OcX3va5bHiv1d63kk1QNuBllY4KPNCgHdb7FSo7eTtIh1AYhcjx8qj9vK/lcH/U/
         f52Pvy19EZFWWPHC37Pv4JjvNfWu+0+dTWbb/GTPdC7JGFUE3NkJ2Dv2pJ5s01sAuU
         hInE0YENXrSOA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-6 tag
Date:   Sun, 11 Apr 2021 00:43:49 +1000
Message-ID: <871rbidwt6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.12:

The following changes since commit 53f1d31708f6240e4615b0927df31f182e389e2f:

  powerpc/mm/book3s64: Use the correct storage key value when calling H_PROTECT (2021-03-26 22:19:39 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-6

for you to fetch changes up to 791f9e36599d94af5a76d3f74d04e16326761aae:

  powerpc/vdso: Make sure vdso_wrapper.o is rebuilt everytime vdso.so is rebuilt (2021-04-02 00:18:09 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.12 #6

Fix an oops triggered by ptrace when CONFIG_PPC_FPU_REGS=n.

Fix an oops on sigreturn when the VDSO is unmapped on 32-bit.

Fix vdso_wrapper.o not being rebuilt everytime vdso.so is rebuilt.

Thanks to Christophe Leroy.

- ------------------------------------------------------------------
Christophe Leroy (3):
      powerpc/ptrace: Don't return error when getting/setting FP regs without CONFIG_PPC_FPU_REGS
      powerpc/signal32: Fix Oops on sigreturn with unmapped VDSO
      powerpc/vdso: Make sure vdso_wrapper.o is rebuilt everytime vdso.so is rebuilt


 arch/powerpc/kernel/Makefile              |  4 ++++
 arch/powerpc/kernel/ptrace/Makefile       |  4 ++--
 arch/powerpc/kernel/ptrace/ptrace-decl.h  | 14 --------------
 arch/powerpc/kernel/ptrace/ptrace-fpu.c   | 10 ++++++++++
 arch/powerpc/kernel/ptrace/ptrace-novsx.c |  8 ++++++++
 arch/powerpc/kernel/ptrace/ptrace-view.c  |  2 --
 arch/powerpc/kernel/signal_32.c           | 20 ++++++++------------
 7 files changed, 32 insertions(+), 30 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmBxuXYACgkQUevqPMjh
pYBgHQ//eM5IN34NKvsdcVEZatYDqIwMNL0w805XmFXcNHeUJ3HP6wf+R84L6zzi
9reylRchDSGOO7qGDbhutDeCvtEO3hgqG+t60sraHEMD8bmzxy3cnidYBpL+SXCV
AmI2hpTzv/qhTLLD85Q6A7jtA0QCJA+Qluw2cgWB44XbKsNX4tofXBMxCZC8tvmb
/SBb2ccZQ1Q0ZkkQSnxuf/MV1h4m8+sOryc7iIbAlfW3Ag5xEj6UwUzpS8VJ0h/e
WR6QRERZN5jwP9jMWVMo7zXw1Rw/vbN97hayUj3dk1QofLmAEOQMG8uPF43SKnAu
3hdabHASC7apYbiN6DQWSh3waXZP5a/pWhMjHKvYEsEOJCxYXTXuI124fbB+QkSj
v8VzKzoDCt4rh7H7wsY8lmqDjwrklEtRrdg0qaZ9seMG6+hWv/0iu30x3NLHLSLD
pR1rhWRlgVNegT++sQlBdgYory4qrAhi6s+0tXWSEX86XqSNaQd9U3KZ4sBwlnAQ
dgaPOQl5T3uY8kVWaSMadMT6IXVetkIBOiUOBUqNzeBKsEPAYj9Hs7FK402cuUT4
O/KwqIeEuDcO6lLCznU81uapqOaGVbsPs/qcETCqyfJmzo8Us/slFmzCd3bvSm+a
eIUUUyrgSAi3LjczjnOwjOXj0RId43/hMLkfrT0EZ138wwjHm7s=
=2wh+
-----END PGP SIGNATURE-----
