Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3885D3B190B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 13:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhFWLhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 07:37:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:58136 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhFWLhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:37:38 -0400
IronPort-SDR: Xfb2wf/lplcc9oxDmwSKKXy+HZxjZQtyUNphaqKYWtO1GQwPCQV8NxnUeNG5UoqkgkULxQ0fiv
 FLV+TroGuKQA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="194548918"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="194548918"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 04:35:20 -0700
IronPort-SDR: hg4K3zgdHKQhKz6mC7jGCYp6qWs6zsvZAN/rhbDKPU8QhhrC1uTytJrizgWSq61RwfNRb+nGWY
 BxtDqXKVWEoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="453005582"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Jun 2021 04:35:19 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lw1A6-0005uN-LX; Wed, 23 Jun 2021 11:35:18 +0000
Date:   Wed, 23 Jun 2021 19:35:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/kspp] BUILD SUCCESS
 a73bbfba991f8bb5d1814affcf1f7642ca0cdd35
Message-ID: <60d31c6f.szfq32JQhZ0r5Cx7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: a73bbfba991f8bb5d1814affcf1f7642ca0cdd35  media: siano: Fix out-of-bounds warnings in smscore_load_firmware_family2()

elapsed time: 757m

configs tested: 114
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                           h3600_defconfig
powerpc                    klondike_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      arches_defconfig
arm                             rpc_defconfig
arm                            lart_defconfig
powerpc                        fsp2_defconfig
sparc64                             defconfig
mips                         mpc30x_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc8315_rdb_defconfig
nds32                            alldefconfig
powerpc                       maple_defconfig
arm                           corgi_defconfig
arc                    vdk_hs38_smp_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    sam440ep_defconfig
sh                           se7705_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                          malta_defconfig
xtensa                           alldefconfig
powerpc                      makalu_defconfig
m68k                        mvme16x_defconfig
arm                        realview_defconfig
riscv                               defconfig
mips                         bigsur_defconfig
powerpc                      katmai_defconfig
mips                        nlm_xlr_defconfig
powerpc                     ppa8548_defconfig
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
powerpc                          allmodconfig
powerpc                           allnoconfig
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
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
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
x86_64               randconfig-b001-20210622
x86_64               randconfig-b001-20210623
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
