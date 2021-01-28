Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C3C306B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 03:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhA1CbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 21:31:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:56327 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhA1CbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:31:13 -0500
IronPort-SDR: mhhJ49sc3UDv4bj7UvCrF/7MoXZ8LWPSVRrc4+tl+CHH8MKnvE3pMTYOdU79ZQJ4XTYHCzCJSK
 Pdn/GuK6gRvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="179386903"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="gz'50?scan'50,208,50";a="179386903"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 18:30:31 -0800
IronPort-SDR: nHB4NM7K6QGUxqCJS6HuELbfKivv3Q0NxtOCt81/dd/TzQ5+4svp4G1ZthgTFsX3OwpZKF9tHK
 8pYJYkZbFIVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="gz'50?scan'50,208,50";a="505146023"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2021 18:30:29 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l4x4m-0002HU-Rz; Thu, 28 Jan 2021 02:30:28 +0000
Date:   Thu, 28 Jan 2021 10:29:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:locking/core 1/3] include/linux/syscalls.h:238:18: error:
 conflicting types for 'sys_futex'
Message-ID: <202101281034.2yevf7Rg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
head:   59ea5f1508e15cecddd8e2ca828f7962ea37adab
commit: 3018a08401300005536817507dd14c2a7c4ffa69 [1/3] futex: Change utime parameter to be 'const ... *'
config: nios2-3c120_defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3018a08401300005536817507dd14c2a7c4ffa69
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip locking/core
        git checkout 3018a08401300005536817507dd14c2a7c4ffa69
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/futex.c:37:
>> include/linux/syscalls.h:238:18: error: conflicting types for 'sys_futex'
     238 |  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
         |                  ^~~
   include/linux/syscalls.h:224:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     224 |  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |  ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:218:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     218 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex.c:3792:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    3792 | SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:585:17: note: previous declaration of 'sys_futex' was here
     585 | asmlinkage long sys_futex(u32 __user *uaddr, int op, u32 val,
         |                 ^~~~~~~~~
>> include/linux/syscalls.h:238:18: error: conflicting types for 'sys_futex_time32'
     238 |  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
         |                  ^~~
   include/linux/syscalls.h:224:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     224 |  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |  ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:218:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     218 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex.c:3988:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    3988 | SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:588:17: note: previous declaration of 'sys_futex_time32' was here
     588 | asmlinkage long sys_futex_time32(u32 __user *uaddr, int op, u32 val,
         |                 ^~~~~~~~~~~~~~~~


vim +/sys_futex +238 include/linux/syscalls.h

bed1ffca022cc876 Frederic Weisbecker 2009-03-13  212  
6c5979631b4b03c9 Heiko Carstens      2009-02-11  213  #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
6c5979631b4b03c9 Heiko Carstens      2009-02-11  214  #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
6c5979631b4b03c9 Heiko Carstens      2009-02-11  215  #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
6c5979631b4b03c9 Heiko Carstens      2009-02-11  216  #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
6c5979631b4b03c9 Heiko Carstens      2009-02-11  217  #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
6c5979631b4b03c9 Heiko Carstens      2009-02-11 @218  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
1a94bc34768e463a Heiko Carstens      2009-01-14  219  
609320c8a22715b7 Yonghong Song       2017-09-07  220  #define SYSCALL_DEFINE_MAXARGS	6
609320c8a22715b7 Yonghong Song       2017-09-07  221  
bed1ffca022cc876 Frederic Weisbecker 2009-03-13  222  #define SYSCALL_DEFINEx(x, sname, ...)				\
99e621f796d7f034 Al Viro             2013-03-05  223  	SYSCALL_METADATA(sname, x, __VA_ARGS__)			\
bed1ffca022cc876 Frederic Weisbecker 2009-03-13  224  	__SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
bed1ffca022cc876 Frederic Weisbecker 2009-03-13  225  
2cf0966683430b64 Al Viro             2013-01-21  226  #define __PROTECT(...) asmlinkage_protect(__VA_ARGS__)
1bd21c6c21e84899 Dominik Brodowski   2018-04-05  227  
e145242ea0df6b7d Dominik Brodowski   2018-04-09  228  /*
e145242ea0df6b7d Dominik Brodowski   2018-04-09  229   * The asmlinkage stub is aliased to a function named __se_sys_*() which
e145242ea0df6b7d Dominik Brodowski   2018-04-09  230   * sign-extends 32-bit ints to longs whenever needed. The actual work is
e145242ea0df6b7d Dominik Brodowski   2018-04-09  231   * done within __do_sys_*().
e145242ea0df6b7d Dominik Brodowski   2018-04-09  232   */
1bd21c6c21e84899 Dominik Brodowski   2018-04-05  233  #ifndef __SYSCALL_DEFINEx
bed1ffca022cc876 Frederic Weisbecker 2009-03-13  234  #define __SYSCALL_DEFINEx(x, name, ...)					\
bee20031772af3de Arnd Bergmann       2018-06-19  235  	__diag_push();							\
bee20031772af3de Arnd Bergmann       2018-06-19  236  	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
bee20031772af3de Arnd Bergmann       2018-06-19  237  		      "Type aliasing is used to sanitize syscall arguments");\
83460ec8dcac1414 Andi Kleen          2013-11-12 @238  	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
e145242ea0df6b7d Dominik Brodowski   2018-04-09  239  		__attribute__((alias(__stringify(__se_sys##name))));	\
c9a211951c7c79cf Howard McLauchlan   2018-03-21  240  	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
e145242ea0df6b7d Dominik Brodowski   2018-04-09  241  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
e145242ea0df6b7d Dominik Brodowski   2018-04-09  242  	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
e145242ea0df6b7d Dominik Brodowski   2018-04-09  243  	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
1a94bc34768e463a Heiko Carstens      2009-01-14  244  	{								\
e145242ea0df6b7d Dominik Brodowski   2018-04-09  245  		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
07fe6e00f6cca6fe Al Viro             2013-01-21  246  		__MAP(x,__SC_TEST,__VA_ARGS__);				\
2cf0966683430b64 Al Viro             2013-01-21  247  		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
2cf0966683430b64 Al Viro             2013-01-21  248  		return ret;						\
1a94bc34768e463a Heiko Carstens      2009-01-14  249  	}								\
bee20031772af3de Arnd Bergmann       2018-06-19  250  	__diag_pop();							\
e145242ea0df6b7d Dominik Brodowski   2018-04-09  251  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
1bd21c6c21e84899 Dominik Brodowski   2018-04-05  252  #endif /* __SYSCALL_DEFINEx */
1a94bc34768e463a Heiko Carstens      2009-01-14  253  

:::::: The code at line 238 was first introduced by commit
:::::: 83460ec8dcac14142e7860a01fa59c267ac4657c syscalls.h: use gcc alias instead of assembler aliases for syscalls

:::::: TO: Andi Kleen <ak@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--FL5UXtIhxfXey3p5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
M06mAAA=

--FL5UXtIhxfXey3p5--
