Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4D7380EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 19:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhENRaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 13:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231804AbhENRaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 13:30:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C75E61183;
        Fri, 14 May 2021 17:29:09 +0000 (UTC)
Date:   Fri, 14 May 2021 18:29:06 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes/updates for 5.13-rc2
Message-ID: <20210514172904.GA29470@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 updates below. Thanks.

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 588a513d34257fdde95a9f0df0202e31998e85c6:

  arm64: Fix race condition on PG_dcache_clean in __sync_icache_dcache() (2021-05-14 17:11:16 +0100)

----------------------------------------------------------------
arm64 fixes and cpucaps.h automatic generation:

- Generate cpucaps.h at build time rather than carrying lots of
  #defines. Merged at -rc1 to avoid some conflicts during the merging
  window.

- Initialise RGSR_EL1.SEED in __cpu_setup() as it may be left as 0 out
  of reset and the IRG instruction would not function as expected if
  only the architected pseudorandom number generator is implemented.

- Fix potential race condition in __sync_icache_dcache() where the
  PG_dcache_clean page flag is set before the actual cache maintenance.

- Fix header include in BTI kselftests.

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Fix race condition on PG_dcache_clean in __sync_icache_dcache()

Mark Brown (3):
      arm64: Generate cpucaps.h
      kselftest/arm64: Add missing stddef.h include to BTI tests
      arm64: tools: Add __ASM_CPUCAPS_H to the endif in cpucaps.h

Peter Collingbourne (1):
      arm64: mte: initialize RGSR_EL1.SEED in __cpu_setup

 arch/arm64/Makefile                      |  3 ++
 arch/arm64/include/asm/Kbuild            |  2 +
 arch/arm64/include/asm/cpucaps.h         | 74 --------------------------------
 arch/arm64/mm/flush.c                    |  4 +-
 arch/arm64/mm/proc.S                     | 12 ++++++
 arch/arm64/tools/Makefile                | 22 ++++++++++
 arch/arm64/tools/cpucaps                 | 65 ++++++++++++++++++++++++++++
 arch/arm64/tools/gen-cpucaps.awk         | 40 +++++++++++++++++
 tools/testing/selftests/arm64/bti/test.c |  1 +
 9 files changed, 148 insertions(+), 75 deletions(-)
 delete mode 100644 arch/arm64/include/asm/cpucaps.h
 create mode 100644 arch/arm64/tools/Makefile
 create mode 100644 arch/arm64/tools/cpucaps
 create mode 100755 arch/arm64/tools/gen-cpucaps.awk

-- 
Catalin
