Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C033AA9D4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 06:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFQESO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 00:18:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:55830 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhFQESM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 00:18:12 -0400
IronPort-SDR: Xiz9Puz/dcf373lXwKx5m8Wb4Ucn2mP1JxGbPw+5WXw40+UHYChwaNBRzv1k12FgDDDrNf1xiO
 7WpKRDTbBQ6g==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="227808580"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="227808580"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 21:16:05 -0700
IronPort-SDR: mFDPeJFEKzfJ2K82PG6aAlks5BfO/9fPjehImcg9wjsVToqZuRrT2oWbaQXX6+ZDKcfkM1L/Op
 +SO2A+CFip+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="415998396"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2021 21:16:04 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltjRk-0001nb-10; Thu, 17 Jun 2021 04:16:04 +0000
Date:   Thu, 17 Jun 2021 12:15:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.06.15a] BUILD SUCCESS
 aec6e1b943147877a3f08e73426ae903362758a7
Message-ID: <60cacc51.H3U8vkUYGV9y72gR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.06.15a
branch HEAD: aec6e1b943147877a3f08e73426ae903362758a7  torture: Log more kvm-remote.sh information

elapsed time: 729m

configs tested: 173
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
sh                ecovec24-romimage_defconfig
mips                    maltaup_xpa_defconfig
arm                        vexpress_defconfig
arm                          pxa910_defconfig
powerpc                    sam440ep_defconfig
arm                           omap1_defconfig
arm                          ep93xx_defconfig
arm                        magician_defconfig
powerpc                     kmeter1_defconfig
m68k                                defconfig
m68k                       m5475evb_defconfig
arm                  colibri_pxa270_defconfig
mips                          ath79_defconfig
arm                            mps2_defconfig
m68k                         apollo_defconfig
arm                           h3600_defconfig
arm                            pleb_defconfig
sh                            shmin_defconfig
powerpc                      makalu_defconfig
arm                         shannon_defconfig
sh                          sdk7786_defconfig
sh                     magicpanelr2_defconfig
parisc                generic-64bit_defconfig
arc                            hsdk_defconfig
xtensa                  audio_kc705_defconfig
mips                            e55_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                        workpad_defconfig
xtensa                generic_kc705_defconfig
arm                           sama5_defconfig
arm                         s5pv210_defconfig
ia64                         bigsur_defconfig
arm                        oxnas_v6_defconfig
powerpc                     pq2fads_defconfig
powerpc                     taishan_defconfig
m68k                            mac_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       eiger_defconfig
mips                       rbtx49xx_defconfig
powerpc                     kilauea_defconfig
arm                         axm55xx_defconfig
arm                        clps711x_defconfig
arm                     eseries_pxa_defconfig
x86_64                            allnoconfig
powerpc                     pseries_defconfig
arm                          ixp4xx_defconfig
arm                        multi_v7_defconfig
s390                          debug_defconfig
sh                          sdk7780_defconfig
sparc                            alldefconfig
arm                             ezx_defconfig
arc                        nsimosci_defconfig
powerpc                  mpc866_ads_defconfig
mips                        jmr3927_defconfig
arm                           spitz_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     rainier_defconfig
powerpc                     powernv_defconfig
sh                           se7619_defconfig
arm                       mainstone_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                        maltaup_defconfig
m68k                           sun3_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
x86_64               randconfig-a004-20210617
x86_64               randconfig-a001-20210617
x86_64               randconfig-a002-20210617
x86_64               randconfig-a003-20210617
x86_64               randconfig-a006-20210617
x86_64               randconfig-a005-20210617
i386                 randconfig-a002-20210615
i386                 randconfig-a006-20210615
i386                 randconfig-a004-20210615
i386                 randconfig-a001-20210615
i386                 randconfig-a005-20210615
i386                 randconfig-a003-20210615
i386                 randconfig-a002-20210617
i386                 randconfig-a006-20210617
i386                 randconfig-a001-20210617
i386                 randconfig-a004-20210617
i386                 randconfig-a005-20210617
i386                 randconfig-a003-20210617
i386                 randconfig-a015-20210617
i386                 randconfig-a013-20210617
i386                 randconfig-a016-20210617
i386                 randconfig-a012-20210617
i386                 randconfig-a014-20210617
i386                 randconfig-a011-20210617
i386                 randconfig-a015-20210615
i386                 randconfig-a013-20210615
i386                 randconfig-a016-20210615
i386                 randconfig-a012-20210615
i386                 randconfig-a014-20210615
i386                 randconfig-a011-20210615
x86_64               randconfig-a001-20210615
x86_64               randconfig-a004-20210615
x86_64               randconfig-a002-20210615
x86_64               randconfig-a003-20210615
x86_64               randconfig-a006-20210615
x86_64               randconfig-a005-20210615
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-b001-20210615
x86_64               randconfig-b001-20210617
x86_64               randconfig-a015-20210617
x86_64               randconfig-a011-20210617
x86_64               randconfig-a014-20210617
x86_64               randconfig-a012-20210617
x86_64               randconfig-a013-20210617
x86_64               randconfig-a016-20210617
x86_64               randconfig-a015-20210615
x86_64               randconfig-a011-20210615
x86_64               randconfig-a012-20210615
x86_64               randconfig-a014-20210615
x86_64               randconfig-a016-20210615
x86_64               randconfig-a013-20210615
x86_64               randconfig-a004-20210616
x86_64               randconfig-a001-20210616
x86_64               randconfig-a002-20210616
x86_64               randconfig-a003-20210616
x86_64               randconfig-a006-20210616
x86_64               randconfig-a005-20210616

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
