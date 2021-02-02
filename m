Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1630CF3F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhBBWod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:44:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:35384 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232280AbhBBWoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:44:25 -0500
IronPort-SDR: jpV78Cr1QytCK1dZjgeonlSxdVrcftSETvg1yIxOuPYf31qIfs9QAf3IO7y4md8jnUEE4/NE+y
 yURGBHy0NtQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="265775423"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="gz'50?scan'50,208,50";a="265775423"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 14:43:40 -0800
IronPort-SDR: f69gMEnVslUSjbKSBTtaKdc1jCVnk3LtsKaqJWLBooT4kd/ycThRDmazK9sttyClVZNH2ZzYvF
 x7STzGWasUKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="gz'50?scan'50,208,50";a="579206328"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 02 Feb 2021 14:43:38 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l74OY-0009jI-1D; Tue, 02 Feb 2021 22:43:38 +0000
Date:   Wed, 3 Feb 2021 06:43:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rcu:willy-maple 132/202] include/linux/kernel.h:694:51: error:
 'struct vm_region' has no member named 'vm_rb'
Message-ID: <202102030650.iZBgPiVQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git willy-maple
head:   7e346d2845b4bd77663394f39fa70456e0084c86
commit: 25b065e50d69b0bb569d8b59f904eb9ad8566f31 [132/202] mm: Remove rb tree.
config: riscv-nommu_k210_defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=25b065e50d69b0bb569d8b59f904eb9ad8566f31
        git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags rcu willy-maple
        git checkout 25b065e50d69b0bb569d8b59f904eb9ad8566f31
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   mm/nommu.c: In function 'add_nommu_region':
>> include/linux/kernel.h:694:51: error: 'struct vm_region' has no member named 'vm_rb'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                                                   ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:20: note: in expansion of macro '__same_type'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   mm/nommu.c:477:13: note: in expansion of macro 'rb_entry'
     477 |   pregion = rb_entry(parent, struct vm_region, vm_rb);
         |             ^~~~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct vm_region' has no member named 'vm_rb'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:697:21: note: in expansion of macro 'offsetof'
     697 |  ((type *)(__mptr - offsetof(type, member))); })
         |                     ^~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   mm/nommu.c:477:13: note: in expansion of macro 'rb_entry'
     477 |   pregion = rb_entry(parent, struct vm_region, vm_rb);
         |             ^~~~~~~~
   mm/nommu.c:488:22: error: 'struct vm_region' has no member named 'vm_rb'
     488 |  rb_link_node(&region->vm_rb, parent, p);
         |                      ^~
   mm/nommu.c:489:25: error: 'struct vm_region' has no member named 'vm_rb'
     489 |  rb_insert_color(&region->vm_rb, &nommu_region_tree);
         |                         ^~
   mm/nommu.c: In function 'delete_nommu_region':
   mm/nommu.c:502:18: error: 'struct vm_region' has no member named 'vm_rb'
     502 |  rb_erase(&region->vm_rb, &nommu_region_tree);
         |                  ^~
   mm/nommu.c: In function 'add_vma_to_mm':
   mm/nommu.c:587:9: error: 'struct mm_struct' has no member named 'mm_rb'
     587 |  p = &mm->mm_rb.rb_node;
         |         ^~
   In file included from <command-line>:
>> include/linux/kernel.h:694:51: error: 'struct vm_area_struct' has no member named 'vm_rb'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                                                   ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:20: note: in expansion of macro '__same_type'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   mm/nommu.c:590:10: note: in expansion of macro 'rb_entry'
     590 |   pvma = rb_entry(parent, struct vm_area_struct, vm_rb);
         |          ^~~~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct vm_area_struct' has no member named 'vm_rb'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:697:21: note: in expansion of macro 'offsetof'
     697 |  ((type *)(__mptr - offsetof(type, member))); })
         |                     ^~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   mm/nommu.c:590:10: note: in expansion of macro 'rb_entry'
     590 |   pvma = rb_entry(parent, struct vm_area_struct, vm_rb);
         |          ^~~~~~~~
   mm/nommu.c:613:19: error: 'struct vm_area_struct' has no member named 'vm_rb'
     613 |  rb_link_node(&vma->vm_rb, parent, p);
         |                   ^~
   mm/nommu.c:614:22: error: 'struct vm_area_struct' has no member named 'vm_rb'
     614 |  rb_insert_color(&vma->vm_rb, &mm->mm_rb);
         |                      ^~
   mm/nommu.c:614:34: error: 'struct mm_struct' has no member named 'mm_rb'
     614 |  rb_insert_color(&vma->vm_rb, &mm->mm_rb);
         |                                  ^~
   In file included from <command-line>:
>> include/linux/kernel.h:694:51: error: 'struct vm_area_struct' has no member named 'vm_rb'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                                                   ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:20: note: in expansion of macro '__same_type'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   mm/nommu.c:619:10: note: in expansion of macro 'rb_entry'
     619 |   prev = rb_entry(rb_prev, struct vm_area_struct, vm_rb);
         |          ^~~~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct vm_area_struct' has no member named 'vm_rb'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:697:21: note: in expansion of macro 'offsetof'
     697 |  ((type *)(__mptr - offsetof(type, member))); })
         |                     ^~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   mm/nommu.c:619:10: note: in expansion of macro 'rb_entry'
     619 |   prev = rb_entry(rb_prev, struct vm_area_struct, vm_rb);
         |          ^~~~~~~~
   mm/nommu.c: In function 'delete_vma_from_mm':
   mm/nommu.c:655:15: error: 'struct vm_area_struct' has no member named 'vm_rb'
     655 |  rb_erase(&vma->vm_rb, &mm->mm_rb);
         |               ^~
   mm/nommu.c:655:27: error: 'struct mm_struct' has no member named 'mm_rb'
     655 |  rb_erase(&vma->vm_rb, &mm->mm_rb);
         |                           ^~
   In file included from <command-line>:
   mm/nommu.c: In function 'do_mmap':
>> include/linux/kernel.h:694:51: error: 'struct vm_region' has no member named 'vm_rb'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                                                   ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:20: note: in expansion of macro '__same_type'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   mm/nommu.c:1141:14: note: in expansion of macro 'rb_entry'
    1141 |    pregion = rb_entry(rb, struct vm_region, vm_rb);
         |              ^~~~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct vm_region' has no member named 'vm_rb'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:697:21: note: in expansion of macro 'offsetof'
     697 |  ((type *)(__mptr - offsetof(type, member))); })
         |                     ^~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   mm/nommu.c:1141:14: note: in expansion of macro 'rb_entry'
    1141 |    pregion = rb_entry(rb, struct vm_region, vm_rb);
         |              ^~~~~~~~
   mm/nommu.c: At top level:
   mm/nommu.c:1658:15: warning: no previous prototype for 'arch_get_unmapped_area' [-Wmissing-prototypes]
    1658 | unsigned long arch_get_unmapped_area(struct file *file, unsigned long addr,
         |               ^~~~~~~~~~~~~~~~~~~~~~
--
   In file included from <command-line>:
   fs/proc/nommu.c: In function 'nommu_region_list_show':
>> include/linux/kernel.h:694:51: error: 'struct vm_region' has no member named 'vm_rb'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                                                   ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:20: note: in expansion of macro '__same_type'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   fs/proc/nommu.c:77:30: note: in expansion of macro 'rb_entry'
      77 |  return nommu_region_show(m, rb_entry(p, struct vm_region, vm_rb));
         |                              ^~~~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct vm_region' has no member named 'vm_rb'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:697:21: note: in expansion of macro 'offsetof'
     697 |  ((type *)(__mptr - offsetof(type, member))); })
         |                     ^~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   fs/proc/nommu.c:77:30: note: in expansion of macro 'rb_entry'
      77 |  return nommu_region_show(m, rb_entry(p, struct vm_region, vm_rb));
         |                              ^~~~~~~~
   fs/proc/nommu.c:78:1: error: control reaches end of non-void function [-Werror=return-type]
      78 | }
         | ^
   cc1: some warnings being treated as errors
--
   fs/proc/task_nommu.c: In function 'task_mem':
>> fs/proc/task_nommu.c:29:23: error: 'struct mm_struct' has no member named 'mm_rb'
      29 |  for (p = rb_first(&mm->mm_rb); p; p = rb_next(p)) {
         |                       ^~
   In file included from <command-line>:
>> include/linux/kernel.h:694:51: error: 'struct vm_area_struct' has no member named 'vm_rb'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                                                   ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:20: note: in expansion of macro '__same_type'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   fs/proc/task_nommu.c:30:9: note: in expansion of macro 'rb_entry'
      30 |   vma = rb_entry(p, struct vm_area_struct, vm_rb);
         |         ^~~~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct vm_area_struct' has no member named 'vm_rb'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:697:21: note: in expansion of macro 'offsetof'
     697 |  ((type *)(__mptr - offsetof(type, member))); })
         |                     ^~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   fs/proc/task_nommu.c:30:9: note: in expansion of macro 'rb_entry'
      30 |   vma = rb_entry(p, struct vm_area_struct, vm_rb);
         |         ^~~~~~~~
   fs/proc/task_nommu.c: In function 'task_vsize':
   fs/proc/task_nommu.c:90:23: error: 'struct mm_struct' has no member named 'mm_rb'
      90 |  for (p = rb_first(&mm->mm_rb); p; p = rb_next(p)) {
         |                       ^~
   In file included from <command-line>:
>> include/linux/kernel.h:694:51: error: 'struct vm_area_struct' has no member named 'vm_rb'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                                                   ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:20: note: in expansion of macro '__same_type'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   fs/proc/task_nommu.c:91:9: note: in expansion of macro 'rb_entry'
      91 |   vma = rb_entry(p, struct vm_area_struct, vm_rb);
         |         ^~~~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct vm_area_struct' has no member named 'vm_rb'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:697:21: note: in expansion of macro 'offsetof'
     697 |  ((type *)(__mptr - offsetof(type, member))); })
         |                     ^~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   fs/proc/task_nommu.c:91:9: note: in expansion of macro 'rb_entry'
      91 |   vma = rb_entry(p, struct vm_area_struct, vm_rb);
         |         ^~~~~~~~
   fs/proc/task_nommu.c: In function 'task_statm':
   fs/proc/task_nommu.c:108:23: error: 'struct mm_struct' has no member named 'mm_rb'
     108 |  for (p = rb_first(&mm->mm_rb); p; p = rb_next(p)) {
         |                       ^~
   In file included from <command-line>:
>> include/linux/kernel.h:694:51: error: 'struct vm_area_struct' has no member named 'vm_rb'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                                                   ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:20: note: in expansion of macro '__same_type'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   fs/proc/task_nommu.c:109:9: note: in expansion of macro 'rb_entry'
     109 |   vma = rb_entry(p, struct vm_area_struct, vm_rb);
         |         ^~~~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct vm_area_struct' has no member named 'vm_rb'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:697:21: note: in expansion of macro 'offsetof'
     697 |  ((type *)(__mptr - offsetof(type, member))); })
         |                     ^~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   fs/proc/task_nommu.c:109:9: note: in expansion of macro 'rb_entry'
     109 |   vma = rb_entry(p, struct vm_area_struct, vm_rb);
         |         ^~~~~~~~
   fs/proc/task_nommu.c: In function 'show_map':
>> include/linux/kernel.h:694:51: error: 'struct vm_area_struct' has no member named 'vm_rb'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                                                   ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:20: note: in expansion of macro '__same_type'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   fs/proc/task_nommu.c:195:27: note: in expansion of macro 'rb_entry'
     195 |  return nommu_vma_show(m, rb_entry(p, struct vm_area_struct, vm_rb));
         |                           ^~~~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct vm_area_struct' has no member named 'vm_rb'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:697:21: note: in expansion of macro 'offsetof'
     697 |  ((type *)(__mptr - offsetof(type, member))); })
         |                     ^~~~~~~~
   include/linux/rbtree.h:38:37: note: in expansion of macro 'container_of'
      38 | #define rb_entry(ptr, type, member) container_of(ptr, type, member)
         |                                     ^~~~~~~~~~~~
   fs/proc/task_nommu.c:195:27: note: in expansion of macro 'rb_entry'
     195 |  return nommu_vma_show(m, rb_entry(p, struct vm_area_struct, vm_rb));
         |                           ^~~~~~~~
   fs/proc/task_nommu.c: In function 'm_start':
   fs/proc/task_nommu.c:220:23: error: 'struct mm_struct' has no member named 'mm_rb'
     220 |  for (p = rb_first(&mm->mm_rb); p; p = rb_next(p))
         |                       ^~
   fs/proc/task_nommu.c: In function 'show_map':
   fs/proc/task_nommu.c:196:1: error: control reaches end of non-void function [-Werror=return-type]
     196 | }
         | ^
   cc1: some warnings being treated as errors


vim +694 include/linux/kernel.h

cf14f27f82af78 Alexei Starovoitov 2018-03-28  684  
^1da177e4c3f41 Linus Torvalds     2005-04-16  685  /**
^1da177e4c3f41 Linus Torvalds     2005-04-16  686   * container_of - cast a member of a structure out to the containing structure
^1da177e4c3f41 Linus Torvalds     2005-04-16  687   * @ptr:	the pointer to the member.
^1da177e4c3f41 Linus Torvalds     2005-04-16  688   * @type:	the type of the container struct this is embedded in.
^1da177e4c3f41 Linus Torvalds     2005-04-16  689   * @member:	the name of the member within the struct.
^1da177e4c3f41 Linus Torvalds     2005-04-16  690   *
^1da177e4c3f41 Linus Torvalds     2005-04-16  691   */
^1da177e4c3f41 Linus Torvalds     2005-04-16  692  #define container_of(ptr, type, member) ({				\
c7acec713d14c6 Ian Abbott         2017-07-12  693  	void *__mptr = (void *)(ptr);					\
c7acec713d14c6 Ian Abbott         2017-07-12 @694  	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
c7acec713d14c6 Ian Abbott         2017-07-12  695  			 !__same_type(*(ptr), void),			\
c7acec713d14c6 Ian Abbott         2017-07-12  696  			 "pointer type mismatch in container_of()");	\
c7acec713d14c6 Ian Abbott         2017-07-12  697  	((type *)(__mptr - offsetof(type, member))); })
^1da177e4c3f41 Linus Torvalds     2005-04-16  698  

:::::: The code at line 694 was first introduced by commit
:::::: c7acec713d14c6ce8a20154f9dfda258d6bcad3b kernel.h: handle pointers to arrays better in container_of()

:::::: TO: Ian Abbott <abbotti@mev.co.uk>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--nFreZHaLTZJo0R7j
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--nFreZHaLTZJo0R7j--
