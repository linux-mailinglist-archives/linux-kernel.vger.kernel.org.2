Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C434234109B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 00:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhCRXDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 19:03:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:58303 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhCRXC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 19:02:58 -0400
IronPort-SDR: FIGjvTsoR1WujhiTrYw3gyVx1YCfR/M8D2/6kgv8NPQXqA8dLdJ6UuF98X7e0xVlT43EPYgWpe
 5xQDSVLQfZbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="189162050"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="189162050"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 16:02:58 -0700
IronPort-SDR: 1lJ/eQL20xcn9u5UvJZGugrzQFU4iqnqo8oIcgMTtknwwgcYRE2kNg5q+FMO0VNIIA8k9dwLIP
 k+mxoOzkJWxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="413276575"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2021 16:02:56 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lN1fM-0001T6-5j; Thu, 18 Mar 2021 23:02:56 +0000
Date:   Fri, 19 Mar 2021 07:02:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 44511ab344c755d1f216bf421e92fbc2777e87fe
Message-ID: <6053dc00.bEm/qGyGigLV62TL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 44511ab344c755d1f216bf421e92fbc2777e87fe  time/debug: Remove dentry pointer for debugfs

elapsed time: 723m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                       omap2plus_defconfig
powerpc                 mpc8560_ads_defconfig
sh                        apsh4ad0a_defconfig
s390                             alldefconfig
riscv                             allnoconfig
arm                        clps711x_defconfig
sparc                            alldefconfig
powerpc                        icon_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                    socrates_defconfig
arm                         assabet_defconfig
h8300                    h8300h-sim_defconfig
mips                  decstation_64_defconfig
arm                         nhk8815_defconfig
xtensa                    xip_kc705_defconfig
sh                         apsh4a3a_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     skiroot_defconfig
arm                     davinci_all_defconfig
sh                           se7750_defconfig
mips                  maltasmvp_eva_defconfig
mips                        qi_lb60_defconfig
xtensa                           alldefconfig
mips                     decstation_defconfig
arm                          exynos_defconfig
mips                            gpr_defconfig
arm                       multi_v4t_defconfig
arm                          moxart_defconfig
powerpc                    klondike_defconfig
sh                            migor_defconfig
riscv                          rv32_defconfig
sh                     magicpanelr2_defconfig
sh                          rsk7269_defconfig
mips                          rm200_defconfig
mips                     cu1000-neo_defconfig
powerpc                     tqm8560_defconfig
arm                          pxa910_defconfig
arm                          simpad_defconfig
m68k                       m5475evb_defconfig
sh                             espt_defconfig
powerpc                      ppc44x_defconfig
arm                           sama5_defconfig
arc                            hsdk_defconfig
mips                        nlm_xlp_defconfig
sh                             sh03_defconfig
sh                               j2_defconfig
mips                        jmr3927_defconfig
powerpc                      makalu_defconfig
sh                           se7722_defconfig
arm                            lart_defconfig
arm                         lpc32xx_defconfig
ia64                         bigsur_defconfig
sh                           se7780_defconfig
ia64                             allmodconfig
ia64                                defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210318
i386                 randconfig-a005-20210318
i386                 randconfig-a003-20210318
i386                 randconfig-a002-20210318
i386                 randconfig-a006-20210318
i386                 randconfig-a004-20210318
x86_64               randconfig-a011-20210318
x86_64               randconfig-a016-20210318
x86_64               randconfig-a013-20210318
x86_64               randconfig-a015-20210318
x86_64               randconfig-a014-20210318
x86_64               randconfig-a012-20210318
i386                 randconfig-a013-20210318
i386                 randconfig-a016-20210318
i386                 randconfig-a011-20210318
i386                 randconfig-a014-20210318
i386                 randconfig-a015-20210318
i386                 randconfig-a012-20210318
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210318
x86_64               randconfig-a001-20210318
x86_64               randconfig-a005-20210318
x86_64               randconfig-a002-20210318
x86_64               randconfig-a003-20210318
x86_64               randconfig-a004-20210318

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
