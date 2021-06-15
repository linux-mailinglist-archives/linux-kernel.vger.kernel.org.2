Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F663A7DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFOMAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:00:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:12906 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhFOMAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:00:50 -0400
IronPort-SDR: xnJnYJgA8P1L61CqKz7ZcUlMP0nfcXecI1hqljMPs7VZ18UjzzUQrW9v8UCkaIYiYnoGwZmmFF
 YFBDyy8cgIwg==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="193283000"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="193283000"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 04:58:45 -0700
IronPort-SDR: Xf+CtcNcFoHdIGNRaI9JMdwDaoTy7HvyDHEU0XiMCaFE8NwYKZCGnNPzDTHcl+iH+WYamVr4OK
 Fp/9Cs8geoLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="421100219"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Jun 2021 04:58:43 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lt7iN-0000P9-AE; Tue, 15 Jun 2021 11:58:43 +0000
Date:   Tue, 15 Jun 2021 19:58:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:tmp.tmp2] BUILD REGRESSION
 adcceb5eb7aee38e4a9c15bdf599655f0e1b1324
Message-ID: <60c895db.auPG922AP36PJ1Tq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tmp.tmp2
branch HEAD: adcceb5eb7aee38e4a9c15bdf599655f0e1b1324  fix for init_task.c - backmerge in steps

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allyesconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-latencytop.h:warning:struct-ctl_table-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   |-- include-linux-sched.h:error:field-irqtrace-has-incomplete-type
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- arc-defconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- arm-allmodconfig
|   |-- arch-arm-include-asm-ucontext.h:error:field-uc_mcontext-has-incomplete-type
|   |-- arch-arm-include-asm-ucontext.h:error:sigset_t-undeclared-here-(not-in-a-function)
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-sigset_t
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-stack_t
|   |-- arch-arm-kernel-signal.h:error:field-info-has-incomplete-type
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-stack_canary
|   `-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|-- arm-allyesconfig
|   |-- arch-arm-include-asm-ucontext.h:error:field-uc_mcontext-has-incomplete-type
|   |-- arch-arm-include-asm-ucontext.h:error:sigset_t-undeclared-here-(not-in-a-function)
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-sigset_t
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-stack_t
|   |-- arch-arm-kernel-signal.h:error:field-info-has-incomplete-type
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-stack_canary
|   `-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|-- arm-defconfig
|   |-- arch-arm-include-asm-ucontext.h:error:field-uc_mcontext-has-incomplete-type
|   |-- arch-arm-include-asm-ucontext.h:error:sigset_t-undeclared-here-(not-in-a-function)
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-sigset_t
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-stack_t
|   |-- arch-arm-kernel-signal.h:error:field-info-has-incomplete-type
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-stack_canary
|-- arm-dove_defconfig
|   |-- arch-arm-include-asm-ucontext.h:error:field-uc_mcontext-has-incomplete-type
|   |-- arch-arm-include-asm-ucontext.h:error:sigset_t-undeclared-here-(not-in-a-function)
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-sigset_t
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-stack_t
|   |-- arch-arm-kernel-signal.h:error:field-info-has-incomplete-type
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-stack_canary
|-- arm-mv78xx0_defconfig
|   |-- arch-arm-include-asm-ucontext.h:error:field-uc_mcontext-has-incomplete-type
|   |-- arch-arm-include-asm-ucontext.h:error:sigset_t-undeclared-here-(not-in-a-function)
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-sigset_t
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-stack_t
|   |-- arch-arm-kernel-signal.h:error:field-info-has-incomplete-type
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-stack_canary
|-- arm-pcm027_defconfig
|   |-- arch-arm-include-asm-ucontext.h:error:field-uc_mcontext-has-incomplete-type
|   |-- arch-arm-include-asm-ucontext.h:error:sigset_t-undeclared-here-(not-in-a-function)
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-sigset_t
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-stack_t
|   |-- arch-arm-kernel-signal.h:error:field-info-has-incomplete-type
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-stack_canary
|-- arm-randconfig-r014-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- arm-simpad_defconfig
|   |-- arch-arm-include-asm-ucontext.h:error:field-uc_mcontext-has-incomplete-type
|   |-- arch-arm-include-asm-ucontext.h:error:sigset_t-undeclared-here-(not-in-a-function)
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-sigset_t
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-stack_t
|   |-- arch-arm-kernel-signal.h:error:field-info-has-incomplete-type
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-stack_canary
|-- arm-spear13xx_defconfig
|   |-- arch-arm-include-asm-ucontext.h:error:field-uc_mcontext-has-incomplete-type
|   |-- arch-arm-include-asm-ucontext.h:error:sigset_t-undeclared-here-(not-in-a-function)
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-sigset_t
|   |-- arch-arm-include-asm-ucontext.h:error:unknown-type-name-stack_t
|   `-- arch-arm-kernel-signal.h:error:field-info-has-incomplete-type
|-- csky-randconfig-r003-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-did-you-mean
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-did-you-mean
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-did-you-mean
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- csky-randconfig-r032-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|-- h8300-allyesconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- h8300-randconfig-p001-20210614
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- h8300-randconfig-r026-20210613
|   `-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|-- h8300-randconfig-r034-20210613
|   `-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|-- i386-defconfig
|   |-- arch-x86-include-asm-uaccess.h:error:implicit-declaration-of-function-in_task
|   |-- arch-x86-include-asm-uaccess_32.h:error:conflicting-types-for-__copy_from_user_inatomic_nocache
|   |-- arch-x86-include-asm-uaccess_32.h:error:redefinition-of-raw_copy_from_user
|   |-- arch-x86-include-asm-uaccess_32.h:error:redefinition-of-raw_copy_to_user
|   |-- include-asm-generic-memory_model.h:error:mem_map-undeclared-(first-use-in-this-function)
|   |-- include-linux-fs.h:error:implicit-declaration-of-function-read_seqcount_begin
|   |-- include-linux-fs.h:error:implicit-declaration-of-function-read_seqcount_retry
|   |-- include-linux-fs.h:error:implicit-declaration-of-function-write_seqcount_begin
|   |-- include-linux-fs.h:error:implicit-declaration-of-function-write_seqcount_end
|   |-- include-linux-fs.h:warning:implicit-declaration-of-function-read_seqcount_begin
|   |-- include-linux-fs.h:warning:implicit-declaration-of-function-read_seqcount_retry
|   |-- include-linux-fs.h:warning:implicit-declaration-of-function-write_seqcount_begin
|   |-- include-linux-fs.h:warning:implicit-declaration-of-function-write_seqcount_end
|   |-- include-linux-numa.h:error:unknown-type-name-u64
|   |-- include-linux-sched-per_task.h:error:dereferencing-pointer-to-incomplete-type-struct-task_struct
|   |-- include-linux-u64_stats_sync.h:error:implicit-declaration-of-function-local_irq_restore
|   |-- include-linux-u64_stats_sync.h:error:implicit-declaration-of-function-local_irq_save
|   |-- include-linux-u64_stats_sync.h:error:implicit-declaration-of-function-read_seqcount_begin
|   |-- include-linux-u64_stats_sync.h:error:implicit-declaration-of-function-read_seqcount_retry
|   |-- include-linux-u64_stats_sync.h:error:implicit-declaration-of-function-write_seqcount_begin
|   `-- include-linux-u64_stats_sync.h:error:implicit-declaration-of-function-write_seqcount_end
|-- i386-tinyconfig
|   `-- include-linux-coredump.h:warning:struct-kernel_siginfo-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- ia64-allmodconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched-thread_info_api.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-sched-thread_info_api.h:error:macro-current_thread_info-passed-arguments-but-takes-just
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   `-- include-linux-ww_mutex.h:error:implicit-declaration-of-function-DEBUG_LOCKS_WARN_ON
|-- ia64-allyesconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched-thread_info_api.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-sched-thread_info_api.h:error:macro-current_thread_info-passed-arguments-but-takes-just
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   `-- include-linux-ww_mutex.h:error:implicit-declaration-of-function-DEBUG_LOCKS_WARN_ON
|-- ia64-defconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched-thread_info_api.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-sched-thread_info_api.h:error:macro-current_thread_info-passed-arguments-but-takes-just
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   `-- include-linux-ww_mutex.h:error:implicit-declaration-of-function-DEBUG_LOCKS_WARN_ON
|-- ia64-randconfig-r012-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched-thread_info_api.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-sched-thread_info_api.h:error:macro-current_thread_info-passed-arguments-but-takes-just
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   `-- include-linux-ww_mutex.h:error:implicit-declaration-of-function-DEBUG_LOCKS_WARN_ON
|-- ia64-randconfig-r013-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched-thread_info_api.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-sched-thread_info_api.h:error:macro-current_thread_info-passed-arguments-but-takes-just
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   `-- include-linux-ww_mutex.h:error:implicit-declaration-of-function-DEBUG_LOCKS_WARN_ON
|-- ia64-randconfig-r016-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched-thread_info_api.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-sched-thread_info_api.h:error:macro-current_thread_info-passed-arguments-but-takes-just
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   `-- include-linux-ww_mutex.h:error:implicit-declaration-of-function-DEBUG_LOCKS_WARN_ON
|-- m68k-allmodconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- m68k-allyesconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   |-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|   `-- include-linux-ww_mutex.h:error:implicit-declaration-of-function-DEBUG_LOCKS_WARN_ON
|-- m68k-defconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- m68k-mvme16x_defconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- m68k-randconfig-r002-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   `-- include-linux-ww_mutex.h:error:implicit-declaration-of-function-DEBUG_LOCKS_WARN_ON
|-- m68k-randconfig-r035-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- microblaze-randconfig-r013-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-latencytop.h:warning:struct-ctl_table-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- microblaze-randconfig-r021-20210614
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-latencytop.h:warning:struct-ctl_table-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- mips-allmodconfig
|   |-- arch-mips-include-asm-compat.h:error:implicit-declaration-of-function-test_thread_flag
|   |-- arch-mips-include-asm-compat.h:error:unknown-type-name-old_time32_t
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- mips-allyesconfig
|   |-- arch-mips-include-asm-compat.h:error:implicit-declaration-of-function-test_thread_flag
|   |-- arch-mips-include-asm-compat.h:error:unknown-type-name-old_time32_t
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- mips-malta_kvm_defconfig
|   |-- arch-mips-include-asm-compat.h:error:implicit-declaration-of-function-test_thread_flag
|   `-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|-- mips-maltasmvp_defconfig
|   |-- arch-mips-include-asm-compat.h:error:implicit-declaration-of-function-test_thread_flag
|   |-- arch-mips-include-asm-compat.h:error:unknown-type-name-old_time32_t
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- mips-randconfig-r014-20210613
|   |-- arch-mips-include-asm-compat.h:error:implicit-declaration-of-function-test_thread_flag
|   |-- arch-mips-include-asm-compat.h:error:unknown-type-name-old_time32_t
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- nds32-allnoconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread_info
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- nds32-allyesconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread_info
|   |-- include-linux-latencytop.h:warning:struct-ctl_table-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- nds32-defconfig
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread_info
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- nds32-randconfig-r022-20210613
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread_info
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- nds32-randconfig-r034-20210615
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread_info
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- nios2-defconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- nios2-randconfig-p001-20210613
|   `-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|-- nios2-randconfig-r023-20210613
|   `-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|-- nios2-randconfig-r024-20210614
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- nios2-randconfig-r031-20210613
|   `-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|-- openrisc-allnoconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-sched-thread_info_api.h:error:expected-asm-or-__attribute__-before-token
|   `-- include-linux-sched-thread_info_api.h:error:macro-current_thread_info-passed-arguments-but-takes-just
|-- parisc-allyesconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched-thread_info_api.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-sched-thread_info_api.h:error:macro-current_thread_info-passed-arguments-but-takes-just
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- parisc-defconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched-thread_info_api.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-sched-thread_info_api.h:error:macro-current_thread_info-passed-arguments-but-takes-just
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- parisc-randconfig-r011-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched-thread_info_api.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-sched-thread_info_api.h:error:macro-current_thread_info-passed-arguments-but-takes-just
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- parisc-randconfig-r021-20210613
|   `-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|-- parisc-randconfig-r033-20210615
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched-thread_info_api.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-sched-thread_info_api.h:error:macro-current_thread_info-passed-arguments-but-takes-just
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- powerpc-allmodconfig
|   |-- arch-powerpc-include-asm-book3s-hash.h:error:expected-asm-or-__attribute__-before-hash__vmemmap_create_mapping
|   |-- arch-powerpc-include-asm-book3s-kup.h:error:request-for-member-regs-in-something-not-a-structure-or-union
|   |-- arch-powerpc-include-asm-book3s-mmu.h:error:expected-asm-or-__attribute__-before-early_init_mmu
|   |-- arch-powerpc-include-asm-book3s-pgtable.h:error:expected-asm-or-__attribute__-before-vmemmap_create_mapping
|   |-- arch-powerpc-include-asm-book3s-radix.h:error:expected-asm-or-__attribute__-before-radix__vmemmap_create_mapping
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compat.h:error:field-ru_stime-has-incomplete-type
|   |-- include-linux-compat.h:error:field-ru_utime-has-incomplete-type
|   |-- include-linux-compat.h:error:implicit-declaration-of-function-copy_to_user
|   |-- include-linux-compat.h:error:implicit-declaration-of-function-ns_to_kernel_old_timeval
|   |-- include-linux-compat.h:error:return-type-is-an-incomplete-type
|   |-- include-linux-compat.h:error:storage-size-of-ctv-isn-t-known
|   |-- include-linux-compat.h:error:storage-size-of-tv-isn-t-known
|   |-- include-linux-compat.h:error:unknown-type-name-rwf_t
|   |-- include-linux-compat.h:warning:struct-__kernel_timespec-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-file_handle-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-io_event-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-iovec-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-old_timespec32-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-pollfd-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-timezone-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   |-- include-linux-sched.h:error:field-irqtrace-has-incomplete-type
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   |-- include-linux-time32.h:error:conflicting-types-for-ns_to_kernel_old_timeval
|   `-- include-linux-uaccess.h:error:conflicting-types-for-copy_to_user
|-- powerpc-allnoconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- powerpc-allyesconfig
|   |-- arch-powerpc-include-asm-book3s-hash.h:error:expected-asm-or-__attribute__-before-hash__vmemmap_create_mapping
|   |-- arch-powerpc-include-asm-book3s-kup.h:error:request-for-member-regs-in-something-not-a-structure-or-union
|   |-- arch-powerpc-include-asm-book3s-mmu.h:error:expected-asm-or-__attribute__-before-early_init_mmu
|   |-- arch-powerpc-include-asm-book3s-pgtable.h:error:expected-asm-or-__attribute__-before-vmemmap_create_mapping
|   |-- arch-powerpc-include-asm-book3s-radix.h:error:expected-asm-or-__attribute__-before-radix__vmemmap_create_mapping
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compat.h:error:field-ru_stime-has-incomplete-type
|   |-- include-linux-compat.h:error:field-ru_utime-has-incomplete-type
|   |-- include-linux-compat.h:error:implicit-declaration-of-function-copy_to_user
|   |-- include-linux-compat.h:error:implicit-declaration-of-function-ns_to_kernel_old_timeval
|   |-- include-linux-compat.h:error:return-type-is-an-incomplete-type
|   |-- include-linux-compat.h:error:storage-size-of-ctv-isn-t-known
|   |-- include-linux-compat.h:error:storage-size-of-tv-isn-t-known
|   |-- include-linux-compat.h:error:unknown-type-name-rwf_t
|   |-- include-linux-compat.h:warning:struct-__kernel_timespec-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-file_handle-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-io_event-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-iovec-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-old_timespec32-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-pollfd-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-timezone-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   |-- include-linux-sched.h:error:field-irqtrace-has-incomplete-type
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   |-- include-linux-time32.h:error:conflicting-types-for-ns_to_kernel_old_timeval
|   `-- include-linux-uaccess.h:error:conflicting-types-for-copy_to_user
|-- powerpc-klondike_defconfig
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- powerpc-mpc8272_ads_defconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- powerpc-mpc8315_rdb_defconfig
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- powerpc-mpc837x_mds_defconfig
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- powerpc-ppc40x_defconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- powerpc-randconfig-r036-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|-- powerpc-walnut_defconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- powerpc64-randconfig-r022-20210614
|   |-- arch-powerpc-include-asm-book3s-hash.h:error:expected-asm-or-__attribute__-before-hash__vmemmap_create_mapping
|   |-- arch-powerpc-include-asm-book3s-kup.h:error:request-for-member-regs-in-something-not-a-structure-or-union
|   |-- arch-powerpc-include-asm-book3s-mmu.h:error:expected-asm-or-__attribute__-before-early_init_mmu
|   |-- arch-powerpc-include-asm-book3s-pgtable.h:error:expected-asm-or-__attribute__-before-vmemmap_create_mapping
|   |-- arch-powerpc-include-asm-book3s-radix.h:error:expected-asm-or-__attribute__-before-radix__vmemmap_create_mapping
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compat.h:error:field-ru_stime-has-incomplete-type
|   |-- include-linux-compat.h:error:field-ru_utime-has-incomplete-type
|   |-- include-linux-compat.h:error:implicit-declaration-of-function-copy_to_user
|   |-- include-linux-compat.h:error:implicit-declaration-of-function-ns_to_kernel_old_timeval
|   |-- include-linux-compat.h:error:return-type-is-an-incomplete-type
|   |-- include-linux-compat.h:error:storage-size-of-ctv-isn-t-known
|   |-- include-linux-compat.h:error:storage-size-of-tv-isn-t-known
|   |-- include-linux-compat.h:error:unknown-type-name-rwf_t
|   |-- include-linux-compat.h:warning:struct-__kernel_timespec-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-file_handle-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-io_event-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-iovec-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-old_timespec32-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-pollfd-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-compat.h:warning:struct-timezone-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   |-- include-linux-sched.h:error:field-irqtrace-has-incomplete-type
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|   |-- include-linux-time32.h:error:conflicting-types-for-ns_to_kernel_old_timeval
|   `-- include-linux-uaccess.h:error:conflicting-types-for-copy_to_user
|-- powerpc64-randconfig-r036-20210615
|   |-- arch-powerpc-include-asm-book3s-hash.h:error:expected-asm-or-__attribute__-before-hash__vmemmap_create_mapping
|   |-- arch-powerpc-include-asm-book3s-kup.h:error:request-for-member-regs-in-something-not-a-structure-or-union
|   |-- arch-powerpc-include-asm-book3s-mmu.h:error:expected-asm-or-__attribute__-before-early_init_mmu
|   |-- arch-powerpc-include-asm-book3s-pgtable.h:error:expected-asm-or-__attribute__-before-vmemmap_create_mapping
|   |-- arch-powerpc-include-asm-book3s-radix.h:error:expected-asm-or-__attribute__-before-radix__vmemmap_create_mapping
|   |-- arch-powerpc-include-asm-mmu.h:error:rodata_enabled-undeclared-(first-use-in-this-function)
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- riscv-allmodconfig
|   |-- arch-riscv-kernel-asm-offsets.c:error:implicit-declaration-of-function-ALIGN
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-stack_canary
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread_info
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- riscv-allnoconfig
|   |-- arch-riscv-kernel-asm-offsets.c:error:implicit-declaration-of-function-ALIGN
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread_info
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- riscv-allyesconfig
|   |-- arch-riscv-kernel-asm-offsets.c:error:implicit-declaration-of-function-ALIGN
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-stack_canary
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread_info
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- riscv-defconfig
|   |-- arch-riscv-kernel-asm-offsets.c:error:implicit-declaration-of-function-ALIGN
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-stack_canary
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread_info
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- riscv-nommu_k210_defconfig
|   |-- arch-riscv-kernel-asm-offsets.c:error:implicit-declaration-of-function-ALIGN
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread_info
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- riscv-nommu_virt_defconfig
|   |-- arch-riscv-kernel-asm-offsets.c:error:implicit-declaration-of-function-ALIGN
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-stack_canary
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread_info
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- riscv-randconfig-p002-20210613
|   |-- arch-riscv-kernel-asm-offsets.c:error:implicit-declaration-of-function-ALIGN
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-stack_canary
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread_info
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- riscv-randconfig-r025-20210614
|   |-- arch-riscv-kernel-asm-offsets.c:error:implicit-declaration-of-function-ALIGN
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread_info
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- riscv-rv32_defconfig
|   |-- arch-riscv-kernel-asm-offsets.c:error:implicit-declaration-of-function-ALIGN
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-stack_canary
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread_info
|   `-- include-linux-syscall_user_dispatch.h:error:EINVAL-undeclared-(first-use-in-this-function)
|-- s390-allmodconfig
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- s390-allyesconfig
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- s390-defconfig
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- s390-randconfig-r005-20210613
|   |-- arch-s390-include-asm-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- sh-allmodconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-did-you-mean
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-did-you-mean
|   `-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-did-you-mean
|-- sh-rsk7201_defconfig
|   `-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|-- sparc-randconfig-r015-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-did-you-mean
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-did-you-mean
|   `-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-did-you-mean
|-- sparc-randconfig-r026-20210614
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   `-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|-- sparc-randconfig-r031-20210615
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   `-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|-- sparc64-randconfig-p002-20210614
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   `-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|-- sparc64-randconfig-r001-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-did-you-mean
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-did-you-mean
|   `-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-did-you-mean
|-- sparc64-randconfig-r015-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-did-you-mean
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-did-you-mean
|   `-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-did-you-mean
|-- sparc64-randconfig-r023-20210614
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-did-you-mean
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-did-you-mean
|   `-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-did-you-mean
|-- um-i386_defconfig
|   |-- arch-x86-include-asm-page_32_types.h:warning:THREAD_SIZE-redefined
|   `-- arch-x86-include-asm-page_32_types.h:warning:THREAD_SIZE_ORDER-redefined
|-- um-x86_64_defconfig
|   |-- arch-um-include-asm-processor-generic.h:warning:TASK_SIZE-redefined
|   |-- arch-um-include-shared-common-offsets.h:error:HZ-undeclared-(first-use-in-this-function)
|   |-- arch-x86-include-asm-page_64_types.h:warning:THREAD_SIZE-redefined
|   |-- arch-x86-include-asm-page_64_types.h:warning:THREAD_SIZE_ORDER-redefined
|   |-- arch-x86-include-asm-page_types.h:warning:PAGE_OFFSET-redefined
|   |-- arch-x86-include-asm-page_types.h:warning:PAGE_SIZE-redefined
|   `-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|-- x86_64-allnoconfig
|   |-- Warning:Kernel-ABI-header-at-tools-perf-trace-beauty-include-linux-socket.h-differs-from-latest-version-at-include-linux-socket.h:.1g-requires-sa_family_t-and-that-sa_data-is-char.
|   |-- Warning:Kernel-ABI-header-at-tools-perf-trace-beauty-include-linux-socket.h-differs-from-latest-version-at-include-linux-socket.h:char-sa_data-bytes-of-protocol-address
|   |-- Warning:Kernel-ABI-header-at-tools-perf-trace-beauty-include-linux-socket.h-differs-from-latest-version-at-include-linux-socket.h:include-linux-socket_types.h
|   |-- Warning:Kernel-ABI-header-at-tools-perf-trace-beauty-include-linux-socket.h-differs-from-latest-version-at-include-linux-socket.h:include-linux-time64.h
|   |-- Warning:Kernel-ABI-header-at-tools-perf-trace-beauty-include-linux-socket.h-differs-from-latest-version-at-include-linux-socket.h:include-uapi-linux-socket.h
|   |-- Warning:Kernel-ABI-header-at-tools-perf-trace-beauty-include-linux-socket.h-differs-from-latest-version-at-include-linux-socket.h:int-l_linger-How-long-to-linger-for
|   |-- Warning:Kernel-ABI-header-at-tools-perf-trace-beauty-include-linux-socket.h-differs-from-latest-version-at-include-linux-socket.h:int-l_onoff-Linger-active
|   |-- Warning:Kernel-ABI-header-at-tools-perf-trace-beauty-include-linux-socket.h-differs-from-latest-version-at-include-linux-socket.h:sa_family_t-sa_family-address-family-AF_xxx
|   |-- Warning:Kernel-ABI-header-at-tools-perf-trace-beauty-include-linux-socket.h-differs-from-latest-version-at-include-linux-socket.h:struct-linger
|   |-- Warning:Kernel-ABI-header-at-tools-perf-trace-beauty-include-linux-socket.h-differs-from-latest-version-at-include-linux-socket.h:struct-sockaddr
|   |-- Warning:Kernel-ABI-header-at-tools-perf-trace-beauty-include-linux-socket.h-differs-from-latest-version-at-include-linux-socket.h:struct-timespec64
|   |-- Warning:Kernel-ABI-header-at-tools-perf-trace-beauty-include-linux-socket.h-differs-from-latest-version-at-include-linux-socket.h:typedef-__kernel_sa_family_t-sa_family_t
|   |-- arch-x86-include-asm-processor.h:linux-sched-thread.h-is-included-more-than-once.
|   |-- drivers-atm-solos-pci.c:solos-attrlist.c-is-included-more-than-once.
|   |-- drivers-dma-buf-selftest.c:selftests.h-is-included-more-than-once.
|   |-- drivers-video-backlight-cr_bllcd.c:linux-backlight.h-is-included-more-than-once.
|   |-- drivers-video-backlight-da9052_bl.c:linux-backlight.h-is-included-more-than-once.
|   |-- drivers-video-backlight-kb3886_bl.c:linux-backlight.h-is-included-more-than-once.
|   |-- drivers-video-backlight-lm3639_bl.c:linux-backlight.h-is-included-more-than-once.
|   |-- drivers-video-backlight-rave-sp-backlight.c:linux-backlight.h-is-included-more-than-once.
|   |-- fs-namei.c:linux-audit.h-is-included-more-than-once.
|   |-- fs-ocfs2-dir.c:linux-iversion.h-is-included-more-than-once.
|   |-- fs-ocfs2-dlm-dlmrecovery.c:linux-stringhash.h-is-included-more-than-once.
|   |-- kernel-bpf-inode.c:linux-seq_file.h-is-included-more-than-once.
|   |-- kernel-exec_domain.c:linux-syscalls.h-is-included-more-than-once.
|   `-- net-core-sock.c:linux-poll.h-is-included-more-than-once.
|-- x86_64-kexec
|   |-- arch-x86-include-asm-page_64_types.h:error:implicit-declaration-of-function-test_thread_flag
|   |-- drivers-acpi-apei-erst-dbg.c:error:CAP_SYS_ADMIN-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-apei-erst-dbg.c:error:implicit-declaration-of-function-capable
|   |-- drivers-nvme-host-multipath.c:error:implicit-declaration-of-function-sysfs_emit
|   |-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-sysfs_add_file_to_group
|   |-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-sysfs_remove_file_from_group
|   |-- drivers-scsi-sg.c:error:implicit-declaration-of-function-sysfs_create_link
|   |-- drivers-scsi-sg.c:error:implicit-declaration-of-function-sysfs_remove_link
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rt
|   |-- include-linux-kern_levels.h:warning:format-llu-expects-argument-of-type-long-long-unsigned-int-but-argument-has-type-int
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rt
|   |-- include-linux-security.h:error:unknown-type-name-key_ref_t
|   |-- lib-test_bitmap.c:error:implicit-declaration-of-function-DIV_ROUND_UP
|   |-- lib-test_bitmap.c:error:implicit-declaration-of-function-ktime_get
|   |-- lib-test_bitmap.c:error:implicit-declaration-of-function-round_up
|   |-- lib-test_bitmap.c:error:unknown-type-name-ktime_t
|   |-- lib-test_sysctl.c:error:SYSCTL_ONE-undeclared-here-(not-in-a-function)
|   |-- lib-test_sysctl.c:error:SYSCTL_ZERO-undeclared-here-(not-in-a-function)
|   |-- lib-test_sysctl.c:error:array-type-has-incomplete-element-type-struct-ctl_table
|   |-- lib-test_sysctl.c:error:field-name-not-in-record-or-union-initializer
|   |-- lib-test_sysctl.c:error:implicit-declaration-of-function-register_sysctl_table
|   |-- lib-test_sysctl.c:error:implicit-declaration-of-function-unregister_sysctl_table
|   |-- lib-test_sysctl.c:error:proc_do_large_bitmap-undeclared-here-(not-in-a-function)
|   |-- lib-test_sysctl.c:error:proc_dointvec-undeclared-here-(not-in-a-function)
|   |-- lib-test_sysctl.c:error:proc_dointvec_minmax-undeclared-here-(not-in-a-function)
|   |-- lib-test_sysctl.c:error:proc_dostring-undeclared-here-(not-in-a-function)
|   |-- lib-test_sysctl.c:error:proc_douintvec-undeclared-here-(not-in-a-function)
|   `-- security-keys-permission.c:error:implicit-declaration-of-function-security_key_permission
|-- x86_64-rhel-8.3
|   |-- arch-x86-include-asm-thread_info.h:error:implicit-declaration-of-function-current_thread_info
|   |-- arch-x86-include-asm-thread_info.h:error:invalid-type-argument-of-(have-int-)
|   |-- crypto-arc4.c:warning:parameter-names-(without-types)-in-function-declaration
|   |-- drivers-acpi-apei-erst-dbg.c:error:CAP_SYS_ADMIN-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-apei-erst-dbg.c:error:implicit-declaration-of-function-capable
|   |-- drivers-pci-pcie-aer_inject.c:error:CAP_SYS_ADMIN-undeclared-(first-use-in-this-function)
|   |-- drivers-pci-pcie-aer_inject.c:error:implicit-declaration-of-function-capable
|   |-- fs-ext2-xattr_trusted.c:error:CAP_SYS_ADMIN-undeclared-(first-use-in-this-function)
|   |-- fs-ext2-xattr_trusted.c:error:implicit-declaration-of-function-capable
|   |-- include-kunit-test.h:error:implicit-declaration-of-function-__typecheck
|   |-- include-kunit-test.h:error:implicit-declaration-of-function-spin_lock
|   |-- include-kunit-test.h:error:implicit-declaration-of-function-spin_unlock
|   |-- include-kunit-test.h:error:implicit-declaration-of-function-strcmp
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rt
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rt
|   |-- include-linux-kthread.h:error:NUMA_NO_NODE-undeclared-(first-use-in-this-function)
|   |-- include-linux-kthread.h:error:implicit-declaration-of-function-wake_up_process
|   |-- include-linux-latencytop.h:warning:struct-ctl_table-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-printk.h:error:_rs-undeclared-(first-use-in-this-function)
|   |-- include-linux-printk.h:error:implicit-declaration-of-function-__ratelimit
|   |-- include-linux-printk.h:error:invalid-storage-class-for-function-DEFINE_RATELIMIT_STATE
|   |-- include-linux-printk.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RATELIMIT_STATE
|   |-- include-linux-spinlock.h:error:static-declaration-of-spin_lock-follows-non-static-declaration
|   |-- include-linux-spinlock.h:error:static-declaration-of-spin_unlock-follows-non-static-declaration
|   |-- include-linux-spinlock.h:warning:conflicting-types-for-spin_lock
|   |-- include-linux-spinlock.h:warning:conflicting-types-for-spin_unlock
|   |-- kernel-sysctl-test.c:error:implicit-declaration-of-function-memcpy
|   |-- kernel-sysctl-test.c:warning:incompatible-implicit-declaration-of-built-in-function-memcpy
|   |-- kernel-torture.c:error:implicit-declaration-of-function-cond_resched
|   |-- kernel-torture.c:error:implicit-declaration-of-function-cond_resched_tasks_rcu_qs
|   |-- kernel-torture.c:error:implicit-declaration-of-function-set_cpus_allowed_ptr
|   |-- kernel-trace-ring_buffer_benchmark.c:error:MAX_NICE-undeclared-here-(not-in-a-function)
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-__set_current_state
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-sched_set_fifo
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-sched_set_fifo_low
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-schedule
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-schedule_timeout
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-set_current_state
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-set_user_nice
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-wake_up_process
|   |-- lib-list-test.c:error:implicit-declaration-of-function-memset
|   |-- lib-list-test.c:warning:incompatible-implicit-declaration-of-built-in-function-memset
|   `-- mm-page_alloc.c:error:implicit-declaration-of-function-set_cpus_allowed_ptr
|-- x86_64-rhel-8.3-kbuiltin
|   |-- arch-x86-include-asm-thread_info.h:error:implicit-declaration-of-function-current_thread_info
|   |-- arch-x86-include-asm-thread_info.h:error:invalid-type-argument-of-(have-int-)
|   |-- crypto-arc4.c:warning:parameter-names-(without-types)-in-function-declaration
|   |-- drivers-pci-pcie-aer_inject.c:error:CAP_SYS_ADMIN-undeclared-(first-use-in-this-function)
|   |-- drivers-pci-pcie-aer_inject.c:error:implicit-declaration-of-function-capable
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-rt
|   |-- include-linux-kernel.h:error:struct-task_struct-has-no-member-named-rt
|   |-- include-linux-latencytop.h:warning:struct-ctl_table-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- include-linux-printk.h:error:_rs-undeclared-(first-use-in-this-function)
|   |-- include-linux-printk.h:error:implicit-declaration-of-function-__ratelimit
|   |-- include-linux-printk.h:error:invalid-storage-class-for-function-DEFINE_RATELIMIT_STATE
|   |-- include-linux-printk.h:error:type-defaults-to-int-in-declaration-of-DEFINE_RATELIMIT_STATE
|   |-- kernel-trace-ring_buffer_benchmark.c:error:MAX_NICE-undeclared-here-(not-in-a-function)
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-__set_current_state
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-sched_set_fifo
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-sched_set_fifo_low
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-schedule
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-schedule_timeout
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-set_current_state
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-set_user_nice
|   |-- kernel-trace-ring_buffer_benchmark.c:error:implicit-declaration-of-function-wake_up_process
|   `-- mm-page_alloc.c:error:implicit-declaration-of-function-set_cpus_allowed_ptr
|-- xtensa-allyesconfig
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
|   |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
|   |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory
|-- xtensa-randconfig-r025-20210613
|   `-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
`-- xtensa-randconfig-r035-20210615
    |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched
    |-- include-linux-compiler_types.h:error:struct-task_struct-has-no-member-named-thread
    |-- include-linux-sched.h:error:array-type-has-incomplete-element-type-struct-held_lock
    `-- include-linux-slab.h:fatal-error:asm-page_types.h:No-such-file-or-directory

clang_recent_errors
|-- arm-randconfig-r004-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched-Werror-Wimplicit-function-declaration
|   `-- include-linux-slab.h:fatal-error:asm-page_types.h-file-not-found
|-- arm-randconfig-r006-20210613
|   |-- include-asm-generic-preempt.h:error:implicit-declaration-of-function-tif_need_resched-Werror-Wimplicit-function-declaration
|   |-- include-linux-mutex.h:error:conflicting-types-for-mutex_unlock
|   |-- include-linux-sched.h:error:array-has-incomplete-element-type-struct-held_lock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-mutex
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-ww_mutex
|   |-- include-linux-slab.h:fatal-error:asm-page_types.h-file-not-found
|   `-- include-linux-ww_mutex.h:error:conflicting-types-for-ww_mutex_unlock
|-- riscv-randconfig-r016-20210613
|   |-- arch-riscv-kernel-asm-offsets.c:error:no-member-named-thread-in-task_struct
|   |-- arch-riscv-kernel-asm-offsets.c:error:no-member-named-thread_info-in-task_struct
|   `-- include-linux-syscall_user_dispatch.h:error:use-of-undeclared-identifier-EINVAL
|-- x86_64-randconfig-a001-20210614
|   |-- arch-x86-include-asm-uaccess.h:error:implicit-declaration-of-function-in_task-Werror-Wimplicit-function-declaration
|   |-- include-linux-mutex.h:error:conflicting-types-for-mutex_unlock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-mutex
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-ww_mutex
|   |-- include-linux-uaccess.h:error:implicit-declaration-of-function-in_task-Werror-Wimplicit-function-declaration
|   `-- include-linux-ww_mutex.h:error:conflicting-types-for-ww_mutex_unlock
|-- x86_64-randconfig-a002-20210614
|   |-- include-linux-mutex.h:error:conflicting-types-for-mutex_unlock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-mutex
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-ww_mutex
|   `-- include-linux-ww_mutex.h:error:conflicting-types-for-ww_mutex_unlock
|-- x86_64-randconfig-a003-20210614
|   |-- include-linux-kernel.h:error:a-parameter-list-without-types-is-only-allowed-in-a-function-definition
|   |-- include-linux-kernel.h:error:called-object-type-int-is-not-a-function-or-function-pointer
|   |-- include-linux-kernel.h:error:implicit-declaration-of-function-static_call_mod-Werror-Wimplicit-function-declaration
|   `-- include-linux-kernel.h:warning:declaration-specifier-missing-defaulting-to-int
|-- x86_64-randconfig-a004-20210614
|   |-- include-linux-mutex.h:error:conflicting-types-for-mutex_unlock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-mutex
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-ww_mutex
|   `-- include-linux-ww_mutex.h:error:conflicting-types-for-ww_mutex_unlock
|-- x86_64-randconfig-a005-20210614
|   |-- include-linux-kernel.h:error:a-parameter-list-without-types-is-only-allowed-in-a-function-definition
|   |-- include-linux-kernel.h:error:called-object-type-int-is-not-a-function-or-function-pointer
|   |-- include-linux-kernel.h:error:implicit-declaration-of-function-static_call_mod-Werror-Wimplicit-function-declaration
|   `-- include-linux-kernel.h:warning:declaration-specifier-missing-defaulting-to-int
|-- x86_64-randconfig-a006-20210614
|   |-- include-linux-mutex.h:error:conflicting-types-for-mutex_unlock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-mutex
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-ww_mutex
|   `-- include-linux-ww_mutex.h:error:conflicting-types-for-ww_mutex_unlock
|-- x86_64-randconfig-a011-20210615
|   |-- arch-x86-include-asm-uaccess.h:error:implicit-declaration-of-function-in_task-Werror-Wimplicit-function-declaration
|   |-- include-linux-mutex.h:error:conflicting-types-for-mutex_unlock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-mutex
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-ww_mutex
|   |-- include-linux-uaccess.h:error:implicit-declaration-of-function-in_task-Werror-Wimplicit-function-declaration
|   `-- include-linux-ww_mutex.h:error:conflicting-types-for-ww_mutex_unlock
|-- x86_64-randconfig-a012-20210615
|   |-- include-linux-mutex.h:error:conflicting-types-for-mutex_unlock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-mutex
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-ww_mutex
|   `-- include-linux-ww_mutex.h:error:conflicting-types-for-ww_mutex_unlock
|-- x86_64-randconfig-a013-20210613
|   |-- include-linux-kernel.h:error:a-parameter-list-without-types-is-only-allowed-in-a-function-definition
|   |-- include-linux-kernel.h:error:called-object-type-int-is-not-a-function-or-function-pointer
|   |-- include-linux-kernel.h:error:implicit-declaration-of-function-static_call_mod-Werror-Wimplicit-function-declaration
|   `-- include-linux-kernel.h:warning:declaration-specifier-missing-defaulting-to-int
|-- x86_64-randconfig-a013-20210615
|   |-- include-linux-kernel.h:error:a-parameter-list-without-types-is-only-allowed-in-a-function-definition
|   |-- include-linux-kernel.h:error:called-object-type-int-is-not-a-function-or-function-pointer
|   |-- include-linux-kernel.h:error:implicit-declaration-of-function-static_call_mod-Werror-Wimplicit-function-declaration
|   `-- include-linux-kernel.h:warning:declaration-specifier-missing-defaulting-to-int
|-- x86_64-randconfig-a014-20210615
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-Werror-Wimplicit-function-declaration
|   `-- include-linux-ww_mutex.h:error:conflicting-types-for-ww_mutex_unlock
|-- x86_64-randconfig-a015-20210613
|   |-- arch-x86-include-asm-uaccess.h:error:implicit-declaration-of-function-in_task-Werror-Wimplicit-function-declaration
|   |-- include-linux-mutex.h:error:conflicting-types-for-mutex_unlock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-mutex
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-ww_mutex
|   |-- include-linux-uaccess.h:error:implicit-declaration-of-function-in_task-Werror-Wimplicit-function-declaration
|   `-- include-linux-ww_mutex.h:error:conflicting-types-for-ww_mutex_unlock
|-- x86_64-randconfig-a015-20210615
|   |-- arch-x86-include-asm-uaccess.h:error:implicit-declaration-of-function-in_task-Werror-Wimplicit-function-declaration
|   |-- include-linux-mutex.h:error:conflicting-types-for-mutex_unlock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-mutex
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-ww_mutex
|   |-- include-linux-uaccess.h:error:implicit-declaration-of-function-in_task-Werror-Wimplicit-function-declaration
|   `-- include-linux-ww_mutex.h:error:conflicting-types-for-ww_mutex_unlock
|-- x86_64-randconfig-a016-20210613
|   `-- include-linux-kernel.h:warning:declaration-specifier-missing-defaulting-to-int
|-- x86_64-randconfig-a016-20210615
|   |-- include-linux-kernel.h:error:a-parameter-list-without-types-is-only-allowed-in-a-function-definition
|   |-- include-linux-kernel.h:error:called-object-type-int-is-not-a-function-or-function-pointer
|   |-- include-linux-kernel.h:error:implicit-declaration-of-function-static_call_mod-Werror-Wimplicit-function-declaration
|   `-- include-linux-kernel.h:warning:declaration-specifier-missing-defaulting-to-int
|-- x86_64-randconfig-b001-20210613
|   |-- include-linux-kernel.h:error:a-parameter-list-without-types-is-only-allowed-in-a-function-definition
|   |-- include-linux-kernel.h:error:called-object-type-int-is-not-a-function-or-function-pointer
|   |-- include-linux-kernel.h:error:implicit-declaration-of-function-static_call_mod-Werror-Wimplicit-function-declaration
|   `-- include-linux-kernel.h:warning:declaration-specifier-missing-defaulting-to-int
|-- x86_64-randconfig-b001-20210614
|   |-- include-linux-mutex.h:error:conflicting-types-for-mutex_unlock
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_lock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:implicit-declaration-of-function-ww_mutex_unlock-Werror-Wimplicit-function-declaration
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-mutex
|   |-- include-linux-seqlock.h:error:incomplete-definition-of-type-struct-ww_mutex
|   `-- include-linux-ww_mutex.h:error:conflicting-types-for-ww_mutex_unlock
`-- x86_64-randconfig-r011-20210613
    |-- include-linux-kernel.h:error:a-parameter-list-without-types-is-only-allowed-in-a-function-definition
    |-- include-linux-kernel.h:error:called-object-type-int-is-not-a-function-or-function-pointer
    |-- include-linux-kernel.h:error:implicit-declaration-of-function-static_call_mod-Werror-Wimplicit-function-declaration
    `-- include-linux-kernel.h:warning:declaration-specifier-missing-defaulting-to-int

elapsed time: 2436m

configs tested: 115
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    klondike_defconfig
csky                             alldefconfig
powerpc                 mpc837x_mds_defconfig
arm                       spear13xx_defconfig
arm                          pxa910_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                      malta_kvm_defconfig
arm                          pcm027_defconfig
powerpc                      ppc40x_defconfig
arm                          simpad_defconfig
sh                          rsk7201_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      walnut_defconfig
m68k                        mvme16x_defconfig
arm                         mv78xx0_defconfig
arm                            dove_defconfig
mips                      maltasmvp_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210613
i386                 randconfig-a006-20210613
i386                 randconfig-a001-20210613
i386                 randconfig-a004-20210613
i386                 randconfig-a005-20210613
i386                 randconfig-a003-20210613
i386                 randconfig-a002-20210614
i386                 randconfig-a006-20210614
i386                 randconfig-a004-20210614
i386                 randconfig-a001-20210614
i386                 randconfig-a005-20210614
i386                 randconfig-a003-20210614
i386                 randconfig-a015-20210613
i386                 randconfig-a013-20210613
i386                 randconfig-a016-20210613
i386                 randconfig-a014-20210613
i386                 randconfig-a012-20210613
i386                 randconfig-a011-20210613
x86_64               randconfig-a002-20210613
x86_64               randconfig-a004-20210613
x86_64               randconfig-a001-20210613
x86_64               randconfig-a003-20210613
x86_64               randconfig-a006-20210613
x86_64               randconfig-a005-20210613
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210613
x86_64               randconfig-b001-20210614
x86_64               randconfig-a001-20210614
x86_64               randconfig-a004-20210614
x86_64               randconfig-a002-20210614
x86_64               randconfig-a003-20210614
x86_64               randconfig-a006-20210614
x86_64               randconfig-a005-20210614
x86_64               randconfig-a015-20210613
x86_64               randconfig-a011-20210613
x86_64               randconfig-a014-20210613
x86_64               randconfig-a012-20210613
x86_64               randconfig-a013-20210613
x86_64               randconfig-a016-20210613
x86_64               randconfig-a015-20210615
x86_64               randconfig-a011-20210615
x86_64               randconfig-a012-20210615
x86_64               randconfig-a014-20210615
x86_64               randconfig-a016-20210615
x86_64               randconfig-a013-20210615

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
