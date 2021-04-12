Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFD035D24D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 23:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbhDLVBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 17:01:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:39472 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237497AbhDLVBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 17:01:07 -0400
IronPort-SDR: S5SCFw7ixvU4izSyBVoqFlDHLxvZYV4Btb1eNd3zacE8ybeHawRKx97tpCo8UxGylh50jJjbTB
 GsPpyK40v8zA==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="181404097"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="181404097"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 14:00:47 -0700
IronPort-SDR: HFcI0IXCpv37N1zMmLUKY9YVZ1Np3XTZrHVXOr23/PfT+aEiSyGK1PqtxR3hSqt7oHq+ISSpdi
 Oytb75LWmigA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="450132313"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2021 14:00:46 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lW3fp-0000eO-IS; Mon, 12 Apr 2021 21:00:45 +0000
Date:   Tue, 13 Apr 2021 05:00:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 298511e29d7c908dcfbe11c714101f9b5aa9e2c9
Message-ID: <6074b4d5.RQAQGdgbhhoozfId%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 298511e29d7c908dcfbe11c714101f9b5aa9e2c9  Merge branch 'core/entry'

elapsed time: 720m

configs tested: 176
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
nds32                            alldefconfig
powerpc                 mpc834x_itx_defconfig
arc                                 defconfig
sh                         apsh4a3a_defconfig
arm                   milbeaut_m10v_defconfig
arm                         nhk8815_defconfig
h8300                            allyesconfig
arm                         cm_x300_defconfig
sh                          rsk7203_defconfig
sh                          landisk_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                       lemote2f_defconfig
sh                             espt_defconfig
sparc                       sparc32_defconfig
arm                          simpad_defconfig
powerpc                        icon_defconfig
openrisc                         alldefconfig
mips                          rm200_defconfig
powerpc                     skiroot_defconfig
arm                            mps2_defconfig
arm                         shannon_defconfig
powerpc                     powernv_defconfig
arm                        realview_defconfig
alpha                               defconfig
arm                       omap2plus_defconfig
mips                           ip27_defconfig
arm                            lart_defconfig
m68k                        mvme16x_defconfig
s390                             allyesconfig
arm                          ixp4xx_defconfig
arm                         bcm2835_defconfig
arm                        mvebu_v7_defconfig
sh                     sh7710voipgw_defconfig
mips                        vocore2_defconfig
arm                           sunxi_defconfig
arm                  colibri_pxa300_defconfig
powerpc                    ge_imp3a_defconfig
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
arm                           sama5_defconfig
sh                        edosk7760_defconfig
sparc64                             defconfig
powerpc                     tqm8548_defconfig
powerpc                        cell_defconfig
sh                          rsk7201_defconfig
h8300                       h8s-sim_defconfig
m68k                          hp300_defconfig
sh                          polaris_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                       spear13xx_defconfig
arm                         hackkit_defconfig
sh                          rsk7264_defconfig
powerpc                        warp_defconfig
arm                             ezx_defconfig
arm                          imote2_defconfig
arc                      axs103_smp_defconfig
mips                         db1xxx_defconfig
m68k                       m5249evb_defconfig
arm                         s3c2410_defconfig
mips                      loongson3_defconfig
sh                   rts7751r2dplus_defconfig
mips                         rt305x_defconfig
nios2                         10m50_defconfig
mips                           rs90_defconfig
xtensa                  cadence_csp_defconfig
sh                             sh03_defconfig
arm                         s5pv210_defconfig
arm                        vexpress_defconfig
mips                      maltasmvp_defconfig
sh                                  defconfig
sparc                       sparc64_defconfig
arm                        magician_defconfig
arc                              alldefconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                      obs600_defconfig
mips                      bmips_stb_defconfig
sh                           sh2007_defconfig
sh                           se7619_defconfig
arm                          pxa910_defconfig
nios2                               defconfig
powerpc                      katmai_defconfig
mips                  decstation_64_defconfig
mips                           ci20_defconfig
m68k                        m5307c3_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                            mmp2_defconfig
arm                       cns3420vb_defconfig
arm                            dove_defconfig
mips                            e55_defconfig
sh                          r7785rp_defconfig
mips                     loongson1c_defconfig
arm                          iop32x_defconfig
sh                           se7343_defconfig
powerpc                  iss476-smp_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
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
