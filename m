Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB86845E43D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 02:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbhKZCBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:01:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:40176 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236826AbhKZB7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 20:59:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235531467"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235531467"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 17:56:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="539109456"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Nov 2021 17:56:00 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqQT2-0007GG-4g; Fri, 26 Nov 2021 01:56:00 +0000
Date:   Fri, 26 Nov 2021 09:55:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: kernel/module.c:4478:14: warning: variable 'exit' set but not used
Message-ID: <202111260932.G88s9JDN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ced7ca3570333998ad2088d5a6275701970e28e
commit: 0d67e332e6df72f43eaa21228daa3a79e23093f3 module: fix clang CFI with MODULE_UNLOAD=n
date:   8 weeks ago
config: arm64-randconfig-r015-20211123 (https://download.01.org/0day-ci/archive/20211126/202111260932.G88s9JDN-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 49e3838145dff1ec91c2e67a2cb562775c8d2a08)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0d67e332e6df72f43eaa21228daa3a79e23093f3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0d67e332e6df72f43eaa21228daa3a79e23093f3
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/module.c:4478:14: warning: variable 'exit' set but not used [-Wunused-but-set-variable]
           exitcall_t *exit;
                       ^
   1 warning generated.


vim +/exit +4478 kernel/module.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  4473  
cf68fffb66d60d Sami Tolvanen  2021-04-08  4474  static void cfi_init(struct module *mod)
cf68fffb66d60d Sami Tolvanen  2021-04-08  4475  {
cf68fffb66d60d Sami Tolvanen  2021-04-08  4476  #ifdef CONFIG_CFI_CLANG
cf68fffb66d60d Sami Tolvanen  2021-04-08  4477  	initcall_t *init;
cf68fffb66d60d Sami Tolvanen  2021-04-08 @4478  	exitcall_t *exit;
cf68fffb66d60d Sami Tolvanen  2021-04-08  4479  
cf68fffb66d60d Sami Tolvanen  2021-04-08  4480  	rcu_read_lock_sched();
cf68fffb66d60d Sami Tolvanen  2021-04-08  4481  	mod->cfi_check = (cfi_check_fn)
cf68fffb66d60d Sami Tolvanen  2021-04-08  4482  		find_kallsyms_symbol_value(mod, "__cfi_check");
cf68fffb66d60d Sami Tolvanen  2021-04-08  4483  	init = (initcall_t *)
cf68fffb66d60d Sami Tolvanen  2021-04-08  4484  		find_kallsyms_symbol_value(mod, "__cfi_jt_init_module");
cf68fffb66d60d Sami Tolvanen  2021-04-08  4485  	exit = (exitcall_t *)
cf68fffb66d60d Sami Tolvanen  2021-04-08  4486  		find_kallsyms_symbol_value(mod, "__cfi_jt_cleanup_module");
cf68fffb66d60d Sami Tolvanen  2021-04-08  4487  	rcu_read_unlock_sched();
cf68fffb66d60d Sami Tolvanen  2021-04-08  4488  
cf68fffb66d60d Sami Tolvanen  2021-04-08  4489  	/* Fix init/exit functions to point to the CFI jump table */
cf68fffb66d60d Sami Tolvanen  2021-04-08  4490  	if (init)
cf68fffb66d60d Sami Tolvanen  2021-04-08  4491  		mod->init = *init;
0d67e332e6df72 Arnd Bergmann  2021-09-27  4492  #ifdef CONFIG_MODULE_UNLOAD
cf68fffb66d60d Sami Tolvanen  2021-04-08  4493  	if (exit)
cf68fffb66d60d Sami Tolvanen  2021-04-08  4494  		mod->exit = *exit;
0d67e332e6df72 Arnd Bergmann  2021-09-27  4495  #endif
cf68fffb66d60d Sami Tolvanen  2021-04-08  4496  
cf68fffb66d60d Sami Tolvanen  2021-04-08  4497  	cfi_module_add(mod, module_addr_min);
cf68fffb66d60d Sami Tolvanen  2021-04-08  4498  #endif
cf68fffb66d60d Sami Tolvanen  2021-04-08  4499  }
cf68fffb66d60d Sami Tolvanen  2021-04-08  4500  

:::::: The code at line 4478 was first introduced by commit
:::::: cf68fffb66d60d96209446bfc4a15291dc5a5d41 add support for Clang CFI

:::::: TO: Sami Tolvanen <samitolvanen@google.com>
:::::: CC: Kees Cook <keescook@chromium.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
