Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFFF3AF8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 00:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhFUWyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 18:54:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:28021 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230438AbhFUWyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 18:54:52 -0400
IronPort-SDR: /HDSsCQR0a33zyN1u1Me50Mz9UK8rbW7Le4gN5mfEKxnK4nOoH8D36996MmFpobaSiJMu7sNwq
 NmnHip32++Xw==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="270793524"
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="270793524"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 15:51:10 -0700
IronPort-SDR: l91w44FGSIeCkEgeF6hvTC1Xxfhg5nvRa86I02PAXzIE1KwIaCarL8E768WWXr1wme8vvCWdO9
 I3u4NiXtjPYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="486672430"
Received: from pl-dbox.sh.intel.com (HELO pl-dbox) ([10.239.159.39])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 15:51:08 -0700
Date:   Tue, 22 Jun 2021 06:43:41 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip:smp/urgent] BUILD REGRESSION
 b22afcdf04c96ca58327784e280e10288cfd3303
Message-ID: <20210621224341.GA165241@pl-dbox>
References: <60d0fc8b.zYHClCDIx15i4OnT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d0fc8b.zYHClCDIx15i4OnT%lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 04:54:35AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/urgent
> branch HEAD: b22afcdf04c96ca58327784e280e10288cfd3303  cpu/hotplug: Cure the cpusets trainwreck
> 
> Error/Warning in current branch:
Sorry for broken report, kindly ignore below warnings, we
will fix this asap.

> 
> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/crypto/cmac.ko', needed by '__modinst'.
> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/crypto/md5.ko', needed by '__modinst'.
> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/crypto/sha512_generic.ko', needed by '__modinst'.
> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/drivers/net/net_failover.ko', needed by '__modinst'.
> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/drivers/net/virtio_net.ko', needed by '__modinst'.
> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/fs/cifs/cifs.ko', needed by '__modinst'.
> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/fs/nfs/nfsv4.ko', needed by '__modinst'.
> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/lib/crypto/libarc4.ko', needed by '__modinst'.
> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/net/core/failover.ko', needed by '__modinst'.
> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/net/dns_resolver/dns_resolver.ko', needed by '__modinst'.
> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/net/sunrpc/auth_gss/auth_rpcgss.ko', needed by '__modinst'.
> 
> Error/Warning ids grouped by kconfigs:
> 
> clang_recent_errors
> `-- x86_64-randconfig-a012-20210621
>     |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-crypto-cmac.ko-needed-by-__modinst-.
>     |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-crypto-md5.ko-needed-by-__modinst-.
>     |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-crypto-sha512_generic.ko-needed-by-__modinst-.
>     |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-drivers-net-net_failover.ko-needed-by-__modinst-.
>     |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-drivers-net-virtio_net.ko-needed-by-__modinst-.
>     |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-fs-cifs-cifs.ko-needed-by-__modinst-.
>     |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-fs-nfs-nfsv4.ko-needed-by-__modinst-.
>     |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-lib-crypto-libarc4.ko-needed-by-__modinst-.
>     |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-net-core-failover.ko-needed-by-__modinst-.
>     |-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-net-dns_resolver-dns_resolver.ko-needed-by-__modinst-.
>     `-- make:No-rule-to-make-target-tmp-kernel-x86_64-randconfig-a012-clang-b22afcdf04c96ca58327784e280e10288cfd3303-lib-modules-..-rc6-kernel-net-sunrpc-auth_gss-auth_rpcgss.ko-needed-by-__modinst-.
> 
> elapsed time: 724m
> 
> configs tested: 135
> configs skipped: 2
> 
> gcc tested configs:
> arm                                 defconfig
> arm64                            allyesconfig
> arm64                               defconfig
> arm                              allyesconfig
> arm                              allmodconfig
> arm                        clps711x_defconfig
> arm                           u8500_defconfig
> m68k                         amcore_defconfig
> sparc64                             defconfig
> powerpc                       eiger_defconfig
> mips                        bcm47xx_defconfig
> arm                           sama5_defconfig
> arm                            lart_defconfig
> mips                           jazz_defconfig
> arm                          badge4_defconfig
> powerpc                    sam440ep_defconfig
> powerpc                 mpc8540_ads_defconfig
> powerpc                    socrates_defconfig
> m68k                            mac_defconfig
> riscv                               defconfig
> um                               alldefconfig
> arc                              allyesconfig
> nios2                         10m50_defconfig
> arm                             mxs_defconfig
> powerpc                     sequoia_defconfig
> mips                          ath79_defconfig
> powerpc                     akebono_defconfig
> powerpc                       maple_defconfig
> powerpc                     tqm5200_defconfig
> arm                          ep93xx_defconfig
> arc                              alldefconfig
> sh                          lboxre2_defconfig
> s390                          debug_defconfig
> mips                     decstation_defconfig
> sh                            titan_defconfig
> arm                        multi_v7_defconfig
> powerpc                  mpc866_ads_defconfig
> sh                          landisk_defconfig
> powerpc                      ep88xc_defconfig
> mips                  maltasmvp_eva_defconfig
> s390                             alldefconfig
> m68k                          multi_defconfig
> m68k                        mvme16x_defconfig
> h8300                    h8300h-sim_defconfig
> mips                       lemote2f_defconfig
> arm                         socfpga_defconfig
> mips                           xway_defconfig
> sparc                       sparc64_defconfig
> powerpc                      ppc6xx_defconfig
> sparc64                          alldefconfig
> arm                        vexpress_defconfig
> powerpc                       holly_defconfig
> parisc                generic-32bit_defconfig
> arm                          pxa168_defconfig
> mips                           ip22_defconfig
> arm                         lpc18xx_defconfig
> powerpc                    gamecube_defconfig
> mips                            e55_defconfig
> powerpc                      katmai_defconfig
> mips                  decstation_64_defconfig
> m68k                        m5272c3_defconfig
> sh                         ecovec24_defconfig
> arm                          collie_defconfig
> x86_64                            allnoconfig
> ia64                             allmodconfig
> ia64                                defconfig
> ia64                             allyesconfig
> m68k                             allmodconfig
> m68k                                defconfig
> m68k                             allyesconfig
> nios2                               defconfig
> nds32                             allnoconfig
> nds32                               defconfig
> nios2                            allyesconfig
> csky                                defconfig
> alpha                               defconfig
> alpha                            allyesconfig
> xtensa                           allyesconfig
> h8300                            allyesconfig
> arc                                 defconfig
> sh                               allmodconfig
> parisc                              defconfig
> s390                             allyesconfig
> s390                             allmodconfig
> parisc                           allyesconfig
> s390                                defconfig
> i386                             allyesconfig
> sparc                            allyesconfig
> sparc                               defconfig
> i386                                defconfig
> mips                             allyesconfig
> mips                             allmodconfig
> powerpc                          allyesconfig
> powerpc                          allmodconfig
> powerpc                           allnoconfig
> x86_64               randconfig-a002-20210621
> x86_64               randconfig-a001-20210621
> x86_64               randconfig-a005-20210621
> x86_64               randconfig-a003-20210621
> x86_64               randconfig-a004-20210621
> x86_64               randconfig-a006-20210621
> i386                 randconfig-a002-20210621
> i386                 randconfig-a003-20210621
> i386                 randconfig-a006-20210621
> i386                 randconfig-a005-20210621
> i386                 randconfig-a004-20210621
> i386                 randconfig-a001-20210621
> i386                 randconfig-a011-20210621
> i386                 randconfig-a014-20210621
> i386                 randconfig-a013-20210621
> i386                 randconfig-a015-20210621
> i386                 randconfig-a012-20210621
> i386                 randconfig-a016-20210621
> riscv                    nommu_k210_defconfig
> riscv                            allyesconfig
> riscv                    nommu_virt_defconfig
> riscv                             allnoconfig
> riscv                          rv32_defconfig
> riscv                            allmodconfig
> x86_64                    rhel-8.3-kselftests
> um                           x86_64_defconfig
> um                             i386_defconfig
> um                            kunit_defconfig
> x86_64                           allyesconfig
> x86_64                              defconfig
> x86_64                               rhel-8.3
> x86_64                      rhel-8.3-kbuiltin
> x86_64                                  kexec
> 
> clang tested configs:
> x86_64               randconfig-b001-20210621
> x86_64               randconfig-a012-20210621
> x86_64               randconfig-a016-20210621
> x86_64               randconfig-a015-20210621
> x86_64               randconfig-a014-20210621
> x86_64               randconfig-a013-20210621
> x86_64               randconfig-a011-20210621
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
