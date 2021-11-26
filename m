Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378D845EBDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353160AbhKZKqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:46:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:27408 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245488AbhKZKoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:44:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="216354063"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="216354063"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 02:36:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="572093129"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2021 02:36:25 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqYae-0007xy-C6; Fri, 26 Nov 2021 10:36:24 +0000
Date:   Fri, 26 Nov 2021 18:36:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Min Li <min.li.xe@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: powerpc-linux-ld: warning: orphan section `.init.plt' from
 `drivers/mfd/rsmu_core.o' being placed in section `.init.plt'
Message-ID: <202111261824.M3qMRnY5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Min,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4849f6000e29235a2707f22e39da6b897bb9543
commit: a1867f85e06edacd82956d3422caa2b9074f4321 mfd: Add Renesas Synchronization Management Unit (SMU) support
date:   5 months ago
config: powerpc-randconfig-r034-20211123 (https://download.01.org/0day-ci/archive/20211126/202111261824.M3qMRnY5-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1867f85e06edacd82956d3422caa2b9074f4321
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a1867f85e06edacd82956d3422caa2b9074f4321
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/mfd/rsmu_core.o' being placed in section `.init.plt'
   powerpc-linux-ld: arch/powerpc/sysdev/cpm_gpio.o:(.rodata+0xd0): undefined reference to `cpm1_gpiochip_add16'
   powerpc-linux-ld: arch/powerpc/sysdev/cpm_gpio.o:(.rodata+0x194): undefined reference to `cpm1_gpiochip_add32'
   powerpc-linux-ld: arch/powerpc/sysdev/cpm_gpio.o:(.rodata+0x258): undefined reference to `cpm1_gpiochip_add16'
   powerpc-linux-ld: arch/powerpc/sysdev/cpm_gpio.o:(.rodata+0x31c): undefined reference to `cpm1_gpiochip_add16'
   powerpc-linux-ld: arch/powerpc/platforms/8xx/m8xx_setup.o: in function `cpm_cascade':
   m8xx_setup.c:(.text+0x28): undefined reference to `cpm_get_irq'
   powerpc-linux-ld: arch/powerpc/platforms/8xx/m8xx_setup.o: in function `mpc8xx_set_rtc_time':
   m8xx_setup.c:(.text+0x46): undefined reference to `mpc8xx_immr'
   powerpc-linux-ld: m8xx_setup.c:(.text+0x52): undefined reference to `mpc8xx_immr'
   powerpc-linux-ld: arch/powerpc/platforms/8xx/m8xx_setup.o: in function `mpc8xx_get_rtc_time':
   m8xx_setup.c:(.text+0x92): undefined reference to `mpc8xx_immr'
   powerpc-linux-ld: m8xx_setup.c:(.text+0x9e): undefined reference to `mpc8xx_immr'
   powerpc-linux-ld: arch/powerpc/platforms/8xx/m8xx_setup.o: in function `mpc8xx_restart':
   m8xx_setup.c:(.text+0xda): undefined reference to `mpc8xx_immr'
   powerpc-linux-ld: arch/powerpc/platforms/8xx/m8xx_setup.o:m8xx_setup.c:(.text+0xe6): more undefined references to `mpc8xx_immr' follow
   powerpc-linux-ld: arch/powerpc/platforms/8xx/m8xx_setup.o: in function `mpc8xx_pics_init':
   m8xx_setup.c:(.init.text+0x2c8): undefined reference to `cpm_pic_init'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
