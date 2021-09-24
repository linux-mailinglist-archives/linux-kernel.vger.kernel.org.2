Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550D94179F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 19:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbhIXRmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 13:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344856AbhIXRmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:42:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04AFF61260;
        Fri, 24 Sep 2021 17:41:01 +0000 (UTC)
Date:   Fri, 24 Sep 2021 18:40:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.15-rc3
Message-ID: <YU4NqD1xVANVj0y0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 9fcb2e93f41c07a400885325e7dbdfceba6efaec:

  arm64: Mark __stack_chk_guard as __ro_after_init (2021-09-16 17:59:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 22b70e6f2da0a4c8b1421b00cfc3016bc9d4d9d4:

  arm64: Restore forced disabling of KPTI on ThunderX (2021-09-23 15:59:15 +0100)

----------------------------------------------------------------
arm64 fixes:

- It turns out that the optimised string routines merged in 5.14 are not
  safe with in-kernel MTE (KASAN_HW_TAGS) because of reading beyond the
  end of a string (strcmp, strncmp). Such reading may go across a 16
  byte tag granule and cause a tag check fault. When KASAN_HW_TAGS is
  enabled, use the generic strcmp/strncmp C implementation.

- An errata workaround for ThunderX relied on the CPU capabilities being
  enabled in a specific order. This disappeared with the automatic
  generation of the cpucaps.h file (sorted alphabetically). Fix it by
  checking the current CPU only rather than the system-wide capability.

- Add system_supports_mte() checks on the kernel entry/exit path and
  thread switching to avoid unnecessary barriers and function calls on
  systems where MTE is not supported.

- kselftests: skip arm64 tests if the required features are missing.

----------------------------------------------------------------
Cristian Marussi (1):
      kselftest/arm64: signal: Skip tests if required features are missing

Peter Collingbourne (1):
      arm64: add MTE supported check to thread switching and syscall entry/exit

Robin Murphy (1):
      arm64: Mitigate MTE issues with str{n}cmp()

dann frazier (1):
      arm64: Restore forced disabling of KPTI on ThunderX

 arch/arm64/include/asm/assembler.h                        |  5 +++++
 arch/arm64/include/asm/mte.h                              |  6 ++++++
 arch/arm64/include/asm/string.h                           |  2 ++
 arch/arm64/kernel/cpufeature.c                            |  8 ++++++--
 arch/arm64/kernel/mte.c                                   | 10 ++++------
 arch/arm64/lib/strcmp.S                                   |  2 +-
 arch/arm64/lib/strncmp.S                                  |  2 +-
 tools/testing/selftests/arm64/signal/test_signals_utils.c |  7 +++++--
 8 files changed, 30 insertions(+), 12 deletions(-)

-- 
Catalin
