Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799F843D607
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhJ0Vwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:52:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:8269 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhJ0Vwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:52:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="293733533"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="gz'50?scan'50,208,50";a="293733533"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 14:50:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="gz'50?scan'50,208,50";a="665162281"
Received: from lkp-server01.sh.intel.com (HELO 3b851179dbd8) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Oct 2021 14:50:01 -0700
Received: from kbuild by 3b851179dbd8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mfqo4-00013h-VI; Wed, 27 Oct 2021 21:50:00 +0000
Date:   Thu, 28 Oct 2021 05:49:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [brauner:fs.binfmt 2/2] fs/binfmt_misc.c:86:49: error: 'struct
 user_namespace' has no member named 'binfmt_misc'
Message-ID: <202110280539.KthGlECA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git fs.binfmt
head:   d484ec2850c2cd85d06837319ef57d6cec24305a
commit: d484ec2850c2cd85d06837319ef57d6cec24305a [2/2] binfmt_misc: allow sandboxed mounts
config: sparc-defconfig (attached as .config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?id=d484ec2850c2cd85d06837319ef57d6cec24305a
        git remote add brauner https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
        git fetch --no-tags brauner fs.binfmt
        git checkout d484ec2850c2cd85d06837319ef57d6cec24305a
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   fs/binfmt_misc.c: In function 'binfmt_misc':
>> fs/binfmt_misc.c:86:49: error: 'struct user_namespace' has no member named 'binfmt_misc'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                                                 ^~
   include/linux/compiler_types.h:279:27: note: in definition of macro '__unqual_scalar_typeof'
     279 |                 _Generic((x),                                           \
         |                           ^
   fs/binfmt_misc.c:86:24: note: in expansion of macro 'smp_load_acquire'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                        ^~~~~~~~~~~~~~~~
>> fs/binfmt_misc.c:86:49: error: 'struct user_namespace' has no member named 'binfmt_misc'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                                                 ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:171:44: note: in expansion of macro 'READ_ONCE'
     171 |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
         |                                            ^~~~~~~~~
   fs/binfmt_misc.c:86:24: note: in expansion of macro 'smp_load_acquire'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                        ^~~~~~~~~~~~~~~~
>> fs/binfmt_misc.c:86:49: error: 'struct user_namespace' has no member named 'binfmt_misc'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                                                 ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:171:44: note: in expansion of macro 'READ_ONCE'
     171 |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
         |                                            ^~~~~~~~~
   fs/binfmt_misc.c:86:24: note: in expansion of macro 'smp_load_acquire'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                        ^~~~~~~~~~~~~~~~
>> fs/binfmt_misc.c:86:49: error: 'struct user_namespace' has no member named 'binfmt_misc'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                                                 ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:171:44: note: in expansion of macro 'READ_ONCE'
     171 |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
         |                                            ^~~~~~~~~
   fs/binfmt_misc.c:86:24: note: in expansion of macro 'smp_load_acquire'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                        ^~~~~~~~~~~~~~~~
>> fs/binfmt_misc.c:86:49: error: 'struct user_namespace' has no member named 'binfmt_misc'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                                                 ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:171:44: note: in expansion of macro 'READ_ONCE'
     171 |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
         |                                            ^~~~~~~~~
   fs/binfmt_misc.c:86:24: note: in expansion of macro 'smp_load_acquire'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                        ^~~~~~~~~~~~~~~~
>> fs/binfmt_misc.c:86:49: error: 'struct user_namespace' has no member named 'binfmt_misc'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                                                 ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:171:44: note: in expansion of macro 'READ_ONCE'
     171 |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
         |                                            ^~~~~~~~~
   fs/binfmt_misc.c:86:24: note: in expansion of macro 'smp_load_acquire'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                        ^~~~~~~~~~~~~~~~
>> fs/binfmt_misc.c:86:49: error: 'struct user_namespace' has no member named 'binfmt_misc'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                                                 ^~
   include/linux/compiler_types.h:279:27: note: in definition of macro '__unqual_scalar_typeof'
     279 |                 _Generic((x),                                           \
         |                           ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   include/asm-generic/barrier.h:171:44: note: in expansion of macro 'READ_ONCE'
     171 |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
         |                                            ^~~~~~~~~
   fs/binfmt_misc.c:86:24: note: in expansion of macro 'smp_load_acquire'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                        ^~~~~~~~~~~~~~~~
   In file included from ./arch/sparc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:266,
                    from include/linux/kernel.h:11,
                    from fs/binfmt_misc.c:13:
>> fs/binfmt_misc.c:86:49: error: 'struct user_namespace' has no member named 'binfmt_misc'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                                                 ^~
   include/asm-generic/rwonce.h:44:73: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   include/asm-generic/barrier.h:171:44: note: in expansion of macro 'READ_ONCE'
     171 |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
         |                                            ^~~~~~~~~
   fs/binfmt_misc.c:86:24: note: in expansion of macro 'smp_load_acquire'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                        ^~~~~~~~~~~~~~~~
   In file included from <command-line>:
>> fs/binfmt_misc.c:86:49: error: 'struct user_namespace' has no member named 'binfmt_misc'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                                                 ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:9: note: in expansion of macro 'compiletime_assert'
     325 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:28: note: in expansion of macro '__native_word'
     325 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/barrier.h:172:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     172 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:86:24: note: in expansion of macro 'smp_load_acquire'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                        ^~~~~~~~~~~~~~~~
>> fs/binfmt_misc.c:86:49: error: 'struct user_namespace' has no member named 'binfmt_misc'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                                                 ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:9: note: in expansion of macro 'compiletime_assert'
     325 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:28: note: in expansion of macro '__native_word'
     325 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/barrier.h:172:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     172 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:86:24: note: in expansion of macro 'smp_load_acquire'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                        ^~~~~~~~~~~~~~~~
>> fs/binfmt_misc.c:86:49: error: 'struct user_namespace' has no member named 'binfmt_misc'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                                                 ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:9: note: in expansion of macro 'compiletime_assert'
     325 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:28: note: in expansion of macro '__native_word'
     325 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/barrier.h:172:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     172 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:86:24: note: in expansion of macro 'smp_load_acquire'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                        ^~~~~~~~~~~~~~~~
>> fs/binfmt_misc.c:86:49: error: 'struct user_namespace' has no member named 'binfmt_misc'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                                                 ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:9: note: in expansion of macro 'compiletime_assert'
     325 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:28: note: in expansion of macro '__native_word'
     325 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/barrier.h:172:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     172 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:86:24: note: in expansion of macro 'smp_load_acquire'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                        ^~~~~~~~~~~~~~~~
   In file included from arch/sparc/include/asm/barrier_32.h:5,
                    from arch/sparc/include/asm/barrier.h:7,
                    from arch/sparc/include/asm/atomic_32.h:18,
                    from arch/sparc/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_32.h:102,
                    from arch/sparc/include/asm/bitops.h:7,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:12,
                    from fs/binfmt_misc.c:13:
>> fs/binfmt_misc.c:86:49: error: 'struct user_namespace' has no member named 'binfmt_misc'
      86 |                 misc = smp_load_acquire(&user_ns->binfmt_misc);
         |                                                 ^~
   include/asm-generic/barrier.h:174:18: note: in definition of macro 'smp_load_acquire'
     174 |         (typeof(*p))___p1;                                              \
         |                  ^
   In file included from include/linux/module.h:12,
                    from fs/binfmt_misc.c:14:
   fs/binfmt_misc.c: In function 'check_file':
>> fs/binfmt_misc.c:112:31: error: invalid use of undefined type 'struct binfmt_misc'
     112 |         list_for_each(l, &misc->entries) {
         |                               ^~
   include/linux/list.h:571:21: note: in definition of macro 'list_for_each'
     571 |         for (pos = (head)->next; pos != (head); pos = pos->next)
         |                     ^~~~
>> fs/binfmt_misc.c:112:31: error: invalid use of undefined type 'struct binfmt_misc'
     112 |         list_for_each(l, &misc->entries) {
         |                               ^~
   include/linux/list.h:571:42: note: in definition of macro 'list_for_each'
     571 |         for (pos = (head)->next; pos != (head); pos = pos->next)
         |                                          ^~~~
   fs/binfmt_misc.c: In function 'load_misc_binary':
   fs/binfmt_misc.c:170:18: error: invalid use of undefined type 'struct binfmt_misc'
     170 |         if (!misc->enabled)
         |                  ^~
   In file included from include/linux/spinlock.h:326,
                    from include/linux/mm_types.h:9,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from fs/binfmt_misc.c:14:
   fs/binfmt_misc.c:174:24: error: invalid use of undefined type 'struct binfmt_misc'
     174 |         read_lock(&misc->entries_lock);
         |                        ^~
   include/linux/spinlock_api_up.h:28:32: note: in definition of macro '___LOCK'
      28 |   do { __acquire(lock); (void)(lock); } while (0)
         |                                ^~~~
   include/linux/spinlock_api_up.h:60:49: note: in expansion of macro '__LOCK'
      60 | #define _raw_read_lock(lock)                    __LOCK(lock)
         |                                                 ^~~~~~
   include/linux/rwlock.h:71:33: note: in expansion of macro '_raw_read_lock'
      71 | #define read_lock(lock)         _raw_read_lock(lock)
         |                                 ^~~~~~~~~~~~~~
   fs/binfmt_misc.c:174:9: note: in expansion of macro 'read_lock'
     174 |         read_lock(&misc->entries_lock);
         |         ^~~~~~~~~
   fs/binfmt_misc.c:179:26: error: invalid use of undefined type 'struct binfmt_misc'
     179 |         read_unlock(&misc->entries_lock);
         |                          ^~
   include/linux/spinlock_api_up.h:43:32: note: in definition of macro '___UNLOCK'
      43 |   do { __release(lock); (void)(lock); } while (0)
         |                                ^~~~
   include/linux/spinlock_api_up.h:76:49: note: in expansion of macro '__UNLOCK'
      76 | #define _raw_read_unlock(lock)                  __UNLOCK(lock)
         |                                                 ^~~~~~~~
   include/linux/rwlock.h:105:41: note: in expansion of macro '_raw_read_unlock'
     105 | #define read_unlock(lock)               _raw_read_unlock(lock)
         |                                         ^~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:179:9: note: in expansion of macro 'read_unlock'
     179 |         read_unlock(&misc->entries_lock);
         |         ^~~~~~~~~~~
   fs/binfmt_misc.c: In function 'bm_evict_inode':
   fs/binfmt_misc.c:610:33: error: invalid use of undefined type 'struct binfmt_misc'
     610 |                 write_lock(&misc->entries_lock);
         |                                 ^~
   include/linux/spinlock_api_up.h:28:32: note: in definition of macro '___LOCK'
      28 |   do { __acquire(lock); (void)(lock); } while (0)
         |                                ^~~~
   include/linux/spinlock_api_up.h:61:49: note: in expansion of macro '__LOCK'
      61 | #define _raw_write_lock(lock)                   __LOCK(lock)
         |                                                 ^~~~~~
   include/linux/rwlock.h:70:33: note: in expansion of macro '_raw_write_lock'
      70 | #define write_lock(lock)        _raw_write_lock(lock)
         |                                 ^~~~~~~~~~~~~~~
   fs/binfmt_misc.c:610:17: note: in expansion of macro 'write_lock'
     610 |                 write_lock(&misc->entries_lock);
         |                 ^~~~~~~~~~
   fs/binfmt_misc.c:612:35: error: invalid use of undefined type 'struct binfmt_misc'
     612 |                 write_unlock(&misc->entries_lock);
         |                                   ^~
   include/linux/spinlock_api_up.h:43:32: note: in definition of macro '___UNLOCK'
      43 |   do { __release(lock); (void)(lock); } while (0)
         |                                ^~~~
   include/linux/spinlock_api_up.h:77:49: note: in expansion of macro '__UNLOCK'
      77 | #define _raw_write_unlock(lock)                 __UNLOCK(lock)
         |                                                 ^~~~~~~~
   include/linux/rwlock.h:106:41: note: in expansion of macro '_raw_write_unlock'
     106 | #define write_unlock(lock)              _raw_write_unlock(lock)
         |                                         ^~~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:612:17: note: in expansion of macro 'write_unlock'
     612 |                 write_unlock(&misc->entries_lock);
         |                 ^~~~~~~~~~~~
   fs/binfmt_misc.c: In function 'bm_register_write':
   fs/binfmt_misc.c:757:25: error: invalid use of undefined type 'struct binfmt_misc'
     757 |         write_lock(&misc->entries_lock);
         |                         ^~
   include/linux/spinlock_api_up.h:28:32: note: in definition of macro '___LOCK'
      28 |   do { __acquire(lock); (void)(lock); } while (0)
         |                                ^~~~
   include/linux/spinlock_api_up.h:61:49: note: in expansion of macro '__LOCK'
      61 | #define _raw_write_lock(lock)                   __LOCK(lock)
         |                                                 ^~~~~~
   include/linux/rwlock.h:70:33: note: in expansion of macro '_raw_write_lock'
      70 | #define write_lock(lock)        _raw_write_lock(lock)
         |                                 ^~~~~~~~~~~~~~~
   fs/binfmt_misc.c:757:9: note: in expansion of macro 'write_lock'
     757 |         write_lock(&misc->entries_lock);
         |         ^~~~~~~~~~
   fs/binfmt_misc.c:758:33: error: invalid use of undefined type 'struct binfmt_misc'
     758 |         list_add(&e->list, &misc->entries);
         |                                 ^~
   In file included from include/linux/spinlock.h:326,
                    from include/linux/mm_types.h:9,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from fs/binfmt_misc.c:14:
   fs/binfmt_misc.c:759:27: error: invalid use of undefined type 'struct binfmt_misc'
     759 |         write_unlock(&misc->entries_lock);
         |                           ^~
   include/linux/spinlock_api_up.h:43:32: note: in definition of macro '___UNLOCK'
      43 |   do { __release(lock); (void)(lock); } while (0)
         |                                ^~~~
   include/linux/spinlock_api_up.h:77:49: note: in expansion of macro '__UNLOCK'
      77 | #define _raw_write_unlock(lock)                 __UNLOCK(lock)
         |                                                 ^~~~~~~~
   include/linux/rwlock.h:106:41: note: in expansion of macro '_raw_write_unlock'
     106 | #define write_unlock(lock)              _raw_write_unlock(lock)
         |                                         ^~~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:759:9: note: in expansion of macro 'write_unlock'
     759 |         write_unlock(&misc->entries_lock);
         |         ^~~~~~~~~~~~
   fs/binfmt_misc.c: In function 'bm_status_read':
   fs/binfmt_misc.c:793:17: error: invalid use of undefined type 'struct binfmt_misc'
     793 |         s = misc->enabled ? "enabled\n" : "disabled\n";
         |                 ^~
   fs/binfmt_misc.c: In function 'bm_status_write':
   fs/binfmt_misc.c:811:21: error: invalid use of undefined type 'struct binfmt_misc'
     811 |                 misc->enabled = false;
         |                     ^~
   fs/binfmt_misc.c:815:21: error: invalid use of undefined type 'struct binfmt_misc'
     815 |                 misc->enabled = true;
         |                     ^~
   fs/binfmt_misc.c:822:41: error: invalid use of undefined type 'struct binfmt_misc'
     822 |                 while (!list_empty(&misc->entries))
         |                                         ^~
   In file included from fs/binfmt_misc.c:13:
   fs/binfmt_misc.c:824:57: error: invalid use of undefined type 'struct binfmt_misc'
     824 |                                   list_first_entry(&misc->entries, Node, list));
         |                                                         ^~
   include/linux/kernel.h:494:33: note: in definition of macro 'container_of'
     494 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   include/linux/list.h:522:9: note: in expansion of macro 'list_entry'
     522 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/binfmt_misc.c:824:35: note: in expansion of macro 'list_first_entry'
     824 |                                   list_first_entry(&misc->entries, Node, list));
         |                                   ^~~~~~~~~~~~~~~~
   In file included from <command-line>:
   fs/binfmt_misc.c:824:57: error: invalid use of undefined type 'struct binfmt_misc'
     824 |                                   list_first_entry(&misc->entries, Node, list));
         |                                                         ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:495:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     495 |         BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
         |         ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:495:27: note: in expansion of macro '__same_type'
     495 |         BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
         |                           ^~~~~~~~~~~
   include/linux/list.h:511:9: note: in expansion of macro 'container_of'
     511 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:522:9: note: in expansion of macro 'list_entry'
     522 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/binfmt_misc.c:824:35: note: in expansion of macro 'list_first_entry'
     824 |                                   list_first_entry(&misc->entries, Node, list));
         |                                   ^~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:824:57: error: invalid use of undefined type 'struct binfmt_misc'
     824 |                                   list_first_entry(&misc->entries, Node, list));
         |                                                         ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:495:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     495 |         BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
         |         ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:496:27: note: in expansion of macro '__same_type'
     496 |                          !__same_type(*(ptr), void),                    \
         |                           ^~~~~~~~~~~
   include/linux/list.h:511:9: note: in expansion of macro 'container_of'
     511 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:522:9: note: in expansion of macro 'list_entry'
     522 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/binfmt_misc.c:824:35: note: in expansion of macro 'list_first_entry'
     824 |                                   list_first_entry(&misc->entries, Node, list));
         |                                   ^~~~~~~~~~~~~~~~
   fs/binfmt_misc.c: In function 'bm_fill_super':
   fs/binfmt_misc.c:878:23: error: 'struct user_namespace' has no member named 'binfmt_misc'
     878 |         misc = user_ns->binfmt_misc;
         |                       ^~
>> fs/binfmt_misc.c:880:39: error: invalid application of 'sizeof' to incomplete type 'struct binfmt_misc'
     880 |                 misc = kmalloc(sizeof(struct binfmt_misc), GFP_KERNEL);
         |                                       ^~~~~~
   fs/binfmt_misc.c:884:37: error: invalid use of undefined type 'struct binfmt_misc'
     884 |                 INIT_LIST_HEAD(&misc->entries);
         |                                     ^~
   In file included from include/linux/spinlock.h:317,
                    from include/linux/mm_types.h:9,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from fs/binfmt_misc.c:14:
   fs/binfmt_misc.c:885:34: error: invalid use of undefined type 'struct binfmt_misc'
     885 |                 rwlock_init(&misc->entries_lock);
         |                                  ^~
   include/linux/rwlock.h:28:16: note: in definition of macro 'rwlock_init'
      28 |         do { *(lock) = __RW_LOCK_UNLOCKED(lock); } while (0)
         |                ^~~~
   In file included from <command-line>:
   fs/binfmt_misc.c:888:43: error: 'struct user_namespace' has no member named 'binfmt_misc'
     888 |                 smp_store_release(&user_ns->binfmt_misc, misc);
         |                                           ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:9: note: in expansion of macro 'compiletime_assert'
     325 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:28: note: in expansion of macro '__native_word'
     325 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/barrier.h:162:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     162 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:888:17: note: in expansion of macro 'smp_store_release'
     888 |                 smp_store_release(&user_ns->binfmt_misc, misc);
         |                 ^~~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:888:43: error: 'struct user_namespace' has no member named 'binfmt_misc'
     888 |                 smp_store_release(&user_ns->binfmt_misc, misc);
         |                                           ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:9: note: in expansion of macro 'compiletime_assert'
     325 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:28: note: in expansion of macro '__native_word'
     325 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/barrier.h:162:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     162 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:888:17: note: in expansion of macro 'smp_store_release'
     888 |                 smp_store_release(&user_ns->binfmt_misc, misc);
         |                 ^~~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:888:43: error: 'struct user_namespace' has no member named 'binfmt_misc'
     888 |                 smp_store_release(&user_ns->binfmt_misc, misc);
         |                                           ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:9: note: in expansion of macro 'compiletime_assert'
     325 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:28: note: in expansion of macro '__native_word'
     325 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/barrier.h:162:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     162 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:888:17: note: in expansion of macro 'smp_store_release'
     888 |                 smp_store_release(&user_ns->binfmt_misc, misc);
         |                 ^~~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:888:43: error: 'struct user_namespace' has no member named 'binfmt_misc'
     888 |                 smp_store_release(&user_ns->binfmt_misc, misc);
         |                                           ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:9: note: in expansion of macro 'compiletime_assert'
     325 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:325:28: note: in expansion of macro '__native_word'
     325 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/barrier.h:162:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     162 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/binfmt_misc.c:888:17: note: in expansion of macro 'smp_store_release'
     888 |                 smp_store_release(&user_ns->binfmt_misc, misc);


vim +86 fs/binfmt_misc.c

    79	
    80	static struct binfmt_misc *binfmt_misc(struct user_namespace *user_ns)
    81	{
    82		while (user_ns) {
    83			struct binfmt_misc *misc;
    84	
    85			/* Pairs with smp_store_release() in bm_fill_super(). */
  > 86			misc = smp_load_acquire(&user_ns->binfmt_misc);
    87			if (misc)
    88				return misc;
    89	
    90			user_ns = user_ns->parent;
    91		}
    92	
    93		/*
    94		 * As the first user namespace is initialized with
    95		 * &init_binfmt_misc we should never come here.
    96		 */
    97		WARN_ON_ONCE(1);
    98		return ERR_PTR(-EINVAL);
    99	}
   100	
   101	/*
   102	 * Check if we support the binfmt
   103	 * if we do, return the node, else NULL
   104	 * locking is done in load_misc_binary
   105	 */
   106	static Node *check_file(struct binfmt_misc *misc, struct linux_binprm *bprm)
   107	{
   108		char *p = strrchr(bprm->interp, '.');
   109		struct list_head *l;
   110	
   111		/* Walk all the registered handlers. */
 > 112		list_for_each(l, &misc->entries) {
   113			Node *e = list_entry(l, Node, list);
   114			char *s;
   115			int j;
   116	
   117			/* Make sure this one is currently enabled. */
   118			if (!test_bit(Enabled, &e->flags))
   119				continue;
   120	
   121			/* Do matching based on extension if applicable. */
   122			if (!test_bit(Magic, &e->flags)) {
   123				if (p && !strcmp(e->magic, p + 1))
   124					return e;
   125				continue;
   126			}
   127	
   128			/* Do matching based on magic & mask. */
   129			s = bprm->buf + e->offset;
   130			if (e->mask) {
   131				for (j = 0; j < e->size; j++)
   132					if ((*s++ ^ e->magic[j]) & e->mask[j])
   133						break;
   134			} else {
   135				for (j = 0; j < e->size; j++)
   136					if ((*s++ ^ e->magic[j]))
   137						break;
   138			}
   139			if (j == e->size)
   140				return e;
   141		}
   142		return NULL;
   143	}
   144	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--d6Gm4EdcadzBjdND
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--d6Gm4EdcadzBjdND--
