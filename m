Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8434431A531
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 20:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhBLTRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 14:17:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:30331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231706AbhBLTRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 14:17:35 -0500
IronPort-SDR: DFlpbuh0E9uGfrlRfRHnaP8k1oHnR7LOsYHAQuQXw8pJRRXfD+OJl9UhtwOPC8yg5J/YqdcHWk
 A22EPljceBSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="179905350"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="gz'50?scan'50,208,50";a="179905350"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 11:16:43 -0800
IronPort-SDR: SP8iDy62MtF8eMEagcRmaHLnyZCrujY9FfOFVD5DlZSFpxYFV7JcJ7cIML3bVxn3Zh2SgRma9o
 VQCBdpX7iGTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="gz'50?scan'50,208,50";a="381831963"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Feb 2021 11:16:41 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lAdvk-0004ph-Mk; Fri, 12 Feb 2021 19:16:40 +0000
Date:   Sat, 13 Feb 2021 03:15:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: ll_temac_main.c:undefined reference to
 `devm_platform_ioremap_resource_byname'
Message-ID: <202102130354.WZikEkEg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wang,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcc0b49040c70ad827a7f3d58a21b01fdb14e749
commit: bd69058f50d5ffa659423bcfa6fe6280ce9c760a net: ll_temac: Use devm_platform_ioremap_resource_byname()
date:   7 months ago
config: s390-randconfig-p001-20210212 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bd69058f50d5ffa659423bcfa6fe6280ce9c760a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bd69058f50d5ffa659423bcfa6fe6280ce9c760a
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   coherent.c:(.text+0x410): undefined reference to `memremap'
   s390-linux-ld: coherent.c:(.text+0x4e8): undefined reference to `memunmap'
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
   coherent.c:(.text+0x64e): undefined reference to `memunmap'
   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x4e): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0x2f2): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_detach':
   main.c:(.text+0xa4): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0xf0): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_probe':
   main.c:(.text+0x2cc): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x388): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x3dc): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x420): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_attach':
   main.c:(.text+0x6e2): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x728): undefined reference to `iounmap'
   s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
   xillybus_of.c:(.text+0x196): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_exit':
   com90xx.c:(.exit.text+0x62): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `check_mirror':
   com90xx.c:(.init.text+0x60): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x86): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_probe':
   com90xx.c:(.init.text+0x798): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x936): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0xdcc): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0xec8): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0xffc): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x10d6): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x12b6): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arc_rimi_exit':
   arc-rimi.c:(.exit.text+0x3e): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arc_rimi_init':
   arc-rimi.c:(.init.text+0x264): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x2ec): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x46c): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x4fc): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x5d6): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `check_mirror':
   arc-rimi.c:(.text.unlikely+0x60): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.text.unlikely+0x86): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/altera/altera_tse_main.o: in function `request_and_map':
   altera_tse_main.c:(.text+0x69a): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/net/ethernet/xilinx/ll_temac_main.o: in function `temac_probe':
>> ll_temac_main.c:(.text+0x1a74): undefined reference to `devm_platform_ioremap_resource_byname'
   s390-linux-ld: ll_temac_main.c:(.text+0x1bf4): undefined reference to `devm_of_iomap'
   s390-linux-ld: ll_temac_main.c:(.text+0x1d08): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/net/ethernet/xilinx/ll_temac_mdio.o: in function `temac_mdio_setup':
   ll_temac_mdio.c:(.text+0x292): undefined reference to `of_address_to_resource'
   s390-linux-ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.o: in function `axienet_probe':
   xilinx_axienet_main.c:(.text+0xc44): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: xilinx_axienet_main.c:(.text+0xe58): undefined reference to `of_address_to_resource'
   s390-linux-ld: xilinx_axienet_main.c:(.text+0xe90): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: xilinx_axienet_main.c:(.text+0xefa): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x3ae): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x3e8): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x416): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x428): undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0xefa): undefined reference to `iounmap'
   s390-linux-ld: drivers/input/serio/apbps2.o: in function `apbps2_of_probe':
   apbps2.c:(.text+0x29e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/input/touchscreen/imx6ul_tsc.o: in function `imx6ul_tsc_probe':
   imx6ul_tsc.c:(.text+0x25e): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: imx6ul_tsc.c:(.text+0x29a): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
   timer-of.c:(.init.text+0x4e): undefined reference to `of_iomap'
   s390-linux-ld: timer-of.c:(.init.text+0x33a): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
   timer-of.c:(.init.text+0x426): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-microchip-pit64b.o: in function `mchp_pit64b_dt_init_timer':
   timer-microchip-pit64b.c:(.init.text+0xa0): undefined reference to `of_iomap'
   s390-linux-ld: timer-microchip-pit64b.c:(.init.text+0x526): undefined reference to `iounmap'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--PEIAKu/WMn1b1Hv9
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--PEIAKu/WMn1b1Hv9--
