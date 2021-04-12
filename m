Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E4235D3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 01:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbhDLXWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 19:22:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:8328 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344078AbhDLXWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:22:15 -0400
IronPort-SDR: njK1j8Zr3N6Nd1nr0impLaBgRvFpekhh71OHtGAdG6A9hEqdbNe7SM+sWojxzq2KxeMWjg4U1h
 0hI7k6rBUiVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194410212"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="194410212"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 16:21:55 -0700
IronPort-SDR: 78OGdTR0qxZWgpvT6+OU0UtLXWA58mIcbc+QG8YOw8IvQ9O8tDlrwExR5lkA6BcVjW5Mvq4k1L
 TTi3Vce4BsRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="398552429"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2021 16:21:54 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lW5sP-0000gr-Fl; Mon, 12 Apr 2021 23:21:53 +0000
Date:   Tue, 13 Apr 2021 07:21:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 f7b21a0e41171d22296b897dac6e4c41d2a3643c
Message-ID: <6074d5e2.9uyg8yfB9+j2ribE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: f7b21a0e41171d22296b897dac6e4c41d2a3643c  x86/asm: Ensure asm/proto.h can be included stand-alone

elapsed time: 722m

configs tested: 167
configs skipped: 69

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
powerpc                        fsp2_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 mpc836x_mds_defconfig
mips                         tb0219_defconfig
mips                           mtx1_defconfig
m68k                       m5249evb_defconfig
mips                          malta_defconfig
arm                          pxa168_defconfig
arc                          axs103_defconfig
arm                         cm_x300_defconfig
sh                          rsk7203_defconfig
sh                          landisk_defconfig
mips                       lemote2f_defconfig
openrisc                         alldefconfig
mips                          rm200_defconfig
powerpc                     skiroot_defconfig
arm                            mps2_defconfig
arm                         shannon_defconfig
powerpc                     powernv_defconfig
arm                        realview_defconfig
powerpc                      mgcoge_defconfig
arm                        mvebu_v5_defconfig
m68k                             allmodconfig
powerpc                     sbc8548_defconfig
sh                            shmin_defconfig
openrisc                 simple_smp_defconfig
arm                         s3c6400_defconfig
arm                            mmp2_defconfig
m68k                       m5275evb_defconfig
powerpc                     mpc512x_defconfig
arm                           sunxi_defconfig
arm                       omap2plus_defconfig
mips                           ip27_defconfig
arm                            lart_defconfig
m68k                        mvme16x_defconfig
s390                             allyesconfig
arm                          ixp4xx_defconfig
ia64                          tiger_defconfig
powerpc                     tqm8555_defconfig
arm                  colibri_pxa300_defconfig
powerpc                    ge_imp3a_defconfig
sh                             espt_defconfig
arm                        trizeps4_defconfig
sh                          urquell_defconfig
powerpc                 linkstation_defconfig
mips                      malta_kvm_defconfig
arm                             rpc_defconfig
powerpc                      ppc64e_defconfig
arm                        oxnas_v6_defconfig
powerpc                          g5_defconfig
xtensa                              defconfig
sh                         ecovec24_defconfig
arm                          collie_defconfig
sh                   sh7724_generic_defconfig
sh                             sh03_defconfig
arm                         s5pv210_defconfig
powerpc                     tqm8540_defconfig
sh                   rts7751r2dplus_defconfig
mips                      maltaaprp_defconfig
arc                      axs103_smp_defconfig
mips                         db1xxx_defconfig
arm                         s3c2410_defconfig
mips                      loongson3_defconfig
mips                           jazz_defconfig
sparc                       sparc32_defconfig
sh                           se7751_defconfig
powerpc                      cm5200_defconfig
x86_64                           alldefconfig
arm                             ezx_defconfig
powerpc                     kmeter1_defconfig
powerpc                      bamboo_defconfig
mips                 decstation_r4k_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7712_defconfig
arm                        vexpress_defconfig
powerpc                        cell_defconfig
mips                      maltasmvp_defconfig
powerpc                     tqm8541_defconfig
xtensa                         virt_defconfig
arm                      pxa255-idp_defconfig
arm                         assabet_defconfig
powerpc                     pq2fads_defconfig
m68k                          amiga_defconfig
arm                         vf610m4_defconfig
arm                         lpc32xx_defconfig
h8300                            alldefconfig
sh                          r7785rp_defconfig
mips                     loongson1c_defconfig
arm                          iop32x_defconfig
sh                           se7343_defconfig
powerpc                  iss476-smp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210412
i386                 randconfig-a001-20210412
i386                 randconfig-a006-20210412
i386                 randconfig-a005-20210412
i386                 randconfig-a004-20210412
i386                 randconfig-a002-20210412
x86_64               randconfig-a014-20210412
x86_64               randconfig-a015-20210412
x86_64               randconfig-a011-20210412
x86_64               randconfig-a013-20210412
x86_64               randconfig-a012-20210412
x86_64               randconfig-a016-20210412
i386                 randconfig-a015-20210412
i386                 randconfig-a014-20210412
i386                 randconfig-a013-20210412
i386                 randconfig-a012-20210412
i386                 randconfig-a016-20210412
i386                 randconfig-a011-20210412
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a003-20210412
x86_64               randconfig-a002-20210412
x86_64               randconfig-a001-20210412
x86_64               randconfig-a005-20210412
x86_64               randconfig-a006-20210412
x86_64               randconfig-a004-20210412

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
