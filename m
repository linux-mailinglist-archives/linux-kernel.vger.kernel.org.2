Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7234821C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhCXTll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:41:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:58063 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238052AbhCXTlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:41:07 -0400
IronPort-SDR: O8Y1nWuMBECIJKk5wCRS0KcX18s84wOwiXOhPRIcELoReMJ1grluMhj0vsFLUUSGmHwgX2TX//
 1V0e6wbQi4uA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190199890"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190199890"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 12:41:04 -0700
IronPort-SDR: BK2f6QUcSsDcoIX0T4cCIj053jqHVsb1ZgnDcUFprXPJnw78fC7wglVqtH4NEaHmrC+pQnA7MT
 +xx8kIOjFyug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="452725755"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Mar 2021 12:41:03 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lP9NG-0001T9-A2; Wed, 24 Mar 2021 19:41:02 +0000
Date:   Thu, 25 Mar 2021 03:40:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD REGRESSION
 5965a7adbd72dd9b288c0911cb73719fed1efa08
Message-ID: <605b95aa.aPo9oZ5lUAdhYVGe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 5965a7adbd72dd9b288c0911cb73719fed1efa08  locking/mutex: Remove repeated declaration

Error/Warning reports:

https://lore.kernel.org/lkml/202103241805.DpvaOjQh-lkp@intel.com

Error/Warning in current branch:

kernel/rcu/../locking/rtmutex_common.h:58:10: error: invalid operands to binary expression ('void' and 'void *')
kernel/rcu/../locking/rtmutex_common.h:58:28: error: no member named 'pi_waiters' in 'struct task_struct'

Error/Warning ids grouped by kconfigs:

clang_recent_errors
`-- s390-randconfig-r034-20210324
    |-- kernel-rcu-..-locking-rtmutex_common.h:error:invalid-operands-to-binary-expression-(-void-and-void-)
    `-- kernel-rcu-..-locking-rtmutex_common.h:error:no-member-named-pi_waiters-in-struct-task_struct

elapsed time: 723m

configs tested: 131
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0287_defconfig
sh                ecovec24-romimage_defconfig
mips                        qi_lb60_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                         ap325rxa_defconfig
mips                         bigsur_defconfig
m68k                        m5407c3_defconfig
arm                            hisi_defconfig
arm                        vexpress_defconfig
m68k                       m5208evb_defconfig
mips                     cu1000-neo_defconfig
powerpc                     ksi8560_defconfig
arm                            mps2_defconfig
mips                  cavium_octeon_defconfig
arm                       imx_v4_v5_defconfig
powerpc64                           defconfig
m68k                        mvme147_defconfig
powerpc                    socrates_defconfig
nds32                             allnoconfig
arm                       imx_v6_v7_defconfig
arm                        neponset_defconfig
sh                            hp6xx_defconfig
arm                         orion5x_defconfig
powerpc                     redwood_defconfig
powerpc                      cm5200_defconfig
powerpc                      katmai_defconfig
powerpc                     ppa8548_defconfig
arm                      tct_hammer_defconfig
mips                      malta_kvm_defconfig
arm                           stm32_defconfig
riscv                               defconfig
openrisc                            defconfig
parisc                generic-32bit_defconfig
arm                        multi_v5_defconfig
mips                            e55_defconfig
arm                          pxa910_defconfig
mips                        workpad_defconfig
mips                     cu1830-neo_defconfig
arm                        shmobile_defconfig
powerpc                     ep8248e_defconfig
powerpc                      makalu_defconfig
arm                        spear3xx_defconfig
arm                             pxa_defconfig
powerpc                     tqm8555_defconfig
powerpc                       eiger_defconfig
arm                          pxa168_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nios2                            allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
parisc                              defconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210323
x86_64               randconfig-a006-20210323
x86_64               randconfig-a001-20210323
i386                 randconfig-a004-20210324
i386                 randconfig-a003-20210324
i386                 randconfig-a001-20210324
i386                 randconfig-a002-20210324
i386                 randconfig-a006-20210324
i386                 randconfig-a005-20210324
i386                 randconfig-a003-20210323
i386                 randconfig-a004-20210323
i386                 randconfig-a001-20210323
i386                 randconfig-a002-20210323
i386                 randconfig-a006-20210323
i386                 randconfig-a005-20210323
i386                 randconfig-a014-20210324
i386                 randconfig-a015-20210324
i386                 randconfig-a016-20210324
i386                 randconfig-a011-20210324
i386                 randconfig-a013-20210324
i386                 randconfig-a012-20210324
x86_64               randconfig-a003-20210323
x86_64               randconfig-a004-20210323
x86_64               randconfig-a005-20210323
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210324
x86_64               randconfig-a003-20210324
x86_64               randconfig-a001-20210324
x86_64               randconfig-a006-20210324
x86_64               randconfig-a005-20210324
x86_64               randconfig-a004-20210324
x86_64               randconfig-a012-20210323
x86_64               randconfig-a015-20210323
x86_64               randconfig-a013-20210323
x86_64               randconfig-a014-20210323
x86_64               randconfig-a011-20210323
x86_64               randconfig-a016-20210323

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
