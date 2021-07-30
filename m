Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3243C3DB22F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 06:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhG3ER4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 00:17:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:33532 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhG3ERy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 00:17:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="211145206"
X-IronPort-AV: E=Sophos;i="5.84,280,1620716400"; 
   d="gz'50?scan'50,208,50";a="211145206"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 21:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,280,1620716400"; 
   d="gz'50?scan'50,208,50";a="581698104"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2021 21:17:49 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m9Jy0-0009bu-AP; Fri, 30 Jul 2021 04:17:48 +0000
Date:   Fri, 30 Jul 2021 12:17:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [arnd-playground:asm-generic-uaccess-6 10/10]
 arch/xtensa/kernel/xtensa_ksyms.c:47:15: error: '__strncpy_user' undeclared
 here (not in a function); did you mean '__strnlen_user'?
Message-ID: <202107301252.3kxsyNC7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git asm-generic-uaccess-6
head:   3b678070bb03678466211f4f13b156fbae62b0db
commit: 3b678070bb03678466211f4f13b156fbae62b0db [10/10] asm-generic: reverse GENERIC_{STRNCPY_FROM,STRNLEN}_USER symbols
config: xtensa-common_defconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=3b678070bb03678466211f4f13b156fbae62b0db
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground asm-generic-uaccess-6
        git checkout 3b678070bb03678466211f4f13b156fbae62b0db
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from arch/xtensa/kernel/xtensa_ksyms.c:15:
>> arch/xtensa/kernel/xtensa_ksyms.c:47:15: error: '__strncpy_user' undeclared here (not in a function); did you mean '__strnlen_user'?
      47 | EXPORT_SYMBOL(__strncpy_user);
         |               ^~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:160:34: note: in expansion of macro '__EXPORT_SYMBOL'
     160 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:163:29: note: in expansion of macro '_EXPORT_SYMBOL'
     163 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   arch/xtensa/kernel/xtensa_ksyms.c:47:1: note: in expansion of macro 'EXPORT_SYMBOL'
      47 | EXPORT_SYMBOL(__strncpy_user);
         | ^~~~~~~~~~~~~
   arch/xtensa/kernel/xtensa_ksyms.c:83:6: warning: no previous prototype for '__xtensa_libgcc_window_spill' [-Wmissing-prototypes]
      83 | void __xtensa_libgcc_window_spill(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +47 arch/xtensa/kernel/xtensa_ksyms.c

5a0015d62668e6 Chris Zankel 2005-06-23  35  
5a0015d62668e6 Chris Zankel 2005-06-23  36  
5a0015d62668e6 Chris Zankel 2005-06-23  37  /*
5a0015d62668e6 Chris Zankel 2005-06-23  38   * String functions
5a0015d62668e6 Chris Zankel 2005-06-23  39   */
5a0015d62668e6 Chris Zankel 2005-06-23  40  EXPORT_SYMBOL(memset);
5a0015d62668e6 Chris Zankel 2005-06-23  41  EXPORT_SYMBOL(memcpy);
5a0015d62668e6 Chris Zankel 2005-06-23  42  EXPORT_SYMBOL(memmove);
c633544a615414 Max Filippov 2017-12-03  43  EXPORT_SYMBOL(__memset);
c633544a615414 Max Filippov 2017-12-03  44  EXPORT_SYMBOL(__memcpy);
c633544a615414 Max Filippov 2017-12-03  45  EXPORT_SYMBOL(__memmove);
57358ba9564a05 Max Filippov 2017-12-17  46  #ifndef CONFIG_GENERIC_STRNCPY_FROM_USER
d3738f407c8ced Max Filippov 2012-09-17 @47  EXPORT_SYMBOL(__strncpy_user);
57358ba9564a05 Max Filippov 2017-12-17  48  #endif
d3738f407c8ced Max Filippov 2012-09-17  49  EXPORT_SYMBOL(clear_page);
d3738f407c8ced Max Filippov 2012-09-17  50  EXPORT_SYMBOL(copy_page);
5a0015d62668e6 Chris Zankel 2005-06-23  51  

:::::: The code at line 47 was first introduced by commit
:::::: d3738f407c8ced4fd17dccf6cce729023c735c73 xtensa: add missing symbol exports

:::::: TO: Max Filippov <jcmvbkbc@gmail.com>
:::::: CC: Chris Zankel <chris@zankel.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--7JfCtLOvnd9MIVvH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--7JfCtLOvnd9MIVvH--
