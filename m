Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975A64601B3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 22:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356262AbhK0VfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 16:35:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:16559 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232746AbhK0VdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 16:33:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="223017304"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="223017304"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 13:30:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="594062281"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Nov 2021 13:30:07 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mr5Go-000A1Y-FB; Sat, 27 Nov 2021 21:30:06 +0000
Date:   Sun, 28 Nov 2021 05:29:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/memcontrol.c:2113:33: warning: unused function 'get_obj_stock'
Message-ID: <202111280551.LXsWYt1T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   86799cdfbcd2308cbad6c1dc983b81595b77b639
commit: 559271146efc0bf125e6390191f683eab884e4a1 mm/memcg: optimize user context object stock access
date:   5 months ago
config: mips-randconfig-r022-20211122 (https://download.01.org/0day-ci/archive/20211128/202111280551.LXsWYt1T-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c133fb321f7ca6083ce15b6aa5bf89de6600e649)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=559271146efc0bf125e6390191f683eab884e4a1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 559271146efc0bf125e6390191f683eab884e4a1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/memcontrol.c:789:20: warning: unused function 'mod_objcg_mlstate'
   static inline void mod_objcg_mlstate(struct obj_cgroup
   ^
   mm/memcontrol.c:950:29: warning: unused function 'memcg_kmem_bypass'
   static __always_inline bool memcg_kmem_bypass(void)
   ^
>> mm/memcontrol.c:2113:33: warning: unused function 'get_obj_stock'
   static inline struct obj_stock long
   ^
>> mm/memcontrol.c:2129:20: warning: unused function 'put_obj_stock'
   static inline void put_obj_stock(unsigned long flags)
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set mips64r2
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/atomic.h", .line = 153, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $1 # atomic_add
   addu $0, $2
   sc $0, $1
   beqz $0, 1b
   .set pop
   '
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-5162b558d8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block certs crypto drivers fs include init ipc kernel lib mm net nr_bisected scripts security sound source usr virt


vim +/get_obj_stock +2113 mm/memcontrol.c

  2101	
  2102	/*
  2103	 * Most kmem_cache_alloc() calls are from user context. The irq disable/enable
  2104	 * sequence used in this case to access content from object stock is slow.
  2105	 * To optimize for user context access, there are now two object stocks for
  2106	 * task context and interrupt context access respectively.
  2107	 *
  2108	 * The task context object stock can be accessed by disabling preemption only
  2109	 * which is cheap in non-preempt kernel. The interrupt context object stock
  2110	 * can only be accessed after disabling interrupt. User context code can
  2111	 * access interrupt object stock, but not vice versa.
  2112	 */
> 2113	static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
  2114	{
  2115		struct memcg_stock_pcp *stock;
  2116	
  2117		if (likely(in_task())) {
  2118			*pflags = 0UL;
  2119			preempt_disable();
  2120			stock = this_cpu_ptr(&memcg_stock);
  2121			return &stock->task_obj;
  2122		}
  2123	
  2124		local_irq_save(*pflags);
  2125		stock = this_cpu_ptr(&memcg_stock);
  2126		return &stock->irq_obj;
  2127	}
  2128	
> 2129	static inline void put_obj_stock(unsigned long flags)
  2130	{
  2131		if (likely(in_task()))
  2132			preempt_enable();
  2133		else
  2134			local_irq_restore(flags);
  2135	}
  2136	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
