Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68949460162
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 21:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244821AbhK0UOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 15:14:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:19244 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356089AbhK0UMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 15:12:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="222653498"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="222653498"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 12:09:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="652448379"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 27 Nov 2021 12:09:05 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mr40O-0009wX-Oy; Sat, 27 Nov 2021 20:09:04 +0000
Date:   Sun, 28 Nov 2021 04:08:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD REGRESSION
 4e0d84634445ed550498d613a49ea8f6cfa5e66c
Message-ID: <61a29028.tpnDCIZi2QXrPudU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 4e0d84634445ed550498d613a49ea8f6cfa5e66c  futex: Fix sparc32/m68k/nds32 build regression

possible Error/Warning in current branch (please contact us if interested):

arch/mips/include/asm/futex.h:132:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
arch/mips/include/asm/futex.h:23:39: error: invalid storage class for function 'futex_atomic_cmpxchg_inatomic'
arch/mips/include/asm/futex.h:89:23: error: implicit declaration of function 'arch_futex_atomic_op_inuser_local'; did you mean 'futex_atomic_op_inuser_local'? [-Werror=implicit-function-declaration]
arch/xtensa/include/asm/futex.h:112:16: error: implicit declaration of function 'arch_futex_atomic_op_inuser_local'; did you mean 'futex_atomic_op_inuser_local'? [-Werror=implicit-function-declaration]
include/asm-generic/current.h:7:23: error: initialization of 'struct futex_pi_state *' from incompatible pointer type 'struct futex_pi_state *' [-Werror=incompatible-pointer-types]
include/linux/compat.h:78:28: error: invalid storage class for function '__do_compat_sys_get_robust_list'
include/linux/compat.h:78:28: error: invalid storage class for function '__do_compat_sys_set_robust_list'
include/linux/compat.h:80:25: error: static declaration of '__se_compat_sys_get_robust_list' follows non-static declaration
include/linux/compat.h:80:25: error: static declaration of '__se_compat_sys_set_robust_list' follows non-static declaration
include/linux/compat.h:82:28: error: implicit declaration of function '__do_compat_sys_get_robust_list'; did you mean '__do_compat_sys_set_robust_list'? [-Werror=implicit-function-declaration]
include/linux/compat.h:82:28: error: implicit declaration of function '__do_compat_sys_set_robust_list'; did you mean '__se_compat_sys_set_robust_list'? [-Werror=implicit-function-declaration]
include/linux/syscalls.h:155:40: error: redeclaration of '__syscall_meta__futex' with no linkage
include/linux/syscalls.h:155:40: error: redeclaration of '__syscall_meta__futex_time32' with no linkage
include/linux/syscalls.h:155:40: error: redeclaration of '__syscall_meta__futex_waitv' with no linkage
include/linux/syscalls.h:155:40: error: redeclaration of '__syscall_meta__get_robust_list' with no linkage
include/linux/syscalls.h:155:40: error: redeclaration of '__syscall_meta__set_robust_list' with no linkage
include/linux/syscalls.h:245:28: error: invalid storage class for function '__do_sys_futex'
include/linux/syscalls.h:245:28: error: invalid storage class for function '__do_sys_futex_time32'
include/linux/syscalls.h:245:28: error: invalid storage class for function '__do_sys_futex_waitv'
include/linux/syscalls.h:245:28: error: invalid storage class for function '__do_sys_get_robust_list'
include/linux/syscalls.h:245:28: error: invalid storage class for function '__do_sys_set_robust_list'
include/linux/syscalls.h:247:25: error: static declaration of '__se_sys_futex' follows non-static declaration
include/linux/syscalls.h:247:25: error: static declaration of '__se_sys_futex_time32' follows non-static declaration
include/linux/syscalls.h:247:25: error: static declaration of '__se_sys_futex_waitv' follows non-static declaration
include/linux/syscalls.h:247:25: error: static declaration of '__se_sys_get_robust_list' follows non-static declaration
include/linux/syscalls.h:247:25: error: static declaration of '__se_sys_set_robust_list' follows non-static declaration
include/linux/syscalls.h:249:28: error: implicit declaration of function '__do_sys_futex'; did you mean '__se_sys_futex'? [-Werror=implicit-function-declaration]
include/linux/syscalls.h:249:28: error: implicit declaration of function '__do_sys_futex_time32'; did you mean '__se_sys_futex_time32'? [-Werror=implicit-function-declaration]
include/linux/syscalls.h:249:28: error: implicit declaration of function '__do_sys_futex_waitv'; did you mean '__se_sys_futex_waitv'? [-Werror=implicit-function-declaration]
include/linux/syscalls.h:249:28: error: implicit declaration of function '__do_sys_get_robust_list'; did you mean '__do_sys_set_robust_list'? [-Werror=implicit-function-declaration]
include/linux/syscalls.h:249:28: error: implicit declaration of function '__do_sys_set_robust_list'; did you mean '__se_sys_set_robust_list'? [-Werror=implicit-function-declaration]
kernel/futex/../locking/rtmutex_common.h:103:20: error: invalid storage class for function 'rt_mutex_waiter_is_top_waiter'
kernel/futex/../locking/rtmutex_common.h:111:39: error: invalid storage class for function 'rt_mutex_top_waiter'
kernel/futex/../locking/rtmutex_common.h:123:19: error: invalid storage class for function 'task_has_pi_waiters'
kernel/futex/../locking/rtmutex_common.h:128:39: error: invalid storage class for function 'task_top_pi_waiter'
kernel/futex/../locking/rtmutex_common.h:136:35: error: invalid storage class for function 'rt_mutex_owner'
kernel/futex/../locking/rtmutex_common.h:158:20: error: invalid storage class for function '__rt_mutex_base_init'
kernel/futex/../locking/rtmutex_common.h:166:20: error: invalid storage class for function 'debug_rt_mutex_unlock'
kernel/futex/../locking/rtmutex_common.h:172:20: error: invalid storage class for function 'debug_rt_mutex_proxy_unlock'
kernel/futex/../locking/rtmutex_common.h:178:20: error: invalid storage class for function 'debug_rt_mutex_init_waiter'
kernel/futex/../locking/rtmutex_common.h:184:20: error: invalid storage class for function 'debug_rt_mutex_free_waiter'
kernel/futex/../locking/rtmutex_common.h:190:20: error: invalid storage class for function 'rt_mutex_init_waiter'
kernel/futex/../locking/rtmutex_common.h:199:20: error: invalid storage class for function 'rt_mutex_init_rtlock_waiter'
kernel/futex/../locking/rtmutex_common.h:93:19: error: invalid storage class for function 'rt_mutex_has_waiters'
kernel/futex/core.c:1007:13: error: invalid storage class for function 'futex_cleanup'
kernel/futex/core.c:1020:13: error: invalid storage class for function 'futex_cleanup'
kernel/futex/core.c:1050:13: error: invalid storage class for function 'futex_cleanup_begin'
kernel/futex/core.c:1063:13: error: invalid storage class for function 'futex_cleanup_begin'
kernel/futex/core.c:1076:13: error: invalid storage class for function 'futex_cleanup_end'
kernel/futex/core.c:1089:13: error: invalid storage class for function 'futex_cleanup_end'
kernel/futex/core.c:1115:19: error: invalid storage class for function 'futex_init'
kernel/futex/core.c:1141:1: error: expected declaration or statement at end of input
kernel/futex/core.c:1148:19: error: invalid storage class for function 'futex_init'
kernel/futex/core.c:115:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
kernel/futex/core.c:115:27: error: static declaration of 'futex_hash' follows non-static declaration
kernel/futex/core.c:1176:15: error: initializer element is not constant
kernel/futex/core.c:1176:1: error: expected declaration or statement at end of input
kernel/futex/core.c:120:27: error: static declaration of 'futex_hash' follows non-static declaration
kernel/futex/core.c:135:1: error: static declaration of 'futex_setup_timer' follows non-static declaration
kernel/futex/core.c:140:1: error: static declaration of 'futex_setup_timer' follows non-static declaration
kernel/futex/core.c:171:12: error: invalid storage class for function 'get_inode_sequence_number'
kernel/futex/core.c:176:12: error: invalid storage class for function 'get_inode_sequence_number'
kernel/futex/core.c:220:5: error: static declaration of 'get_futex_key' follows non-static declaration
kernel/futex/core.c:225:5: error: static declaration of 'get_futex_key' follows non-static declaration
kernel/futex/core.c:409:5: error: static declaration of 'fault_in_user_writeable' follows non-static declaration
kernel/futex/core.c:414:5: error: static declaration of 'fault_in_user_writeable' follows non-static declaration
kernel/futex/core.c:429:17: error: static declaration of 'futex_top_waiter' follows non-static declaration
kernel/futex/core.c:434:17: error: static declaration of 'futex_top_waiter' follows non-static declaration
kernel/futex/core.c:440:5: error: static declaration of 'futex_cmpxchg_value_locked' follows non-static declaration
kernel/futex/core.c:445:5: error: static declaration of 'futex_cmpxchg_value_locked' follows non-static declaration
kernel/futex/core.c:451:5: error: static declaration of 'futex_get_value_locked' follows non-static declaration
kernel/futex/core.c:456:5: error: static declaration of 'futex_get_value_locked' follows non-static declaration
kernel/futex/core.c:469:6: error: static declaration of 'wait_for_owner_exiting' follows non-static declaration
kernel/futex/core.c:474:6: error: static declaration of 'wait_for_owner_exiting' follows non-static declaration
kernel/futex/core.c:499:6: error: static declaration of '__futex_unqueue' follows non-static declaration
kernel/futex/core.c:504:6: error: static declaration of '__futex_unqueue' follows non-static declaration
kernel/futex/core.c:513:27: error: static declaration of 'futex_q_lock' follows non-static declaration
kernel/futex/core.c:518:27: error: static declaration of 'futex_q_lock' follows non-static declaration
kernel/futex/core.c:536:6: error: static declaration of 'futex_q_unlock' follows non-static declaration
kernel/futex/core.c:541:6: error: static declaration of 'futex_q_unlock' follows non-static declaration
kernel/futex/core.c:543:6: error: static declaration of '__futex_queue' follows non-static declaration
kernel/futex/core.c:548:6: error: static declaration of '__futex_queue' follows non-static declaration
kernel/futex/core.c:573:5: error: static declaration of 'futex_unqueue' follows non-static declaration
kernel/futex/core.c:578:5: error: static declaration of 'futex_unqueue' follows non-static declaration
kernel/futex/core.c:620:6: error: static declaration of 'futex_unqueue_pi' follows non-static declaration
kernel/futex/core.c:625:6: error: static declaration of 'futex_unqueue_pi' follows non-static declaration
kernel/futex/core.c:637:12: error: invalid storage class for function 'handle_futex_death'
kernel/futex/core.c:642:12: error: invalid storage class for function 'handle_futex_death'
kernel/futex/core.c:71:19: error: invalid storage class for function 'setup_fail_futex'
kernel/futex/core.c:744:19: error: invalid storage class for function 'fetch_robust_entry'
kernel/futex/core.c:749:19: error: invalid storage class for function 'fetch_robust_entry'
kernel/futex/core.c:75:24: error: initializer element is not constant
kernel/futex/core.c:765:13: error: invalid storage class for function 'exit_robust_list'
kernel/futex/core.c:770:13: error: invalid storage class for function 'exit_robust_list'
kernel/futex/core.c:77:6: error: static declaration of 'should_fail_futex' follows non-static declaration
kernel/futex/core.c:836:21: error: invalid storage class for function 'futex_uaddr'
kernel/futex/core.c:849:1: error: invalid storage class for function 'compat_fetch_robust_entry'
kernel/futex/core.c:867:13: error: invalid storage class for function 'compat_exit_robust_list'
kernel/futex/core.c:87:19: error: invalid storage class for function 'fail_futex_debugfs'
kernel/futex/core.c:935:13: error: invalid storage class for function 'exit_pi_state_list'
kernel/futex/core.c:946:13: error: invalid storage class for function 'exit_pi_state_list'
kernel/futex/futex.h:134:19: error: invalid storage class for function 'futex_match'
kernel/futex/futex.h:140:19: error: invalid storage class for function 'futex_match'
kernel/futex/futex.h:169:20: error: invalid storage class for function 'futex_queue'
kernel/futex/futex.h:175:20: error: invalid storage class for function 'futex_queue'
kernel/futex/futex.h:183:20: error: invalid storage class for function 'futex_hb_waiters_inc'
kernel/futex/futex.h:189:20: error: invalid storage class for function 'futex_hb_waiters_inc'
kernel/futex/futex.h:198:20: error: invalid storage class for function 'futex_hb_waiters_dec'
kernel/futex/futex.h:204:20: error: invalid storage class for function 'futex_hb_waiters_dec'
kernel/futex/futex.h:205:19: error: invalid storage class for function 'futex_hb_waiters_pending'
kernel/futex/futex.h:211:19: error: invalid storage class for function 'futex_hb_waiters_pending'
kernel/futex/futex.h:238:1: error: invalid storage class for function 'double_lock_hb'
kernel/futex/futex.h:244:1: error: invalid storage class for function 'double_lock_hb'
kernel/futex/futex.h:249:1: error: invalid storage class for function 'double_unlock_hb'
kernel/futex/futex.h:255:1: error: invalid storage class for function 'double_unlock_hb'
kernel/futex/futex.h:39:20: error: invalid storage class for function 'should_fail_futex'
kernel/futex/pi.c:1100:5: error: static declaration of 'futex_unlock_pi' follows non-static declaration
kernel/futex/pi.c:1232:1: error: expected declaration or statement at end of input
kernel/futex/pi.c:12:5: error: static declaration of 'refill_pi_state_cache' follows non-static declaration
kernel/futex/pi.c:202:12: error: invalid storage class for function 'attach_to_pi_state'
kernel/futex/pi.c:30:33: error: assignment to 'struct futex_pi_state *' from incompatible pointer type 'struct futex_pi_state *' [-Werror=incompatible-pointer-types]
kernel/futex/pi.c:320:12: error: invalid storage class for function 'handle_exit_race'
kernel/futex/pi.c:35:31: error: invalid storage class for function 'alloc_pi_state'
kernel/futex/pi.c:376:13: error: invalid storage class for function '__attach_to_pi_owner'
kernel/futex/pi.c:410:12: error: invalid storage class for function 'attach_to_pi_owner'
kernel/futex/pi.c:45:13: error: invalid storage class for function 'pi_state_update_owner'
kernel/futex/pi.c:474:12: error: invalid storage class for function 'lock_pi_update_atomic'
kernel/futex/pi.c:514:5: error: static declaration of 'futex_lock_pi_atomic' follows non-static declaration
kernel/futex/pi.c:613:12: error: invalid storage class for function 'wake_futex_pi'
kernel/futex/pi.c:683:12: error: invalid storage class for function '__fixup_pi_state_owner'
kernel/futex/pi.c:68:6: error: static declaration of 'get_pi_state' follows non-static declaration
kernel/futex/pi.c:77:6: error: static declaration of 'put_pi_state' follows non-static declaration
kernel/futex/pi.c:855:12: error: invalid storage class for function 'fixup_pi_state_owner'
kernel/futex/pi.c:884:5: error: static declaration of 'fixup_pi_owner' follows non-static declaration
kernel/futex/pi.c:930:5: error: static declaration of 'futex_lock_pi' follows non-static declaration
kernel/futex/requeue.c:125:20: error: invalid storage class for function 'futex_requeue_pi_complete'
kernel/futex/requeue.c:156:19: error: invalid storage class for function 'futex_requeue_pi_wakeup_sync'
kernel/futex/requeue.c:223:6: error: invalid storage class for function 'requeue_pi_wake_futex'
kernel/futex/requeue.c:267:1: error: invalid storage class for function 'futex_proxy_trylock_atomic'
kernel/futex/requeue.c:364:5: error: static declaration of 'futex_requeue' follows non-static declaration
kernel/futex/requeue.c:59:22: error: declaration of 'futex_q_init' with no linkage follows extern declaration
kernel/futex/requeue.c:628:53: error: passing argument 2 of 'rt_mutex_start_proxy_lock' from incompatible pointer type [-Werror=incompatible-pointer-types]
kernel/futex/requeue.c:691:5: error: invalid storage class for function 'handle_early_requeue_pi_wakeup'
kernel/futex/requeue.c:74:6: error: invalid storage class for function 'requeue_futex'
kernel/futex/requeue.c:762:5: error: static declaration of 'futex_wait_requeue_pi' follows non-static declaration
kernel/futex/requeue.c:797:21: error: assignment to 'struct rt_mutex_waiter *' from incompatible pointer type 'struct rt_mutex_waiter *' [-Werror=incompatible-pointer-types]
kernel/futex/requeue.c:896:1: error: expected declaration or statement at end of input
kernel/futex/requeue.c:92:20: error: invalid storage class for function 'futex_requeue_pi_prepare'
kernel/futex/syscalls.c:137:29: error: invalid storage class for function 'futex_cmd_has_timeout'
kernel/futex/syscalls.c:151:1: error: invalid storage class for function 'futex_init_timeout'
kernel/futex/syscalls.c:153:29: error: invalid storage class for function 'futex_cmd_has_timeout'
kernel/futex/syscalls.c:167:1: error: invalid storage class for function 'futex_init_timeout'
kernel/futex/syscalls.c:197:12: error: invalid storage class for function 'futex_parse_waitv'
kernel/futex/syscalls.c:213:12: error: invalid storage class for function 'futex_parse_waitv'
kernel/futex/syscalls.c:29:41: warning: 'alias' attribute ignored [-Wattributes]
kernel/futex/syscalls.c:374:1: error: expected declaration or statement at end of input
kernel/futex/syscalls.c:396:1: error: expected declaration or statement at end of input
kernel/futex/waitwake.c:115:6: error: static declaration of 'futex_wake_mark' follows non-static declaration
kernel/futex/waitwake.c:143:5: error: static declaration of 'futex_wake' follows non-static declaration
kernel/futex/waitwake.c:188:12: error: invalid storage class for function 'futex_atomic_op_inuser'
kernel/futex/waitwake.c:238:5: error: static declaration of 'futex_wake_op' follows non-static declaration
kernel/futex/waitwake.c:320:13: error: invalid storage class for function 'futex_wait_restart'
kernel/futex/waitwake.c:328:6: error: static declaration of 'futex_wait_queue' follows non-static declaration
kernel/futex/waitwake.c:371:12: error: invalid storage class for function 'unqueue_multiple'
kernel/futex/waitwake.c:399:12: error: invalid storage class for function 'futex_wait_multiple_setup'
kernel/futex/waitwake.c:496:13: error: invalid storage class for function 'futex_sleep_multiple'
kernel/futex/waitwake.c:524:5: error: static declaration of 'futex_wait_multiple' follows non-static declaration
kernel/futex/waitwake.c:577:5: error: static declaration of 'futex_wait_setup' follows non-static declaration
kernel/futex/waitwake.c:632:5: error: static declaration of 'futex_wait' follows non-static declaration
kernel/futex/waitwake.c:684:39: error: 'futex_wait_restart' undeclared (first use in this function); did you mean 'futex_wait_setup'?
kernel/futex/waitwake.c:707:1: error: expected declaration or statement at end of input

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- mips-allmodconfig
|   |-- arch-mips-include-asm-futex.h:error:implicit-declaration-of-function-arch_futex_atomic_op_inuser_local
|   |-- arch-mips-include-asm-futex.h:error:invalid-storage-class-for-function-futex_atomic_cmpxchg_inatomic
|   |-- arch-mips-include-asm-futex.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|   |-- include-asm-generic-current.h:error:initialization-of-struct-futex_pi_state-from-incompatible-pointer-type-struct-futex_pi_state
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_futex
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_futex_time32
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_futex_waitv
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_get_robust_list
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_set_robust_list
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_futex
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_futex_time32
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_futex_waitv
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_get_robust_list
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_set_robust_list
|   |-- include-linux-syscalls.h:error:redeclaration-of-__syscall_meta__futex-with-no-linkage
|   |-- include-linux-syscalls.h:error:redeclaration-of-__syscall_meta__futex_time32-with-no-linkage
|   |-- include-linux-syscalls.h:error:redeclaration-of-__syscall_meta__futex_waitv-with-no-linkage
|   |-- include-linux-syscalls.h:error:redeclaration-of-__syscall_meta__get_robust_list-with-no-linkage
|   |-- include-linux-syscalls.h:error:redeclaration-of-__syscall_meta__set_robust_list-with-no-linkage
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_futex-follows-non-static-declaration
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_futex_time32-follows-non-static-declaration
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_futex_waitv-follows-non-static-declaration
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_get_robust_list-follows-non-static-declaration
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_set_robust_list-follows-non-static-declaration
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-__rt_mutex_base_init
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-debug_rt_mutex_free_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-debug_rt_mutex_init_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-debug_rt_mutex_proxy_unlock
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-debug_rt_mutex_unlock
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_has_waiters
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_init_rtlock_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_init_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_owner
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_top_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_waiter_is_top_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-task_has_pi_waiters
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-task_top_pi_waiter
|   |-- kernel-futex-core.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-core.c:error:initializer-element-is-not-constant
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-exit_pi_state_list
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-exit_robust_list
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-fail_futex_debugfs
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-fetch_robust_entry
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-futex_cleanup
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-futex_cleanup_begin
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-futex_cleanup_end
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-futex_init
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-get_inode_sequence_number
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-handle_futex_death
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-setup_fail_futex
|   |-- kernel-futex-core.c:error:static-declaration-of-__futex_queue-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-__futex_unqueue-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-fault_in_user_writeable-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_cmpxchg_value_locked-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_get_value_locked-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_hash-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_q_lock-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_q_unlock-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_setup_timer-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_top_waiter-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_unqueue-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_unqueue_pi-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-get_futex_key-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-should_fail_futex-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-wait_for_owner_exiting-follows-non-static-declaration
|   |-- kernel-futex-core.c:warning:ISO-C90-forbids-mixed-declarations-and-code
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-double_lock_hb
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-double_unlock_hb
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_hb_waiters_dec
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_hb_waiters_inc
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_hb_waiters_pending
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_match
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_queue
|   |-- kernel-futex-pi.c:error:assignment-to-struct-futex_pi_state-from-incompatible-pointer-type-struct-futex_pi_state
|   |-- kernel-futex-pi.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-__attach_to_pi_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-__fixup_pi_state_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-alloc_pi_state
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-attach_to_pi_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-attach_to_pi_state
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-fixup_pi_state_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-handle_exit_race
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-lock_pi_update_atomic
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-pi_state_update_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-wake_futex_pi
|   |-- kernel-futex-pi.c:error:static-declaration-of-fixup_pi_owner-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-futex_lock_pi-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-futex_lock_pi_atomic-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-futex_unlock_pi-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-get_pi_state-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-put_pi_state-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-refill_pi_state_cache-follows-non-static-declaration
|   |-- kernel-futex-requeue.c:error:assignment-to-struct-rt_mutex_waiter-from-incompatible-pointer-type-struct-rt_mutex_waiter
|   |-- kernel-futex-requeue.c:error:declaration-of-futex_q_init-with-no-linkage-follows-extern-declaration
|   |-- kernel-futex-requeue.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-futex_proxy_trylock_atomic
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-futex_requeue_pi_complete
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-futex_requeue_pi_prepare
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-futex_requeue_pi_wakeup_sync
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-handle_early_requeue_pi_wakeup
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-requeue_futex
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-requeue_pi_wake_futex
|   |-- kernel-futex-requeue.c:error:passing-argument-of-rt_mutex_start_proxy_lock-from-incompatible-pointer-type
|   |-- kernel-futex-requeue.c:error:static-declaration-of-futex_requeue-follows-non-static-declaration
|   |-- kernel-futex-requeue.c:error:static-declaration-of-futex_wait_requeue_pi-follows-non-static-declaration
|   |-- kernel-futex-syscalls.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-syscalls.c:error:invalid-storage-class-for-function-futex_cmd_has_timeout
|   |-- kernel-futex-syscalls.c:error:invalid-storage-class-for-function-futex_init_timeout
|   |-- kernel-futex-syscalls.c:error:invalid-storage-class-for-function-futex_parse_waitv
|   |-- kernel-futex-syscalls.c:warning:alias-attribute-ignored
|   |-- kernel-futex-waitwake.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-waitwake.c:error:futex_wait_restart-undeclared-(first-use-in-this-function)
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-futex_atomic_op_inuser
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-futex_sleep_multiple
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-futex_wait_multiple_setup
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-futex_wait_restart
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-unqueue_multiple
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wait-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wait_multiple-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wait_queue-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wait_setup-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wake-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wake_mark-follows-non-static-declaration
|   `-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wake_op-follows-non-static-declaration
|-- mips-allyesconfig
|   |-- arch-mips-include-asm-futex.h:error:implicit-declaration-of-function-arch_futex_atomic_op_inuser_local
|   |-- arch-mips-include-asm-futex.h:error:invalid-storage-class-for-function-futex_atomic_cmpxchg_inatomic
|   |-- arch-mips-include-asm-futex.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|   |-- include-asm-generic-current.h:error:initialization-of-struct-futex_pi_state-from-incompatible-pointer-type-struct-futex_pi_state
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_futex
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_futex_time32
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_futex_waitv
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_get_robust_list
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_set_robust_list
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_futex
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_futex_time32
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_futex_waitv
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_get_robust_list
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_set_robust_list
|   |-- include-linux-syscalls.h:error:redeclaration-of-__syscall_meta__futex-with-no-linkage
|   |-- include-linux-syscalls.h:error:redeclaration-of-__syscall_meta__futex_time32-with-no-linkage
|   |-- include-linux-syscalls.h:error:redeclaration-of-__syscall_meta__futex_waitv-with-no-linkage
|   |-- include-linux-syscalls.h:error:redeclaration-of-__syscall_meta__get_robust_list-with-no-linkage
|   |-- include-linux-syscalls.h:error:redeclaration-of-__syscall_meta__set_robust_list-with-no-linkage
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_futex-follows-non-static-declaration
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_futex_time32-follows-non-static-declaration
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_futex_waitv-follows-non-static-declaration
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_get_robust_list-follows-non-static-declaration
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_set_robust_list-follows-non-static-declaration
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-__rt_mutex_base_init
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-debug_rt_mutex_free_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-debug_rt_mutex_init_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-debug_rt_mutex_proxy_unlock
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-debug_rt_mutex_unlock
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_has_waiters
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_init_rtlock_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_init_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_owner
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_top_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_waiter_is_top_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-task_has_pi_waiters
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-task_top_pi_waiter
|   |-- kernel-futex-core.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-core.c:error:initializer-element-is-not-constant
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-exit_pi_state_list
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-exit_robust_list
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-fail_futex_debugfs
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-fetch_robust_entry
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-futex_cleanup
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-futex_cleanup_begin
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-futex_cleanup_end
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-futex_init
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-get_inode_sequence_number
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-handle_futex_death
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-setup_fail_futex
|   |-- kernel-futex-core.c:error:static-declaration-of-__futex_queue-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-__futex_unqueue-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-fault_in_user_writeable-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_cmpxchg_value_locked-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_get_value_locked-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_hash-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_q_lock-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_q_unlock-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_setup_timer-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_top_waiter-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_unqueue-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_unqueue_pi-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-get_futex_key-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-should_fail_futex-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-wait_for_owner_exiting-follows-non-static-declaration
|   |-- kernel-futex-core.c:warning:ISO-C90-forbids-mixed-declarations-and-code
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-double_lock_hb
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-double_unlock_hb
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_hb_waiters_dec
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_hb_waiters_inc
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_hb_waiters_pending
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_match
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_queue
|   |-- kernel-futex-pi.c:error:assignment-to-struct-futex_pi_state-from-incompatible-pointer-type-struct-futex_pi_state
|   |-- kernel-futex-pi.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-__attach_to_pi_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-__fixup_pi_state_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-alloc_pi_state
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-attach_to_pi_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-attach_to_pi_state
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-fixup_pi_state_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-handle_exit_race
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-lock_pi_update_atomic
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-pi_state_update_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-wake_futex_pi
|   |-- kernel-futex-pi.c:error:static-declaration-of-fixup_pi_owner-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-futex_lock_pi-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-futex_lock_pi_atomic-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-futex_unlock_pi-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-get_pi_state-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-put_pi_state-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-refill_pi_state_cache-follows-non-static-declaration
|   |-- kernel-futex-requeue.c:error:assignment-to-struct-rt_mutex_waiter-from-incompatible-pointer-type-struct-rt_mutex_waiter
|   |-- kernel-futex-requeue.c:error:declaration-of-futex_q_init-with-no-linkage-follows-extern-declaration
|   |-- kernel-futex-requeue.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-futex_proxy_trylock_atomic
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-futex_requeue_pi_complete
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-futex_requeue_pi_prepare
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-futex_requeue_pi_wakeup_sync
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-handle_early_requeue_pi_wakeup
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-requeue_futex
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-requeue_pi_wake_futex
|   |-- kernel-futex-requeue.c:error:passing-argument-of-rt_mutex_start_proxy_lock-from-incompatible-pointer-type
|   |-- kernel-futex-requeue.c:error:static-declaration-of-futex_requeue-follows-non-static-declaration
|   |-- kernel-futex-requeue.c:error:static-declaration-of-futex_wait_requeue_pi-follows-non-static-declaration
|   |-- kernel-futex-syscalls.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-syscalls.c:error:invalid-storage-class-for-function-futex_cmd_has_timeout
|   |-- kernel-futex-syscalls.c:error:invalid-storage-class-for-function-futex_init_timeout
|   |-- kernel-futex-syscalls.c:error:invalid-storage-class-for-function-futex_parse_waitv
|   |-- kernel-futex-syscalls.c:warning:alias-attribute-ignored
|   |-- kernel-futex-waitwake.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-waitwake.c:error:futex_wait_restart-undeclared-(first-use-in-this-function)
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-futex_atomic_op_inuser
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-futex_sleep_multiple
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-futex_wait_multiple_setup
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-futex_wait_restart
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-unqueue_multiple
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wait-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wait_multiple-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wait_queue-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wait_setup-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wake-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wake_mark-follows-non-static-declaration
|   `-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wake_op-follows-non-static-declaration
|-- mips-bigsur_defconfig
|   |-- include-linux-compat.h:error:implicit-declaration-of-function-__do_compat_sys_get_robust_list
|   |-- include-linux-compat.h:error:implicit-declaration-of-function-__do_compat_sys_set_robust_list
|   |-- include-linux-compat.h:error:invalid-storage-class-for-function-__do_compat_sys_get_robust_list
|   |-- include-linux-compat.h:error:invalid-storage-class-for-function-__do_compat_sys_set_robust_list
|   |-- include-linux-compat.h:error:static-declaration-of-__se_compat_sys_get_robust_list-follows-non-static-declaration
|   |-- include-linux-compat.h:error:static-declaration-of-__se_compat_sys_set_robust_list-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-compat_exit_robust_list
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-compat_fetch_robust_entry
|   `-- kernel-futex-core.c:error:invalid-storage-class-for-function-futex_uaddr
|-- mips-gcw0_defconfig
|   `-- kernel-futex-futex.h:error:invalid-storage-class-for-function-should_fail_futex
|-- mips-randconfig-r032-20211126
|   |-- arch-mips-include-asm-futex.h:error:implicit-declaration-of-function-arch_futex_atomic_op_inuser_local
|   |-- arch-mips-include-asm-futex.h:error:invalid-storage-class-for-function-futex_atomic_cmpxchg_inatomic
|   |-- arch-mips-include-asm-futex.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|   |-- include-asm-generic-current.h:error:initialization-of-struct-futex_pi_state-from-incompatible-pointer-type-struct-futex_pi_state
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_futex
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_futex_time32
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_futex_waitv
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_get_robust_list
|   |-- include-linux-syscalls.h:error:implicit-declaration-of-function-__do_sys_set_robust_list
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_futex
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_futex_time32
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_futex_waitv
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_get_robust_list
|   |-- include-linux-syscalls.h:error:invalid-storage-class-for-function-__do_sys_set_robust_list
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_futex-follows-non-static-declaration
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_futex_time32-follows-non-static-declaration
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_futex_waitv-follows-non-static-declaration
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_get_robust_list-follows-non-static-declaration
|   |-- include-linux-syscalls.h:error:static-declaration-of-__se_sys_set_robust_list-follows-non-static-declaration
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-__rt_mutex_base_init
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-debug_rt_mutex_free_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-debug_rt_mutex_init_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-debug_rt_mutex_proxy_unlock
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-debug_rt_mutex_unlock
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_has_waiters
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_init_rtlock_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_init_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_owner
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_top_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-rt_mutex_waiter_is_top_waiter
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-task_has_pi_waiters
|   |-- kernel-futex-..-locking-rtmutex_common.h:error:invalid-storage-class-for-function-task_top_pi_waiter
|   |-- kernel-futex-core.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-core.c:error:initializer-element-is-not-constant
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-exit_pi_state_list
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-exit_robust_list
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-fetch_robust_entry
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-futex_cleanup
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-futex_cleanup_begin
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-futex_cleanup_end
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-futex_init
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-get_inode_sequence_number
|   |-- kernel-futex-core.c:error:invalid-storage-class-for-function-handle_futex_death
|   |-- kernel-futex-core.c:error:static-declaration-of-__futex_queue-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-__futex_unqueue-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-fault_in_user_writeable-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_cmpxchg_value_locked-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_get_value_locked-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_hash-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_q_lock-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_q_unlock-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_setup_timer-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_top_waiter-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_unqueue-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-futex_unqueue_pi-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-get_futex_key-follows-non-static-declaration
|   |-- kernel-futex-core.c:error:static-declaration-of-wait_for_owner_exiting-follows-non-static-declaration
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-double_lock_hb
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-double_unlock_hb
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_hb_waiters_dec
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_hb_waiters_inc
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_hb_waiters_pending
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_match
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-futex_queue
|   |-- kernel-futex-futex.h:error:invalid-storage-class-for-function-should_fail_futex
|   |-- kernel-futex-pi.c:error:assignment-to-struct-futex_pi_state-from-incompatible-pointer-type-struct-futex_pi_state
|   |-- kernel-futex-pi.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-__attach_to_pi_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-__fixup_pi_state_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-alloc_pi_state
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-attach_to_pi_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-attach_to_pi_state
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-fixup_pi_state_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-handle_exit_race
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-lock_pi_update_atomic
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-pi_state_update_owner
|   |-- kernel-futex-pi.c:error:invalid-storage-class-for-function-wake_futex_pi
|   |-- kernel-futex-pi.c:error:static-declaration-of-fixup_pi_owner-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-futex_lock_pi-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-futex_lock_pi_atomic-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-futex_unlock_pi-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-get_pi_state-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-put_pi_state-follows-non-static-declaration
|   |-- kernel-futex-pi.c:error:static-declaration-of-refill_pi_state_cache-follows-non-static-declaration
|   |-- kernel-futex-requeue.c:error:assignment-to-struct-rt_mutex_waiter-from-incompatible-pointer-type-struct-rt_mutex_waiter
|   |-- kernel-futex-requeue.c:error:declaration-of-futex_q_init-with-no-linkage-follows-extern-declaration
|   |-- kernel-futex-requeue.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-futex_proxy_trylock_atomic
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-futex_requeue_pi_complete
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-futex_requeue_pi_prepare
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-futex_requeue_pi_wakeup_sync
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-handle_early_requeue_pi_wakeup
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-requeue_futex
|   |-- kernel-futex-requeue.c:error:invalid-storage-class-for-function-requeue_pi_wake_futex
|   |-- kernel-futex-requeue.c:error:passing-argument-of-rt_mutex_start_proxy_lock-from-incompatible-pointer-type
|   |-- kernel-futex-requeue.c:error:static-declaration-of-futex_requeue-follows-non-static-declaration
|   |-- kernel-futex-requeue.c:error:static-declaration-of-futex_wait_requeue_pi-follows-non-static-declaration
|   |-- kernel-futex-syscalls.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-syscalls.c:error:invalid-storage-class-for-function-futex_cmd_has_timeout
|   |-- kernel-futex-syscalls.c:error:invalid-storage-class-for-function-futex_init_timeout
|   |-- kernel-futex-syscalls.c:error:invalid-storage-class-for-function-futex_parse_waitv
|   |-- kernel-futex-syscalls.c:warning:alias-attribute-ignored
|   |-- kernel-futex-waitwake.c:error:expected-declaration-or-statement-at-end-of-input
|   |-- kernel-futex-waitwake.c:error:futex_wait_restart-undeclared-(first-use-in-this-function)
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-futex_atomic_op_inuser
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-futex_sleep_multiple
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-futex_wait_multiple_setup
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-futex_wait_restart
|   |-- kernel-futex-waitwake.c:error:invalid-storage-class-for-function-unqueue_multiple
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wait-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wait_multiple-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wait_queue-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wait_setup-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wake-follows-non-static-declaration
|   |-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wake_mark-follows-non-static-declaration
|   `-- kernel-futex-waitwake.c:error:static-declaration-of-futex_wake_op-follows-non-static-declaration
`-- xtensa-allyesconfig
    `-- arch-xtensa-include-asm-futex.h:error:implicit-declaration-of-function-arch_futex_atomic_op_inuser_local

elapsed time: 1381m

configs tested: 54
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
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
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
