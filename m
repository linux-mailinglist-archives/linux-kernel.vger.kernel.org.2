Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8EE354872
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 00:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbhDEWFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 18:05:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:53072 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232519AbhDEWFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 18:05:02 -0400
IronPort-SDR: ZqXTyWxZx5BwLwDS61g3VUPlAypxLFfOVLXs2Up294NRwIl8qVi+SaVslT+Hglw3gwkM3XLgRA
 yoclN4/cgJrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="278181084"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="278181084"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 15:04:48 -0700
IronPort-SDR: Amr6JAA94opWnZIEnRjucFpBTRaTNuWAx7wwUVrvCVkIn2NikYoepoJYwhUUxpqLi74kKmGZfq
 fPROVE/qD/Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380677856"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 15:04:46 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lTXKv-000Aoh-HI; Mon, 05 Apr 2021 22:04:45 +0000
Date:   Tue, 06 Apr 2021 06:03:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 0cf95a69f165a15bca8e97917222f39b82b5e356
Message-ID: <606b8949.5y5FF+ZDefzAs2+t%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 0cf95a69f165a15bca8e97917222f39b82b5e356  Merge branch 'linus'

elapsed time: 725m

configs tested: 167
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
arm                         cm_x300_defconfig
powerpc                      chrp32_defconfig
arm                           sama5_defconfig
powerpc                          g5_defconfig
m68k                         amcore_defconfig
powerpc                   motionpro_defconfig
arm                         hackkit_defconfig
mips                      pic32mzda_defconfig
arm                     am200epdkit_defconfig
microblaze                      mmu_defconfig
sh                           se7705_defconfig
arm                     davinci_all_defconfig
sh                           se7751_defconfig
sh                           sh2007_defconfig
powerpc                     tqm8540_defconfig
riscv                          rv32_defconfig
mips                           gcw0_defconfig
sh                         ap325rxa_defconfig
arm                         at91_dt_defconfig
mips                             allyesconfig
mips                           rs90_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      obs600_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      cm5200_defconfig
arm                        realview_defconfig
powerpc                    sam440ep_defconfig
arm                           h3600_defconfig
powerpc                     ep8248e_defconfig
arm                        cerfcube_defconfig
mips                      loongson3_defconfig
mips                   sb1250_swarm_defconfig
arc                                 defconfig
arm                        spear6xx_defconfig
sh                         apsh4a3a_defconfig
openrisc                            defconfig
arm                            mmp2_defconfig
sh                             shx3_defconfig
nios2                               defconfig
arm                      tct_hammer_defconfig
mips                      malta_kvm_defconfig
powerpc                     skiroot_defconfig
mips                           ci20_defconfig
sh                               allmodconfig
arm                      integrator_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                  iss476-smp_defconfig
arm                       imx_v4_v5_defconfig
mips                           ip28_defconfig
m68k                       m5249evb_defconfig
h8300                               defconfig
arm                      jornada720_defconfig
powerpc                      ep88xc_defconfig
arm                         palmz72_defconfig
openrisc                  or1klitex_defconfig
arm                       aspeed_g5_defconfig
arm                           spitz_defconfig
mips                       lemote2f_defconfig
sh                           se7780_defconfig
m68k                          hp300_defconfig
arm                       cns3420vb_defconfig
um                             i386_defconfig
arm                            hisi_defconfig
powerpc                     kilauea_defconfig
arm                             pxa_defconfig
sh                        edosk7760_defconfig
powerpc                      ppc40x_defconfig
arm                          ixp4xx_defconfig
sh                           se7721_defconfig
sh                   sh7724_generic_defconfig
m68k                          sun3x_defconfig
mips                      pistachio_defconfig
mips                          ath25_defconfig
sh                          lboxre2_defconfig
powerpc                     akebono_defconfig
openrisc                         alldefconfig
powerpc                     sbc8548_defconfig
sh                          rsk7203_defconfig
sh                          landisk_defconfig
mips                       rbtx49xx_defconfig
mips                      maltasmvp_defconfig
xtensa                  nommu_kc705_defconfig
s390                       zfcpdump_defconfig
mips                           ip27_defconfig
mips                     cu1000-neo_defconfig
powerpc                     mpc83xx_defconfig
mips                malta_kvm_guest_defconfig
arc                        vdk_hs38_defconfig
arm                            qcom_defconfig
arm                       multi_v4t_defconfig
mips                        workpad_defconfig
h8300                     edosk2674_defconfig
powerpc                    klondike_defconfig
mips                          rm200_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210405
i386                 randconfig-a003-20210405
i386                 randconfig-a001-20210405
i386                 randconfig-a004-20210405
i386                 randconfig-a002-20210405
i386                 randconfig-a005-20210405
x86_64               randconfig-a014-20210405
x86_64               randconfig-a015-20210405
x86_64               randconfig-a013-20210405
x86_64               randconfig-a011-20210405
x86_64               randconfig-a012-20210405
x86_64               randconfig-a016-20210405
i386                 randconfig-a014-20210405
i386                 randconfig-a011-20210405
i386                 randconfig-a016-20210405
i386                 randconfig-a012-20210405
i386                 randconfig-a015-20210405
i386                 randconfig-a013-20210405
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a004-20210405
x86_64               randconfig-a003-20210405
x86_64               randconfig-a005-20210405
x86_64               randconfig-a001-20210405
x86_64               randconfig-a002-20210405
x86_64               randconfig-a006-20210405

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
