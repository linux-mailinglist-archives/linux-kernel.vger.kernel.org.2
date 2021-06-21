Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3343AF70B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 22:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhFUU5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 16:57:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:36400 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhFUU5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 16:57:51 -0400
IronPort-SDR: W6pGyCZ+VgpFARThItGOrctjMF7Z5V/qRTsB+Ea039M0xfgnChwhpOXKq09ZwnmIDFgCnB7cMf
 gb6ogFsbHz+A==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="292560812"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="292560812"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 13:55:35 -0700
IronPort-SDR: ResA4EmKCQQ2wbUMHUE5MfWQqJet91IV8QEudCL3vxA5LKmmwaF/r9JFXVz0ay+e+Rha3p+FXh
 DBiHcIJT9l+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="555555458"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Jun 2021 13:55:34 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lvQxB-0004mx-Fa; Mon, 21 Jun 2021 20:55:33 +0000
Date:   Tue, 22 Jun 2021 04:54:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/urgent] BUILD REGRESSION
 b22afcdf04c96ca58327784e280e10288cfd3303
Message-ID: <60d0fc8b.zYHClCDIx15i4OnT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/urgent
branch HEAD: b22afcdf04c96ca58327784e280e10288cfd3303  cpu/hotplug: Cure the cpusets trainwreck

Error/Warning in current branch:

make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/crypto/cmac.ko', needed by '__modinst'.
make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/crypto/md5.ko', needed by '__modinst'.
make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/crypto/sha512_generic.ko', needed by '__modinst'.
make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/drivers/net/net_failover.ko', needed by '__modinst'.
make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/drivers/net/virtio_net.ko', needed by '__modinst'.
make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/fs/cifs/cifs.ko', needed by '__modinst'.
make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/fs/nfs/nfsv4.ko', needed by '__modinst'.
make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/lib/crypto/libarc4.ko', needed by '__modinst'.
make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/net/core/failover.ko', needed by '__modinst'.
make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/net/dns_resolver/dns_resolver.ko', needed by '__modinst'.
make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/net/sunrpc/auth_gss/auth_rpcgss.ko', needed by '__modinst'.

Error/Warning ids grouped by kconfigs:

clang_recent_errors
`-- x86_64-randconfig-a012-20210621
    |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-crypto-cmac.ko-needed-by-__modinst-.
    |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-crypto-md5.ko-needed-by-__modinst-.
    |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-crypto-sha512_generic.ko-needed-by-__modinst-.
    |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-drivers-net-net_failover.ko-needed-by-__modinst-.
    |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-drivers-net-virtio_net.ko-needed-by-__modinst-.
    |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-fs-cifs-cifs.ko-needed-by-__modinst-.
    |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-fs-nfs-nfsv4.ko-needed-by-__modinst-.
    |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-lib-crypto-libarc4.ko-needed-by-__modinst-.
    |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-net-core-failover.ko-needed-by-__modinst-.
    |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-net-dns_resolver-dns_resolver.ko-needed-by-__modinst-.
    `-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-net-sunrpc-auth_gss-auth_rpcgss.ko-needed-by-__modinst-.

elapsed time: 724m

configs tested: 135
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        clps711x_defconfig
arm                           u8500_defconfig
m68k                         amcore_defconfig
sparc64                             defconfig
powerpc                       eiger_defconfig
mips                        bcm47xx_defconfig
arm                           sama5_defconfig
arm                            lart_defconfig
mips                           jazz_defconfig
arm                          badge4_defconfig
powerpc                    sam440ep_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                    socrates_defconfig
m68k                            mac_defconfig
riscv                               defconfig
um                               alldefconfig
arc                              allyesconfig
nios2                         10m50_defconfig
arm                             mxs_defconfig
powerpc                     sequoia_defconfig
mips                          ath79_defconfig
powerpc                     akebono_defconfig
powerpc                       maple_defconfig
powerpc                     tqm5200_defconfig
arm                          ep93xx_defconfig
arc                              alldefconfig
sh                          lboxre2_defconfig
s390                          debug_defconfig
mips                     decstation_defconfig
sh                            titan_defconfig
arm                        multi_v7_defconfig
powerpc                  mpc866_ads_defconfig
sh                          landisk_defconfig
powerpc                      ep88xc_defconfig
mips                  maltasmvp_eva_defconfig
s390                             alldefconfig
m68k                          multi_defconfig
m68k                        mvme16x_defconfig
h8300                    h8300h-sim_defconfig
mips                       lemote2f_defconfig
arm                         socfpga_defconfig
mips                           xway_defconfig
sparc                       sparc64_defconfig
powerpc                      ppc6xx_defconfig
sparc64                          alldefconfig
arm                        vexpress_defconfig
powerpc                       holly_defconfig
parisc                generic-32bit_defconfig
arm                          pxa168_defconfig
mips                           ip22_defconfig
arm                         lpc18xx_defconfig
powerpc                    gamecube_defconfig
mips                            e55_defconfig
powerpc                      katmai_defconfig
mips                  decstation_64_defconfig
m68k                        m5272c3_defconfig
sh                         ecovec24_defconfig
arm                          collie_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
x86_64               randconfig-a002-20210621
x86_64               randconfig-a001-20210621
x86_64               randconfig-a005-20210621
x86_64               randconfig-a003-20210621
x86_64               randconfig-a004-20210621
x86_64               randconfig-a006-20210621
i386                 randconfig-a002-20210621
i386                 randconfig-a003-20210621
i386                 randconfig-a006-20210621
i386                 randconfig-a005-20210621
i386                 randconfig-a004-20210621
i386                 randconfig-a001-20210621
i386                 randconfig-a011-20210621
i386                 randconfig-a014-20210621
i386                 randconfig-a013-20210621
i386                 randconfig-a015-20210621
i386                 randconfig-a012-20210621
i386                 randconfig-a016-20210621
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
x86_64               randconfig-b001-20210621
x86_64               randconfig-a012-20210621
x86_64               randconfig-a016-20210621
x86_64               randconfig-a015-20210621
x86_64               randconfig-a014-20210621
x86_64               randconfig-a013-20210621
x86_64               randconfig-a011-20210621

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
