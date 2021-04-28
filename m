Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BA836D66A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbhD1L1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:27:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:11610 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhD1L1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:27:00 -0400
IronPort-SDR: ZLd9ZAT2U/cIyOaRVYUi702zp2acelIK4IdLlIBeO2cJ5lY45UoWR4ccFOCPiTotl7LrvOjLln
 +Ok7eLaRvxwA==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="183858421"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="gz'50?scan'50,208,50";a="183858421"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 04:26:14 -0700
IronPort-SDR: 5tM7jMsrNJElC88ayjVT7dzO2ilLNTbmAJDkeX+FQICTYwzIccW886KB0DtIXAPxS+wUCLV63A
 IPKbic0DT72g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="gz'50?scan'50,208,50";a="604860519"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Apr 2021 04:26:12 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lbiKZ-00075P-SF; Wed, 28 Apr 2021 11:26:11 +0000
Date:   Wed, 28 Apr 2021 19:25:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/dma/ppc4xx/adma.c:688:38: sparse: sparse: incorrect type in
 argument 2 (different address spaces)
Message-ID: <202104281937.5stqP4PZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   acd3d28594536e9096c1ea76c5867d8a68babef6
commit: 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e powerpc: inline iomap accessors
date:   5 months ago
config: powerpc64-randconfig-s031-20210428 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/dma/ppc4xx/adma.c:73:1: sparse: sparse: symbol 'ppc440spe_adma_chan_list' was not declared. Should it be static?
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:543:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sg1l @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:543:35: sparse:     expected unsigned int [usertype] sg1l
   drivers/dma/ppc4xx/adma.c:543:35: sparse:     got restricted __le32 [usertype]
   drivers/dma/ppc4xx/adma.c:544:35: sparse: sparse: invalid assignment: |=
   drivers/dma/ppc4xx/adma.c:544:35: sparse:    left side has type unsigned int
   drivers/dma/ppc4xx/adma.c:544:35: sparse:    right side has type restricted __le32
   drivers/dma/ppc4xx/adma.c:590:23: sparse: sparse: invalid assignment: |=
   drivers/dma/ppc4xx/adma.c:590:23: sparse:    left side has type unsigned int
   drivers/dma/ppc4xx/adma.c:590:23: sparse:    right side has type restricted __le32
   drivers/dma/ppc4xx/adma.c:629:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:629:23: sparse:     expected unsigned int [usertype]
   drivers/dma/ppc4xx/adma.c:629:23: sparse:     got restricted __le32 [usertype]
   drivers/dma/ppc4xx/adma.c:630:23: sparse: sparse: invalid assignment: |=
   drivers/dma/ppc4xx/adma.c:630:23: sparse:    left side has type unsigned int
   drivers/dma/ppc4xx/adma.c:630:23: sparse:    right side has type restricted __le32
   drivers/dma/ppc4xx/adma.c:655:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cnt @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:655:34: sparse:     expected unsigned int [usertype] cnt
   drivers/dma/ppc4xx/adma.c:655:34: sparse:     got restricted __le32 [usertype]
>> drivers/dma/ppc4xx/adma.c:688:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:688:38: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:688:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:689:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:689:38: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:689:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:690:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:690:38: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:690:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:691:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:691:39: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:691:39: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:738:69: sparse: sparse: Using plain integer as NULL pointer
   drivers/dma/ppc4xx/adma.c:1187:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1187:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1187:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>> drivers/dma/ppc4xx/adma.c:1188:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1188:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1188:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1190:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1190:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1190:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
>> drivers/dma/ppc4xx/adma.c:1191:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1191:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1191:36: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1138:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1138:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1138:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1147:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1147:35: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1147:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1157:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1157:49: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1157:49: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:1159:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1159:38: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1159:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:911:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:911:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:911:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:912:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:912:40: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:912:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:974:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:974:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:974:32: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:979:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:979:40: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:979:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:984:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:984:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:984:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:985:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:985:34: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:985:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:986:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:986:34: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:986:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:993:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:993:55: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:993:55: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:995:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:997:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:997:51: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:997:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:999:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:999:46: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:999:46: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1008:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1008:35: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1008:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1027:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1027:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1027:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>> drivers/dma/ppc4xx/adma.c:1031:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1031:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1031:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1031:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1031:60: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1031:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1032:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1032:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1032:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1032:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1032:60: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1032:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1038:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1038:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1038:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1039:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1039:37: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1039:37: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1053:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1053:48: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1053:48: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1055:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1055:25: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1055:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1062:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1062:41: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1062:41: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1064:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1064:39: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1064:39: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1065:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1065:25: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1065:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1066:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1066:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1066:33: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1067:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1067:22: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1067:22: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1080:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1080:48: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1080:48: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:1090:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1090:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1090:26: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1210:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1210:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1210:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1214:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1214:30: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1214:30: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:2777:62: sparse: sparse: Using plain integer as NULL pointer
   drivers/dma/ppc4xx/adma.c:4094:14: sparse: sparse: too many warnings

vim +688 drivers/dma/ppc4xx/adma.c

12458ea06efd7b Anatolij Gustschin 2009-12-11  675  
12458ea06efd7b Anatolij Gustschin 2009-12-11  676  /**
12458ea06efd7b Anatolij Gustschin 2009-12-11  677   * ppc440spe_desc_set_dcheck - set CHECK pattern
12458ea06efd7b Anatolij Gustschin 2009-12-11  678   */
12458ea06efd7b Anatolij Gustschin 2009-12-11  679  static void ppc440spe_desc_set_dcheck(struct ppc440spe_adma_desc_slot *desc,
12458ea06efd7b Anatolij Gustschin 2009-12-11  680  				struct ppc440spe_adma_chan *chan, u8 *qword)
12458ea06efd7b Anatolij Gustschin 2009-12-11  681  {
12458ea06efd7b Anatolij Gustschin 2009-12-11  682  	struct dma_cdb *dma_hw_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11  683  
12458ea06efd7b Anatolij Gustschin 2009-12-11  684  	switch (chan->device->id) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  685  	case PPC440SPE_DMA0_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  686  	case PPC440SPE_DMA1_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  687  		dma_hw_desc = desc->hw_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11 @688  		iowrite32(qword[0], &dma_hw_desc->sg3l);
12458ea06efd7b Anatolij Gustschin 2009-12-11  689  		iowrite32(qword[4], &dma_hw_desc->sg3u);
12458ea06efd7b Anatolij Gustschin 2009-12-11  690  		iowrite32(qword[8], &dma_hw_desc->sg2l);
12458ea06efd7b Anatolij Gustschin 2009-12-11  691  		iowrite32(qword[12], &dma_hw_desc->sg2u);
12458ea06efd7b Anatolij Gustschin 2009-12-11  692  		break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  693  	default:
12458ea06efd7b Anatolij Gustschin 2009-12-11  694  		BUG();
12458ea06efd7b Anatolij Gustschin 2009-12-11  695  	}
12458ea06efd7b Anatolij Gustschin 2009-12-11  696  }
12458ea06efd7b Anatolij Gustschin 2009-12-11  697  

:::::: The code at line 688 was first introduced by commit
:::::: 12458ea06efd7b44281e68fe59c950ec7d59c649 ppc440spe-adma: adds updated ppc440spe adma driver

:::::: TO: Anatolij Gustschin <agust@denx.de>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--x+6KMIRAuhnl3hBn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--x+6KMIRAuhnl3hBn--
