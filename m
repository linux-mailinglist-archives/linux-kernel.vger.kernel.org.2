Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741923B3D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhFYHYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:24:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:38460 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhFYHX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:23:58 -0400
IronPort-SDR: +gabzjAWsfJUKMyihp8XDwHcFn1FyUns2DYOsxCSMiTiYQGDoGfyb2/8ppFlFHOCQm4is41VTC
 DnSeJB390dPg==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="187313942"
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="187313942"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 00:21:37 -0700
IronPort-SDR: GiqBs37UGSAvt4wMFs5+/q+qvPfHQ7AwG9Id4FyFi5VwM0VgQ1/tzZC8jcYIatCfdggVwiWkU0
 mxkb4sBMmNGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="491468628"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jun 2021 00:21:35 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lwg9e-0006yt-9q; Fri, 25 Jun 2021 07:21:34 +0000
Date:   Fri, 25 Jun 2021 15:20:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD REGRESSION
 adf3c31e18b765ea24eba7b0c1efc076b8ee3d55
Message-ID: <60d583cd.M2tLCwuTsKgBaK+y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: adf3c31e18b765ea24eba7b0c1efc076b8ee3d55  sched/doc: Update the CPU capacity asymmetry bits

Error/Warning reports:

https://lore.kernel.org/lkml/202106240431.pQhQXlhJ-lkp@intel.com

Error/Warning in current branch:

runqslower.bpf.c:77:12: error: no member named 'state' in 'struct task_struct'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-rhel-8.3-kselftests
    `-- runqslower.bpf.c:error:no-member-named-state-in-struct-task_struct

elapsed time: 1396m

configs tested: 204
configs skipped: 4

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                            defconfig
arm                        mvebu_v5_defconfig
xtensa                          iss_defconfig
parisc                           allyesconfig
mips                        vocore2_defconfig
mips                           mtx1_defconfig
powerpc                      arches_defconfig
mips                            gpr_defconfig
m68k                        m5272c3_defconfig
microblaze                      mmu_defconfig
nds32                               defconfig
arm                             rpc_defconfig
arm                        magician_defconfig
mips                      maltasmvp_defconfig
s390                                defconfig
powerpc                      ppc44x_defconfig
m68k                          atari_defconfig
sh                   secureedge5410_defconfig
arm                              alldefconfig
mips                     decstation_defconfig
arm                       aspeed_g5_defconfig
mips                     loongson1c_defconfig
sh                        dreamcast_defconfig
sh                        sh7785lcr_defconfig
arm                         axm55xx_defconfig
nios2                         10m50_defconfig
powerpc                       holly_defconfig
powerpc                      makalu_defconfig
arc                        nsimosci_defconfig
sparc64                          alldefconfig
arm                        keystone_defconfig
mips                          ath79_defconfig
mips                  maltasmvp_eva_defconfig
arm                        spear6xx_defconfig
sh                             espt_defconfig
mips                        qi_lb60_defconfig
h8300                            alldefconfig
powerpc                     akebono_defconfig
xtensa                generic_kc705_defconfig
riscv                             allnoconfig
openrisc                    or1ksim_defconfig
ia64                             allmodconfig
mips                         rt305x_defconfig
sh                           se7206_defconfig
nios2                            alldefconfig
powerpc                 mpc8540_ads_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                        fsp2_defconfig
powerpc                     tqm8555_defconfig
xtensa                       common_defconfig
powerpc                     stx_gp3_defconfig
xtensa                  cadence_csp_defconfig
arm                      pxa255-idp_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                        edosk7705_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     pseries_defconfig
mips                        jmr3927_defconfig
arm                      footbridge_defconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                     davinci_all_defconfig
powerpc                      ppc64e_defconfig
m68k                           sun3_defconfig
powerpc                     ppa8548_defconfig
arm                        clps711x_defconfig
arm                        multi_v5_defconfig
xtensa                    xip_kc705_defconfig
sh                           se7751_defconfig
mips                       capcella_defconfig
sh                         microdev_defconfig
parisc                generic-32bit_defconfig
powerpc                    gamecube_defconfig
m68k                        m5307c3_defconfig
m68k                         amcore_defconfig
arm                       multi_v4t_defconfig
m68k                          amiga_defconfig
powerpc                     sequoia_defconfig
arm                          badge4_defconfig
sh                   rts7751r2dplus_defconfig
arc                          axs103_defconfig
mips                    maltaup_xpa_defconfig
um                                  defconfig
riscv                          rv32_defconfig
sh                           se7343_defconfig
powerpc                 mpc834x_mds_defconfig
arm                           sunxi_defconfig
mips                           gcw0_defconfig
arc                        vdk_hs38_defconfig
sh                          rsk7203_defconfig
m68k                          sun3x_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                   milbeaut_m10v_defconfig
arm                           tegra_defconfig
powerpc                           allnoconfig
powerpc                       maple_defconfig
arm                           corgi_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                       m5249evb_defconfig
mips                        omega2p_defconfig
powerpc                     sbc8548_defconfig
arm                         palmz72_defconfig
m68k                        mvme147_defconfig
arm                          ixp4xx_defconfig
arm                          pxa910_defconfig
x86_64                            allnoconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210623
x86_64               randconfig-a001-20210623
x86_64               randconfig-a005-20210623
x86_64               randconfig-a003-20210623
x86_64               randconfig-a004-20210623
x86_64               randconfig-a006-20210623
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
i386                 randconfig-a002-20210623
i386                 randconfig-a001-20210623
i386                 randconfig-a003-20210623
i386                 randconfig-a006-20210623
i386                 randconfig-a005-20210623
i386                 randconfig-a004-20210623
x86_64               randconfig-a012-20210624
x86_64               randconfig-a016-20210624
x86_64               randconfig-a015-20210624
x86_64               randconfig-a014-20210624
x86_64               randconfig-a013-20210624
x86_64               randconfig-a011-20210624
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210623
i386                 randconfig-a014-20210623
i386                 randconfig-a013-20210623
i386                 randconfig-a015-20210623
i386                 randconfig-a012-20210623
i386                 randconfig-a016-20210623
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210624
x86_64               randconfig-b001-20210622
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
