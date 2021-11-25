Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4640045DF71
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbhKYRSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:18:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:45367 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243108AbhKYRQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:16:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="215569108"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="215569108"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 09:08:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="592067220"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Nov 2021 09:08:45 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqIEm-0006gX-IC; Thu, 25 Nov 2021 17:08:44 +0000
Date:   Fri, 26 Nov 2021 01:08:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>
Subject: arch/parisc/kernel/cache.c:50:1: sparse: sparse: symbol
 'pa_swapper_pg_lock' was not declared. Should it be static?
Message-ID: <202111260110.KkIdLdT2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f53fa508db098c9d372423a6dac31c8a5679cdf
commit: b7795074a04669d0a023babf786d29bf67c68783 parisc: Optimize per-pagetable spinlocks
date:   10 months ago
config: parisc-randconfig-s031-20211122 (https://download.01.org/0day-ci/archive/20211126/202111260110.KkIdLdT2-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b7795074a04669d0a023babf786d29bf67c68783
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b7795074a04669d0a023babf786d29bf67c68783
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/parisc/kernel/cache.c:50:1: sparse: sparse: symbol 'pa_swapper_pg_lock' was not declared. Should it be static?

vim +/pa_swapper_pg_lock +50 arch/parisc/kernel/cache.c

b37d1c1898b288 Mikulas Patocka 2019-04-28  48  
b37d1c1898b288 Mikulas Patocka 2019-04-28  49  /* Swapper page setup lock. */
b37d1c1898b288 Mikulas Patocka 2019-04-28 @50  DEFINE_SPINLOCK(pa_swapper_pg_lock);
b37d1c1898b288 Mikulas Patocka 2019-04-28  51  

:::::: The code at line 50 was first introduced by commit
:::::: b37d1c1898b288c69f3dc9267bc2c41af06f4a4b parisc: Use per-pagetable spinlock

:::::: TO: Mikulas Patocka <mpatocka@redhat.com>
:::::: CC: Helge Deller <deller@gmx.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
