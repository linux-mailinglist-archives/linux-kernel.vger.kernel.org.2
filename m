Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C6F45FE79
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 13:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354288AbhK0MVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 07:21:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:18376 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234953AbhK0MTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 07:19:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="234488625"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="234488625"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 04:15:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="539497131"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Nov 2021 04:15:49 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqwcO-0009Tm-KQ; Sat, 27 Nov 2021 12:15:48 +0000
Date:   Sat, 27 Nov 2021 20:15:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/memcontrol.c:785:20: warning: unused function 'mod_objcg_mlstate'
Message-ID: <202111272014.WOYNLUV6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5c17547b778975b3d83a73c8d84e8fb5ecf3ba5
commit: 68ac5b3c8db2fda00af594eca4100aceaf927c0e mm/memcg: cache vmstat data in percpu memcg_stock_pcp
date:   5 months ago
config: mips-randconfig-r022-20211122 (https://download.01.org/0day-ci/archive/20211127/202111272014.WOYNLUV6-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c133fb321f7ca6083ce15b6aa5bf89de6600e649)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68ac5b3c8db2fda00af594eca4100aceaf927c0e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 68ac5b3c8db2fda00af594eca4100aceaf927c0e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/memcontrol.c:785:20: warning: unused function 'mod_objcg_mlstate'
   static inline void mod_objcg_mlstate(struct obj_cgroup
   ^
   mm/memcontrol.c:946:29: warning: unused function 'memcg_kmem_bypass'
   static __always_inline bool memcg_kmem_bypass(void)
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


vim +/mod_objcg_mlstate +785 mm/memcontrol.c

   784	
 > 785	static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
   786					     struct pglist_data *pgdat,
   787					     enum node_stat_item idx, int nr)
   788	{
   789		struct mem_cgroup *memcg;
   790		struct lruvec *lruvec;
   791	
   792		rcu_read_lock();
   793		memcg = obj_cgroup_memcg(objcg);
   794		lruvec = mem_cgroup_lruvec(memcg, pgdat);
   795		__mod_memcg_lruvec_state(lruvec, idx, nr);
   796		rcu_read_unlock();
   797	}
   798	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
