Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4436E3E2BFA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhHFNxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234093AbhHFNxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:53:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 407C360F70;
        Fri,  6 Aug 2021 13:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628258016;
        bh=HJzP5YP4DYQESm9BV+H2EfIFsF7Mzd+YPm8A9nWkj3g=;
        h=Date:From:To:Cc:Subject:From;
        b=CsVJKkRwfeUetV5oVR54+pqKArGdOHRuwQ7qYVdNFl+W0HpU5hYmBaRqz9y96UkKW
         Dha72e8wwl+0krdrRvxPE+jl8RROAskdNCRJqfwjoHPHH0kTX4WrcAp2+cbMlm4YVc
         Sal5XgZOVcPe14qrvvq5NdN0Bsi4voXMUB/b7L2Lot82PhS+ohSw/mr8Q3Yp0cYu7v
         NPpXphkPUhAW+ZDgMNvunsg/jmUvu/lJScKAndgaLQpaYz6yCyZyzHpEaLbEdXVFU8
         VN5gipq+RVLKf9Leo1UYiw/Svymz4zffsvuIQCd/qawdxoQM9VMveqEp8y33Ztd7X5
         29C9LfINmId1g==
Date:   Fri, 6 Aug 2021 14:53:32 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc5
Message-ID: <20210806135331.GA2951@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc5. It's all pretty minor but the
main fix is sorting out how we deal with return values from 32-bit system
calls as audit expects error codes to be sign-extended to 64 bits

Brief summary in the tag.

Cheers,

Will

--->8

The following changes since commit d8a719059b9dc963aa190598778ac804ff3e6a87:

  Revert "mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge" (2021-07-21 11:28:09 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 0c32706dac1b0a72713184246952ab0f54327c21:

  arm64: stacktrace: avoid tracing arch_stack_walk() (2021-08-03 10:39:35 +0100)

----------------------------------------------------------------
arm64 fixes for -rc5

- Fix extension/truncation of return values from 32-bit system calls

- Fix interaction between unwinding and tracing

- Fix spurious toolchain warning emitted during make

- Fix Kconfig help text for RANDOMIZE_MODULE_REGION_FULL

----------------------------------------------------------------
Barry Song (1):
      arm64: fix the doc of RANDOMIZE_MODULE_REGION_FULL

Mark Rutland (3):
      arm64: fix compat syscall return truncation
      arm64: stacktrace: fix comment
      arm64: stacktrace: avoid tracing arch_stack_walk()

Masahiro Yamada (1):
      arm64: move warning about toolchains to archprepare

 arch/arm64/Kconfig                  |  9 ++++++---
 arch/arm64/Makefile                 | 21 ++++++++++++---------
 arch/arm64/include/asm/ptrace.h     | 12 +++++++++++-
 arch/arm64/include/asm/stacktrace.h |  2 +-
 arch/arm64/include/asm/syscall.h    | 19 ++++++++++---------
 arch/arm64/kernel/kaslr.c           |  4 +++-
 arch/arm64/kernel/ptrace.c          |  2 +-
 arch/arm64/kernel/signal.c          |  3 ++-
 arch/arm64/kernel/stacktrace.c      |  2 +-
 arch/arm64/kernel/syscall.c         |  9 +++------
 10 files changed, 50 insertions(+), 33 deletions(-)
