Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC33C1AD6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 23:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhGHVMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 17:12:42 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:45284 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhGHVMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 17:12:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5CED961BC7CF;
        Thu,  8 Jul 2021 23:09:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EeDYST1kiou4; Thu,  8 Jul 2021 23:09:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D187361BC7D4;
        Thu,  8 Jul 2021 23:09:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QBJ6jrR1G8Fc; Thu,  8 Jul 2021 23:09:57 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id A855661BC7CF;
        Thu,  8 Jul 2021 23:09:57 +0200 (CEST)
Date:   Thu, 8 Jul 2021 23:09:57 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <62640125.4933.1625778597465.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for 5.14
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: gYSse3P0dfpzt5m4VoMpJqkdzyrdDA==
Thread-Topic: UML changes for 5.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.14-rc1

for you to fetch changes up to 1aee020155f364ef538370d3392969f1077b9bae:

  um: remove unneeded semicolon in um_arch.c (2021-06-19 10:02:50 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Support for optimized routines based on the host CPU
- Support for PCI via virtio
- Various fixes

----------------------------------------------------------------
Anton Ivanov (3):
      um: Add support for host CPU flags and alignment
      um: enable the use of optimized xor routines in UML
      um: add a UML specific futex implementation

Johannes Berg (11):
      um: allow disabling NO_IOMEM
      lib: add iomem emulation (logic_iomem)
      um: remove unused smp_sigio_handler() declaration
      um: export signals_enabled directly
      um: expose time-travel mode to userspace side
      um: time-travel/signals: fix ndelay() in interrupt
      um: irqs: allow invoking time-travel handler multiple times
      um: add PCI over virtio emulation driver
      um: virtio/pci: enable suspend/resume
      um: allow not setting extra rpaths in the linux binary
      um: implement flush_cache_vmap/flush_cache_vunmap

Shaokun Zhang (1):
      um: Remove the repeated declaration

Wan Jiabing (1):
      um: remove unneeded semicolon in um_arch.c

YiFei Zhu (1):
      um: Fix stack pointer alignment

Zhen Lei (2):
      um: fix error return code in slip_open()
      um: fix error return code in winch_tramp()

 arch/um/Kconfig                         |  33 +-
 arch/um/Makefile                        |   3 +-
 arch/um/drivers/Kconfig                 |  20 +
 arch/um/drivers/Makefile                |   1 +
 arch/um/drivers/chan_user.c             |   3 +-
 arch/um/drivers/slip_user.c             |   3 +-
 arch/um/drivers/ubd_kern.c              |   3 +-
 arch/um/drivers/virt-pci.c              | 895 ++++++++++++++++++++++++++++++++
 arch/um/drivers/virtio_uml.c            |  40 +-
 arch/um/include/asm/Kbuild              |   4 +-
 arch/um/include/asm/cacheflush.h        |   9 +
 arch/um/include/asm/cpufeature.h        | 157 ++++++
 arch/um/include/asm/fpu/api.h           |  20 +
 arch/um/include/asm/futex.h             |  14 +
 arch/um/include/asm/io.h                |   7 +
 arch/um/include/asm/irq.h               |   8 +-
 arch/um/include/asm/irqflags.h          |  10 +-
 arch/um/include/asm/msi.h               |   1 +
 arch/um/include/asm/pci.h               |  39 ++
 arch/um/include/asm/processor-generic.h |   8 +
 arch/um/include/asm/tlb.h               |   2 +-
 arch/um/include/asm/xor.h               |  17 +-
 arch/um/include/linux/time-internal.h   |  12 +-
 arch/um/include/linux/virtio-uml.h      |  13 +
 arch/um/include/shared/irq_user.h       |   1 +
 arch/um/include/shared/kern_util.h      |   1 -
 arch/um/include/shared/longjmp.h        |  14 +-
 arch/um/include/shared/os.h             |   8 +-
 arch/um/include/shared/timetravel.h     |  22 +
 arch/um/kernel/Makefile                 |  14 +-
 arch/um/kernel/ioport.c                 |  13 +
 arch/um/kernel/irq.c                    |  52 +-
 arch/um/kernel/ksyms.c                  |   2 +-
 arch/um/kernel/skas/clone.c             |   2 +-
 arch/um/kernel/skas/uaccess.c           | 136 +++++
 arch/um/kernel/time.c                   |  35 +-
 arch/um/kernel/um_arch.c                |  48 +-
 arch/um/os-Linux/helper.c               |   4 +-
 arch/um/os-Linux/signal.c               |  64 ++-
 arch/um/os-Linux/skas/process.c         |   2 +-
 arch/um/os-Linux/start_up.c             |  32 ++
 arch/x86/Makefile.um                    |   2 +-
 drivers/input/Kconfig                   |   1 -
 drivers/input/gameport/Kconfig          |   1 +
 drivers/input/joystick/Kconfig          |   1 +
 drivers/tty/Kconfig                     |   5 +-
 drivers/video/console/Kconfig           |   2 +-
 include/asm-generic/logic_io.h          |  78 +++
 include/linux/logic_iomem.h             |  62 +++
 include/uapi/linux/virtio_pcidev.h      |  64 +++
 lib/Kconfig                             |  14 +
 lib/Makefile                            |   2 +
 lib/logic_iomem.c                       | 318 ++++++++++++
 53 files changed, 2211 insertions(+), 111 deletions(-)
 create mode 100644 arch/um/drivers/virt-pci.c
 create mode 100644 arch/um/include/asm/cacheflush.h
 create mode 100644 arch/um/include/asm/cpufeature.h
 create mode 100644 arch/um/include/asm/fpu/api.h
 create mode 100644 arch/um/include/asm/futex.h
 create mode 100644 arch/um/include/asm/msi.h
 create mode 100644 arch/um/include/asm/pci.h
 create mode 100644 arch/um/include/linux/virtio-uml.h
 create mode 100644 arch/um/include/shared/timetravel.h
 create mode 100644 arch/um/kernel/ioport.c
 create mode 100644 include/asm-generic/logic_io.h
 create mode 100644 include/linux/logic_iomem.h
 create mode 100644 include/uapi/linux/virtio_pcidev.h
 create mode 100644 lib/logic_iomem.c
