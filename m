Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E29D30E39A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhBCTxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:53:39 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:59800 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhBCTxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:53:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 50A526083244;
        Wed,  3 Feb 2021 20:52:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cXrZbyZxHfBm; Wed,  3 Feb 2021 20:52:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E408A608A38F;
        Wed,  3 Feb 2021 20:52:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Gncwla61AYgT; Wed,  3 Feb 2021 20:52:54 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C07B76083244;
        Wed,  3 Feb 2021 20:52:54 +0100 (CET)
Date:   Wed, 3 Feb 2021 20:52:54 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2021686242.358980.1612381974638.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML fixes for 5.11-rc7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: 826gqyiALhpUoxwWQydY83QpX/Pnfg==
Thread-Topic: UML fixes for 5.11-rc7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 4992eb41ab1b5d08479193afdc94f9678e5ded13:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2021-01-26 11:10:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.11-rc7

for you to fetch changes up to 7f3414226b58b0df0426104c8ab5e8d50ae71d11:

  um: time: fix initialization in time-travel mode (2021-01-26 22:11:38 +0100)

----------------------------------------------------------------
This pull request contains the following bug fixes for UML:

- Make sure to set a default console, otherwise ttynull is selected.
- Revert initial ARCH_HAS_SET_MEMORY support, this needs more work.
- Fix a regression due to ubd refactoring.
- Various small fixes.

----------------------------------------------------------------
Hajime Tazaki (1):
      um: ubd: fix command line handling of ubd

Johannes Berg (6):
      um: return error from ioremap()
      um: virtio: free vu_dev only with the contained struct device
      Revert "um: allocate a guard page to helper threads"
      Revert "um: support some of ARCH_HAS_SET_MEMORY"
      um: fix os_idle_sleep() to not hang
      um: time: fix initialization in time-travel mode

Thomas Meyer (2):
      um: stdio_console: Make preferred console
      um: kmsg_dumper: always dump when not tty console

 arch/um/Kconfig                    |  1 -
 arch/um/drivers/ubd_kern.c         |  6 ++---
 arch/um/drivers/virtio_uml.c       |  3 ++-
 arch/um/include/asm/io.h           |  2 +-
 arch/um/include/asm/pgtable.h      |  3 ---
 arch/um/include/asm/set_memory.h   |  1 -
 arch/um/include/shared/kern_util.h |  2 +-
 arch/um/kernel/kmsg_dump.c         |  9 +++++--
 arch/um/kernel/process.c           | 11 +++-----
 arch/um/kernel/time.c              | 50 +++++++++++++++++++++--------------
 arch/um/kernel/tlb.c               | 54 --------------------------------------
 arch/um/kernel/um_arch.c           | 22 +++++++++++++---
 arch/um/os-Linux/helper.c          |  4 +--
 arch/um/os-Linux/time.c            | 15 ++++++++++-
 14 files changed, 84 insertions(+), 99 deletions(-)
 delete mode 100644 arch/um/include/asm/set_memory.h
