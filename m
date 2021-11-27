Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64E545FC30
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 03:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351206AbhK0Cst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 21:48:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:44357 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350433AbhK0Cqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 21:46:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="222606494"
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="222606494"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 18:43:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="675707630"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Nov 2021 18:43:31 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqngY-0008xH-9s; Sat, 27 Nov 2021 02:43:30 +0000
Date:   Sat, 27 Nov 2021 10:43:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/memcontrol.c:1058:29: warning: unused function 'memcg_kmem_bypass'
Message-ID: <202111271029.EeYluWMG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5c17547b778975b3d83a73c8d84e8fb5ecf3ba5
commit: b4e0b68fbd9d1fd7e31cbe8adca3ad6cf556e2ee mm: memcontrol: use obj_cgroup APIs to charge kmem pages
date:   7 months ago
config: mips-randconfig-r022-20211122 (https://download.01.org/0day-ci/archive/20211127/202111271029.EeYluWMG-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c133fb321f7ca6083ce15b6aa5bf89de6600e649)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b4e0b68fbd9d1fd7e31cbe8adca3ad6cf556e2ee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b4e0b68fbd9d1fd7e31cbe8adca3ad6cf556e2ee
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/memcontrol.c:1058:29: warning: unused function 'memcg_kmem_bypass'
   static __always_inline bool memcg_kmem_bypass(void)
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set noat
   .set push
   .set arch=r4000
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/cmpxchg.h", .line = 163, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $2 # __cmpxchg_asm
   bne $0, ${3:z}, 2f
   .set pop
   move $$1, ${4:z}
   .set arch=r4000
   sc $$1, $1
   beqz $$1, 1b
   .set pop
   2: .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/cmpxchg.h", .line = 163, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   '
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-5162b558d8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block certs crypto drivers fs include init ipc kernel lib mm net nr_bisected scripts security sound source usr virt


vim +/memcg_kmem_bypass +1058 mm/memcontrol.c

279c3393e2c1133 Roman Gushchin 2020-10-17  1057  
4127c6504f25c4f Roman Gushchin 2020-10-17 @1058  static __always_inline bool memcg_kmem_bypass(void)
4127c6504f25c4f Roman Gushchin 2020-10-17  1059  {
4127c6504f25c4f Roman Gushchin 2020-10-17  1060  	/* Allow remote memcg charging from any context. */
4127c6504f25c4f Roman Gushchin 2020-10-17  1061  	if (unlikely(active_memcg()))
4127c6504f25c4f Roman Gushchin 2020-10-17  1062  		return false;
4127c6504f25c4f Roman Gushchin 2020-10-17  1063  
4127c6504f25c4f Roman Gushchin 2020-10-17  1064  	/* Memcg to charge can't be determined. */
4127c6504f25c4f Roman Gushchin 2020-10-17  1065  	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
4127c6504f25c4f Roman Gushchin 2020-10-17  1066  		return true;
4127c6504f25c4f Roman Gushchin 2020-10-17  1067  
4127c6504f25c4f Roman Gushchin 2020-10-17  1068  	return false;
4127c6504f25c4f Roman Gushchin 2020-10-17  1069  }
4127c6504f25c4f Roman Gushchin 2020-10-17  1070  

:::::: The code at line 1058 was first introduced by commit
:::::: 4127c6504f25c4fcff52dc996efda2ef859dd661 mm: kmem: enable kernel memcg accounting from interrupt contexts

:::::: TO: Roman Gushchin <guro@fb.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
