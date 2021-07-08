Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC163C19B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 21:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhGHTUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 15:20:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:7531 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhGHTUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 15:20:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="231340869"
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="231340869"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 12:17:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="487774382"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jul 2021 12:17:49 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m1ZWs-000ESE-L0; Thu, 08 Jul 2021 19:17:46 +0000
Date:   Fri, 09 Jul 2021 03:16:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 dd28e0c352c025765370ab4a3a302d7701b4b2f5
Message-ID: <60e74f1c.gcBK1I29Zwp0lNvG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: dd28e0c352c025765370ab4a3a302d7701b4b2f5  Merge branch 'WIP/fixes'

elapsed time: 727m

configs tested: 157
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7269_defconfig
arm                   milbeaut_m10v_defconfig
arm                         mv78xx0_defconfig
mips                        bcm63xx_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      chrp32_defconfig
mips                     cu1830-neo_defconfig
arm                          ixp4xx_defconfig
powerpc                  iss476-smp_defconfig
h8300                       h8s-sim_defconfig
sparc64                          alldefconfig
arm                     am200epdkit_defconfig
xtensa                  audio_kc705_defconfig
arm                            mps2_defconfig
arm                           sunxi_defconfig
sh                          kfr2r09_defconfig
arc                      axs103_smp_defconfig
sh                          sdk7786_defconfig
riscv                          rv32_defconfig
powerpc                     kilauea_defconfig
um                             i386_defconfig
powerpc                         ps3_defconfig
powerpc                    sam440ep_defconfig
arm                           corgi_defconfig
powerpc                          allmodconfig
arm                  colibri_pxa270_defconfig
mips                         cobalt_defconfig
powerpc                   bluestone_defconfig
mips                          rb532_defconfig
sh                              ul2_defconfig
mips                      maltaaprp_defconfig
sh                          lboxre2_defconfig
mips                     loongson2k_defconfig
sh                           se7724_defconfig
arc                        nsim_700_defconfig
arm                         vf610m4_defconfig
arm                          imote2_defconfig
mips                         rt305x_defconfig
xtensa                generic_kc705_defconfig
sh                           se7751_defconfig
arm                       versatile_defconfig
sh                         ecovec24_defconfig
m68k                        stmark2_defconfig
mips                  cavium_octeon_defconfig
arm                     eseries_pxa_defconfig
powerpc                      pasemi_defconfig
arm                             mxs_defconfig
sh                           se7712_defconfig
sh                        edosk7705_defconfig
powerpc                     tqm8541_defconfig
sh                           se7722_defconfig
mips                           xway_defconfig
sh                           sh2007_defconfig
arm                         cm_x300_defconfig
m68k                         apollo_defconfig
m68k                         amcore_defconfig
sh                        dreamcast_defconfig
sh                            migor_defconfig
arm                           h3600_defconfig
arm                           u8500_defconfig
arm                        mvebu_v7_defconfig
sh                            hp6xx_defconfig
powerpc                     akebono_defconfig
arm                       cns3420vb_defconfig
m68k                           sun3_defconfig
csky                             alldefconfig
powerpc                     mpc512x_defconfig
powerpc                 mpc834x_mds_defconfig
x86_64                            allnoconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210707
x86_64               randconfig-a002-20210707
x86_64               randconfig-a005-20210707
x86_64               randconfig-a006-20210707
x86_64               randconfig-a003-20210707
x86_64               randconfig-a001-20210707
i386                 randconfig-a006-20210708
i386                 randconfig-a004-20210708
i386                 randconfig-a001-20210708
i386                 randconfig-a003-20210708
i386                 randconfig-a005-20210708
i386                 randconfig-a002-20210708
i386                 randconfig-a004-20210707
i386                 randconfig-a006-20210707
i386                 randconfig-a001-20210707
i386                 randconfig-a003-20210707
i386                 randconfig-a005-20210707
i386                 randconfig-a002-20210707
i386                 randconfig-a015-20210707
i386                 randconfig-a016-20210707
i386                 randconfig-a012-20210707
i386                 randconfig-a011-20210707
i386                 randconfig-a014-20210707
i386                 randconfig-a013-20210707
i386                 randconfig-a015-20210708
i386                 randconfig-a016-20210708
i386                 randconfig-a011-20210708
i386                 randconfig-a012-20210708
i386                 randconfig-a013-20210708
i386                 randconfig-a014-20210708
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210707
x86_64               randconfig-b001-20210708
x86_64               randconfig-a015-20210707
x86_64               randconfig-a014-20210707
x86_64               randconfig-a012-20210707
x86_64               randconfig-a011-20210707
x86_64               randconfig-a016-20210707
x86_64               randconfig-a013-20210707

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
