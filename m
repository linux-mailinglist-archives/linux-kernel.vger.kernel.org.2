Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACA0440D72
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 08:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhJaHbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 03:31:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:6688 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhJaHbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 03:31:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10153"; a="229593333"
X-IronPort-AV: E=Sophos;i="5.87,197,1631602800"; 
   d="gz'50?scan'50,208,50";a="229593333"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2021 00:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,197,1631602800"; 
   d="gz'50?scan'50,208,50";a="448599836"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 31 Oct 2021 00:29:15 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mh5HH-0002FU-23; Sun, 31 Oct 2021 07:29:15 +0000
Date:   Sun, 31 Oct 2021 15:28:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arnd-playground:randconfig-5.16-next 137/151]
 arch/mips/include/asm/futex.h:132:1: warning: ISO C90 forbids mixed
 declarations and code
Message-ID: <202110311503.xzacY3AQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git randconfig-5.16-next
head:   d18f89e8161c4cf63dd554521b305dd3374b52b3
commit: 2db331c581c8cc2f8742223470ca5cdd8d7fc312 [137/151] [SUBMITTED 20211026] futex: ensure futex_atomic_cmpxchg_inatomic() is present
config: mips-ci20_defconfig (attached as .config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=2db331c581c8cc2f8742223470ca5cdd8d7fc312
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground randconfig-5.16-next
        git checkout 2db331c581c8cc2f8742223470ca5cdd8d7fc312
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/futex/futex.h:12,
                    from kernel/futex/core.c:41:
   arch/mips/include/asm/futex.h: In function 'arch_futex_atomic_op_inuser':
   arch/mips/include/asm/futex.h:89:23: error: implicit declaration of function 'arch_futex_atomic_op_inuser_local'; did you mean 'futex_atomic_op_inuser_local'? [-Werror=implicit-function-declaration]
      89 |                 ret = arch_futex_atomic_op_inuser_local(op, oparg, oval,\
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/futex.h:89:23: note: in definition of macro '__futex_atomic_op'
      89 |                 ret = arch_futex_atomic_op_inuser_local(op, oparg, oval,\
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/futex/futex.h:12,
                    from kernel/futex/core.c:41:
   arch/mips/include/asm/futex.h:23:39: error: invalid storage class for function 'futex_atomic_cmpxchg_inatomic'
      23 | #define futex_atomic_cmpxchg_inatomic futex_atomic_cmpxchg_inatomic
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/futex.h:133:1: note: in expansion of macro 'futex_atomic_cmpxchg_inatomic'
     133 | futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/futex/futex.h:12,
                    from kernel/futex/core.c:41:
>> arch/mips/include/asm/futex.h:132:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     132 | static inline int
         | ^~~~~~
   In file included from kernel/futex/core.c:41:
   kernel/futex/futex.h:33:27: error: section attribute cannot be specified for local variables
      33 | extern int  __read_mostly futex_cmpxchg_enabled;
         |                           ^~~~~~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:39:20: error: invalid storage class for function 'should_fail_futex'
      39 | static inline bool should_fail_futex(bool fshared)
         |                    ^~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:140:19: error: invalid storage class for function 'futex_match'
     140 | static inline int futex_match(union futex_key *key1, union futex_key *key2)
         |                   ^~~~~~~~~~~
   kernel/futex/futex.h:175:20: error: invalid storage class for function 'futex_queue'
     175 | static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
         |                    ^~~~~~~~~~~
   kernel/futex/futex.h:189:20: error: invalid storage class for function 'futex_hb_waiters_inc'
     189 | static inline void futex_hb_waiters_inc(struct futex_hash_bucket *hb)
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:204:20: error: invalid storage class for function 'futex_hb_waiters_dec'
     204 | static inline void futex_hb_waiters_dec(struct futex_hash_bucket *hb)
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:211:19: error: invalid storage class for function 'futex_hb_waiters_pending'
     211 | static inline int futex_hb_waiters_pending(struct futex_hash_bucket *hb)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:244:1: error: invalid storage class for function 'double_lock_hb'
     244 | double_lock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
         | ^~~~~~~~~~~~~~
   kernel/futex/futex.h:255:1: error: invalid storage class for function 'double_unlock_hb'
     255 | double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
         | ^~~~~~~~~~~~~~~~
   In file included from kernel/futex/core.c:42:
   kernel/futex/../locking/rtmutex_common.h:93:19: error: invalid storage class for function 'rt_mutex_has_waiters'
      93 | static inline int rt_mutex_has_waiters(struct rt_mutex_base *lock)
         |                   ^~~~~~~~~~~~~~~~~~~~
   kernel/futex/../locking/rtmutex_common.h:103:20: error: invalid storage class for function 'rt_mutex_waiter_is_top_waiter'
     103 | static inline bool rt_mutex_waiter_is_top_waiter(struct rt_mutex_base *lock,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/../locking/rtmutex_common.h:111:39: error: invalid storage class for function 'rt_mutex_top_waiter'
     111 | static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *lock)
         |                                       ^~~~~~~~~~~~~~~~~~~
   kernel/futex/../locking/rtmutex_common.h:123:19: error: invalid storage class for function 'task_has_pi_waiters'
     123 | static inline int task_has_pi_waiters(struct task_struct *p)
         |                   ^~~~~~~~~~~~~~~~~~~
   kernel/futex/../locking/rtmutex_common.h:128:39: error: invalid storage class for function 'task_top_pi_waiter'
     128 | static inline struct rt_mutex_waiter *task_top_pi_waiter(struct task_struct *p)
         |                                       ^~~~~~~~~~~~~~~~~~
   kernel/futex/../locking/rtmutex_common.h:136:35: error: invalid storage class for function 'rt_mutex_owner'
     136 | static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
         |                                   ^~~~~~~~~~~~~~
   kernel/futex/../locking/rtmutex_common.h:158:20: error: invalid storage class for function '__rt_mutex_base_init'
     158 | static inline void __rt_mutex_base_init(struct rt_mutex_base *lock)
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/futex/../locking/rtmutex_common.h:166:20: error: invalid storage class for function 'debug_rt_mutex_unlock'
     166 | static inline void debug_rt_mutex_unlock(struct rt_mutex_base *lock)
         |                    ^~~~~~~~~~~~~~~~~~~~~
   kernel/futex/../locking/rtmutex_common.h:172:20: error: invalid storage class for function 'debug_rt_mutex_proxy_unlock'
     172 | static inline void debug_rt_mutex_proxy_unlock(struct rt_mutex_base *lock)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/../locking/rtmutex_common.h:178:20: error: invalid storage class for function 'debug_rt_mutex_init_waiter'
     178 | static inline void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/../locking/rtmutex_common.h:184:20: error: invalid storage class for function 'debug_rt_mutex_free_waiter'
     184 | static inline void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/../locking/rtmutex_common.h:190:20: error: invalid storage class for function 'rt_mutex_init_waiter'
     190 | static inline void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/futex/../locking/rtmutex_common.h:199:20: error: invalid storage class for function 'rt_mutex_init_rtlock_waiter'
     199 | static inline void rt_mutex_init_rtlock_waiter(struct rt_mutex_waiter *waiter)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/core.c:45:20: error: section attribute cannot be specified for local variables
      45 | int  __read_mostly futex_cmpxchg_enabled;
         |                    ^~~~~~~~~~~~~~~~~~~~~
   kernel/futex/core.c:45:20: error: declaration of 'futex_cmpxchg_enabled' with no linkage follows extern declaration
   In file included from kernel/futex/core.c:41:
   kernel/futex/futex.h:33:27: note: previous declaration of 'futex_cmpxchg_enabled' with type 'int'
      33 | extern int  __read_mostly futex_cmpxchg_enabled;
         |                           ^~~~~~~~~~~~~~~~~~~~~
   kernel/futex/core.c:120:27: error: static declaration of 'futex_hash' follows non-static declaration
     120 | struct futex_hash_bucket *futex_hash(union futex_key *key)
         |                           ^~~~~~~~~~
   In file included from kernel/futex/core.c:41:
   kernel/futex/futex.h:131:34: note: previous declaration of 'futex_hash' with type 'struct futex_hash_bucket *(union futex_key *)'
     131 | extern struct futex_hash_bucket *futex_hash(union futex_key *key);
         |                                  ^~~~~~~~~~
   kernel/futex/core.c:140:1: error: static declaration of 'futex_setup_timer' follows non-static declaration
     140 | futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
         | ^~~~~~~~~~~~~~~~~
   In file included from kernel/futex/core.c:41:
   kernel/futex/futex.h:128:1: note: previous declaration of 'futex_setup_timer' with type 'struct hrtimer_sleeper *(ktime_t *, struct hrtimer_sleeper *, int,  u64)' {aka 'struct hrtimer_sleeper *(long long int *, struct hrtimer_sleeper *, int,  long long unsigned int)'}
     128 | futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
         | ^~~~~~~~~~~~~~~~~
   kernel/futex/core.c:176:12: error: invalid storage class for function 'get_inode_sequence_number'
     176 | static u64 get_inode_sequence_number(struct inode *inode)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/core.c:225:5: error: static declaration of 'get_futex_key' follows non-static declaration
     225 | int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
         |     ^~~~~~~~~~~~~
   In file included from kernel/futex/core.c:41:
   kernel/futex/futex.h:124:12: note: previous declaration of 'get_futex_key' with type 'int(u32 *, bool,  union futex_key *, enum futex_access)' {aka 'int(unsigned int *, _Bool,  union futex_key *, enum futex_access)'}
--
   In file included from kernel/futex/futex.h:12,
                    from kernel/futex/syscalls.c:7:
   arch/mips/include/asm/futex.h: In function 'arch_futex_atomic_op_inuser':
   arch/mips/include/asm/futex.h:89:23: error: implicit declaration of function 'arch_futex_atomic_op_inuser_local'; did you mean 'futex_atomic_op_inuser_local'? [-Werror=implicit-function-declaration]
      89 |                 ret = arch_futex_atomic_op_inuser_local(op, oparg, oval,\
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/futex.h:89:23: note: in definition of macro '__futex_atomic_op'
      89 |                 ret = arch_futex_atomic_op_inuser_local(op, oparg, oval,\
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/futex/futex.h:12,
                    from kernel/futex/syscalls.c:7:
   arch/mips/include/asm/futex.h:23:39: error: invalid storage class for function 'futex_atomic_cmpxchg_inatomic'
      23 | #define futex_atomic_cmpxchg_inatomic futex_atomic_cmpxchg_inatomic
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/futex.h:133:1: note: in expansion of macro 'futex_atomic_cmpxchg_inatomic'
     133 | futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/futex/futex.h:12,
                    from kernel/futex/syscalls.c:7:
>> arch/mips/include/asm/futex.h:132:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     132 | static inline int
         | ^~~~~~
   In file included from kernel/futex/syscalls.c:7:
   kernel/futex/futex.h:33:27: error: section attribute cannot be specified for local variables
      33 | extern int  __read_mostly futex_cmpxchg_enabled;
         |                           ^~~~~~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:39:20: error: invalid storage class for function 'should_fail_futex'
      39 | static inline bool should_fail_futex(bool fshared)
         |                    ^~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:140:19: error: invalid storage class for function 'futex_match'
     140 | static inline int futex_match(union futex_key *key1, union futex_key *key2)
         |                   ^~~~~~~~~~~
   kernel/futex/futex.h:175:20: error: invalid storage class for function 'futex_queue'
     175 | static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
         |                    ^~~~~~~~~~~
   kernel/futex/futex.h:189:20: error: invalid storage class for function 'futex_hb_waiters_inc'
     189 | static inline void futex_hb_waiters_inc(struct futex_hash_bucket *hb)
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:204:20: error: invalid storage class for function 'futex_hb_waiters_dec'
     204 | static inline void futex_hb_waiters_dec(struct futex_hash_bucket *hb)
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:211:19: error: invalid storage class for function 'futex_hb_waiters_pending'
     211 | static inline int futex_hb_waiters_pending(struct futex_hash_bucket *hb)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:244:1: error: invalid storage class for function 'double_lock_hb'
     244 | double_lock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
         | ^~~~~~~~~~~~~~
   kernel/futex/futex.h:255:1: error: invalid storage class for function 'double_unlock_hb'
     255 | double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
         | ^~~~~~~~~~~~~~~~
   In file included from kernel/futex/syscalls.c:4:
>> kernel/futex/syscalls.c:29:41: warning: 'alias' attribute ignored [-Wattributes]
      29 | SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/syscalls.h:119:25: note: in definition of macro '__SC_DECL'
     119 | #define __SC_DECL(t, a) t a
         |                         ^
   include/linux/syscalls.h:117:22: note: in expansion of macro '__MAP2'
     117 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   include/linux/syscalls.h:243:35: note: in expansion of macro '__MAP'
     243 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                                   ^~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:219:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     219 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:29:1: note: in expansion of macro 'SYSCALL_DEFINE2'
      29 | SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
         | ^~~~~~~~~~~~~~~
>> include/linux/syscalls.h:243:20: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     243 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                    ^~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:219:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     219 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:29:1: note: in expansion of macro 'SYSCALL_DEFINE2'
      29 | SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:246:28: error: invalid storage class for function '__do_sys_set_robust_list'
     246 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:219:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     219 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:29:1: note: in expansion of macro 'SYSCALL_DEFINE2'
      29 | SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:246:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     246 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |         ^~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:219:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     219 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:29:1: note: in expansion of macro 'SYSCALL_DEFINE2'
      29 | SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:248:25: error: static declaration of '__se_sys_set_robust_list' follows non-static declaration
     248 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
         |                         ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:219:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     219 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:29:1: note: in expansion of macro 'SYSCALL_DEFINE2'
      29 | SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:247:25: note: previous declaration of '__se_sys_set_robust_list' with type 'long int(long int,  long int)'
     247 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
         |                         ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:219:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     219 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:29:1: note: in expansion of macro 'SYSCALL_DEFINE2'
      29 | SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c: In function '__se_sys_set_robust_list':
   include/linux/syscalls.h:250:28: error: implicit declaration of function '__do_sys_set_robust_list'; did you mean '__se_sys_set_robust_list'? [-Werror=implicit-function-declaration]
     250 |                 long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:219:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     219 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:29:1: note: in expansion of macro 'SYSCALL_DEFINE2'
      29 | SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c: In function 'arch_futex_atomic_op_inuser':
   include/linux/syscalls.h:256:28: error: invalid storage class for function '__do_sys_set_robust_list'
     256 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:219:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     219 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:29:1: note: in expansion of macro 'SYSCALL_DEFINE2'
      29 | SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:256:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     256 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |         ^~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:219:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     219 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:29:1: note: in expansion of macro 'SYSCALL_DEFINE2'
      29 | SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:52:24: warning: 'alias' attribute ignored [-Wattributes]
      52 |                 struct robust_list_head __user * __user *, head_ptr,
         |                        ^~~~~~~~~~~~~~~~
   include/linux/syscalls.h:119:25: note: in definition of macro '__SC_DECL'
     119 | #define __SC_DECL(t, a) t a
         |                         ^
   include/linux/syscalls.h:113:35: note: in expansion of macro '__MAP2'
     113 | #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:117:22: note: in expansion of macro '__MAP3'
     117 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   include/linux/syscalls.h:243:35: note: in expansion of macro '__MAP'
     243 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                                   ^~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:220:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     220 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:51:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      51 | SYSCALL_DEFINE3(get_robust_list, int, pid,
         | ^~~~~~~~~~~~~~~
>> include/linux/syscalls.h:243:20: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     243 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                    ^~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:220:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     220 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:51:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      51 | SYSCALL_DEFINE3(get_robust_list, int, pid,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:246:28: error: invalid storage class for function '__do_sys_get_robust_list'
     246 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:220:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     220 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:51:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      51 | SYSCALL_DEFINE3(get_robust_list, int, pid,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:246:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     246 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |         ^~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:220:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     220 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:51:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      51 | SYSCALL_DEFINE3(get_robust_list, int, pid,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:248:25: error: static declaration of '__se_sys_get_robust_list' follows non-static declaration
     248 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
         |                         ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:220:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     220 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:51:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      51 | SYSCALL_DEFINE3(get_robust_list, int, pid,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:247:25: note: previous declaration of '__se_sys_get_robust_list' with type 'long int(long int,  long int,  long int)'
     247 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
         |                         ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:220:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     220 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:51:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      51 | SYSCALL_DEFINE3(get_robust_list, int, pid,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c: In function '__se_sys_get_robust_list':
   include/linux/syscalls.h:250:28: error: implicit declaration of function '__do_sys_get_robust_list'; did you mean '__do_sys_set_robust_list'? [-Werror=implicit-function-declaration]
     250 |                 long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:220:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     220 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:51:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      51 | SYSCALL_DEFINE3(get_robust_list, int, pid,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c: In function 'arch_futex_atomic_op_inuser':
   include/linux/syscalls.h:256:28: error: invalid storage class for function '__do_sys_get_robust_list'
     256 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:220:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     220 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:51:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      51 | SYSCALL_DEFINE3(get_robust_list, int, pid,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:256:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     256 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |         ^~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:220:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     220 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:51:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      51 | SYSCALL_DEFINE3(get_robust_list, int, pid,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:153:29: error: invalid storage class for function 'futex_cmd_has_timeout'
     153 | static __always_inline bool futex_cmd_has_timeout(u32 cmd)
         |                             ^~~~~~~~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:167:1: error: invalid storage class for function 'futex_init_timeout'
     167 | futex_init_timeout(u32 cmd, u32 op, struct timespec64 *ts, ktime_t *t)
         | ^~~~~~~~~~~~~~~~~~
   In file included from kernel/futex/syscalls.c:4:
   kernel/futex/syscalls.c:181:30: warning: 'alias' attribute ignored [-Wattributes]
     181 |                 const struct __kernel_timespec __user *, utime,
         |                              ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:119:25: note: in definition of macro '__SC_DECL'
     119 | #define __SC_DECL(t, a) t a
         |                         ^
   include/linux/syscalls.h:114:35: note: in expansion of macro '__MAP3'
     114 | #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:115:35: note: in expansion of macro '__MAP4'
     115 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:116:35: note: in expansion of macro '__MAP5'
     116 | #define __MAP6(m,t,a,...) m(t,a), __MAP5(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:117:22: note: in expansion of macro '__MAP6'
     117 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   include/linux/syscalls.h:243:35: note: in expansion of macro '__MAP'
     243 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                                   ^~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:180:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     180 | SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
>> include/linux/syscalls.h:243:20: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     243 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                    ^~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:180:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     180 | SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:246:28: error: invalid storage class for function '__do_sys_futex'
     246 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:180:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     180 | SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:246:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     246 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |         ^~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:180:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     180 | SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:248:25: error: static declaration of '__se_sys_futex' follows non-static declaration
     248 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
         |                         ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:180:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     180 | SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:247:25: note: previous declaration of '__se_sys_futex' with type 'long int(long int,  long int,  long int,  long int,  long int,  long int)'
     247 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
         |                         ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:180:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     180 | SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c: In function '__se_sys_futex':
   include/linux/syscalls.h:250:28: error: implicit declaration of function '__do_sys_futex'; did you mean '__se_sys_futex'? [-Werror=implicit-function-declaration]
     250 |                 long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:180:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     180 | SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c: In function 'arch_futex_atomic_op_inuser':
   include/linux/syscalls.h:256:28: error: invalid storage class for function '__do_sys_futex'
     256 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:180:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     180 | SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:256:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     256 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |         ^~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:180:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     180 | SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:213:12: error: invalid storage class for function 'futex_parse_waitv'
     213 | static int futex_parse_waitv(struct futex_vector *futexv,
         |            ^~~~~~~~~~~~~~~~~
   In file included from kernel/futex/syscalls.c:4:
   kernel/futex/syscalls.c:264:24: warning: 'alias' attribute ignored [-Wattributes]
     264 |                 struct __kernel_timespec __user *, timeout, clockid_t, clockid)
         |                        ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:119:25: note: in definition of macro '__SC_DECL'
     119 | #define __SC_DECL(t, a) t a
         |                         ^
   include/linux/syscalls.h:113:35: note: in expansion of macro '__MAP2'
     113 | #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:114:35: note: in expansion of macro '__MAP3'
     114 | #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:115:35: note: in expansion of macro '__MAP4'
     115 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:117:22: note: in expansion of macro '__MAP5'
     117 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   include/linux/syscalls.h:243:35: note: in expansion of macro '__MAP'
     243 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                                   ^~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     222 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:262:1: note: in expansion of macro 'SYSCALL_DEFINE5'
     262 | SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
         | ^~~~~~~~~~~~~~~
>> include/linux/syscalls.h:243:20: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     243 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                    ^~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     222 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:262:1: note: in expansion of macro 'SYSCALL_DEFINE5'
     262 | SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:246:28: error: invalid storage class for function '__do_sys_futex_waitv'
     246 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     222 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:262:1: note: in expansion of macro 'SYSCALL_DEFINE5'
     262 | SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:246:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     246 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |         ^~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     222 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:262:1: note: in expansion of macro 'SYSCALL_DEFINE5'
     262 | SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:248:25: error: static declaration of '__se_sys_futex_waitv' follows non-static declaration
     248 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
         |                         ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     222 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:262:1: note: in expansion of macro 'SYSCALL_DEFINE5'
     262 | SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:247:25: note: previous declaration of '__se_sys_futex_waitv' with type 'long int(long int,  long int,  long int,  long int,  long int)'
     247 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
         |                         ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     222 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:262:1: note: in expansion of macro 'SYSCALL_DEFINE5'
     262 | SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c: In function '__se_sys_futex_waitv':
   include/linux/syscalls.h:250:28: error: implicit declaration of function '__do_sys_futex_waitv'; did you mean '__se_sys_futex_waitv'? [-Werror=implicit-function-declaration]
     250 |                 long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     222 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:262:1: note: in expansion of macro 'SYSCALL_DEFINE5'
     262 | SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c: In function 'arch_futex_atomic_op_inuser':
   include/linux/syscalls.h:256:28: error: invalid storage class for function '__do_sys_futex_waitv'
     256 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     222 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:262:1: note: in expansion of macro 'SYSCALL_DEFINE5'
     262 | SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:256:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     256 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |         ^~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     222 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:262:1: note: in expansion of macro 'SYSCALL_DEFINE5'
     262 | SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:379:30: warning: 'alias' attribute ignored [-Wattributes]
     379 |                 const struct old_timespec32 __user *, utime, u32 __user *, uaddr2,
         |                              ^~~~~~~~~~~~~~
   include/linux/syscalls.h:119:25: note: in definition of macro '__SC_DECL'
     119 | #define __SC_DECL(t, a) t a
         |                         ^
   include/linux/syscalls.h:114:35: note: in expansion of macro '__MAP3'
     114 | #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:115:35: note: in expansion of macro '__MAP4'
     115 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:116:35: note: in expansion of macro '__MAP5'
     116 | #define __MAP6(m,t,a,...) m(t,a), __MAP5(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:117:22: note: in expansion of macro '__MAP6'
     117 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   include/linux/syscalls.h:243:35: note: in expansion of macro '__MAP'
     243 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                                   ^~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:378:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     378 | SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
>> include/linux/syscalls.h:243:20: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     243 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                    ^~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:378:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     378 | SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:246:28: error: invalid storage class for function '__do_sys_futex_time32'
     246 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:378:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     378 | SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:246:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     246 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |         ^~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:378:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     378 | SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:248:25: error: static declaration of '__se_sys_futex_time32' follows non-static declaration
     248 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
         |                         ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:378:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     378 | SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:247:25: note: previous declaration of '__se_sys_futex_time32' with type 'long int(long int,  long int,  long int,  long int,  long int,  long int)'
     247 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
         |                         ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:378:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     378 | SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c: In function '__se_sys_futex_time32':
   include/linux/syscalls.h:250:28: error: implicit declaration of function '__do_sys_futex_time32'; did you mean '__se_sys_futex_time32'? [-Werror=implicit-function-declaration]
     250 |                 long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:378:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     378 | SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c: In function 'arch_futex_atomic_op_inuser':
   include/linux/syscalls.h:256:28: error: invalid storage class for function '__do_sys_futex_time32'
     256 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |                            ^~~~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:378:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     378 | SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:256:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     256 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |         ^~~~~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     223 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:378:1: note: in expansion of macro 'SYSCALL_DEFINE6'
     378 | SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   kernel/futex/syscalls.c:396:1: error: expected declaration or statement at end of input
     396 | }
         | ^
..


vim +132 arch/mips/include/asm/futex.h

4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06   21  
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15   22  #define arch_futex_atomic_op_inuser arch_futex_atomic_op_inuser
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15  @23  #define futex_atomic_cmpxchg_inatomic futex_atomic_cmpxchg_inatomic
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15   24  #include <asm-generic/futex.h>
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15   25  
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15   26  #define __futex_atomic_op(op, insn, ret, oldval, uaddr, oparg)		\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   27  {									\
256ec489f1c772 arch/mips/include/asm/futex.h Thomas Bogendoerfer 2020-08-24   28  	if (cpu_has_llsc && IS_ENABLED(CONFIG_WAR_R10000_LLSC)) {	\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   29  		__asm__ __volatile__(					\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   30  		"	.set	push				\n"	\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   31  		"	.set	noat				\n"	\
378ed6f0e3c525 arch/mips/include/asm/futex.h Paul Burton         2018-11-08   32  		"	.set	push				\n"	\
a809d46066d517 arch/mips/include/asm/futex.h Ralf Baechle        2014-03-30   33  		"	.set	arch=r4000			\n"	\
0307e8d024dffc include/asm-mips/futex.h      Atsushi Nemoto      2006-06-11   34  		"1:	ll	%1, %4	# __futex_atomic_op	\n"	\
378ed6f0e3c525 arch/mips/include/asm/futex.h Paul Burton         2018-11-08   35  		"	.set	pop				\n"	\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   36  		"	" insn	"				\n"	\
a809d46066d517 arch/mips/include/asm/futex.h Ralf Baechle        2014-03-30   37  		"	.set	arch=r4000			\n"	\
0307e8d024dffc include/asm-mips/futex.h      Atsushi Nemoto      2006-06-11   38  		"2:	sc	$1, %2				\n"	\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   39  		"	beqzl	$1, 1b				\n"	\
fd7710cb491f90 arch/mips/include/asm/futex.h Paul Burton         2019-10-07   40  		__stringify(__WEAK_LLSC_MB) "			\n"	\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   41  		"3:						\n"	\
0e525e48f73cc8 arch/mips/include/asm/futex.h Maciej W. Rozycki   2014-11-15   42  		"	.insn					\n"	\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   43  		"	.set	pop				\n"	\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   44  		"	.section .fixup,\"ax\"			\n"	\
0307e8d024dffc include/asm-mips/futex.h      Atsushi Nemoto      2006-06-11   45  		"4:	li	%0, %6				\n"	\
0f67e90e1caea4 include/asm-mips/futex.h      Ralf Baechle        2007-11-20   46  		"	j	3b				\n"	\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   47  		"	.previous				\n"	\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   48  		"	.section __ex_table,\"a\"		\n"	\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   49  		"	"__UA_ADDR "\t1b, 4b			\n"	\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   50  		"	"__UA_ADDR "\t2b, 4b			\n"	\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   51  		"	.previous				\n"	\
b0984c43702f0f arch/mips/include/asm/futex.h Maciej W. Rozycki   2014-11-15   52  		: "=r" (ret), "=&r" (oldval),				\
94bfb75ace81f7 arch/mips/include/asm/futex.h Markos Chandras     2015-01-26   53  		  "=" GCC_OFF_SMALL_ASM() (*uaddr)				\
94bfb75ace81f7 arch/mips/include/asm/futex.h Markos Chandras     2015-01-26   54  		: "0" (0), GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oparg),	\
b0984c43702f0f arch/mips/include/asm/futex.h Maciej W. Rozycki   2014-11-15   55  		  "i" (-EFAULT)						\
0307e8d024dffc include/asm-mips/futex.h      Atsushi Nemoto      2006-06-11   56  		: "memory");						\
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03   57  	} else if (cpu_has_llsc) {					\
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03   58  		__asm__ __volatile__(					\
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03   59  		"	.set	push				\n"	\
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03   60  		"	.set	noat				\n"	\
378ed6f0e3c525 arch/mips/include/asm/futex.h Paul Burton         2018-11-08   61  		"	.set	push				\n"	\
1922c356ab2d00 arch/mips/include/asm/futex.h Markos Chandras     2014-11-19   62  		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
3c1d3f0979721a arch/mips/include/asm/futex.h Paul Burton         2019-10-01   63  		"	" __SYNC(full, loongson3_war) "		\n"	\
a6813fe5c28656 arch/mips/include/asm/futex.h Markos Chandras     2013-12-04   64  		"1:	"user_ll("%1", "%4")" # __futex_atomic_op\n"	\
378ed6f0e3c525 arch/mips/include/asm/futex.h Paul Burton         2018-11-08   65  		"	.set	pop				\n"	\
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03   66  		"	" insn	"				\n"	\
1922c356ab2d00 arch/mips/include/asm/futex.h Markos Chandras     2014-11-19   67  		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
a6813fe5c28656 arch/mips/include/asm/futex.h Markos Chandras     2013-12-04   68  		"2:	"user_sc("$1", "%2")"			\n"	\
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03   69  		"	beqz	$1, 1b				\n"	\
fd7710cb491f90 arch/mips/include/asm/futex.h Paul Burton         2019-10-07   70  		__stringify(__WEAK_LLSC_MB) "			\n"	\
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03   71  		"3:						\n"	\
0e525e48f73cc8 arch/mips/include/asm/futex.h Maciej W. Rozycki   2014-11-15   72  		"	.insn					\n"	\
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03   73  		"	.set	pop				\n"	\
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03   74  		"	.section .fixup,\"ax\"			\n"	\
0307e8d024dffc include/asm-mips/futex.h      Atsushi Nemoto      2006-06-11   75  		"4:	li	%0, %6				\n"	\
0f67e90e1caea4 include/asm-mips/futex.h      Ralf Baechle        2007-11-20   76  		"	j	3b				\n"	\
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03   77  		"	.previous				\n"	\
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03   78  		"	.section __ex_table,\"a\"		\n"	\
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03   79  		"	"__UA_ADDR "\t1b, 4b			\n"	\
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03   80  		"	"__UA_ADDR "\t2b, 4b			\n"	\
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03   81  		"	.previous				\n"	\
b0984c43702f0f arch/mips/include/asm/futex.h Maciej W. Rozycki   2014-11-15   82  		: "=r" (ret), "=&r" (oldval),				\
94bfb75ace81f7 arch/mips/include/asm/futex.h Markos Chandras     2015-01-26   83  		  "=" GCC_OFF_SMALL_ASM() (*uaddr)				\
94bfb75ace81f7 arch/mips/include/asm/futex.h Markos Chandras     2015-01-26   84  		: "0" (0), GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oparg),	\
b0984c43702f0f arch/mips/include/asm/futex.h Maciej W. Rozycki   2014-11-15   85  		  "i" (-EFAULT)						\
0307e8d024dffc include/asm-mips/futex.h      Atsushi Nemoto      2006-06-11   86  		: "memory");						\
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15   87  	} else {							\
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15   88  		/* fallback for non-SMP */				\
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15   89  		ret = arch_futex_atomic_op_inuser_local(op, oparg, oval,\
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15   90  							uaddr);	\
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   91  	}
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15   92  
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06   93  static inline int
30d6e0a4190d37 arch/mips/include/asm/futex.h Jiri Slaby          2017-08-24   94  arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06   95  {
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06   96  	int oldval = 0, ret;
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06   97  
a08971e9488d12 arch/mips/include/asm/futex.h Al Viro             2020-02-16   98  	if (!access_ok(uaddr, sizeof(u32)))
a08971e9488d12 arch/mips/include/asm/futex.h Al Viro             2020-02-16   99  		return -EFAULT;
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06  100  
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06  101  	switch (op) {
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06  102  	case FUTEX_OP_SET:
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15  103  		__futex_atomic_op(op, "move $1, %z5", ret, oldval, uaddr, oparg);
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15  104  		break;
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15  105  
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06  106  	case FUTEX_OP_ADD:
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15  107  		__futex_atomic_op(op, "addu $1, %1, %z5",
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15  108  				  ret, oldval, uaddr, oparg);
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15  109  		break;
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06  110  	case FUTEX_OP_OR:
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15  111  		__futex_atomic_op(op, "or	$1, %1, %z5",
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15  112  				  ret, oldval, uaddr, oparg);
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15  113  		break;
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06  114  	case FUTEX_OP_ANDN:
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15  115  		__futex_atomic_op(op, "and	$1, %1, %z5",
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15  116  				  ret, oldval, uaddr, ~oparg);
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15  117  		break;
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06  118  	case FUTEX_OP_XOR:
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15  119  		__futex_atomic_op(op, "xor	$1, %1, %z5",
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15  120  				  ret, oldval, uaddr, oparg);
ebfaebae364c36 include/asm-mips/futex.h      Ralf Baechle        2005-09-15  121  		break;
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06  122  	default:
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06  123  		ret = -ENOSYS;
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06  124  	}
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06  125  
30d6e0a4190d37 arch/mips/include/asm/futex.h Jiri Slaby          2017-08-24  126  	if (!ret)
30d6e0a4190d37 arch/mips/include/asm/futex.h Jiri Slaby          2017-08-24  127  		*oval = oldval;
30d6e0a4190d37 arch/mips/include/asm/futex.h Jiri Slaby          2017-08-24  128  
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06  129  	return ret;
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06  130  }
4732efbeb99718 include/asm-mips/futex.h      Jakub Jelinek       2005-09-06  131  
e9056f13bfcdd0 include/asm-mips/futex.h      Ingo Molnar         2006-03-27 @132  static inline int
8d7718aa082aaf arch/mips/include/asm/futex.h Michel Lespinasse   2011-03-10  133  futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
8d7718aa082aaf arch/mips/include/asm/futex.h Michel Lespinasse   2011-03-10  134  			      u32 oldval, u32 newval)
e9056f13bfcdd0 include/asm-mips/futex.h      Ingo Molnar         2006-03-27  135  {
8d7718aa082aaf arch/mips/include/asm/futex.h Michel Lespinasse   2011-03-10  136  	int ret = 0;
8d7718aa082aaf arch/mips/include/asm/futex.h Michel Lespinasse   2011-03-10  137  	u32 val;
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  138  
96d4f267e40f95 arch/mips/include/asm/futex.h Linus Torvalds      2019-01-03  139  	if (!access_ok(uaddr, sizeof(u32)))
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  140  		return -EFAULT;
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  141  
256ec489f1c772 arch/mips/include/asm/futex.h Thomas Bogendoerfer 2020-08-24  142  	if (cpu_has_llsc && IS_ENABLED(CONFIG_WAR_R10000_LLSC)) {
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  143  		__asm__ __volatile__(
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  144  		"# futex_atomic_cmpxchg_inatomic			\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  145  		"	.set	push					\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  146  		"	.set	noat					\n"
378ed6f0e3c525 arch/mips/include/asm/futex.h Paul Burton         2018-11-08  147  		"	.set	push					\n"
a809d46066d517 arch/mips/include/asm/futex.h Ralf Baechle        2014-03-30  148  		"	.set	arch=r4000				\n"
37a9d912b24f96 arch/mips/include/asm/futex.h Michel Lespinasse   2011-03-10  149  		"1:	ll	%1, %3					\n"
37a9d912b24f96 arch/mips/include/asm/futex.h Michel Lespinasse   2011-03-10  150  		"	bne	%1, %z4, 3f				\n"
378ed6f0e3c525 arch/mips/include/asm/futex.h Paul Burton         2018-11-08  151  		"	.set	pop					\n"
37a9d912b24f96 arch/mips/include/asm/futex.h Michel Lespinasse   2011-03-10  152  		"	move	$1, %z5					\n"
a809d46066d517 arch/mips/include/asm/futex.h Ralf Baechle        2014-03-30  153  		"	.set	arch=r4000				\n"
37a9d912b24f96 arch/mips/include/asm/futex.h Michel Lespinasse   2011-03-10  154  		"2:	sc	$1, %2					\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  155  		"	beqzl	$1, 1b					\n"
fd7710cb491f90 arch/mips/include/asm/futex.h Paul Burton         2019-10-07  156  		__stringify(__WEAK_LLSC_MB) "				\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  157  		"3:							\n"
0e525e48f73cc8 arch/mips/include/asm/futex.h Maciej W. Rozycki   2014-11-15  158  		"	.insn						\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  159  		"	.set	pop					\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  160  		"	.section .fixup,\"ax\"				\n"
37a9d912b24f96 arch/mips/include/asm/futex.h Michel Lespinasse   2011-03-10  161  		"4:	li	%0, %6					\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  162  		"	j	3b					\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  163  		"	.previous					\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  164  		"	.section __ex_table,\"a\"			\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  165  		"	"__UA_ADDR "\t1b, 4b				\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  166  		"	"__UA_ADDR "\t2b, 4b				\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  167  		"	.previous					\n"
94bfb75ace81f7 arch/mips/include/asm/futex.h Markos Chandras     2015-01-26  168  		: "+r" (ret), "=&r" (val), "=" GCC_OFF_SMALL_ASM() (*uaddr)
94bfb75ace81f7 arch/mips/include/asm/futex.h Markos Chandras     2015-01-26  169  		: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
b0984c43702f0f arch/mips/include/asm/futex.h Maciej W. Rozycki   2014-11-15  170  		  "i" (-EFAULT)
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  171  		: "memory");
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  172  	} else if (cpu_has_llsc) {
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  173  		__asm__ __volatile__(
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  174  		"# futex_atomic_cmpxchg_inatomic			\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  175  		"	.set	push					\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  176  		"	.set	noat					\n"
378ed6f0e3c525 arch/mips/include/asm/futex.h Paul Burton         2018-11-08  177  		"	.set	push					\n"
1922c356ab2d00 arch/mips/include/asm/futex.h Markos Chandras     2014-11-19  178  		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
3c1d3f0979721a arch/mips/include/asm/futex.h Paul Burton         2019-10-01  179  		"	" __SYNC(full, loongson3_war) "			\n"
a6813fe5c28656 arch/mips/include/asm/futex.h Markos Chandras     2013-12-04  180  		"1:	"user_ll("%1", "%3")"				\n"
37a9d912b24f96 arch/mips/include/asm/futex.h Michel Lespinasse   2011-03-10  181  		"	bne	%1, %z4, 3f				\n"
378ed6f0e3c525 arch/mips/include/asm/futex.h Paul Burton         2018-11-08  182  		"	.set	pop					\n"
37a9d912b24f96 arch/mips/include/asm/futex.h Michel Lespinasse   2011-03-10  183  		"	move	$1, %z5					\n"
1922c356ab2d00 arch/mips/include/asm/futex.h Markos Chandras     2014-11-19  184  		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
a6813fe5c28656 arch/mips/include/asm/futex.h Markos Chandras     2013-12-04  185  		"2:	"user_sc("$1", "%2")"				\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  186  		"	beqz	$1, 1b					\n"
3c1d3f0979721a arch/mips/include/asm/futex.h Paul Burton         2019-10-01  187  		"3:	" __SYNC_ELSE(full, loongson3_war, __WEAK_LLSC_MB) "\n"
0e525e48f73cc8 arch/mips/include/asm/futex.h Maciej W. Rozycki   2014-11-15  188  		"	.insn						\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  189  		"	.set	pop					\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  190  		"	.section .fixup,\"ax\"				\n"
37a9d912b24f96 arch/mips/include/asm/futex.h Michel Lespinasse   2011-03-10  191  		"4:	li	%0, %6					\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  192  		"	j	3b					\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  193  		"	.previous					\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  194  		"	.section __ex_table,\"a\"			\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  195  		"	"__UA_ADDR "\t1b, 4b				\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  196  		"	"__UA_ADDR "\t2b, 4b				\n"
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  197  		"	.previous					\n"
94bfb75ace81f7 arch/mips/include/asm/futex.h Markos Chandras     2015-01-26  198  		: "+r" (ret), "=&r" (val), "=" GCC_OFF_SMALL_ASM() (*uaddr)
94bfb75ace81f7 arch/mips/include/asm/futex.h Markos Chandras     2015-01-26  199  		: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
b0984c43702f0f arch/mips/include/asm/futex.h Maciej W. Rozycki   2014-11-15  200  		  "i" (-EFAULT)
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  201  		: "memory");
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15  202  	} else {
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15  203  		return futex_atomic_cmpxchg_inatomic_local(uval, uaddr, oldval, newval);
2db331c581c8cc arch/mips/include/asm/futex.h Arnd Bergmann       2020-12-15  204  	}
6ee1da94c5fed9 include/asm-mips/futex.h      Ralf Baechle        2006-05-03  205  
37a9d912b24f96 arch/mips/include/asm/futex.h Michel Lespinasse   2011-03-10  206  	*uval = val;
37a9d912b24f96 arch/mips/include/asm/futex.h Michel Lespinasse   2011-03-10  207  	return ret;
e9056f13bfcdd0 include/asm-mips/futex.h      Ingo Molnar         2006-03-27  208  }
e9056f13bfcdd0 include/asm-mips/futex.h      Ingo Molnar         2006-03-27  209  

:::::: The code at line 132 was first introduced by commit
:::::: e9056f13bfcdd054a0c3d730e4e096748d8a363a [PATCH] lightweight robust futexes: arch defaults

:::::: TO: Ingo Molnar <mingo@elte.hu>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Dxnq1zWXvFF0Q93v
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICPk/fmEAAy5jb25maWcAnFxdc9s2s77vr9CkM2famaaxZTtJ54wvQBKUUJEEA4Cy7BuO
4jCpp/46kty++fdnF/wCyYWccy7eNxV2ASyAxeLZD/rnn36esZfD08P2cHe7vb//PvtWPVa7
7aH6Mvt6d1/99yySs0yaGY+E+R2Yk7vHl/+8e7h73s8ufj+9+P3k7e72w2xV7R6r+1n49Pj1
7tsLdL97evzp559CmcViUYZhueZKC5mVhm/M5RvsXt2/vcex3n67vZ39sgjDX2enp7/Pfz95
43QTugTK5fe2adEPdXl6ejI/OemYE5YtOlrXzLQdIyv6MaCpZZuffehHSCJkDeKoZ4UmmtUh
nDjiLmFsptNyIY3sRxkRSlmYvDAkXWSJyPiElMkyVzIWCS/jrGTGqJ5FqE/llVSrviUoRBIZ
kfLSsAC6aKlwNjiPn2cLe7r3s311eHnuTyhQcsWzEg5Ip7kzdiZMybN1yRQsWqTCXJ7NYZRW
OpnmKJPh2szu9rPHpwMO3DNccaWkckntBsqQJe0OvnnT93AJJSuMJDrb9ZWaJQa7No1Ltubl
iquMJ+XiRjiLcCkBUOY0KblJGU3Z3Ph6SB/hnCbcaIPa1a3WkZfcP1fqYwwoO7FRrvzTLvL4
iOfHyLgQYsKIx6xIjNUb52za5qXUJmMpv3zzy+PTY/Vrx6CvmHNg+lqvRR5OGvDf0CR9ey61
2JTpp4IXnG7tu/Q6yUy4LC2VWEGopNZlylOprvGisXDpdi40T0RA7gwrwEK6FHvf4HbO9i+f
99/3h+qhv28LnnElQnt54WYHjvguSS/lFU3hccxDI0C1WByXKdMrmi9culcBWyKZMpG5+plF
cIfrZuQYssdShTwqzVJxFols4e6GO1HEg2IR6+HWVI9fZk9fR5swFtNaqjUeFEuS6SpCMAkr
vuaZ0QQxlbos8ogZ3lo4c/dQ7fbUphsRrsDEcdhVx/qCbV3eoClLZeYuDhpzmENGIiT0pO4l
YOfcPraV4F6KxbJUXNu1Km27NHszEbezcnk8MiIcmso/RWfL4edgmZ0YyNfsJ6mqzTjkWQ0H
7e6U4jzNDSww42XAQRwhC+UuveVYy6TIDIPb07GRMrT8JBcxa7voMC/eme3+79kBNm62BaH3
h+1hP9ve3j69PB7uHr+NDhw6lCwMJUg1Ut+1UGZERsUixUUVt4ra89JbqyO80CEHKwKs9LNo
4Lpqw4ymd0YL8mR+YOV2h1RYzDSl/dl1CTR3B+BnyTeg5obYfV0zu911278RaThVZzZW9X84
hmTVnagMXQHEaglmBa4EiRHwqQdNXorYXJ6e91ohMrOC9z/mY54zV78sl8giviEGbw2IDpdg
3ayNaTVM3/5VfXm5r3azr9X28LKr9ra5WTJB7d6OhZJF7lipnC14adWFO4ANHpdwMfo5egHr
thX8425WkKyaOaiHyxLq9fQDxUyockjp0VsMaBeM/5WIzJLURLgeTl+SpZk2FxGtzA1dRSRA
aagx3PMbd4ua9oivRcgnzXAR8GoN1lJTUqHDY2LYR4qy5gBKdM7g1vaTFQZwt/MbAYj7G6CA
GjTAHgx+Z9zUv3spljxc5RIUEx8DIxUnha11EsHv5LB7nmsNxxdxMJEhPH704SiesGvaTIEq
we5aoKbozoGUYB3tf1MnF5YyB4MobjhCBHwq4Z+UZeHgQRyzafgP6n3E5w0wfQTGAOaMAI4w
w0qOLkfGjBi+zEcZKUMSlVLlgHMA+ykH+YzhZP0bDGLIc2OdVcVc9astpXNLAdMKVANniAU3
CMbKCZypD2zSHNfwa4xeO5wwsGaui+dYEJ7EsBfKGSRgGva7GExUgOs9+gkq64ySy4G8YpGx
xHWGrUxugwVlboNe1harRcTC8Y+ELAtVP8AtOVoLzdstcRYLgwRMKeFu7ApZrlM9bSkH+9m1
2i3AC4AgeQThlXVHYlrvV2FK2Vel+Sd3GGtKbCvBDAvgUeQaYqvheEnKMZS1jSBUuU5B9uHz
mIenJwM/zL5ETbAlr3Zfn3YP28fbasb/qR4BCjB4o0IEAwApXUDoTExCix8c0YFOaT1c+7p5
jL9McwYQT60oeJGwwF2rTgrasdKJDDz9QVUUPLGNfzkcDaj4riRCg7WFSyZTz+gu45KpCJAB
rRl6WcQxuEr2WbdnxYz0oVuM1kxAYrPdwyBMp/bCxQ74q0UpTiv4o2C0od222jNOt7d/3T1W
MNp9ddsE3jpB3GEa550U2PKxBF6elH4xmPpAt5vl/MJH+fAH/bS4UtEcYXr+YbPx0d6feWh2
4FAGLKGRt92/iIeIvkePxZDnT3ZDOXLu/pd6eFkTBm7BJ/+QiZTZQsvsjA7lDHjmPH6d6T0d
orF7ALbEMP8QuQiPibFW56e+HUZ6Bq8RhyvlkUAxUP2Vv7viIB1fAb6klVEvBMCtOS1gQ6S1
sSF+PEI8OzlG9MwpgmsDUF4tRebBbA0HU6nnhvVjyONjvMoAvoLyGLOaIRHGJFx7PO92FDDf
UtM60rAEYuEdJBOlRwh7xGZz9scxDTKbcy9drJQ0AtQjuPCcR8jWokhLGRqOIWtJG5H2nrbm
L5DMg3X/vDn/cH5SfhJlEryn9aNhUfoPP/3DSbkIr04Iu4HUjydlKOYnrsnYnJ6cQGth/8k4
HZHdnH48s0z4z4hpYLLsHK57Pn0Zxu7v8oqLxdLBtF1gDa5woMCzAGsJToSD8axzIlNh4NUE
t6m0/owL1ZgCYXSR51IZDM5heNN52MATxIBOKJdcgQo63l1eNJpbgm0RbIjU+xE9PNbs6Rxk
GrUlp7AakLoJElx0caTBi+kIgb3O5qWaewS4QdfoGK0smDKn7y8uToZcmMoZT+CGd4iD6tmH
G4VtroCGARAypdAMrOv6ck4KdzYP4NhqFDAc7v/CAj8AL31ysa2KwCTxOrRu9UG34KRBlofv
z1W/yXaSUZgEPcPyfDWAhD3h9P2KBoc9y/vzFQUTbfwaLsimvAGzKgHeqcvT085RQpMAOo36
MVIbu+YRAdvwEMHrjrmxqQGH0t6dqEjz0iTBaMA4b/dw2E2dr4BWTBtrrR0MhKSM88imBHUK
amaHBs86FaGSQwjZShsJLqatSmyIVn2dhSO5mRZRc3dOpgQ4SX350Q10D3zAgeZMqAPtPN43
1WxkYmLw7YAfDAFmOUeh+zmNTIBy/pHQEmgHGzwa49SDI3D4C/oVsKT3PhKaeT9tKDK1Q0zh
5Vy66ciby9M+LV3b5qXCuPcw5bfhnriYYnppFdYPJSWYqjh/f97KQUiJ7qt00hWYoTUiKyMz
vgSgtizPwXaDoDV1OBnGMlwGv1iKXf0gZ5hGmFWH90qmP8YJTCXfIMSlHtvJmGjzE4lx7Ml6
Wr52R6ajjp1wayr7GHi4ijhhOMCBCVc2PjWl5Ys675+Ai55oeAvqbNHLfvb0jI/LfvZLHorf
ZnmYhoL9NuPwavw2s/9nwl97Mw1MZaQEZuNhrAULHRiQpsXoOqYpy0uV1RYBFp/1VoGis83l
6QXN0IYNXhlnwFYP12exfnSx3fupWNTEvLq3K3/6t9rNHraP22/VQ/V4aEfsd8gKtBQBPJfW
n8ToHWBnN57XoCGNiuqSeyRd02i70A9Nv34pqUlewQcqjKoIgyd1YM/JrzX9064/EDpavKv+
56V6vP0+299u7+t0W29OwGIjNvDlr4je3cDiy301Hgvzq96x6g5uy0TuQfRttR5kUzD7VwDK
vfGFjWvwCHrGshL92XIdaXk5qqPZ7gBiHwC0veyqt1+qZ5CG1JTa0DZR2t4w1+CYdigQRSQs
GLqTrlah1W3tSjBMINkFC5gNLwtMYkak1RiV162KG5KQpQ5UqK2OUJ/gAV7oqfmxPayAlnMp
5WpERBcAfhuxKGRBZPU1rByPvqk6GF0mhCmA6oyIr8H1K1Q4vm0W88AUGgBxkVkUNR6jhrky
jsuJ4DotUxk1JUjjjVAcVszgJlv7ixlem+h14+g1nx4C5Db4i/2pdptMqsfEx5jazF4fBlYY
mm6uESTC2LGNxo6WesUyY5NXOVMYZW6KrogZNA/Rph4hlTFo2/CVayi+pI5dEyogD410EyU/
1A4/lXRzBomRbTWAOwsqE5gzq3CrQZLBkkFVoNdyXMblyf+Pb9E08z/iAHVpdinnoYgH8VoZ
FQnX9qoitFHu6XXD8w0qY1aX/OAGEApte9swNjg71BEN3tcRg52AvEzDXh+nmtPWbhmZR/Iq
qzsk7FoOKhgTWxcCkoMfGLkuSP1G19cNd5GSvCkjVOWg1Aqhj5tkoEoEahWrFbvJI5XZOBRh
l+HLAbr7i9a5kbgz86Fcv/283VdfZn/X8Ox59/T1bvzuIRsRXR/PYdnaQs46bdXnBI7MNFgu
lsDmSbEQw9yy03w05/DKg9Wlu0yZYorQfQpsSk1jlspxBGsFH+Be29Q43giLabxdcxXZMY7W
Ch8bQauwqxf11Du1nGQmuyHiuSs05o15GXfu6N5izTHj5uaH2MallGNGTDRdYWWDRvvUVSqU
IrVOIb0i+4qDxTfLyzfv9p/vHt89PH0BhfpcObW2RokUDgBsU1SuMGlKjBU0lTHdz7puINAL
omTOofqqJPvCA8MXSpjj5QkYsvFUJwDHVUD5onVfTM7GeiwcrlTmzFMVl6ya+uuSZ6G6zse4
sHYKtrvDHd6VmQFHbZhlZQBKrBvAojVWQpDeo46k7lmdbHosBs09mh/NWNeVyr4SyYGZ6SdA
fXUYAEskhsXkDnF1HQyf8ZYQxDR4H87Xjthsl84BgeJNBos9LCCt6fjuNPRjNLLvFSgJ93V2
icPeHUC2hb6RFRG5tJ9FXVEMdfl9VkowMgnLc7yELIrs1bUXsefvy5jsEfH/VLcvh+3n+8p+
STGzqfWDc1iByOLU4MszmrMnIBwwbglK/Uq5J2dfLRtybJ9q7Ocvq2sG16ES+SBl3hDGNVTO
NA007ZTCt8I6LV09PO2+O97Y1ClqIngjTBAzbcpFkY82ZcV5bktDhprQlGoLLRM2vFA6TwB0
5MYqB8A8fXnu7ho886HfscawsuJoYUdJ/M45XKjRfLVHU7ZFHO2uAnZxlcSCTkCxQTGwTiud
ErO0J2pBVyoyq3mX5yd/vG85MBiMLoTFsauBgxsmnNXeD7nEGJC1Qa+ROmz7KUQ/EjhTk9K5
KXVc/e3QbfUTPRGcLmf68kPf4SaXkjbRN7qukaHTfVFbm9G6AfTRcmUDy976W1C9yRct7SlZ
8IufqLSXPNoetjN2e1vt97P06fHu8LQbYcOIpWMla66Pr2+XvvPeoP70O6SaVYd/n3Z/wwDT
ewaavuKDu163lJFglHIXmXBKxfAXmAu3sCuuG6UcBHBt23jIHm0k9HZvYpVa/5ekYhHlil8T
QopsuCSR1wV5IfN8jAQM7btcKnBfOFVyDkx55n4xYX+X0TLMR5NhMwZ+aTDYMCimaDquS+Qe
JFkTF2jXeVrQWXJ9nYHFkSvhCR/VY6yN8FJjWXjS5kBkdEWwpQEA9RNFPg4HDOl+/QhzNKGL
Y+Cp4wmLwHWzOye1oV++uX35fHf7Zjh6Gl2MXADnuNZ01ibNoadvC/GzOwyApIyscMPl5ibH
TxMBvMfXrgK1vfPltfWLwRyluc9kAXMdeKFxa36ECHoYhZ4VCCzs9uiv8tRzGzhfkgAvOdme
zD0zBEpEC/ppsnriKU1ZJ+DDfzyZn9KVVhEPoTctSRLS1STMsISuVtp4StsACHrS0Vi74zE/
nHOU+4LOTOKa/WX2Uehxp2DbmfU3SLLMebbWV8KE9HVea/y2yvMOgkQ27O29sWnuMel15Ts9
5VL7DX0tKTh+Xo7kDL91A2UvfVyflPFPkIXjb2taHFJ/H2BvrBJ0HY7DU99oykIhVW0Q3V2X
w4Lq4FMyeqtnh2p/GKEFK8HKTD5DaiDBpOeI4D7/zp6zVLHItyxGQ+CAVmN4+9VG+YxAjOXT
tLL4LM2VUDwBb4o2Q/FKeII6uFN/0EOGTNDlkyHPl6UvNJHF9KJyDaZ5nIdyX9mYpiVXpsh8
9bYxEwm6lIQKcbM0AIDb+9chzeqfu9tqFu3u/hlXd4fhqLCtT1Hd3TY9ZrJDhT1gq8OrS57k
pCRwx0yaD8MobVuZYlCW6AQvWRaxZBCkz1U9UyxUaiuF7Cfc7criu93Dv9tdNbt/2n6pdo5/
eFU2afWHbnM2AO67cQafjnfcdTZluiqCs43CkZdtLJej5zYmhxGq1i32PEYYhqpT6McY+Fp5
UFzNgN5IMww4pSnoDf02IxvDCp6W2YYBiTPqqvww+VEYOfoEWfFF6mYT69+lmIeTtjS1H3kM
w8xTpesqEL5YLR5oYaDCVJugXAgdYImLJxi6MZ6Hta6ziFKP3VkKtMbkAbsCuaEBuLXhqLJ/
qKj9JbTtWI6r7TeQ+BcwDrune/t5puO4CfyA4usW7m++ezo83T7du98U/r/6O+rc3qqUY6CA
dmqlXGBQvmGdLM1U33bb2dd2gV/sAl0ZPQyTu9JujTN1psko9fBPIcBPq8B6Ilof/3ze7vYj
24fdmPpgI6eeNAFwtFU4Ey6HR8Y1eSwU3G9b00nMMAnQtgJaCYs9FiM8Yci0/o7G7LaP+3v7
t1FmyfY7sRIb2/KuwlLBdaVtmqeWPvMRhJei4sg7nNZxRD+TOvV2stsrc//5jMNQA2IXFAe/
vQZ/ExVRLH2nZPouvt/u/5rd/nX33CjoZIfDmAaASPuTg/fgM5nIgAYvYACJ7Sez5akThZxS
50ep50MqiFWKU6JtPlFH5rFzSPN842QvSYAF/6T+Htm95gOj52cElk0jhnlrrq2NXU22WCJc
2uCK0aP1n3qeMDNZTle6fnzO+kvt6v7r21uwmNu7xwrspYkac+47ffxYNAbsTrsm9pjCZT4/
W/mKOFuW84/J+3O6ltPqszbzC/9d0MmxU8yXx6jwv2NkayPmqZnCwehu//db+fg2xF30g0m7
TTJcnJHH8vqO1w4OQEAnKQVDYsuk/MnahYwjzXPjsMgTyS1UVNt/34GR3d7fV/d2ltnXWmnr
Z/OeWIydOYJJElFGHgTRsiEUOSKN5XE+s6BI5yclD2kLOeCbXwRl4HHLR3O9zpduxCtTLnKP
+9dx4G3ET7iPc4UAm7OQxp8dE1NMe7zKjgcTwEmZLNKJoqZ3+1vyEPH/tHhFwEjolczwz974
r18uyvEp1xk7OLjq8Zv9ZObl+flpdyCUmLt/j8xthVcMPe109FdGPCzwXr5yZA3/5PDb5Bsh
bBcNwPtnl5TkUaRm/1X/O8cq2NlDnVbwmMi6AzXh60MR20z+9S+kFoEYbiM0lFeJrVLSSwne
oZvmahkCHjR/h2x+MqZh3rB2WwZiIGmRFDzwP/x25KPQa3kNvuTIjWhdNOPogy2C78NvNk9i
PMkkoGIC1CjO3QFKzlRyTZNWMvhz0NBkogdtgzy4xJozcIfXCJ6Gf04ESHVSm67BANjlqfZv
qjOoyo+sSBL8QUeUGqYEsOBRhkgF/qoPO80rdN8LGUZYrp+vTBit6RHwr0ngrmAU5vgUwdR+
ZOuUz3RnOXoMDu2lJ7pkad4cgyXaT7vocKA7YWc8KSebRRfzi00Z5ZJ+AqMiTa9RdWhfIfxf
yq6kOW5cSd/nV+j4JqJ7ukgWlzq8A4pkVbHFTQRrkS4VepamW/FkySHLE55/P5kAF4BEgp6D
ZIv5EcSO3ME3nsvXK8dIhhMhr/ixwaDS5pTFhDKD1QnfRCuXEWrjjOfuZrXyLESXCN5NS141
/NoCyCdCc3rM9uCEoR0iKrpZmQ1vhyIOPN9sSUi4E0RmEi5n6BnY1WvPkFZlrAM1dy+YT+By
5cmOiOU5ZDyDX7fp/fXIzVqU2J0uaXnupTWKDt/nM1dSYFUQ8VQj3Wwo6egyesSGKNgliEJr
IRsvvpi58gFwuaytCBC9rtHmUKfcPLYdLE2d1WptXHGTrup0Jz8fv99kb98/P358FVkzvv/9
+AHs8ScK/Ii7ecVj+gnW5ss3/K/axW12nRqsB5XL/7vc+VzOM+7hUWyd8AKUuYRSH42LDPW6
tVmkSeMDwVtmPL42Lb+QE7I+1ayc8q69CKhuZVLeQ/NNJ2/MGDQkouujeiw1LEtEulTTwS1e
GJwYlYf6XxhKMHmCWcykd+FYra4+Inzr5h8wJP/+7ebz8dvzbzdx8jtMGSWuqj9CuJ6O69DI
p+YNenjJrEke3jb5cyh+mcYvEuJF10ElavQJ5ZqA5NV+T5muBYBjCI1QTM+2HtF3bT+ftSNL
vgpM5GwAdcguXkJk4vcCiGMK3mVInm3hHwumqU3F9PLzpLn/offjWYTsaY4mgkLxB5Iq1JMz
Dyu9WscdP8REWpuOfj2cZ55K2jogPcAk2SymmNasxm6Zdw5zVbso93iSOa3nltJWZozT0ugo
y7ns3tU416pMqMkrmCIjBY2W+yOVTiK9E4FlFpemNqV0OCxGDwfzaNck6XShKGjqIexFW9ak
x4SwFxDWWqgfJ/gPaBduFhVhKm2P5grC8+tJjIxIvUu8faL48TIvjNF7gMd4jFYf/RNmrWng
SGMxug7ryX27g67lxOQa3i7Yg3pmqCQY+bLNNO9JldwYc8kqAC4878aVhdvfJYrCTUB2ev/u
tqlYElcmP1IF1SlwNCmZxabMCdpLmG/F2OJYuMhqDd6nRVZmwwiYZOYC+HwlOYb8uwsZ4Rnq
j4VnVOdBMS5Ic3FKddKHLuPxuBjFk2spkiKVDCqHluh0sSRpMTO2+XBkZ5FSwTQMQrFlL1rk
auDVzjw580xm6htFB3wgfpOLQCmbgayfL1UAEKystK8U+YWfZ1urSt6dFz8ODfulxs8GqYzd
6E8i9Q4QL+4aqKbMOrNuTQtqZErWItVeCPy3qcqqMI98qZedXS/71Datxja0h2ph7dfAjGOA
H1F7PFOQW7UX0kANgD8hymjQ3Ys+lToUZwU/0q6IAyw15j5UEVXOmh38pER9eGGMNdCKiNHy
d2mpElox6guF3JdVDQyStpWc4+sl38Pet9TOU2bmURTIOXtY3E+k/K5WoZPoU6gDLm6b1M8u
mcDZMHkObAWFgd2U8nuSi/Z6y6PNxi8ofiyrunS8Mxa+jrnJ7NYbx+dUpVY1kd02z0xhCSBF
St9QmZRC8z0HUsxac+OReAtbNrF7IrlO94xP3UQUetPmkUNolka6WfWDdNhuw4hIeIZ0+KG2
DiRn9YGq/Zni/M5sHr12fvl4fsV4AyCqstb5PC2kGz7tBW3uw2ygjDHCu9zg4KbILcm8btnb
tx+fpHifldqdKeJPYBYTbRbIp3ghQlqQPoUSJKOGbyl/GQkqWNtklylo8O54RS+dl941RxNe
u/crDK4kPFUl5M/q3g5IT0v0iVimdObMzKu9eZvei/xXWhxS9+zKktr3I3MCpAloY1iqI6S9
3Zq/cNc6K2JFaRhCWatgXIfgHAZM0nkyN0Fk1jEOyPz2dmuy/w4AtKT+86vhTSQIjpXw4R6A
bcyCtWNWVKqgaO0s9L+cnwsNKiLPNevUNYy3gCnYJfR8c0LXERSb19wIqBvHNVsRBkyZnltC
ETFg0LMdedWFz9lYmRHUVmd2JsxgI+pY3hJmp7FWsFNQ9+b041q417Y6xodJVNMceWkXvxez
2qEStQ6gLeGRPZZyLyPRudlpWtnK7PsYx7xjFojISkUER0gA9gsHboS6hEPWhEry3xTZeibA
iN3w8PjxJLwTsz+qm17R2PMaeMmLouDFP/H3JN+WeAwsVM01lyz5vGFm0UhSO70CvGkBARXD
12zFNPFCGaze2gFyiyIgR4Exa4NYkU4tRwOLYOrcIWzcdKbLc/Lvx4/HL3B0KtbK7mttqyQa
O6lpRqR6CeM7Sy7DfbmK7AFKQPF5/gxw42OMek60lC4YxbiJrnV7r5QtDVjkQ5mhZMy6mSdo
+UDPavQzH+wEzx8vj68Kk6yMDcul3T/WjBGSELlaItHxoXL/g7hmQesOFSdykbLricGjUndx
VWE71F0Yc7UroFl/ahXSbCUKoWxEUlT+T99EbTCvTpEOEGPtZOo8Kje7AmS8xqjoE5a2CE7o
lTvUrnWjyHSJjAoak7LrRHQr7jyrhvCf97ff8R0oSkwIYTcyGF+7EuDg9RwicaQGIQJFJQQ7
Yypl6gj9CgnloTLk01J5tssI7XKPiOPyQkh5PcIJMk5le+9AtqTvHaTbZv9s2X5p5DvoEqwT
rGu+iJwodqfkHc+veb1UiEBl5S5PL0vQGHUiIj1Tts9i2GWILN1dD9dTQ8XgzqntSJOxL+K2
ySW/Ox/5UtoFE8oGUl73nJAO0UeoJTK/dKULayUhjsOr3X0oZktB1sBO2M9ZMx9RF1l3753J
PQ1OB5lpS2Xzh4cyXWJWgYhpLHwEbtnac2zlDxnKGziAjN+KYQgI9nUEXVA70JjuV4JunDh9
tTH8TNNGdjSY7vk91euCSJnx+55pjrxVsqEa59z84JcCqxsbhH414gj+kPmaYYlU+uMhadc4
xPhU3OZByM5An4TWKxQZOyYO8H7TxvoNnA4GDo2VHesvY3j+hWFFnd/6P76+f/98/d+b56//
en56en66+aND/Q6HADq0/6emNcBawwjQ7rqISFJMVCoifqxOu4hNi/RkZveQav1MVph8CZAy
d4HGpxUtjyG5jtlydZtbz7zHI5FnRUvYHpEsd+sZ75/+hLn2BrscYP7gBQ7d49PjNzEB5y6w
on+zCoPMj4Q/jBik2g0csyZBNKPaVu3u+PBwrTgRioqwllX8CkuUBuCle5NFJ2pbff4N9R9b
pEy5aWvkfmhciuScnvR7S9zMI4g5IxgAOVUxfpE0Ko0Qlu9tEx4hVBSfunMo73kmywKvNQMO
mlepO+GQJsONpm9Mdn7J29fZTfH4HWdVPMQimOIrhEVXsB/m808YfKXfS1ruJ9eNKKBt1m6Z
7mmOj23++bK1/d5BQoBduyIPMnEaUxAzlgCewW4B/xLRVQIgzzqSjtwP6acG9EouB5KOti3S
7R8BwGdGGQ9WhICMCAs3i+NORVkg8TK1zenU2d6kkR/uy7uivu7vbB3AirnHsZh2P14/X769
Pv+ECWeSIrDmx/m+iK/2waTd1J1NVPihDlAkoyM3Jv2kLwBHVJungXsh5Bf8CLmD8Lowd8eB
m6ZmXWuSLfw5X9zSYlXzmy+vL9Klct5j+GKcZ2jPvRXMnrEOCkqI+0ug6Vk71OQvkZnz8/1j
xlPUbQ31fP/y7zlnhHllHD+KhqtLjc87rcCYrip9E9naOmsgmi/IRDSf71DN5xs4aOC8fBLx
rXCIiup8/y+tu/RPZkkbuTWhTZ5jp8rJ3mw4a/rQwqxEuWRsch/M3hGus1tYsxLmvxEPz6+7
YxlPVCdYEvzP/AlJGFokz6bu2+Y2d/UqgGnw+Mqs0u9BmOSTkFoGyMXxCVm/h9QZphE+EMzd
UFBb7EwccE8fVRqzV6s4zYlIgqG5vZ/HlRunfgPT/vvj95tvL29fPj9eTbZjCjIMC5QL81gZ
J/lAhAJh8tMuVsh3Bs1ctetPr8krWXM3dUqRQzutvPKedLrUy7rGMjRm+uh6cvpF2OV1+/r4
7RsIBKJ8A+8m3gzXl4vIsWBWy9aDdpmm2zgCAUjOVDYjQd61+M/KMW/gAjIsDxt7L5ENKXII
+iE/m9UJgppX+yw+mXdaASi2UcBD89qQA8YK5icuTNJqa85+JmE0I9CPe0xYqATdctzLMSuS
646I67PMjkHQFE+ff36DDdw0a2y22w5QEm6fYpDOMJKWYRCWQEIhOQJcS/tBFtz4hKQ3AgjD
bwfYRb5tpNs6i91oOmsVkWHSh3Jl7hJT3/YjM6cOnNTCiMA6dojLEvse85yNY2mP7HSz5VQC
Ys+LIluXZbwiogfkpG2Ys55GX/WKwnkTpRcEyKZ0hxmognx6+fj8AcyEdetj+32T7skbVmWb
gYmYXpDdfdv4jfH1s7kn6+oscuxwozeXpOKFF7mWzE99bnGTrxMmoWa1JmbvocmozNqjTgrW
9iow137LWjgL7q/x2V0R2okeknA3JCaLBrF/SEDM8lQP4VsiK2zXHorev7+9c8MLdRNsh4G1
4YQrIh/DBERcKNnVJuM1gqwYKCjaEFGKPSavo5C4orSHkAfh+B10K7XPhrz1At88RiMkXjuB
a+ZNe1CSdhduYC+tAyL7RY+GMVk7vnlMNAxxV6aKcX17NyEm9MyTWcH4v1AfP1quj78hVoWK
CYj5OMzpYuutzc3qZ+OeHfcpjo27WdvX2L7Kk11GpCzpQU3rrwiRq69U027Wvr0fjzF3VoR+
ZGh/stlsiByWdAARhgIUzOQZLu6MTCrFAN8/mYXqDISyOosLSCzFdeYdGRslbwhMDJ9ANyIh
9uJ1JivDp+iwqvFLjVASYJK7rqSZrHN+/Pzy99P7Xzf1x/Pny9fn9x+fN/t3OJLe3vWTbyh0
LAwmwIkukE7kgvEFQ3n0EWpFdAZQK+YhyxpM224FdUKIHZSc7XSMEfYu5up0kC4DyznRjUHF
vk5ifGouF+YAc50pvWdwultZhi6PHz+e9DSKfFvHlkpx9C823fzGTWE3W8yJboIjYVY/ofz7
7x9v4tZYW/ajXXJlcRvBHkB4eCOAe6Fj3o16MnEpdw3SvhQ7iAh98T5r3ShcWWJMENQWaS70
zzGVzWpAHfKYSEaGGOgvf7OiLplGQAIyhlOczQpO8ZlL7a4uZGQ0Qgo0dJq7VHRKwoBXoOuA
ZN8lFd8KxFYJATHv7T05IK5778nmw6MjU57vgpyXdNHAv6eoXuTXPaEhFX0YO7CuL9Ze6DHW
sajdwDV7qCL5kAVrWOY4LObjq8VL0ngWm/sCyfB1SjTGL2R3PCDkXiTfpoXt7Siqi4iQq0c6
PcyCHhCqQTlXgbnzQzNn0gHCMLAsYQmwzAYJiIjsaQNgQ083AYjWVgAwctZGRBsiH8VA3yy8
vzFrTwS9DTzC37wn20pPy53rbInkT+nDBXUfROwtvB5bqacM0xSR19wjpGypu4CRClyHWS2G
xDregehJsJni7XYdefT5YWFSBTn2Wz+y0G8jQnkuqKXfBoS/PNJ5GtsPHp6tw+CygCl8QgUj
qLf3EawvejfkbVEbc0siTagUtYBMeNqi2c/z/Mu15cBD0QOX197GsmZQHiUUgt1n8sIy8Cwv
iJwHbc0DZ0XIXkj0Kc2xJBIqPFEpAbBsJRJAyHQDwHXoxYjthp6xnM8dwg/o/aT7iqV3ERAF
Cy3dEP2kAOxMwACyHaMAgiOGWKTtOV+vPAuDBoBgtV7g4M6544aeHZMXnm/ZCtrYA2Hd0mF3
xcUyMfIqPpRsz8y6E8HYNdlDVTJrf/YYW3eei2htObGB7Dl2nqWDLHzEQw9jeymbjVkoF5tj
dSiA3Q0dKgRRBQGzadlmh5KWQcBdX4qj2f1JbofIiln206l9ciICxG6wwJzfxZjuDZkqurIy
EWXhrK7UoSyaxIuj9VMCMBvF3nJgk9L6UwAziuRMuw13eCS1yibCLrugr3uVt2yviYsjpLvp
WrjEHil3hhGOcSDyislffAH4zv1ke5thUPaMAt9cQZb4HsFwKT0AYggROaaBXGIfnYCWStqx
0vd8QqiawCizywgjlb0jJOP5xiO4ew0VuKFjFjhHGLID4VITBcjMraigKCREGh202FW53NV/
ARWE5r19RKEk4xMngIaKgvXSFwWKYOh1VESILTpqQ3CAGgpEHHex+nHtAIOzWFrtU9GkKiiK
iOBNHUSwKSroLtwQIqKCAilocY2hlXdNCJMKahddiDNWBR0fUipKRoGdYK0ujrVALa5pgSK4
TwV1NmuxRgRKTYRUoYICKshZA7nrpWXYtHeu45l5BRVVnBYHGYoKwsXZzvO9DyOzVBgH4WkV
LG1sgIrc9dIcFajQbIoYUcAL+07gLdUf+WqXkvh1GCzWpR3CKvZMYM4v1c1f7o/T1DmtR0iZ
eLxeBx5gCuXh7zxrNP+vBp2x44q4WlZQT10CNvUdBmIUXlxDJDnJmushu/iHhIhUgGOPMix1
NDICN8NtNKXiVjK09ScNa4mcsw3JlyOpbVJWPFAJJKBi+6rBK9ktX8/2R1aa5zxQ2xZezYgU
Gs00QEPt8N4z1zBIWdP5hWXKtUr9w/aixiFlYvuCh2QXiGgtqhKXbXW5UomWsXmV5s0tzRWp
IQyoSJOMXYEkfCxkXPZQED6OD6FHWCZEcpdjztMIkSSkYVnJDyypznNYH7ikVE2vWV8rpes0
wtVyQWMP3CbNSQQc8TRP47khqnh+ennsRYfP7upxvX9YIfK0Dl2kUWGa5RVI8CcKgJGELUgJ
NELcIUcRedJQpN4tkKILzxd1ZAdPuFmTla748v5hSBNzypJUZCoa53bXO1XZNpicQxGvktO2
3/8mH9UK73yWnp7f1/nL24+f8wt25VdP69wdPzs+68LYhiFXKDjuKYw7sctIJEtOFq8iiZFi
YJGVeCyzcj8NxBq8ouat0Pp0CF15n18XN+1I7D+zuEsV1l1E8tfL5+PrTXsyfQTHZHqLlULS
MjoKLLtAB7G6xYRQTqCSkvuSoQlO9Iqe/AupeLUuqoXR+Rs2TMw9SRmmAX7MU9Mg9Fc5z9uk
rlqDPVb0Je483cQ3HadivQ2N0/Iai5WYrUPC2jMCHPPRhl8uGsrahNSEbwnBX5Z9mFx6a6LT
W/JtmpZmZkDuxsgtlGaRWVSdbSiWWXy9TZkfEg6XXf0YC8NVYHar6QvZBRFhN5UIqeo0L8t1
Pm58XcIyElikhQs/VhxOwl8qEHdiG1BOzCL+g+OVoLiGu3hI3X2k4Fcusr41Zvs41lu5mJCu
NA3S93ntyinx6PHty8vr66N2WYl+qLUY5qCk9hB7IbJGsON+7S7n+/H08g6nyJd3dED97ebb
xzveIIXhNhj/8vXl56TlspD2xI7UlakdImHhmuDQB8QmItwSO0SKqaB8M1+iQAhRTCIKXnuU
FloiYu55hAq0B/geITmOgNxziTuZZUXzk+euWBa7npnflbBjwkD8tHXbuYhC4iqAEeCZlRnd
2Vq7IS9q894oIbwq76/bdnedwfpLGX9p3shQloQPwPlMgp0mmHnj9xEu6psjn2EpDZiB0CF0
EyqC2JUGxDqy9Q4iAsIPdkRE1mHctpFjGySgE36mAz2w0W/5yiF8bLt1kUcBNCOwYfAYcAiN
sYqwdZbQa4aE9bXfTWrfIcR0BUHowgZESHlndoizG1kHrT1vKM9lBWDrdARYu+tUX0AU0xDK
vMaV86gtLON6CR1CQdJtRhfXn+2rKodrXFPPb9YvWqeSQBCpA5VVR0SsqIilMjzrPBIIQgs9
InxC89ojNl60sW3R7DaK7DP+wCN3euJoAzB0tjIAL19hD/0feaEtpr4wjMSxToL1yiPsGypm
usFpX59/aWQF/pCQL++Agf0cDXJEZXDjDn33YOZa7IXJwKCkufn88fb8Mf8CMmkgurizCdEH
3ExeHS53egaG6O35/cf3m7+fX7+Zih6GKPSsa73w3ZBQX3d8FGHu7HoHM/HVWTLdkZTbW4i6
yso+fn3+eIR33uBINd1YJb9yyHzrIXHIIuLKn64NBfSxbUsUANsxhQDfxjshIFz6hL2jC4z+
WgAQKnsFYNtaEEBY6AbA2rEdLtVp5TLr1l+dXOpS1BFAGKFGgJW3EQBbM6qTv1QHACyWYDsL
qlNAeUCOJVhPAgFYqsPGDghdIu5nAFBm2wGw1FHhUivCcKGEyM7hVaeNS4SPDYClSm6WxsLx
IuvyRcTWztLwICDuP+t20nZTrAh9hIKwyoqIcKznNiBqynNrQLSL9Wgd6zIHxGm1VI/TYltO
9rbwZuWt6tizdXtZVeXKWUIVflER9wlKQJOwuLDKzxJhq27zp78ure3xbwNmY1oEwHYaA2Cd
xnuryOrf+ltm9qfqGGMi/bKkpm2U3tqWAvfj0CvMjJX5vJZ3zMIzk46zZzf9yNr97Db0rLth
ct6E1jMcAYGtYQCIVuH1RCQb0RogWiCvQie5EpagZ4ZtONHBkTAZD4Bgyrl01dE/PoSY2/m9
PXeCqa5SCd6eM2BSxYY0Nqr/uiLjS+L+H2VX1tw47ty/iur/kJqt1GYl6k5qHyiQkjDmZYK6
5oWltTUzqrUlR5YrO/n06QYPgSAacl58oH84CDQaQKPRPZl0C49R6bp9P9LIpt3mrCI/rZRv
7OP9en49/u8BNeNyP9vS4Ul8GfRHv7QpaJnn9qQPXIo6ge2VhTje2sod90jqdDIZE0SpX6Zy
SiKRMxQcRDRBy5zulmgs0kbEV0pan6Q5oxFJ6/WJtqDn/R5R35Y5XWdC0YYY2omgDUhauA0g
41DYqOOMoLLBQEy6VA/gMWs0tPFAj/iYOYOxIjpI0hwLjWhOWSOR06d7aM7gHEL13mSSihFk
JXooW7lTku0Ed3pDgl15Nu31CZZMQa5TI7IN+t1eOid4K+x5PeiiAdEJkj6DrxmoksckS1Qh
836Qlxnzy/l0hSzvlRctaXz7ft2fnveX586X9/0VzqXH6+G3zncFWjYDLyxENutOptNb28rE
UU8dmiJx3Z12/zEk9trIUa9ngEJqr5mIvC6lgKn1T9J/1793QPBeDu9XdN9LfoeXbh+aRVcS
jzmep7WEN+eIbEg0mQzGjimxXzUPkn4Xn+lUDOHV03tFJjp9rYas39Mq/RZA1/dHpkR9mIbL
3sAxDBOsZ+0B7ZoG1GkPvRw709B3W/076U767U7vdiejNtQZaUO/9kVvO9XzlxPR67WaW5CK
rm3XCuVvdbzbZuIi+8iUODYNl94RwDlbvR4BC4SG80S/1X701+TqVRf9JZflmsWyzpfPcLxI
YMXethrtjA3fDImOgXf6WiJMIm2qBKPBeNIztXmgVR1tszaLAXsPDezdH2oD6PEZdlg4Myez
VvIYk42pSSt12mal4gu0SeIzo8zrj1qcARtGp5saUgc9X0v+5vVgcUADjNgzZJBrXD3yrJR5
5JjjnJnozFZ8jWMcJV3eFHN+XN8XZwLqjM6X68+OC2ee49P+9MfD+XLYnzrZjQf/YFISe9ma
bBkMv9PtajwRp8Oeo4t8TOzpnDdjcIbQxU6w8LJ+Xy+0TB3qqRgYycDjXU3AuavJ0HFMaTl8
nzF9PQgMBRuWstHUqXqWC+/zM3mqDx5w7cQsQJyuaFTRXI/+7f9Vb8bwsb1pzRv06zW5svZR
CuycTy+/yl3JH0kQNEuFBJPghk8CQWeU6ZI0rWcCxtwt7amqg2HnO5zD5fLbWvX70+3uq8YL
0Wzp6PyBadNWWqL3vEzTugTfoQx0hpOJeu4iUZtzeGTr69wqJougxcKQqK8ubjaD/W6/PeVH
o6G2weJbODcONRaWm2WnxUvufNrta41axulK9F0NKFicOb6G9AM/8qvxYufX1/Opw6vYcJ0v
fjTsOk7vN9UsrmXVUsnAbmsLkjiGrXBrxyvrzs7nl3d03wqMcng5v3VOh/9psHutOZDsgjGu
87lv1BxQZjiykMVl//bz+GR0oesRTiA9NEmSbjVB9qOXNXyr2TAjK2QwZFeVL9WVm5JcqGku
+9dD56+P79/R2XZbWzM32ycas8l8s/3T3y/HHz+vIDYC5rWjEdZFAzVngSuEISxmDUIT7IAv
lpkFWrbpTs0lV53ez7DoPB/f31721XCYWrdeuKYIGNUoyDFneiCfRjL8DlZhJP6cdM30NN6I
P52hwpR3WlfhWnyj3IrGq6jt5HrJvbahLySqFpHw783lXJb60YIIlwlA6q3ACitq9xYWXXo4
rSM5vR2eUOhjBoPiE3O4AwwvTjUhdxlbyXBnFkS6MmuDJTVJCDfBNZV4OCDpVKhTSVylPmHU
L3vZDx64+TFGQc7iJJ+btdQSwBczP7Ih2NJPU7Oj94LM4T8LPU6Fa/l4Fq+op+FIDl3mBoGl
eKmpoMnQeRlf+7mYdYfE3ZXEFUH3SDpw6SKOUk4E3UOIHwpbN/pUYNiC6FP+lQqy2fJR0r5R
oQuLmRLOOOF/RNLnxNIgiUGc8tjCm8s40CKUNchrvnYDj/AZj+Vno0mfHnr4LvucfNjRo7Fi
0j0xSd+4AcwMS9P9jYipAAmI2HI3pvzh47ftUhkRjwRwdMJGU4m3WUj76s4IF1dIzTY8WlpY
7cGP0Ks5FdITIQGjHZ9KOhH1raBF8ZrmVhwUqyQOXRg1OrplAQkwKLyFvpvD+k7XIR+ZLWwl
yND18dzsoE4i4ggWN8vEw+iR3M6+UUazT5SlnAg0BdQ4tU27xI3QwSNMXnqYEj8KMUiiBZC5
wY7wmi0BGOiMWWoAeYfDxIlL0BKzE5l9niQpD126GakPlVgmUhoz5tKfCUuTrSttAWsl3Q/t
+W0ro4yLiJGQaUTmu7R4Bqof4Js/IsyTxKyiJLBI8NQmwjDyqyssq6sI3TT7Gu+sVcDyS8sD
kMHCt4iTbAmyiu6CbIkxzoq4QPRSgFvMPBGEHzlEOPNvfkq3cuPaVucN5+Rb2mKlgLlGUrFi
a/9923mw+bTMEAESPU7zJREWSm4ig4SuACNhOLrBRXVZbdha167GjScBfA9kOA0k3DzIJbwV
10bxWa5WU/vcb9ZdFyfDxaGEpMN8FeR8EceeHqxbDcSlll/H1lVbonxAvGQ8D3iWwUHMj2A/
qkSNVR6VNRMxQlHTxRimwtqak7IfAasAw00R/FKUG0VUmAykuylb5ktX5EvmNVqkN8WNIlgi
mI8RwKuX5K3TYNOwFIer9RxTPl/z5y6siLCspIKLTK9qDjXwiGdSnFPyTJbTeERIwuIMffbG
3oplASeCIVU4jwv0RywD2qaRG5ATqRweIcdHOmgWM+KtoOw+fD28AiEfwfEBdv+7P51mWdoj
+tu0Or9f74Qtk+M8Gm+7XRxFsrVb5EsbwL8HiLcrp9ddJlYQumnvjbZWzBy6GkqyYjDsAroE
tTboXotFMOnZi0gnqJqcjq0goBVP5UJtd1EPU+nrmb3s3432VpIHiGDv8hk8Bk0lli2kbzw6
b9b0jSWrjWAN+s+O7IIshv2t33k+vKGOsXM+dQQTvPPXx7UzCx5kOFfhdV73v6pL+f3L+7nz
16FzOhyeD8//1cFQU2pJy8PLm9Rwv+JL7OPp+7k5vUucPq3LZMtzaRWFeg5qM9Uozc3cuUvP
0Qo3h/0LtW6rOC681usJAwz+JjaSKkp4Xto1G1XrMMIAXIV9XYWJWBKhnVSgG7grz7xRU2Fx
5NNnEhX44Kbh/eJKrUkOA8Luj4cfQSfORg5hISwXN7e9wuBc46/7H8fTD5MJoBQcHrO9nZbH
OQtn8YR2jyglrRcJ08PwZiVSanhE5Gm5dm2aroybJEefPJiWL2PRdj6x2D//OFz/8D72L79f
UMf7en4+dC6H//44Xg7FIlxAqs0KXj/A7D7IcHPPeu/JimBhLuIWmxzT1CgPHdelWvDxG9U6
zSUkSzFAYciF8PF0RDjzl52+xOcsPs2EMjjIqP20DT9ffnTrPkcyo/SR0hJUdRxvMkq1AivV
z/dghRHlPZTLU4b7j7u49KHfIxyLKbC2Ptjwmcv+oEd0wWYJB9qlb5N0ZUxwvuCoN/cD3zov
qjoTWP3Nx3gVVQqU0Gw+rCD9MPEtS0oZwj3zMIwo7bigxK25IOIaKSCeuI93MXdL8b3Fp/qr
wuWEkkj9yknPIR4ANFFUjC+VtUHuE9cJja4grmwUyMrswFiBPPg7kbgRBmL6JPQuLBB3e+sh
nnGYm+zuCIQsy1ef6NgQNVB3QbEYjwm7ew1GuShQYdvVZ3goctfh/U5LAod6maig4oyPqJc7
CuyRucQ1mQqCVYSMz6sK0IQlk61ll1TCXP2+3CSL/TR1NzwFcUVc86joXTiLzXduCur+zGS7
mZ9+1Rx/GXs3IXWgKiqMeOTfHXYsjN0vbYt6ozy8W9yGi+UstriHqTpNrCiPj+rYZ3cn1Crx
xpN5d0w8NFI/4a64NUccxi1CU3FBnN/8kBMeZ0oq4TVUnv28VWadC2thWcECfxFn5C2MRFhO
r9U6ynZjRsQSKWAyEhS9xfLomxh5qMf1lbzYlJ2AV98ebNUC16wIl4A8nHMZJbYIa0V/Mv3F
sLGMmL/ms5SMUSi/KN64acotCDJ4dqEvQSMZqReY8222shwauEBLkzm9UO4gN80e/jfZwVua
+5arGf52hr0tffZaCs7wj/7QIuIr0IDyMSL7nkcPOYyifFFj6SIYwlhoV9L1pEt+/no/Pu1f
OsH+l8niSupFlo1ojlGcFLos5nOz6yOkSneJa5taFI8LWsTOkopRqsbdul5F80w0V23twoWN
WkufWaTeORCpIPRJaFF7NqEmZ58KCrsBDRY2fzoGanUaj1ZhPlvN5+jLzFFG6HA5vv08XOCj
bypIXSzOkaMssr5S9q2IEBmyOamVXCnpaPXZ1nUItyTyOL62Fo/kvkWJGCWYXTruosvABtLz
cwb5bU2AldxxCIffynhZghfLRkidqb2rC0uxlrZTZXTjqGsTW/45NytoSn3D2+WAzjfOGKHt
6Xz6fvzxcdm3nApiaeR9mxR+hLWY7JY8sihVi06zqBWq+PIWSIi2gZXmk26GxdtqAbin4GUe
+vsNk1hQ1h5FOS4L89AiGwpbAwt9abl7W+TebGG2gynIG3/GiEtoOU/dTdnpJHPd541bkdku
afp7VatCO0ex4ZnqYy4M2e2fZJMK/xH2ZYbE8kmrmjGfobmrIanyUTm5NUw631u5xKELc+qr
ouLYr/Dt94l7HSyHXjSQKrwlI2KTIJWKW4Llbgz9ioQiSmMj1hGkrlekiEfySiyJ6BuS6C35
CMaLzs8ebd+xFGZVC9LCzHycCv1QwMHH5GQZLzDx5u421PIeT1oBq999S81pCyIFJCceiwNi
OymRsxT3gRHuxpcb3B1FC79tVIsmVYYziCzBjfpdZzg1K0kKBEaYNu/vijawcNQnIsTcAMTp
vvjetNvFByXm/aGE+EFv6HT7lGt5iZGBhu7RzUtiRR8RXu5q+pRwtCIBRah7x8AjkozbyBZD
yGBelg9HOuF2v6QPqbiXFX243Zb2ADbYZEL4MLh9GhH6qwaMCBWgBHgu6zkD0SVc+hSFEAEU
JLF2cW/hNM+ZEF7ziq/M+kPCo1px985cdNhvAQRsOO1Z+xuYbPgPTeei35sH/R4R8UrFOM16
tKksb0z/ejme/v7S+00uheli1imtJz9Oz4Aw2Nd0vtwMn35rCYMZnsMsQ1AErqPpYbBNCbWD
pGO4IUvpaHuyI3YrRffL2HUGZlYceaDbwex8efqpib26+7LL8cePxsFQtbvQxXhljiHjPhO0
GATwMs4Iaph5BGXpw5I/810qZ/2k5PZAqEFnyYrI6cI2dM2zHUEuJZGJVNnSSOMh2WfHtyve
7L13rkXH3fgrOly/H1+u6GtEbrk6X7B/r/sL7Mh+M3evVKUI7kfUNxee7YkPTtyIMyIjnHjQ
FbyZmMjnIhHVW+j9tyWZ6xZnhHKJMR8jN8MRikBw+BnxmRuZnpqkGcsDPlPifEFCtWlQkpYs
i2HeGRNLw6k//3W5PnX/pQKAmMVL1sxVJmq56uYipLU/VGjRGnZBFVdAQudYPXlT5hIC4WQy
L6KpN+uX6UkaM0NyMXaNtlTp+Yr7sO1eEcEnsNXp2rxDRmM7bKlh91Plc2ez4TefsN+8gfz4
GxFSqYZsJ5SH9hLiiV6fWF1UCOFgUIGMqFBeJWS5CydDQjVbYTDC+pSK1FNiUjFk/Tt1cRH0
HMLhdBNDRO3QQER0qxK0BQgR9ahEJGw+GVKheVQMFQe7Aep/BvQZDOGkuR6NQS+jolCVkNlj
3yG88JcIAfvbaZcIq1Ri5mG/R2yS61EHRqYC690gwwnhlF8phYjMXEH8EM4e9vmQrgFiZy6E
UMGTashkQqio677zYGpOWgIEz7x3BAgOHRUsToXcndV9KvybCrH3KEIIp8INyH0hRAU7U6UH
FYmu6vXpmArcUPPI4C4boQga2DmgEGX2zoNJ6PTuiIWQJeOmK051NXIYHJbxYQWvn4YCc+B2
8xOrjCf61G1/s4WfmA5TdofbtyPNzblsUfKyv8KZ4fVeU1kYm/WBCns4VDzGG4RyTK1CCLd6
6ko3GeZzN+TEI00FOSaO7jeIMyBuoGoZkD30xpl7h9kGk+zO1yOE8NCrQqgYjRVEhCPnzkfN
HgfUgbfmhmTI7kxDZCr7dP+2ix7DpMVS59PvcAa5y1Cu50fEq/l6WcrgL23V0SBtTWL9iWPt
7q1+Si4KF5Z3GriIA2/Omxq5EuKFriHM3S2VsAEAgOKj4JYr96MFj9R3+JBWx+xdulHkB6JJ
jedqzWjEnLrAGwuvaUKr5MCOmjQ6ytvk7pYj0axWnQu0CSNscnm4QBvYnKTLoMocyEQQnuKS
qeSh3EuogmQE5yUWlIcLwnTkhjGS4UPJjxRw9tDy1WPFXo6H07XBHK7YRSzPtuR3Q7rxzAHp
s9XcFO9Kloh3sVR5kA+VAvpzqirwVLNgpamrrc0KYkWFtpmTMW9SYxQfhczjPPSjVTPUWZEc
UqV6iYlj12iF3C5MplL2SAUVn9GK8kkUmrS4rG0XEB6fLuf38/drZ/nr7XD5fd358XF4vzZe
d9Ve7O3QW/WL1N9R1gDAnz7xKl1kLkx+0+k65IlQ4ji1BY5FQi3dtZ+zQLlpqlLgqO0nbqpI
m0JxVqJv2o7woTuYELuTWxbcZk0HhPpWgQk+7A/MC46GIryaN1HErUATRGjQmyDCw7kCYh7z
x0RMFA02Jc42Kkw6HsqZ+QJUAaJsht8L36xaVZCUglyBrNndhpUBBKmJqiBnMM8MmlZ++nE4
HZ864sze23Y2wON+xFnOFivDO0SVWizpxKrShDlDIrCqhiMuMXTY2LTT0EHNRVSlbskgx03U
pG+rJ2Orei5Wr0NNPWtmBS4wIBoxhuWau2ZmQ+nlBs4ukdEfE3s5P/0N9X9cng7tsZVq8GJP
0khJ0njWeLcBTRQpM7dS74ZStd7qQ7ET2gsVDRA3H3vKpzj4tAOqzUYDs0Mo4/cpZbg8mMVE
FFzo/ZXprU6hET28nq8HDB1m3GvKkMio/DS2ypC5KPTt9f2HsbwE9oDlmmsusZFTWYXQ7xLa
Krd1HdC2L+LX+/Xw2olPHfbz+PZb5x3vkL4DR3rNmxT39eX8o2DURvMq910GcuF163LePz+d
X6mMRnrxBHGb/DG/HA7vT/uXQ+fxfOGPVCH3oMW9xn+EW6qAFk0SffnEqRMcr4eCOvs4vuBF
SN1Jplt2nvlb6HWmRFM1DtjnS5fFP37sX6CfyI400lU2YJqNucy8Pb4cT/9QZZqo9WP+T3HP
rQGJ3OjMU//RMMH9bcZuN1D+P9en86l6E2uwbCngcIxxYYNilsslRH+6rtPR4o0KnlNCkiwi
o7eVkDSbTMd987GhhIhwOCRO7iWisjy9g4FhRINJx7TQhCB0UuUSsFjUYFsdNoIUc6N4hr2G
aucU1jc6tyHchBaDIqS6WQhnw4x4v4kIPHrOM/OuBula4HOFUuoDXpt4aYfQ3KQWW5b0UUZE
aPuUAAquGc1TNuyRTJZigC02642r12o5Amo7ERf5gnBb5PW2KEOR4BNG6nCRSjeKZjlS6PiW
u474+OtdTkN1hpSvCtEO2dzVy91trUa2IlEMDlvyEhdNpokmVMYGaKJQC/S3Uv/YmLkzFuYP
cSTDIzvt1pUd9oky9UZKlVOexWnqR+ZDpIrzbP1SgYQbEM5mEIWMzMPtJHy0dl8Ie+9ARlOz
V1qxj62sZOvmziQKpY39fRR2Md0uN0mWceTnoReORsTmFoEx84M4QwNVj7ApR1Tp28hQpzKk
N05VMuOzFOaaz0whIUhSw8tu9/R8OR8b75HdyEtj3Vy12rCUcEUf03QMVaZWl+Dqv/pddylm
/flKNPbEBTiFH21l5aZzveyf8Bm6wfGMIARkoXrT7ZkrfzLtIm8558nCvDzNiUeOghObYhHw
kJJX0kQZ/o584kUkQzdhhE1QGOsPQSo9WHMfUNj+HGHrVDBTM2COG3DPzXz4rjxxU83+qP5m
3Nq7jSUAFlgnJ+y4gdY3P5QAyiBXWUEmABvk8ziVZWp1DGTDYsG3ucvMBg4VSvhslVKmJhJE
GW98nXmNevF/Egw1hTMG60CDdVOfQ98BjeiSrzRpS5MWc0F2cswsxFlmaUvEA0vWudPKWfch
nuuaW5wqrTTdjhNTRlTpSufGILTVzHPUTrJ0R7+/BASsodqg1rQozvi88V7JK5KMR2JJkSZ2
jTa47Sw3bfoqzsxi4P8qO5blxnHcfb8i1ac9pGfivDrZqhxkibbV1it62EkuLrejTrs6sVN+
7Ezm6xcgRVmUADpbNdPdJiCKAkEABAEQ6wsNskuaUAo4Myk1kFzOzCV8ZOA8zoj8Dne++NUq
5JxJ7qM37wpboXtf0zj805t4cvUTi9/P4lvQZdyoCm/QAen30H0r/36c/Tlw8j/FA/4JxoX5
9prueYtAYQZP0gSd1NiNp3Uknht7IsH6N5cX3yi4H2NiIxiGd1+W2/XNzdXt194XCrHIBzcm
b6vX0osotywwgLUF4EE628ijLMRtuX9en/ykyIYOEoMSsmGMFVRabRiLmhu1NmQzUgqLX/lc
oLDEAis38FJBlbIYizRqDqCl2/MwMadVNhwR4QrnwclzSv2APTCoigkbvnr867DMtN3UJd7h
FCFTx0sY5ydCY5RxiqkB/JQ6ngU24GEjKwhLD7Ii3DKaPg+yPPV90BX7eqn3/Y7A0m14jTam
93oyX4qaoBozeGqEzdatT0YY56E5y73u+xz0dlI+xPbjkluIbrUZQH9KkY9gv+O7fNlTN3VC
hoDZfeFkIwY4sejx0I+A+znhH1p4JOFh99HDpRV6zUNT20sTTL+jz2Bh5UxYdWFhyjTmjIpI
5NM4HbfWpQZqpmz8npy3fl8YWwjZwgoaCabPwhCUTc2NVU0t2NBF7YHo0oWFlzRqTDb7o8Ka
h6kDW2Us+BQ3w97BOGr/hIGaL6zPivRkFFGaGI4q1WLxObkiGXGT5Poc24eyosOE2YeA/nV4
0chNezOMA35oJUzpaARrJT8DJW8+WEO+8ZBvVwzk5uqMhZyzEL43bgQ31+x7rnsshB3B9QUL
uWQh7Kivr1nILQO5veCeuWUpenvBfc/tJfeem2+t7wGTFbljdsM80Dtn3w+gFqmdzPV9uv8e
3XxON1/QzczYr+jma7r5G918y4ybGUqPGUuvNZhx7N/MUqLNiD7B1tBxUY0w5Uc0hiswSfMI
SpSLgklIr5HSGFT2sZc9pn4QHHnd0BFHUVLB1CvUGL6LhVfoxO4aJyp82qtjkO/YR+VFOqYj
WxCjvWfxAiZbPPLdVi3VCuLHs6nhfTdcRergs1zsN8vdBxWzhcXBaK1R2WEzLxSZdM3nqc+4
uayuGw0k9YiM5YHtnSciMFBxc+/GyePMCUCFYi5kkzYdNNrlAHocHQVZXKRMUKasmu/KbrBA
7UgECek30xvLAymcZnZWFt59eZ2vnvHA/RT/eF7/tTr9mL/N4df8+X25Ot3Of5bQ4fL5FHOJ
XnASTn+8//yi5mVcblbl68mv+ea5XKEf8zA/KrirfFtvPk6Wq+VuOX9d/iMT/ptxKD5WJMED
lSiODHeWBMWRomMj543xYipkLPnK4GpTwZW1r7H8xAxvlkES4i0CQ2PjQYDJnTTzeRrMU6c+
km3zdT1O9EnF+njV3Xy879YnC6y+u95U14cfyKiQgVRDJ2loE6P5vNMOdBiRjV1UrH+fGA7K
CgDSAxQbY5UplHZGKdlBbcpivGZGvCgqAtqeruDyL1oa6m+QGy9a7FYoZLBosv/xulx8/V1+
nCzkNLzgjVkfTQlUPZ5mtKeuAnt0PYEKKtyjcHv3wk2PYGQhE0BYkbAAA/v86qp326GBs9/9
Kle75WK+K59PxEoSAvj15K8l3su53a4XSwny5rs5QRmXKdlSgYd2sDty4L/zsyQOHtn8Gj3L
Yuhj8oOVDuKeKSVVk3LkgEiZdOjQl5FJWG53S31l38pdbvv+uxY4ty4jN2f2THrI1s6DlC5E
VoFj+9CSI1/2YB8bKOhpypwX6mnDCOG8sLIBpvJ2p2SEGeXsjHCR5lraHYE/HPnwSev5f1X3
kZbbXUc6u6l7ce4Sok0CrKN4GHHFSCqMfuCMxbl1DhWKdZ5gIHnvzPPpuzP0Wj02ls+sUo0j
IzVsiKHHhA1rsPU1oQ8LWZ7lW2cxDb0eE5SqJcbIYQKha/j5FROUXGNc9ayzDBh0rlUtve3g
HGyffsw4XRTONGmNQS0ZWfqLWj4OEz5wAHNFUGumi6ftoPgO1zmhgC2TVXO5TpZbZxoRrPTn
IiEq8ED+/RkldBznKFODQZRwIS/1ZFv5Pp/GbbL+q7ro9n1TbreGkV1TYBCYxxeVaniKCaF0
w6S11Q9ZxwfgERWcVYErv7sKn4Xtx/rtJNq//Sg3J8NyVW70JqHDb1Hmz9wkZS7k0t+Z9ocy
WcWG9N3HahMCo7SYTVjDep2B+Tw7JvZqxGzsykr6n0I+8i01niMcypXbMNqxlEV7v/C6/LHB
i4I36/1uuSI1ZOD3P6MaEE1x91Es0ors4tUqIM38J9G8G4dA+tzQaAuxRaopwexYwULFQQrX
qikOiCjxzy7t9j4g++EwF+5R5pE3sjgD8eAK6y4H8VwXBP3RQYby+svZ8CHoColys8OIXzDY
Vazedvmymu/2sLdc/CoXv2Gj2owo/gy6qtzT5TbtZ/Aj4aQzecBphqc6MiKDmK6+D/oMs9sa
Aqu+uQp0XeQmj7Ddj0MdTkHhBCJqgXWQZSTwsN0PzK1mnHqMpYC3EMqaqX064U5d9ikvlqha
ovgQ0en6Mz+W1fxVCFNrMApOgjpBT2CjAQeA9CJZ3O1dt5GtFh28IC9mTF8XrQ0/NIDqCgbt
XbKJEPiu6D/eEI8qCKc3JIqTTh2mupTC6DP+TIAyqa0AYQFMGTG/r2x17rEb4uuVjW7EYzmR
F4d2muG5NApuUzHL1o66Bj2tjr9Fs/4Qtnqi244qlkCXzQZ+Pd6HJwQQg9S82PRoViBcaMCi
zXBL1dRldmz3QqexQITwZDI0oEl/JrXSET5N/RwvQA/7nbxsGHDgpAgcSW1OyQHM6EVcDO+r
yiodwTIix42hYLom8TIERXGkAbPQ+HKEuvLLDz5y7EukIE8kqLuFLH/O9687LNq1W77ssUL9
m3I1zjflHCTwP+V/GgYe9IJKdBZibbbs7uK8A8lwF6SgzYXZBMN48ByEK3prdsXcEWIikdG5
iOIE/jAKkYQ3Jk3Q1OGPjjWz9EXkws49pUp9ZsNAMWqD/vdNsRyYQRs1c+cx7BLl2eXBq5ze
owVC3YgEK3Tg5U3unoi6r4mXxd03DEWOgSXxwHMa+R4ZxlPHjQFmIOK0zK80cEextrtGeQHS
J/D8i+57K2DKAgMb0A0Tr+k7bsKKGmieBWgTQra+b5ar3W9ZhOX5rdy+dO+HlHWSxzLH0IwV
k83ohWeMaXlwkMtohn7hB97MJ21kdakTXj0dgEUR1Of831iM+8IX+d2lhocgKfH4ttPD5WEs
fQzQqIYsb3ukObi6vtLC402MzrVk+sPl/SSAJdIU0EWTWVh61xvE5Wv5dbd8q8y3rURdqPYN
db6mhoLbC2IogxTeP5s6aXTXOzuvSYYnbQmwHQbem2FuKexkpKcfgCQFRoAARha8EOaXXHxq
QJmQhbwxpi50jJrQbYgc3iyOAjNQVxXTj0Hq1VXBlWSadRJTq0cmIViyxQMKIXryGl1OhTNG
mYrahDw7+vRUyLmQG+PlQi8yr/yxf5FX4vmr7W6zf6tqY2iOxVvUMVSqme7UaKzPyESEc3F3
9nePwqovS2Nh6EsvMPXm7ssXc3qasUq6RUrmKf5JTIQKZ5II/NXkrZ6i1r00TWksFfd46Bn3
2uJv4oFayRf9zInADo38HNVYa6QSyr1v7OKjaFn5QRXgXc30p+bOpBWGuIqgTUEMH9XStjp6
rDtrrlgZbIL32UYZF2OoOkREqS3pTY+8MnIaMeJXgpPYz+LIZ9wY6i1x/7vgji+qtRw41LRI
ulYEASMzgCXVZRwNsXUvT5iLjLNtMneE1xFKLLyuF34ydzap/iahjYcqHFUyqDveCmDpXuWE
ykNtC9YYTSG0yG1djfzhqJXM1KWt/HBMABjAmuoO2ABTClYdqY8d5P/KPmh4GRUUIyyBS2DF
HhaX59V7EPM8/cDUnbGMMDOzay4D/km8ft+engTrxe/9uxKlo/nqpWloOLIiAaiCOGnGrzeb
MR2pEHc9EygNtyIHFddgmniQY5RkkcDYcmBwJppdAWcjzLXLnYzmq+k9KClQVR7jwJdXDqm3
kcrETgEVQgM65nkvLx6gZIZaA7xhIuG4TaMjIaje25OHVBwLkbSkhXIe4cHqQTL+e/u+XOFh
K3zP235X/l3CP8rd4o8//miWLcaEH9k3Vu2hQmCTFBhXJ/7Qu33sA7/LsopwL1vk4oE5Q6hY
kyjX0V7YRzuZThUSSMR4mjjMPSjVqKaZYO4FUQjy03jxrpDUxgfeBxNzpC+ksfRwVw4N+t3y
rbAY8HYs/qqow4cS3pEG0w0sXent0f/BOh2rNr0fBM6QcukddhdNhpKmpAwMijIhPAwOkn4e
m6BW+o+RWr+VUfA838G+HqyBBXpWCfubvce+0uRH4JlNQcv8M7/l2TxsbVCFR/LabdyQpAWR
LGeIIeaT2m91U6BflIMV2c05S92CFlMAAK5wAgtrIcpR/kOkVAw+1RfyAAsV90SFwUOJF+M7
Oqv9vtospMQ2QS8nB8w49zGPqbQAqcTrzYscaNpyStTQYeokIxpHbzoHmt2NDtQOO5SJwEAz
9JK3UDDRC9eExASLMMqzFoZbPah6OQDxCUZ0D3i6Zw7e5dPlmrclqD2SbSpZ53vSwZc9PvVj
0ocdenhWgbv5hvFdtd59Keeb1w+scwL/b9ev5d1u95Fdnvbw4pOzk8Xr79nyZbXelLP9ar8t
nxuF23XHaEalvseUF5SDfEJXAv3ZlYbh2VXlZaqOmOS/Fo2anpu83O5QgqLh4K7/W27mL6UR
aFtwFqkWIOiQAPr60Xe1BSeRq5xICqdtSo/deNIxJcGAhGbFbDMz+wTxqdMZ4Dk8v0G6Ibe1
SxkGY49J35d2V+hHsuYjj+H5E+b4oV+7qFDRWQRNH+M3LHAhL0wPYiwuxmLJbP4J3k1r7Qxd
vUnBw7Uz1K6c5ZePxINXhDRp0AmEa/toJxWiimKmlZDGy1zmvF4ijAEjZ6ogSATpoaNPw9Qb
XCeygJVvlocXBXPVmoQ+OGnKOAYlnNpjmRgpHjLl7HXxaka4s2YJ9ZnLttUGg7lZRn97zMS1
SPgk5E1NRRwMZmCD3tU7EhvxA1hLI3TUeoIO3xz4sHmHcdInBGZvAz8NwZizEFKlL1u+h/fz
VtwqY/TZ9ATFsWFs4RjYursOcK31JWiYM3JZd2JHkFHz6M0hKwmgLMbCAdANYjflZtVE6hmb
TlEm3n67axwWHEwmo70TSq/a/wchsP0jKXEBAA==

--Dxnq1zWXvFF0Q93v--
