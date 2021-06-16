Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5963A8F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFPDXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhFPDXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:23:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 790A661246;
        Wed, 16 Jun 2021 03:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623813675;
        bh=rOudsK9P7bMhTK2OtdWpKbEvj8MV63gh3o1URze326c=;
        h=From:To:Cc:Subject:Date:From;
        b=nwBg7NXU86tjS9hw+PrWm7ZikqKiel5aE9OxQyWP6my3RTBNdx0JBxZP1ybHFZVha
         DGADS6+CJMndKBo/uPWHrPN2oBys9zp8keSaitE8gY18gVL1oxe+cztsz7tFffA5U0
         i6c2B4WUjd+l086Kjx81pEmqGc997WkmFXA3e3W94t/1Ut5EOfRGFFcnLSEA6W/L/P
         R0v65CwSLI8vzQ8yWlr1LsXD+vdzEZEyZaUXdnMfv7MjKxY6XVrO97uw8oJwkaHX20
         N9AWz2jiCGJJ3DhOCZ3Tc6P/XU2HDaPjahNfW1gH72fheKST+IyGPuTDcTyUxaEM9l
         WBYYkH1LtDrMQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/8] membarrier cleanups
Date:   Tue, 15 Jun 2021 20:21:05 -0700
Message-Id: <cover.1623813516.git.luto@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

membarrier() is unnecessarily tangled with the core scheduler.  Clean it
up.  While we're at it, remove the documentation and drop the pretence that
SYNC_CORE can ever be a well-defined cross-arch operation.

Andy Lutomirski (8):
  membarrier: Document why membarrier() works
  x86/mm: Handle unlazying membarrier core sync in the arch code
  membarrier: Remove membarrier_arch_switch_mm() prototype in core code
  membarrier: Make the post-switch-mm barrier explicit
  membarrier, kthread: Use _ONCE accessors for task->mm
  powerpc/membarrier: Remove special barrier on mm switch
  membarrier: Remove arm (32) support for SYNC_CORE
  membarrier: Rewrite sync_core_before_usermode() and improve
    documentation

 .../membarrier-sync-core/arch-support.txt     | 68 +++++------------
 arch/arm/Kconfig                              |  1 -
 arch/arm64/include/asm/sync_core.h            | 19 +++++
 arch/powerpc/include/asm/membarrier.h         | 27 -------
 arch/powerpc/include/asm/sync_core.h          | 14 ++++
 arch/powerpc/mm/mmu_context.c                 |  2 -
 arch/x86/Kconfig                              |  1 -
 arch/x86/include/asm/sync_core.h              |  7 +-
 arch/x86/kernel/alternative.c                 |  2 +-
 arch/x86/kernel/cpu/mce/core.c                |  2 +-
 arch/x86/mm/tlb.c                             | 54 ++++++++++---
 drivers/misc/sgi-gru/grufault.c               |  2 +-
 drivers/misc/sgi-gru/gruhandles.c             |  2 +-
 drivers/misc/sgi-gru/grukservices.c           |  2 +-
 fs/exec.c                                     |  2 +-
 include/linux/sched/mm.h                      | 42 +++++-----
 include/linux/sync_core.h                     | 21 -----
 init/Kconfig                                  |  3 -
 kernel/kthread.c                              | 16 +---
 kernel/sched/core.c                           | 44 +++--------
 kernel/sched/membarrier.c                     | 76 +++++++++++++++++--
 21 files changed, 210 insertions(+), 197 deletions(-)
 create mode 100644 arch/arm64/include/asm/sync_core.h
 delete mode 100644 arch/powerpc/include/asm/membarrier.h
 create mode 100644 arch/powerpc/include/asm/sync_core.h
 delete mode 100644 include/linux/sync_core.h

-- 
2.31.1

