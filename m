Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9679245EF14
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245728AbhKZN1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:27:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:33099 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232187AbhKZNZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:25:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="259566139"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="259566139"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 05:11:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="607863687"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2021 05:10:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqb0F-000895-3H; Fri, 26 Nov 2021 13:10:59 +0000
Date:   Fri, 26 Nov 2021 21:10:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tglx-devel:msi 90/101] legacy.c:undefined reference to
 `msi_device_populate_sysfs'
Message-ID: <202111262105.6xBC0RW6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi
head:   1bd31f3b9bc0cc3328fe9030a6b240ac1772d60a
commit: 56feb45643467df8db6a3b57cb07fb4b1f4a1505 [90/101] genirq/msi: Simplify sysfs handling
config: ia64-defconfig (https://download.01.org/0day-ci/archive/20211126/202111262105.6xBC0RW6-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=56feb45643467df8db6a3b57cb07fb4b1f4a1505
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel msi
        git checkout 56feb45643467df8db6a3b57cb07fb4b1f4a1505
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/pci/msi/legacy.o: in function `pci_msi_legacy_setup_msi_irqs':
>> legacy.c:(.text+0x2b2): undefined reference to `msi_device_populate_sysfs'
   ia64-linux-ld: drivers/pci/msi/legacy.o: in function `pci_msi_legacy_teardown_msi_irqs':
>> legacy.c:(.text+0x392): undefined reference to `msi_device_destroy_sysfs'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
