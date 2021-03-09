Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A28B331D00
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 03:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhCIC2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 21:28:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:28627 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhCIC2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 21:28:47 -0500
IronPort-SDR: B0Iz4WU4L9MKBxnLbdsXZH/PqKMvlFwFaedE09oOpdABxohe7dxtE55J2K4rXhFDbrqU5AP23o
 VL3FfAn4vcew==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175754696"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="175754696"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 18:28:46 -0800
IronPort-SDR: 2Q7EtcDYrqYSYbzIQUxF9rRJHM2D2JRp5EqIjkeoZ3IlhPrR7KAZrj27DpKIfZlmlmD25ZaaII
 uvXnzX2C8KpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="386065267"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Mar 2021 18:28:45 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lJS73-0001Jm-5G; Tue, 09 Mar 2021 02:28:45 +0000
Date:   Tue, 09 Mar 2021 10:27:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 d0962f2b24c99889a386f0658c71535f56358f77
Message-ID: <6046dd29.uxmGdXsEHiYzdHel%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: d0962f2b24c99889a386f0658c71535f56358f77  x86/entry/32: Remove leftover macros after stackprotector cleanups

elapsed time: 726m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                         ap325rxa_defconfig
m68k                       m5208evb_defconfig
powerpc                       ppc64_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           ci20_defconfig
sh                          rsk7201_defconfig
m68k                       m5249evb_defconfig
sh                        apsh4ad0a_defconfig
mips                          ath79_defconfig
powerpc                  mpc885_ads_defconfig
nds32                            alldefconfig
parisc                generic-32bit_defconfig
sh                          lboxre2_defconfig
sh                          rsk7203_defconfig
powerpc                          g5_defconfig
sh                           se7619_defconfig
powerpc                        cell_defconfig
arm                           corgi_defconfig
arm                     eseries_pxa_defconfig
sh                        edosk7760_defconfig
arm                             rpc_defconfig
arm                        mvebu_v7_defconfig
powerpc                     stx_gp3_defconfig
arm                            qcom_defconfig
arm                        realview_defconfig
arm                  colibri_pxa270_defconfig
arc                     nsimosci_hs_defconfig
arm                         nhk8815_defconfig
h8300                       h8s-sim_defconfig
powerpc                      mgcoge_defconfig
sh                             sh03_defconfig
mips                       capcella_defconfig
xtensa                  audio_kc705_defconfig
arm                       omap2plus_defconfig
nds32                               defconfig
arm                       mainstone_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                         microdev_defconfig
openrisc                 simple_smp_defconfig
arm                       aspeed_g4_defconfig
m68k                          hp300_defconfig
sh                            titan_defconfig
powerpc                       holly_defconfig
mips                       bmips_be_defconfig
xtensa                  nommu_kc705_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210308
x86_64               randconfig-a001-20210308
x86_64               randconfig-a004-20210308
x86_64               randconfig-a002-20210308
x86_64               randconfig-a005-20210308
x86_64               randconfig-a003-20210308
i386                 randconfig-a005-20210308
i386                 randconfig-a003-20210308
i386                 randconfig-a002-20210308
i386                 randconfig-a006-20210308
i386                 randconfig-a004-20210308
i386                 randconfig-a001-20210308
i386                 randconfig-a016-20210308
i386                 randconfig-a012-20210308
i386                 randconfig-a014-20210308
i386                 randconfig-a013-20210308
i386                 randconfig-a011-20210308
i386                 randconfig-a015-20210308
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210308
x86_64               randconfig-a016-20210308
x86_64               randconfig-a015-20210308
x86_64               randconfig-a014-20210308
x86_64               randconfig-a011-20210308
x86_64               randconfig-a012-20210308

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
