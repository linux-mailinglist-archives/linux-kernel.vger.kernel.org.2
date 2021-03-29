Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6776534C516
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhC2Hjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:39:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:44748 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231221AbhC2HjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:39:19 -0400
IronPort-SDR: fzadqHiNJ6urBBiLibAEeOaTpU7lUxe8pnqLnvNA8KuYDPhBLjLq9Fgarc6zU73MtSKBEvm9+s
 BQFIbUTKxA8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="252844722"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="252844722"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:39:17 -0700
IronPort-SDR: GNLPJqiDacKRayfjOudITSWpUEAiTDz3dihfPD/xGWO7FLzvWblbru4FeWQ2A1P8uzNI8Wto+O
 RkFmZLIBl0nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="410954114"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Mar 2021 00:39:15 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lQmUU-0004Qj-UF; Mon, 29 Mar 2021 07:39:14 +0000
Date:   Mon, 29 Mar 2021 15:38:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 bd9a5fc2edb0bdcb0756298daa31ddd6a02f0634
Message-ID: <606183fb.ru8IcFwLg0GSvGUM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: bd9a5fc2edb0bdcb0756298daa31ddd6a02f0634  MAINTAINERS: Add myself as futex reviewer

elapsed time: 720m

configs tested: 112
configs skipped: 2

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
arm                       aspeed_g4_defconfig
arm                             pxa_defconfig
sparc                       sparc32_defconfig
ia64                             alldefconfig
powerpc                        icon_defconfig
arc                        nsimosci_defconfig
powerpc                      chrp32_defconfig
arm                       omap2plus_defconfig
sh                          rsk7264_defconfig
riscv                    nommu_virt_defconfig
um                            kunit_defconfig
mips                     cu1830-neo_defconfig
sh                 kfr2r09-romimage_defconfig
mips                           ip32_defconfig
sh                             shx3_defconfig
m68k                          multi_defconfig
mips                        workpad_defconfig
nios2                         10m50_defconfig
powerpc                   lite5200b_defconfig
mips                        nlm_xlp_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                          sdk7780_defconfig
powerpc                 mpc8560_ads_defconfig
sh                          r7785rp_defconfig
sh                         microdev_defconfig
m68k                       bvme6000_defconfig
sh                           se7705_defconfig
arm                         axm55xx_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                         shannon_defconfig
mips                     loongson1b_defconfig
parisc                generic-64bit_defconfig
powerpc                      ppc6xx_defconfig
arm                          ixp4xx_defconfig
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
x86_64               randconfig-a002-20210329
x86_64               randconfig-a003-20210329
x86_64               randconfig-a006-20210329
x86_64               randconfig-a001-20210329
x86_64               randconfig-a005-20210329
x86_64               randconfig-a004-20210329
i386                 randconfig-a003-20210329
i386                 randconfig-a004-20210329
i386                 randconfig-a001-20210329
i386                 randconfig-a002-20210329
i386                 randconfig-a006-20210329
i386                 randconfig-a005-20210329
i386                 randconfig-a014-20210328
i386                 randconfig-a011-20210328
i386                 randconfig-a015-20210328
i386                 randconfig-a016-20210328
i386                 randconfig-a013-20210328
i386                 randconfig-a012-20210328
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210329
x86_64               randconfig-a012-20210329
x86_64               randconfig-a013-20210329
x86_64               randconfig-a014-20210329
x86_64               randconfig-a011-20210329
x86_64               randconfig-a016-20210329

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
