Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477A434F635
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhCaBZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:25:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:44660 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230284AbhCaBZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:25:29 -0400
IronPort-SDR: zry9AXb9oWAEs/+e3f7Gr/7UCt53Oc/bdERpRLdJSOtpgeXjsmdeNIEXnKQrCxONDD9oIb8aDh
 qzG0zr8SmZ2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="255884091"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="255884091"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 18:25:24 -0700
IronPort-SDR: Fip/7804oBC8qU1SyfMkNTPFlclmfgpX9JT2/r0/vWbilC5yew/nYWNl9jF2xnAzxt9yj2Cglj
 kX4oFzr/O+9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="393831120"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2021 18:25:23 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRPbm-0005a6-Hx; Wed, 31 Mar 2021 01:25:22 +0000
Date:   Wed, 31 Mar 2021 09:24:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD REGRESSION
 e571028ea527748ab22cd3a97c2d795db281ac59
Message-ID: <6063cf4c.U23/hwyFwDq/bN3G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: e571028ea527748ab22cd3a97c2d795db281ac59  Merge branch 'core/entry'

possible Error/Warning in current branch:

arch/x86/net/bpf_jit_comp.c:2015:16: error: 'ideal_nops' undeclared (first use in this function)
arch/x86/net/bpf_jit_comp.c:2015:27: error: 'NOP_ATOMIC5' undeclared (first use in this function); did you mean 'GFP_ATOMIC'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- x86_64-allmodconfig
|   |-- arch-x86-net-bpf_jit_comp.c:error:NOP_ATOMIC5-undeclared-(first-use-in-this-function)
|   `-- arch-x86-net-bpf_jit_comp.c:error:ideal_nops-undeclared-(first-use-in-this-function)
|-- x86_64-allyesconfig
|   |-- arch-x86-net-bpf_jit_comp.c:error:NOP_ATOMIC5-undeclared-(first-use-in-this-function)
|   `-- arch-x86-net-bpf_jit_comp.c:error:ideal_nops-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-8.3
|   |-- arch-x86-net-bpf_jit_comp.c:error:NOP_ATOMIC5-undeclared-(first-use-in-this-function)
|   `-- arch-x86-net-bpf_jit_comp.c:error:ideal_nops-undeclared-(first-use-in-this-function)
`-- x86_64-rhel-8.3-kbuiltin
    |-- arch-x86-net-bpf_jit_comp.c:error:NOP_ATOMIC5-undeclared-(first-use-in-this-function)
    `-- arch-x86-net-bpf_jit_comp.c:error:ideal_nops-undeclared-(first-use-in-this-function)

elapsed time: 727m

configs tested: 121
configs skipped: 4

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
mips                           gcw0_defconfig
powerpc                        warp_defconfig
powerpc                     kmeter1_defconfig
mips                           ip22_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                         db1xxx_defconfig
arm                        cerfcube_defconfig
arm                           tegra_defconfig
sh                              ul2_defconfig
arm                        neponset_defconfig
powerpc                     redwood_defconfig
arm                       aspeed_g5_defconfig
mips                malta_qemu_32r6_defconfig
sh                        sh7763rdp_defconfig
sh                          rsk7201_defconfig
sh                          urquell_defconfig
arm                            mmp2_defconfig
powerpc                      bamboo_defconfig
i386                                defconfig
powerpc                 mpc837x_mds_defconfig
arm                          lpd270_defconfig
powerpc                     pq2fads_defconfig
powerpc                      obs600_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      ppc44x_defconfig
sh                   secureedge5410_defconfig
m68k                            mac_defconfig
ia64                      gensparse_defconfig
powerpc                     skiroot_defconfig
mips                            ar7_defconfig
mips                     cu1000-neo_defconfig
sparc                       sparc64_defconfig
sh                           se7619_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      arches_defconfig
mips                        qi_lb60_defconfig
riscv                          rv32_defconfig
mips                           xway_defconfig
powerpc                        fsp2_defconfig
powerpc                       ppc64_defconfig
arm                          iop32x_defconfig
powerpc                       ebony_defconfig
sh                            migor_defconfig
mips                       lemote2f_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
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
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
