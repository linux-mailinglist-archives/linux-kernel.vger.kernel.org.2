Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5CE37614B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhEGHkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:40:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:26807 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231179AbhEGHki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:40:38 -0400
IronPort-SDR: xyEodSdG3spVStOX8wrjPGVvjo9VViWU7q9l7nRFShbRw2Vt6dWIBXmeNc5IpxPkTgDnZL8gik
 5PnwcqkM3V8w==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="259948094"
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; 
   d="gz'50?scan'50,208,50";a="259948094"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 00:39:36 -0700
IronPort-SDR: w3VHcyjg1pQGhAot9DgN8U5Zw5LBm1qfB8zeMw4UoQwSB7NEpgzjHkOPKQUziiawE4i0Q2RJEm
 HcXY7Ecmys7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; 
   d="gz'50?scan'50,208,50";a="434794459"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 May 2021 00:39:34 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lev5B-000B74-LY; Fri, 07 May 2021 07:39:33 +0000
Date:   Fri, 7 May 2021 15:39:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: drivers/watchdog/indydog.c:116:24: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202105071512.P6WI4W3n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e48661230cc35b3d0f4367eddfc19f86463ab917
commit: ddb002d6d6af12c45dd9d565cadf0f40b36b7c25 MIPS: uaccess: Reduce number of nested macros
date:   4 weeks ago
config: mips-randconfig-s032-20210507 (attached as .config)
compiler: mips-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=mips 

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
   drivers/watchdog/indydog.c:153:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *write )( ... ) @@     got int ( * )( ... ) @@
   drivers/watchdog/indydog.c:153:27: sparse:     expected int ( *write )( ... )
   drivers/watchdog/indydog.c:153:27: sparse:     got int ( * )( ... )

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
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16 @110  		if (copy_to_user((struct watchdog_info *)arg,
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

--opJtzjQTFsWo+cga
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
+Bdd/QX25z0BAA==

--opJtzjQTFsWo+cga--
