Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A134075BF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbhIKJXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 05:23:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhIKJXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 05:23:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74DD260F9D;
        Sat, 11 Sep 2021 09:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631352117;
        bh=rLs6lXO4ezLXi1eMDGtuAGxJsksCVO9gqYP0VT8AEb0=;
        h=From:To:Cc:Subject:Date:From;
        b=VdNXLhQ/7cpD/rchd5lgkiUVZc/YpZPes8flZgcn0HwgdZkG6jYWNywM6XovNp4me
         KdI5jc9ghU0lE2x4sC9BHrltJiVFgA1PEV0RWYoeoXHfJIAxECbbCvGnYgqm1BKXhw
         XR+0dY0S5WRNT0KIGHU/Q4TTgGCC0tJ6qoG4R/I6bLmLrMYjFSIiUlqGh27SAQ0sMF
         gsvTZ1VPxXiFuZE9HFb6xty3N+Cpn6cbh6MbWkx9PguQ2jM4QZM157oIrHkFyLaY4n
         ojYw7F6FC/CN3SlLtB/f6RTYKRg2D8wsbValeeuw8A6CL+2tHkcZh0gL6EIBrvfbRb
         ta4Zu8MYAM4bw==
From:   guoren@kernel.org
To:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, hch@lst.de, liush@allwinnertech.com,
        wefu@redhat.com, lazyparser@gmail.com, drew@beagleboard.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V4 0/6] riscv: Add PBMT & DMA for D1 bringup
Date:   Sat, 11 Sep 2021 17:21:33 +0800
Message-Id: <20210911092139.79607-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

These patches are a continuation of "riscv: Add DMA_COHERENT support for
Allwinner D1". In this version, we rebase on Atish's Global dma pool
patchset, and it has been tested on qemu and our hardware platforms.
But we append "select DMA_DIRECT_REMAP" in RISCV_DMA_NONCOHERENT, so not
sure it would affect Atish's hardware platform.

We still use riscv_dma_cache_sync_set, not the alternative code. I agree
the alternative framework is better for performance in dma ops. Maybe
Atish's next version of the patch would use it.

The custom PBMT implementation is moved into errata and add
apply_errata_setup_vm() in setup_vm prologue. Hope it could be approved.

You can follow the D1 fedora wiki[1], try the latest kernel with the
patchset.
[1] https://fedoraproject.org/wiki/Architectures/RISC-V/Allwinner#Build_Linux_Kernel_for_D1

Previous versions:
V3: https://lore.kernel.org/linux-riscv/1623693067-53886-1-git-send-email-guoren@kernel.org/
V2: https://lore.kernel.org/linux-riscv/1622970249-50770-10-git-send-email-guoren@kernel.org/
V1: https://lore.kernel.org/linux-riscv/1621400656-25678-3-git-send-email-guoren@kernel.org/

Atish Patra (2):
  RISC-V: Support a new config option for non-coherent DMA
  RISC-V: Implement arch_sync_dma* functions

Guo Ren (3):
  riscv: pgtable: Add custom protection_map init
  riscv: errata: pgtable: Add custom Svpbmt supported for Allwinner D1
  riscv: errata: Support T-HEAD custom dcache ops

Liu Shaohua (1):
  riscv: soc: Add Allwinner SoC kconfig option

 arch/riscv/Kconfig                       |  13 +++
 arch/riscv/Kconfig.erratas               |  11 +++
 arch/riscv/Kconfig.socs                  |  15 ++++
 arch/riscv/configs/defconfig             |   1 +
 arch/riscv/errata/Makefile               |   1 +
 arch/riscv/errata/alternative.c          |  23 +++++
 arch/riscv/errata/thead/Makefile         |   1 +
 arch/riscv/errata/thead/errata.c         | 108 +++++++++++++++++++++++
 arch/riscv/include/asm/alternative.h     |   4 +
 arch/riscv/include/asm/dma-noncoherent.h |  19 ++++
 arch/riscv/include/asm/fixmap.h          |   2 +-
 arch/riscv/include/asm/pgtable-64.h      |   8 +-
 arch/riscv/include/asm/pgtable-bits.h    |  46 +++++++++-
 arch/riscv/include/asm/pgtable.h         |  30 ++++---
 arch/riscv/include/asm/vendorid_list.h   |   1 +
 arch/riscv/mm/Makefile                   |   1 +
 arch/riscv/mm/dma-noncoherent.c          |  66 ++++++++++++++
 arch/riscv/mm/init.c                     |  28 ++++++
 mm/mmap.c                                |   4 +
 19 files changed, 366 insertions(+), 16 deletions(-)
 create mode 100644 arch/riscv/errata/thead/Makefile
 create mode 100644 arch/riscv/errata/thead/errata.c
 create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
 create mode 100644 arch/riscv/mm/dma-noncoherent.c

-- 
2.25.1

