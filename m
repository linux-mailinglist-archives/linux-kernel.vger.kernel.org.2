Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38E844AF75
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 15:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbhKIObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 09:31:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33858 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhKIObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 09:31:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C07831FD58;
        Tue,  9 Nov 2021 14:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636468099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=29iIuoXhjXzZm+Edp5wA7tp91R6v1sniaJVft+boKZ8=;
        b=tL+XRcJWpxS/DkFYk4/IO4PF+bBYpuR64igPpRSBlQqIGMA3HVSo1EhQEQCljurIrqPmvj
        DBiWB2DI5Xh5Ctdgpi8+x/QNXbSGF3lUxqNQ4hlotpY4njeACTPnnvCrif7KjfMnwH2dvS
        rNSv9R8e7JUCQTqe+jscNp3203pPn6U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BA4213A1F;
        Tue,  9 Nov 2021 14:28:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F7KGJIOFimE1dgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 09 Nov 2021 14:28:19 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.16-rc1
Date:   Tue,  9 Nov 2021 15:28:19 +0100
Message-Id: <20211109142819.24428-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.16b-rc1-tag

xen: branch for v5.16-rc1

It contains the following patches:

- a series for speeding up the boot of Xen PV guests

- some cleanups in Xen related code

- replacement of license texts with the appropriate SPDX headers and
  fixing of wrong SPDX headers in Xen header files

- a small series making paravirtualized interrupt masking much simpler
  and at the same time removing complaints of objtool

- a fix for Xen ballooning hogging workqueues for too long

- enablement of the Xen pciback driver for Arm

- some further small fixes/enhancements


Thanks.

Juergen

 Documentation/admin-guide/kernel-parameters.txt |   7 +
 arch/arm/xen/enlighten.c                        |   1 -
 arch/arm/xen/hypercall.S                        |   1 -
 arch/arm64/xen/hypercall.S                      |   1 -
 arch/x86/include/asm/paravirt_types.h           |   2 +
 arch/x86/include/asm/xen/hypercall.h            | 233 +++++++++++-------------
 arch/x86/include/asm/xen/hypervisor.h           |   4 +
 arch/x86/include/asm/xen/pci.h                  |  19 --
 arch/x86/kernel/paravirt.c                      |  13 +-
 arch/x86/pci/xen.c                              |  76 +-------
 arch/x86/xen/enlighten.c                        | 116 +++---------
 arch/x86/xen/enlighten_hvm.c                    |   6 +-
 arch/x86/xen/enlighten_pv.c                     |  35 +---
 arch/x86/xen/irq.c                              |  62 +------
 arch/x86/xen/mmu_pv.c                           |  52 ++++--
 arch/x86/xen/setup.c                            |  10 +-
 arch/x86/xen/smp.c                              |  28 ---
 arch/x86/xen/smp_pv.c                           |   2 -
 arch/x86/xen/xen-head.S                         |  12 +-
 arch/x86/xen/xen-ops.h                          |   4 +-
 drivers/xen/Kconfig                             |  24 +++
 drivers/xen/Makefile                            |   2 +-
 drivers/xen/balloon.c                           | 113 ++++++++----
 drivers/xen/mem-reservation.c                   |  27 +--
 drivers/xen/pci.c                               |  76 ++++++++
 drivers/xen/pvcalls-back.c                      |   1 -
 drivers/xen/xen-acpi-processor.c                |   6 +-
 drivers/xen/xen-pciback/Makefile                |   7 +
 drivers/xen/xen-pciback/conf_space_capability.c |   2 +-
 drivers/xen/xen-pciback/conf_space_header.c     |   8 +-
 drivers/xen/xen-pciback/pci_stub.c              |   3 +-
 drivers/xen/xen-pciback/pciback.h               |   5 +
 drivers/xen/xen-pciback/xenbus.c                |   8 +-
 include/xen/arm/hypercall.h                     |  15 --
 include/xen/balloon.h                           |   3 -
 include/xen/interface/callback.h                |  19 +-
 include/xen/interface/elfnote.h                 |  19 +-
 include/xen/interface/event_channel.h           |   2 +-
 include/xen/interface/features.h                |   2 +-
 include/xen/interface/grant_table.h             |  19 +-
 include/xen/interface/hvm/dm_op.h               |  19 +-
 include/xen/interface/hvm/hvm_op.h              |  20 +-
 include/xen/interface/hvm/hvm_vcpu.h            |  19 +-
 include/xen/interface/hvm/params.h              |  20 +-
 include/xen/interface/hvm/start_info.h          |  19 +-
 include/xen/interface/io/9pfs.h                 |  19 +-
 include/xen/interface/io/blkif.h                |   2 +-
 include/xen/interface/io/console.h              |   2 +-
 include/xen/interface/io/displif.h              |  19 +-
 include/xen/interface/io/fbif.h                 |  19 +-
 include/xen/interface/io/kbdif.h                |  19 +-
 include/xen/interface/io/netif.h                |  19 +-
 include/xen/interface/io/pciif.h                |  19 +-
 include/xen/interface/io/protocols.h            |   2 +-
 include/xen/interface/io/pvcalls.h              |   2 +
 include/xen/interface/io/ring.h                 |  19 +-
 include/xen/interface/io/sndif.h                |  19 +-
 include/xen/interface/io/vscsiif.h              |  19 +-
 include/xen/interface/io/xenbus.h               |   2 +-
 include/xen/interface/io/xs_wire.h              |   2 +-
 include/xen/interface/memory.h                  |   2 +-
 include/xen/interface/nmi.h                     |   2 +-
 include/xen/interface/physdev.h                 |  20 +-
 include/xen/interface/platform.h                |  19 +-
 include/xen/interface/sched.h                   |  19 +-
 include/xen/interface/vcpu.h                    |  19 +-
 include/xen/interface/version.h                 |   2 +-
 include/xen/interface/xen-mca.h                 |   1 +
 include/xen/interface/xen.h                     |  19 +-
 include/xen/interface/xenpmu.h                  |   2 +-
 include/xen/pci.h                               |  28 +++
 include/xen/xen.h                               |   6 -
 72 files changed, 496 insertions(+), 968 deletions(-)

Arnd Bergmann (1):
      xen/balloon: fix unused-variable warning

Christophe JAILLET (1):
      xen/pvcalls-back: Remove redundant 'flush_workqueue()' calls

Jan Beulich (6):
      xen/x86: streamline set_pte_mfn()
      xen/x86: restore (fix) xen_set_pte_init() behavior
      xen/x86: adjust xen_set_fixmap()
      xen/x86: adjust handling of the L3 user vsyscall special page table
      xen/x86: there's no highmem anymore in PV mode
      xen/x86: restrict PV Dom0 identity mapping

Jiasheng Jiang (1):
      xen: Fix implicit type conversion

Juergen Gross (10):
      xen: fix wrong SPDX headers of Xen related headers
      x86/pvh: add prototype for xen_pvh_init()
      x86/xen: remove xen_have_vcpu_info_placement flag
      x86/xen: switch initial pvops IRQ functions to dummy ones
      x86/xen: remove 32-bit pv leftovers
      xen: allow pv-only hypercalls only with CONFIG_XEN_PV
      xen: remove highmem remnants
      x86/xen: remove 32-bit awareness from startup_xen
      xen/balloon: add late_initcall_sync() for initial ballooning done
      xen/balloon: rename alloc/free_xenballooned_pages

Oleksandr Andrushchenko (1):
      xen-pciback: allow compiling on other archs than x86

Thomas Gleixner (1):
      x86/xen: Remove redundant irq_enter/exit() invocations

YueHaibing (1):
      xen-pciback: Fix return in pm_ctrl_init()
