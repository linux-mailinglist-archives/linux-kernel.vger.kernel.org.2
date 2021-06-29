Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0663B769A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhF2QsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 12:48:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:46540 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232441AbhF2QsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:48:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="293824925"
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="gz'50?scan'50,208,50";a="293824925"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 09:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="gz'50?scan'50,208,50";a="625699915"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Jun 2021 09:45:47 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lyGrr-0009Ew-6R; Tue, 29 Jun 2021 16:45:47 +0000
Date:   Wed, 30 Jun 2021 00:17:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/dma/ppc4xx/adma.c:4100:31: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202106300021.3T1dk9Og-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c54b245d011855ea91c5beff07f1db74143ce614
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   9 weeks ago
config: powerpc64-randconfig-s032-20210629 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d991bb1c8da842a2a0b9dc83b1005e655783f861
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d991bb1c8da842a2a0b9dc83b1005e655783f861
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/dma/ppc4xx/adma.c:1155:49: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1155:49: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1157:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1157:38: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1157:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:909:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:909:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:909:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:910:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:910:40: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:910:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:927:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:972:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:972:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:972:32: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:977:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:977:40: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:977:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:982:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:982:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:982:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:983:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:983:34: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:983:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:984:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:984:34: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:984:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:991:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:991:55: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:991:55: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:993:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:993:51: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:993:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:995:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:997:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:997:46: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:997:46: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1006:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1006:35: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1006:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1025:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1025:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1025:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:1029:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1029:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1029:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1029:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1029:60: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1029:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1030:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1030:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1030:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1030:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1030:60: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1030:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1036:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1036:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1036:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1037:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1037:37: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1037:37: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1051:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1051:48: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1051:48: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1053:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1053:25: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1053:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1060:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1060:41: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1060:41: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1062:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1062:39: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1062:39: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1063:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1063:25: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1063:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1064:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1064:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1064:33: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1065:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1065:22: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1065:22: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1078:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1078:48: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1078:48: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:1088:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1088:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1088:26: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1208:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1208:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1208:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1212:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1212:30: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1212:30: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:2775:62: sparse: sparse: Using plain integer as NULL pointer
   drivers/dma/ppc4xx/adma.c:4092:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *regs @@     got void [noderef] __iomem * @@
   drivers/dma/ppc4xx/adma.c:4092:14: sparse:     expected void *regs
   drivers/dma/ppc4xx/adma.c:4092:14: sparse:     got void [noderef] __iomem *
>> drivers/dma/ppc4xx/adma.c:4100:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs [noderef] __iomem *xor_reg @@     got void *regs @@
   drivers/dma/ppc4xx/adma.c:4100:31: sparse:     expected struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:4100:31: sparse:     got void *regs
>> drivers/dma/ppc4xx/adma.c:4107:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs [noderef] __iomem *dma_reg @@     got void *regs @@
   drivers/dma/ppc4xx/adma.c:4107:31: sparse:     expected struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:4107:31: sparse:     got void *regs

vim +4100 drivers/dma/ppc4xx/adma.c

12458ea06efd7b Anatolij Gustschin       2009-12-11  4001  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4002  /**
12458ea06efd7b Anatolij Gustschin       2009-12-11  4003   * ppc440spe_adma_probe - probe the asynch device
12458ea06efd7b Anatolij Gustschin       2009-12-11  4004   */
463a1f8b3ceebe Bill Pemberton           2012-11-19  4005  static int ppc440spe_adma_probe(struct platform_device *ofdev)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4006  {
05c02542c20aa0 Anatolij Gustschin       2010-06-03  4007  	struct device_node *np = ofdev->dev.of_node;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4008  	struct resource res;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4009  	struct ppc440spe_adma_device *adev;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4010  	struct ppc440spe_adma_chan *chan;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4011  	struct ppc_dma_chan_ref *ref, *_ref;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4012  	int ret = 0, initcode = PPC_ADMA_INIT_OK;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4013  	const u32 *idx;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4014  	int len;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4015  	void *regs;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4016  	u32 id, pool_size;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4017  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4018  	if (of_device_is_compatible(np, "amcc,xor-accelerator")) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4019  		id = PPC440SPE_XOR_ID;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4020  		/* As far as the XOR engine is concerned, it does not
12458ea06efd7b Anatolij Gustschin       2009-12-11  4021  		 * use FIFOs but uses linked list. So there is no dependency
12458ea06efd7b Anatolij Gustschin       2009-12-11  4022  		 * between pool size to allocate and the engine configuration.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4023  		 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4024  		pool_size = PAGE_SIZE << 1;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4025  	} else {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4026  		/* it is DMA0 or DMA1 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4027  		idx = of_get_property(np, "cell-index", &len);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4028  		if (!idx || (len != sizeof(u32))) {
c6c93048baff25 Rob Herring              2017-07-18  4029  			dev_err(&ofdev->dev, "Device node %pOF has missing "
12458ea06efd7b Anatolij Gustschin       2009-12-11  4030  				"or invalid cell-index property\n",
c6c93048baff25 Rob Herring              2017-07-18  4031  				np);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4032  			return -EINVAL;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4033  		}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4034  		id = *idx;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4035  		/* DMA0,1 engines use FIFO to maintain CDBs, so we
12458ea06efd7b Anatolij Gustschin       2009-12-11  4036  		 * should allocate the pool accordingly to size of this
12458ea06efd7b Anatolij Gustschin       2009-12-11  4037  		 * FIFO. Thus, the pool size depends on the FIFO depth:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4038  		 * how much CDBs pointers the FIFO may contain then so
12458ea06efd7b Anatolij Gustschin       2009-12-11  4039  		 * much CDBs we should provide in the pool.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4040  		 * That is
12458ea06efd7b Anatolij Gustschin       2009-12-11  4041  		 *   CDB size = 32B;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4042  		 *   CDBs number = (DMA0_FIFO_SIZE >> 3);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4043  		 *   Pool size = CDBs number * CDB size =
12458ea06efd7b Anatolij Gustschin       2009-12-11  4044  		 *      = (DMA0_FIFO_SIZE >> 3) << 5 = DMA0_FIFO_SIZE << 2.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4045  		 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4046  		pool_size = (id == PPC440SPE_DMA0_ID) ?
12458ea06efd7b Anatolij Gustschin       2009-12-11  4047  			    DMA0_FIFO_SIZE : DMA1_FIFO_SIZE;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4048  		pool_size <<= 2;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4049  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4050  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4051  	if (of_address_to_resource(np, 0, &res)) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4052  		dev_err(&ofdev->dev, "failed to get memory resource\n");
12458ea06efd7b Anatolij Gustschin       2009-12-11  4053  		initcode = PPC_ADMA_INIT_MEMRES;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4054  		ret = -ENODEV;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4055  		goto out;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4056  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4057  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4058  	if (!request_mem_region(res.start, resource_size(&res),
12458ea06efd7b Anatolij Gustschin       2009-12-11  4059  				dev_driver_string(&ofdev->dev))) {
a584bff5efae8c Joe Perches              2010-11-12  4060  		dev_err(&ofdev->dev, "failed to request memory region %pR\n",
a584bff5efae8c Joe Perches              2010-11-12  4061  			&res);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4062  		initcode = PPC_ADMA_INIT_MEMREG;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4063  		ret = -EBUSY;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4064  		goto out;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4065  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4066  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4067  	/* create a device */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4068  	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4069  	if (!adev) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4070  		initcode = PPC_ADMA_INIT_ALLOC;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4071  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4072  		goto err_adev_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4073  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4074  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4075  	adev->id = id;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4076  	adev->pool_size = pool_size;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4077  	/* allocate coherent memory for hardware descriptors */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4078  	adev->dma_desc_pool_virt = dma_alloc_coherent(&ofdev->dev,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4079  					adev->pool_size, &adev->dma_desc_pool,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4080  					GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4081  	if (adev->dma_desc_pool_virt == NULL) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4082  		dev_err(&ofdev->dev, "failed to allocate %d bytes of coherent "
12458ea06efd7b Anatolij Gustschin       2009-12-11  4083  			"memory for hardware descriptors\n",
12458ea06efd7b Anatolij Gustschin       2009-12-11  4084  			adev->pool_size);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4085  		initcode = PPC_ADMA_INIT_COHERENT;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4086  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4087  		goto err_dma_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4088  	}
d73111c6d43f08 Masanari Iida            2012-08-04  4089  	dev_dbg(&ofdev->dev, "allocated descriptor pool virt 0x%p phys 0x%llx\n",
12458ea06efd7b Anatolij Gustschin       2009-12-11  4090  		adev->dma_desc_pool_virt, (u64)adev->dma_desc_pool);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4091  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4092  	regs = ioremap(res.start, resource_size(&res));
12458ea06efd7b Anatolij Gustschin       2009-12-11  4093  	if (!regs) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4094  		dev_err(&ofdev->dev, "failed to ioremap regs!\n");
f3b77727e82722 Julia Lawall             2013-12-29  4095  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4096  		goto err_regs_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4097  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4098  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4099  	if (adev->id == PPC440SPE_XOR_ID) {
12458ea06efd7b Anatolij Gustschin       2009-12-11 @4100  		adev->xor_reg = regs;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4101  		/* Reset XOR */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4102  		iowrite32be(XOR_CRSR_XASR_BIT, &adev->xor_reg->crsr);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4103  		iowrite32be(XOR_CRSR_64BA_BIT, &adev->xor_reg->crrr);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4104  	} else {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4105  		size_t fifo_size = (adev->id == PPC440SPE_DMA0_ID) ?
12458ea06efd7b Anatolij Gustschin       2009-12-11  4106  				   DMA0_FIFO_SIZE : DMA1_FIFO_SIZE;
12458ea06efd7b Anatolij Gustschin       2009-12-11 @4107  		adev->dma_reg = regs;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4108  		/* DMAx_FIFO_SIZE is defined in bytes,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4109  		 * <fsiz> - is defined in number of CDB pointers (8byte).
12458ea06efd7b Anatolij Gustschin       2009-12-11  4110  		 * DMA FIFO Length = CSlength + CPlength, where
12458ea06efd7b Anatolij Gustschin       2009-12-11  4111  		 * CSlength = CPlength = (fsiz + 1) * 8.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4112  		 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4113  		iowrite32(DMA_FIFO_ENABLE | ((fifo_size >> 3) - 2),
12458ea06efd7b Anatolij Gustschin       2009-12-11  4114  			  &adev->dma_reg->fsiz);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4115  		/* Configure DMA engine */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4116  		iowrite32(DMA_CFG_DXEPR_HP | DMA_CFG_DFMPP_HP | DMA_CFG_FALGN,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4117  			  &adev->dma_reg->cfg);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4118  		/* Clear Status */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4119  		iowrite32(~0, &adev->dma_reg->dsts);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4120  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4121  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4122  	adev->dev = &ofdev->dev;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4123  	adev->common.dev = &ofdev->dev;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4124  	INIT_LIST_HEAD(&adev->common.channels);
dd3daca162f741 Jingoo Han               2013-05-24  4125  	platform_set_drvdata(ofdev, adev);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4126  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4127  	/* create a channel */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4128  	chan = kzalloc(sizeof(*chan), GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4129  	if (!chan) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4130  		initcode = PPC_ADMA_INIT_CHANNEL;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4131  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4132  		goto err_chan_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4133  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4134  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4135  	spin_lock_init(&chan->lock);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4136  	INIT_LIST_HEAD(&chan->chain);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4137  	INIT_LIST_HEAD(&chan->all_slots);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4138  	chan->device = adev;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4139  	chan->common.device = &adev->common;
8ac695463f37af Russell King - ARM Linux 2012-03-06  4140  	dma_cookie_init(&chan->common);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4141  	list_add_tail(&chan->common.device_node, &adev->common.channels);
7f8281765f9949 Allen Pais               2020-08-31  4142  	tasklet_setup(&chan->irq_tasklet, ppc440spe_adma_tasklet);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4143  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4144  	/* allocate and map helper pages for async validation or
12458ea06efd7b Anatolij Gustschin       2009-12-11  4145  	 * async_mult/async_sum_product operations on DMA0/1.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4146  	 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4147  	if (adev->id != PPC440SPE_XOR_ID) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4148  		chan->pdest_page = alloc_page(GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4149  		chan->qdest_page = alloc_page(GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4150  		if (!chan->pdest_page ||
12458ea06efd7b Anatolij Gustschin       2009-12-11  4151  		    !chan->qdest_page) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4152  			if (chan->pdest_page)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4153  				__free_page(chan->pdest_page);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4154  			if (chan->qdest_page)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4155  				__free_page(chan->qdest_page);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4156  			ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4157  			goto err_page_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4158  		}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4159  		chan->pdest = dma_map_page(&ofdev->dev, chan->pdest_page, 0,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4160  					   PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4161  		chan->qdest = dma_map_page(&ofdev->dev, chan->qdest_page, 0,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4162  					   PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4163  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4164  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4165  	ref = kmalloc(sizeof(*ref), GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4166  	if (ref) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4167  		ref->chan = &chan->common;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4168  		INIT_LIST_HEAD(&ref->node);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4169  		list_add_tail(&ref->node, &ppc440spe_adma_chan_list);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4170  	} else {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4171  		dev_err(&ofdev->dev, "failed to allocate channel reference!\n");
12458ea06efd7b Anatolij Gustschin       2009-12-11  4172  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4173  		goto err_ref_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4174  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4175  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4176  	ret = ppc440spe_adma_setup_irqs(adev, chan, &initcode);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4177  	if (ret)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4178  		goto err_irq;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4179  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4180  	ppc440spe_adma_init_capabilities(adev);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4181  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4182  	ret = dma_async_device_register(&adev->common);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4183  	if (ret) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4184  		initcode = PPC_ADMA_INIT_REGISTER;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4185  		dev_err(&ofdev->dev, "failed to register dma device\n");
12458ea06efd7b Anatolij Gustschin       2009-12-11  4186  		goto err_dev_reg;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4187  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4188  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4189  	goto out;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4190  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4191  err_dev_reg:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4192  	ppc440spe_adma_release_irqs(adev, chan);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4193  err_irq:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4194  	list_for_each_entry_safe(ref, _ref, &ppc440spe_adma_chan_list, node) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4195  		if (chan == to_ppc440spe_adma_chan(ref->chan)) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4196  			list_del(&ref->node);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4197  			kfree(ref);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4198  		}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4199  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4200  err_ref_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4201  	if (adev->id != PPC440SPE_XOR_ID) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4202  		dma_unmap_page(&ofdev->dev, chan->pdest,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4203  			       PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4204  		dma_unmap_page(&ofdev->dev, chan->qdest,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4205  			       PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4206  		__free_page(chan->pdest_page);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4207  		__free_page(chan->qdest_page);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4208  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4209  err_page_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4210  	kfree(chan);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4211  err_chan_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4212  	if (adev->id == PPC440SPE_XOR_ID)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4213  		iounmap(adev->xor_reg);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4214  	else
12458ea06efd7b Anatolij Gustschin       2009-12-11  4215  		iounmap(adev->dma_reg);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4216  err_regs_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4217  	dma_free_coherent(adev->dev, adev->pool_size,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4218  			  adev->dma_desc_pool_virt,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4219  			  adev->dma_desc_pool);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4220  err_dma_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4221  	kfree(adev);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4222  err_adev_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4223  	release_mem_region(res.start, resource_size(&res));
12458ea06efd7b Anatolij Gustschin       2009-12-11  4224  out:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4225  	if (id < PPC440SPE_ADMA_ENGINES_NUM)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4226  		ppc440spe_adma_devices[id] = initcode;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4227  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4228  	return ret;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4229  }
12458ea06efd7b Anatolij Gustschin       2009-12-11  4230  

:::::: The code at line 4100 was first introduced by commit
:::::: 12458ea06efd7b44281e68fe59c950ec7d59c649 ppc440spe-adma: adds updated ppc440spe adma driver

:::::: TO: Anatolij Gustschin <agust@denx.de>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--dDRMvlgZJXvWKvBx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--dDRMvlgZJXvWKvBx--
