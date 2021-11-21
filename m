Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CC04581B8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 05:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbhKUEvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 23:51:14 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:54509 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbhKUEvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 23:51:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HxdFK0fbtz4xcs;
        Sun, 21 Nov 2021 15:48:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1637470088;
        bh=mC6rnoasBXMiC83+R9ITQ95F9G2PxGIWjseaTS+tZZE=;
        h=From:To:Cc:Subject:Date:From;
        b=GJ51HJe0PIGy54baJ900wWm+2Cn0zqpEQuY3aYovHSvF0yy3m8Nwy+f/p75j34TXo
         SjYJ1KdUbJK0/vYrt6AnQNngW2TAIxx0HxR9ZaqqlE/zVO77Ya4ydthh9PZlBm0Bs3
         R9EAXoZXjxvtuV6BLT6LurOYyrah59PlyD3T16sYfNONGbx1rH+xUPpaCg4KT4sdS0
         tNT6b6QQLpmKyuzQVTZz5PhWL48EGXeeEDYEm8cq6UyYJevHtAEAYpwmRjzrFpm5Zl
         QDj4A18u/3oZN1K5pKClDAUF6SRswtC5nrqcBOX0ojR9V63TWC6/CcgbXvTke9IEzt
         MA1hHB0OrktOw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aik@ozlabs.ru, christophe.leroy@csgroup.eu, clg@kaod.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        masahiroy@kernel.org, maz@kernel.org, npiggin@gmail.com,
        u.kleine-koenig@pengutronix.de
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.16-2 tag
Date:   Sun, 21 Nov 2021 15:48:02 +1100
Message-ID: <87lf1iqflp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some powerpc fixes for 5.16:

The following changes since commit 158ea2d2b2ff8fb49f39209a31b4920f13193a3d:

  kbuild: Fix -Wimplicit-fallthrough=3D5 error for GCC 5.x and 6.x (2021-11=
-14 18:59:49 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-5.16-2

for you to fetch changes up to 8e80a73fa9a7747e3e8255cb149c543aabf65a24:

  powerpc/xive: Change IRQ domain to a tree domain (2021-11-17 21:55:42 +11=
00)

- ------------------------------------------------------------------
powerpc fixes for 5.16 #2

Fix a bug in copying of sigset_t for 32-bit systems, which caused X to not =
start.

Fix handling of shared LSIs (rare) with the xive interrupt controller (Powe=
r9/10).

Fix missing TOC setup in some KVM code, which could result in oopses depend=
ing on kernel
data layout.

Fix DMA mapping when we have persistent memory and only one DMA window avai=
lable.

Fix further problems with STRICT_KERNEL_RWX on 8xx, exposed by a recent fix.

A couple of other minor fixes.

Thanks to: Alexey Kardashevskiy, Aneesh Kumar K.V, C=C3=A9dric Le Goater, C=
hristian Zigotzky,
Christophe Leroy, Daniel Axtens, Finn Thain, Greg Kurz, Masahiro Yamada, Ni=
cholas Piggin,
Uwe Kleine-K=C3=B6nig.

- ------------------------------------------------------------------
Alexey Kardashevskiy (3):
      powerpc/pseries/ddw: Revert "Extend upper limit for huge DMA window f=
or persistent memory"
      powerpc/pseries/ddw: simplify enable_ddw()
      powerpc/pseries/ddw: Do not try direct mapping with persistent memory=
 and one window

Christophe Leroy (3):
      powerpc/book3e: Fix TLBCAM preset at boot
      powerpc/signal32: Fix sigset_t copy
      powerpc/8xx: Fix pinned TLBs with CONFIG_STRICT_KERNEL_RWX

C=C3=A9dric Le Goater (1):
      powerpc/xive: Change IRQ domain to a tree domain

Masahiro Yamada (1):
      powerpc: clean vdso32 and vdso64 directories

Michael Ellerman (1):
      KVM: PPC: Book3S HV: Use GLOBAL_TOC for kvmppc_h_set_dabr/xdabr()

Nicholas Piggin (2):
      powerpc/pseries: rename numa_dist_table to form2_distances
      powerpc/pseries: Fix numa FORM2 parsing fallback code

Uwe Kleine-K=C3=B6nig (1):
      powerpc/83xx/mpc8349emitx: Drop unused variable


 arch/powerpc/kernel/Makefile                   |  3 ++
 arch/powerpc/kernel/head_8xx.S                 | 13 +++---
 arch/powerpc/kernel/signal.h                   | 10 ++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        |  4 +-
 arch/powerpc/mm/nohash/kaslr_booke.c           |  2 +-
 arch/powerpc/mm/nohash/tlb.c                   |  4 +-
 arch/powerpc/mm/numa.c                         | 44 +++++++++-----------
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |  1 -
 arch/powerpc/platforms/pseries/iommu.c         | 26 ++++--------
 arch/powerpc/sysdev/xive/Kconfig               |  1 -
 arch/powerpc/sysdev/xive/common.c              |  3 +-
 11 files changed, 52 insertions(+), 59 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmGZzfUACgkQUevqPMjh
pYDQNg//VzUcbRZgUaPw7NkPCberclTmpaFyUwk3iMx0rLH95vXhNjrCJa7tSxWk
fBp3WwVkytglPSM8CTxXNZm7ufXJyv7gO2jcpIzzkFxdD+uMODNd7wdl2rGq6Vxq
KLixLpP1696qVGKfma8NXsFlLJpUImDbRKNd5r2rYpLRSouQ8n5lfXVO1H0y4Pdn
aBxHidR10wiIG/SmDYawlAyxVmxAQZV5z7nnXYbNulB4exZeIOrSqo+XtBnr5Hem
CsLgsPizpERz6pRVKt08B9GUqNCqg8z/bwoU5xd8jlEdLGt3NX7MBkIhyoLOeSGu
94A+aQHsdP9bLp4I1cwqaA2FQ5NvU3BLwETC0nVmHtl5+unzFdm5mQMeGfkeTTqI
t0ki8d+JR5jyc8PayydXuy5RRwmRe9CHvr7mImb+RP3MMmL/ntOW0DnNWR7ARTSJ
By5lgKrm5XSer7M63LUltne5ZPUvLL2RBbGXU4HkVTbMQ0YzZikBcAg7T08CbOMz
0kMVlD+lygXk14u2WEFRYcwj4/aqGlxYVAYfKcJUiGI3jNNPi9ytGj5bL3Nityaf
XiGQ51kJREAKUNqrVHumI8JFZGtdrl7YD/7gUiCKUUV7GF6L+3imX7KQYbCIKqUN
HbN+Kni6KVkXvmu+0Y9w9aJf3l2pvyatY1cyliFfhTp1W8R7oOI=3D
=3DkNrV
-----END PGP SIGNATURE-----
