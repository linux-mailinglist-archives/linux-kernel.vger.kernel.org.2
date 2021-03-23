Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C33345A43
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCWJCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:02:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:33182 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhCWJCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:02:35 -0400
IronPort-SDR: 3bSrMQWQ5SPAzHcwIlD4rBT/eppnOWrtHM8ra7jiceHnz56+p8m815rR4jp7YXwYNFll6ElZ3f
 issPgZmPeKxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="169771333"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="169771333"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 02:02:35 -0700
IronPort-SDR: TqeGJ2lAFzTmS59TLrHUzpjrf8lBP/4AYg6F+iPcEUQifVVlSb+I+aJHVfCruvcoBiKIl4JP2D
 mdbvKfrC/+9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="375991441"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2021 02:02:33 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lOcvp-0000Si-4N; Tue, 23 Mar 2021 09:02:33 +0000
Date:   Tue, 23 Mar 2021 17:02:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 ebdbd41bf2536ac57bf315ce9690245e08c5e506
Message-ID: <6059ae9a.NVj/z5Z/EaeOXqo9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
branch HEAD: ebdbd41bf2536ac57bf315ce9690245e08c5e506  locking/mutex: Fix non debug version of mutex_lock_io_nested()

elapsed time: 724m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
m68k                       m5208evb_defconfig
arc                         haps_hs_defconfig
powerpc                      katmai_defconfig
sh                   rts7751r2dplus_defconfig
mips                           ip27_defconfig
riscv                    nommu_virt_defconfig
arc                              alldefconfig
arc                          axs103_defconfig
mips                     cu1830-neo_defconfig
sh                         ap325rxa_defconfig
mips                        jmr3927_defconfig
mips                           ip28_defconfig
arm                             mxs_defconfig
riscv                            alldefconfig
sh                        edosk7705_defconfig
sh                                  defconfig
mips                  decstation_64_defconfig
openrisc                 simple_smp_defconfig
riscv                    nommu_k210_defconfig
powerpc                   bluestone_defconfig
m68k                       m5275evb_defconfig
nios2                            alldefconfig
powerpc                 linkstation_defconfig
powerpc                    gamecube_defconfig
arm                           tegra_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc836x_rdk_defconfig
openrisc                         alldefconfig
m68k                       m5249evb_defconfig
mips                        maltaup_defconfig
arm                           omap1_defconfig
i386                                defconfig
arm                       imx_v4_v5_defconfig
arm                         at91_dt_defconfig
powerpc                     ep8248e_defconfig
powerpc                         wii_defconfig
riscv                               defconfig
powerpc                    sam440ep_defconfig
m68k                          hp300_defconfig
sh                           se7724_defconfig
arm                             ezx_defconfig
arm                            qcom_defconfig
m68k                        m5307c3_defconfig
ia64                                defconfig
mips                      pic32mzda_defconfig
sh                        sh7785lcr_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210322
i386                 randconfig-a003-20210322
i386                 randconfig-a001-20210322
i386                 randconfig-a002-20210322
i386                 randconfig-a006-20210322
i386                 randconfig-a005-20210322
x86_64               randconfig-a012-20210322
x86_64               randconfig-a015-20210322
x86_64               randconfig-a013-20210322
x86_64               randconfig-a014-20210322
x86_64               randconfig-a016-20210322
x86_64               randconfig-a011-20210322
i386                 randconfig-a014-20210322
i386                 randconfig-a011-20210322
i386                 randconfig-a015-20210322
i386                 randconfig-a016-20210322
i386                 randconfig-a012-20210322
i386                 randconfig-a013-20210322
riscv                             allnoconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210322
x86_64               randconfig-a003-20210322
x86_64               randconfig-a001-20210322
x86_64               randconfig-a006-20210322
x86_64               randconfig-a004-20210322
x86_64               randconfig-a005-20210322

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
