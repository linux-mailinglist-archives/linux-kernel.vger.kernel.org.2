Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677953A4856
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhFKSFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:05:54 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38615 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhFKSFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:05:44 -0400
Received: by mail-wr1-f48.google.com with SMTP id c9so6953436wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Mg8WzLcVMzfg8yKYE2XdWTm4SZXxy8KtasJdntNsY4=;
        b=A91VyNBBUsKLtwbBAfwfH0AHpM3Ffl+D5vk7eI1ceBL6f5fHnO2Lh8GXAuhuqKGGis
         Jx1ItBFahugHmsTwLvCiUmbPMcu+yIL4A8V26wmNYnLIzQ5/2q5Mz18xcT6UV6EyXaqw
         4Txbdn+D81uyUssu18+kTnBp4xG3qrHXuSWdPCVMsmDhbYdb51Yq6HXmVE1wazyxZtNq
         dxH5AaiWpKcvdpKRFkJcUjNMWB2dO2eSHLTC6E0dE1fN8MJ2gSWqLdS9iYMGgpq5mgHN
         YWpB54bzJvFv0LBZ/Hv7q9zLubCQ9KZjgX/Ikzluwdaiw0iWU6LFvbodSoiOBQKbDQ8z
         xm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Mg8WzLcVMzfg8yKYE2XdWTm4SZXxy8KtasJdntNsY4=;
        b=mLMLRCuEYandJs+zdFHarUAr5GldlVYS+2haWXeTwf5uW64wx847zzsQZU28O7/fbJ
         OlyCbpp+DXxN3fyUpU9Hleea5ihqmU3VrU9H7HF9NP4fWhLS8Vjkf8w340O2BaTITJiu
         ebwE2N6baz8/qCCkEPxGkuZuH/cYAClgm3KFhcKjGbXToh6lATSOFUPDscg+R9IGX6yq
         jF9DpfgW9hOn1nF2w9yb0SPZ2TEtdOlEP5TiiaCau+LUf8k83Drg7wJ8LvPctBnYeVB8
         9wmjiWvuNQY6KmgkJ/KGHCb7UZfZpxDTSJX3IfN2cNeXkP54AEp6vYy2BoiLE8if7230
         spEw==
X-Gm-Message-State: AOAM531hTV7aHt0p+lWxHNwEICYdXDSBQ/k7gLqgcyd9AO/oaAC5krfL
        L7Yv26+Ctjr86E6LXcKOS7INmuBcVCdCtjv/
X-Google-Smtp-Source: ABdhPJyJlEYVd+ZcgWbuzsWDwMbt7ryhaLlwhSIszcisZ9wZHqUg9j+i5Kmcewx9KydX9ZomMDi2mw==
X-Received: by 2002:adf:ab49:: with SMTP id r9mr5497736wrc.237.1623434564960;
        Fri, 11 Jun 2021 11:02:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:02:44 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: [PATCH v3 00/23] Add generic vdso_base tracking
Date:   Fri, 11 Jun 2021 19:02:19 +0100
Message-Id: <20210611180242.711399-1-dima@arista.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 Changes:
- Migrated arch/powerpc to vdso_base
- Added x86/selftest for unmapped vdso & no landing on fast syscall
- Review comments from Andy & Christophe (thanks!)
- Amended s/born process/execed process/ everywhere I noticed
- Build robot warning on cast from __user pointer

I've tested it on x86, I would appreciate any help with
Tested-by on arm/arm64/mips/powerpc/s390/... platforms.

One thing I've noticed while cooking this and haven't found a clean
way to solve is zero-terminated .pages[] array in vdso mappings, which
is not always zero-terminated but works by the reason of
VM_DONTEXPAND on mappings.

v2 Changes:
- Rename user_landing to vdso_base as it tracks vDSO VMA start address,
  rather than the explicit address to land (Andy)
- Reword and don't use "new-execed" and "new-born" task (Andy)
- Fix failures reported by build robot

Started from discussion [1], where was noted that currently a couple of
architectures support mremap() for vdso/sigpage, but not munmap().
If an application maps something on the ex-place of vdso/sigpage,
later after processing signal it will land there (good luck!)

Patches set is based on linux-next (next-20201123) and it depends on
changes in x86/cleanups (those reclaim TIF_IA32/TIF_X32) and also
on my changes in akpm (fixing several mremap() issues).

Logically, the patches set divides on:
- patch       1: a cleanup for patches in x86/cleanups
- patches  2-13: cleanups for arch_setup_additional_pages()
- patches 13-14: x86 signal changes for unmapped vdso
- patches 15-22: provide generic vdso_base in mm_struct
- patch      23: selftest for unmapped vDSO & fast syscalls

In the end, besides cleanups, it's now more predictable what happens for
applications with unmapped vdso on architectures those support .mremap()
for vdso/sigpage.

I'm aware of only one user that unmaps vdso - Valgrind [2].
(there possibly are more, but this one is "special", it unmaps vdso, but
 not vvar, which confuses CRIU [Checkpoint Restore In Userspace], that's
 why I'm aware of it)

Patches as a .git branch:
https://github.com/0x7f454c46/linux/tree/vdso_base-v3

v2 Link:
https://lore.kernel.org/lkml/20201124002932.1220517-1-dima@arista.com/
v1 Link:
https://lore.kernel.org/lkml/20201108051730.2042693-1-dima@arista.com/

[1]: https://lore.kernel.org/linux-arch/CAJwJo6ZANqYkSHbQ+3b+Fi_VT80MtrzEV5yreQAWx-L8j8x2zA@mail.gmail.com/
[2]: https://github.com/checkpoint-restore/criu/issues/488

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Guo Ren <guoren@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: x86@kernel.org

Dmitry Safonov (23):
  x86/elf: Check in_x32_syscall() in
    compat_arch_setup_additional_pages()
  elf: Move arch_setup_additional_pages() to generic elf.h
  arm/elf: Remove needless ifdef CONFIG_MMU
  arm64: Use in_compat_task() in arch_setup_additional_pages()
  x86: Remove compat_arch_setup_additional_pages()
  elf: Remove compat_arch_setup_additional_pages()
  vdso: Set mm->context.vdso only on success of
    _install_special_mapping()
  elf/vdso: Modify arch_setup_additional_pages() parameters
  elf: Use sysinfo_ehdr in ARCH_DLINFO()
  arm/vdso: Remove vdso pointer from mm->context
  s390/vdso: Remove vdso_base pointer from mm->context
  sparc/vdso: Remove vdso pointer from mm->context
  mm/mmap: Make vm_special_mapping::mremap return void
  x86/signal: Land on &frame->retcode when vdso isn't mapped
  x86/signal: Check if vdso_image_32 is mapped before trying to land on it
  mm: Add vdso_base in mm_struct
  x86/vdso: Migrate to generic vdso_base
  arm/vdso: Migrate to generic vdso_base
  arm64/vdso: Migrate compat signals to generic vdso_base
  arm64/vdso: Migrate native signals to generic vdso_base
  mips/vdso: Migrate to generic vdso_base
  powerpc/vdso: Migrate native signals to generic vdso_base
  x86/vdso/selftest: Add a test for unmapping vDSO

 arch/Kconfig                                  |   3 +
 arch/alpha/include/asm/elf.h                  |   2 +-
 arch/arm/Kconfig                              |   2 +
 arch/arm/include/asm/elf.h                    |  10 +-
 arch/arm/include/asm/mmu.h                    |   3 -
 arch/arm/include/asm/vdso.h                   |   6 +-
 arch/arm/kernel/process.c                     |  14 +-
 arch/arm/kernel/signal.c                      |   6 +-
 arch/arm/kernel/vdso.c                        |  20 +--
 arch/arm64/Kconfig                            |   2 +
 arch/arm64/include/asm/elf.h                  |  27 +---
 arch/arm64/include/asm/mmu.h                  |   4 -
 arch/arm64/kernel/signal.c                    |  10 +-
 arch/arm64/kernel/signal32.c                  |  17 +-
 arch/arm64/kernel/vdso.c                      |  72 +++------
 arch/csky/Kconfig                             |   1 +
 arch/csky/include/asm/elf.h                   |   4 -
 arch/csky/kernel/vdso.c                       |  11 +-
 arch/hexagon/Kconfig                          |   1 +
 arch/hexagon/include/asm/elf.h                |   6 -
 arch/hexagon/kernel/vdso.c                    |   3 +-
 arch/ia64/include/asm/elf.h                   |   2 +-
 arch/mips/Kconfig                             |   2 +
 arch/mips/include/asm/elf.h                   |  10 +-
 arch/mips/include/asm/mmu.h                   |   2 -
 arch/mips/kernel/signal.c                     |  11 +-
 arch/mips/kernel/vdso.c                       |   5 +-
 arch/mips/vdso/genvdso.c                      |   9 --
 arch/nds32/Kconfig                            |   1 +
 arch/nds32/include/asm/elf.h                  |   8 +-
 arch/nds32/kernel/vdso.c                      |   8 +-
 arch/nios2/Kconfig                            |   1 +
 arch/nios2/include/asm/elf.h                  |   4 -
 arch/nios2/mm/init.c                          |   2 +-
 arch/powerpc/Kconfig                          |   2 +
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |   1 -
 arch/powerpc/include/asm/book3s/64/mmu.h      |   1 -
 arch/powerpc/include/asm/elf.h                |   9 +-
 arch/powerpc/include/asm/mmu_context.h        |   9 --
 arch/powerpc/include/asm/nohash/32/mmu-40x.h  |   1 -
 arch/powerpc/include/asm/nohash/32/mmu-44x.h  |   1 -
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h  |   1 -
 arch/powerpc/include/asm/nohash/mmu-book3e.h  |   1 -
 arch/powerpc/kernel/signal_32.c               |   8 +-
 arch/powerpc/kernel/signal_64.c               |   4 +-
 arch/powerpc/kernel/vdso.c                    |  48 +-----
 arch/powerpc/perf/callchain_32.c              |   8 +-
 arch/powerpc/perf/callchain_64.c              |   4 +-
 arch/riscv/Kconfig                            |   1 +
 arch/riscv/include/asm/elf.h                  |   9 +-
 arch/riscv/kernel/vdso.c                      |  11 +-
 arch/s390/Kconfig                             |   1 +
 arch/s390/include/asm/elf.h                   |  10 +-
 arch/s390/include/asm/mmu.h                   |   1 -
 arch/s390/kernel/vdso.c                       |  12 +-
 arch/sh/Kconfig                               |   1 +
 arch/sh/include/asm/elf.h                     |  16 +-
 arch/sh/kernel/vsyscall/vsyscall.c            |   3 +-
 arch/sparc/Kconfig                            |   1 +
 arch/sparc/include/asm/elf_64.h               |  11 +-
 arch/sparc/include/asm/mmu_64.h               |   1 -
 arch/sparc/vdso/vma.c                         |  20 +--
 arch/x86/Kconfig                              |   2 +
 arch/x86/entry/common.c                       |  10 +-
 arch/x86/entry/vdso/extable.c                 |   4 +-
 arch/x86/entry/vdso/vma.c                     |  79 ++++-----
 arch/x86/ia32/ia32_signal.c                   |  18 ++-
 arch/x86/include/asm/compat.h                 |   6 +
 arch/x86/include/asm/elf.h                    |  44 ++---
 arch/x86/include/asm/mmu.h                    |   1 -
 arch/x86/include/asm/mmu_context.h            |   5 -
 arch/x86/include/asm/vdso.h                   |   4 +
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |   3 +-
 arch/x86/kernel/signal.c                      |  25 ++-
 arch/x86/um/asm/elf.h                         |   9 +-
 arch/x86/um/vdso/vma.c                        |   2 +-
 fs/Kconfig.binfmt                             |   3 +
 fs/aio.c                                      |   3 +-
 fs/binfmt_elf.c                               |  19 ++-
 fs/binfmt_elf_fdpic.c                         |  17 +-
 fs/compat_binfmt_elf.c                        |  12 --
 include/asm-generic/mm_hooks.h                |   9 +-
 include/linux/elf.h                           |  24 ++-
 include/linux/mm.h                            |   3 +-
 include/linux/mm_types.h                      |  21 ++-
 kernel/fork.c                                 |   1 +
 mm/mmap.c                                     |  28 ++--
 mm/mremap.c                                   |   2 +-
 tools/testing/selftests/x86/.gitignore        |   1 +
 tools/testing/selftests/x86/Makefile          |  11 +-
 .../testing/selftests/x86/test_munmap_vdso.c  | 151 ++++++++++++++++++
 91 files changed, 511 insertions(+), 491 deletions(-)
 create mode 100644 tools/testing/selftests/x86/test_munmap_vdso.c


base-commit: 614124bea77e452aa6df7a8714e8bc820b489922
-- 
2.31.1

