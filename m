Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D376F3D0256
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 21:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhGTTKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 15:10:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:33210 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231404AbhGTTKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 15:10:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="272433046"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="gz'50?scan'50,208,50";a="272433046"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 12:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="gz'50?scan'50,208,50";a="432285054"
Received: from lkp-server02.sh.intel.com (HELO 1b5a72ed9419) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jul 2021 12:51:00 -0700
Received: from kbuild by 1b5a72ed9419 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5vlc-0000NN-BD; Tue, 20 Jul 2021 19:51:00 +0000
Date:   Wed, 21 Jul 2021 03:50:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arnd-playground:asm-generic-uaccess-4 1/7]
 arch/um/kernel/skas/uaccess.c:211:15: error: '__strncpy_from_user'
 undeclared here (not in a function); did you mean 'strncpy_from_user'?
Message-ID: <202107210320.SCJ12EAT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git asm-generic-uaccess-4
head:   d7d80410412f516869e09904cffd817acaeec742
commit: d6c30cddd046b12ea68ec67c50bac29cae3da28c [1/7] asm-generic/uaccess.h: remove __strncpy_from_user/__strnlen_user
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=d6c30cddd046b12ea68ec67c50bac29cae3da28c
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground asm-generic-uaccess-4
        git checkout d6c30cddd046b12ea68ec67c50bac29cae3da28c
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/linkage.h:7,
                    from include/linux/fs.h:5,
                    from include/linux/highmem.h:5,
                    from arch/um/kernel/skas/uaccess.c:7:
>> arch/um/kernel/skas/uaccess.c:211:15: error: '__strncpy_from_user' undeclared here (not in a function); did you mean 'strncpy_from_user'?
     211 | EXPORT_SYMBOL(__strncpy_from_user);
         |               ^~~~~~~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:160:34: note: in expansion of macro '__EXPORT_SYMBOL'
     160 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:163:29: note: in expansion of macro '_EXPORT_SYMBOL'
     163 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   arch/um/kernel/skas/uaccess.c:211:1: note: in expansion of macro 'EXPORT_SYMBOL'
     211 | EXPORT_SYMBOL(__strncpy_from_user);
         | ^~~~~~~~~~~~~
>> arch/um/kernel/skas/uaccess.c:242:6: warning: no previous prototype for '__strnlen_user' [-Wmissing-prototypes]
     242 | long __strnlen_user(const void __user *str, long len)
         |      ^~~~~~~~~~~~~~


vim +211 arch/um/kernel/skas/uaccess.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  191  
d6c30cddd046b1 Arnd Bergmann      2020-01-16  192  long strncpy_from_user(char *dst, const char __user *src, long count)
^1da177e4c3f41 Linus Torvalds     2005-04-16  193  {
f8d65d27e677da Richard Weinberger 2015-05-12  194  	long n;
^1da177e4c3f41 Linus Torvalds     2005-04-16  195  	char *ptr = dst;
^1da177e4c3f41 Linus Torvalds     2005-04-16  196  
d6c30cddd046b1 Arnd Bergmann      2020-01-16  197  	if (!access_ok(src, 1))
d6c30cddd046b1 Arnd Bergmann      2020-01-16  198  		return -EFAULT;
d6c30cddd046b1 Arnd Bergmann      2020-01-16  199  
db68ce10c4f0a2 Al Viro            2017-03-20  200  	if (uaccess_kernel()) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  201  		strncpy(dst, (__force void *) src, count);
8ca842c4b5cbc7 Jeff Dike          2007-10-16  202  		return strnlen(dst, count);
^1da177e4c3f41 Linus Torvalds     2005-04-16  203  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  204  
^1da177e4c3f41 Linus Torvalds     2005-04-16  205  	n = buffer_op((unsigned long) src, count, 0, strncpy_chunk_from_user,
^1da177e4c3f41 Linus Torvalds     2005-04-16  206  		      &ptr);
^1da177e4c3f41 Linus Torvalds     2005-04-16  207  	if (n != 0)
8ca842c4b5cbc7 Jeff Dike          2007-10-16  208  		return -EFAULT;
8ca842c4b5cbc7 Jeff Dike          2007-10-16  209  	return strnlen(dst, count);
^1da177e4c3f41 Linus Torvalds     2005-04-16  210  }
f8d65d27e677da Richard Weinberger 2015-05-12 @211  EXPORT_SYMBOL(__strncpy_from_user);
^1da177e4c3f41 Linus Torvalds     2005-04-16  212  
^1da177e4c3f41 Linus Torvalds     2005-04-16  213  static int clear_chunk(unsigned long addr, int len, void *unused)
^1da177e4c3f41 Linus Torvalds     2005-04-16  214  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  215  	memset((void *) addr, 0, len);
8ca842c4b5cbc7 Jeff Dike          2007-10-16  216  	return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  217  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  218  
f8d65d27e677da Richard Weinberger 2015-05-12  219  unsigned long __clear_user(void __user *mem, unsigned long len)
^1da177e4c3f41 Linus Torvalds     2005-04-16  220  {
db68ce10c4f0a2 Al Viro            2017-03-20  221  	if (uaccess_kernel()) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  222  		memset((__force void*)mem, 0, len);
8ca842c4b5cbc7 Jeff Dike          2007-10-16  223  		return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  224  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  225  
f8d65d27e677da Richard Weinberger 2015-05-12  226  	return buffer_op((unsigned long) mem, len, 1, clear_chunk, NULL);
^1da177e4c3f41 Linus Torvalds     2005-04-16  227  }
f8d65d27e677da Richard Weinberger 2015-05-12  228  EXPORT_SYMBOL(__clear_user);
^1da177e4c3f41 Linus Torvalds     2005-04-16  229  
^1da177e4c3f41 Linus Torvalds     2005-04-16  230  static int strnlen_chunk(unsigned long str, int len, void *arg)
^1da177e4c3f41 Linus Torvalds     2005-04-16  231  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  232  	int *len_ptr = arg, n;
^1da177e4c3f41 Linus Torvalds     2005-04-16  233  
^1da177e4c3f41 Linus Torvalds     2005-04-16  234  	n = strnlen((void *) str, len);
^1da177e4c3f41 Linus Torvalds     2005-04-16  235  	*len_ptr += n;
^1da177e4c3f41 Linus Torvalds     2005-04-16  236  
^1da177e4c3f41 Linus Torvalds     2005-04-16  237  	if (n < len)
8ca842c4b5cbc7 Jeff Dike          2007-10-16  238  		return 1;
8ca842c4b5cbc7 Jeff Dike          2007-10-16  239  	return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  240  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  241  
f8d65d27e677da Richard Weinberger 2015-05-12 @242  long __strnlen_user(const void __user *str, long len)
^1da177e4c3f41 Linus Torvalds     2005-04-16  243  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  244  	int count = 0, n;
^1da177e4c3f41 Linus Torvalds     2005-04-16  245  
db68ce10c4f0a2 Al Viro            2017-03-20  246  	if (uaccess_kernel())
8ca842c4b5cbc7 Jeff Dike          2007-10-16  247  		return strnlen((__force char*)str, len) + 1;
^1da177e4c3f41 Linus Torvalds     2005-04-16  248  
^1da177e4c3f41 Linus Torvalds     2005-04-16  249  	n = buffer_op((unsigned long) str, len, 0, strnlen_chunk, &count);
^1da177e4c3f41 Linus Torvalds     2005-04-16  250  	if (n == 0)
8ca842c4b5cbc7 Jeff Dike          2007-10-16  251  		return count + 1;
3179ce7254ffa4 Richard Weinberger 2013-05-11  252  	return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  253  }
f8d65d27e677da Richard Weinberger 2015-05-12  254  EXPORT_SYMBOL(__strnlen_user);
dd3035a21ba7cc Anton Ivanov       2021-03-12  255  

:::::: The code at line 211 was first introduced by commit
:::::: f8d65d27e677da0ce33de570e3068308a77ed2b1 um: Rework uaccess code

:::::: TO: Richard Weinberger <richard@nod.at>
:::::: CC: Richard Weinberger <richard@nod.at>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--YZ5djTAD1cGYuMQK
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--YZ5djTAD1cGYuMQK--
