Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD1B42185A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 22:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhJDUZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 16:25:00 -0400
Received: from foss.arm.com ([217.140.110.172]:35948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233952AbhJDUY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:24:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99E6B1FB;
        Mon,  4 Oct 2021 13:23:09 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B322A3F70D;
        Mon,  4 Oct 2021 13:23:07 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     vincenzo.frascino@arm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2 0/5] arm64: ARMv8.7-A: MTE: Add asymm in-kernel support
Date:   Mon,  4 Oct 2021 21:22:48 +0100
Message-Id: <20211004202253.27857-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements the in-kernel asymmetric mode support for
ARMv8.7-A Memory Tagging Extension (MTE), which is a debugging feature
that allows to detect with the help of the architecture the C and C++
programmatic memory errors like buffer overflow, use-after-free,
use-after-return, etc.

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

When asymmetric mode is present, the CPU triggers a fault on a tag mismatch
during a load operation and asynchronously updates a register when a tag
mismatch is detected during a store operation.

Note: The userspace support will be sent with a future patch series.

The series is based on linux-v5.15-rc4.

To simplify the testing a tree with the new patches on top has been made
available at [1].

[1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v2.asymm

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Evgenii Stepanov <eugenis@google.com>
Cc: Branislav Rankov <Branislav.Rankov@arm.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (5):
  kasan: Remove duplicate of kasan_flag_async
  arm64: mte: Bitfield definitions for Asymm MTE
  arm64: mte: CPU feature detection for Asymm MTE
  arm64: mte: Add asymmetric mode support
  kasan: Extend KASAN mode kernel parameter

 Documentation/dev-tools/kasan.rst  |  7 +++++--
 arch/arm64/include/asm/memory.h    |  1 +
 arch/arm64/include/asm/mte-kasan.h |  5 +++++
 arch/arm64/include/asm/sysreg.h    |  3 +++
 arch/arm64/kernel/cpufeature.c     | 10 +++++++++
 arch/arm64/kernel/mte.c            | 33 +++++++++++++++++++++++++++++-
 arch/arm64/tools/cpucaps           |  1 +
 lib/test_kasan.c                   |  2 +-
 mm/kasan/hw_tags.c                 | 27 +++++++++++++++++++-----
 mm/kasan/kasan.h                   | 24 +++++++++++++++++-----
 mm/kasan/report.c                  |  2 +-
 11 files changed, 100 insertions(+), 15 deletions(-)

-- 
2.33.0

