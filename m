Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CC244C853
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 19:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhKJTBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:01:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234465AbhKJS6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 13:58:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3898610FF;
        Wed, 10 Nov 2021 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636570337;
        bh=/8FT+gkW74SGUywqbw9I/r6HU5rPntFMDBcXKJeMXSw=;
        h=Date:From:To:Cc:Subject:From;
        b=f8ATwYExn/sFCf+DCJQpqn+EmGk/0t7LiP67nt567HQGAnmGLC4R5Qf3RTP+MK2w6
         TXOmMNKUK3Sk0as/xFQ/d4I+EeARGpj87W+1NxHdHfB3y1/YuQCEnRdPPIoJl42tAL
         +x+rkF0f2tE+mFFlyuFEazsAtiyU12yy5+H+EJ8Ds0asbeY0matmEQ078+/md/K+X0
         ci1uOBFyM1UfNC4EF554NOjzGxBQpuoTttQSi3R/v72svnAoDETrzs6HXrIeOqnBS8
         JAUTRm1kQLAyCsUM1khLTuhUrU2rF1YHVNWRQoQaYSTmKm4Muj9BrNwrwMb2YwCMKy
         e4iZ0OZNLIG1A==
Date:   Wed, 10 Nov 2021 18:52:13 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc1
Message-ID: <20211110185212.GA4786@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc1 to address issues spotted during the
merge window. There's the usual summary in the tag and we have at least one
more fix already pending for next week.

Cheers,

Will

--->8

The following changes since commit e6359798f62da66a4a48061d2324a69ea59ff39b:

  Merge branch 'for-next/fixes' into for-next/core (2021-10-29 12:27:53 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to c7c386fbc20262c1d911c615c65db6a58667d92c:

  arm64: pgtable: make __pte_to_phys/__phys_to_pte_val inline functions (2021-11-08 10:05:54 +0000)

----------------------------------------------------------------
arm64 fixes for -rc1

- Fix double-evaluation of 'pte' macro argument when using 52-bit PAs

- Fix signedness of some MTE prctl PR_* constants

- Fix kmemleak memory usage by skipping early pgtable allocations

- Fix printing of CPU feature register strings

- Remove redundant -nostdlib linker flag for vDSO binaries

----------------------------------------------------------------
Arnd Bergmann (1):
      arm64: pgtable: make __pte_to_phys/__phys_to_pte_val inline functions

Masahiro Yamada (1):
      arm64: vdso: remove -nostdlib compiler flag

Peter Collingbourne (1):
      arm64: mte: change PR_MTE_TCF_NONE back into an unsigned long

Qian Cai (1):
      arm64: Track no early_pgtable_alloc() for kmemleak

Reiji Watanabe (1):
      arm64: arm64_ftr_reg->name may not be a human-readable string

 arch/arm/mm/kasan_init.c          |  2 +-
 arch/arm64/include/asm/pgtable.h  | 12 +++++++++---
 arch/arm64/kernel/cpufeature.c    | 10 +++++++---
 arch/arm64/kernel/vdso/Makefile   |  2 +-
 arch/arm64/kernel/vdso32/Makefile |  2 +-
 arch/arm64/mm/kasan_init.c        |  5 +++--
 arch/arm64/mm/mmu.c               |  3 ++-
 include/linux/memblock.h          |  2 +-
 include/uapi/linux/prctl.h        |  2 +-
 mm/memblock.c                     |  9 ++++++---
 tools/include/uapi/linux/prctl.h  |  2 +-
 11 files changed, 33 insertions(+), 18 deletions(-)
