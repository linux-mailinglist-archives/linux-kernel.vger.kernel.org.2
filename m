Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D3244CD22
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhKJWy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:54:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:64821 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233634AbhKJWy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:54:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="232653509"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="gz'50?scan'50,208,50";a="232653509"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 14:52:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="gz'50?scan'50,208,50";a="452509265"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2021 14:52:05 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mkwRo-000FcI-6x; Wed, 10 Nov 2021 22:52:04 +0000
Date:   Thu, 11 Nov 2021 06:51:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joel Stanley <joel@jms.id.au>
Subject: arch/powerpc/platforms/powernv/vas-window.c:91:13: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202111110610.YCUMggYM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Oliver,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   881007522c8fcc3785c75432dbb149ca1b78e106
commit: 3b70464aa78917e88c1d4bfc2100c344c0eda8e0 powerpc/powernv: Staticify functions without prototypes
date:   1 year, 3 months ago
config: powerpc64-randconfig-s031-20211015 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3b70464aa78917e88c1d4bfc2100c344c0eda8e0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3b70464aa78917e88c1d4bfc2100c344c0eda8e0
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/platforms/powernv/vas-window.c:91:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *map @@     got void [noderef] __iomem * @@
   arch/powerpc/platforms/powernv/vas-window.c:91:13: sparse:     expected void *map
   arch/powerpc/platforms/powernv/vas-window.c:91:13: sparse:     got void [noderef] __iomem *
   arch/powerpc/platforms/powernv/vas-window.c:116:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *map @@     got void [noderef] __iomem * @@
   arch/powerpc/platforms/powernv/vas-window.c:116:13: sparse:     expected void *map
   arch/powerpc/platforms/powernv/vas-window.c:116:13: sparse:     got void [noderef] __iomem *
>> arch/powerpc/platforms/powernv/vas-window.c:128:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *addr @@
   arch/powerpc/platforms/powernv/vas-window.c:128:17: sparse:     expected void volatile [noderef] __iomem *addr
   arch/powerpc/platforms/powernv/vas-window.c:128:17: sparse:     got void *addr
   arch/powerpc/platforms/powernv/vas-window.c: note: in included file:
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr @@     got void * @@
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse:     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse:     got void *
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr @@     got void * @@
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse:     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse:     got void *
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr @@     got void * @@
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse:     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse:     got void *
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr @@     got void * @@
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse:     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse:     got void *
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr @@     got void * @@
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse:     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse:     got void *
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr @@     got void * @@
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse:     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:482:37: sparse:     got void *
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr
>> arch/powerpc/platforms/powernv/vas.h:476:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got void *[assigned] regptr @@
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/powernv/vas.h:476:18: sparse:     got void *[assigned] regptr

vim +91 arch/powerpc/platforms/powernv/vas-window.c

180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   64  
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   65  /*
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   66   * Map the paste bus address of the given send window into kernel address
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   67   * space. Unlike MMIO regions (map_mmio_region() below), paste region must
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   68   * be mapped cache-able and is only applicable to send windows.
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   69   */
5239af679a0742 Sukadev Bhattiprolu 2017-08-28   70  static void *map_paste_region(struct vas_window *txwin)
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   71  {
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   72  	int len;
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   73  	void *map;
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   74  	char *name;
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   75  	u64 start;
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   76  
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   77  	name = kasprintf(GFP_KERNEL, "window-v%d-w%d", txwin->vinst->vas_id,
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   78  				txwin->winid);
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   79  	if (!name)
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   80  		goto free_name;
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   81  
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   82  	txwin->paste_addr_name = name;
dda44eb29c2357 Haren Myneni        2020-04-17   83  	vas_win_paste_addr(txwin, &start, &len);
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   84  
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   85  	if (!request_mem_region(start, len, name)) {
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   86  		pr_devel("%s(): request_mem_region(0x%llx, %d) failed\n",
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   87  				__func__, start, len);
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   88  		goto free_name;
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   89  	}
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   90  
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  @91  	map = ioremap_cache(start, len);
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   92  	if (!map) {
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   93  		pr_devel("%s(): ioremap_cache(0x%llx, %d) failed\n", __func__,
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   94  				start, len);
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   95  		goto free_name;
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   96  	}
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   97  
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   98  	pr_devel("Mapped paste addr 0x%llx to kaddr 0x%p\n", start, map);
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28   99  	return map;
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  100  
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  101  free_name:
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  102  	kfree(name);
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  103  	return ERR_PTR(-ENOMEM);
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  104  }
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  105  
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  106  static void *map_mmio_region(char *name, u64 start, int len)
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  107  {
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  108  	void *map;
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  109  
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  110  	if (!request_mem_region(start, len, name)) {
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  111  		pr_devel("%s(): request_mem_region(0x%llx, %d) failed\n",
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  112  				__func__, start, len);
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  113  		return NULL;
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  114  	}
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  115  
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  116  	map = ioremap(start, len);
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  117  	if (!map) {
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  118  		pr_devel("%s(): ioremap(0x%llx, %d) failed\n", __func__, start,
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  119  				len);
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  120  		return NULL;
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  121  	}
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  122  
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  123  	return map;
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  124  }
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  125  
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  126  static void unmap_region(void *addr, u64 start, int len)
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  127  {
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28 @128  	iounmap(addr);
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  129  	release_mem_region((phys_addr_t)start, len);
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  130  }
180fe15a8299c1 Sukadev Bhattiprolu 2017-08-28  131  

:::::: The code at line 91 was first introduced by commit
:::::: 180fe15a8299c14f77347c5835c98c2446226ee6 powerpc/powernv/vas: Define helpers to access MMIO regions

:::::: TO: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--bg08WKrSYDhXBjb5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--bg08WKrSYDhXBjb5--
