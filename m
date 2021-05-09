Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C45A377607
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 11:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhEIJ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 05:29:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:41960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhEIJ32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 05:29:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72332ADDB;
        Sun,  9 May 2021 09:28:24 +0000 (UTC)
Date:   Sun, 9 May 2021 11:28:21 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.13-rc1
Message-ID: <YJerNVYK4h/Pnv5X@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

a bunch of things accumulated in x86/urgent in the last two weeks.
Please pull.

Thx.

---

The following changes since commit 5e321ded302da4d8c5d5dd953423d9b748ab3775:

  Merge tag 'for-5.13/parisc' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2021-05-03 13:47:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13_rc1

for you to fetch changes up to bc908e091b3264672889162733020048901021fb:

  KVM: x86: Consolidate guest enter/exit logic to common helpers (2021-05-05 22:54:12 +0200)

----------------------------------------------------------------
- Fix guest vtime accounting so that ticks happening while the guest is running
can also be accounted to it. Along with a consolidation to the guest-specific context
tracking helpers.

- Provide for the host NMI handler running after a VMX VMEXIT to be able to run
on the kernel stack correctly.

- Initialize MSR_TSC_AUX when RDPID is supported and not RDTSCP (virt relevant -
  real hw supports both)

- A code generation improvement to TASK_SIZE_MAX through the use of alternatives

- The usual misc. and related cleanups and improvements

----------------------------------------------------------------
Alexey Dobriyan (1):
      x86: Delete UD0, UD1 traces

Andi Kleen (1):
      x86/resctrl: Fix init const confusion

Lai Jiangshan (1):
      KVM/VMX: Invoke NMI non-IST entry instead of IST entry

Linus Torvalds (1):
      x86/cpu: Use alternative to generate the TASK_SIZE_MAX constant

Sean Christopherson (7):
      x86/cpu: Initialize MSR_TSC_AUX if RDTSCP *or* RDPID is supported
      x86/cpu: Remove write_tsc() and write_rdtscp_aux() wrappers
      sched/vtime: Move vtime accounting external declarations above inlines
      sched/vtime: Move guest enter/exit vtime accounting to vtime.h
      context_tracking: Consolidate guest enter/exit wrappers
      context_tracking: KVM: Move guest enter/exit wrappers to KVM's domain
      KVM: x86: Consolidate guest enter/exit logic to common helpers

Wan Jiabing (1):
      x86/smpboot: Remove duplicate includes

Wanpeng Li (3):
      context_tracking: Move guest exit context tracking to separate helpers
      context_tracking: Move guest exit vtime accounting to separate helpers
      KVM: x86: Defer vtime accounting 'til after IRQ handling

 arch/x86/include/asm/bug.h            |   9 ---
 arch/x86/include/asm/idtentry.h       |  15 +++++
 arch/x86/include/asm/msr.h            |   4 --
 arch/x86/include/asm/page_64.h        |  33 +++++++++++
 arch/x86/include/asm/page_64_types.h  |  23 +-------
 arch/x86/kernel/cpu/common.c          |   4 +-
 arch/x86/kernel/cpu/resctrl/monitor.c |   2 +-
 arch/x86/kernel/nmi.c                 |  10 ++++
 arch/x86/kernel/smpboot.c             |   3 -
 arch/x86/kvm/svm/svm.c                |  39 +-----------
 arch/x86/kvm/vmx/vmx.c                |  55 ++++-------------
 arch/x86/kvm/x86.c                    |   9 +++
 arch/x86/kvm/x86.h                    |  45 ++++++++++++++
 include/linux/context_tracking.h      |  92 +++++------------------------
 include/linux/kvm_host.h              |  45 ++++++++++++++
 include/linux/vtime.h                 | 108 ++++++++++++++++++++++------------
 16 files changed, 263 insertions(+), 233 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
