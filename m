Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B827E42CA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJMTqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:46:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:1157 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhJMTqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:46:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="208315349"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="gz'50?scan'50,208,50";a="208315349"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 12:44:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="gz'50?scan'50,208,50";a="592300008"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Oct 2021 12:44:37 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1makB2-00053F-UK; Wed, 13 Oct 2021 19:44:36 +0000
Date:   Thu, 14 Oct 2021 03:44:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: xillybus_of.c:undefined reference to `devm_platform_ioremap_resource'
Message-ID: <202110140304.PakWGooV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Herbert,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   348949d9a4440abdab3b1dc99a9bb660e8c7da7c
commit: a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a hwrng: ks-sa - Add dependency on IOMEM and OF
date:   10 months ago
config: s390-buildonly-randconfig-r006-20211013 (attached as .config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x48): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0x2aa): undefined reference to `iounmap'
   s390-linux-ld: drivers/irqchip/irq-imx-intmux.o: in function `imx_intmux_probe':
   irq-imx-intmux.c:(.text+0x380): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/phy/marvell/phy-mvebu-a3700-utmi.o: in function `mvebu_a3700_utmi_phy_probe':
   phy-mvebu-a3700-utmi.c:(.text+0x398): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
   clk-fixed-mmio.c:(.text+0x32): undefined reference to `of_iomap'
   s390-linux-ld: clk-fixed-mmio.c:(.text+0x68): undefined reference to `iounmap'
   s390-linux-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
   fsl-edma.c:(.text+0xc3c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: fsl-edma.c:(.text+0xd14): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0xbc2): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
   hidma.c:(.text+0x380): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: hidma.c:(.text+0x3bc): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/edma.o: in function `edma_xbar_event_map':
   edma.c:(.text+0x4ea): undefined reference to `of_address_to_resource'
   s390-linux-ld: edma.c:(.text+0x512): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/dma/ti/edma.o: in function `edma_probe':
   edma.c:(.text+0x35c4): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/omap-dma.o: in function `omap_dma_probe':
   omap-dma.c:(.text+0xfd4): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/dma-crossbar.o: in function `ti_am335x_xbar_probe':
   dma-crossbar.c:(.text+0x202): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/dma-crossbar.o: in function `ti_dra7_xbar_probe':
   dma-crossbar.c:(.text+0x9d8): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_close':
   dpaa2-console.c:(.text+0x6a): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_probe':
   dpaa2-console.c:(.text+0xba): undefined reference to `of_address_to_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_generic_console_open.constprop.0':
   dpaa2-console.c:(.text+0x1a8): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x1e2): undefined reference to `iounmap'
   s390-linux-ld: dpaa2-console.c:(.text+0x21c): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x298): undefined reference to `iounmap'
   s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exynos_trng_probe':
   exynos-trng.c:(.text+0x28e): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson_rng_probe':
   meson-rng.c:(.text+0xa6): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng_probe':
   mtk-rng.c:(.text+0x2ac): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/npcm-rng.o: in function `npcm_rng_probe':
   npcm-rng.c:(.text+0x1d8): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
>> xillybus_of.c:(.text+0x13c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/mfd/sun6i-prcm.o: in function `sun6i_prcm_probe':
   sun6i-prcm.c:(.text+0x9a): undefined reference to `mfd_add_devices'
   s390-linux-ld: drivers/mtd/nand/raw/denali_dt.o: in function `denali_dt_probe':
   denali_dt.c:(.text+0x11a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: denali_dt.c:(.text+0x152): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/input/keyboard/samsung-keypad.o: in function `samsung_keypad_probe':
   samsung-keypad.c:(.text+0x85c): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/ptp/ptp_qoriq.o: in function `ptp_qoriq_probe':
   ptp_qoriq.c:(.text+0xdf4): undefined reference to `ioremap'
   s390-linux-ld: ptp_qoriq.c:(.text+0xe34): undefined reference to `iounmap'
   s390-linux-ld: drivers/ptp/ptp_qoriq.o: in function `ptp_qoriq_free':
   ptp_qoriq.c:(.text+0xee6): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
   timer-of.c:(.init.text+0x96): undefined reference to `of_iomap'
   s390-linux-ld: timer-of.c:(.init.text+0x340): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
   timer-of.c:(.init.text+0x3fc): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-microchip-pit64b.o: in function `mchp_pit64b_dt_init_timer':
   timer-microchip-pit64b.c:(.init.text+0xda): undefined reference to `of_iomap'
   s390-linux-ld: timer-microchip-pit64b.c:(.init.text+0x4bc): undefined reference to `iounmap'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
   Depends on HAS_IOMEM && (ARCH_SUNXI || COMPILE_TEST
   Selected by
   - CLK_SUNXI_PRCM_SUN6I && COMMON_CLK && CLK_SUNXI
   - CLK_SUNXI_PRCM_SUN8I && COMMON_CLK && CLK_SUNXI

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--pf9I7BMVVzbSWLtt
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
C962yFJJFYvFbjHV/wARBLPgPA0BAA==

--pf9I7BMVVzbSWLtt--
