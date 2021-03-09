Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07FD331BDB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhCIAnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:43:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:8628 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229714AbhCIAnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:43:41 -0500
IronPort-SDR: 26sPJ69GWeqMhobU4wUvQbN4sIoy4eWVugg4lGdxieCqoiNYLJ89sPK7+VWxex0zXB6gcfVKjB
 mR0Z0k5GSeZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273158959"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="273158959"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 16:43:41 -0800
IronPort-SDR: /g3BwmW/RlpIPJVUakUnB+8pQ1T9MnoPc7me13b+iztIIYyrwgU/I5oa/RMp0Oe6SsmBSlP0jk
 q29OgVUKNCvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="430562098"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2021 16:43:40 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lJQTL-0001G0-OY; Tue, 09 Mar 2021 00:43:39 +0000
Date:   Tue, 09 Mar 2021 08:43:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 6840a150b9daf35e4d21ab9780d0a03b4ed74a5b
Message-ID: <6046c499.npfhkdgwPH5CY03p%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: 6840a150b9daf35e4d21ab9780d0a03b4ed74a5b  x86/platform/uv: Set section block size for hubless architectures

elapsed time: 728m

configs tested: 207
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
nds32                               defconfig
sh                           se7724_defconfig
mips                         bigsur_defconfig
mips                          ath25_defconfig
m68k                           sun3_defconfig
powerpc                     akebono_defconfig
sh                          polaris_defconfig
sh                          rsk7264_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          pcm027_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
mips                           gcw0_defconfig
arm                            lart_defconfig
sh                        edosk7705_defconfig
sh                          sdk7780_defconfig
sh                        edosk7760_defconfig
powerpc                          g5_defconfig
csky                             alldefconfig
sh                         microdev_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                            gpr_defconfig
powerpc                      pmac32_defconfig
sh                         ap325rxa_defconfig
m68k                       m5208evb_defconfig
powerpc                       ppc64_defconfig
mips                           ci20_defconfig
sh                          rsk7201_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                               alldefconfig
powerpc64                           defconfig
mips                        jmr3927_defconfig
arm                            hisi_defconfig
powerpc                  mpc885_ads_defconfig
nds32                            alldefconfig
parisc                generic-32bit_defconfig
sh                          lboxre2_defconfig
arm                          pxa3xx_defconfig
m68k                             alldefconfig
arm                          moxart_defconfig
powerpc                  storcenter_defconfig
arm                             ezx_defconfig
mips                       lemote2f_defconfig
arm                         socfpga_defconfig
powerpc                     pseries_defconfig
arm                         s5pv210_defconfig
mips                    maltaup_xpa_defconfig
mips                        vocore2_defconfig
powerpc                    amigaone_defconfig
powerpc                    mvme5100_defconfig
arc                            hsdk_defconfig
arm                        multi_v5_defconfig
sh                              ul2_defconfig
sh                          rsk7203_defconfig
sh                           se7619_defconfig
powerpc                        cell_defconfig
arm                           spitz_defconfig
mips                      maltaaprp_defconfig
arm                           corgi_defconfig
arm                     eseries_pxa_defconfig
arm                             rpc_defconfig
arm                        mvebu_v7_defconfig
powerpc                     stx_gp3_defconfig
sparc                            allyesconfig
sh                             espt_defconfig
m68k                          sun3x_defconfig
sparc                       sparc64_defconfig
mips                  maltasmvp_eva_defconfig
arm                       imx_v6_v7_defconfig
arm                        trizeps4_defconfig
arm                       netwinder_defconfig
arm                           viper_defconfig
arm                             mxs_defconfig
arm                        cerfcube_defconfig
sh                           se7343_defconfig
sh                        sh7785lcr_defconfig
mips                        bcm47xx_defconfig
microblaze                      mmu_defconfig
h8300                       h8s-sim_defconfig
powerpc                      mgcoge_defconfig
sh                             sh03_defconfig
mips                       capcella_defconfig
xtensa                  audio_kc705_defconfig
arc                          axs101_defconfig
powerpc                    ge_imp3a_defconfig
mips                           jazz_defconfig
ia64                        generic_defconfig
mips                         tb0226_defconfig
sh                           se7705_defconfig
arm                         bcm2835_defconfig
arm                        keystone_defconfig
arm                        neponset_defconfig
arm                       aspeed_g5_defconfig
sh                          sdk7786_defconfig
arm                           u8500_defconfig
mips                         mpc30x_defconfig
mips                  decstation_64_defconfig
sh                           se7721_defconfig
arm                       omap2plus_defconfig
arm                       mainstone_defconfig
powerpc               mpc834x_itxgp_defconfig
openrisc                 simple_smp_defconfig
m68k                        mvme16x_defconfig
arc                           tb10x_defconfig
mips                         tb0219_defconfig
powerpc                 mpc8272_ads_defconfig
sh                ecovec24-romimage_defconfig
ia64                            zx1_defconfig
ia64                             allmodconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210308
x86_64               randconfig-a001-20210308
x86_64               randconfig-a004-20210308
x86_64               randconfig-a002-20210308
x86_64               randconfig-a005-20210308
x86_64               randconfig-a003-20210308
i386                 randconfig-a005-20210308
i386                 randconfig-a003-20210308
i386                 randconfig-a002-20210308
i386                 randconfig-a006-20210308
i386                 randconfig-a004-20210308
i386                 randconfig-a001-20210308
i386                 randconfig-a005-20210309
i386                 randconfig-a003-20210309
i386                 randconfig-a002-20210309
i386                 randconfig-a006-20210309
i386                 randconfig-a004-20210309
i386                 randconfig-a001-20210309
x86_64               randconfig-a013-20210309
x86_64               randconfig-a016-20210309
x86_64               randconfig-a015-20210309
x86_64               randconfig-a014-20210309
x86_64               randconfig-a011-20210309
x86_64               randconfig-a012-20210309
i386                 randconfig-a016-20210309
i386                 randconfig-a012-20210309
i386                 randconfig-a014-20210309
i386                 randconfig-a013-20210309
i386                 randconfig-a011-20210309
i386                 randconfig-a015-20210309
i386                 randconfig-a016-20210308
i386                 randconfig-a012-20210308
i386                 randconfig-a014-20210308
i386                 randconfig-a013-20210308
i386                 randconfig-a011-20210308
i386                 randconfig-a015-20210308
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210309
x86_64               randconfig-a001-20210309
x86_64               randconfig-a004-20210309
x86_64               randconfig-a002-20210309
x86_64               randconfig-a005-20210309
x86_64               randconfig-a003-20210309
x86_64               randconfig-a013-20210308
x86_64               randconfig-a016-20210308
x86_64               randconfig-a015-20210308
x86_64               randconfig-a014-20210308
x86_64               randconfig-a011-20210308
x86_64               randconfig-a012-20210308

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
