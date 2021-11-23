Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC2B45A649
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhKWPP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:15:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:64422 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhKWPPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:15:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="295844135"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="295844135"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 07:12:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="474787353"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2021 07:12:41 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpXTM-0001zX-Pv; Tue, 23 Nov 2021 15:12:40 +0000
Date:   Tue, 23 Nov 2021 23:12:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: arch/arm/kernel/sys_oabi-compat.c:251:51: sparse: sparse: incorrect
 type in argument 3 (different address spaces)
Message-ID: <202111232352.1I2ZjeBh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   136057256686de39cc3a07c2e39ef6bc43003ff6
commit: 7e2d8c29ecdd86afbcedb9d9a977bab8af527add ARM: 9111/1: oabi-compat: rework fcntl64() emulation
date:   3 months ago
config: arm-randconfig-s032-20211123 (https://download.01.org/0day-ci/archive/20211123/202111232352.1I2ZjeBh-lkp@intel.com/config.gz)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7e2d8c29ecdd86afbcedb9d9a977bab8af527add
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7e2d8c29ecdd86afbcedb9d9a977bab8af527add
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm/kernel/sys_oabi-compat.c:251:51: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct flock64 [noderef] __user *user @@     got struct flock64 * @@
   arch/arm/kernel/sys_oabi-compat.c:251:51: sparse:     expected struct flock64 [noderef] __user *user
   arch/arm/kernel/sys_oabi-compat.c:251:51: sparse:     got struct flock64 *
   arch/arm/kernel/sys_oabi-compat.c:265:55: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected struct flock64 [noderef] __user *user @@     got struct flock64 * @@
   arch/arm/kernel/sys_oabi-compat.c:265:55: sparse:     expected struct flock64 [noderef] __user *user
   arch/arm/kernel/sys_oabi-compat.c:265:55: sparse:     got struct flock64 *
   arch/arm/kernel/sys_oabi-compat.c:292:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __poll_t [usertype] events @@     got unsigned int [addressable] [usertype] events @@
   arch/arm/kernel/sys_oabi-compat.c:292:23: sparse:     expected restricted __poll_t [usertype] events
   arch/arm/kernel/sys_oabi-compat.c:292:23: sparse:     got unsigned int [addressable] [usertype] events
   arch/arm/kernel/sys_oabi-compat.c:312:21: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int __pu_val @@     got restricted __poll_t [usertype] revents @@
   arch/arm/kernel/sys_oabi-compat.c:312:21: sparse:     expected unsigned int __pu_val
   arch/arm/kernel/sys_oabi-compat.c:312:21: sparse:     got restricted __poll_t [usertype] revents

vim +251 arch/arm/kernel/sys_oabi-compat.c

   230	
   231	asmlinkage long sys_oabi_fcntl64(unsigned int fd, unsigned int cmd,
   232					 unsigned long arg)
   233	{
   234		void __user *argp = (void __user *)arg;
   235		struct fd f = fdget_raw(fd);
   236		struct flock64 flock;
   237		long err = -EBADF;
   238	
   239		if (!f.file)
   240			goto out;
   241	
   242		switch (cmd) {
   243		case F_GETLK64:
   244		case F_OFD_GETLK:
   245			err = security_file_fcntl(f.file, cmd, arg);
   246			if (err)
   247				break;
   248			err = get_oabi_flock(&flock, argp);
   249			if (err)
   250				break;
 > 251			err = fcntl_getlk64(f.file, cmd, &flock);
   252			if (!err)
   253			       err = put_oabi_flock(&flock, argp);
   254			break;
   255		case F_SETLK64:
   256		case F_SETLKW64:
   257		case F_OFD_SETLK:
   258		case F_OFD_SETLKW:
   259			err = security_file_fcntl(f.file, cmd, arg);
   260			if (err)
   261				break;
   262			err = get_oabi_flock(&flock, argp);
   263			if (err)
   264				break;
   265			err = fcntl_setlk64(fd, f.file, cmd, &flock);
   266			break;
   267		default:
   268			err = sys_fcntl64(fd, cmd, arg);
   269			break;
   270		}
   271		fdput(f);
   272	out:
   273		return err;
   274	}
   275	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
