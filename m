Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E7B45D7EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352039AbhKYKJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:09:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:51005 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354111AbhKYKHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:07:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="298890459"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="298890459"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 02:00:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="607503943"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 25 Nov 2021 02:00:31 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqBYN-0006AV-26; Thu, 25 Nov 2021 10:00:31 +0000
Date:   Thu, 25 Nov 2021 17:59:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mcgrof-next:20211116-sysctl-cleanups-v3 19/20]
 fs/binfmt_misc.c:826:17: error: too few arguments to function 'panic'
Message-ID: <202111251738.XZmLQiGG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20211116-sysctl-cleanups-v3
head:   06113f1d9a2d0669964adfa2e0128bd50e56b621
commit: ef6d1ebb37a8b418ca2a35f5d94d3eb4c93febe5 [19/20] fs: move binfmt_misc sysctl to its own file
config: arm-randconfig-c002-20211116 (https://download.01.org/0day-ci/archive/20211125/202111251738.XZmLQiGG-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=ef6d1ebb37a8b418ca2a35f5d94d3eb4c93febe5
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20211116-sysctl-cleanups-v3
        git checkout ef6d1ebb37a8b418ca2a35f5d94d3eb4c93febe5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/binfmt_misc.c: In function 'init_misc_binfmt':
>> fs/binfmt_misc.c:826:17: error: too few arguments to function 'panic'
     826 |                 panic();
         |                 ^~~~~
   In file included from include/linux/kernel.h:19,
                    from fs/binfmt_misc.c:13:
   include/linux/panic.h:12:6: note: declared here
      12 | void panic(const char *fmt, ...) __noreturn __cold;
         |      ^~~~~
   fs/binfmt_misc.c:827:1: error: control reaches end of non-void function [-Werror=return-type]
     827 | }
         | ^
   cc1: some warnings being treated as errors


vim +/panic +826 fs/binfmt_misc.c

   819	
   820	static int __init init_misc_binfmt(void)
   821	{
   822		int err = register_filesystem(&bm_fs_type);
   823		if (!err)
   824			insert_binfmt(&misc_format);
   825		if (!register_sysctl_mount_point("fs/binfmt_misc"))
 > 826			panic();
   827	}
   828	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
