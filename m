Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31B45D4F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347751AbhKYGwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:52:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:24478 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhKYGuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:50:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="298858882"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="298858882"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 22:44:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="497957878"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Nov 2021 22:44:24 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mq8UZ-0005uM-Qp; Thu, 25 Nov 2021 06:44:23 +0000
Date:   Thu, 25 Nov 2021 14:44:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mcgrof-next:20211116-sysctl-cleanups-v3 9/20]
 drivers/char/hpet.c:1044:23: warning: assignment to 'struct ctl_table_header
 *' from 'int' makes pointer from integer without a cast
Message-ID: <202111251417.kSQaTZ8j-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20211116-sysctl-cleanups-v3
head:   06113f1d9a2d0669964adfa2e0128bd50e56b621
commit: 766042fb8971eaa61f89cdf9b340e602ad6bc7ef [9/20] hpet: use new sysctl subdir helper register_sysctl_subdir()
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20211125/202111251417.kSQaTZ8j-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=766042fb8971eaa61f89cdf9b340e602ad6bc7ef
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20211116-sysctl-cleanups-v3
        git checkout 766042fb8971eaa61f89cdf9b340e602ad6bc7ef
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/char/hpet.c: In function 'hpet_init':
   drivers/char/hpet.c:1044:25: error: implicit declaration of function 'register_sysctl_subdir'; did you mean 'register_sysctl_init'? [-Werror=implicit-function-declaration]
    1044 |         sysctl_header = register_sysctl_subdir("dev", "hpet", hpet_table);
         |                         ^~~~~~~~~~~~~~~~~~~~~~
         |                         register_sysctl_init
>> drivers/char/hpet.c:1044:23: warning: assignment to 'struct ctl_table_header *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1044 |         sysctl_header = register_sysctl_subdir("dev", "hpet", hpet_table);
         |                       ^
   cc1: some warnings being treated as errors


vim +1044 drivers/char/hpet.c

  1035	
  1036	static int __init hpet_init(void)
  1037	{
  1038		int result;
  1039	
  1040		result = misc_register(&hpet_misc);
  1041		if (result < 0)
  1042			return -ENODEV;
  1043	
> 1044		sysctl_header = register_sysctl_subdir("dev", "hpet", hpet_table);
  1045	
  1046		result = acpi_bus_register_driver(&hpet_acpi_driver);
  1047		if (result < 0) {
  1048			if (sysctl_header)
  1049				unregister_sysctl_table(sysctl_header);
  1050			misc_deregister(&hpet_misc);
  1051			return result;
  1052		}
  1053	
  1054		return 0;
  1055	}
  1056	device_initcall(hpet_init);
  1057	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
