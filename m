Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7ABD36F10A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbhD2U3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:29:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:65009 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237043AbhD2U3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:29:46 -0400
IronPort-SDR: p0depVcpczuQydjboy5FAuG8UWN2ysXO4+99ffwaa3zMuCofUgfyPTVoEvPUDmWPO/3lBQpxno
 ph7nZBZofalw==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="196670591"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="196670591"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 13:28:56 -0700
IronPort-SDR: KCgU4lHYbipTi+TeLJXvA8UNArlvnmyBz/m2RqZL4roa3G608GQAGjKdfrJhRjosR5XVyqzoWU
 sWgSrFQH3DMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="466490145"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Apr 2021 13:28:55 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lcDHK-0007mq-Jx; Thu, 29 Apr 2021 20:28:54 +0000
Date:   Fri, 30 Apr 2021 04:28:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 3b2e75db2b04c5daf18f9a189d72be01831632bc
Message-ID: <608b16d1.W+I26oyEozhTGfNR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 3b2e75db2b04c5daf18f9a189d72be01831632bc  Merge branch 'x86/mm'

i386-tinyconfig vmlinux size:

+-------+-------------------------+------------------------------------+
| DELTA |         SYMBOL          |               COMMIT               |
+-------+-------------------------+------------------------------------+
|  +113 | TOTAL                   | 3b2e75db2b04 Merge branch 'x86/mm' |
|  +136 | TEXT                    | 3b2e75db2b04 Merge branch 'x86/mm' |
|  +283 | flush_tlb_func()        | 3b2e75db2b04 Merge branch 'x86/mm' |
|   +69 | arch_tlbbatch_flush()   | 3b2e75db2b04 Merge branch 'x86/mm' |
|  -254 | flush_tlb_func_common() | 3b2e75db2b04 Merge branch 'x86/mm' |
+-------+-------------------------+------------------------------------+

elapsed time: 727m

configs tested: 127
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
mips                         rt305x_defconfig
powerpc                      obs600_defconfig
sh                         apsh4a3a_defconfig
xtensa                           alldefconfig
mips                       lemote2f_defconfig
powerpc                        icon_defconfig
xtensa                         virt_defconfig
arm                           corgi_defconfig
m68k                          sun3x_defconfig
arm                          moxart_defconfig
arm                     eseries_pxa_defconfig
arm                       aspeed_g5_defconfig
mips                       capcella_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           xway_defconfig
powerpc                     sbc8548_defconfig
arm                     am200epdkit_defconfig
sh                           se7721_defconfig
mips                           ip27_defconfig
powerpc                      arches_defconfig
arm                       netwinder_defconfig
arm                             ezx_defconfig
sh                           sh2007_defconfig
sh                           se7343_defconfig
mips                      loongson3_defconfig
parisc                           allyesconfig
powerpc                 mpc836x_mds_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     tqm8541_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     mpc83xx_defconfig
arm                         axm55xx_defconfig
arm                         s3c6400_defconfig
arm                           h3600_defconfig
sparc                            allyesconfig
m68k                           sun3_defconfig
riscv                            alldefconfig
powerpc                      katmai_defconfig
sh                        apsh4ad0a_defconfig
mips                        bcm47xx_defconfig
powerpc                     ppa8548_defconfig
arm                            zeus_defconfig
powerpc                     pq2fads_defconfig
powerpc                    socrates_defconfig
sh                            hp6xx_defconfig
arm                          pxa910_defconfig
s390                       zfcpdump_defconfig
sh                          landisk_defconfig
powerpc                 mpc8560_ads_defconfig
mips                      bmips_stb_defconfig
sparc64                             defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210429
i386                 randconfig-a002-20210429
i386                 randconfig-a001-20210429
i386                 randconfig-a006-20210429
i386                 randconfig-a003-20210429
i386                 randconfig-a004-20210429
i386                 randconfig-a012-20210429
i386                 randconfig-a014-20210429
i386                 randconfig-a013-20210429
i386                 randconfig-a011-20210429
i386                 randconfig-a015-20210429
i386                 randconfig-a016-20210429
x86_64               randconfig-a004-20210429
x86_64               randconfig-a002-20210429
x86_64               randconfig-a005-20210429
x86_64               randconfig-a006-20210429
x86_64               randconfig-a001-20210429
x86_64               randconfig-a003-20210429
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
x86_64               randconfig-a015-20210429
x86_64               randconfig-a016-20210429
x86_64               randconfig-a011-20210429
x86_64               randconfig-a014-20210429
x86_64               randconfig-a013-20210429
x86_64               randconfig-a012-20210429

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
