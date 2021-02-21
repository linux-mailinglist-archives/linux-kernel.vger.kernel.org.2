Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C874320D5D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhBUUDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 15:03:08 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:48506 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhBUUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:03:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1A58D60A3587;
        Sun, 21 Feb 2021 21:02:22 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id k69zyif8DZWs; Sun, 21 Feb 2021 21:02:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B584C60A3592;
        Sun, 21 Feb 2021 21:02:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m67_rH2fde5z; Sun, 21 Feb 2021 21:02:21 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id A1F2C60A3587;
        Sun, 21 Feb 2021 21:02:21 +0100 (CET)
Date:   Sun, 21 Feb 2021 21:02:21 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1264486228.14901.1613937741621.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for 5.12
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: mHBkGFFNnr0R+r7J/8sHQfwiLkZ7xQ==
Thread-Topic: UML changes for 5.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linux-5.12-rc1

for you to fetch changes up to ddad5187fc2a12cb84c9d1ac8ecb816708a2986b:

  um: irq.h: include <asm-generic/irq.h> (2021-02-12 21:40:14 +0100)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Many cleanups and fixes for our virtio code
- Add support for a pseudo RTC
- Fix for a possible jailbreak
- Minor fixes (spelling, header files)

----------------------------------------------------------------
Christophe Leroy (1):
      mm: Remove arch_remap() and mm-arch-hooks.h

Colin Ian King (1):
      um: fix spelling mistake in Kconfig "privleges" -> "privileges"

Johannes Berg (15):
      um: virtio: clean up a comment
      um: virtio: fix handling of messages without payload
      um: virtio: disable VQs during suspend
      um: time-travel: rework interrupt handling in ext mode
      um: virtio: allow devices to be configured for wakeup
      um: hostfs: use a kmem cache for inodes
      um: print register names in wait_for_stub
      um: mm: check more comprehensively for stub changes
      um: defer killing userspace on page table update failures
      um: separate child and parent errors in clone stub
      um: rework userspace stubs to not hard-code stub location
      um: remove process stub VMA
      um: add a pseudo RTC
      um: io.h: include <linux/types.h>
      um: irq.h: include <asm-generic/irq.h>

 arch/um/drivers/Kconfig                 |  13 +-
 arch/um/drivers/Makefile                |   2 +
 arch/um/drivers/rtc.h                   |  15 +++
 arch/um/drivers/rtc_kern.c              | 211 ++++++++++++++++++++++++++++++++
 arch/um/drivers/rtc_user.c              |  80 ++++++++++++
 arch/um/drivers/virtio_uml.c            | 145 +++++++++++++++-------
 arch/um/include/asm/Kbuild              |   2 +-
 arch/um/include/asm/io.h                |   1 +
 arch/um/include/asm/irq.h               |   1 +
 arch/um/include/asm/mmu_context.h       |  29 +----
 arch/um/include/linux/time-internal.h   |  17 +++
 arch/um/include/shared/as-layout.h      |  17 +--
 arch/um/include/shared/common-offsets.h |   6 +
 arch/um/include/shared/irq_kern.h       |  60 +++++++++
 arch/um/include/shared/skas/mm_id.h     |   1 +
 arch/um/include/shared/skas/stub-data.h |   2 +-
 arch/um/kernel/exec.c                   |   4 +-
 arch/um/kernel/irq.c                    | 171 ++++++++++++++++++++++----
 arch/um/kernel/skas/clone.c             |  28 ++---
 arch/um/kernel/skas/mmu.c               |  87 -------------
 arch/um/kernel/time.c                   |  17 ++-
 arch/um/kernel/tlb.c                    |  14 +--
 arch/um/kernel/um_arch.c                |   5 +
 arch/um/os-Linux/skas/mem.c             |   2 +
 arch/um/os-Linux/skas/process.c         |  86 ++++++++++---
 arch/x86/um/os-Linux/task_size.c        |   2 +-
 arch/x86/um/shared/sysdep/stub_32.h     |  33 +++--
 arch/x86/um/shared/sysdep/stub_64.h     |  36 ++++--
 arch/x86/um/stub_32.S                   |  17 ++-
 arch/x86/um/stub_64.S                   |   5 +-
 arch/x86/um/stub_segv.c                 |   5 +-
 fs/hostfs/hostfs_kern.c                 |  10 +-
 include/asm-generic/Kbuild              |   1 -
 include/asm-generic/mm-arch-hooks.h     |  16 ---
 include/linux/mm-arch-hooks.h           |  22 ----
 mm/mremap.c                             |   3 -
 36 files changed, 841 insertions(+), 325 deletions(-)
 create mode 100644 arch/um/drivers/rtc.h
 create mode 100644 arch/um/drivers/rtc_kern.c
 create mode 100644 arch/um/drivers/rtc_user.c
 delete mode 100644 include/asm-generic/mm-arch-hooks.h
 delete mode 100644 include/linux/mm-arch-hooks.h
