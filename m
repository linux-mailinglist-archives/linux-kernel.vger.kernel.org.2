Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317B13F273C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 09:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbhHTHDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 03:03:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:9477 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238655AbhHTHDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 03:03:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="203870542"
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="gz'50?scan'50,208,50";a="203870542"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 00:03:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="gz'50?scan'50,208,50";a="452543831"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Aug 2021 00:02:59 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mGyYM-000UdD-OH; Fri, 20 Aug 2021 07:02:58 +0000
Date:   Fri, 20 Aug 2021 15:02:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: drivers/watchdog/indydog.c:116:24: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202108201513.QjkawREH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d992fe5318d8d7af9510b879439a3c7f283da442
commit: ddb002d6d6af12c45dd9d565cadf0f40b36b7c25 MIPS: uaccess: Reduce number of nested macros
date:   4 months ago
config: mips-randconfig-s032-20210820 (attached as .config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-348-gf0e6938b-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/watchdog/indydog.c:110:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct watchdog_info * @@
   drivers/watchdog/indydog.c:110:35: sparse:     expected void [noderef] __user *to
   drivers/watchdog/indydog.c:110:35: sparse:     got struct watchdog_info *
>> drivers/watchdog/indydog.c:116:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int * @@
   drivers/watchdog/indydog.c:116:24: sparse:     expected int [noderef] __user *__p
   drivers/watchdog/indydog.c:116:24: sparse:     got int *
>> drivers/watchdog/indydog.c:119:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] __user *__p @@     got int * @@
   drivers/watchdog/indydog.c:119:21: sparse:     expected int const [noderef] __user *__p
   drivers/watchdog/indydog.c:119:21: sparse:     got int *
   drivers/watchdog/indydog.c:135:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int * @@
   drivers/watchdog/indydog.c:135:24: sparse:     expected int [noderef] __user *__p
   drivers/watchdog/indydog.c:135:24: sparse:     got int *
   drivers/watchdog/indydog.c:153:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected long ( *write )( ... ) @@     got long ( * )( ... ) @@
   drivers/watchdog/indydog.c:153:27: sparse:     expected long ( *write )( ... )
   drivers/watchdog/indydog.c:153:27: sparse:     got long ( * )( ... )

vim +116 drivers/watchdog/indydog.c

^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16   97  
9b9dbcca3fa13a drivers/watchdog/indydog.c      Alan Cox         2008-05-19   98  static long indydog_ioctl(struct file *file, unsigned int cmd,
9b9dbcca3fa13a drivers/watchdog/indydog.c      Alan Cox         2008-05-19   99  							unsigned long arg)
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  100  {
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  101  	int options, retval = -EINVAL;
42747d712de56c drivers/watchdog/indydog.c      Wim Van Sebroeck 2009-12-26  102  	static const struct watchdog_info ident = {
e73a780272a46e drivers/watchdog/indydog.c      Wim Van Sebroeck 2009-05-11  103  		.options		= WDIOF_KEEPALIVEPING,
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  104  		.firmware_version	= 0,
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  105  		.identity		= "Hardware Watchdog for SGI IP22",
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  106  	};
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  107  
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  108  	switch (cmd) {
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  109  	case WDIOC_GETSUPPORT:
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  110  		if (copy_to_user((struct watchdog_info *)arg,
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  111  				 &ident, sizeof(ident)))
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  112  			return -EFAULT;
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  113  		return 0;
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  114  	case WDIOC_GETSTATUS:
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  115  	case WDIOC_GETBOOTSTATUS:
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16 @116  		return put_user(0, (int *)arg);
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  117  	case WDIOC_SETOPTIONS:
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  118  	{
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16 @119  		if (get_user(options, (int *)arg))
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  120  			return -EFAULT;
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  121  		if (options & WDIOS_DISABLECARD) {
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  122  			indydog_stop();
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  123  			retval = 0;
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  124  		}
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  125  		if (options & WDIOS_ENABLECARD) {
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  126  			indydog_start();
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  127  			retval = 0;
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  128  		}
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  129  		return retval;
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  130  	}
0c06090c9472db drivers/watchdog/indydog.c      Wim Van Sebroeck 2008-07-18  131  	case WDIOC_KEEPALIVE:
0c06090c9472db drivers/watchdog/indydog.c      Wim Van Sebroeck 2008-07-18  132  		indydog_ping();
0c06090c9472db drivers/watchdog/indydog.c      Wim Van Sebroeck 2008-07-18  133  		return 0;
0c06090c9472db drivers/watchdog/indydog.c      Wim Van Sebroeck 2008-07-18  134  	case WDIOC_GETTIMEOUT:
0c06090c9472db drivers/watchdog/indydog.c      Wim Van Sebroeck 2008-07-18  135  		return put_user(WATCHDOG_TIMEOUT, (int *)arg);
9b9dbcca3fa13a drivers/watchdog/indydog.c      Alan Cox         2008-05-19  136  	default:
9b9dbcca3fa13a drivers/watchdog/indydog.c      Alan Cox         2008-05-19  137  		return -ENOTTY;
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  138  	}
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  139  }
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  140  

:::::: The code at line 116 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--bp/iNruPH9dso1Pn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
k1ySItT8qjUyTKiqi76ouIlHxTbOqBnPD0HCJAi0o82XxDOfI6Ek/YUO4RYU0o3KaE6D7ywN
1vE40DjZgsb1ACFxaxOcSbPshtZrIk5kLQXzFSAl6AxCQHsvNJJnFLk2G/Sgmm7STH7ftyiB
SQk9q8R7uCmboMJmjx1hXCSoxQISB3HHpx/Pwjiq+f10Z14D6fWTnhRc95t8dkqTQ/y5hD1Q
Lo45uS/O9zukQ0i4bXY9BZ+di6vzm+leUn6nZ0YDojlGTh/wmAc2d9HvAPXUshoWPe1NQCgi
KB0xfxm1uFga3ATwMyXdhXim3Doaxxmgt9r1Meq65YwcHXTLk9dPTz+ePr6+/EAGVcOApjm5
v5auBBdtBhABRRzLZd87jol70swxh5Vpi1P5zYoIPmjS+b2/dHOBCB3OxtWnAGXETHloui+g
Gif41CtiSaDN3iCJ+NJa+BCZP5/NTnuT+76kTKFSZmW27+LGxpwuGDSw60vCpzEDXS+45Me7
YUFxTXZWjdc8jtc1eJpJkl6+zUmzdFrRXRGFPgJMD4UVYfq8ruyvEKkpnNAVDjVEzUqux8fu
RBHC2w/R2SpDB+lRBwpSlsO5Q6FxV5ax6Y+1urJUQ7vExJW3hncfwXiauLlRMCm6W6St3StV
Pzxk24EgMiIqzZ4irqwUk6T6gXUfHIgMundhbHbdMll90CeooWT/eixCKlnwNdS6hBRUm42t
yrfyHHsYEdsWbX+mgA2jdDUUKJWtuzycNAWXg3PCCumBVYOfgI+PdlnoEIYf+iByI+b56ti0
7SObMWGf2vOw2iuyTc8XOihxLuzrTKbO2LeYmjbIKi/u1lhDnXTy4sO3TpqcKkIownmboURc
Nkoju7++vH7+/uXlb1YDXo7y0+fvsDDc6FaujCzttq071Xl0SlTgiEq0282J3A5lFIojLq3o
HOrLIo8jdOGic/xtp9o3HZsRWhtgOzedWNU6v1UK0o5l3zoCkm21m57UZO/Orb4dFaKT/fYi
DcWXf3378fn1058/jT5oDyfN0WYmsj0eImoGL0bCS2aLAsLNlIHdnahDM8bHyo7QIURXxCu/
+4MbOcu74bt//Pnt5+uX/7t7+fOPl+fnl+e73yeu3759/e0ja6r/Mes1aBO0oInl0uyXYshd
YlGMY2OkseMGE/q5/Ey+P3WFmfhkZO5Iv+S23baEV8UDE6HGTKuqebhf4ZYxW5rgvRLnbQ5N
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

--bp/iNruPH9dso1Pn--
