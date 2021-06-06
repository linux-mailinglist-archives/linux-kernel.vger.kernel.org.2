Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1071139CF2D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFFMrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhFFMqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:46:19 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270E8C06178B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:44:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FybmS6nDJz9sXb;
        Sun,  6 Jun 2021 22:44:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1622983466;
        bh=X/hDMXOgYJINlaXQahFoL+S/LpzpX4FSL3A6BglVdDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=n3yPlr568lok+2V//9qJlKn05LsC8V0JDVQ15IycQ29mbRLiT7e3CHNWZtYCHnLZh
         oOyaeWLO3pQu9FxPyF2XkEqk1kxV52cIbeYAyaZBWgW+VscIQh3nrqUDX7QDixzsVG
         HomIRlpTb0z7NUqBZvd/1EKmX5ewbgU8gdyibPTO0z8iz+tbLVHSXxkK1ewrOHDqF+
         m0vrWj10Wyyn4lX08YNAWJZ5aMp+70FQRob2RCXOIs4irzB0pCaTNSv4HA0flsTPqO
         JUxhazrOQzqGZAIWOM3iKZiH1SN45GHQ0xv1E3JHRT0iZjufv//ZkhSFzSSuTAjYPJ
         86/H1eY8G5tIg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     fbarrat@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com,
        npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.13-5 tag
Date:   Sun, 06 Jun 2021 22:44:24 +1000
Message-ID: <87fsxvf9hz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.13:

The following changes since commit d72500f992849d31ebae8f821a023660ddd0dcc2:

  powerpc/64s/syscall: Fix ptrace syscall info with scv syscalls (2021-05-21 00:58:56 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-5

for you to fetch changes up to 59cc84c802eb923805e7bba425976a3df5ce35d8:

  Revert "powerpc/kernel/iommu: Align size for IOMMU_PAGE_SIZE() to save TCEs" (2021-06-01 11:17:08 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.13 #5

Fix our KVM reverse map real-mode handling since we enabled huge vmalloc (in some
configurations).

Revert a recent change to our IOMMU code which broke some devices.

Fix KVM handling of FSCR on P7/P8, which could have possibly let a guest crash it's Qemu.

Fix kprobes validation of prefixed instructions across page boundary.

Thanks to: Alexey Kardashevskiy, Christophe Leroy, Fabiano Rosas, Frederic Barrat, Naveen
N. Rao, Nicholas Piggin.

- ------------------------------------------------------------------
Frederic Barrat (1):
      Revert "powerpc/kernel/iommu: Align size for IOMMU_PAGE_SIZE() to save TCEs"

Naveen N. Rao (1):
      powerpc/kprobes: Fix validation of prefixed instructions across page boundary

Nicholas Piggin (2):
      powerpc: Fix reverse map real-mode address lookup with huge vmalloc
      KVM: PPC: Book3S HV: Save host FSCR in the P7/8 path


 arch/powerpc/include/asm/pte-walk.h     | 29 ++++++++++++++++++++
 arch/powerpc/kernel/eeh.c               | 23 +---------------
 arch/powerpc/kernel/io-workarounds.c    | 16 ++---------
 arch/powerpc/kernel/iommu.c             | 11 ++++----
 arch/powerpc/kernel/kprobes.c           |  4 +--
 arch/powerpc/kvm/book3s_hv.c            |  1 -
 arch/powerpc/kvm/book3s_hv_rm_mmu.c     | 15 ++--------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |  7 +++++
 8 files changed, 49 insertions(+), 57 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmC8wv4ACgkQUevqPMjh
pYDyIw/8C5X6YwKf+jM18S08wUfAy9BdnH79SNM4uANdYkpgduv8joMyjpoDs4Tv
I0LH0vx1QybGO8sJwOZJfGTrb5iQtZIBoZUtWoKZWFLsX8s6ltxh7Cv6skP3GfgK
YFrQirUtnOoi7xbgILkofklKCriRYdy0ww5+VqoNRk6WqWecRGhXtr17z3KNluTs
9Mt/7uWT275/XFd1IUzHFJfV/vkGnWTQD5N5sx/K9YxlIye/LdGb2o3FzLGr2jyB
SMHSS7cevNyl4chM5AaFAGs7WZygLFZmScDdR0jEh9oipk77puQnGvwTk9GcZVQL
Vy5tneHjWiKg0PbgWmuPWk3XfsgtoBGrpqsk2Guj23qOWolxhZ1DlpgO5+MRXXVm
0GLOJzbzR3Tf5NgsRxaGN2kjFuexyxawVJc1w8cM98QPAPYBIHIdHSjX9LIq/iW0
mXYWag1/etDQGmWgkKpun0aVRU2VH3pLejyRqwRT2ZZYm1Zo8Lsz21eDBoD+8jCV
pwOcB44F0jz4+13cjtyYcWfln34I4ex0pumrc0pGVF+6tfDPWJI8JXihORNrcUhn
KwZKkCZaqAMskiaNDyFS/45vWsYAevQdh74rVYG1Ad1yTXz9naY2t4ryOFB01DLh
H5pwoan6sdHt97C9SCI35oTC+W0cv/qEVv0fyJl0oH8U/QlKSJo=
=K09P
-----END PGP SIGNATURE-----
