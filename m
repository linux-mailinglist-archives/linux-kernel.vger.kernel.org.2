Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A59E387065
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 05:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbhERD4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 23:56:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:17950 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237342AbhERD4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 23:56:46 -0400
IronPort-SDR: DPbmgmZp/Q0C6mv9bvoMaakzE7ii3Y3twKMDQDe6cQoKUEk64Ejpf3jwZaWkj6sNqgnG4G3C1F
 0fi1jXgIDN7Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="200668567"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="gz'50?scan'50,208,50";a="200668567"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 20:55:29 -0700
IronPort-SDR: g3EOu3XMPokHF3d2QTJWVKt3mXR/x+TgAj/XCvqyONxgDwdn8xCn5wiXfTrA8Vd+WVpLjzTegW
 8ot95RPDdXWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="gz'50?scan'50,208,50";a="611816964"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 May 2021 20:55:26 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1liqpK-000223-Al; Tue, 18 May 2021 03:55:26 +0000
Date:   Tue, 18 May 2021 11:54:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/dma/ppc4xx/adma.c:688:38: sparse: sparse: incorrect type in
 argument 2 (different address spaces)
Message-ID: <202105181144.Ikt0QXR5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ac91e6c6033ebc12c5c1e4aa171b81a662bd70f
commit: 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e powerpc: inline iomap accessors
date:   6 months ago
config: powerpc64-randconfig-s032-20210518 (attached as .config)
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

12458ea06efd7b Anatolij Gustschin 2009-12-11  599  
12458ea06efd7b Anatolij Gustschin 2009-12-11  600  /**
12458ea06efd7b Anatolij Gustschin 2009-12-11  601   * ppc440spe_desc_set_dest_addr - set destination address into the descriptor
12458ea06efd7b Anatolij Gustschin 2009-12-11  602   */
12458ea06efd7b Anatolij Gustschin 2009-12-11  603  static void ppc440spe_desc_set_dest_addr(struct ppc440spe_adma_desc_slot *desc,
12458ea06efd7b Anatolij Gustschin 2009-12-11  604  				struct ppc440spe_adma_chan *chan,
12458ea06efd7b Anatolij Gustschin 2009-12-11  605  				dma_addr_t addrh, dma_addr_t addrl,
12458ea06efd7b Anatolij Gustschin 2009-12-11  606  				u32 dst_idx)
12458ea06efd7b Anatolij Gustschin 2009-12-11  607  {
12458ea06efd7b Anatolij Gustschin 2009-12-11  608  	struct dma_cdb *dma_hw_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11  609  	struct xor_cb *xor_hw_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11  610  	phys_addr_t addr64, tmphi, tmplow;
12458ea06efd7b Anatolij Gustschin 2009-12-11  611  	u32 *psgu, *psgl;
12458ea06efd7b Anatolij Gustschin 2009-12-11  612  
12458ea06efd7b Anatolij Gustschin 2009-12-11  613  	switch (chan->device->id) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  614  	case PPC440SPE_DMA0_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  615  	case PPC440SPE_DMA1_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  616  		if (!addrh) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  617  			addr64 = addrl;
12458ea06efd7b Anatolij Gustschin 2009-12-11  618  			tmphi = (addr64 >> 32);
12458ea06efd7b Anatolij Gustschin 2009-12-11  619  			tmplow = (addr64 & 0xFFFFFFFF);
12458ea06efd7b Anatolij Gustschin 2009-12-11  620  		} else {
12458ea06efd7b Anatolij Gustschin 2009-12-11  621  			tmphi = addrh;
12458ea06efd7b Anatolij Gustschin 2009-12-11  622  			tmplow = addrl;
12458ea06efd7b Anatolij Gustschin 2009-12-11  623  		}
12458ea06efd7b Anatolij Gustschin 2009-12-11  624  		dma_hw_desc = desc->hw_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11  625  
12458ea06efd7b Anatolij Gustschin 2009-12-11  626  		psgu = dst_idx ? &dma_hw_desc->sg3u : &dma_hw_desc->sg2u;
12458ea06efd7b Anatolij Gustschin 2009-12-11  627  		psgl = dst_idx ? &dma_hw_desc->sg3l : &dma_hw_desc->sg2l;
12458ea06efd7b Anatolij Gustschin 2009-12-11  628  
12458ea06efd7b Anatolij Gustschin 2009-12-11 @629  		*psgl = cpu_to_le32((u32)tmplow);
12458ea06efd7b Anatolij Gustschin 2009-12-11  630  		*psgu |= cpu_to_le32((u32)tmphi);
12458ea06efd7b Anatolij Gustschin 2009-12-11  631  		break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  632  	case PPC440SPE_XOR_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  633  		xor_hw_desc = desc->hw_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11  634  		xor_hw_desc->cbtal = addrl;
12458ea06efd7b Anatolij Gustschin 2009-12-11  635  		xor_hw_desc->cbtah |= addrh;
12458ea06efd7b Anatolij Gustschin 2009-12-11  636  		break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  637  	}
12458ea06efd7b Anatolij Gustschin 2009-12-11  638  }
12458ea06efd7b Anatolij Gustschin 2009-12-11  639  
12458ea06efd7b Anatolij Gustschin 2009-12-11  640  /**
12458ea06efd7b Anatolij Gustschin 2009-12-11  641   * ppc440spe_desc_set_byte_count - set number of data bytes involved
12458ea06efd7b Anatolij Gustschin 2009-12-11  642   * into the operation
12458ea06efd7b Anatolij Gustschin 2009-12-11  643   */
12458ea06efd7b Anatolij Gustschin 2009-12-11  644  static void ppc440spe_desc_set_byte_count(struct ppc440spe_adma_desc_slot *desc,
12458ea06efd7b Anatolij Gustschin 2009-12-11  645  				struct ppc440spe_adma_chan *chan,
12458ea06efd7b Anatolij Gustschin 2009-12-11  646  				u32 byte_count)
12458ea06efd7b Anatolij Gustschin 2009-12-11  647  {
12458ea06efd7b Anatolij Gustschin 2009-12-11  648  	struct dma_cdb *dma_hw_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11  649  	struct xor_cb *xor_hw_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11  650  
12458ea06efd7b Anatolij Gustschin 2009-12-11  651  	switch (chan->device->id) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  652  	case PPC440SPE_DMA0_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  653  	case PPC440SPE_DMA1_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  654  		dma_hw_desc = desc->hw_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11  655  		dma_hw_desc->cnt = cpu_to_le32(byte_count);
12458ea06efd7b Anatolij Gustschin 2009-12-11  656  		break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  657  	case PPC440SPE_XOR_ID:
12458ea06efd7b Anatolij Gustschin 2009-12-11  658  		xor_hw_desc = desc->hw_desc;
12458ea06efd7b Anatolij Gustschin 2009-12-11  659  		xor_hw_desc->cbbc = byte_count;
12458ea06efd7b Anatolij Gustschin 2009-12-11  660  		break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  661  	}
12458ea06efd7b Anatolij Gustschin 2009-12-11  662  }
12458ea06efd7b Anatolij Gustschin 2009-12-11  663  
12458ea06efd7b Anatolij Gustschin 2009-12-11  664  /**
12458ea06efd7b Anatolij Gustschin 2009-12-11  665   * ppc440spe_desc_set_rxor_block_size - set RXOR block size
12458ea06efd7b Anatolij Gustschin 2009-12-11  666   */
12458ea06efd7b Anatolij Gustschin 2009-12-11  667  static inline void ppc440spe_desc_set_rxor_block_size(u32 byte_count)
12458ea06efd7b Anatolij Gustschin 2009-12-11  668  {
12458ea06efd7b Anatolij Gustschin 2009-12-11  669  	/* assume that byte_count is aligned on the 512-boundary;
12458ea06efd7b Anatolij Gustschin 2009-12-11  670  	 * thus write it directly to the register (bits 23:31 are
12458ea06efd7b Anatolij Gustschin 2009-12-11  671  	 * reserved there).
12458ea06efd7b Anatolij Gustschin 2009-12-11  672  	 */
12458ea06efd7b Anatolij Gustschin 2009-12-11  673  	dcr_write(ppc440spe_mq_dcr_host, DCRN_MQ0_CF2H, byte_count);
12458ea06efd7b Anatolij Gustschin 2009-12-11  674  }
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
12458ea06efd7b Anatolij Gustschin 2009-12-11 @690  		iowrite32(qword[8], &dma_hw_desc->sg2l);
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

--82I3+IH0IqGh5yIs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--82I3+IH0IqGh5yIs--
