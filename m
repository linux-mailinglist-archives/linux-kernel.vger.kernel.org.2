Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC7C4308BA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbhJQMif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:38:35 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:41243 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbhJQMib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:38:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HXKHn24Wnz4xbc;
        Sun, 17 Oct 2021 23:36:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1634474181;
        bh=Dw1rY37uJhO7CntwmBCrGxDeK8CeNQ/IuMdrDqnsJyY=;
        h=From:To:Cc:Subject:Date:From;
        b=VmPuR+yyn5IfRb2PK9EhLP9nTZuxF91PaXmIq6K5ktEmca9dNc+Bx42ERRGlVfOmI
         osMxxS5H2xinjOYOmLRBaNBlJ/4TkYlm+ySNGRVD1u9M6DmC+/9vlnQmpyW6qGeOGE
         9aw5jp1tfY72kd9kt4mdW+OegqKLzczBSoF3tviFJDs7fNrTao4YXca/48zfzJJ8E5
         nud/2qhRhf9/Qiw6ggHn3UKt2ZLLTMBc9WURlSqIFOpiYoUHW2Yksn243DqbN5NZvu
         S60AWeITzUK0MhOKisifjUhZnZedJQXTnA5pst6kDIrqCfSkPNRQ1T7TVC5lmXO9fP
         BdFBhiG27JX/g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     clg@kaod.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.15-4 tag
Date:   Sun, 17 Oct 2021 23:36:20 +1100
Message-ID: <87sfwzde0r.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.15:

The following changes since commit eb8257a12192f43ffd41bd90932c39dade958042:

  pseries/eeh: Fix the kdump kernel crash during eeh_pseries_init (2021-10-=
07 23:37:22 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-5.15-4

for you to fetch changes up to cdeb5d7d890e14f3b70e8087e745c4a6a7d9f337:

  KVM: PPC: Book3S HV: Make idle_kvm_start_guest() return 0 if it went to g=
uest (2021-10-16 00:40:03 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.15 #4

Fix a bug where guests on P9 with interrupts passed through could get stuck=
 in
synchronize_irq().

Fix a bug in KVM on P8 where secondary threads entering a guest would write=
 outside their
allocated stack.

Fix a bug in KVM on P8 where secondary threads could confuse the host offli=
ne code and
cause the guest or host to crash.

Thanks to: C=C3=A9dric Le Goater

- ------------------------------------------------------------------
C=C3=A9dric Le Goater (1):
      powerpc/xive: Discard disabled interrupts in get_irqchip_state()

Michael Ellerman (2):
      KVM: PPC: Book3S HV: Fix stack handling in idle_kvm_start_guest()
      KVM: PPC: Book3S HV: Make idle_kvm_start_guest() return 0 if it went =
to guest


 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 28 ++++++++++++--------
 arch/powerpc/sysdev/xive/common.c       |  3 ++-
 2 files changed, 19 insertions(+), 12 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmFsGG0ACgkQUevqPMjh
pYCAJRAAi8wEtHdIziXc22xYVaI8znMeogpoYnqKmEjRoGhyv79JNzh1/kOsNWyQ
E8hGut8YrKl+0xswbF41E5qdQCLfHiJYhqe8Ltl38ltoSx5YO/FqTtDMuVvc9bO1
SuyNOQWwrfPo6PolAHKtWv+yn7lMV6tP2NBp0lXe6DQkrCC7FEQ/s+12qQFmmnmb
hZ4KQuu27kcWqADTyhqipH+pLS+0nSdWFrBXyxQVtPlAxy0trvwU3m+9rNvcWcob
D07uH8n0TS1nORYs0s8YStxz5Kme0ICUIj64hvox7T1CqcTldl5iMrpzjvHRUa+s
sbuAgjAnyaksCiKyDJjIo8NtpXFYYLq4SeAn0/6dCxb3gtyQsRBDG9oe7F/q5jvO
j0flo6Bmcl4es3dTEz5mX7G/EChniTYyeq4xfVFZpA/56LkXeCdcTkBeyTeopBSe
QLtR40DUFYBZZVBUotBp9K13Grqg8xrvLYFZhUihA5rnC7HRZjwt70Rh3FmZUKcd
i7blHpIssf8obH5ERhEUOF4ITHwmFkLDBgqTh/jlPYlMBz4FYn/2IxWnMfZQpv3u
igC6DHCwJ9FmTI0iGyN2xbxGqW/WrAZrRCTFB3lZSw38O4e31viIXbfi9u+Iib2e
j0oUBZmoroH6POha/udMK/FUdxTlkS8OTiUDM7K2J81L7Cz9F6k=3D
=3Da0+j
-----END PGP SIGNATURE-----
