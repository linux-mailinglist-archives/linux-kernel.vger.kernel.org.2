Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DFA45E088
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 19:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349796AbhKYS3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:29:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:16624 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231959AbhKYS1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:27:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235374888"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235374888"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 10:23:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="457936910"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Nov 2021 10:23:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqJPO-0006mX-Uz; Thu, 25 Nov 2021 18:23:46 +0000
Date:   Fri, 26 Nov 2021 02:22:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Subject: kernel/futex/syscalls.c:29:1: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202111260248.R4wPhIDu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f53fa508db098c9d372423a6dac31c8a5679cdf
commit: af8cc9600bbf2251b04c56139f7c83f87c3f878a futex: Split out syscalls
date:   7 weeks ago
config: s390-randconfig-s031-20211116 (https://download.01.org/0day-ci/archive/20211126/202111260248.R4wPhIDu-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af8cc9600bbf2251b04c56139f7c83f87c3f878a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout af8cc9600bbf2251b04c56139f7c83f87c3f878a
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/futex/syscalls.c:29:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/futex/syscalls.c:29:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:51:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:51:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:51:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:51:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:180:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:180:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:180:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:180:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:180:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:180:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:203:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:203:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:218:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:218:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:218:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:218:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:259:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:259:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:259:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:259:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:259:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/futex/syscalls.c:259:1: sparse: sparse: Using plain integer as NULL pointer

vim +29 kernel/futex/syscalls.c

     8	
     9	/*
    10	 * Support for robust futexes: the kernel cleans up held futexes at
    11	 * thread exit time.
    12	 *
    13	 * Implementation: user-space maintains a per-thread list of locks it
    14	 * is holding. Upon do_exit(), the kernel carefully walks this list,
    15	 * and marks all locks that are owned by this thread with the
    16	 * FUTEX_OWNER_DIED bit, and wakes up a waiter (if any). The list is
    17	 * always manipulated with the lock held, so the list is private and
    18	 * per-thread. Userspace also maintains a per-thread 'list_op_pending'
    19	 * field, to allow the kernel to clean up if the thread dies after
    20	 * acquiring the lock, but just before it could have added itself to
    21	 * the list. There can only be one such pending lock.
    22	 */
    23	
    24	/**
    25	 * sys_set_robust_list() - Set the robust-futex list head of a task
    26	 * @head:	pointer to the list-head
    27	 * @len:	length of the list-head, as userspace expects
    28	 */
  > 29	SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
    30			size_t, len)
    31	{
    32		if (!futex_cmpxchg_enabled)
    33			return -ENOSYS;
    34		/*
    35		 * The kernel knows only one size for now:
    36		 */
    37		if (unlikely(len != sizeof(*head)))
    38			return -EINVAL;
    39	
    40		current->robust_list = head;
    41	
    42		return 0;
    43	}
    44	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
