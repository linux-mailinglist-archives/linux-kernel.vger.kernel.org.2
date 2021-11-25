Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DFC45D503
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349194AbhKYHBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:01:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:35666 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346104AbhKYG7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:59:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="216166246"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="216166246"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 22:56:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="538884598"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 24 Nov 2021 22:56:25 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mq8gC-0005vX-Ex; Thu, 25 Nov 2021 06:56:24 +0000
Date:   Thu, 25 Nov 2021 14:55:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [kbingham-rcar:kbingham/vsp/v3u-5.16 31/50]
 drivers/soc/renesas/rcar-irqc.c:46:6: warning: no previous prototype for
 'r8a7791_irqc_show'
Message-ID: <202111251426.faFMJHB3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git kbingham/vsp/v3u-5.16
head:   ccac14c690227590a29f6d85289101f00de58ec6
commit: afbd32fecf59eeb92e38e7fd7824b60d46d5c894 [31/50] soc: renesas: rcar: IRQC debug handling
config: arm-shmobile_defconfig (https://download.01.org/0day-ci/archive/20211125/202111251426.faFMJHB3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git/commit/?id=afbd32fecf59eeb92e38e7fd7824b60d46d5c894
        git remote add kbingham-rcar https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git
        git fetch --no-tags kbingham-rcar kbingham/vsp/v3u-5.16
        git checkout afbd32fecf59eeb92e38e7fd7824b60d46d5c894
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/renesas/rcar-irqc.c:46:6: warning: no previous prototype for 'r8a7791_irqc_show' [-Wmissing-prototypes]
      46 | void r8a7791_irqc_show(const char *msg, unsigned int n)
         |      ^~~~~~~~~~~~~~~~~


vim +/r8a7791_irqc_show +46 drivers/soc/renesas/rcar-irqc.c

    45	
  > 46	void r8a7791_irqc_show(const char *msg, unsigned int n)
    47	{
    48		printk("%s:%u\n", msg, n);
    49		printk("-LEVEL-- --HIGH-- --LOW--- -S-RISE- -S-FALL- -A-RISE- -A-FALL-\n");
    50		printk("%08x %08x %08x %08x %08x %08x %08x\n",
    51		       ioread32(irqc + MONITOR), ioread32(irqc + HLVL_STS),
    52		       ioread32(irqc + LLVL_STS), ioread32(irqc + S_R_EDGE_STS),
    53		       ioread32(irqc + S_F_EDGE_STS), ioread32(irqc + A_R_EDGE_STS),
    54		       ioread32(irqc + A_F_EDGE_STS));
    55	}
    56	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
