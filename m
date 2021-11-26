Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04B245EF16
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348299AbhKZN2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:28:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50426 "EHLO mail.kernel.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S237137AbhKZN0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:26:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ADC360E53;
        Fri, 26 Nov 2021 13:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637932970;
        bh=PNB+pY2UTXPBHUsNInngg94qXAVwoG1OVtOEIHyZKM8=;
        h=Date:From:To:Cc:Subject:From;
        b=ULJqGfoJnRpCE3ncR+zoG8Nq+ze/4yDi52VwViCr+B0S56Iaqg2tWm+elIo8ZHZrz
         nJmLdYWCplCIxEokdIxALsuhqH38Iozu7NvJzFcCOBcUM2y37ufY9zeP/LfS/gsJOQ
         XsAaIP5NpI47mKmyWBwFFk0iviKwh1oACncZX6gVNs3DhzdX51y1l87NuhD6LDkwpS
         HKjGILrxu4Ud7EMFcWJkAL1TPNR1mJB/NMv0HnuxWvUGdPuniMY8LdRACRX5bklWfz
         g2tFAV4dOnM392/akeJdIyDmOLDkoEFJohCSCNnnsK1EAKOMCDHxdKkn4cxNJQj+m0
         FdXlm4p45Pd4Q==
Date:   Fri, 26 Nov 2021 13:22:46 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc3
Message-ID: <20211126132245.GA20204@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

When you get a chance, please can you pull these three arm64 fixes? The
main one is a fix to the way in which we evaluate the macro arguments to
our uaccess routines, which we _think_ might be the root cause behind
some unkillable tasks we've seen in the Android arm64 CI farm (testing is
ongoing). In any case, it's worth fixing.

Other than that, we've toned down an over-zealous VM_BUG_ON() and fixed
ftrace stack unwinding in a bunch of cases.

Please pull.

Thanks,

Will

--->8

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 94902d849e85093aafcdbea2be8e2beff47233e6:

  arm64: uaccess: avoid blocking within critical sections (2021-11-24 09:16:26 +0000)

----------------------------------------------------------------
arm64 fixes for -rc3

- Evaluate uaccess macro arguments outside of the critical section

- Tighten up VM_BUG_ON() in pmd_populate_kernel() to avoid false positive

- Fix ftrace stack unwinding using HAVE_FUNCTION_GRAPH_RET_ADDR_PTR

----------------------------------------------------------------
Mark Rutland (2):
      arm64: ftrace: use HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
      arm64: uaccess: avoid blocking within critical sections

Pingfan Liu (1):
      arm64: mm: Fix VM_BUG_ON(mm != &init_mm) for trans_pgd

 arch/arm64/include/asm/ftrace.h     | 11 +++++++++
 arch/arm64/include/asm/pgalloc.h    |  2 +-
 arch/arm64/include/asm/stacktrace.h |  6 -----
 arch/arm64/include/asm/uaccess.h    | 48 +++++++++++++++++++++++++++++++------
 arch/arm64/kernel/ftrace.c          |  6 ++---
 arch/arm64/kernel/stacktrace.c      | 18 +++++++-------
 6 files changed, 64 insertions(+), 27 deletions(-)
