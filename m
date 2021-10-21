Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196B2436DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhJUXHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:07:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:58059 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhJUXHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="315379993"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="315379993"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033210"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:19 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 00/23] x86: Support Intel Advanced Matrix Extensions (part 4)
Date:   Thu, 21 Oct 2021 15:55:04 -0700
Message-Id: <20211021225527.10184-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last part of the effort to support AMX. This series follows the
KVM part:
    https://lore.kernel.org/lkml/20211017151447.829495362@linutronix.de/

With AMX the FPU register state buffer which is part of
task_struct::thread::fpu is not going to be extended unconditionally for
all tasks on an AMX enabled system as that would waste minimum 8K per task.

AMX provides a mechanism to trap on first use. That trap will be utilized
to allocate a larger register state buffer when the task (process) has
permissions to use it. The default buffer task_struct will only carry
states up to AVX512.

The cost of XFD switching only matters for an AMX-enabled system. With the
cleanup of the KVM FPU handling, host-side XFD/AMX is completely
independent of guest-side XFD/AMX.

The per-task feature and size information helps to support dynamic features
organically compared to the old versions.

Each task has a unique sigframe length with dynamic features. sigaltstack()
has a new size checker to support a per-task sigframe size.

This version also fixes the syscall implementation and the XFD state
switching on hot paths.

Here is a summary of patches:

  - At first, add arch-specific sigaltstack size check

  - Establish a set of new syscalls to control dynamic XSTATE components

  - Update infrastructure to prepare dynamic features

  - Support XFD state and switching, and add buffer reallocation helpers

  - Finally, enable AMX with XFD #NM handling

This series is based on:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu-3-kvm

and a revision of the version in the tglx tree -- some bug fixes, polish,
and addressing Dave Hansen's feedback (noted on each patch):

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu

This comes with a large selftest suite which is going to be posted
separately. A preview along with the full series is available here:

    git://github.com/intel/amx-linux.git amx

Thanks,
Chang

Chang S. Bae (15):
  x86/fpu/xstate: Provide xstate_calculate_size()
  x86/arch_prctl: Add controls for dynamic XSTATE components
  x86/fpu/signal: Prepare for variable sigframe length
  x86/fpu: Reset permission and fpstate on exec()
  x86/cpufeatures: Add eXtended Feature Disabling (XFD) feature bit
  x86/msr-index: Add MSRs for XFD
  x86/fpu: Add XFD state to fpstate
  x86/fpu: Update XFD state where required
  x86/fpu/xstate: Add XFD #NM handler
  x86/fpu/xstate: Add fpstate_realloc()/free()
  x86/fpu/xstate: Prepare XSAVE feature table for gaps in state
    component numbers
  x86/fpu/amx: Define AMX state components and have it used for
    boot-time checks
  x86/fpu: Calculate the default sizes independently
  x86/fpu: Add XFD handling for dynamic states
  x86/fpu/amx: Enable the AMX feature in 64-bit mode

Thomas Gleixner (8):
  signal: Add an optional check for altstack size
  x86/signal: Implement sigaltstack size validation
  x86/fpu: Add members to struct fpu to cache permission information
  x86/fpu: Add fpu_state_config::legacy_features
  x86/fpu: Add basic helpers for dynamically enabled features
  x86/signal: Use fpu::__state_user_size for sigalt stack validation
  x86/fpu: Prepare fpu_clone() for dynamically enabled features
  x86/fpu: Add sanity checks for XFD

 .../admin-guide/kernel-parameters.txt         |   9 +
 arch/Kconfig                                  |   3 +
 arch/x86/Kconfig                              |  17 +
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/fpu/api.h                |  11 +
 arch/x86/include/asm/fpu/sched.h              |   2 +-
 arch/x86/include/asm/fpu/types.h              |  88 +++
 arch/x86/include/asm/fpu/xstate.h             |  21 +-
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/proto.h                  |   2 +-
 arch/x86/include/uapi/asm/prctl.h             |   4 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   2 +
 arch/x86/kernel/fpu/context.h                 |   2 +
 arch/x86/kernel/fpu/core.c                    |  93 ++-
 arch/x86/kernel/fpu/init.c                    |   9 +-
 arch/x86/kernel/fpu/internal.h                |   3 -
 arch/x86/kernel/fpu/signal.c                  |  70 +--
 arch/x86/kernel/fpu/xstate.c                  | 566 ++++++++++++++++--
 arch/x86/kernel/fpu/xstate.h                  |  61 +-
 arch/x86/kernel/process.c                     |  21 +-
 arch/x86/kernel/signal.c                      |  64 +-
 arch/x86/kernel/traps.c                       |  38 ++
 include/linux/signal.h                        |   6 +
 kernel/signal.c                               |  35 +-
 24 files changed, 1008 insertions(+), 123 deletions(-)


base-commit: 672f086122b67b299aa89c6b5f647c20ef84157f
--
2.17.1

