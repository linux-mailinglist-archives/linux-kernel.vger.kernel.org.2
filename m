Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFDF45D5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 09:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348091AbhKYID5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 03:03:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:31103 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348592AbhKYIB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 03:01:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="234196773"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="234196773"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 23:57:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="675150960"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Nov 2021 23:57:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mq9dG-0005zy-PW; Thu, 25 Nov 2021 07:57:26 +0000
Date:   Thu, 25 Nov 2021 15:57:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mcgrof-next:20211116-sysctl-cleanups-v3 11/20]
 drivers/macintosh/mac_hid.c:246:31: warning: assignment to 'struct
 ctl_table_header *' from 'int' makes pointer from integer without a cast
Message-ID: <202111251523.kkvJodHq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20211116-sysctl-cleanups-v3
head:   06113f1d9a2d0669964adfa2e0128bd50e56b621
commit: 72daf12fc8290df22f4479f912a74c73a6a2fe38 [11/20] macintosh/mac_hid.c: use new sysctl subdir helper register_sysctl_subdir()
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20211125/202111251523.kkvJodHq-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=72daf12fc8290df22f4479f912a74c73a6a2fe38
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20211116-sysctl-cleanups-v3
        git checkout 72daf12fc8290df22f4479f912a74c73a6a2fe38
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/macintosh/mac_hid.c: In function 'mac_hid_init':
   drivers/macintosh/mac_hid.c:246:33: error: implicit declaration of function 'register_sysctl_subdir'; did you mean 'register_sysctl_init'? [-Werror=implicit-function-declaration]
     246 |         mac_hid_sysctl_header = register_sysctl_subdir("dev", "mac_hid",
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 register_sysctl_init
>> drivers/macintosh/mac_hid.c:246:31: warning: assignment to 'struct ctl_table_header *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     246 |         mac_hid_sysctl_header = register_sysctl_subdir("dev", "mac_hid",
         |                               ^
   cc1: some warnings being treated as errors


vim +246 drivers/macintosh/mac_hid.c

   243	
   244	static int __init mac_hid_init(void)
   245	{
 > 246		mac_hid_sysctl_header = register_sysctl_subdir("dev", "mac_hid",
   247							       mac_hid_files);
   248		if (!mac_hid_sysctl_header)
   249			return -ENOMEM;
   250	
   251		return 0;
   252	}
   253	module_init(mac_hid_init);
   254	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
