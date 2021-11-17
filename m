Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C6045451E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 11:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhKQKlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 05:41:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:40710 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232427AbhKQKlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 05:41:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="221136936"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="gz'50?scan'50,208,50";a="221136936"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 02:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="gz'50?scan'50,208,50";a="454822368"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Nov 2021 02:38:49 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mnIL2-0001Z1-KU; Wed, 17 Nov 2021 10:38:48 +0000
Date:   Wed, 17 Nov 2021 18:38:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
Subject: drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202111171856.r6ahUbut-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ab774587903771821b59471cc723bba6d893942
commit: b3ed524f84f573ece1aa2f26e9db3c34a593e0d1 drm/msm: allow compile_test on !ARM
date:   7 weeks ago
config: alpha-randconfig-s031-20211117 (attached as .config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b3ed524f84f573ece1aa2f26e9db3c34a593e0d1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b3ed524f84f573ece1aa2f26e9db3c34a593e0d1
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c: note: in included file:
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
--
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1412:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1412:31: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1412:31: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1418:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1418:31: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1418:31: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:858:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:858:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:858:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:858:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:858:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:858:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:860:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:860:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:860:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:860:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:860:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:860:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1066:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1066:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1066:23: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1066:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1066:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1066:23: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1458:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *[noderef] mmio @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1458:20: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1458:20: sparse:     got void *[noderef] mmio
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1460:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *[noderef] rscc @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1460:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1460:28: sparse:     got void *[noderef] rscc
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1560:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] mmio @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1560:19: sparse:     expected void *[noderef] mmio
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1560:19: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1567:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] rscc @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1567:27: sparse:     expected void *[noderef] rscc
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1567:27: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1598:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *[noderef] mmio @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1598:20: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1598:20: sparse:     got void *[noderef] mmio
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1600:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *[noderef] rscc @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1600:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1600:28: sparse:     got void *[noderef] rscc
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c: note: in included file (through drivers/gpu/drm/msm/adreno/a6xx_gpu.h):
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:26: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:26: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:26: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:26: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:26: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:26: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:26: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:26: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:26: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:26: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:26: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: too many warnings
--
>> drivers/gpu/drm/msm/adreno/a6xx_gpu.c:1499:36: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *llc_mmio @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gpu.c:1499:36: sparse:     expected void [noderef] __iomem *llc_mmio
   drivers/gpu/drm/msm/adreno/a6xx_gpu.c:1499:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gpu.c: note: in included file (through drivers/gpu/drm/msm/adreno/a6xx_gpu.h):
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:26: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:26: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:121:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:121:41: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:121:41: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:122:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:122:43: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:122:43: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:121:31: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:122:33: sparse: sparse: dereference of noderef expression
--
>> drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c:658:26: sparse: sparse: symbol 'msm8x76_config' was not declared. Should it be static?
--
>> drivers/gpu/drm/msm/msm_ringbuffer.c:43:36: sparse: sparse: symbol 'msm_sched_ops' was not declared. Should it be static?
--
>> drivers/gpu/drm/msm/msm_fbdev.c:115:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got void * @@
   drivers/gpu/drm/msm/msm_fbdev.c:115:26: sparse:     expected char [noderef] __iomem *screen_base
   drivers/gpu/drm/msm/msm_fbdev.c:115:26: sparse:     got void *
--
>> drivers/gpu/drm/msm/msm_drv.c:141:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/msm/msm_drv.c:141:31: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/msm/msm_drv.c:141:31: sparse:     got void *
   drivers/gpu/drm/msm/msm_drv.c:150:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/msm/msm_drv.c:150:31: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/msm/msm_drv.c:150:31: sparse:     got void *
--
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:189:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:189:9: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:189:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:190:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:190:9: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:190:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:191:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:191:9: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:191:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:192:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:192:9: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:192:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:197:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:197:19: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:197:19: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:198:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:198:19: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:198:19: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:315:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem cxdbg @@     got void [noderef] __iomem *cxdbg @@
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:315:41: sparse:     expected void *[noderef] __iomem cxdbg
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:315:41: sparse:     got void [noderef] __iomem *cxdbg
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:189:9: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:190:9: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:191:9: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:192:9: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:197:19: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:198:19: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c: note: in included file (through drivers/gpu/drm/msm/adreno/a6xx_gpu.h):
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:133:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:133:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:133:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:133:26: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:26: sparse: sparse: dereference of noderef expression
--
>> drivers/gpu/drm/msm/dsi/dsi_host.c:1360:27: sparse: sparse: cast to restricted __be32
>> drivers/gpu/drm/msm/dsi/dsi_host.c:1360:27: sparse: sparse: cast to restricted __be32
>> drivers/gpu/drm/msm/dsi/dsi_host.c:1360:27: sparse: sparse: cast to restricted __be32
>> drivers/gpu/drm/msm/dsi/dsi_host.c:1360:27: sparse: sparse: cast to restricted __be32
>> drivers/gpu/drm/msm/dsi/dsi_host.c:1360:27: sparse: sparse: cast to restricted __be32
>> drivers/gpu/drm/msm/dsi/dsi_host.c:1360:27: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/msm/dsi/dsi_host.c:1361:17: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/msm/dsi/dsi_host.c:1361:17: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/msm/dsi/dsi_host.c:1361:17: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/msm/dsi/dsi_host.c:1361:17: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/msm/dsi/dsi_host.c:1361:17: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/msm/dsi/dsi_host.c:1361:17: sparse: sparse: cast to restricted __be32

vim +104 drivers/gpu/drm/msm/adreno/a6xx_hfi.c

4b565ca5a2cbbb Jordan Crouse  2018-08-06   95  
df0dff13290597 Jordan Crouse  2018-09-20   96  static int a6xx_hfi_wait_for_ack(struct a6xx_gmu *gmu, u32 id, u32 seqnum,
df0dff13290597 Jordan Crouse  2018-09-20   97  		u32 *payload, u32 payload_size)
df0dff13290597 Jordan Crouse  2018-09-20   98  {
df0dff13290597 Jordan Crouse  2018-09-20   99  	struct a6xx_hfi_queue *queue = &gmu->queues[HFI_RESPONSE_QUEUE];
df0dff13290597 Jordan Crouse  2018-09-20  100  	u32 val;
df0dff13290597 Jordan Crouse  2018-09-20  101  	int ret;
4b565ca5a2cbbb Jordan Crouse  2018-08-06  102  
df0dff13290597 Jordan Crouse  2018-09-20  103  	/* Wait for a response */
df0dff13290597 Jordan Crouse  2018-09-20 @104  	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_GMU2HOST_INTR_INFO, val,
df0dff13290597 Jordan Crouse  2018-09-20  105  		val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 5000);
4b565ca5a2cbbb Jordan Crouse  2018-08-06  106  
df0dff13290597 Jordan Crouse  2018-09-20  107  	if (ret) {
6a41da17e87dee Mamta Shukla   2018-10-20  108  		DRM_DEV_ERROR(gmu->dev,
df0dff13290597 Jordan Crouse  2018-09-20  109  			"Message %s id %d timed out waiting for response\n",
df0dff13290597 Jordan Crouse  2018-09-20  110  			a6xx_hfi_msg_id[id], seqnum);
df0dff13290597 Jordan Crouse  2018-09-20  111  		return -ETIMEDOUT;
4b565ca5a2cbbb Jordan Crouse  2018-08-06  112  	}
4b565ca5a2cbbb Jordan Crouse  2018-08-06  113  
df0dff13290597 Jordan Crouse  2018-09-20  114  	/* Clear the interrupt */
df0dff13290597 Jordan Crouse  2018-09-20  115  	gmu_write(gmu, REG_A6XX_GMU_GMU2HOST_INTR_CLR,
df0dff13290597 Jordan Crouse  2018-09-20  116  		A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ);
4b565ca5a2cbbb Jordan Crouse  2018-08-06  117  
df0dff13290597 Jordan Crouse  2018-09-20  118  	for (;;) {
df0dff13290597 Jordan Crouse  2018-09-20  119  		struct a6xx_hfi_msg_response resp;
4b565ca5a2cbbb Jordan Crouse  2018-08-06  120  
df0dff13290597 Jordan Crouse  2018-09-20  121  		/* Get the next packet */
8167e6fa76c8f7 Jonathan Marek 2020-04-23  122  		ret = a6xx_hfi_queue_read(gmu, queue, (u32 *) &resp,
df0dff13290597 Jordan Crouse  2018-09-20  123  			sizeof(resp) >> 2);
df0dff13290597 Jordan Crouse  2018-09-20  124  
df0dff13290597 Jordan Crouse  2018-09-20  125  		/* If the queue is empty our response never made it */
df0dff13290597 Jordan Crouse  2018-09-20  126  		if (!ret) {
6a41da17e87dee Mamta Shukla   2018-10-20  127  			DRM_DEV_ERROR(gmu->dev,
df0dff13290597 Jordan Crouse  2018-09-20  128  				"The HFI response queue is unexpectedly empty\n");
df0dff13290597 Jordan Crouse  2018-09-20  129  
df0dff13290597 Jordan Crouse  2018-09-20  130  			return -ENOENT;
4b565ca5a2cbbb Jordan Crouse  2018-08-06  131  		}
4b565ca5a2cbbb Jordan Crouse  2018-08-06  132  
df0dff13290597 Jordan Crouse  2018-09-20  133  		if (HFI_HEADER_ID(resp.header) == HFI_F2H_MSG_ERROR) {
df0dff13290597 Jordan Crouse  2018-09-20  134  			struct a6xx_hfi_msg_error *error =
df0dff13290597 Jordan Crouse  2018-09-20  135  				(struct a6xx_hfi_msg_error *) &resp;
4b565ca5a2cbbb Jordan Crouse  2018-08-06  136  
6a41da17e87dee Mamta Shukla   2018-10-20  137  			DRM_DEV_ERROR(gmu->dev, "GMU firmware error %d\n",
df0dff13290597 Jordan Crouse  2018-09-20  138  				error->code);
df0dff13290597 Jordan Crouse  2018-09-20  139  			continue;
df0dff13290597 Jordan Crouse  2018-09-20  140  		}
4b565ca5a2cbbb Jordan Crouse  2018-08-06  141  
df0dff13290597 Jordan Crouse  2018-09-20  142  		if (seqnum != HFI_HEADER_SEQNUM(resp.ret_header)) {
6a41da17e87dee Mamta Shukla   2018-10-20  143  			DRM_DEV_ERROR(gmu->dev,
df0dff13290597 Jordan Crouse  2018-09-20  144  				"Unexpected message id %d on the response queue\n",
df0dff13290597 Jordan Crouse  2018-09-20  145  				HFI_HEADER_SEQNUM(resp.ret_header));
df0dff13290597 Jordan Crouse  2018-09-20  146  			continue;
df0dff13290597 Jordan Crouse  2018-09-20  147  		}
df0dff13290597 Jordan Crouse  2018-09-20  148  
df0dff13290597 Jordan Crouse  2018-09-20  149  		if (resp.error) {
6a41da17e87dee Mamta Shukla   2018-10-20  150  			DRM_DEV_ERROR(gmu->dev,
df0dff13290597 Jordan Crouse  2018-09-20  151  				"Message %s id %d returned error %d\n",
df0dff13290597 Jordan Crouse  2018-09-20  152  				a6xx_hfi_msg_id[id], seqnum, resp.error);
df0dff13290597 Jordan Crouse  2018-09-20  153  			return -EINVAL;
4b565ca5a2cbbb Jordan Crouse  2018-08-06  154  		}
4b565ca5a2cbbb Jordan Crouse  2018-08-06  155  
df0dff13290597 Jordan Crouse  2018-09-20  156  		/* All is well, copy over the buffer */
df0dff13290597 Jordan Crouse  2018-09-20  157  		if (payload && payload_size)
df0dff13290597 Jordan Crouse  2018-09-20  158  			memcpy(payload, resp.payload,
df0dff13290597 Jordan Crouse  2018-09-20  159  				min_t(u32, payload_size, sizeof(resp.payload)));
4b565ca5a2cbbb Jordan Crouse  2018-08-06  160  
df0dff13290597 Jordan Crouse  2018-09-20  161  		return 0;
4b565ca5a2cbbb Jordan Crouse  2018-08-06  162  	}
4b565ca5a2cbbb Jordan Crouse  2018-08-06  163  }
4b565ca5a2cbbb Jordan Crouse  2018-08-06  164  

:::::: The code at line 104 was first introduced by commit
:::::: df0dff132905974697e2a19aa8bcc0ecc447c00e drm/msm/a6xx: Poll for HFI responses

:::::: TO: Jordan Crouse <jcrouse@codeaurora.org>
:::::: CC: Rob Clark <robdclark@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
rQWlDb5ZrFUAbek7zt7/AcGlpz6HMAIA

--RnlQjJ0d97Da+TV1--
