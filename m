Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FDC45DCFC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbhKYPOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:14:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:49261 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235116AbhKYPMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:12:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="296332554"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="296332554"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 07:05:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="675286060"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2021 07:05:40 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqGJf-0006WK-J8; Thu, 25 Nov 2021 15:05:39 +0000
Date:   Thu, 25 Nov 2021 23:05:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: arch/s390/kernel/syscall.c:56:1: sparse: sparse: Using plain integer
 as NULL pointer
Message-ID: <202111252321.A2S8SwOA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f53fa508db098c9d372423a6dac31c8a5679cdf
commit: 56e62a73702836017564eaacd5212e4d0fa1c01d s390: convert to generic entry
date:   10 months ago
config: s390-randconfig-s031-20211116 (https://download.01.org/0day-ci/archive/20211125/202111252321.A2S8SwOA-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=56e62a73702836017564eaacd5212e4d0fa1c01d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 56e62a73702836017564eaacd5212e4d0fa1c01d
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/s390/kernel/syscall.c:56:1: sparse: sparse: Using plain integer as NULL pointer
>> arch/s390/kernel/syscall.c:56:1: sparse: sparse: Using plain integer as NULL pointer

vim +56 arch/s390/kernel/syscall.c

^1da177e4c3f415 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  55  
a4679373cf4ee0e arch/s390/kernel/sys_s390.c Christoph Hellwig 2010-03-10 @56  SYSCALL_DEFINE1(mmap2, struct s390_mmap_arg_struct __user *, arg)
^1da177e4c3f415 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  57  {
a4679373cf4ee0e arch/s390/kernel/sys_s390.c Christoph Hellwig 2010-03-10  58  	struct s390_mmap_arg_struct a;
^1da177e4c3f415 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  59  	int error = -EFAULT;
^1da177e4c3f415 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  60  
^1da177e4c3f415 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  61  	if (copy_from_user(&a, arg, sizeof(a)))
^1da177e4c3f415 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  62  		goto out;
a90f590a1bee36f arch/s390/kernel/sys_s390.c Dominik Brodowski 2018-03-11  63  	error = ksys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd, a.offset);
^1da177e4c3f415 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  64  out:
^1da177e4c3f415 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  65  	return error;
^1da177e4c3f415 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  66  }
^1da177e4c3f415 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  67  

:::::: The code at line 56 was first introduced by commit
:::::: a4679373cf4ee0e7792dc56205365732b725c2c1 Add generic sys_old_mmap()

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
