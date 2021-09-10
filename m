Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0407406706
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 08:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhIJGDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 02:03:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:14254 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhIJGDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 02:03:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="208229512"
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="gz'50?scan'50,208,50";a="208229512"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 23:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="gz'50?scan'50,208,50";a="549032498"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Sep 2021 23:02:31 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mOZcM-0003v2-IN; Fri, 10 Sep 2021 06:02:30 +0000
Date:   Fri, 10 Sep 2021 14:02:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/dma/ppc4xx/adma.c:4100:31: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202109101456.cSk5Cb19-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bf9f243f23e6623f310ba03fbb14e10ec3a61290
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   4 months ago
config: powerpc64-randconfig-s032-20210910 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d991bb1c8da842a2a0b9dc83b1005e655783f861
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d991bb1c8da842a2a0b9dc83b1005e655783f861
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

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

--Nq2Wo0NMKNjxTN9z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Nq2Wo0NMKNjxTN9z--
