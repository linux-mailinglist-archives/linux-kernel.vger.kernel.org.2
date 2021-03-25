Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F8B3494B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhCYOyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhCYOys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:54:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D426161A01;
        Thu, 25 Mar 2021 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616684087;
        bh=OIYERMOG/XPylWSnUTkbmBN81RCSXvziYG/US6eKvQE=;
        h=Date:From:To:Cc:Subject:From;
        b=bv4CR7tnXhP5m5Io8X+PCvZ3zTkUqAW+QxIwrP5YtzTqO8B6yHH24/IATa76UP7f2
         9WTeVPDUtvAVyjR1d4EKZnVAuOFsqTSriMygVLiHPBDEENU8STTo4JCTJ3/aivNKcu
         j9Ng9uFaAXdgTgIksxQbAAavt6t6UlUZZScWGp/dWiIwCqN7ZYV1Dh8NeZpE2oa/pP
         UXZnbJotynvYShZ7k7neJlmP+onSFJoO+2oJ7CPClpF2geOo8J7ahnoIg5cveoob0K
         mhX6gDcFGiPLF9qTdjiWW0K2mDHqdwHbUTC+Qel+1ZoJM0ejsvjzrvb52OrsD78wql
         u0U4GJaoxwkUQ==
Date:   Thu, 25 Mar 2021 14:54:43 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>, kernel-team@android.com
Subject: [GIT PULL] arm64: Fixes for -rc5
Message-ID: <20210325145443.GA15172@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc5. Minor fixes all over, ranging
from typos to tests to errata workarounds. Summary in the tag.

Cheers,

Will

--->8

The following changes since commit c8e3866836528a4ba3b0535834f03768d74f7d8e:

  perf/arm_dmc620_pmu: Fix error return code in dmc620_pmu_device_probe() (2021-03-12 11:30:31 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 20109a859a9b514eb10c22b8a14b5704ffe93897:

  arm64: kernel: disable CNP on Carmel (2021-03-25 10:00:23 +0000)

----------------------------------------------------------------
arm64 fixes for -rc5

- Fix possible memory hotplug failure with KASLR

- Fix FFR value in SVE kselftest

- Fix backtraces reported in /proc/$pid/stack

- Disable broken CnP implementation on NVIDIA Carmel

- Typo fixes and ACPI documentation clarification

- Fix some W=1 warnings

----------------------------------------------------------------
Alex Elder (1):
      arm64: csum: cast to the proper type

Andre Przywara (1):
      kselftest/arm64: sve: Do not use non-canonical FFR register value

Bhaskar Chowdhury (1):
      arm64: cpuinfo: Fix a typo

Maninder Singh (1):
      arm64/process.c: fix Wmissing-prototypes build warnings

Mark Rutland (1):
      arm64: stacktrace: don't trace arch_stack_walk()

Pavel Tatashin (2):
      arm64: kdump: update ppos when reading elfcorehdr
      arm64: mm: correct the inside linear map range during hotplug check

Rich Wiley (1):
      arm64: kernel: disable CNP on Carmel

Tom Saeger (1):
      Documentation: arm64/acpi : clarify arm64 support of IBFT

 Documentation/arm64/acpi_object_usage.rst   | 10 +++++-----
 Documentation/arm64/silicon-errata.rst      |  3 +++
 arch/arm64/Kconfig                          | 10 ++++++++++
 arch/arm64/include/asm/checksum.h           |  2 +-
 arch/arm64/include/asm/cpucaps.h            |  3 ++-
 arch/arm64/include/asm/processor.h          |  2 ++
 arch/arm64/include/asm/thread_info.h        |  2 ++
 arch/arm64/kernel/cpu_errata.c              |  8 ++++++++
 arch/arm64/kernel/cpufeature.c              |  5 ++++-
 arch/arm64/kernel/cpuinfo.c                 |  2 +-
 arch/arm64/kernel/crash_dump.c              |  2 ++
 arch/arm64/kernel/process.c                 |  2 ++
 arch/arm64/kernel/stacktrace.c              |  9 +++++----
 arch/arm64/mm/mmu.c                         | 21 +++++++++++++++++++--
 tools/testing/selftests/arm64/fp/sve-test.S | 22 +++++++++++++++++-----
 15 files changed, 83 insertions(+), 20 deletions(-)
