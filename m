Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331D63261CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhBZLKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhBZLKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:10:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 839E764EF3;
        Fri, 26 Feb 2021 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614337761;
        bh=UafMWbdxz8GDciYyvjVd44wddKbu5UOIXiZnDZDAhCI=;
        h=Date:From:To:Cc:Subject:From;
        b=qurh9kU4NRRuw5LoTxuv9fe66S7ZByv//73ghJj8US7VkvShTMycrwRJUjDjp3E9M
         Fn+moxObo89UA7aMa8YYqBTxV19SEbrJaVqDthinVs/89v/aTLi76ewdf+uyQgLBTU
         cpRGnewRu42IlvCnbNFW6h0rUTISfzkuCpdV5oqrWRFZpevjtwRbWmWRNiYQJGt7t5
         ivefheR8n/UByw7CClvg9U3eiuFz5hLpYDdkNHEDhI9ho/yW2o1gYMIxyZTxO0gs1P
         Nh+tNDesih3ltHUPR0yKjI1NfdoFYvE756ivq7NA4zX0o7tEN/aipF2wagwakisS9W
         52xe93LNklldg==
Date:   Fri, 26 Feb 2021 11:09:16 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>, kernel-team@android.com,
        maz@kernel.org
Subject: [GIT PULL] arm64: Fixes for -rc1
Message-ID: <20210226110916.GA14247@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc1. The big one is a fix for the VHE
enabling path during early boot, where the code enabling the MMU wasn't
necessarily in the identity map of the new page-tables, resulting in a
consistent crash with 64k pages. In fixing that, we noticed some missing
barriers too, so we added those for the sake of architectural compliance.

Other than that, just the usual merge window trickle. There'll be more
to come, too.

Cheers,

Will

--->8

The following changes since commit 1ffa9763828cf73a4d4eaa04c29a4a89fb0708c7:

  Merge branch 'for-next/vdso' into for-next/core (2021-02-12 15:17:42 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 3c02600144bdb0a1280a9090d3a7e37e2f9fdcc8:

  arm64: stacktrace: Report when we reach the end of the stack (2021-02-25 10:34:51 +0000)

----------------------------------------------------------------
arm64 fixes for -rc1

- Fix lockdep false alarm on resume-from-cpuidle path

- Fix memory leak in kexec_file

- Fix module linker script to work with GDB

- Fix error code when trying to use uprobes with AArch32 instructions

- Fix late VHE enabling with 64k pages

- Add missing ISBs after TLB invalidation

- Fix seccomp when tracing syscall -1

- Fix stacktrace return code at end of stack

- Fix inconsistent whitespace for pointer return values

- Fix compiler warnings when building with W=1

----------------------------------------------------------------
He Zhe (1):
      arm64: uprobe: Return EOPNOTSUPP for AARCH32 instruction probing

Joey Gouly (1):
      KVM: arm64: make the hyp vector table entries local

Marc Zyngier (3):
      arm64: VHE: Enable EL2 MMU from the idmap
      arm64: Add missing ISB after invalidating TLB in __primary_switch
      arm64: Add missing ISB after invalidating TLB in enter_vhe

Mark Brown (1):
      arm64: stacktrace: Report when we reach the end of the stack

Pavel Tatashin (1):
      kexec: move machine_kexec_post_load() to public interface

Shaoying Xu (1):
      arm64 module: set plt* section addresses to 0x0

Timothy E Baldwin (1):
      arm64: ptrace: Fix seccomp of traced syscall -1 (NO_SYSCALL)

Will Deacon (1):
      arm64: spectre: Prevent lockdep splat on v4 mitigation enable path

Zhiyuan Dai (1):
      arm64/mm: Fixed some coding style issues

qiuguorui1 (1):
      arm64: kexec_file: fix memory leakage in create_dtb() when fdt_open_into() fails

 arch/arm64/include/asm/module.lds.h    |  6 ++---
 arch/arm64/kernel/head.S               |  1 +
 arch/arm64/kernel/hyp-stub.S           | 40 +++++++++++++++++++++++-----------
 arch/arm64/kernel/machine_kexec_file.c |  4 +++-
 arch/arm64/kernel/probes/uprobes.c     |  2 +-
 arch/arm64/kernel/ptrace.c             |  2 +-
 arch/arm64/kernel/stacktrace.c         |  2 +-
 arch/arm64/kernel/suspend.c            |  2 +-
 arch/arm64/kvm/hyp/hyp-entry.S         |  2 +-
 arch/arm64/mm/mmu.c                    |  6 ++---
 include/linux/kexec.h                  |  2 ++
 kernel/kexec_internal.h                |  2 --
 12 files changed, 44 insertions(+), 27 deletions(-)
