Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40168338EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhCLNe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:34:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231512AbhCLNeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:34:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A21460190;
        Fri, 12 Mar 2021 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615556060;
        bh=9UTrPGnInmHkhNMOk81TEKQqO2DhO9DZdatw5H8tVY0=;
        h=Date:From:To:Cc:Subject:From;
        b=Tk+a6BGJqFQQhv9OY1VL/pEelzLl8rGKThSK3+gP2RM3anONJioh0OhrlvZEpuGmQ
         m76D2ZpPUrFVnkkJy6C4eEUUvV7Yi+/Y7oTCeUQkclfZj7hTlE8fH7ATpEOGMeP/EL
         nw2TAcsHMYmFshEBGixxEUZX9oW0Mne1pJO9XODHpBvkypIWLAuGbwkU0ukyB1+xss
         NBx3CuAto2EHGNhYMp+nIO69uOoRXrogjFKiIYoJRdEGFsberjI377ZgQuMEE76gMt
         gAm1dqCjeBMsfR0elUA2nnIPGw7dWUt0DDnuBOdgtLeUfuANnf6dwD/Oo1ak4WltJJ
         akPsL9hCPpIhA==
Date:   Fri, 12 Mar 2021 13:34:16 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>, kernel-team@android.com
Subject: [GIT PULL] arm64: Fixes for -rc3
Message-ID: <20210312133415.GA359@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc3. Summary in the tag, but we've
got a smattering of changes all over the place which we've acrued since
-rc1. To my knowledge, there aren't any pending issues at the moment,
but there's still plenty of time for something else to crop up...

Cheers,

Will

--->8

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to c8e3866836528a4ba3b0535834f03768d74f7d8e:

  perf/arm_dmc620_pmu: Fix error return code in dmc620_pmu_device_probe() (2021-03-12 11:30:31 +0000)

----------------------------------------------------------------
arm64 fixes for -rc3

- Fix booting a 52-bit-VA-aware kernel on Qualcomm Amberwing

- Fix pfn_valid() not to reject all ZONE_DEVICE memory

- Fix memory tagging setup for hotplugged memory regions

- Fix KASAN tagging in page_alloc() when DEBUG_VIRTUAL is enabled

- Fix accidental truncation of CPU PMU event counters

- Fix error code initialisation when failing probe of DMC620 PMU

- Fix return value initialisation for sve-ptrace selftest

- Drop broken support for CMDLINE_EXTEND

----------------------------------------------------------------
Andrey Konovalov (1):
      arm64: kasan: fix page_alloc tagging with DEBUG_VIRTUAL

Anshuman Khandual (4):
      arm64/mm: Drop redundant ARCH_WANT_HUGE_PMD_SHARE
      arm64/mm: Drop THP conditionality from FORCE_MAX_ZONEORDER
      arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
      arm64/mm: Reorganize pfn_valid()

Ard Biesheuvel (2):
      arm64: mm: use a 48-bit ID map when possible on 52-bit VA builds
      arm64: mm: remove unused __cpu_uses_extended_idmap[_level()]

Catalin Marinas (1):
      arm64: mte: Map hotplugged memory as Normal Tagged

James Morse (1):
      arm64/mm: Fix __enable_mmu() for new TGRAN range values

Mark Brown (1):
      kselftest: arm64: Fix exit code of sve-ptrace

Rob Herring (1):
      arm64: perf: Fix 64-bit event counter read truncation

Wei Yongjun (1):
      perf/arm_dmc620_pmu: Fix error return code in dmc620_pmu_device_probe()

Will Deacon (2):
      arm64: cpufeatures: Fix handling of CONFIG_CMDLINE for idreg overrides
      arm64: Drop support for CMDLINE_EXTEND

 arch/arm64/Kconfig                            | 12 ++------
 arch/arm64/include/asm/memory.h               |  5 ++++
 arch/arm64/include/asm/mmu_context.h          | 17 -----------
 arch/arm64/include/asm/pgtable-prot.h         |  1 -
 arch/arm64/include/asm/pgtable.h              |  3 ++
 arch/arm64/include/asm/sysreg.h               | 20 +++++++++----
 arch/arm64/kernel/head.S                      |  8 +++--
 arch/arm64/kernel/idreg-override.c            | 43 ++++++++++++++-------------
 arch/arm64/kernel/perf_event.c                |  2 +-
 arch/arm64/kvm/reset.c                        | 10 ++++---
 arch/arm64/mm/init.c                          | 29 ++++++++++++++++--
 arch/arm64/mm/mmu.c                           |  5 ++--
 drivers/firmware/efi/libstub/arm64-stub.c     |  2 +-
 drivers/perf/arm_dmc620_pmu.c                 |  1 +
 include/linux/pgtable.h                       |  4 +++
 mm/memory_hotplug.c                           |  2 +-
 tools/testing/selftests/arm64/fp/sve-ptrace.c |  2 +-
 17 files changed, 96 insertions(+), 70 deletions(-)
