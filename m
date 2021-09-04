Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61DC400BF8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 18:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhIDPyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 11:54:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:54350 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236843AbhIDPyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 11:54:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10097"; a="241940332"
X-IronPort-AV: E=Sophos;i="5.85,268,1624345200"; 
   d="gz'50?scan'50,208,50";a="241940332"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2021 08:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,268,1624345200"; 
   d="gz'50?scan'50,208,50";a="463224421"
Received: from lkp-server01.sh.intel.com (HELO 2115029a3e5c) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Sep 2021 08:53:07 -0700
Received: from kbuild by 2115029a3e5c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mMXyc-0001iE-AF; Sat, 04 Sep 2021 15:53:06 +0000
Date:   Sat, 4 Sep 2021 23:52:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Shaohua <liush@allwinnertech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [csky-linux:linux-5.15-rc1-d1-v4 7/7]
 drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:174:31: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202109042343.6iXJaMdQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/c-sky/csky-linux linux-5.15-rc1-d1-v4
head:   88c6ea42e010e46e58be159efa07cda22d95a512
commit: 88c6ea42e010e46e58be159efa07cda22d95a512 [7/7] riscv: soc: (not ready) Allwinner D1 GMAC driver
config: i386-randconfig-s002-20210904 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-rc1-dirty
        # https://github.com/c-sky/csky-linux/commit/88c6ea42e010e46e58be159efa07cda22d95a512
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux linux-5.15-rc1-d1-v4
        git checkout 88c6ea42e010e46e58be159efa07cda22d95a512
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:174:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:174:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:174:31: sparse:     got void *
>> drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:177:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:177:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:177:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:178:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:178:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:178:31: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:181:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:181:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:181:34: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:188:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:188:46: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:188:46: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:195:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:195:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:195:31: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:199:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:199:29: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:199:29: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:200:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:200:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:200:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:203:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:203:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:203:31: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:211:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:211:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:211:33: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:217:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:217:42: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:217:42: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:239:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:239:29: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:239:29: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:246:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:246:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:246:28: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:251:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:251:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:251:28: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:259:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:259:37: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:259:37: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:261:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:261:37: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:261:37: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:265:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:265:37: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:265:37: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:267:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:267:37: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:267:37: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:271:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:271:37: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:271:37: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:273:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:273:37: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:273:37: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:283:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:283:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:283:36: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:285:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:285:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:285:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:287:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:287:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:287:36: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:324:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:324:45: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:324:45: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:334:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:334:31: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:334:31: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:336:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:336:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:336:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:338:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:338:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:338:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:345:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:345:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:345:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:347:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:347:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:347:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:355:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:355:31: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:355:31: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:357:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:357:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:357:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:359:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:359:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:359:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:364:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:364:43: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:364:43: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:367:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:367:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:367:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:380:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:380:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:380:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:383:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:383:44: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:383:44: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:395:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:395:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:395:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:397:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:397:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:397:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:399:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:399:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:399:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:403:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:403:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:403:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:405:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:405:46: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:405:46: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:408:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:408:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:408:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:429:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:429:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:429:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:431:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:431:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:431:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:450:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:450:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:450:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:457:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:457:29: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:457:29: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:458:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:458:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:458:28: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:474:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:474:34: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:474:34: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:482:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:482:29: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:482:29: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:484:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:484:29: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:484:29: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:491:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:491:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:491:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:493:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:493:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:493:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:495:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:495:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:495:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:497:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:497:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:497:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:504:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:504:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:504:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:506:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:506:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:506:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:508:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:508:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:508:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:510:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:510:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:510:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:517:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:517:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:517:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:518:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:518:43: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:518:43: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:525:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:525:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:525:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:526:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:526:43: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:526:43: sparse:     got void *
>> drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:521:6: sparse: sparse: symbol 'sunxi_rx_poll' was not declared. Should it be static?
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:531:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:531:44: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:531:44: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:536:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:536:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:536:26: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:683:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:683:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:683:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:685:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:685:30: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:685:30: sparse:     got void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:689:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:689:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c:689:32: sparse:     got void *
--
>> drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:165:6: sparse: sparse: symbol 'sunxi_udelay' was not declared. Should it be static?
>> drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1351:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1351:31: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1351:31: sparse:     got void [noderef] __iomem *base
>> drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1278:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1284:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1284:28: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1284:28: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1285:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1285:28: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1285:28: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1313:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1313:28: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1313:28: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1315:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1315:28: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1315:28: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1322:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1322:30: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1322:30: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:375:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:375:36: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:375:36: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:384:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:384:38: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:384:38: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:428:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:428:47: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:428:47: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:429:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:429:47: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:429:47: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:430:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:430:50: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:430:50: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:431:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:431:50: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:431:50: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:432:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:432:52: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:432:52: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:433:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:433:46: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:433:46: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:434:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:434:52: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:434:52: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:435:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:435:51: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:435:51: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:436:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:436:51: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:436:51: sparse:     got void [noderef] __iomem *base
>> drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:486:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *iobase @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:486:40: sparse:     expected void *iobase
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:486:40: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:489:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:489:44: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:489:44: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:490:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:490:38: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:490:38: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:492:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:492:44: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:492:44: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:493:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:493:38: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:493:38: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:495:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *iobase @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:495:40: sparse:     expected void *iobase
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:495:40: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:497:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *iobase @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:497:40: sparse:     expected void *iobase
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:497:40: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:499:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:499:44: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:499:44: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:500:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:500:38: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:500:38: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:562:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:562:41: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:562:41: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:571:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:571:30: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:571:30: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:581:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:581:37: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:581:37: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:605:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *iobase @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:605:45: sparse:     expected void *iobase
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:605:45: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:619:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *iobase @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:619:49: sparse:     expected void *iobase
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:619:49: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1209:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1209:27: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1209:27: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1216:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1216:28: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1216:28: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1241:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1241:39: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1241:39: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1514:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1514:27: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1514:27: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1606:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1606:38: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1606:38: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1654:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *iobase @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1654:39: sparse:     expected void *iobase
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1654:39: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1674:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *iobase @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1674:39: sparse:     expected void *iobase
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1674:39: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1686:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1686:44: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1686:44: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1695:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *iobase @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1695:30: sparse:     expected void *iobase
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1695:30: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1747:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1747:28: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1747:28: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1757:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *iobase @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1757:40: sparse:     expected void *iobase
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1757:40: sparse:     got void [noderef] __iomem *base
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1759:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *iobase @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1759:40: sparse:     expected void *iobase
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1759:40: sparse:     got void [noderef] __iomem *base
>> drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1752:5: sparse: sparse: symbol 'geth_set_features' was not declared. Should it be static?
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1225:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *base @@
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1225:39: sparse:     expected void *
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1225:39: sparse:     got void [noderef] __iomem *base
>> drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1314:24: sparse: sparse: non size-preserving integer to pointer cast
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1316:24: sparse: sparse: non size-preserving integer to pointer cast
   drivers/net/ethernet/allwinnertmp/sunxi-gmac.c:1419:20: sparse: sparse: context imbalance in 'geth_xmit' - different lock contexts for basic block

vim +174 drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c

   163	
   164	int sunxi_mdio_read(void *iobase, int phyaddr, int phyreg)
   165	{
   166		unsigned int value = 0;
   167	
   168		/* Mask the MDC_DIV_RATIO */
   169		value |= ((hwdev.mdc_div & 0x07) << 20);
   170		value |= (((phyaddr << 12) & (0x0001F000)) |
   171				((phyreg << 4) & (0x000007F0)) |
   172				MII_BUSY);
   173	
 > 174		while (((readl(iobase + GETH_MDIO_ADDR)) & MII_BUSY) == 1)
   175			;
   176	
 > 177		writel(value, iobase + GETH_MDIO_ADDR);
   178		while (((readl(iobase + GETH_MDIO_ADDR)) & MII_BUSY) == 1)
   179			;
   180	
   181		return (int)readl(iobase + GETH_MDIO_DATA);
   182	}
   183	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--qMm9M+Fa2AknHoGS
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICD+SM2EAAy5jb25maWcAjDxLdxyn0vv8ijnOJlnE0cu6zvmOFjRN95BpmjbQoxlt+sjy
2NG5suSrx73xv/+qoB9A04qzcDRUAQXUm6J//unnFXl5fvh6/Xx7c31393315XB/eLx+Pnxa
fb69O/zfKperWpoVy7l5C8jV7f3L37/fnr4/X717e3z29mi1OTzeH+5W9OH+8+2XF+h6+3D/
088/UVkXvOwo7bZMaS7rzrCduXjz5ebmtz9Wv+SHj7fX96s/3p6+Pfrt5ORX99cbrxvXXUnp
xfehqZyGuvjj6PToaMStSF2OoLGZaDtE3U5DQNOAdnL67uhkaK9yRM2KfEKFpjSqBzjyqKWk
7ipeb6YRvMZOG2I4DWBrIIZo0ZXSyCSA19CVzUC17BolC16xrqg7YozyUGStjWqpkUpPrVx9
6C6l8kjLWl7lhgvWGZLBQFoqM0HNWjECO1IXEv4BFI1d4Uh/XpWWOe5WT4fnl2/TIfOam47V
244o2CEuuLk4PQH0kSzRIL2GabO6fVrdPzzjCBNCSxrerWFSpmZIw75LSqph49+8STV3pPW3
0i6y06QyHv6abFm3YapmVVde8WZC9yEZQE7SoOpKkDRkd7XUQy4BztKAK208TgypHffMJzW5
qR7Br8F3V6/3lq+Dz14D40ISZ5mzgrSVsWzjnc3QvJba1ESwize/3D/cH359M42rL0mTnFDv
9ZY3NAlrpOa7TnxoWcsS1FwSQ9edhXqSpKTWnWBCqj0KGaFrf/NbzSqeJWcjLWjKxDT2gImC
qSwGEAycWw2CBTK6enr5+PT96fnwdRKsktVMcWpFGKQ+8yj0QXotL9MQVhSMGo5TF0UnnChH
eA2rc15bPZEeRPBSgf4CwfPYVeUA0nAinWIaRgj1TS4F4XXYprlIIXVrzhRuzD6ECs07LoVo
F4giRsGxwh6CCgCFl8ZC2tTWEt8JmbNwikIqyvJe4cEWTFDdEKVZvyXj2foj5yxry0KHPHC4
/7R6+Byd5mSnJN1o2cKcjuly6c1oWcNHsdLxPdV5SyqeE8O6imjT0T2tEnxh1ft2YrMIbMdj
W1Yb/Sqwy5QkOYWJXkcTcJAk/7NN4gmpu7ZBkiOF50STNq0lV2lrbCJjZReyadHEoG0YJMbc
fj08PqWEBiztppM1A6nwiFlfAaMrLnNrh8cjBXMKEJ5XKdVggd4QvFwjR/XE2mH6E59RM1qh
pojWzKCp+5OPC4GfqVUg1nR6I71956TqQVhbN4pvR10qi2IRtVGsgrNNcnBIlKdLFWOiMbAz
NUsr2x5hK6u2NkTtE9va40z7MnSiEvrMmgPFM6DmezAR4VFqugZhplIFlNk9Bg773Vw//Xv1
DOe0uoY1Pj1fPz+trm9uHl7un2/vv0TsgyxJqKXH6YVxFpR9y5ITOL3DOkeVTRnYEUBNnxiy
O/qGOrVLmvvzws/xVHOu0W9LH90PrNVzzWCdXMvKasjZtinarnRCwOAMOoDNTyVohB8d24HQ
eUeqAww7UNSEO2K79tojAZo1tTlLtRtFKJvTBBteVeiUCp+xEFIzYCDNSppV3FdkCCtILVvr
184au4qR4uL43IdkUsYj2CY4w4rsL95N4YudWNIMz2JxBZ11yUXm65zwdEa7tnF/eJZuM56S
DASGb5zPneK+SqIHDSpozQtzcXLktyPTCLLz4McnEyfw2kDAQwoWjXF8GqjBFkIVF3w4sUVb
MqhEffPX4dPL3eFx9flw/fzyeHiamK+FcE80Q1QSNmYt2CMwRk6PvJu2KjFgYHcvSW26DG0y
kNLWgsAEVdYVVavXng0ulWwb7W8heIh0Qf6rTd8hsbsO4JbuD1cQrjoPlhxZmSWU+RY5TH+K
fuqG5zo5eg9X+ULY0MMLEN0rplJra8A79r0KZDucr4ckiMnZltOUAe7h0BFVaGoZTBXL/QLj
27cJrmmSBHDnEiNpSTcjDjEk8B0gSAFHEVR8ioQ1o5tGgjSgywAOKpvbKgxYZyzixzSFBsJA
uYKHmzxpZZXJFPICz8FeWtdR+R45/iYCRnMepBd0qTyKg6FhCH8njsuXw0iAhSGk30fORjlL
o4YhL2hKdAZCNUZpJ8EZEPyKoeNuj14qQWoa7GyMpuGPlH7LO6maNalB9pVnBtDlMp6/7HQV
z4/PYxywbZRZ78Sp6di1pbrZAJVgWpHMCRqbxGhwAQaeg5x4AY0umcHQrZt5845FZs0FrCuv
gm1xnrZzXJMuGaptX2atGq8F9xMqgSMULTCtBAkEUUVbVYkpi9awnUcz/gQ14W1UI4O18rIm
lZ+js6vxG2ws4jfoNShon2jC0/kMLrtWRa7c0CXfclhFv8meXoOhM6IU949qgyh7oectXXBC
Y6vdIRRjDNKjFIOy3l6REnxrtTAdOBEBFNbUur/eNFT4oq1ZEM5anWdbEzPAuCzPWR6zNVDV
jXGjxwzHR2cz/7FPDTeHx88Pj1+v728OK/bfwz04owTsMkV3FKKmybYvDO7otEDYlW4rbNCf
dH5/cMZp7K1wEzqfIS0cumozR4SfahUNAZ/BRqqTyq5ItjBAiCbTaCSDA1UlGzz9eGxrdtE3
7RRIuBRLg4xomKcBPzpwMvS6LQpwvBoCE435k6V1o7PXEGU4CeJQl4NOS4xVh9b0BTFymDwe
kHfvz7tTL9lqczJDeNcVkWoFbN+suWw3quCcUZn7kgh+eQOuuTUR5uLN4e7z6clveG/h5443
YF073TZNkAAHx5RunOs9gwX5KCuFAr1FVYPZ5C4PcvH+NTjZeZFCiDDw1D+ME6AFw435KU26
3M9TD4CAhd2oZD/Yq67I6bwLKD2eKcw25aGzMaog5BDUYLsEDHgEhKprSuAXE6kS8AWdB+ei
bYhwJgQbiQ0gq4pgKIXZrnXrX7IEeJahk2iOHp4xVbtcIJhDzTM/b2ZRdKsxG7oEtmGC3RhS
desWzHKVBbwJnNxpX+X2o1omwhwY5nA941CATWZEVXuK+UnmeQlN6aKjCrQTGJ0xdupvgTSp
meNT3FhGXQLUKt3m8eHm8PT08Lh6/v7NJQDmUVRAJBJeMGJaxZxPG4JEY5OhHmvIKi+4Hxkp
ZsBYu+uqUUVgX8cb4C6pKml3ESfjJZCT0CMIZDsDB4KHPDlSQe+BmMXhQQ3hTUWj0/EOohAx
jZ8IRjwvQRcQhPPFgVROT0+Od4twYI8aThoOrs5BMy+seeSX/v4BosKqVWzGaVzxwE66oEIK
DmoP3H1Mr+LiU6p9vQehAb8GHOSyZX6mAs6abLkKTM/QNo+S5ii64bXNVS8sbr1FlVJlwLrd
dmDcaZNYnei3ASsdkenS5U2LmVuQiMr0zuJE0DbNEiOhryTxYtQhOTGF/Wfvz3X6mBGUBrx7
BWB0+u4KYUIszHQeDjg0gwaDCELwIH04taa5d4Cn/fgBmr7tE5uFhW3+tdD+Pt1OVatlWvQE
KwoQyzBJOUEveU3XvKELhPTg03RCRYDxWhi3ZOBVlLvjV6BdtXA8dK/4bnG/t5zQ0y59dWuB
C3uHDv5CL3DjUh6h1ZJxMnXQjKrGJVACqqPP0537KNXxMswpVoxTqGz24dDopzdgmlwaRLci
BBsdkQJxyo6uy/OzuFluI2PEay5aYQ1LAS5itQ+JshoKonOhPV+QE9CWaOG6ILZH/K3YLdm+
PnuPOQRWsSj9BNODmnZ7kE6CWbjlgcC/HSBgc+aN633p56THUUD6SKvmAHBSay2YIW6KGXmt
oABJ5/F6lKs1kTue0rrrhjkt6U1s25hoK3QIlfFOMfdTBbV1yDRGKeCSZawEb/YkDcSr4/cx
aAh/YsDU4GydFmZuAAVdEAJbLNKRZiYHcmgMjTlTEES4LFKm5IbVLjGF994LMwg684CgCfPg
FSsJTV2G9TiOkyJeh2bHJqG3UlOOEatIpkyHjniprdfgHCUIgsn+ZOGVlHMdvbD568P97fPD
Y3A15sXnvfQr0oRW18OwXpW8TPofMV5b0yFD2keLC7SEa3G7CkK8YFrd6TYV/sNUSjkaCZot
C9K6/P1mYV8VQwYApz2+BeAUdAUo0qXz8JVR7xbz4GBqiZfL4O8ll9HDzlJOSg87P/Miu63Q
TQVe4GmQsBtaT9Ie3AA+TrtCIKqyKDB/f/Q3PXL/RTSEa2xIIhogrhROG05TMmS9ugKUC4wG
moEkIjQbiyyDraYeHGes+PBkilfIL9XgFmMdRcsujkIaGxx7UVpxpY2JXHFr4yCMkXjzpFQ7
XFmHUQ5wDjqUYiBuQnUDpFw5ozzGwV8Y+HHDr9hie78vowo9WkDDjcTMo9WtA/JxtBckVclk
N9rln8J90II08bLB40zfbrAi7Ritr7rjo6Ml0Mm7o9SpXHWnR0f+1G6UNO6FVzvqLMZa4aW/
33/DdixlRqgiet3lrR8+N+u95mhZgLUVisdxKB1YZkGJ6bl1ug6xO4jXFJgDXtAcNr9hB9CJ
CUnFyxomPAmlERitasvwPnliPw8cbJnLsvrQ1Ppd7mmb6+Bqh4oco3+cJR3ngyTyYt9VuRkS
6cn07Wu5izBttW5QjjAl5jInKFGjRnDG7OF/h8cVGJDrL4evh/tnOxqhDV89fMMa5SdXGdLz
gUv8pDRfkHFoxOJNIYBo5eWcLj8469fZyMVa7CmrOwgBeOXlTE+FSSMk2YPNfg1G0DKYBidH
bto4AyVAbZm+BBG7NH6mz7bAqRhQfI5i1NEw1JT8nO5PENfuQJm0626shqrORNoZAYptO7ll
SvGc+Tm2cHhGU8V1PgaJqc+IAYW+j1tbY0JFbJu3MLtcGrog8w65TGpnC7NxiGJw1lpH00/x
A7Ubugjm+WynRuCMGN4IvkRMKPlhv2k6Upag9hdy/hbXrMFZIlVEE201BJhdrkGIsf7cu0Ue
872uuzVAbVMqkscLi2EJzkqX1do1UI53J0mjZCmUECeBHlLRpMO+cBn7+Y5fs3Rq0PVdqMLw
twQisLV8BU2xvMVCU7yNuUSzK+sq6V2MAkoa5ol52N7fyoZTIGCZgLwx6TpAJ3A7AyHKK6u0
f8e1rqPa43jjDhwVVZCFIudn/52bNYaWQ4Xeqng8/OflcH/zffV0c30XRB6DmIUhsBW8Um7t
M4jO1ZakwHGt1whEuYzjZgsYKu2wt1dosBhJzzuhItVwbj/eBTMptpzkx7vIOmdAWMpuJfEB
1tdDh5fNSWTrG7WGL+U3xu0NKzGSGMNuLMDHpS/Ah3Uunm+wrBTKuBif4T7HDLf69Hj73+BK
GtDcxoS81bfZW4OcbWOv1wXHjVX7i4Fpgy+E3FDLNxO9jYmR/GFwb2t52W3OIxEbAf9aBAz+
RHilsrP+kJCLFxQNuKXgL7jMlOK1DCeYw2N3IMTi4euKEKjF8n1Lc+Zy82JB+/axtj2t2t4s
nywsqZJ1qdpZ1IbNa5CIxdHZxNuBObU89vTX9ePhk+dvJhdY8WxpY+y1KlZHgp9rg0Q/Q5JW
mSNz8093h1CB8qgmaGizAlKRPF+q55uwBKvbxSEMSxfXBEjDXU3S/DnQcK8TL9ataIwV/tG/
d+X1L09Dw+oXcCBWh+ebt7/6vj96FaXE8D1t4CxYCPfzFZScqyipFoBJ7fmn2IQzhi1uhLBt
mDiIQqCd1tnJEezph5arlHeKNQBZ6z8DdEUBmOoMGqcfmmIkGf9eq9FST25BxdOXHjUz794d
pa9LSiaTHr3Iuzqbyf9eF9EDq+FpQvpA3WHf3l8/fl+xry9315HM9ZFrnycfxprhhy4XOHdY
TiFdYsNOUdw+fv0fiPUqj00Fy/1StDzHfJm/rIIrYb0/F7gm9ygXnKdVGUBcuV9iCy0MH5sK
QtcYh+MlMyswmnE3rUF6U1N8WZUV6ScJxWVHi3JxqlLKsmLjWvyBe5BOxic9ELO8Noke2YMe
jOXUYMtllRp4Anq53+WpPPRh1sSg2yafqW1z+PJ4vfo8HLTzCSxkeO2TRhjAMxYJmGqzDTIK
eMHcgjxdzZ5gDPIBUdV29+7Yu0PCApA1Oe5qHredvDuPW01DWj1mRYYirOvHm79unw83mFv5
7dPhG5COOnRmqobQyd20jJLsaoPQuO+DtJkrcEms4s9WgKUjGQuuC9y76G7D9hpTt8XiC+Ee
ERNHScQebVZg415cjQmYtrYpMyy9phgNR2kSvLXEZ8OG112Gb02jgTjwEaacEsVMm+TMGyyM
SQFkk27vh8GkVlz6ZuFFW7t6N6YUZg7sPU70MhPQgrrd6eWpHXEt5SYColnA2JmXrWwT7wE1
nJ014O6lZLRrts5LKoMJvr6+fI4AwVmfplsAOtvXidmmO8rdm3RX79ddrrlh4ROdsT5Lj7WD
9v2D65HEq6WrIIyApycZtw/nuviM8VU+eJr9c/P46CACBkmtc1eW1TNYaG0dnvbD2PBU8f38
Ysf1ZZfBLrhHBRFMcHQTJ7C25ERIGGVhqVaralg8nFdQuhyX9yaYCPMX6G7b9xKu6sz2SA2S
mH+o4FX9FoVp9OmwA13xCtSvm+7RhGi7kmD+qs80YSVsEoyPqlIoPVM6IXLvmPrihJiYXpP0
PIk3ZBFG38/dOy/Actku1BnyhnbuFfLw2YPEZmhG0bF5BdSXYAZa10EWE1C2N55QBewUDT2r
OZwU9A+042bJOq5BHVPdlZHuax7/iAAKwX9eju34JDW1D5cccXuWs3VxMV8mnnTG4iWRfdu4
GN41i7h50LW1vWODo8RS0QR/OFYDGJa0xyl7ywMWCBOgaVdxd1BFw50ooyDMXlIcQC1eBqBB
A2uJghKfoywMrhuUjrzsdyehmW3n4aIqRX5Q3Rzb3R2+2U6ZjLDXWNTRxyyh7oMAH2+WgD5w
OHNvDomf9+Blf3VzOgOQyDKOEQDqdzzv1HqmW7mN45j+0ntEXUCY3+1M1s2ADTXDNzHU5c6X
jkVQ3N0dabJ7CjStCJ95n54Mt5Ch4UJl7r9/iB2i/oUJOHpU7ZtZAffklMWafvZKe8baSw+w
QoHvn36A7NiHCjGaLVgAo+nXjY2E43VnLXneVcf5+JTTOcFUbn/7eP10+LT6t3sw8u3x4fNt
mHJGpP5kEoNb6PAhnuiNfgxLhrGv0RDsJX73CF1wXidfU/yDIz+yLbAJvrDylZ99e6TxNc3F
caQ5/OX07OUeZsy/GBBitfVrGIPr9NoIWtHxgz7x3kWYPHUP2wNR2hU6Ur1diDuPcHz++Nos
I+LCl3JitPijNzEiMvIlPkPV+NGV8Q1px4Vl+fSKbFiA9Rjrize/P328vf/968MnYJiPB+/r
OKANBBwAKP0clNNeLIxlLYN9eh/fFWd9nfP4E/xnTBYo9iGsvh4emma6TDYGKc3pVaphpeIm
+WC1B3Xm+GgOvpLREyYEXGYLX8GwnVBtLNxY2WVhoXxD0uyFCO7rW4PiS30cobl+fL5FIVuZ
798OQTWBfS/lHPp8i9ciqUS60LnUE6qXOip40DxlPKMZ/W0SHzArGG4dtGF2gcuw2VY0uK8O
yellvBfzQz8uXWVMDrY7/AyZB9zsMz+AGJqz4oNPdTjJT+MW9a+pB8Wq6+PpV1v3+4+vCaxO
mXknU32ES9Ip4X0Cyao619k5OD6d6lKDSVsAWou4ABtzBPZjUfn01GFCWYbEndVluuusfTQ5
mNTD6omKNA2qDpLnVuFEF2eT4zC8B+0yVuD/MPQKP4Lk4dqinO5SweDTrSz7+3Dz8nz98e5g
vwa4shWZzx6rZLwuhEE30ePfqghfofZImiru+xB98+xBvsTrctEkreYSQZZacfj68Ph9JaYr
gVk669X6wKHwUJC6DV87TlWHDpYQ576z55yNfeKv/7mYH7/dVPratydq/BxLdEx9XV+P1efl
/OnQF2qMZWBbK/3/nD3bcuO2kr/iysPW2aozdSTqYulhHiAQlDDmzQQl0fPCcsY+iSuT8dTY
Ocn+/aIBkgLAbiq7qZrJCN0AcW30HUuseocGrrm1f6q6hndwP/leM12RZaA5oaa8AC9NGq/R
SsA59WQqJKEYN+qnNuDywNPN7PO2btfLnfQ0uDvNsaIu0Da8p/DNH3fKWZvezG3kEJu6Kq4+
LmdbPzKTDsRyYkdcCOZgjMuBzqU9hutpOLMH7PpGsTMbou4dIi265yZyA1uqzPN31j9Jp7YB
lqiwCmUhAJjuIFMfby8VPpeBZ2BfrrJgyfuS3jej56l7lTNES/aKWLdLRj9ppgO0nHdELP8Q
s2qCWuwV40m2AwbwHEYxGqQs6ctxQ6CoTFwFkdJpDyEbHiMFJXsB5xa4sbPxL3a/ZrSe4C2k
5ejSRCLgXnGDzFMLqw5wFU53sMt7JdRASmlq2dfLxZCkLH9+//P1x2/gIjGiqfrY34kgXhBK
2lgybBH05e4IqvBLXw3O4WSJLSwKzypoysImL8coJcI7kyozFx9lrgTjA14zLk32F4Eupcz9
IcvSZu6ATHlocxqhZwZbE1eC2do1Upk7V4L93cYHXgYfg2Lj00t9DBAqVuFwGLcsCbnHAvcV
+JBnxwbppsVo62OeB/acB7glijsp8NWwFU817tEB0KQ4TsEun8U/AMvSMjzy08C0sEUDZUno
RQ10GK5bCBsyKKp52Rf7zR/jkt7ABqNi5ysYANXrAnpUfNvC1/U/91Oix4DDjzuXMemvxR7+
8acvf/z88uUnv/UsXuGSt17Ztb9NT+tur4NGCPdANEg2Yw9EhbQxoT2A0a+nlnY9ubZrZHH9
PmSyxIOIDDTYsy5IyXo0al3WrtEAbwPOY830thB6WT+UYlTb7rSJrgKlKdMufTNxEgyimX0a
rsR+3abna98zaIeM4THKdpnL9G80JAuWXfmgXitj3MFVKKXegFQ1SBsKto2M+Q4xIxzNVRr9
r76ms5LK36iRreUEVxGUE0BNo2JO9FNC2jaCaldESraaymysJQ60PI2IL+wqGe/x/WCIi8LZ
mlPK8nYzi+a4o2IsuK6N9yTlePipFv5TfJWaaIU3xUo843J5KKjPrzVPVRKx3VIIAWNa4UHt
MB90Dr6YYwl84hzsrlp+01L6x99dAarWciNQZLSxohT5SZ1lzXHqdkLYEO+8QIp58trISuKu
hBHmROKMg6IZJtvTWOCDAYx0AammgexTWPdVTX8g5wojtiWw1qAO1FcJdy3gVenIeVVi8q26
F7XJ4Vc1VsMCHgalJ402fjBnl+wPOlJWRLowB4enTCmJUXpzoUOWTPXQ+qnMdvejnL76Qhcs
swZfjDM0/A9ICDa9vs+W37w/v3VJbL2JLO/qvcB3vznuVaFv8yKXQSjIICKMmg8Arjjg7B2W
VSymZo44jYQyV8sCVVNR5C+BBGf4pg9obFd8lpVIrd/PpUfJHsiA57NoJ7IHfHt+fnq7eX+9
+flZTwAon55A8XSjL0SD4GhOuxKQAEEeO5g8qUbCdMJMq+ROog6wsChbh/23vy9KXG/1tkjS
SmeaJc5ucVEeWip3fZ4QGfSVvihT+t6QCQ7DLvqeVEKSJhDCHVkY0kUIL8WeITedu1dYDIc6
c+0PoIMpLOXtSkR9qIsi7Wlkf2ri5/+8fEEcOK3R2rrEDmOA35SnhKdxD3906e2DNHnSaMM0
TUAJnBRMlZnXjCnB8sENsOlQEx8NVFp/C/lKzAsgtiXBfhi3ZYKES+uwHM7KVGYhCPqqj9h9
CyBQYsKRvuQL9WrKAr+AAKbJOw1jOFE3nwzdGM1sgOOC3u4izLke4hBLaWDgbkTPN2D8rYWx
iKKK4C/8fu/cOsF/emTY0mVfXr+9/3j9ChmTLyEx3gQltf6bitQGBHjGo1fbjb4RP7+9/PLt
DE6y8Dn+qv+h/vj+/fXHu+toO4VmVf6vP+vevXwF8DPZzASWHdbj0zPkmTDgy9Ahn/+lLXeC
OYuFXgET/mMGSs7Cp9toLhCUPqzh6pcH4x++KsOKiW9P319fvoV9hfwqxiMQ/bxXcWjq7c+X
9y+//o09oM4dM1gLPB3ndGvOrdSkLUUTOXNTGZc845KFv41bQsulc0dANWsA6Mb14cvjj6eb
n3+8PP3iW2sfILsOvoDx+jba4tLDJpptsWAiDVisV56Gn0sslUDX8+BZFztesPUNVqML38BK
GfBVF5/uly/dhXZThApadmxkKhkYd1yLyNE6/hxEWrpWTq+4czlw3ug51VnpGwP6Ms1KHsN9
1nPgJuFdGjwa0Q+5sl8c4iPMy00fw3iLr6/6rPy4jCo5m1V3uz4UGUNADMnnHbNkU1fsErjw
k6PVutQz3ql26EhPL3i9t4erUA976jCqxuUDRBfcuDlMJHgtxJU8oV/vwOJUiWD+oRxYpK6u
FpDAMxGb6qy9L5T/mspln0ILzFiNu3bM3sR60oGDd1l6Pq7PHApZPY91QTxcBODTMYVkmju9
PWvpuiZVYu+5RNrfrYz4qExpicjb132560TYlZ3no6Isc/0j+u+4TyH17endHYMAQUPabIfU
43yHda5lp8w1SYKpCbw8zbZN3G0NoMTcN31IgO8FNj76Q+Tbk2F1Xd+Ooql9y4WSwNvD1ggo
8EWYOsgxzInG6j/i0PNCs/0czzCwz924C/ilWfzKM1iZwgyekegBQ8sWX1ZJB0M7bJCOuwbB
6YdUe/5E+qfZxGrMDA0+N98ff7z5bjI1+N/eGl8dNy24Lu7zoSCgIsFK9bKbsKgJkA2QMCZ6
Y7j/MCcbMHEuxt1TjIbpI4J9MUxGgPgb9WM3U3LU/9QsFTj02LTa9Y/Hb282gO4mffyf0STt
0jtNtYJhBb5mSe0tc65/E7p8ClIlcRvA+h2ubGbjy5bPQkxvioqiJA6CBg6eWZBpzii5Rnum
Ytm/qiL7V/L18U0zPr++fB/HlZtdkkh/Tj6JWPCAXEK5Jpkhn9DVB52isZ4UvqDZg/OCfDKv
R9npC/cBzMYBYoCWOmjjbuxFkYkgGAxgQOt2LL9rzzKuD+2c+ECAFl1pBntEAkHb+P0M+7Ke
BC9GnYBxSmoEBhiNJ0YukbJN2DRlxx1qQD4BzcBMfJxlsRoTNYBo5gvTYPTgLimCSyJYNqIa
aGZRQwF3SuS1eydNbH8rsz1+/+7kWjCqNIP1+AWSPwVnpIDbqem1tqNNDh5CVDAtwG0MM6Tw
SVLmK7vdQWTx7bqpitG4JT80wdg9uFC7aArO7zaz5WQLiu+idtQ3DyUX9fvzV6Lr6XI52zej
aeFE2lkDA8GDBNvcFadK0w7s+jYtaLG33yS9iH1lUe27Ts9f//0BBMHHl2/PTze6qY53wARM
86GMr1bUkQMHUjNx4eAHQHuuZG3ip2SCW8t99AJVGhviwA9ltLiLVusRadKQ5SZdL3FNiFli
VUcrggvR7KudSW9Pj4r0n7AMcrnVRQ1550C/7DqvdVDNWavOv2kebUaXb2SZIKuPeXn77UPx
7QOHJaP0o2ayCr53Qm12kIUbZNU2+zhfjkvrj8vLHrm+/NaooWVF/6NQErxsYqhmLnIvKYxT
2C263QE4xignsgvUW2FEpDtQ1MBlvNczTK44+HHkeF4es+aa++96bt1sOddz9IueFUfjFI5f
8KCrfSmoYQ5MyzGeiyWOoFkfHo7LRduFJsje7xbp4WAMgvUy40jLOK5u/sv+P7rRhObmd+tl
hvI/Bs3v8r15dbrndYZPXG84OHEwwaFRy4Efd5h2GiAmMb4nThZeEofCOKfVRPy5ht4Vu09u
5XEMlC7rXLe9Mk/m1L8DBzNdYp2/sZQHYZI/Gzrqv1xCFWhkTxfdlZKi06Vam8ikwNqzVgaJ
w0YavA7Ems3mdrseAzTtWo5L86LreV/u+s0ZpzmjFsn0NLO9uOgBf7y+v355/epdNVIxXQNX
AeZlmBnmAvGTMXbRKp5ltwtgyY9pCj9w02eHlOCuBnrAMsaV/X1N0EkrBbeELBdRg6dm+UwR
rL6VVMs9kwhxtcO7OAzzClw1eOL/Hk71kMeagwJrNo9PRJq9mpnjASY/3IfC2FCvrsG1EVbK
n117YZ0y4ZgdehFWl7Y8ePdvmCmogppToZb172I1xq4ahITt9M3lMcO2HLffGljgOeWBWLV3
Y1ydQjCEqfpQHXEo7BkckvBR7zrIyIWrv0fcabSSwsvbl7EKS8sbqqhUm0q1SE+zyBN6WLyK
Vk0blwWuiY6PWfYAtBbXLuwyyPKAn8MDy2uCka9lko1eHr60ytV2EanlDONkRc7TQsHzA5DC
TnJft3soW5ninhSsjNV2M4sY5Qqr0mg7my0wG4UBRW6qp25Oaw1ZrRDA7jC/vUXKTS+2Mzfy
OOPrxcoRhWM1X288abqEsOQDatLVkkWtJ0HzI+UCMekqikTE57YBRt7QQtIa1xvDWjLRDFhK
8qZVcYLnf478O9T+1rtK94tVbTQ3c2eZOlGC3Ddi6Gy5pljR0h3ZpXiF7RILtTmPkGoZa9ab
W9xxrkPZLniDvRczgJtm6dy+XbGM63azPZRCNSOYEPPZbOnyacGYHQq+u53P8Le56+e/Ht9u
5Le39x9//G6e6uvS5r2DWhHaufkKfOeTJgYv3+Gf7tVdg34DJSf/j3YxCuPbHBg4fZok9v67
B1ZozogcrAO0Jaj+BaFucIyTNY2dMo5xroIfPP8giKnTfeWQn4XSBABKVauGxDiwHctZy3Ao
vMhLHLRTyXKJG4Q9im51AuDs14mBo7Nioo+zwhHxKiZjk+7VYZ4By//lv35nSswrxMnAB5rP
dt+zycb/oTfCb/+8eX/8/vzPGx5/0BvZSxM4MDFottVDZYE1dtsrNK9iX8V9VbIv44eg+8M1
4VFDgBhBGxIaYZpvQEiL/T54xN6Um4xxxt43OpNmdur+nLwFC2KMV90S+E0m3AJwI7DJO2f+
HiF5zUPGs/EKm/JU7vT/EEDwNPNQbrxQ8OflLE5VOmPpFRXB8IPpPJtH+bzjbyA4h2VhxuZi
QubGC9jsdwuLRs8bIC2vIe3yJprA2YloAtjt1YW+SPV/5qDRXzqUhKu4geo2tg0hhvQIenFo
OOP463gWeGDzVdQEm8CULqPR7DLGp4fCJL+d7CwgbK8gbJdTCNlpcrTZ6UjkuLW0rKz1JYRl
rLdfhzgfvbPGI694RrhxW5KiOxUROhLNZxhKm4sz5UE84IwTMY5xpsdf1otrCNEVBLnIJoaq
NHNWl/cTk3xM1IFPbngtPhLvtJujd1Sazoa3ntfHhwr3uu2h+Pi6i788TR99Nbpx/euwWcy3
c/JIJdZXdUzPbXnIImAogdtsT+zJer0bSM6r1WIzG9clbLAWCK/Y4GJRD2dz9PkXywuUSF+J
pw8t8LMsW1GWc4yBvmAocPPhdTW+iWoxQR7UQ7Za8I0munisTDcf6BPNALo3Ow8yCow+3IHm
0QY3T3RI7NrNEvPFdvXXBAmEEWxv8VAag5GrkniJzoDP8e18i8Wa2s+L4PF5u4zZFdJeZpsZ
KnQb6Nit3rvfETuZ16WQQ4sPbRW7L5P0pVqGV+dxscgQXJYe2YgTCbjjQRZx86cokH2B2XE1
pboI4ipzNxMjFJ5EtSsgNRwkEfW0Jxpo8jxhOmYNC7PFm69+LosYpSxGHM+GzMnccW/98+X9
V43/7YNKkptvj+8v/3m+eYG32f/9+MWT70wj7ECIKAN0eL4X6zjAuTi52Wag6L6o5P1oNJp0
8Pk6Io6rnQTw0Jzuk5JphB8GA03w4IwMDda1WjPf/FVzLZrvwmdpoRSSjhGkEcAlec4BCu6P
+CEFRZ95s9d2h9A4GS54hNBPzK68aBqHSslRYdmVIDrvZr7YLm/+kbz8eD7rP/89lg8TWYnO
Je/SYFfWFgf09hnguj8RWpGKJrwgFAr3mJrstbPOjGuJv4CXxIwnJSYK6U7Yl6hdvynpvrF5
2RQXJr7IYyqg1Wg+UQiMaX8MOO6L+ujepKeeyKBAaZ1B1ysoKynjJ+rVXVmSoFNDQYCfIKJa
dpqBOsY487anPG8YV6FT+2Vc3CYWx8/REe+gLm9PZtGqQmlJltDzCFTr35kvwCboxJXmaUY8
iKx5/xw9hAKS3+ausl8d80azY5l7dUE3TyKPi6pdcN8rRqQL9IsLvprj+sfO0V0jEPzBBWGD
O9ufiopioOqH8lCgCYmcMbCYlbXwH36yRebNPjjXVxrYC/+giXq+mFOpMfpKqRY9pf6I56Ci
UskLRZz4S9VahC+XCYrD73SSNfqIoNtoxj67KZc8kG9EyeLNfD4njWnpRPiRbpXg87plzjNO
neFcrvEtBG9ENHvUF90dhaZUeS093p7dE/mq3HoVvvVNouhC+QxSSsWzp/irFwDA5wog1Ipe
2Vq7qmBxcDB3S/x07XgGtJFIlpg3xPPQ1G6r5b7IcRIAjRF8k3ldEEwlVEWMVvkD5sGDcbsc
482dOl2QlqcXZ2jcvlfpJN3Xyl3QQaTKFxi6orbG134A4/M1gPGFu4BPWECh2zNZVUc/qFlt
tn/NWjx21aupuDeikMogVUw2N++Q7QU8yz7cLfhomlZwRhhl8bvK+WjsU2+bjieVqEXbqdVF
/V4+lEa4/V9fgnFI1MbtwcPnwvO13Inoat/FZ36QnjeZLWnzUkE+QX25ZBD/FB7ScUvJ8ZOs
lfcAU0dUk+z0ab65QjXskyfo3j4c2VlIFCQ30appcFD3ZvllYLjSBYpnId6MMIXtcS2ZLj8R
GYQaqkp4ZVwgS/LrV3a/eeobkqe7w/mUXdk4qWYDvH1jCszfOL/nfpFVJ+EnmM5OGZVfQd0R
+V3U3QMWruh+SH+F5YXvS5w2y5ZSAKfNinZ60FB1ngQn5+tT7W+vO7XZLPH7CkArnApbkP4i
HvFxpz7rVkdmUGLpR0c559Hm0xrXrmlgEy01FAfr2b5dLq4cWrvhRIYfzuyh8hQy8Hs+I7ZA
IliaX/lczuruYxdia4twjk1tFpsIO/Num6IGb0BfvRwRG/jU7K8cJv3PqsiLDKdkud93qflG
8X+jspvFdoaQWNZQV1suohmxxBp0RxrY+whgMnvSMa0r3Mx2jjezvzDXHncmTjL2mWGj2ouv
UpzizptDeNz2ClXsEj6KfC/zwIGJmTfJ0EE8CIiLTeQV9rwUuYJHF9Dltgpu94v3KVtQ9rz7
lORrdZuNyFsKfI8m0nM7cgR/i8xjye85u9U7AwzmeKMd/MgIxvieg5sNlXityq7u5coPfKvW
s+WVw1oJkCc9rokROpLNfLEl0pwBqC7wE15t5uvttU7kwrPzuzBIhlWhIMUyzcj5hgLgAUJB
Fqkp3EeZXECRsirRf3zHC0LlpcvhzT1+TeJUMmWBtW0bzRaYqcKr5Rt4pNoSZEeD5tsrC60y
FQRF8u18O6mhMSh8i9/AopScygcC39rO54RwCMDltUtEFRyCLpsaX6ba3JPeeOpMH5y/sfT+
q68HVpYPmSAii2F7CcJJGfKA5cQ1KY9XOvGQF2VgxI/PvG3SfXD6x3VrcTjWHsW2JVdq+TXg
lWHNr0FqREUkX6wDtc24zZN/3eifbQXvUeIXvQRDVKqXtcZCGpxmz/JzEAxhS9rzitpwA8IC
FUicxq3Dp9t45wIKZBcYdLT9Doc1kibPHU6a6vW4uoiNrAJ9TnfmABARtvAkjgnXPVkSV45J
nbWbz9Bp0avvvdyhzrrEE1tEDK+M7PeQ/eGALVtiHqKz1awPt5Q3gEoH+oFyL2jsAovB+4AC
dvo+GsGGlOxIhF6PRiPwbLWcL2dTCOA9NAXfLDeb+STC7UQDXHIW00PstDEkPGYnOTVAycsU
skUR4LSp6arGabU5swe6OrgZ1fPZfM5JnE6+vQrXYs1VnM2mifR/E3gN5GVgVbsnUYRmmjUD
1MLLaxSOkUwnwUZQ/BsYNb0zBsmPxijqAsgGvby5eWaB0X3Nm7Lly1Vbf2L6fqa3Ias3swUN
vp/sZ8dTTsANu0fDNcs3OZ/AQtDAWsxnDc6nguVEk0TJ6Y/HJYi49J4CeM03c3ohTQvLzTR8
fXsFviXhJ31LKUVv1+4i2mtSHFXw99SmvlOb7XaVoRkDYlm01ijt2KSh0AuYTM6Q2NoALoVF
EhSAK0lQ1Lcf5DeyX5D1jhGWbYsA7gu5pC5jg3OQ4LBGXtgGR+8kDoZ2wmwNKLK8X87muKmy
R9jM1h4rbe9C0Nplf3x9f/n+9fmvMN69m8g2O+q1Kgn1iIfV5wFvCOO8j5zBqxn7UadKriYu
Zw1tG0Dx2h/Su42qOjVT4n2BsiT8KIMKphuH17f3D28vT883R7UbHPYB6/n5qcvDCpA+VS17
evz+/vxj7CpythKX8+tiHc6swIvB6oMvCR8mMlVq6Gqk7UEbzdz0xC7IMewh0N5ag4B6VTwB
qpT0NKngKYame3ErXjTPGLC7JwmooytFwP9L2bN1t43z+FfyuPvQHV0sW37ogyzJNie6RZJt
uS8+mTY707NtMyfNfDvz75cgKYkXQP72oWkCQCREgSQI4tIm6mYGw00GCAypR3roCN3xTYf3
BP2na6bbF3SU0CrzyrziUtp4m1ztuTC2kLhOTOD/8+3l588HjtQn1eViX4CrCWU8oC3wJdge
8UtEdSd0oytuQO4lhjnGCd+dOWnurNh1GeKQ9ePPv97JQB1WNSezCgIA4LyAF08B5H4P1ZMK
Iw5eYmTprEcjA5zElAk/fgwKM2Wj+vbMh29yHzRDu+VjNRRFNHORGwS/1lcZum1A87MVzz2C
rRVAGyAqd4Z88jG/7mqZz3Jqc4TxdQjfljSCJooC/MBrEsV4nLVFhBnhZpL+cYfz+cQV+ugO
F0CzuUsT+MTFyUSTqdz27TrGPUMmyuLxkYjdnkjITdWgELnaibT/E2GfJuuVj9cL0YnilX/n
U0iJvvNuZRwG+PQ3aMI7NPz4swkjXHGZiYgFbiZoWj8grtpGmiq/9IRr2kQDZQ/gfvBOd8qo
e+fD1UW2Z91R1a6/02JfX5JLgivLM9WpuitRNV+IcIvpLARlcOvrU3qk6kxNlEN/t780aeCU
tky0I3Lizx+whyKgDLNIaculppfDn7emCxDQLSnM8gkzZnel6uCOFHB3w/8n9MGZrrtWSQOH
NOxQ4lLx46BxIJlJ0uuctdXlhu3zXV0/LnYiisuJGHK8kbwA5YEo5KHxmoO+xohzyNybEByG
5n2biPZQ2c12M5zR51L8vjx0asCsxxdSbEqCpOGnD8HkAhHY0KzQEAOfXhMzHkeCYSQh+Hqh
ZS6tlkuZgQbx2pWOHKS+7zV6SXoJP3fDMCSJDYYtwYbNkiaDw+1hm9BwMsFNZ0rpgJJXmMBJ
AlHeyczRKyDQLniEpkStLJ2KNVyZvkd1TKoLdbrWyB53/I97RE1+SDo0l7ciklLFFWZ+zlnZ
KpcQpi5t81w7rWlArrp0m1hPVGAiN/FmYwyYjcWUHpMoJdpufS/wzXQABh5OdbdSv6BC0bc+
3BAkJ658sCFlLY7fnQLf88MFZLDFkXASg7qVLK3i0I+pAdLJIg9XuAz6a5z2ZeITue9c0gOf
enfGP732fdfY4S4uAfkdFN5I/+ziV3d7WNmTGyOxbvYRyizZeuEK7whwUUD1AYnDmhaL+9Wp
jknZdEcrBkYnyHOi3KJBdEiKhPCwd8jo3GAG7ZCGltufjlbn1juNHOo606uFGm/OsjxvCNyV
A/nP1XognmYF4xOGRlo+EDq2W3fXzRrXgA3mT9UntCSwPkqP/T7wA2JFyA2jlYmpcYRYVm8X
CHyk+Jck1NaqU/IDg+/HaAilQZZ2kfzUGLLsfJ+YAHxJ3CcdlF5cUcyW3SFYh/E9DsQfVBus
HNan4tZ399+YVfnA7s258nHjB4Tg9WmTVxQjHOUUScA+btbf9n00eMQ2J35vId3fAv7CCNGZ
thhcOLJe3Eda4oFRltsNNbsA50VkHxzrY96oDlFINQGaBuQGrjvqit4UUD/cxJi/nDNsrA+o
LZbLj1j6iJnH0YHnDQsbi6QgRV2isfRPLhWp5Cj0jd2V4ra86bnmjRWOFbmuIZu4jt58u94P
QmJqdH25Jzs8tXuu0Ib0tt0N8ToilpG+6daRtyFk8VPer4OAlKRPTsAzStbWx1IpWffkiD11
ETUxPonUBRpSnbiZ6YwloVxh9VeYw65C92mw5gJXV/xob7co9c2UH0TslVHid1xvI6x4ysoZ
Dh5/4Z6y44wG2WGz4YMvmbhLuA3BwaonDr4TZbwNovstykl9ay6ty6ZJWSbxSs9qp4aoSayC
zgAVNsAd1yx0J0MNleVpnRG4M9u1iTvWacO/w7/B54VBXWeuy/dmNv/xixZ8rwTcwqAkPRPl
X/oc99Kb7NAdf3lFuUQ49L8SBZAEXhSVK5PFNq65uO1ZoEhL38POZRILwclF0kOUihAde+Tb
vD/Ng+scKGFtCPzYoLAHbWgCPo+afOEofinAd3b6wgbyNF5/mGOTFCU4NVCcNek+8tYhF+Dy
hODiaLNyWW0upRJOklUgQdkUItrWPVSCAtMrIsVZsgliTw20cy8jzyv4egO4dUisRdlQhCtn
0VNg+5xlIinfaUnFl9pgvcV95CeKdbDG3BlG2UtCQ3c1wOZOp1rMcr5yQOZ2/tsuaV3es/Ys
FuYjabXU6NYROdwCvaHQLWR67hpMwNqS2QdcAbJGWsCoAZbIEouXFKi9F1qtc4itHwl4kKmM
ija97zuQwIaEngNZOe+wD3ERkEiiwrNCGvqW9Dl4fvsiCnmxX+oHOwGe+X5I4m2LQvx5Y7G3
Cmwg/6myic4+EAKR9nGQbnzCl1qQNElL3RYoghRM68jHk+iC7aRB33qsTS4LjapQc6thu+cu
AMeUpWba9E4bSbNb4l7e05n8nwQKeeSQlLmZtXWE3KouimIEXhgiNoHz8uR7j/jBfyLal9aB
ebrdx+RqyhyCXa/Li+w/nt+eP4NPi5MJue8N79wzdq48VWzY8t2vN53LZdI2AUYeKjKRQPTU
11Dv7uOYM/Pl7evzNzeXvzLo5klbgNnFFHOOiAMzo/AE5LpU0+aiTJVWxAihk8ndDRkZUf46
irzkdk44iLr50+n34A6D7fM6USrzexBMG7lFdS71CsA6Ih/MXcLoCs2DqRFUrYgP6j6uMGx7
qnpW5hMJ2kc+9HmVEXfaOmHSNTn/Fmc7IAkbhYt0FUfbyehFZGK8D2I0YFknKpqOkIiSZUjn
UFwNSQQls7S//vgAj3KIEGPhSOZmnJUN8TNI6Huu1Er44MBhwApZacTmaUSNQkW/8kQ5fXLf
ojC3dA2oSazd/68d5vujkB3bs7PbpAST0wDuONkTASaf6tK0GrB5LBH3x6dL/TXrwDiFjsOE
pjG2AuTgKWVIEfKptsvbLCGS9yiqXVquw2FBttU2+mufQNql3uHXwi98XILytrtC3v67HCz1
Ltrj8g6bmrv46ES75JS1fBH/6PtR4HkUkzqDS8MH2eGXFyDl0Nx0+AuY6KXRa4kwPoluG0oD
4ch9xwW+Uf3bT87If+eFBTWr9kU+LL93CgFwfJLdMnZgKd+bW2QxsEkW3r9r7JxfU6UmY6e3
F8G0bwvrYlyhZN3iKrN83Mp6SKSLakH5NQOFSNNKJTa4VqlwBjsQQdi3Y1ZgJuvJNUhqSwhU
ai7YOFW3A1ENoqo/1SUaYgelXoyu1NBAcmXLy0LDiCHljxEODcBl0/IR1PxiZ9hNJqSe6n8J
aG6oHAW6vk7oprG8I2elUmYeoxdn1pQMHAiywjAnADSDf8JcZiFE3fTMytktMZA6XnpxUX3J
CATp1rxPzAQ/gqDDvovE8I3NYuWS9Okxqw82h2DYqvcm9Q7rW6GPF352qjLddXsCwb4Bh5My
R7GW7/aMsNJyzYhdskKDhWeKQ26M+ow467WXdLBKhupgUi6aemWxGTOw5pjrZqasL8zA8aaB
bGdEYt26upq7rQpHEFlXP9Onnmkl0E0ikJOzTKrbyrpynuGEk0KXtsEKv/lmDWRGBAdldJEk
OdVWtUuC1uFWVSnNJbRJ4024/tuCVvwgpiBTs1wKSyIKuTqTFVLyM5mA69igiQT4rD6kxxyy
foIAa0tPyv81JS6cHIGtYPAI65w8pgLqANQ90HwTM4NvaRuhTiSKhKt4gsRtEzBj7IXTMiD5
HsyqnLjv0Amr07nGDflAVXWp2Tna6d3O0hazvQHmzIcYCloMV2Tg+jD81AQrGmPd3tlY8wYu
L1KzUDNXroorxBSlRaIfzkY4Qqkq6Klp49ozJvOekp/21MGdiWYUNzBQSgHMEkIgpet9kCIh
CUbdFog2gy9XN21+YIYxnkOFXyyUHjTBcMGc9BbsyEmNUAEOLE/DyIsW3iX4EhU1Mea49rmT
hizeZFHk1SF3GnVm/gznP7FdTuGLPl2FuvvAiGjSZButfKxNifp7odWGVaCnuK3yMTWBWW7S
O52VxZA2Ba59Lg6h2dQxL5q8FZYqgu/RtXUSlOTb769vX9//+P7T+hzFod4x62sDsEn3GNDI
0201PHU2mfx2f/3UpEDtdA+cOQ7/4/Xn+8PnKTs2FoYnu2V+FOJeeRN+jYcATPhhAV9mmwgP
aVBoSAq6hL+VDXHrCIurYxbVkR3hQiyRJZFwmiMbxgbcvi8WanG5TzMlcyTx6XQiSTrWRdGW
HnaOX4fERbpEb9eEfsHRZ6ISs8JZ/n9CJGAto2SkS0tXpRLL4z8/31++P/zGxW0s0fwf37nc
ffvn4eX7by9fIJbyF0X14fXHB6jd/J926yms5mQUjZz3HTtUsmIFYogjaYkMWUCWHwIPPQsA
rszPgTk5sRVTrLL75FT0fNf9NU97ojQs0D7mpbUuachaxKuYHfKVYHpXCzMkDkAZiY0u28eQ
FpCOlT1aig6QU/ISWXHub76r/uDndo76RS4tzyoc1rHZC3YS5/4JwH1Sd/wE5lpQ6/c/5Iqs
GteEyWo4Tdx6IELjtfKvGv3uicT0ciq4hgFt6UWXWWsce7TeoEAVydnaewVI1bnDMFA/EOoA
22Mni87SlSAnEthD7pDsTvi5Q9d2tOdCTEgMZQ6U57GShgYqk67XlXsBEydVeevDV5vy+SdI
0VzBQQtwnD8xlAUTpj78oAXoQVYPk4nicH7HUH+TIbjh5kfu4mqC5xy/LhACeTNkAMZVxxBP
wFzgaofknaOJMjgSCfH1Zlf7zuobrNxg5bMON4CyV1UNVZQb71YUjf0ImA1JezU8J83xXUcI
Bl/NuOZfWSPK16jAMKFPMOt+i8PHvBw2Z13qx3xX9IgbXqAQFwwkuhwYYZnlyJ4rXwXb78FQ
TLzZoDLx6aBxqdRgn67VU9ncDk/IB0nMYhzzVNCU01mhM7k/uTWC4dGx9rSaTrpJoxHzwoo2
Fh9xqruBVxwXA1Lk62DwzHezFrUJJI7yGFzm6AZDX9/WhTVpphrmGnOo+fOoy/xRFL6bj1bS
u4Iv87Oy+3PUhgX421co1DmPCzQABy7NSGJGG/I/3YQMClf1jSKX6nbTjR245zFohwsVJAh9
tGwdGkpci6MYt7j6jFMaycTE7y8/Xt6e31/f3BNB33AWXz//D8Igfxk/iuObOI6r2/KkmLb+
H8+/fXt5kAm8HiAcvsr7S92KnDvik3d9UjZQG+T9lQ/SywPfy7l28OXr+9dXUBlEtz//SzQ2
2rccbiZm7HPgWMxLIW6Htj41mp7E4fKI7NLDYXB/4o+Zt//QEv8N78JAyM3SYWlkRfj2bRF4
mblA4cQWuPAybYKw82LTqOBgjc3GxrqYjn8O/Z50gg9+pN8xT/C+3BuZ6kaE9DTEDfuKpE7z
giiJPTE6JaXqSB1/pN0l175NGB4bOhKlx7xtr2eW494AI1lx5fsiRNQuUiVFlrdF8kjcX4x8
tfVAOSxPbCVVVVd3m0rzLGm5Uo87rk4Sk1fnvL3XZV48HuFy/16fOVci+m53avFQzGl6iXz7
d1tj/Jvfo/kVXD7ujysQ7FluG2xsqvzC7nPfnaqWdfn9T96zg8uaWKFavoT+fP758OfXH5/f
374Zp2G1elEk9qTKn05cM9i1RtUHkH8jE6ICQI29voEsQAXjX+pj5AcjRb23DPfi0KkKplmt
sPbJzI0j1zDk+bFirA5LLTVhAt7O2J2QQKvVczJSvnx/ffvn4fvzn3/yc7+Y7c5BTjy3WQ2D
pdnK9xJ6vsMFX1QbTEuRLNq6unSnvyTNzmkIPKaodvY9/Of5nvPUtEfQxeAkXYsM9bG4ZBZI
5JY+pxa03MXrTg82kV8qKZMoC7hc1buTjbO8bBSwdtq4dqnpny6jCoY4wu1PAn1Js22IhokI
tK34jh/qtldhIaPVlZYJqZxwDeCDwoID44LU7Dd+HNtdsj7e2O+bHkPftwkvrII6Zja089fp
KtY5XuRosnwJ6Mvff3KlyDqwypFw8+WY6KqxODnwg2CROV9JJFdB06rO6MB+VwWFFcHCCGt8
aNMrKEW/ceeEjCTA7UuCoG9YGsS2s7Fma7AGUC4g+8wdWGdYA89icpdtvCiI7SVgDIPWgdIO
57xO0YTbFW7DVvh4g5ZUmLDROkI+AsQwuWPn6FU6tk2jPopDq7Ex3sRpTCC2aNijxMsIE1vs
y3i7XRnz1B16dZ3A7sr6gglffp8+JrLLyIHiOkWN2+mVrC0i2Y1BQkIibdJIlEsqonymHPks
DQMim7hcWGrIe1vYzi7Txb0zUtMZfVGo+W7or1eu9EBt5YFYEMgtuUzDMI7t792wru5aCzi0
kGMhdHvgyq5dOmL04HLfRbzj+evb+1/8vGet3pacHA5tfkgsM7nZc/p4anSxRBsen7n4o+bh
f/jfr8pOO1tBpt4vvrJGirRYNTaPZ5KsC1axtmzoGP9SYghz25/h3YHp74IwqTPffXv+l+6Q
wttRphV+4DH7VaYVaU7VX1Mi4BXQgF+TIkbalAjIlpiBfYhs3seiVc1W1uTDaKirThF7EcFb
6JGtoq5LJkVIPxze0hazaJpUxJAZ52odsdFnoonwKV7i3MOyGpkk/gaRLCVB2pEH3M34x+xQ
PxyJ7U5NUxgBHzqcNIM1kD0cCI3lQ2nKSZbyszyY1rFk7mMk7vi4AoMp0oaBlQ6ywsO+762N
IVPt87NQH29XERaKN5KIQNm50Ql8CTw/cuHwedYeDo8puE/AA4xnmeNggeNuZ9bdU8PAweju
JAsROXir0d1TAEnlXUYVwnZjt9HH7Ant3abL+tuJiwf/nrfqjJ2WpgGCJDbYgDoJbMYB4Bgf
ddPSHvV1J61JgEQsLio/AoM0OYbv2kI+PghZTDZ44RuLJHBfUWACc3sfeR0jeJGGRxIxhfRI
yREBqqie9kWHxzHWG2mUm/sSwrVIU/ThOsLW35kgXfnroHA5y/JeXJ2LIVmtozXG5KhL32FU
5gJYGrcmWItsVu7D/Tok0oaOJFy+V36EiYpBYZb50lFBtLnbwSbENm6NIuIsuKMIiHiLCD4g
tjHFUrRGl6FpvSl34QqRJnUa2bhyfUhOhxy+drBdocv16CG/MGvaPvJCRLbbnq/zkQs/pZ3v
eQHy7tl2u42MoMvjpcQdLEHHSkxvSgmCfMZkooGRpuuTnnVEVPZIlJc5Z6uC+EjlBs6Fv0j4
YtB99Gxi5d1oQS8tE+nuoFxKs9RXlkvHlEN9hkoFDSSByLEWdcJ9wvg354NH5C1BHoHwWEis
TKU6UY/QrSOEi/wCAdzj38i8/Trl/4M9qfUkRVGn9hFlnjnNaXwGxWf5ed/mT4s0szRA+glG
eeoqKjCS4l2JOyWsJ5U2+v3lG9zGvX1//oa6dYkyK12d8u26I5sRTmGcNFzxLXK5NSDBX1wp
qYtt2YxBtNbSKEqqPgVv2rpgtihM4c/YKOD6KtLbqHk7sRwjZHQ7n/X4EVHVl+Ran/CbiIlK
xrcI1+NbXsHExlzEJnJIbSxuXXnDHz2kPWHXv9NlKy6ib02bq5acj355fv/8x5fX3x+at5f3
r99fXv96fzi88qH78arbLqYm56ZgIiGjZBJAJTA9LzxFVtU1WkqAIG8gxGe5c33hGsnNN3by
rM+OCfW+nxrFNi9pg0SEhe9C0WYoT3sEp1KfaAhzgodol/YisEgj7X1LFGVe7QN/V6bLZBeu
0kMeNxSpgiMXBugTYyK1CPauY86RhcfLYoDOtU1euWMhg3pBO+HqIcTPLnUicv5gzybp04m1
uf36IzY7y/TMisP5sYKV4FxNDhsQbHzPJwnyHV/hwnhF9AxXIl6c2/12DZSw48sj6vzFm9yz
vklxuctPbT2+C/I02214y8aXYLsy0Y2Ll2TPFxiLJbYOPS/vduSbsnw9DDSWvwvFUR9v/GBv
8cSBNgvHRQGTNwPOSKZ+IN8XdxyT/qc4YxB5tfJDu8nqTHyYtTdYMs4/VcxPJQ5wE6w8u1mu
m9ByJipZqXsxglsgCTe7zTRuoybyVA7x2u4Nyizi7Vw4x8HmaH0PDo03Gxe4nYHaRE2Pnygu
ufDmzcDnBCq8FdtCPTFqGPiSv/H8mGi7hGTJga/YkWpUl3z47fnny5d5i0if375ou2CTugtQ
ycBT8GJcM1ldjncrVOuzMS5lcxfEutwTHqSQNrvuOrYz0iZ0O+MPCNfWvZHFUymDUj740yPW
BkLYov3ULIAGCcFsl7F6sYWRgHg+a9lZ2E+YSF5BtWKS4fNlJiNcaHdpmSDjA2Dzr5t8o5QR
1BMeA3P93ALPzBuna0B1+yLBD9bag1D49ZaWlfM08boWkW0NnoPT/vuvH5/B68+t+jXOin3m
6MsC1kURavQA5GjdtR/6P8qupblxHEn/FZ1mumN3ownwfZgDRFISSyRFkxQt10WhrVJNO8Jl
19qu2e799YsEKRKPBN1zcJWdX+INJJBgIpO1bmj55HiDKfZNFAJUmF+RRRLW0Sh0tJekAhE+
L8HCWgmhNUO7IlEDYgMk4hM4lu+eggHOhaS8x8IHibxvV5YGzYgPsIEgLKlmIi+3WNy0yrZ/
N6J6zQoZjUdS3AW5xIDUQSC2kdSNICeaa9CI+tEcqFvWZWB42p63qOG56IKEuMr9tkTUX/7K
EO6TWHAY14VA3eWBx7cJPdbJfM7o4BFMmyfYTSSAvEDNCAGyHVTauyNr9tPzIjT/ouZZWL6J
A2Z99Dap/GL4k10Haq8lbONUIXCWJAzO/gqf7cXVzFZbHt0JDnCqaF8wn1j1mYuuQ4oKZOAw
rTuAGkV1GaEmNDPqo4kCx14bcV3th/iN7sgQhgEagHyGfU0KDdQowKixay56To88bJ6NcBQ7
oZEXfH1DsorieLE1HMcMmgQqbs+1gjgt1gu/qZqKxvFZvBLGlH2xP6hf74BUdacsUUmguqmU
22cUSerdXKMq0Tgmqv7G75isiec49ndXolzTaERGOy9yid7XwwW3Lclk/6Om2XNFz16Lyu8C
S0wwwNssMZohw7kXBrr/KwGUvkMQkh6/Buj7h4gvCGM/abuytpZrWCYCtYNnMq7rn8DruBa+
TmIbbLbUSkyfudTsilKfG8IES1Jy6jYgjq98jhvcf1vcZd58g1t7fGCIcKOkmSG2iQfzE8ut
LcIUDSUrNmhSJpHRw0CPLO+HJ4YYjaoiwRQpjVOxo8GE2c8VnIVLaXW1dPeF57jmEpxh4T7Z
nLj3BaGhiwBF6fqusbo+8MAmWBLXj+KFLhN6shW2W9uKWh2SXcW2zBJwF05+Tf75UDF76CqJ
x/Z8T3RMGXkOPqdH2CXGkQhj+aAQ13cWDlaS/aEsxYQz/DQkEfpVUmYZ7T0tyaltnxpZxgtZ
U1TBwQj7jD0Kso227kYbaV0nEP7zUSK2NO4gbIo4oWC1vl2NmjN5OE+VxDnf9lPZ0YVNHZuv
Okf353Oms0d07TnvDGzyEzjyPBQd2yqK3MwCb6qPg8u49liiDsVnZvg+Jz7PTex4pvw0ttXk
lcEDqmIU+HgGC1ZCElPqu3FkyWBQD5fT6yMvQYb9yYxN83Ex89sxCMlg0O7Q1agy+ZhKrLLI
KpqGuNbStcCdGAtVH1Zo2HLyDat81/ctQyvQKFoeGv1sNyN5W8Quai2p8AQ0JAzrGr6hBK5l
ZOGIEi63TbBQW/IopMuTfjoNWJJb9hyNKVhuvmk8JGHDvricnvMEYYD1HmhRfmSDNAVJwaLA
i61QYJlsAEYxbuivcnG9abFNsxqFQ75lTAUYYod/veVLvRJb1uKgEFpeyOtsNFiuxXg9ojn8
V/AwslWEg7x/PiigJnx8UYFT1r5HAkvedRT5yzMOWALLsijruzC2xLuWuLj2+oFYAhbqorXn
iOwBXkNiS8UMEzSURdapZ0TXaCQkYbGHLyNJRUbqU2+ik+WoKDMdP2cEvV2RmHoun21rUoDR
h+UAF6otSTyyef5Mblhbr+HNsPDyIMfOVP1USClMHVwCuU5v8TmlMqEG6TJLQGx9wjHqfSS6
m+6OEhezFZd5yp5aC7kLwg+OBJhWL6HFFj40L49Ky3NwAnTv5FBEPcs6FWCIm0fNXFxr9Alf
h4tVkNR7FKPK5ZWKcQFlmQiLdwAaG3E/ksk3hf/DhugKvY6ibzY1pkF3x7MQSvhiFr3qE2EG
JrXuhiT67pHwvUe6zCvyRv7AVW8E5Vwe0owqqcbwWGr8quZcZROEX3mLtYyxyAwBEn2rOX/q
E5QOHmZxgFUPciAvuRZg91h/VNWS60H7dbpc3VNZo6Xn5aFCgSYpSxMQfdrnSaZ3aVZZnEw1
511+8ncpttSgfIhFkKtFD1ExFNLo41TtOPk1O/97fKqrZscrfPNaozAPj8C1goenjyeFBgGs
upM+LvZY5IDm2CAkmT6tgVIdunyTqwNfZuAGEFCLS/iZAZ7bWKKOC54Rl64AZDLv6aLDym6P
67TphSfLNiuyxDRCKK9fHy+3W4L3P3/IT9DG6rESHO3PNdDKYBUrDttz13/YCPAe30HAg96e
W8PgnSaSk96ytPmwvNuLfVvviSdHck2mR+tGn9wS9nmawSLv9bz4H+DhSHFXnvbr20wZn0l+
vb54xePzzz9WLz/gekbq7CHn3iskyTfTVB8xEh1GOOMjLK+hAWZpr9/kDMBwi1PmlTgcVVvZ
96DIs8xKyn/UZgpkc18pHsAFkYHvbLn/sHZKk01ySjr3gr4mpu6EXrSOsMTWZHdHGM+hJwYD
m6fr5e0KKcVA/n55Fw6KrsKt0VezNs31f35e395XbLjbzE41Fw9lVvE5KzsBsbZCMKWP/3x8
vzytuh5rHUyJskQ/dgFUZZ06fbiqxgeS1R1sfiSQodF91jCQihgXqPCV22bCBRIXnW0Ljics
xR6LbJoqUzORhsgSY7LvGFo9uv/89vj0fn3lnXt544U8Xb+8w+/vq79vBLD6Lif+uznuYCjz
0bIGN2y8TXNsJ5HNl5fv3+G+U2RtWV7r44ZqsnumI0tP0PlKOMhup2YkLYcZmOtLbMivFK8J
ZqgtW76lsOpwLtNO9ck2IegjVGm5d/VWWX2zjBsMeJR5MKRL2IZvzYnFWuHGI6xprWUPIZx0
QaJ43xpIul8QmXpO2pw2p1bvyxustk1G+i5RWz1JqKnRasUmASZiKhRaPAeY8nq/mRtjmfwG
BmcrkD+jx1PZuR4MGWxVfH9V6yZ2FUvF+lz99n2j8v/t457zxpgZwYEu0Vsll220aPP4er2H
h8K/5FmWrYgbe7+u2NwyJadN3mR8lqpzRt0fZZ8oA+ny/OXx6eny+idi/jWcFbqOCQcxSmPg
+Egna3z28+vjC999v7yAg4H/XP14fflyfXsDz3bggu774x9adYdMup4dcdOQEU9Z6LnG5srJ
ceQ55qBwgMRxiGlTI0PGAo/4yHgKBLX8GKdnW7ueHAdsXISt68qv8m9U3/V8jFq4lBnNKXqX
OixPqLs2K3bkbXI97AQ/4FyBC0PfTAd0F7tyGydjTcO2rI1lL1Sldbc5D9j8FOgvjfDgkytt
J0b9rNQyFviR4rxHYZ/PXNYs+BkJTOiRoxMnuxjZi4xmAjlQA7ArABzwF2QvcEULg7LuIhLr
ZXKiHyDEwCDuW4fIT4LHKVhEAa9cYAC8U0NCkPUwAAvLAT4EhJ6LLIcR0ftBW761TzyjbwXZ
NwaIk0PlzedIvqcRNhDdfRw72KW7BBsdB1RilNzXJ5dSg8zPaTEVV/bSrIPJfFHmuim2RLda
LpHGpX6ifqTHmZFP2uiMvz5bF02IzAdBjpClL5ZCiF/Pyhz4beXM4aJmahIeI8stdqMYEWNs
H0VLM3HXRnQM2KP009QnUj89fufS51/X79fn9xW4pzc67Fingee4xBC1AzBeEyvlmHnOG9tv
Aws/rf545TIPPtGjxYJwC326aw3Bac1hcDeUNqv3n8/8CHzLdvbeo0HDxv349uXK9+zn6wsE
jbg+/ZCS6t0auo4xSqVPwxiRF7j1x9i4jmstdZ46VFG77VUZ1s3l+/X1wnN75luFGcFpnBtc
K6hA9S/0iiZJi5F3uW9K0rw8UXMrBipBxIug27dHgH00s9DDqLEhXTjVNfcAoLp4dVzLh9+B
4dA7lKHWXTecBp5RCaCq365muuX7jcSAfWKe4BA7gB16P0Dda0gwIrAEHTdklRgwW5sbHGhe
2+ZkqAGIBBvHNKDGCDWkPkGoITU2QE5FxyIMQrSSYWgJSXZjiCIf+/A7wwHaqfHyWMSBuUlz
augaM/zQEzcyl0PfBgFFJnPZxaVj+d4mcaBfgGacEKO7ObkezA11cuc4BK1IR1BHexPeO2gx
veNSNL+eoJ+YRxnZOK5TJy4yytXhUDlEgEv94peHAnMSIZ1YQnJWPNIOUJOypDTPOAPZaGHz
yfcqg9r6+4Axs+6Cbj8KcNjLkq2pSvh7f802OjlJDBU766Jsb0yv1k9Ct1T2anw7ETtNwWmY
n4PbucSPFrQ7tg9dUxKk93FIjMUA1MCoLKdGTnjuk1Kur1KpQaF/urz9Lm2ERj3BwMLe12AL
GxijDAZNXiAXrBYzOTVcOitsWxIEyuZupJCuDQDD7iGSU0qjyBmCBTRLdxFKDuqVQ3es5phu
yc+395fvj/93hVtNcRZC7p5FCgiRU6OhSWUmuCRQA9FraKTs5gYoO/w18w2JFY2jKJQXlwJn
zA8D1I7V4ArxEso214SggnbUwU10NSbVvsFA0TcQKhOVFVoNI66lf+464hBLt58S6mi2wwrq
4/YMKpMeD1Sp2KngefgWT20GY2i/5x7ZEs9rI/ncraCMHz0Vu39jFpEIRzeJo+xXBkYXMEt1
xhKprXMy7+Pu3ST8tGwZvTKKmjbgeSBfDscaHFlsOy+oy5sSH7O2kJnyLiaqeaWMNpEWQ8w2
zK5DGsy6V5mzJUkJ71nP0usCX/OWK257MXkmC7q3q7i+3ry+PL/zJNPnGmEj/vZ+ef56ef26
+uXt8s4Vr8f366+rbxKrciHcdmsnimO0vSMe4IZgA9o7sfPH3LaJqN41jeSAEAeLGTnDRM0K
FpP89lPQoihtXSKWDtbqLyK6yX+s+KbBFel3CE6utl/KK21OezX3m4hOaJpqzcrVJSnqUkWR
pxr6zmRFDg6f0/r1f7XWcZEySE7UI2YXCjLqZ1WU2rny4gbS54KPnRtgxFhrnb8jnnw4vI0k
lV9e3WaE42CcsZ7nMOLI7NCTw67pqKZ5t8FwtOdWWiqq+g8Fcp+15GQxBxbJRiGQWozcZp5h
GLBq8XKxnXJIymDFqA0ccgowYogQqbl6+OxDN2dRZMt3PyMJXyWOxdJTTJd1FDCy0Le8EeHk
ixmmbrf65a8sqrbmp5iT0SoaIp3CiRSZiK5G5OtUW41F4Gnedudao7Zy4jv8qQu0PX5cOKjB
5G2xuL4xBdJ8DZ1bYjYMMp5o7RCOdpwSyQ7oNvsBDsfGkhvbqq1Otokdc8ZmybIMd4PQlDX8
lE4d3KxtYvAIatEGeNMVNHKNzh7IuN3kJGaxexwxGinhuy5YQRxSfS4JpUKersm4FyzsfiAq
IovV+NzH6DsYCXYxWRjeqsK6ltekenl9/33FuG76+OXy/Nv+5fV6eV5183L6LRH7Vtr11oXF
py91HG1lHRqfUH3fBCLRF9E64ZqhLo6Lbdq5rvqISaLj940SQ4A9vhpwqhlCT6vbwS5VxeQ9
Rj7Vaj3QzoNphUnvvQKRH8g5IojpPyb/P+lfF2YxNaQMX46RfesQcpU6rVKauuv/7d+qQpfA
Gy/8kOGpL8QUUyUp79XL89Of40nyt7oo1AKG63Nkj+QN5XvA8h4peOJp4bVZcrOhut0trL69
vA5HH+Pw5canh0/G1KvWO4pdLE+gds7gtJoShKZNJXjw5Tk+QtRTD0RDjILebz9XFNs22hbW
igOqn2VZt+bHWVNIcsESBP4f1qLyE/UdH/MxM56QG34iMDc62BxcewN2h+bYunhUU5G8TQ4d
xS5PROqsyKrJKDIZ7LbAV+frt8uX6+qXrPIdSsmvePRyTZQ7cWyIDj1euKosGTqRqEb38vL0
BmEM+Vy8Pr38WD1f/9e+HaTHsnw4b/BIIDZbGJHJ9vXy4/fHL29YmE+2xfb1fsvOrJEvaQeC
sA3c1kdhFzhf/XGwvc87CJN3wKxhUjmYBP9DfIk7p+sco7aK1xygpzUXqCfhYznN0HkFTCLy
WKkVNFDbrNiAmZKK7csW5kWtGjHPqXixZdtBlNZDcdg+nJvM4ukUkmyESSzqYVfiKg4sPXMN
OwVbp1KP3Tu2FTdZAHALYU3BUdet1lprbBika3dgnTahU1Sp8QP1iotB/HYVMhAx03f8FBio
GQ9xvQsllsyNDjGC4dYwjk56IxVYd7EuBWyy1W04ujQldg8t+uJQZilDs5VTqYkalmYW18gA
szLlE98KV4djnzE7nscEFb4c6reZNmt7Pph6n/Xl/XaD22yIIS6Zb9OnoPYtfmsklt2WbSl+
YoBuSVgD/k13aWksTIEVfWpfFncni9tqjq0Pyc6ecgiUftb6XGKoWZVNYWPTx7cfT5c/V/Xl
+fqkTV7BeGbr7vzg8MPkyQlCpvb3yAGlZk3LF3BhrMuRpT2258+Ow6VC6df+ueLKmR+jauqU
Zn3IzrscHuHSME6xgoGj64lD7o98IhUBXnYKIYSx2BYzCwwFntj6ZWFmyYo8Zed96vodkV0Y
zRybLD/l1XkP3mPzkq6Zoh7LbA/gLn3zwI9n1EtzGjDXQVueF3mX7fl/sUvRvCaGPI4ikqAs
VXUo+PZQO2H8OUFH9lOan4uO16bMHF/VVSee/Y6lrD13rePjeF5t07ytwXv+PnXiMHU8jK/I
WApVLro9z2nnEi+4/4CPV2mXclUvtowdK9sj788ijR3Lh3YpW863dlz/zvIiW+Xcen5oOXJN
fPDgrSoirszvCov/Q4n50DNolVgYFkdGKHcQhBTV1jDm2CEB1qclBIo/ncuCbRw/vM98gvfo
ocjL7HQukhR+rY58VluOLbcEEOdVuCg+dOA2JWaWjNsUfvgC6agfhWff7ewSbkjC/2XtocqT
c9+fiLNxXK+yCuMhieV1MdYjDXtIcy5VmjIISUw+YBlN2EyWQ7U+nJs1X0Gpi3Lc5mgbpCRI
neWJ3AaZu2MfzU+JO3A/OSfUmNLCXn5cA2CyuIay8yOHU4MxipjDTwut59Nsg0bNw5Mxttyz
hw3PztauLN8fzp5732+IxW/7zCvehRZ3fJI2pD1ZvlsZ/K3jhn2Y3n/Uohu353akyBx0yrV5
x6cUX6ltF4Z/hQXdjhSWKO5RHjAHZ8nJox7b15bOG3n8wGf78oPe6FIweOcL4b7ducvLtKvB
ot+hUcclB9rIkcNzyy5jFlkleOotQW3nJLbmWDyM55HwfH932lpEVJ+3XD85nGC9x9T2cW1i
56Kxzvj0O9W14/sJDXE9Vzt/yfVbN3m6zbDmT4hyhJu18vXr49d/XrXTXJJWLbYOIQ71ocrO
eVIFdGGfSnZ80oAbK9BnUJeIQg0bd3pOqkSsKLX+Bc8CZGbRRTGhaxsYB4QsYceTdqKBF815
FwSE6un4ye58e34jn92zLYOWt3wRpPUJnKdss/M68p3ePW/u9U6q7otJy7a0HPSyuqtcL0Bk
DehI57qNAtTTscbjGRlwVZH/5BHuonTgyGOHGgojkCnqd2JA4XCLTrRul1cQzjIJXN6FxKHa
ma07tLt8zcb3AgFdRJfThotopDdJxUObctjxLX5Te8ToSw60VeDzgYxsk1hi0Y5LkGudEtoO
0QhVVVG8reZilVWnwLW4BNEZQ9x/nsEWyP6LblcBYIvvE0P+SdDZeGdl5bTfngjJUe7SOvI9
rT9m/dYkntluPZSPwzltl+AkU94p26Wc2qSsq1if99Yml6d2g37fgx5vknp7NARk3jRce73L
SptGPayjVL6sA3c1AO1OkeuHqQmAZkblQZUB1yM44MkT8gaUOd8r3bvORJqsZto13Q3ie79v
8YEpsYSub/lWCDr/+nASJoRWjgKkLBZXVIzUaXCHAK5MsrZr/4HsdFx/gCfd4l00hHXZa1xF
voZn8alw9j7YWb5evl9X//3z27fr6xgjSNoIN+tzUqZcdZHEHacJhxAPMkn6fbxwFNePSioR
C6rPWsTjA5SzgYeZRdHwbdAAkkP9wPNkBpCXbJutufKuIO1Di+cFAJoXAHhevL+zfFudsyrN
meLQVzSp240IMmrAwP9DU/JiOr6XLKUVrVCeZ2/+n7EraXLcVtL3+RUV7zBhHxxPJEWKmoh3
gEhIYhdBsglSS10YPT3ldoX7dTuqyzHjfz9IgAuWBMuXilJ+SayJRGLLhLfvR7Eio/mg64Ej
HDxk/cGsE/gTKYvT2awPOKAZt2e5VSbYj4L6d1bQMVdQfvv0+j//++n1GbtIDD0jVQAq5gJt
GL4kgw/vYr0Z+i5sCAbi8TYCkJj1RVvi+49SVHjnBS8n/BbIUR6Pm+1aGSer0PamDSwoEM4M
3uJ724AHuXRB58MroSgK/BBKoG1x8WKF75EECB1NN/EO96UNouGEEDcy9e9bQ+t39yD0pixQ
b0vg+0KAkIsYkF608Dbuxd9yFa3FKC+8QvR4b3H1LLAo9+yLQ5Z1ndc1vhoAuBO2qLeinTAo
qV9wSYtH6JRDyZtoRlpWeBweCfhEhR7w6J3RM7ohVQc2nG7dNka3jCC9Mfip9d3oMtcrcRSW
1jXzFhPuEYSoyQcF5XATZmdlydkuwBeP6FwnVdfh0+ffv758+e3t4T8fyiyf/OMs55hj8rCT
l5WE89HDlJ41YOX2uBG2f9ihm0iSg3FhfJyO+gm8pHeXKN58vJhUZfXcXGKk31IEYpfX4ZbZ
5bmcTuE2CskWbV/gmHxFeIpLGI+S/fGkH8iN1RBC8njUd0yAruw3k1Z3LBKmmx48aJqZ7MZ0
8McuD82LZwum/J2jNVuYmiu+07JwrLgYNpnQ63ELCxJ9YgFJ03gcsC880lv21QqUifC5DhgR
Jk7OBA2ao5XJjhVkQGma+KEdCrlhKbTPlJNpb08m0Wa9tJJnjyVdioWW7gDRQIyYCVrzIM4f
F3TFYeHCZPtd1rK9iGbdlc07XXTIkwB1xau1WpvdsqrCajB6T0erTXN9KfiOcpu+l0sTyzoc
IXPNKlbZRsXh9yCPN4RxWXkC+yw8PlNLY8nKvgtD4zWAc7dk+ozXfaWtM+TPAVxCmb6QTDqE
ThWqp9CDwxmpVDJwgn6/AUhNxhzCQMvcJRY02+sPQYGeM0KrE+wTOemcrzltTBKnHx29CPSW
XJmwDU3iB8N14EQZiqqRsWEvJiZaAS6QmERW3GgLkFsZH1FMHr2oj7GMmGDZekgvy9q2SNs6
Lr/0spEb2DM5/1cUGm00uggUtofpJU6Woq2z4WildKHtoeZUgken4AtaVB1udMmi2qHi9CQY
4Z1TNwhhdzr0R6eLe3BN1SI9D5ew7OLN/ND43tLB51Mo5DEssKeswAmyNNCLMD/dQrhytnzh
yA9Awtpzv2FNv90EQ09aK4u6KSPzie5I3aJUyQvZ4PwuQrL9bnBcScn+cL1IaegV/MnZBeCH
0TebTU6HnNtD9xAkLrXQl5GyfLnKxSgayYM0QO8TT+g2db4pOX6zXYJPXZCYQcBGchgF+IbW
jKPb54BmrEij0CmIJKOnVRLl21B/1jjTEpNGeZCkqUNL9Xujspkz8wkO0E49lyalHi97pNNb
11JG7TILRKgXbztIJ2tXMde+zwGPgjxV/0CenoLEFWlOQpvYCYv/tnQ0gmHtKLHIaiBWtLUj
rq6o2hRypQhpHF+mqgFBzzh2s1PCPCONlRY01BFOxqyiSo1dVBXJSopAaKdakUKnAZLiZ43j
SLFfaZo4L86e4D8S7orihpt1Cyx32PBFh2Tq09RzYWWCPW8xJtjjGUHCV3xrDbBDl3p8MckG
Jptg41cHYmT7AiBK8bvdTxTfG5pGeYqvWEY48WyFKTiOV+qsgqz6D24kT3c7+kufk7YkK40u
bJw1uCT31c9V8vgSfE7eD6vk/biYk/DtLqUC/BjNznWE3+JQei0vTv4mVfBKmyuG/MO7Kawp
X5WEn4NWPIg8LrwW3C96R+YLeCAN1Zz7RzuA/mEu7PZgt9JrMsRVevOXfGLwZ/FYt6cgtPe6
dMmpS3/vl7dkm2w9O9TjgoB43FQDXLEw9uuLJrud8ZMwuYYpxHSV+6fUllHP47gR3ftzlmjs
/5pTT3BAab0XJA1XVNGIv6Pi5aZnzf1D43ILQ38J7+xo6Vq5R3nOf5E+0vSzFiWHRAkLuuc5
f/Uf1idiBSx9+A68eKL/2hjztr2UAoep16KlOHVAzNi8yPzdW9+OV4/JUHDzwGrOp1ZnmeaM
Rg+1z+KaCweO2Y33ggbaEWGjMA/I6q638wTwSFYqp0LB+yyi2jJhIGSxXKcceu4iYk6lLYSz
tnYOTIGGJHL/7CZxBsshvy7TeCL8wZXO1dKqLvyjW0UOF8yeRjhkLIlkcGo+XM8F70pnvUyF
GFTyFFkweTHVGOrF3fdsdL0K7+yOr8/PPz5/+vr8kDX97BhifI21sI6OtJFP/ktzhjxW/Mjh
Wn6L9B8gnDim6ASxjytr9SnhPhfq1i80Kg9ur8YnoMmLoy97Kor2TsKsyI6FvZyfPvfX+ZZd
7J2LEWkbxk8uVLCbrGlveMxd7TpDNwh5ORdJGGxcqVDJo3me5IeFvXDXsLq3Nz9GEC6ZlSXc
q/BxyKb3Jq5Q9bHTOTIDIf1wr65Wq8iKlMJaxA8n589UqHP1YKykF1PvW8ysexR2f3bhOVYC
Xh/RRNSI6tjL59fv0s/96/dvsPXK4SDnAQa28vyqP/ObOvPvf2WXdfSHjnbtiEkjH25kMNJZ
MUEsTtnyKw1z647NiXjkCG55zdPgON3mNHMfahoa3Lo1uahm0g99V5RIToAJ8zTEVbrCPM5G
HTZn0p5R4+azidy8SLKCmAE7HNRbEtOtsYEEgb0xoSHD+boC4oV53Ab6uxmdjmb1uN3Gzn7W
iMSx344fWZIAO/DVGbZ4Lz/GEeraRWOI7YMESS+zONGdLkzAIQ9THOgGntn7QYJuBaGfyTyK
ywjpLwVEWG0UtN5Yige7hmpy2NtSEtiG5RYtkgBiRGJHAJcRBXqTS/AaCsjzlEnnQe8Q6wy6
EyWdvtt46IGvOLvgHRUxMqHDErDbDZGvEbCjOmtwFKxsykw8W//iembBHGEsDBALAGuTW7jZ
mRe4Jygnu3B1OApbCxEHdYsWV+KU74IIUSeCHm4RuaM8jZyN1ZEeIq2t6LiYjhjafaeOJRtU
MuC14tA+RptoTbuAo9R0Y2+2z0gU74gHik1f9AaWYIfaBsde99JuZrlDVNeE4A00ozxH5gmF
7hERUmXFAM7SfZBADPQprpfLJBYfQZIifQ/ALt17AbwSEtzbJxwL4BuIE4y/MNO5VNRYHPCX
CUBU9AQYbbDWGwFvkhL0JinaFBG5CfEnKlFfqnGwCfFU4yD8Py/gzU2CKjOnQ8SYi0LMddPM
UCbO8Y2kd0KhpqMQu8kKVIikQNeS7uIEUztAx7OMrdczOoIGItYZUmTuVHR/LYQNaFcC4wqC
d6uqeDKCD3vAkSlWkldKJ0GV5krm/NSVsXP2KJHixIh7IKwhuFDNaEtPDDPHxrdHRPx1YjFa
PGJ9vVZ232YB5yz0+brSeeJgTbqBI8HM/BHAx+gE4m3D2TZOkAlDrJ0j3AQAJPadQyuGYuAE
WZJ1hIcxZhRKIEGNeIB2yZrFJzkw004A8SZFhiwAuwDR2BII8aTEIgMxUmR0qACZkLoj2ac7
H4BNRloIplUQ70idARWDmSEKnMN+Aw5vWD11+J0SSJZ3yrBaAu+ErLOsT8ojZ57dgi3Wnzwi
Ybizz+IloqxzDxIjbSOjY2EWrLBx9lGEaEowftjhjDSi/GSL5C6B1A/gmvrK0jhAJyFAUEev
BgNWKUFPkSaFWF8Bai4DsjpryzBhyBQq6YhuAjq2MgB67KvtLl5fWcoYZuuLLsmyZvIDAzZx
C3qK7Zgouk/aR3Rd0CF29gZRGJKOZ7nHLEtJx4u+33nS2aGbOoCgYVtmBk4gDpOb5lMZpajZ
C6uJXYwoU9YlUYwKnUTwNzMaS5KsTWQV6cVSExm/AMSYXqnUDRQPECLtqwBM4zYkEUYrQWfF
soGr/aIhRdNknlc1Ju8FYUUZ25ti9Gfb3bBcJ2d5xm6ukYWyoOCuKbpnu8AmoDamTy1pzgh6
cyb4ewXvBqeDEA1R3qiQBtAOCdVpcJG7z1POhbHPL34OB7lTfhcGT0urU3dGu0EwtgQzePuz
/oYT0huPJKdi8D+eP4NrTSiOsz0O/GQL7mzsUomuQY1UicFTCeeDHo6rfYUfDrR8LLBnlACC
u8D2blYjOxfi193OJqv7E8FPNgEWIkXKEnugC2jT1nnxSO/cykq6undyujct5dgVVEBFd5zq
CpwB6d8t1OGIHW7Al5RxAZolgOjoNbNLQJ9EWT2pnCg7FK3d9Uf9xbaklHVb1L1V4UtxIaV+
CxiIIi/pQsguxeMdP0oH7ErKrsYuF6pc6FX6M7JTPN1bn2tEgAuIB2yWregswgdyaJ0e665F
dUbf6qr6VbwQA6yu7O/KrKmv6F14iVKrlUta1ZfaotWnAhtGEx1+NFhDzQxHY8kH5LZnh5I2
JA9xYQKe0367QT69niktufWZNVBORcaEZGBPDBVDCS//7Aoxcj+WhJ89X7VUDQGzdVghFD2v
j52TWg2HqhR/eioZ+rIrpFh6WaoOs2wAqduOPpolaYjQ67QVo0LrVI3ojMyGdqS860GlJVXo
pjLLUaJ6a28UcULmB0Deykyc8ArIo8MmDppzPP+saC2gJJV0kJTZX5TkzpUzAr3IGtmvxpoW
PBma6XFSOC0+eq2yiJSNnEbtZZzvsqgePXnyjhJHSwqikHUx5VGfrhb5N6WtA1vTiaXUS+A7
jXD0bpBMh5G2+1Dfx8QWs0Cj+xusK2ylIVQnp9QxCMBTzQl77glgD3bA0PDITOpaFKzunEn5
VlQMs1UAe6JtbTbLRHEGwdM9B1Otsjux4nU7nPsDSs963tVs/GVykLIxIotiNsrslta0o+bq
wR0AZaigK5sJrrWqLLThVAtLwLjkYmdlfzQ+Vluu7SG8PT8M9TkrTN8RSwEAXzxrzFUBshjO
8Mocv+wLDH3ZFGBeehnEv5V88ohZiVw6ZhDTEOHDOcut3D1fqNv7stGBCaqqmZAzvfntrx8v
n0X3lZ/+Mpxlz1lUdSMTvGXU48gGUCj7cPFVsSPnS20Xdu6NlXJYmZD8RHH9290bT6hs+LCt
RYcq39ZIczE9hEZzbeGtFcWIaoGykAXPcChr/XHgTJpe2qXzygTWMOYzLWAeHVqrKEMs+yfP
/wmcD+fvP94essWNee72DHzueywHGM/P5hOOmTj4XhssHPbQxBIpuyOm6oDjejAvRcmqFkeh
UrC5UabZIGUVa6FarPk8IdEES3bYeZ57AHop4KxB/OfJsxcVKRIhHRs76+zjeaWJzvyjF5s8
gq01MeuwWZKJ1UVXGNI0UlQ3z2Ly/O/vr3/xt5fPv2MDdv6orzg5UmHW8d7jAoJxsapS8oqV
h8/S7eT7d8RzKofsd+YLazcyfZB2ZjVEKX4/fGZs4z3mKaCiV8usgl/qZZNhYc/UwbGFMSZp
xArbrMbXrZLz0IJdWIkF53C+goP76mS6GVChQSmyiJffkyrahLHpjVYBqNtsBV1DI5aeKgjc
/dVvQCzU2KZaF5MUrd1sILLJ1qLTMojDTWSFe5CQdBOBbaEtaGilpjxLYCklW/ze/ozvQ1w6
JANs+KEb2hKtaLc1HjlK6rUljVMS0TL7GI0LLOHRNYFRtibab7dulQTZ81hixOON5z3EhMe3
2/g0do0NHDGs4im6zTnKOb1AUN+ixBsixraSZjiJ7CZVHj8QYmwLgjBMg3DLN2ns5uxxLCLB
lp4gQMPqkMzD1OM7W+LTPd8t7jJfNVsXxXt7iC1uPSzhy4Joh/pwlHCXkSTe7KzEujKL9+ow
zkqN3Ha7xI6pYA8iT/QWiddd6HmJqTKg1TEMDujMqBqIR8GxjIK93ZMjoA7ILMUm75j/99eX
b7//FPws7br2dHgYfa78+Q2CQCDLhYeflpXTz5ZqPMCKkjntw+88Q/egVOXKW9aUuduq5U2I
ju+rnpvn/kprFNkuPawMUYgwfLh32E6M6mKxoGC987p90Wi2TAAx3Lm6BLymBJt4TVuYC08t
0PMnYWh3318//2ZNQnP3da8vX764ExMsak6GrxKdbPvwMLBaTIfnunOrMeJ5wTGbw+BhnduH
E3amwpQ+UIJ5XzAYET99Bp41vQchmVj2F93dAyPTwFw55RhikD0uG/nljzeIvfbj4U219DIg
que3X1++vkFUlO/ffn358vATdMjbp9cvz28/6/aU2fQtqXhhuTVDq0dEHxFPORti7fAaqJgx
8UA9VhpwBGKL9tyGo0tVTy06bIucZJkwpYoDRI24a0chn37/8w9opB/fvz4//Pjj+fnzb8bj
CJxD23UQfythmlfYEoSKyWgQcwo4SeFZq++LSMhxqglUi0c5GAXlpDtGkdBkwJs0OCoTM4ex
9aMKwvIEv+g9wTvPO0uJ053P+eEIxx47SsJFGqa7GH/ONjHsdx5NpBi8UUFH2Dc3KZhGwSrD
LcKNHfV1vF1NfAebQeuVT1a+b9MwWU3fDgNuw8F66SLUHmm7zHSaAgRhcmyTNEhdZFr1aKRz
Jhamd5w4eUL6x+vb580/dAYBdrV+S0UjWl/NFQEW37YEYNWF0flloSA8vExOlLXpBxiFjXa0
B9NMBxdDCFl5YzLKMtGHvqDSs46nXHl7MXZjYFMRiues2SZmcjjET1TfzV0QWj/tMfotNeNg
TkjOwdciKhg6yw5XChpLssPWLRPD+c7SOImwEriLCItB2KTJ3lwBalC6f6f4owO/9QyE0auf
5k9Iy+NMPeSygIKXQlWkPiD0fhIiudwEPXbJTXaEi1JYvSW0SfBrRQZTlGBLA4MlQQRJAikC
sG3QpXhfSGS45phpMDEdPkbhI1ojUjKCb9XMY6Th6WYTYQFE5v7K4g4tNhcr//2GuMCRwYMX
rEStGDJo1AyNIdZfCugfhkh/UhZt9AcSM/9F0BFRAnqECFJ7SdMNKhY8F2PZGErKhGkKS6Gg
nbdfkxTJsHULI/VH6NUsa8MOGLZoPSSCvTbRGfS3H4aqCBK0O/c7j0uQpd+2cboqXaANtkhP
KQ2FdJUYRmEQYsMoa3Z7S0aQB6rQc7CGcqcEpM2i0ONdwyzNuraUwrjP1nR5e0uCYA6K23z9
9CZW3/9en7IyVnNUeEJM7Qq6FdBBR+I1OYWZKI2HI2FFeUdTTsxdHwPBXUxpLLswxa/S6zzb
v8GT/p101noh5+F2gw1Ia8NLp+MTMO8eg11HVqfgbdphHQX0CFF1QI8RO4RxloRbpHSHj9sU
G0BtE2cbVBJATnGDVhN36bd2lenpXn1k+JJjYqm6m3nEJ+X++7dfxAr+HaknOTh2RGadTvy3
CfB5NHNcyNscXRLtsYlEGPHIfDRtuM8XDPmzWKi+vqdQJtffSEFyRpQNboaLnKmuGa5CNDHi
xqIAJ5rKC8pScqCNLsblqUZF9SubgMIpoUnRz+xJ2dGWCGk7CURjuw7kVgC3ZsFLbxgGm9qi
LQQtMXbDmuwM36Ky0pQ3Lzb6LlCSNuSNxTdySTfRZ8h1YCemrfcXwKgJ1MJyhjtSjT4ZGa1D
wRE9835Q6S7XUsQKx1cR1TClBc9dm319ef72pnUt4fcqgzu7Vh7iJ6x3sEQO/XHy36L5Y4Bk
jlZUVX6VdPzofUwJlVwBDKy+0CXciV4wQB3ptRmmgNDY3aGR5UxJY8rsTJXrWMqQjBWc2c0/
xf4xm2f5mvS3MeAYLpsQQwYpaW9ukImfQ1bgl/8Aa6RSoFXRfsQTE7WgbOSwEya+SxIC47TN
ak+8CJlxVkz3k708Fe3wbSGZQNt7HOsCyo6Jx6Hb5YjeiwHNNPma1esJgYBOPfWESq4g3KDQ
dFlJLuilM3VHfBGZMYIxo5XhrWok4wN6BA/gAkzf9R/p0nG0mwMzBUEjT2GCxi0XvBEveYPr
i8u55p2sgDPUpTuZH99/fXs4//XH8+svl4cvfz7/eMPubJ3vDW0v6Ih4L5UlkVNL775LQhmE
+/Y42urIyYqas6j1NJnDLGDtM40+prZ3l2afJtahKXQ3qhBZkNE5SW4jNR9K0nS1cWw8Qw3v
fNuLM09nHbstHK1APSNUYo8HeXcUv4s6MjJalgQiQ041WCrA+xacqxl1W9p4BKNBXqge6qal
p8Jz7DwxnxqPq7YRP9cdeDFf5WnaOhoOfff/lD3JduM6rvv+Cp9adZ9T95U1eFrchSLJtsqa
SpQdV218fBNX4nMSO+04r2/11z+A1EBQUFJvE0cARFIcQBDEUH5Ql7eA2bMwr33r2YkRgv1Y
t1+tIBiKL/f0/VndxVXUaoo/nRtbGnmHifnli8PPw+VwujsM7g+vx4cTkc4iX3Cdj/WJfFpJ
lLVDzO+V3tyfJKuhO9U1Dm2DGR0ZRc5ceqzSsCIa9QUMMahGv0NlcR65lIRaRFDchFPpaCR+
4IeT4binAMTyykSdSGCuK5C7tc4CcHkbj4e665b2Csql8LsI056Ku/oxhuY2YQvf+CMWPo+2
sKZN9o+YeJHs/AVnA1QJsxufbErLW5FHqWnOpU1xcX673B26JyWoTBTy8mPkkN4KNyUDvYmD
BtpULg24MIspMNRy7PK2nmwzGtblRTFs3kTYrzl7slyzkzL3eX5Znz1uMu4IV9VU6/vrRQ1j
soa/G8+EkfQHCtReCMr+XRxOh8vxbiCRg3z/cJAXvgPRjeL2EanGZWRNUg6e85tmTaHum9E5
r4RtZr3gjovZXJGbX0KONLWIUhGqS5rD8/l6eLmc79iDaojW63gfw44487Iq9OX59YE5s1fB
DdviEYDHT47tK2Sq67QkRB7WFmg70o9BQLeirotg+yWkxc2miqlPqvCtVbDMt9P97fFy0A7Z
7WZWU3eDynYovvltIkkBvftP8ev1engeZKeB/3h8+RfecN8df8JMCqhFh/f8dH4AMMZ+1Aes
+g4OrfJ0Xc77+7vzc9+LLF4SpNv8Sxtb8tv5En3rK+QjUmUu8T/Jtq+ADk4iw5NcQ/HxelDY
m7fjE9pXNJ3ETN04KsOt9GsFAJwL4jgs2KH//dJl8d/e9k/QT70dyeL1SYLG0h0Wvj0+HU9/
95XJYRvTiN+aPa2ojHL0vJAZCZRGQD0OFmcgPJ319VqhQJre1A68WRqEiacn/NGJ4BQhQ0wS
hRwhQPFTgPTGo9FMS+Re79uYyWATmi0PTD7TfqSZnyXcln5ruBP+fb07n6qlzJk5K/KdF/gy
KxB/t1/RbHObvWKt8HPhgfw2NJvSyYVVgSsFWVo67oyLSVCRgVToOKNRp1QlSuoGjhVCyThM
hXmZjqweo8SKpCins4nDKdYqApGMRrqGuQLXPiQcAhYD/CU5+RLYc3Sn40h/M8Kj93o+123T
WtjOJy5+GqJX30ZIlJKU+UCNDK3AsxTN7o0mrObRXFJRcGUPhSc7pt3qX90KQnunQyprFbjM
GhJbJxG3THbFClG90PNxbSvrFaN2m7u7w9Phcn4+XMkK84JIWGObXhvUQP6Gxwu2cRVt9V08
H5HxJvEsffXAs23TZ3fYeaahbCoYiV0Dx3WY9dIsLeahZhkaxnBruUmi4XSqcJzW0rP1Lwg8
R0+GC7OvCOiZSIG4UGISoweimG9jgRE+vDkHo5+gwUlXaC6C6vMcjcuvtiKY6Y2TgN7BVFh+
KFdb/+vKIg4Oie/YeqjKJPEmrs7WKoAZS6UG80FUEDseG+4/3tRls1ECZjYaWYa6v4KaAHo2
2vowrbjzKmDG9ogmkPI9035OwzgkMFq5mjqWTQE33ojoH4wFqhbtaQ9C4OB6HtwfH47X/ROa
TcLWZi5hFToNOEZcenQdT4Yzq+C+CFCWHs4En2c2ebbHY/o8M5gEQLgBkIgpedWd0KLGdH0o
yC5SmqYq4DhfcktHpjxgJmOzzMl4uuNMFBClL2B8nlnGs2MUNp1yNhaAmOkmC/jszoxXZzNe
3Q5sVuoyQCrhigY5ZIhZsMhCUdJJzyu+b8GUtMx35J1mzyuBN0M2uMjVO/W2nm7COMtRlV2G
fpkRk/tlNHXZ4MXL7URnhJjSZ1t/QC3LS/s1A1b6tjuxDIDhboIgVn5SGJIAGWQma2hzw4UY
y9LXpoJMKYDEs0WAo5t9oQJvrH9o4ucg9xCNCILcnvwmiJtZ3MSUUVLKcCUvrcdD2k1Jbo/t
GYWl3npCTAGUVNgMZ8utAin7Jlnwjk9OKaficGpxE6VG6irPGuaKoU14g0JYtuVwgnSFHU6F
NeyUZtlTQWwyKvDYEmPdHlCCoQBr1KlYTGZs4EOFnDquaxYzJcn2qqKl01O3cMuxwmHPZ5Wx
7470yYMw4dtDl/CmzXxsDXsWZKUz3NYDWG8P720F+mYxv5xPVzgK32s7BMqFRQj7UhwyZWpv
VIqJlyc4chp7zNTRt4Nl4rtVnudGX9G8pQ5e+5f9HTQUlecfbmATi26GH7+s6ng8PEt/dGWk
oRdZxrAM8mUnOIJChD+yDuYmCcdUMMVnU2iUMLL1+L6YUvuryPtmmq/XyzMRkyEJA+cHzrCN
fECgPRHNJQ6jcZCIzBh6p8BwImKRk1jhuaAWmxLQV7bEmWVvfqg4mO3omN2ujGWO97WxDMy3
KtMMDYRVCaXqDERdrQx0e25qw0Gw5etTPBFVEaIaNWUhDsTCTyJtkrQhKUycUuOJvK6p+Qp6
CBN5VdNyzWvQu0WQ011pNJTHkWlm4Kopo9Qn1fKAlbJXS5pfZaMhtdEBiMN6nCKC2i0DxLX5
CydEudzOLBGaXRs8j2Y2+nqJsAM1KhvNHO6Ai5ghkVpHY9stTFlwpO7e9AIB0nO4QORsTAcC
YBP91CKfp/R5bBnPZt+CQNrXYZPJsOfzJh0h2xny1h7Ako28fTVDQusSw7Ipz8rerDqBcN0e
ow4Qriw+9iKKXWNdFkjGtuMQ22aQk0Zs/nhETKnAADKRO2GvChEzs6k8AF8ynNqVSzIBj0YT
y4RNHMsUThA6trjDi9qa6+6rjYneW2ANk7l/e37+Val1OxxDKV1lSmuWYXQKUI6hl8O/3w6n
u18D8et0fTy8Hv+LrrhBIL7kcdwk9ZLXdfLCan89X74Ex9fr5fjXG5o+6et/VjtIkGu+nveU
vfLj/vXwRwxkh/tBfD6/DP4J9f5r8LNp16vWLr2uORwRyBELAFX+jqr2/2/Z9Xsf9AnhiA+/
LufXu/PLATq7Zf7t8UtY4+GU54CIsxzyCQo0NkH2mFBtC2HPTIg7IpLFwhp3nk1JQ8IIY5tv
PWHD6YXqgGqYqRtq4IZyS9tpF9+LbOewsV7ytTPU21wBTL1NtSupguAsy126R+UCXQm5BdUd
HyVKHPZP10dtw66hl+ug2F8Pg+R8Ol7N4ZyHrtvHKyWOs4VAvfvQPBEixCayB1e1htRbq9r6
9ny8P15/afOubkpik1i1wbLUz5JLPBjpqRoBYA91DSEJDIap5nXf52UpbNsyn+nUqGBUZViu
9ddEBGLqiD7bZAQ7H6jYILCSKwYOeD7sX98uh+cDnCzeoMM6Gmd3aMgXEtgjjUjcZGQuPJeK
65GxqKJ2Uema3WpZMRXNt5mYToZEG6sgZjENvFdtmmzH3N4cpZtd5CcuuqfqmpIW2llhOo5v
N5LA+hzL9UnuWHQEETQ1BCdlxiIZB2LbB2el1hpXs5t6Y+ufEnoBOKLURVaHtjcuKhjC8eHx
yrJ0P48wwXmPwPQVVo5j9Ymxa9Qa8fdmXuwMeyJYAQoj2HPzNg/EjCiCJWRGFdmemDg2qw26
WVoTsm3Asz7j/QRenBLRBkFsSBxAOLqeEp7H+gLH57GuHl/ktpeTXHUKAp86HGp3E805RsSw
65G0cgSj++xJiKV7/ek3FjG51NQwedGTJvur8Mwc0BWmyIvhiDC2qlFNdKNGnC1G9A4s3sCI
uz63ocEOAbsJZWAVjL8xSzOvx70vy0uYIVoDc/gUGcSJcGPL0huLzy69jChXjsP6X8LCXG8i
oXd2AzLyQzRgwhFKXziuHmtKAox8jVWvljCwI9aHVmJ0X1MJ0JXuCJjo3sMAcEd6uoG1GFlT
mwQb2fhp7PK3MAql+1ttwiQeD6k2RMF68gls4rHFSoc/YNjs+s604nOUJym77f3D6XBVNzos
t1phzH6OcyCCDLC3Gs54nXF1j5l4C2INqYF7L2JbCjOsn7cANsl9ubYc8cWwzJKwDAt1w6hd
zvnOyHa5AqrNQtYqBcbOPlI3+T00xvOp0Z1ZuEz80dR1zM/upetJ3FBRFYlDxEMK7+SEoFi+
6O9e4i09+BEjhwhV7IRRU+nt6Xp8eTr8TY5ZUulFMwkTwkomu3s6njqzsDugUerHUcoOqEal
zBJ2RVZ2Ioxrez5Tpd5otOisctjWe3od3Gjwx+D1uj/dwzH7dDCP0TJDcLHOyw+MIGQ8Ck6J
yNdSCRUnkPKlB/H+9PD2BP+/nF+PeBh+t9uqKLzKzgfDY4WULXxcKjmyvpyvICEdGUONkU25
biCAO3HMFvUrblcX47L+2gpD78/83B2yGa4QYzn06osyaUlBzitlHpvHqZ5vZfsBhkk/PcRJ
PrOG/GmSvqIUGJfDK0qdLPu9yYfjYcL7Pdwkuc3y/iBewo5BVkeQC6dHOiTiS0+ug5zGJ4j8
HDuQqzvJY0s/O6pnuo1XMJOj5zFwdN6LOhGjcY9QjCiH94Gv2HHfV5Ujl37WMreHY54h/8g9
kFrHLCvpDGB7ADgdTw/suApn5ozY0rrvVbPk/PfxGU+zuE7vj6/q5qmz6qXgOtJFszgKvEJa
qO42ujL0xrLpAswNz6haQJ0Hk4lLcsUVc5IPaDtzjMxQW2gCK+rBm5qUjQKQM6RBEDfxyImH
2+7W2PT2ux1R2Zm/np/QSebDWz1bzIxDvi26MaMaC/R3i1V7xOH5BXWVPQsaddIzNrojMLko
2WEKgiTzszWJD60t0TJMiMNYEm9nwzHrQ6NQ5DI8gfMSuXaQEE4BDgjLIiy3hB2LVeZLhK3Z
b6F6yppWmZnrXY3pF+30Ud6wy26ThGa483qy6r4x8GDGd0KQESsNQV6Z4BYY+4HfLUIhS2rX
KQu65bkC4tDffF5y4asRW7lYLxKzSBnoldcEKrQQvZGfW4LKqaWnchnowKxYxlqlwSqUDFZ8
G9w9Hl+66YoAg944ZJnAN0f8+uyU0xSTe/6qyo3U7mEZ5nAq4Uv5+KnqohfezXyS3hdYelhq
xvZ6mQqnen7BpUtSBJhaUkb/rMW7fPl9IN7+epXm7e3nV67KO0BrmoYWuEsiEPUDhW4aIcP5
LxIk4McQXvS9VMVfxIj4psNA3UF+sltlqYcF2h+UJoNT7MqsKIx4jixdYBTGkIgIRFnNp4fg
vFhPZYEoXApRsp0m37C1FJdEWxgOvas0ZL71dvY0TXZLoaf8Jij8fjKXsS3SaqyTDkCv1svz
ZZaGuyRIxmN2iiFZ5odxhjfXRUBjYCCyWcNoEXDDZ0ijdGFiOubWmxeZYk0L0FHBp/GjoyBG
156voc+5hwYldTnCZwxA2mPMddNZ7fnhgkF+5Nb5rK4LiK923d53yJrVRE38YTTcTnXe6f5y
Pt5rO28aFJmetKwC7G6iNICzXZT7fTidyxtv1UFMPv11xJConx//U/3zv6d79Z8WXrBbYxMH
gh27+hu0zTy6STdBlPARpgOPcxisgxbqj83e1bIw9DkW+S5EdziOvav3Ci0A4vJ2cL3s76Tg
2HW6F+wOpWZsSRJW1bDe3ach6Eu6UuMXsmATmog1A83LiIHWG3h7pdP9SO3GI19wOu65IMcM
eJQx/jGQY5oFnAkUkiSeKDuxeTWESnhDSq0wnkxg1FOs8PXIARJyE6Ivh1lY5rMWjmFjUQP/
ct5bOriRxzD1AAiU2/Z6QtPBsKkf1mgUu5jMbN6TpcILy2XNDBFNew4hjWNyVw/UaTKwsyzX
82tH2ZY+oSRhVCLiKDHkCwQpV02/LPjEhFJhA/+nPKsFWRwJ6OxUCh4/JWGpQQrcfVt7QRCy
aUIar2YQMGEXzcs1tahTs/5byCWISzLdvRifdr4RoVQCBQ1J3KofqNeZMtw4YmxjuRPpbni+
5y/D3S2mQVPxk7XjmodnSThHzgWawAu9VwAUZQndw8Jtae/mnPQOGGc3N13DHFlwJiKYXD5n
XF/TiNBfF+RSGTDujgRLRsAaUzDCoQkb0qFta+qieiowgy8jbLVOo1JqC7Xav94ERFjB595Y
tlBfciO7XZdvI4FbndFJDRiIe1wEGxJ0pMZQ1bzAolWw23plyakpv9b1a89Mp31lOwyhLf/W
SVEriylY+CvQrayUac1iLmyjOzJfwbirg7IwWl9DyCe0cnaNlT0rF+MCP4gXymviYp2CIAwT
4PuuEz/KoO4PQqXwnoDx4KX2trpwvoODQjTnBPc0ipseqmeWbfSBBOAAcGRqHnTBbH/VyHrg
2YZLItWhPWEHVDEy5oASdvsCxdT1ASuX+rw+uh8g7HdmkLaz9ohlfewAIzOYfErBquxcWc7N
PgxutkN8pCc9hJfg6FR8z6tcixwYjtYLUh9gccjZAPdz0cQ8q9m3CYgUoJOUYu4pBNtN39ZZ
yW/8EoPRuWTgA7kVoqcT0zZJ6Zdk0njrMpsLl1+xCkknpmTgpDt8I1lpqypS8SbYojPowdj7
bnKPBooZS6MCZt8OftjSOVovvvW+Q4OzOM44NYP2Dh4xNPlFw6Q4+lszGaBGkITQjVlOBqry
Xrh7pDEh5kLuIqwEUFEr8uAPOFV8CTaBFAI6MkAkshkclo3u+prFUU/SvB/wBtvx62Bel1K3
g69b3atk4svcK7+EW/yblnzr5jX30q4A4E1+5Ddzk9fBcx3lBLMm5N4i/NN1Jhw+yjBaiAjL
Pz8dX8/T6Wj2h/WJI1yX86nONcxKFYQp9u36c9qUmJad/V6C+ncOiS5u2QF/tzOVDuD18HZ/
HvzkOlkKD7QtErTq8xpB5CYxvUQ0cH0rG6wTTsKVlKiPKzX+K4E4QpgjOCp1VxiJAnE6Doow
Nd/AjKCY6BJ3Oj236SosUn1cDJ1xmeT0kyWAl0gNmo4I1V4qrRfALW/Y2QnH93mw84vQK0lY
Mfxp50Kti+kOl7YEIqFCaqpYlFxlwLRBql/pVJoewuC8+KzfFslnclmmID2CukS6fz4b5O6u
J2J3lpVIwU/yuUypVCdFCVL24yoiHGE4RQWp8S1BJLwb2JPXQc4lXwUS7sS+KKS3L2y/maaq
wn3dfMSvJRWazkNinRa6Tks97xZwvtJ6qYL2r3g/zJc8p/OjORalPcnpL/TwbwjEUJK3sCFJ
wa3uVbLDItU694GQb0L0zpFBIjtifwvl3U1bvGQPmIW+J7SjJPyN9onb9D0akdygsnfDWmfI
Aqrx08YGdguvT670+kXOWc6PV6qHQIaHensge007QWPRbFc71+Fu7AjJxCF3dxQ34S/ZCdGU
dU81SOzeOqYjzpTQIJnQDmgx1PzUwHFXkAbJO+3qybFhEHHXqQbJ6J06eKcqg6jHDlMnmjm/
UdKsJ5COURKb65SQ0KAAtLWsDSCSgOSHk3U37RlLy9btg02URVGe8KOIguryLR5s82CHB7s8
uDOUNYJzGdTxE768Tj82H8Fd/BMCt/fVvvW0yqLprqANkbA1hWHUcJC89UzkNdgPMTWtWbPC
wAlvXXBRkxuSIvPKiC32exHFsX6hV2MWXsjDizBcdcEgNsYkDFiDSNdR2fOZqkmdLyrXxYoP
go8UlSDf3uHE3LXJOo1wErcVV4BdiuaCcfRDmh02t0m6EEeUrsqT93D3dkFzlk6YdNwF9cbg
M5w+v2FI6h1z0qtF4LAQEYh3aYlvFFG66FFLVUXyUm2xhiKCfoJKY8GQtK3dBctdBs2R3UHE
8O8qWHvkN6h2a64UShh9XMi7+rKIWM18V+dYQ+Z8iZUEzPcacqRSyoiw5GLGcNQsLfdKbhrJ
cMFwvgvCFDpnLYOh59+l2OV7ZpgSk4zT8YCoigocka0LPVadVKP68s0E5t4yjHNdH8+iZZv/
/PTl9a/j6cvb6+HyfL4//PF4eHohN6PNJ4qkLxBdQ1JmSfadVzE3NF6ee9AK/nzUUMWZF+TR
B52OdsnvU2CqcjhbR8FHtYHUnoGUGAv++ralBNbTk9i80RKb9zgL1ZRokXp4zcPfO/V8Sbjh
eE6tPGiXh570Aj7iz09P+9M9ust+xj/35/+cPv/aP+/haX//cjx9ft3/PECBx/vPmCfvAXnO
579efn5SbGh1uJwOT4PH/eX+IK0PW3b0jzZn++B4OqKn1PG/e+q5G+ElCMw5fwUrOzXutSJM
YKpWgJbRtOcyThHPYSfopa3vD/km1ej+L2oiIJist/6abVYo9a4etB3ZHV42KhXa5dfL9Ty4
O18Og/NloJaQFgZZEqMulwT8JWC7Cw+9gAV2ScXKj/KlvuANRPeVpSeWLLBLWuha6xbGEjbn
lk7De1vi9TV+ledd6pV+D1yXgNcAXVLY9r0FU24FJ8eCCoUMkjsDkhcb9YFxzVdRLeaWPU3W
cQeRrmMe2G16Ln87YPnDTIr/q+zIliLHke/7FcQ87UbsTAADDL0RPMi2XOXBFz6oKl4cNFND
E91ABxS7PX+/mSnL1pEqmIc+KjMtS7KUt1J9twQJzIzHTV9xVkdW+I1Nt/Uor+Db528Pdz9/
3f51cEeL/P7l9vuXv7y13bTCaynxF5iMYwaWLJmuA7jlEjgmdJMw72wLfzKBRV7L49PTo096
VOJt9wUT7+9ud9s/DuQTDQ0POPzvYfflQLy+Pt89ECq53d16Y43jwv/oDCxeglYmjg/rKt/g
aTpmMy8yvCONGX0rrzLujuRp9EsBzPFaDyiiwggov1/97kbcyojTKNx83DXcI+yNOFOPIm98
ebPyYFUaMU3X0Mlw22tml4HWuGqEzwvKZXi6E7ACur7gFhtW9/ViKku85DwwqdYtU5p9csC1
mn8beK0o9fmR7evOf0MT/3rsP6nAKj2ER/JQmOKcY0rrNSsJolxcymP/kyq4/zngHd3RYZKl
/s5g2w9+pCI5YWAMXQZbgHJI/TlqisQ6Wa/31FIcccDj0zMOfHrECNql+NUHFgysA5UlqhbM
WlvVp/bRX6VCPHz/Yt+doHlEy7QBUKeUN0dRZn45eJcOFJtV4B44/WkF3v2S+bw2Fmh5Op5t
A+d/NIT6c62SbG1YGhCAI0v151s2tVVu24YPbSuPh9Nz5kMXJ8z8gmW4f1JGgtDwNVq9UX3g
58fveDTowa7ONc1BClYmF0vTvPSm8t5yfuKv0PzG3z8AW3Iy4KbtEm8hNmA3PD8elG+Pn7cv
utYO32lRttkQ1w17UEgPrIkW+pYrBsOyTIVRbMObKMTFfLRhpvCa/D3rOomJ8A3Y1QHFD6/j
oNfu2y8ToVatP0TcBG6ZculQvQ+PDPtGOVyO3fHt4fPLLdg+L89vu4cnRlphQQrB7DIqVKE4
uj7DsI+GxaktufdxRcKjJt3MaMGdHptwzx4BOo6ZIFwLHNBUsxt5cbSPZN9YgoJrHugejQ+J
AhKHUIW/eZe+DoXJyrUgNwS3Q2YsfvQ9G8UgbJci0NRCOmnRHJE6KyUDl+Z4hDgFhye8w8Mg
jmP+6laD5AozKZbnn05/vP9upI3dy1eDhGfHH6I7+WB7upPX/BWMXDc/SAodveYuwzTo3MsH
DRQ6yNYxo0uqD9BIGVgXosirRRYPizWvX4h2UxQSvbXk4e029p1uin9hpZ0/yQx7pSvM8Moy
dSrw7sv27uvD0/3My1SWAvIivKWunfzZhpfTpSCGif+7+OknI+noA2/VTUZZKZrNUMOLuvRi
quYT4reNyJKzob6a+6QhQwQWOki7xoho4N2LogGScmFyLTwZZ40rykCbxPsoDYevPnIGimYZ
15shbapCp/UxJLksA9hSYsZSZsafNSrNygT+amAmIzOyEldNYp3MarJCDmVfROrOzGno6DY3
z+lN5+TibMoPd1AOmBJ34DMOKSqb49GFzBwHUWCyB6w30EjKscyDJQViWMmgAFigozObwjdf
oDNdP9hP2eYV2lVWXMfG5Fksow13JMIiOGEeFc3KUQcdCvggfLtnlgiJ7V+/mYsv8k3M2Ajc
TpbhnJgjyqQqjDEzPQCddMrKndtCaCJ9+A1KPdBocivl6UYJcgcKGjDTMkK5lkHnZalBE+bh
fP9AQ2bICczRr28QbM6ZguB1osxkjUg68Vdzj2XijK9zOuJFw4crZnS3hG0ZfnVbw/5x+z9E
8e8ezL7Tbh78sLjJahYRAeKYxVjGjAHHefVZghks0xwxXlo/6Iaajm5iMPPYKCP5WuRDp+SY
HpFoGrFR3MRgJG1bxRkwj2s5EMGMQgYEjMk8qqdAmDk2WAwL4fZl3nh7uXlZdCllMrQKAWzZ
OhdHOLokXNQUtDPrDjfqhvJBJEkzdMPZicWU21VWdXlkvzj2rubGgDBwauHeQ61cUds/b9++
7bCMwe7h/u357fXgUYVVbl+2twdYuPQ/hnEBraAyPRTRBlbHxaGHaNFBo5AmizPR0B1MKxCL
ALOzmgrEA20iNqMfSUSeLcoCvQTn9pSg5RU6jqM/BiO+20Wu1qbBQel0wxTpMxA1zHl7OVRp
SnExCzM01hJKrkyRmVeR/cuUOHrZ5PZZjTi/wei1sRGaK7RcjHaLOrOKF+LZV7yZF5QFa+HD
ZtD78DppK393LmTXgfiv0kQwJ+LxmcEUmhaiI73BzMeu0FczZWSa0PMfpsQmEJ4RgMmQsbkN
8AB1lTvbhuZ8JcyLfAmUyLrqHJjSGkHFwSuupjXdwmbTB9qm2iyOGmiHTrX6StDvLw9Pu6+q
SMnj9vXez+8gFfOSpsTSrBCImYv2gQ3qaUcJqVGf4b2prN8AuGJFZ08WOSiQ+RSd+y1IcdVn
srs4mZYJsGXMhfBaODFSRzBfd+xpIp176vWa3pSiyGL3zJwF9m8V2BRRBTrSIJsG6DjvmHoQ
/oB6HFWtVckqOOeTP+7h2/bn3cPjqPe/Eumdgr/4X0i9a/S/eDA8CdLH0q6zNGO1jJN8JoJB
2YKCy57yn0mSlWjSoYN1TnEgI+jKNUjUvBrhUnFpZbVY4gpBwUZdGyKyhKY2FgmwpLjJajY8
lIJElgO0XV4cHR6fzDsNHgCRi6fd7QvDGykSiq6Klst8WAIaL6LLQN4Lk6GpobTq0BhmwBei
M7UEF0N9Gqoy37htpBWIpCHty3g8ggXsHKWtwX1oUHWV2WeBrwuw6PBos8XNjTZXUlzSFXrA
9M2V+uG1+A/zTuCR0yTbz2/395jSkD297l7esF6tsWoLgVY6mMaNYZUawCmvQpY47ReHP444
KveODR+HMcsei4GgsW0PvvVX5pR7HkrKnsgw2k6UBZ69Dm6MqcEx48SUYCQDLmGhmv3A30xr
k8XZR60Yz3OibmEtNsKZjSliYMjcaZY4NhqM8CLe1mkqAMXVGUC1yyzt/B4k2fVwIxs+BUuR
9CVsMeAb8LH3UAFT57+LQkvQIfegJ1WLy5fk5nVONcR0RiJhs3w+tPbthaEOgbgbEo/IaH/O
mDo0NWYIZZR9ct3hZTVV6a9ixJMKyPJNeLZalSaHIBjwjbYqlYeHaQ/P9QZXeVMlohOOMTYt
WUWzWvsNrzileHLHdHjOwnxIQbgrwq1WqwgP6TK7e0TscxTYhKlloNk4VIlMv5KNxRzOcAea
uCeRsYfFaFK0REAXHys8vNtjxS4n0XtkqC15H2niQAIjUtB5nFDK6Lh0weTMQWb449OYPeNS
ymzfOqaV7gKYKslII8tEWS7uHF8XPoRyF8byBM4bAdnwxZcmfL1Ic7FgD/zaixhd1r3wtm0A
rC7upXxBFzWKWxTK3hq6RMsOnQuevaBMkNagGEU4I9sDNM7gl9liCd3c/8Hpe+Bx3xQkmafb
8MhRulwKZKt+6EphcZcAxwHhODPeJLGdV4aoTKV1j/b0exaeqSr7pfKKQ0nfI5Ggq2S0Mwb0
wEOHAoTJxEuOT0/d5ztyDqkSvLjZ0NXg9mQuvLEvO3Rm8d5uWWKpOt8hAvQH1fP3138f4MUv
b9+VYra8fbo3bTeY0xgTVSvL02OBsV5KbwQeFZJM576bfScYjetr8xpLvWGrtAsi0QQj55dJ
Rm/4CM3UNSsV3XkZyxARNSx7WFidaC32oXTKCTUN9OTc+HZzl2ZC6hHzsiDt2PtpBldXoNqD
gp/Y2Te0fNSY2BWy/1Orwxmgmv/xhvo4oyoohurYtwpom4wEI+ZvmgBc2+4axTm8lDJQmXVk
dyBIi3oqUo0jMbSkf75+f3jCXEEY5OPbbvtjC//Z7u5++eWXfxklizEiTM0tkGd4/pi6AS5k
FLSY1QZCNGKlmihhyvm+qphzJzxuje7UvpNr6fHqFoY9Rrxt1s+Tr1YKA7K2WtFBB/dNq9Y6
86ygKmpuO/XocICsPQDGYNqLo1MXTDZ5O2LPXKwSuaPrhkg+7SMhZ5SiO/FelIF6k4tmALur
160du6tmpA6uGNFV6IJpcykZsTV+ZZXyMmpzHK+niQM2gW5PpZ5Op4/nT8GEyto4tR5j9+bf
WcX6rWr6gKmTwjF/PBs+lEXmrgH/mdnbZnadHAiwVsCiaqVMYKOrANkeDehSSbn3KcAIAPWu
9UPmik19VebPH7e72wO0e+4weu25qijy7apDHLBlTBF1JAsUb44Xk2o7kCkSV1T+TJtHFjcN
dNN+edzA3JVdpu5RUTlocc9aY4q9xL3LilDLt8fFr0Sko0tlGbjzxOyPAhxWWpqfYyYEiVDJ
JJ/UJOuOj6wXuOsHgfKKreihS0xb8+DZdFejvtk0wWqf2KklCM5c6Y+d1FVyuS0M6DLedJXB
6igzzXA2e7KgrGo1MkMbIUVy8p/txy4aUS95Gu0cTvXMhZHDKuuWGL9w1VmObCzYg051l3wk
K8gIhPYw08Ehwaok9JGRklyAXiOYZugGUeKxNdW0w47wbpL14AxTdSW2ZR4mvMx3S41AeY0p
rkhvpY3gl5brDiOD6O9059hoavSctSvTuBk1CQwdsWP13qfdCe6LRkImruOMGFU8Cgl5TQcX
0zvrKLSE3l89H1g40yabOgHcCOupcLqyIdPN6pHNFSjj6Qw3VCma/RETNOD9B5cr2Mfhx6q2
rLJW+h8JnSzzk2aLWKmToJx7f2QLalO4YhZYRwlm97LyF7xGTPa5vfgiEKWwZscJ9U4RaviY
7wMToR5g0x2j/JIy1uiWZmsZ9NBOJNX+MWsD1qkH0+vBhfMt7OcjNhZzl8xjUe2mhLU2tTh/
WMxoG2+IYS+woEYVL1DV8yzzZ9rCcyibE2QGU2BC3vodIqegOH4DayMovBov/tM3bmk+zSvi
6nr6itPudBuCTQNCuWYUQ6a7f4t4Kl5K/CaROdiT/EnwmQtSbDPcvPHdkBWGCVFnyRI5VMs4
O/r10wnlGKDrim+WvCfveMyo/nM2RkAoBkl61I/zM06PclRgjy/7KrJPI0WTb3TU16rvvj4/
G8ZoLHH0vuafCrSVRIvAA1RFf53Yx9lGyziP0rxnD2yQ9J1YGFfuCTuMSUhY95uv+a25dTWu
gcP1OV9lxaAIBHonij4UKp8oXKY3xrop2k6JTgGNT3AapdUGKSh78PTF982EmjIKuwUUz5r8
cWhbBlNr+nKliq274dRJ/7XXr5le0W1fd2gKoocmfv7v9uX2fmvUyugtR7DyDY7BDBdsh1IU
TK6Vy9I1VhWWtL9gfVdtN2HSAt1RxtQx1VzOrnRqMUCR5W0uuAAlolSgSPspjKesBvcWksBW
CnEpdQ0R9+0kLpUhw46TaFK0698fmRkHtt5fxMbrA88a1gdICyvgPjq3WxD9IE4UjZ1H2YCE
JY1SuaLoJFKIlaIgBj7qfvQRxBpoe1ejV3pAZQT9H2niUoSNigIA

--qMm9M+Fa2AknHoGS--
