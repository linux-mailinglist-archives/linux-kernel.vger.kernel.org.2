Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2426B381D63
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 10:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhEPIZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 04:25:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:50360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230040AbhEPIZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 04:25:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C093EAC4B;
        Sun, 16 May 2021 08:23:54 +0000 (UTC)
Date:   Sun, 16 May 2021 10:23:42 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.13-rc2
Message-ID: <YKDWjnjRglMNfFCN@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here's the x86/urgent lineup for v5.13-rc2.

Well, so the three SEV commits are not really urgent material. But we
figured since getting them in now will avoid a huge amount of conflicts
between future SEV changes touching tip, the kvm and probably other
trees, sending them to you now would be best. The idea is that the
tip, kvm etc branches for 5.14 will all base ontop of -rc2 and thus
everything will be peachy.

What is more, those changes are purely mechanical and defines movement
so they should be fine to go now (famous last words).

But, if you consider that too risky at this moment, I can always do a
common, immutable tip branch which we all can merge. Former's cleaner,
of course, but I could be missing an important aspect so whatever you
say - I'm game.

Please pull,
thx.

---

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13_rc2

for you to fetch changes up to a554e740b66a83c7560b30e6b50bece37555ced3:

  x86/boot/compressed: Enable -Wundef (2021-05-12 21:39:56 +0200)

----------------------------------------------------------------
- Enable -Wundef for the compressed kernel build stage

- Reorganize SEV code to streamline and simplify future development

----------------------------------------------------------------
Brijesh Singh (3):
      x86/sev-es: Rename sev-es.{ch} to sev.{ch}
      x86/sev: Move GHCB MSR protocol and NAE definitions in a common header
      x86/msr: Rename MSR_K8_SYSCFG to MSR_AMD64_SYSCFG

Nick Desaulniers (1):
      x86/boot/compressed: Enable -Wundef

 Documentation/virt/kvm/amd-memory-encryption.rst  |  2 +-
 Documentation/x86/amd-memory-encryption.rst       |  6 +--
 arch/x86/boot/compressed/Makefile                 |  7 +--
 arch/x86/boot/compressed/misc.c                   |  2 +-
 arch/x86/boot/compressed/misc.h                   |  2 +-
 arch/x86/boot/compressed/{sev-es.c => sev.c}      |  4 +-
 arch/x86/include/asm/msr-index.h                  |  6 +--
 arch/x86/include/asm/sev-common.h                 | 62 +++++++++++++++++++++++
 arch/x86/include/asm/{sev-es.h => sev.h}          | 30 ++---------
 arch/x86/kernel/Makefile                          |  6 +--
 arch/x86/kernel/cpu/amd.c                         |  4 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c                |  2 +-
 arch/x86/kernel/cpu/mtrr/generic.c                |  4 +-
 arch/x86/kernel/head64.c                          |  2 +-
 arch/x86/kernel/mmconf-fam10h_64.c                |  2 +-
 arch/x86/kernel/nmi.c                             |  2 +-
 arch/x86/kernel/{sev-es-shared.c => sev-shared.c} | 20 ++++----
 arch/x86/kernel/{sev-es.c => sev.c}               |  4 +-
 arch/x86/kvm/svm/svm.c                            |  4 +-
 arch/x86/kvm/svm/svm.h                            | 38 ++------------
 arch/x86/kvm/x86.c                                |  2 +-
 arch/x86/mm/extable.c                             |  2 +-
 arch/x86/mm/mem_encrypt_identity.c                |  6 +--
 arch/x86/pci/amd_bus.c                            |  2 +-
 arch/x86/platform/efi/efi_64.c                    |  2 +-
 arch/x86/realmode/init.c                          |  2 +-
 arch/x86/realmode/rm/trampoline_64.S              |  4 +-
 drivers/edac/amd64_edac.c                         |  2 +-
 tools/arch/x86/include/asm/msr-index.h            |  6 +--
 29 files changed, 124 insertions(+), 113 deletions(-)
 rename arch/x86/boot/compressed/{sev-es.c => sev.c} (98%)
 create mode 100644 arch/x86/include/asm/sev-common.h
 rename arch/x86/include/asm/{sev-es.h => sev.h} (70%)
 rename arch/x86/kernel/{sev-es-shared.c => sev-shared.c} (96%)
 rename arch/x86/kernel/{sev-es.c => sev.c} (99%)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
