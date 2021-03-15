Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3F833B3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhCONUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:20:49 -0400
Received: from foss.arm.com ([217.140.110.172]:39862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhCONU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:20:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B64C1FB;
        Mon, 15 Mar 2021 06:20:29 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 472C13F792;
        Mon, 15 Mar 2021 06:20:27 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v16 0/9] arm64: ARMv8.5-A: MTE: Add async mode support
Date:   Mon, 15 Mar 2021 13:20:10 +0000
Message-Id: <20210315132019.33202-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements the asynchronous mode support for ARMv8.5-A
Memory Tagging Extension (MTE), which is a debugging feature that allows
to detect with the help of the architecture the C and C++ programmatic
memory errors like buffer overflow, use-after-free, use-after-return, etc.

MTE is built on top of the AArch64 v8.0 virtual address tagging TBI
(Top Byte Ignore) feature and allows a task to set a 4 bit tag on any
subset of its address space that is multiple of a 16 bytes granule. MTE
is based on a lock-key mechanism where the lock is the tag associated to
the physical memory and the key is the tag associated to the virtual
address.
When MTE is enabled and tags are set for ranges of address space of a task,
the PE will compare the tag related to the physical memory with the tag
related to the virtual address (tag check operation). Access to the memory
is granted only if the two tags match. In case of mismatch the PE will raise
an exception.

The exception can be handled synchronously or asynchronously. When the
asynchronous mode is enabled:
  - Upon fault the PE updates the TFSR_EL1 register.
  - The kernel detects the change during one of the following:
    - Context switching
    - Return to user/EL0
    - Kernel entry from EL1
    - Kernel exit to EL1
  - If the register has been updated by the PE the kernel clears it and
    reports the error.

The series is based on linux-next/akpm.

To simplify the testing a tree with the new patches on top has been made
available at [1].

[1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v13.async.akpm

Changes:
--------
v16:
  - Rebase on the latest linux-next/akpm.
  - Address review comments.
v15:
  - Rebase on the latest linux-next/akpm.
  - Address review comments.
  - Enable KUNIT tests for async mode.
  - Drop kselftest that verified that TCO is enabled in
    load_unaligned_zeropad().
v14:
  - Rebase on the latest linux-next/akpm.
  - Address review comments.
  - Drop a patch that prevented to running the KUNIT tests
    in async mode.
  - Add kselftest to verify that TCO is enabled in
    load_unaligned_zeropad().
v13:
  - Rebase on the latest linux-next/akpm.
  - Address review comments.
v12:
  - Fixed a bug affecting kernel functions allowed to read
    beyond buffer boundaries.
  - Added support for save/restore of TFSR_EL1 register
    during suspend/resume operations.
  - Rebased on latest linux-next/akpm.
v11:
  - Added patch that disables KUNIT tests in async mode
v10:
  - Rebase on the latest linux-next/akpm
  - Address review comments.
v9:
  - Rebase on the latest linux-next/akpm
  - Address review comments.
v8:
  - Address review comments.
v7:
  - Fix a warning reported by kernel test robot. This
    time for real.
v6:
  - Drop patches that forbid KASAN KUNIT tests when async
    mode is enabled.
  - Fix a warning reported by kernel test robot.
  - Address review comments.
v5:
  - Rebase the series on linux-next/akpm.
  - Forbid execution for KASAN KUNIT tests when async
    mode is enabled.
  - Dropped patch to inline mte_assign_mem_tag_range().
  - Address review comments.
v4:
  - Added support for kasan.mode (sync/async) kernel
    command line parameter.
  - Addressed review comments.
v3:
  - Exposed kasan_hw_tags_mode to convert the internal
    KASAN represenetation.
  - Added dsb() for kernel exit paths in arm64.
  - Addressed review comments.
v2:
  - Fixed a compilation issue reported by krobot.
  - General cleanup.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Evgenii Stepanov <eugenis@google.com>
Cc: Branislav Rankov <Branislav.Rankov@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Andrey Konovalov (1):
  kasan, arm64: tests supports for HW_TAGS async mode

Vincenzo Frascino (8):
  arm64: mte: Add asynchronous mode support
  kasan: Add KASAN mode kernel parameter
  arm64: mte: Drop arch_enable_tagging()
  kasan: Add report for async mode
  arm64: mte: Enable TCO in functions that can read beyond buffer limits
  arm64: mte: Conditionally compile mte_enable_kernel_*()
  arm64: mte: Enable async tag check fault
  arm64: mte: Report async tag faults before suspend

 Documentation/dev-tools/kasan.rst       |  9 +++
 arch/arm64/include/asm/memory.h         |  4 +-
 arch/arm64/include/asm/mte-kasan.h      |  9 ++-
 arch/arm64/include/asm/mte.h            | 48 +++++++++++++
 arch/arm64/include/asm/uaccess.h        | 22 ++++++
 arch/arm64/include/asm/word-at-a-time.h |  4 ++
 arch/arm64/kernel/entry-common.c        |  6 ++
 arch/arm64/kernel/mte.c                 | 94 ++++++++++++++++++++++++-
 arch/arm64/kernel/suspend.c             |  3 +
 include/linux/kasan.h                   |  6 ++
 lib/test_kasan.c                        | 19 +++--
 mm/kasan/hw_tags.c                      | 66 +++++++++++++++--
 mm/kasan/kasan.h                        | 40 +++++++++--
 mm/kasan/report.c                       | 22 +++++-
 14 files changed, 329 insertions(+), 23 deletions(-)

-- 
2.30.2

