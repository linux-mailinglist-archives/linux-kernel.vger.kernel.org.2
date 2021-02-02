Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87D30BE65
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhBBMkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:40:46 -0500
Received: from mga05.intel.com ([192.55.52.43]:47425 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231665AbhBBMk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:40:29 -0500
IronPort-SDR: x758cIjBBN/0OV+KxnjpoRJsnNAqANSbZI8rdeshLrnsItsDGCuDbsHiCLqeIsMISlvc0T7zLW
 Ffu257Slr+Vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="265677648"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="265677648"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 04:39:48 -0800
IronPort-SDR: A1tJHHfgIeJW4Vu96Z7WEpJ0WLGyEGCVC5F5g/sB5VbpA5H8VAC3PNDoN9WAumnyU0+2/9AKOG
 S9nPsx2aNSag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="413578771"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 02 Feb 2021 04:39:47 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l6uyA-0009L4-L6; Tue, 02 Feb 2021 12:39:46 +0000
Date:   Tue, 02 Feb 2021 20:38:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 8acf417805a5f5c69e9ff66f14cab022c2755161
Message-ID: <601947dd.8T2WnKZsMjEeGnBa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 8acf417805a5f5c69e9ff66f14cab022c2755161  x86/split_lock: Enable the split lock feature on another Alder Lake CPU

elapsed time: 725m

configs tested: 172
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                malta_kvm_guest_defconfig
nios2                         3c120_defconfig
arm                            xcep_defconfig
sh                             shx3_defconfig
sh                        dreamcast_defconfig
mips                          malta_defconfig
mips                      pistachio_defconfig
sh                              ul2_defconfig
xtensa                  nommu_kc705_defconfig
m68k                            q40_defconfig
powerpc                  storcenter_defconfig
arm                           h5000_defconfig
sh                           se7619_defconfig
sh                          rsk7203_defconfig
powerpc                    adder875_defconfig
powerpc                 mpc8313_rdb_defconfig
m68k                          amiga_defconfig
arm                       versatile_defconfig
arm                      footbridge_defconfig
arm                       multi_v4t_defconfig
sh                           sh2007_defconfig
ia64                             allmodconfig
mips                         tb0219_defconfig
parisc                              defconfig
sh                         apsh4a3a_defconfig
powerpc                     kilauea_defconfig
powerpc                        fsp2_defconfig
m68k                          sun3x_defconfig
m68k                        m5272c3_defconfig
xtensa                           allyesconfig
arm                          gemini_defconfig
powerpc                    klondike_defconfig
arc                        nsim_700_defconfig
arm                         palmz72_defconfig
mips                  decstation_64_defconfig
arm                           sama5_defconfig
arm                          iop32x_defconfig
arm                          ixp4xx_defconfig
powerpc                     stx_gp3_defconfig
parisc                           allyesconfig
sh                     sh7710voipgw_defconfig
powerpc                  mpc885_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     asp8347_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    amigaone_defconfig
sh                          r7780mp_defconfig
mips                            ar7_defconfig
arm                             ezx_defconfig
xtensa                         virt_defconfig
arm                      tct_hammer_defconfig
powerpc                     tqm5200_defconfig
mips                         db1xxx_defconfig
powerpc                     tqm8560_defconfig
powerpc                    sam440ep_defconfig
arm                          prima2_defconfig
csky                             alldefconfig
mips                      maltasmvp_defconfig
sh                ecovec24-romimage_defconfig
powerpc                          allmodconfig
powerpc                 mpc837x_mds_defconfig
arm                            mps2_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     sequoia_defconfig
powerpc                     tqm8548_defconfig
arm                      jornada720_defconfig
sh                        sh7763rdp_defconfig
arm                         s5pv210_defconfig
arm                        keystone_defconfig
ia64                         bigsur_defconfig
mips                      maltaaprp_defconfig
s390                       zfcpdump_defconfig
alpha                            alldefconfig
mips                        omega2p_defconfig
mips                      bmips_stb_defconfig
xtensa                  audio_kc705_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210201
x86_64               randconfig-a001-20210201
x86_64               randconfig-a005-20210201
x86_64               randconfig-a002-20210201
x86_64               randconfig-a004-20210201
x86_64               randconfig-a003-20210201
i386                 randconfig-a001-20210201
i386                 randconfig-a005-20210201
i386                 randconfig-a003-20210201
i386                 randconfig-a006-20210201
i386                 randconfig-a002-20210201
i386                 randconfig-a004-20210201
i386                 randconfig-a001-20210202
i386                 randconfig-a005-20210202
i386                 randconfig-a003-20210202
i386                 randconfig-a006-20210202
i386                 randconfig-a002-20210202
i386                 randconfig-a004-20210202
x86_64               randconfig-a013-20210202
x86_64               randconfig-a014-20210202
x86_64               randconfig-a015-20210202
x86_64               randconfig-a016-20210202
x86_64               randconfig-a011-20210202
x86_64               randconfig-a012-20210202
i386                 randconfig-a013-20210202
i386                 randconfig-a016-20210202
i386                 randconfig-a014-20210202
i386                 randconfig-a012-20210202
i386                 randconfig-a015-20210202
i386                 randconfig-a011-20210202
i386                 randconfig-a013-20210201
i386                 randconfig-a016-20210201
i386                 randconfig-a014-20210201
i386                 randconfig-a012-20210201
i386                 randconfig-a015-20210201
i386                 randconfig-a011-20210201
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210202
x86_64               randconfig-a001-20210202
x86_64               randconfig-a005-20210202
x86_64               randconfig-a002-20210202
x86_64               randconfig-a004-20210202
x86_64               randconfig-a003-20210202
x86_64               randconfig-a013-20210201
x86_64               randconfig-a014-20210201
x86_64               randconfig-a015-20210201
x86_64               randconfig-a016-20210201
x86_64               randconfig-a011-20210201
x86_64               randconfig-a012-20210201

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
