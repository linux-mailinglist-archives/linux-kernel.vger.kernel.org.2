Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632093870D8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344968AbhEREWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:22:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:19432 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230378AbhEREUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:20:47 -0400
IronPort-SDR: b2ux5EEMlSOuTquiTeN+s2QAwPcBlE3xzKNR9rbEMG5jRCir6DdDWfbNMRzQdNwi/f60UJ5M9M
 cPoqtqoC+EBQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="200671563"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="gz'50?scan'50,208,50";a="200671563"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 21:19:29 -0700
IronPort-SDR: l0UVGsaJTz71DbzUR5fx+LYTfbK+ojlmexCBV6fqFZUV0P6lEu473T/PE3ixj8PtoMibSot2Nl
 qcQwu7h8gFOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="gz'50?scan'50,208,50";a="411107671"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 17 May 2021 21:19:27 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lirCY-00022C-HM; Tue, 18 May 2021 04:19:26 +0000
Date:   Tue, 18 May 2021 12:18:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/dma/ppc4xx/adma.c:4100:31: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202105181216.SvMMGB2A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ac91e6c6033ebc12c5c1e4aa171b81a662bd70f
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   2 weeks ago
config: powerpc64-randconfig-s032-20210518 (attached as .config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=powerpc64 

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

--wac7ysb48OaltWcw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICGs+o2AAAy5jb25maWcAlDzLctw2kPd8xVRySQ5x9LKT1JYOIAhykCEJCgBnJF1QE5l2
VJElrzRKnL/fbhAkARIce1MVS+xuNF6NfqGhH777YUVeD0+f9of7u/3Dw3+rj+1j+7w/tO9X
H+4f2v9ZpWJVCb1iKddvgLi4f3z98svnp3/b5893q7dvTs/enKw27fNj+7CiT48f7j++Quv7
p8fvfviOiirjuaHUbJlUXFRGs2t9+b1r/fMD8vr5493d6sec0p9Wv785f3PyvdeMKwOIy/96
UD6yuvz95PzkZKAtSJUPqAFMlGVRNSMLAPVkZ+cXI4ciRdIkS0dSAMVJPcSJN9o18CaqNLnQ
YuTiIXhV8Ip5KFEpLRuqhVQjlMsrsxNyM0KShhep5iUzmiQFM0pIPWL1WjICo68yAf8AicKm
sPw/rHK7lw+rl/bw+nncEF5xbVi1NUTCbHjJ9eX52TiosubQiWbK66QQlBT9pL//PhiZUaTQ
HnBNtsxsmKxYYfJbXo9cfExxW5I45vp2qYW3rCH/H1YhGJmv7l9Wj08HnPwMf317DAsd+WiH
TFlGmkLb1fNm24PXQumKlOzy+x8fnx7bnwYCdaO2vKb+KGuh+LUprxrWsOhAdkTTtZnh+y2S
QilTslLIG0O0JnQ9LkyjWMETT+AbOLmTBSUSuFsEDA42tpiQj1ArRiCRq5fXP1/+ezm0n0Yx
ylnFJKdWYNVa7LxzOsGYgm1ZEceXPJdEo1hF0XTtCxBCUlESXoUwxcsYkVlzJnGyNyE2I0oz
wUc0LEuVFsw/hv0gSsWxzSIiOp5MSMpSdzR5lY9YVROpmOM47Lc/45QlTZ6pUC7ax/erpw+T
nZiOyKqI7WxLezSFQ7yBjai0N00rCqigNKcbk0hBUkr8kx9pfZSsFMo0dUo068VH339qn19i
ErS+NTW0EikPjkclEMNhQ6KHw6KjmDXP10YyZVdCxpdwNpp+MLVkrKw1sLc6ejysDr4VRVNp
Im+iXTuqyGnt21MBzfs1oXXzi96//L06wHBWexjay2F/eFnt7+6eXh8P948fx1Xacgmt68YQ
anl08jT0bDcuREdGEWFiKjh322CuiUphvIIy0C9AGJsO2heliS9DCAKxLciNbRQMDlHXU1bj
qike3aRvWJ5BGcKcuBJFr0Ps8krarNRc3jRshQHcOHT4MOwahNATZRVQ2DYTEC6BbeqkPoKa
gZqUxeBaEhoZE6xwUaAtLn3FiJiKgWJRLKdJwf0DiLiMVKLxjfkIBBVMssuzcektL0ETXMDo
3kzGZ6yXUSbR/QrXe9CEm+4XXyB6mBWziHjxzRr66TSx3Up191f7/vWhfV59aPeH1+f2xYJd
xxHsIBi5FE3tiWlNctadQiZHKJhRmk8+zQZ+eH6a5WQUXTPPPcwIlybEDLOkGShJMCk7nup1
dHXhNHptY0a+Q9c8VQHnDizTBQfH4TOQ2lsmY3xr8BD804sbgd04zGzaKdtyymZgoHaHPYQn
dRYZb8lVbLeHLsDkeQdQoEZzKKJJYBvAxQIbChoqPv01o5ta8EqjHQDHOuY/2SUHT0cL24fX
8Y2CjUsZqGwKBixdxpjtmT8qicov0lNSoGLcWp9ReuzsNymBpRINuAroT47MUuvWxsUmNQng
ziJ9Acr51D71gqdricUy6mIJdat0TFoTIdDCudM+hj6iBlPMbxl6RGjr4UdJKhoYnSmZgl8i
XVjPFaKNFPUQFaBOUTYMwwCm6rX/wPQoYYQ70AtZgxsIvresgo2nugAbQVmtbQiLCtGLzay4
u4+pJSkhMOBwqDx1o3KmSzSKo5s2jLkTMoeIjDHrvNR5JBFzd4bTDWdhE9sx/8QlBHzSrPG9
xqyBYH3yCWrC75zVIhznOBOeV6TI0rhhwdFmMSmy7qUfgqt1p4iHtoTHhZYL08iJ5zM2Srcc
5ucWNr5O0E9CpORRnbnBZjelpzR7iAk87QFq1xOVgnOwRmGJ7TtKiA0io4syeOjjEA1ySAjd
xBx5j0zdVOCRgxL0hkjLIGCGYOQqthNlwtLU14D2+OEJNkMIMQoZPT0JNIY10S4rVLfPH56e
P+0f79oV+6d9BDeOgPGm6MiBJ965w47PyD7qZnwjx8HnLTtmvdEPDakoa6IhlIkdDlWQJDiZ
RZPEBb0QSwiSwFZIcDlchmCZDI01OnNGwvkW5TcQrolMwfWMiYtaN1lWsM7bATERYK+EDBSa
ZmWnErfgvGaczpQnuAQZL+KBhNV/1sJ2y+m2Jkw1Db5FTc8DQwmAd3NJqZ+f7tqXl6dnCMs+
f356PgRCUVM0L5tzZc7P4joOKH57++XLMnIBd3HyJTLDi4svkbi29jx05JnV6BLnagYdARdf
PEY4Be8c1pqZdxeJn5qp1zdqBgOeZYmeOhzt9RLcTBYZENaWxMSj9PydSlqn7/Ji3Mf5Vgyn
KVXC9uMFXgmqiirlxLOY52fBDGCUEyVVlgQc2Ao8Ga5BXZHry9NfjxHw6vL0NE7QH+KvMQro
An6wBFxeqcu3p0PQVJXccGvp+jXToGq7QEg1dR1mXy0YWGQFydUcj1kTcBvniF6w1jvG83W4
5Z5HQWRx44y4H8lULt2D4d7pb0MWuvNsRck16ArwlI09qL7/0a0LuXH6HCQ2paFYNWmSm9N3
b9+ezAerEzQpk2yh5TmnDRwMDzjYxX5w3hHqk6kNL0F9TY0bT5jsHDj0exRPiimJalQN8hhB
48xSKsecRwif8bG7hZksKRI2OeTgT3QhS0QBjDhOKJ6sKC5F3NkCbnsERygaCX9p6ry7FLAp
1rAh6B/YYY5uKQRD4UARVyo+0SiK4xmBU9NH3/XD/oC2NqaYFZyqWLbSY3jx65cgvURKUIPR
OKnBaC1MvLFEVPFkmyLlxcUJq2P6jV01ggdRkCZcgecc9etgroFLKwmEZqEP6CXlZTwoQ5FZ
ikdJdSOqAux6bInyglBuT6cXSaY7IaLOMc/9g3wjFINzHqwYV+piwdTRBlxC3dCYt5OpOrAf
ZINLH9snTv10FIrRxRdMvteTo4bSldfcu6+x+zX5vA6+Vd163+9O/OgDPpX/+eu7rPbPfl3+
dnbqW9uOwjApL955YXfSyY2Fe6ZsA55i3gQXXqwmNUSsRBLMnHrmrPbTffgFpyaXl2Ned5U9
t//72j7e/bd6uds/BKlctJngxHm3CT3E5GKLdzngtAc5GB89pAPHXe3RmJGN73tP0atWZOQF
4v+PRmIHuhqsxrc3wcDGJmu+vYmoUgYDi2bEYvSAg062s0x2lNiax0bzWHAdrHSYqYhS9Kux
gB+mvoDv57m41V+Z1uJ0BjH8MBXD1fvn+3+6iGvk1q1RKHEOZmqw0ynb+v1fCcmvepql1H3k
BPSj4u8fWjcOAA1jRbBvWmxSf3b/4/XQNfAgPuPgXs1ITaNsZqbND1qfPmMNg7dUeLUUJIXX
t+b05MRfG4CcvT2JX0zdmvOTRRTwOYlI5Pr28nSsOiiJXkNY3hSTy9IQ3idxxrxGiF7vTFNZ
fV1CYBwNINdC10WTu4gniKPshXRqVM0r9GtjJs26T7h91nFCX48RNXXTWGVdFneD7Tr8Go2E
3/zjBqwxtiVJmBHDK1R7dwKBzdL4wFfXwNj14dmHomA5KXrH1GwJ+CVjjYf1aDY2slbTpTl9
5xCLQei7iwiFh7cBu1rzDDz6wYtzxR0OPHiTNnqf0tpLZwyDzC14UkKm4C6MgQ4tU1t9MlYu
sGsIXsA7kjneB4xw50R78Y/zqt2lQpAYcSi14bVNN8UmVxpVMN/69xAXjXqBq83KW1x8HUvw
wjZsSfjqcsLNeqfxIdFiEwyoj1C66/xgf3dXnbo3LMs4OGyVjuV0FllFZj+lEMGdCSLzG1OK
lBVR1TVRUoP4KmLSkoA7xHt/JHl9meuyodqgow9jAA7hvGRUY+Qw8+lo7WlABCgR3NxnqjBF
Ete3/lCGUBsroEAzUVd60w+bvP8Hs3vvh8olP5eLVjm1VwbQemb60vbD/vXBAvCe+GUFOn61
7/nd+SVq/XBW++d29frSvh+XqBA7VBB4FXF58gV0t/1vjL/hqIosQ1ft5MvdBOuqiGBiMobG
NA+nZCQ4mRDYO3PX89B4WMbJ0gzZGfBSG1Lw2+AevM/K7Z/v/ro/tHd4Q/rz+/Yz8GofD3PJ
oBKzSS5jPKz5H01Zm4IkLOY32TzCeDCaCgaRV3i/RmkQdFrNC26RLRrTvDKJ2pFpcRiHrjFp
A9ZjWrS0mYbiHVQyHUd0UIM2cXJnY/FZU1FrEiEWEBLE/g9GQ8s6lkrZ9mshPI3RnyHQYNZT
cZo6ko8Htax5dtPf9IUENlmGomRmNVqqRA3gau6ms8PEgyGoeDE35dbaHfyATvnBxpjDDxMX
IxzdVsczbcrp7tghj9IQJPlMDp4GNO6yEWgqomisJPgKSWcIUf7DtdoRkC9M1tn1IrBb4B+D
wStniw5DxSSeIhkDu1df0/XUu9gxsumdE2B11XAZ784aZqzY6osfIyuiGMUE4xGUyUDkg2vA
aZMZ4WhiHYYScPcXLZrt0m4cHh1Gu5z/yCTAxO4/tegrn3yO8dqj4MSCv2ULzxYpQIrdYtSM
4n2Dt+sibQo4pKgWWJHZ1GCEP7vGQ1J1pX44kwmNEplGHJCIXTUlGU6i7cFesQTCNe5WkHg+
lrX2/KqxdbWVpAS75LWkBSypwZu6HZGphxBYNsvzmavl4IROr2RcBrvTF7jeS75tZxfBvDgz
JHfXkaVQGpSXDmk8YZkgj91K2lsLEJ7AkUAHzb97my6mPVtLV+5hBrZLfKJOsJdZg2WjYvvz
n3sw2qu/O2/o8/PTh3uXbhkDQCBzEzk2CUvW3Xox09/O9jdbR3oKhACr0zGQmXiPHjjqF32j
jR7CHm1KvIv3DZ69blYlDvzEC/26wxWZd3/sbG1bAXatCdzwBLcv5toSV43TL5+qTscviCtt
fbsND+ELmSxtKtFwBqmRpVc0bGfVNe7Osa8v5U6hOxZHWmlbwA1bXCEOlHhB6hqLH0maYlLc
TJI0Y4xjxYh9ae9eD/s/H1r7HGJl750PnseU8CorNaoWL3dYZFMXypEpKnm0SNThsUwqPPWS
oR2OCs7S2OzAy/bT0/N/q3L/uP/Yfoo6ey4K9uYOAFin1Ebdppw5Z1g2bXK/YMqu7gYjOaw6
CHfcRe5+bWavX+oClFit7b65C0hfzU38MOsPSIaSExiXSOU4/NA4LKcpPI/b7rfR0/tVa99A
eyWNd5y6i1Vw2rgvSRvlLVWfVbRWoQTJQ/aXFye/vxtVP4NABW22N7ywPAs+F+35gMtU0B6W
HHyWy+Ge87YWwnPEbpMmKES8Pc/ApET431p14a9SD7G55Lmj291EOv88SLikfbUBusmbeNXA
ugSB4uhpBxE6k+hb2HLi2PVIU0+eoYxWR7POnSB++Q1uhn2p4uvv5ZMwRKF+xh0+IBjIwwsz
BLIJTG0STKGwqvfP7bmr2sO/T89/Y7p1PHDjhGGBWOz8g/L0zDR+ga4oJ5CUE0/8r9PaVkoG
xZwesCcfN6pi8TsCgOODI/Q0SxKth8H517rGd1ZKQTATrIxtC2fMuiWwl2UdHFOgmHq/A2gI
570t1mXwAaGG75Uq7amfnEjvq5ShFZM8zWNu0hY4mt9Ozk69yGiEmXzrM/UQ5TbsIGW0im5m
UXjHCj7O/AkRP++EtaFgjwrmwONe1Wkau968PnvrsSa199CnXotAkDljDAf+9iJgPEBNVbhf
bNkix4QwiXlJXpNOtLwlJ3TowhOVvh7aiv7Va/vawnn4xdVqBxdijtrQ5GrGwqx1EgFmoYns
4SAqC4KL2Fray8hZK1uhebV0KiyJZPEyxh6vsngF2IiPFdj1WM2uivkkdZLNgTRRcyCcpNi8
NMEZH+kXlFk655YqVABzOPwM6zCHBjIWTA6re+XWfbokm2RpQ+habBae/TiKq+z4ftFp2nSC
z646ksgCkw2LjenoBq7Xka2qOZsDoeMofLQ2s54xbjjSN9PRVpHkdGeEHvYvL/cf7u8mD3Sx
HS0mwgUAjCv8aL0Ha8qrlF1Pu0ZUtlsYLiKboHysA9i00xzqxHDGX6ptTC366HfzAWeFfZ04
49a9MViUJrsEdXYUj6wX6kV6khIfc5KFSmnrWViKI9Mi4aMqBBPM0IuC05iF6wnyScPctpJh
yeqkDXppU9WAcEXCKo8eXhE9B9ase3Q6GzLWiiyugyXYJNj2KA0MJOYu9mg02fMhTd6leP2V
YlnBIwnPjq2xbirMkmzYzbzPvHsF6UE17f3GiH7gWaASUxo3LGml8HGLwPfYsVASi5owIAku
7kdo/+s2ytyjq+jXKGbBS4wIo4KFN4kz93W75LsOiEKIGvNpMXYQy3ER4xoiZs/qYAMKXm0m
/jVK2VRiEGZytWRYK79Ed62CWOdK6riaqDEEQkdQsoxWMX9S+ilFmdmnmb79su+l5HV3PY9x
e+iAX9exF2TWpZcLzyk8ms7lj4WQiIVeIXS+QVXkDSiZ+jSoJd1fGgjjpNWhfTn0OTsXsM1Q
E4QfW3l1FKSUJF2aT7T8L/EOYYJPAVgqA4jMUFSCY9QDjdbRB1/ApmL1pAmCTEldcj9+YBwV
5ujFVwjXPBobIEZNel54Qm0x0ZJEwJQq04GCAhgREG1f6wn35eJPQCpWZGH0DsCMEd1INrz4
6y6pH17bw9PT4a/V+/af+7t2XqgELa8omfS+prwhMppNs8hUF6fzJok+jxUpOGTRMEpkOm+2
hf8Xlktui2COVyAfqkwDWKeC/LTE4qT7VjuO91N+xmEHOzB5zmNB+ILTc6GyHGMyLzPbBXqn
NpeCRQVzWtQ/rBDgi9lcPKiPUGX0ZJThXaZ7MWJEFS2xGagls/dq9jUYS/HOMU0ifePlT3/X
gCRoS1V0jF3OrY6PbVkYx+HLlMwr8Qf0LpB6F9sGItTDjKSY9VNaRkMNn8yNGutruvfMT5/a
1b/3z+1D+/LSb/oKC+YAttqv8G/vYJnC4fnpYbV/+Pj0fH/465OfRBq4l0zFHxcPFNNDPqeI
/rWJSEeqT/DFTXnIDxpUTXTdKtFdEhzvDxybRKjly85xYEU56pIpUmmyiFvrATXvHl/Ff7Vr
nih1hEetjnhHA5VOiwhdbCL2mQ/WdnWFISMvmW34kdji97i7TQnPYiY9C3MrGcgvz3k8L4TY
ivJpAwCZqV4OCCaa1LkD++dVdt8+4DO+T59eH12QuvoRWvzkVKRnEJCPK3lxY/AQWVpPBwUg
w89iih+xdfX2/DzkYUHYJAQrPe+ug81pq+t6TuyAjjoYozrPdrJ6Ox2n5/580xoN+cBYxAax
jJc/3HXBywjJCC/wkmyEML3WQhS9j+y5t3gjRPFF6x+jV5d2piyd2m/32Mhbi65YMawxm3x4
pXgeMPJ+FsD2dihpFqovAU9UHX9YiUhTR5OH2F34RqYDRP/sT4/rCky997l+TwYN4mZxlMv1
ijhx3SRhd8EfYbEPfSgpQ0iXBLcFwNOhcLFd6AnCgpBLTSACmK44Ov4Y/dpKuOWlRapjL2AH
IqzWOU6x8GxhTsbkGf7jCauraQ5EzAMaWoeKzMepdU1nCgsQvZXGvz4y81jt/oAnuZ0ksuwo
r/Fx7bWpdjG1ii0zDf925eUeVLNckhkzCQ6r/etjC7wQFXk6MqDcBd/SinZjDQYyTCAoB0WG
18gsAnLHKOj8/zh7tuXGcVx/JU+ndh/6jCXf5Id50M02O6KkFmVb6RdVppPdTm06nUoytTN/
fwBSknkB7a5TNZcYgMAbSAIkAB7nPUYweecCOlyBnll4xzpGGym2aqaA7rSVTW33hzJDDzPz
MNvB4zzyiyJo27eYluxCp+MNesbiNnfHPmlSLlr6ZEd9yVIogeI/LLHvT/9+OaHLKspg+hP+
EFNwns4oO1l9k50kS2uRbeJ111GwkdisHjDBuJBLEpd3d2XlLH2Mdytfb4FxGTfBvOvsj9AU
wLhApziDqojvQFjSuPYuIGAzC8p+k6WjwWaLESwzYCtEtw68rfN0RUPpDsNQgqLfnfwjfssa
VvrRWPX+gsigek7mNJFfy0Uj2CysKo9gus6HktV7XxzkMM9IHeWSdCq/lJ9/wEr59IzoR1t6
rYlQJeyYs0LKG1naBWaK2/3DIyaJkOjzav2uRbPqBaZxlhsRXzrUnTpnFFbwAorq4/7zOgwo
sR5Dmq5WfYpjoneiaZfKXx5efz692P2LcfsyzoUs3vhwYvX+36ePb9+v7nviBP+wNt23eaof
eVxmoRknXdEn5NFCnQ6nM9NvnrLY/t0XFWb+YeY5AXxoMR3a9enb/dvDzR9vTw//fjS8Ne7w
RpyqRbZah5tzqSwKZ5tQrwUWdg5u0A5v45pl+o3oAAArS5wD+ue6eTcQDOFQTde3XS+d6KiD
4pEbj+GDnZFsdsKZFvGZ/4Hb930jLt1z/UZlBHOsRp+qCEGVdu/+9emBVTdCDbIjHOOXrWDL
tbHWT0WB3dx15LKjf7yKLrQeeYDSEVL8m07i5qTQe6p/jqR4+jaYNjeV69tzUP6u+7yoPQsn
9FTLazotRxuXWVy4qSclzy1r+CluVOhE5ojw9untx39xyX3+CavGm+bhd5JTQdeEJ5B02cqA
o5G/CiPCxtK0kLDzVzJAQLWRYqqhJyNIb9GZEj398Nqb7Ckgk65z5DDZzZ3OQmMZmHWcvCbP
FUTHtpMHZ0G10ZIZFxp29A6nJMiPjSfqTxHgqevAplcxjNSSwvsvlehvD5ia2Tw1Hz6tcxKr
5aeRsXMy6sW4GjJ9G5t8Zzh2qt99nG7WDtA40RhgomCcYNhzbixrAwM9b+4Im2tMcaESe5A1
KYhbM/ABkVu5icr4G1IWPNNyin07HxxNbEG1kzoZOo9WTV/Qmn7SBn1cUxflEtOZ1iJoaAXm
RuiLmjKkUMHs84QZS5JKm4AjT+91GEvHx9E7zwwFPcB6Np5kU0eHe2a5tCqAcx46gHHXPucy
NUL27GMl+F85hpdMyxRImZ1YeFfqVxe8nfzB6vu3jyd5bvV6//Zu7A9ABcOzxoib1vy4T1K+
AvuAQg2RrRSq2l6CItPFZhZ5sHjeJe5EX1qfy3igppcpalrzmlpDtw0VNoEEKPA1DCNRM5gI
MpPiBZSKzkTPauVv/SnwMpDBeDJI2sxO6hJi6FpVFne0LugMmBzHA/wJGjhmX1X519q3+5f3
Z3UkWdz/beV2k11b1Z6bBtVvLcN7JVgMOCbobpyNron5b03Ff9s+37+DDvn96dXVMaREbJnZ
eZ/zLE+tpRHhmB+AAMP30nVhiDF1kWDenkwv6BGTwCZ9h87JgPc2FQkLD6FFtssrnrfNnV0W
LqVJXN72MsVsH3hYWGThFTaLX2NjzRi7LquL6LlTCWwnCy72FqMzv01oX8Ul0p7gugvxRIRW
unn/NwoCz0TrzB/EgNJGmQcjGjNzONMupg6aJUY/g5ALYSLystWX4wvir2zr+9dXLc+HjHyW
VPffMKebNUcq3H660V3EXuP2d8LQEzTgEItG48ag5siMadZJilx7N0NHoJBIGTlnsdLR1ZYu
Ejdk1XvmejKgyXNEknKXc1bSB5IGWQ2GBMZ7eClFugxnKemkgegybyWF2ZxWLJczC2adSisQ
mrgezuqs6djAAtU4HxZx29jnmuNByhXJUTfXj8//+oSG+/3Ty+PDDfD0+mvI8ni6XAZWeyQM
s8Bt9XgHDeXeqGJ/4vFgLzh1gifxRRMT4++0Vl+U2sxCq9PVp/f/fKpePqXYeOc2y+CQVemO
tiOvd5S68wSTz+wyhFgOHnLBKvPSSBWkAVUOz7v+1LCW/sxQ7Ai0iLk40Jf6GpVaNEkGYYd7
6O5SbzfxSTbO6e88TaHX/g395J7JTT2S628A6VA8adrHYHqUjsgQJCBAlHJuUycymeE5yo6o
4XQjiyMo21HUuB78j/p/eAOT9OaHijt6oKVHfUBJz3VWJqdD4psW+zswww0zYJ+A7RDzlR6w
kbVa7+prLCjCaHAO9uZUJoAxv07WJpTVAlgMI2yN4H4AqvAxEnVbJZ8NQHZXxpwZtRrDNQ2Y
YV5WGD2OObNQfdSjGhUCvWWtVqhoUMqLD+sg4++Uw1Fa7fNG7cWTDYnRDZi3c8qjCeqr6VZ0
BpzPcxSoJ43EERl3UbTerBxGfRBGCxdaohI/hUWXR54bB+qjpOpwpSw8vX9z/SribBkuuz6r
K6PiGtjjRpEdOL8zRwRDu1tdq2nZllvLmwStu07bJ1gqNvNQLGYaDANVi14IPTNqmRaVQF9C
HHSWGglA6p4V2nGEtL/TipVprrupSjAGtTZ6ytW4zsQmmoWxHhHBRBFuZrO5DQmNDGCgsImq
EbCVF+FySeX0GimSfbBea5v9CJeFb2ba3rjn6Wq+NHTmTASryJMKGYNG9gfq3EI0unNAduo7
mUUKbysMGdWuBuRZE8FquP4V2TbXV2Y8wwZrUqt8Gg5TQC32OewTnEolqjAwzCH98MCAx+xc
KZ0SdKDgcbeK1kuizgPBZp522twaoKB09tFmX+fCOJUesHkezGYLcrG2mqRdNyTrYCaF3dnz
2se/7t9v2Mv7x9ufP2T28vfv92+gKHygAY18bp5xu3mAGfr0in/qXdWi3UHW5f/B1xXdgom5
Z4oPV+ug4dfaJMrTvTbTkpT3x1v7NzpLW3ISFym+CKH7Y0zyY7lpxGAXxH2sgfDlEf2a7lhj
QmQHMB5KnmV7gNcp/eyQsSaey8csJNn0nJVIBRv1OUdnQSSmV9A1COoD7UDvIKwXKdSba3me
3wTzzeLmH9unt8cT/PtPt7gta/KTkbpmhPTV3rQdJkRZCfqc52KR0yChB2hbif1wLq27J7My
28aNHSeo3o9xL97Yy+ufH96OZGV90INZ8ad0Z7Vh2y1u96ajtMKop9Zu7XB1ieNgC7EOcU69
8FzrGZ+cesLXBP51b+yPw9fVQeTq3ouEo+/dofNiRQoqUNl3vwezcHGZ5u739SoyST5Xd0TR
+ZEEal72qr/9No365Da/S6q4oSOitDoS68NUPYFPkp3rMkJ6mMZFtaMQ84yCZobNosFpG30i
SKukoSzkiWC3Dan67Rr9rUED3HMSc8CMkdzUlSaszCEZk4+oTTQCFhacN/pt2oRsuZ6b/cxX
+k56EX2oh1lOyBO+CVJRxeA5dqFi5txGyPQoVUMpFCZNYjllnrGYtcNzhXZu6oll8ONSKV/3
ebk/xGQZWbK5zH8X8zwlnWTOVTg0CVqx246SRbGc6SEVEwJn44EUjq1g8Spxlx6Z/YwSigFd
HdK9mv2amnwGoq2NrwwxXeHV8XG2BvvhEs682DPxPkQDa1Vw4UOpoHMzQsggOFR9zbqUUSGL
OmFyCINZMPfxkehwc4UJus+h1xhLy2geRHSd07sobXkcLGa+whTFLgjo1L0maduK2lH4LtAu
HGKCNIs3s/nCVz80lEEcrvDYx7wWe0NL0NF53jIPZhcXcecrXGHR+mJkeIBB26WYQ5MuZnv4
zFpx8JWzq6qMUXdpRhthHTXD7nQsmCsgNdd4MDOOSkeJlbhbrwIauTuUX319e9tuwyBce7BG
oLKJqWjEKUab9RTNZp7KKAIrukAnAAspCKIZfd1iEKaw5pGJqQ0qLoJgQdcFloQtPkjFah+B
/EHj0F30UIAp7RkSVuadqd0bnG/XAW0hG0tpXnJMT3eVMAf7cNsuu9nqerexHZlgUaeRfzfD
sy8kF/n3yeMVajThV9bUU9ZG6NB7QSxOfLPurs0Q3oGB2Hg3Cfk3a0P/6t2KRXRVpGDI5ari
mQKADmezzj5Icii8q6ZCr6/UouF969lhBSuMVK8mTlzqZtEGoecVK5OMb0kPP4uo9vSAOJQL
z6Iuusg4/jV6phar5Wzd0divebsKQ+/YfpXa57WNuSpY0rD+uF16doOm2vNhl597Zv4Xsex8
dcSXNZlrell59RQ0imoegSRVJVg9XoUMdKZg4XBUUFMhGjAN+1qVGLFXgx4o3GLjNg1X14uV
GlUKTMw1UmET0Fv0HhzsvXk3g75rWzPUYzR5u/V6tZkPFfMWDHTRJlyq6jkdicjNeuDhYHkc
LdxqyQvTBPZn3crRUFmOCXkat8oSe2S0NTfYq137eWNzbfIdPnhQNZ56SjkPg6ivT83UXWbv
d3UIQ1Tnt863p2Ixm8/8n44Est6E+n8qVrPF7EqzDuT5Rx0XHJPf+YquU5hWq/kcX4AjcNFy
vXDAJ+4ZGsR42tDcRrMlVuOSAMvBayp8MR0P66vMLSKL12E0888U1H6XyysTBYlW80lc7cmW
dcV8QW1sCg+LSbjaxHbNUh6bCqsBtlf4gVWWxzU+1lDAX0lMbcpDjZujXAD87UaC1XIkuMxo
tdYYGWgZOCJfLiC7BrZBVAocQbTJ2pqzNPCOQsPZwkkZL4FOIKuOFJw6U5CorX7PMkJslUDC
w2w4uHbK3gaUS9SACl3yOW3iDUjKvWhAxXZVl8vxxG1///YgHZXZb9UNHm9qB4lWa4gLRYtC
/uxZNNMfrlJA+K959ajAddzcJpkDTVktTEdUCYd9GeBkJyiCJqZDmBR2uBLqalieBPU8tSIb
7hBUDcx6iRCT8dlg6BiKOq4TAloV+FpeLWqnh1Af6sl2y2WKrvLBGgI8RLIecRwgfSmWy0hn
PmEKSnYmbM4Pwew2IL/ccsdMG07qKcGaTvGpY3V1zvv9/u3+2weG3NjXvup+ZqrC0ZeidANb
ZntnrFjqTk6CiY8KGdiCjuno9j9ODPH49nT/7LoNqbME5SuQmjrMgIqsF5bUpffPl08S8a74
yqsu92pGcYh5AvJXzIKZKSQGSr6/VenB8yMJamVEvQZtTX3lkf6JrNYNKAMD4xC3BHtfhN+A
TotarIOgc7iOCK09Nmu/+89A4EQd6/C+TQ/+T8GGJz4EKNVTFNkoCZfoMNdEwdqLvMQedjvK
TWbA7wV67s/DjqrvGXl9gE2jVAN6JYoZwacD8LPglBQIynl0QEpnhl1eMuLDCfcr/X5so6Xn
rbKBouIe3+axt9mWeZ4JHCiKuLTSrloc0rTsakpaJeJXmiHSYMUEfaYxSjDjSd5kMTEqQ7iB
D35hPg073Oc23nmyU5mESOSuBmccmlwy3u+cJJ0gSuJD1mC2wSBYhme3W4LSJ4foOULWZURc
aDOeC8WXWzvoB6AekIWYaG8lOWzUv0jh9mmTUsMF+sX1ZRuIykaFXf4eODya2qfwAFI+iVUP
NbK/PCN/RaThV97JIDe2g2WjqOhLtXECgPEjaAV82lXK/mswp7xlRh51kzkdicBLG0rLPSdc
Y7HHPDk4KYKsJeZE7bIAvT5YMKGdKmPeL6/EsCLJY7S5ha1v29h+nIhOkwyqq1XE7YqU0REh
Mz35xG0iIkVm8kE2VCy7VWnbFNYLvQNKRS2XmZUFj1ddrNzLCzKvtMRj9ujW4HlXpjK15s7M
Btvvs4IWTXyCTr29uz/KAJnUerpZY7Ij98Oy+lpxPevSoShMB6T9MR28V0wYvnxOSB26Y9Ah
esDVeZv9DFNPcv++0hrXSJ8AT8OhHBIzpC/1SxUDAx3MxjIrjCMWhMr0A8OrLWe7XmKkJ5SM
2vOxVJ47yo9ha7ySItF6ihUFgI3fAp0ws3GmO32owvFQotra1Lep6BOu+2KKOs8zCZcEBrKs
U44HGBb27LSqPk7aCUufctQ8cZpKdMn+NDwepQnNCJKh+2Armi/ETtgkXswDCqGlhXRwqP82
5Y6u9JnMWW4dCmk80GXw9vYKe5XL5SJ/HAeqcWPuFrroFJYg+qmQiaRj9d7I8INPJQz68pC7
QcbCfCMM2/MkHpeglA49xFQNmKp4Qd91ntEL3WBMm3ChbIUpt4WnKuMnIGHcTDsEkFsA0Yvb
kY4Ug2/ME4g2hX9rWiZ1sKRjwr41U1CXjIWgFjXGHY2GGa1gAsUAUub60bSOLQ/HqrWRBLcj
1B0dXbo7l49o5/OvdbjwY+zjWVAuizsnOdyYaMU7YmM3NgdQpTBYdsqloPzpwpRwWzTug6DF
0pkOOsWY5LJ3ZRAdtfQicg9fGf58AOTSpVA57//5/PH0+vz4F1Qb6yHDlajKgOqaqCMumYI+
L3e5w9TSA85QVaBRa0QUbbqYe27CR5o6jTfLBe1kYNL85ekCScFKVFSoSjQ5tXYgNsvNT60P
edGldWE46F7sTf37IbEFHmeZjIWZE0F2fLGrjKemRmAtExlPIjSd5WGw/XkIh/XtBjgD/PvP
9w867Y7RMXHBgiWpz0/Y1dyuEQA7G8iz9XJldztAoyDwj+medct9Ru1FcmGIdJcVCRHGvSZA
asa6hQkq5a1yaAGPLGMxSOjBGgYmlsvN0gGu5jMHtll1JuzIYrvFALLcq84z/+/3j8cfN3/8
ec7h+48fMErPf988/vjj8eHh8eHmt4Hq08+XTxhN+U9ralr56yRM6ixOz7cb6jZDorqOWTyS
lIfRfOkAJwcngzcibquSvIpEtEpXZzJLMWfEsGoYzLL4CPOOOmhTMxMzQctENuY2ZCFFER/9
WFRpMQ2kU7ZGYvv362QXbWekyHfhzLcw5zw/WsKoNCSru6nOkcuwiihTrw2TfkJqJu32RWx6
BcsZk8AgMmcIGfethahDFrWzKbGqNg63EPb562IdzWzWRZ2G1FsLcjW19UoJrD1aNuLa1dKT
3Emh16vQJ+f8uFp0dp15J+zyB6PAW0iFkkfeqCLSCHmXkJO1hcDqrUugjuEwU6zP69LZQevO
c9kKOBWndkF4p4NcTwMaxqyhbm7nVqeJeRouAmekMb00bFi0gSmXTD6mc9OhtS9UAJG0Y51C
gdWypYO9zvi1H38oV2BGhidfT4Da/+UAhlxj11hdWyQ1p6LzkWDMfWj22gjttyZ8yi5ggk/c
2vmnNKpGZbrCvwx1Rb25IMiY9tXZmfK/QJF9uX/GLeo3pTrcP9y/flCZ+qQw2kGrsofiSvRg
rYxaSvXxXSlGA0dtz7MVkEG58mm1DTJO+ynrtPHtVtBBWV4lyRhud8uQoCGEj8JgbCPGN9sb
Debsst0ZzhjU4Px7iyTxWRq6wTAVqWfDSvFlH4AM6W/OiOxEgsUxJeGc1UwirBAwUdMri6jJ
zAp7/YAHfhi2jHJwEHrqyfdRbZXg5ycMQdQFBFmgYeM5/iJSM7Y18Pn57T+2Xpy/yFdv6/1d
wZIbjNXyPUN58/ET+D3egAjDTHiQaYxgekiu7/9rpMRs6z5YRhG+2Z3e4q0HOYhuncYeciyO
MTXbgOjlmzp6xm5Wcj1KTKNHQ2V7KFMr/RBygr/oIgzE8Gq2XaWxKrGYr8OQgKPb20aXmQkD
KijoL5Qzw0TCM+rLhAdRRB2tjARZHC1nfX2oM7dC0rmLqCjoJUFkpC0eEDytw7mYRaYlbmNd
jABh0RfxCd4Fy1lHtQt9dKnLxaks6W+pZ3kZMcqNz4VjnFRpqncjSnrc0RNnoKjSvKg8KZLH
Gk2ZpQXqohfqbqg9U4NVehq3I9bkydmE3syIPpgMHRLe7xakEA7Iyz0xUtEnFJNYopUUeDZY
g4g0qKcxk8nvzBOUEZfe7UowlIxJPuLsaa1gtWM4nHEhMrpYW/zeorHbkzcFK+muna8vjaL6
sk92C/NJwalsV++2pb6LianQxeGS6B6Er6nprT/CPdW9/hLNVgsPIiIQrP6ymAUbEkGzkog1
KZWAWs0CKiOtVusoDFdkc6LVipxViNqsaD+MiSbjm1VwSTyRS0dXWxYQXJ4kkmY5v1LAZu1p
2mZD9KRCeL8g1uYvqVjMyDZIe0iIBEwBWNwuLULpOojo1StFH+SLn0bwKSGLIuNq7Fx4tFhS
8G5JgXlkuPJr8NADny/JphR1LNBXyX1ep3l8eXy/f795fXr59vH2TKnv004DKoWIyeTbYwX2
fb39P8aupMltXEn/FR9nDi+C+3KYA0RSEl2ESJOUxPKFUWNXdzvGz9VR7X7z5t8PEuCCJQH5
YFdVfknsayIXZHMVdMtayEA40FjXN/iSC1ec4xG4+oykaZ67Rv3Ohow/KQ20FTc8xaxMzVTc
ieSxewpLjJjowyxU5s4u/MXcfimzPInduT1YnyRGXGxsMmLiY5MLn8o7nv5quYhr5m9sEXaI
W8CQIGOs/0x8rISM/ksVjFJ3BSP3CWjn+7XcQscsidCFd4eLX2vBynflQZzoAUH7zxe0heGr
4ZwG3uOJAGwJLoIy2B4tBYwpDax9xtFHXQFMobWxAY1xeZjOlj0eHJwNjcaiMoXEXSfXyWBj
sqzBw3kStoSrd1PLHmXsJEJhGSuXVVlh+xZkn9i1kQEJDigacDKVHQzyDN3/QXZpuTGC0BP1
XqDxJOglfJGKRq6eW3gS5HDLoTM63TlEOz9OTWyEWGFl1ZBnrExYqBjxRv369dvL+Po/yKFj
SaICF2NUVp7ajoIW4nxDZAFAp63yoCRDHelr5LJFxyD1kIWFv0KEWE054uo7OmZ+iO6YgATu
2Qvl8V1rBB2TFN+PAXEeVoAhR3qW1wgdqlDg5FGBMz91r7LAkj1myd2HPsYS+64hz6oX8urt
L/q2sWcKaUo1hth6dR+itPGR0zoHQhuQI8vBrR4YRfaxsU0s2t3SFJOOQOBcbih9la67cHRm
RIPAXRh2ZDwvEbZjf3Of3B614/j6Sd1/AkGQLjDUT+f8yXJ4HiwBYoViiaa3KGO761mZCpKx
0NuVWYR303++/Pnn69cPXDKF3E/4lylbo7lXN3txxKu6A+fSoUe4KSHTuMYzOuOE0StL41D1
/XMHsdA6o0EdT+4bPp0G3SGJwPT3eNEHeuQqQTXMgoS59Z10egJVXaxbnVrWCtNCEy/ZI/xQ
7KjkPkdeSQXcmyOSW6oaWZ+bO/aSxLG67bQkmvZUF7fCSGWRFNsS2s1+lBF6yJIhNajV5bNw
5qJmQbuC5WDNQrxr62lNZlHp5JhmIODYusnBNlmHFbwYaqVQdOXFZCeUxGXAVqL2cDWXArtl
z4K31mYYLt0wF3110nPEhh1b0ObpjjrnXdekQtYj5MTVUs2g+Vmik7kjEo0ovfyqpVmXcFtp
blMWx8ZX96LMNdNzlUGExhwwO2iBG2/GgtxgT9diWaLlfFT9VztW102ZiVNf//3ny4+vygFt
8XTfxXGWaW21UFWPvwty0efmCWJGlvoM4LuAZ84CoAfWYcS1BkOzVRY6FMj5aWrmKFwjODpq
7OoiyHzspruOpnypifTWq7Wq2OuO5YPWFt5D9FW/TL040PuAUf3MNwcepweYQHqBWSv49H7T
khPeFvRltQtz+cKwELM0NFbH9Shldic8gzmWLP4c5lhUmiCzaBUsa4Xwg6P1WRHGWe7q1M36
z9Xx4BAHvSnveODrHcPJWWIOUg7kjoH0iU7mWiUcipjUxIvMwXzn4mFbBvdVKL+vD+aI3OI9
ukeqUAfVx+SYTWa9acN27LN9Xp61VHi8WIjX5+uNIUKqAiTLFZbNjG3lvqaVb1SCV+727f3n
3y/f3YdNcjqx3YrganqiWm3xdO3kDNGE12/uisTq7oNJj3Ft9v/xv98WRRf68tdPpd3ZJ0LX
g/uvbaUZuCPlEERZoGW0fjVhbyTyt/6dYomqR7adPpxqufZI2eU6Dd9f/qUaZ7CUFmWcc9Xj
lhAby0DRs+iGQ8W9WCmlBGRai8gQD38FkQrdBQBmH7/Nqgliy4XCIXu2koHMWn55+quAbwMs
eTCAncIKG2htpxj1nyhzCPVRFNAH/l7jysNUSlQWP0UG2TKYJHEB2JTxGBBoXGqOQsS8RhVj
SXRxCX7w8Xy+U/nk2ZVE4NJqtNyASFnMBzKyiSJ7P1/ca63f7M3CF25BR8rAw0gaH4E+1QlM
EthxzLM8sixFmEkxZnkUY/eDlaW4B54s9Vjp0ImyqFOmZza6b6EHJr2pTuyqeQtNBNGJWaEB
DUCytghD5Ua/EIO4pnP4BH6QJiugqhLp4Ln8hBVuhctxvrIhwnpvvtwsoSbXxgFfr/g5SWLx
0c19Gwfcb5lZ2o2+Jbl6OLMMN4DZ8f54hdjl5CqbDa1pgifRVDGL05AAaxiOsW3aMQpXD2pU
8wC+VnJ1c+ZIop/k0FPrh3zueSGW5pKno2nh0Ct7cl3p6t64Z8VHHJZVM4YJ+ti7MxSRnwQN
9jE0XxSnuGh2ZSqrkZsXCO4kxjYkKUHuFtDSWnmKlULoXdADdnVdedgMiHxZt0cB1GdzGQpi
zDWnzJGqQnYJilmG7o/ZncBDixTnmQVIJqQSrPJhhIwGcWPA8ljuCqk5Xfj8gl4P8ghZNE9t
Ux7r4Wwi/Rh7IdJz/cjWebSNuAr2dTh02G1qq1sRpPK5Yl8EFp9xZo7XYvA9L0AacLu5mv1V
5nkeo67VLvGYgHtGdV/Vdl7+53yrS5206HAL+bbwEPXykx3FsZP+FninTCMffwxWWLBb9c5A
wUu6XFcVwj1tyBzSdUcFcgsg95MM+GmKAnmg2DFvwJhOvgWI7ACaOQOSwAKo0hcVwp+tN57z
iN6bNxwUGJFch0KVvm7AVM9HAh5pL+wq1WBf6qZ4GzJOHbZ+b8GdRn/ubiP26QLNpCE9xWUe
K2vB/iM1m7K4h3edrVM9qK9wOdhkLzuHj5tdbQyaXGil1/ETuEwzAQi8MiEfHNM4TOPBBE5D
gXCP7Ip5HeHohFXs1MR+NuAnKokn8CxOsxYOdqwlSIHSJEAzFSZ8Nn9kgulcnxMfPUpsLXeg
pKJIix5oV01YxjW8h8Di5sz5Y4Eq/KwwW057P8BDlkEEbXZgcXwt9qcY/ZhDqSVulMKVI3NU
AGiD86NQjN9rZJ4A1YJVOAJrBoFFnUrhSVwdKjjQlR+OYAF2opEZEi9B5gtH/NyWapJkzmID
T/4g59BPQ6RHIIxagu9kHAqxt0+FI0J2AA7E6PDjUI6fatXi5u7VjBZd6DmXM9pMfXWCWYwV
ZCyS2H0MYOe4IMwSZxbV5Rj4EGtTO7JsDH3KVqYQHZA0wS42O5yGyAyiKT4xaeoaAAzO8M9Q
jWgJthTdonomMbi7uKG5O+McGVaMailOHgehuzM5j8VPhcrjWl8uYyEkmPUwyiGWNrwY08xD
ig5A7kUIIMwpEGAgYYDM2LYo5m61ejKqwNF8Hg6uBb4tkF2Yv43lsp6U6upi41vI6Mk3SHAz
A4UHjdq4nZvAbeqxMvM9dGTuh8RDmuQ4dHP4bNLBir44Hju0uPVl6K79XHdDh0mXNrY+jAN8
gWRQ4l6BGIdqZLID3RArgU83ZGiSzA+RM31Dg9hLkHsD31Ut81tAu5/8R9tfmDn3V9hp4hAr
97K5IXUVO5jlm8CzbUsMifFv2N6Q4ZtoGEXYpQfkG4n8sL0BHWsddD3taJIm0ehur26q2Lbt
Wsc+xdHw0fcygiwJw9iVZZEg5WUbT+RF+DGGYXGYoCpJK8u1KHMPmycABB66LU9lV/mo5vLK
8blhVUUShegBR4JsfbJylGV3HJYHXwQ5jLJR8kZmd0Ok6xkZu/kxcvhvrLYMKFzz1nAvswIV
LfzIQ/ZlBgS+BUhA1o6Ujg5FlFIfPw8P4zikqPBw/54mCTp4SVn4QVZmvvvYSMohxbUHNg5W
+Myy+F1I4LlGITBg+xqjh5YFdSxSTEi0wWda4IfKkXa+5xq8nAE9O3DE1QaMQSzU2KeRc/ln
DLGP5nqrSZIl2APNxjFmQYhme8/CNA1Pzq4FnszHtcdkntzHxIMKR4BKRjiEP5EqLK7NhDE0
bCUf0e1ZgMnlQT0NHYiNhR/T0Hh1pqvKlaJ5K9rIl/ZOnls5TMsGCW+c3GvcXF0g4mOJcLUd
BF2qaQWJeNJT4MpgqN5y0eX95eeXP76+/f6he3/9+e2fr29///xwevvX6/uPN1W4uaXT9dWS
zXxqb/YEjeiwa8O2xxFpoEW4iyJ5nE70epSxrVxcohRsENpRS+wXjEfiSEIkc+E0AAGECoyb
LEJxQBipgsjB4vc7nZkAKIZ6SY4NIfGoawKLw2usdT7XdQ9v346qszssBHVTZsiyabo+I2zo
l2QOwWuqWSQysOtV4qFlAvcPPYVjgrvXgG8gNJ/cbELLNHIzLUrNrgodR9YKEK8BK/Pi6Mg5
hO5IO1RdHqINBO6h0Jy6yxR5XvZoQHPfaG6mp3DuR5xn4VjfRtAaXy/TgwxWp7mOHNbnV7MB
QNMuhFftfizQAgi1WmfiQxqgjQsSILzZVw1CzJkwnYJlIuyU9Np0+uwA99T9CFRs5xlBDRxJ
XviKMun8+VPPAbyhzafpcHB3gOB7wFLWZKyeHoyn1ZGdm23Rf3cOKWHyrTbkSuw/E4W+2Eeg
w2+JFOXIanOjhX3fj6XvW5aONQswvMO+XVW0nctfU9PU93xj6SxiGF2lxV1ZEnpeNRwsg2fR
OlQb71DQiM8yjQjORAwitwXRyyTTrXpJjCn1wkz/tqanriysFaId1Neo8IqCo73E00rZtk+V
hcRKJ5wargeZUNoWZxL46ndX2sgduOqa/uO/X/56/bqfRIqX96/SAQSiVhVYv7O0OzyyC+ux
rh2G+qD4/B8Oyh8woJT4K/BVUZ9brmy1fb0PlR235ckdQesJoAx6wsIn/WzxzcM6myBJAln9
axaZF7WFe8O18bYAQ4s94nB8KaD4FAFoLfu3EgU+NkRRXQDiBSOutaekmAt6saCagZrA9Omx
+0j+7e8fX8Dn1xoQy7BBpcdSO94DZVWVUxZ4oA9higaWW0HNmpJyLcAuji1vsPwzMgZZ6tmi
gXMWdqqar4MSMULQIWjUsakm4RRdTZeD56Yosf4EDtZ4ce7Jt3FONc0DeHKaZtlOU/XjeIMu
jv4UF9YA6OaWOw1JRDfB3Iiq+s9GzrBb5YaqCkc7GZMPiN6sC9lQGrqSa+hNejrLbQZ//NwY
tIrojs02WmjQFO8wQAOroadDmIc6nZu/CzcwKnJixwnwj7c+tSvlp4UfLmqO1kFKuwC3feag
FBZa/WoKYnbiI6U94XOdRGyLsLjvWTjieOIce6XOIzivXLpoSxCorBa4rQgc8WrZ0gAIw2Is
JeXHg5yw7NDNEfBPQxIYg+AjuXxmy1ZbWqxGgeeponjRABTBiI1BKsj4s9qGJ6hutphcQl1Q
n3Kbazq1vzgdVTDdYdk+ZafmIULNIpOa5Z5ZGtCIRog5xplnRrHHJLR4ollh9B2cg+u1Xk/0
Mk6Vfdj21YjFvQNo1U6V1o41LK8SOX2j6nvatTj47DppbAhKAViv4yanvHSbJYxMXJUF1YoU
8Rhn2IszR58y2VkiJ4n7p0ocqgLZRYc6SpPJcKbKIbtNF4dprApXN6LtdMQZnp4zNtqVLZgc
phhpS/mrxXxMRKYc6bcv72+v31+//Hx/+/Hty18fOP6h/vHz9f23F0U4Jl18GIu5fq6hmH49
Ta3CwslxX2AaTJxhtYJVPmOXIELDkK2Z41AQ6+6/WfYpH4OWc4YJvpeUGzmyNB+IqzPLXQjQ
DYnvoYq4QjtWdT69Bp235bmY4Km5mmq2G1VRsV1LvRos6g0FQJzYDg6med9GzZIJoea+saYu
dNf5gLGwlV/W5FxFMOacWhFyLWW18zWqODbX7o0fpKFrCjQ0jMNQbzUzOCKnC7tKjajZLQLN
MIrmObXF+UJOaHBsfurSzV8louWIKNsB8urS2PcCk+Z7Ok3Xbt+otvHPwMjcokHG6xvHJ41B
P8MtgmGjSnfNa6JYoe5R5hvDt2/PVNj62jeChUU1HlY/tiCL/F4vCQ0DNml4uCtjfeYghzDV
CcHCJURGokdtPC2m8/ptp4Cw6SjRbMinMykJ6INd9XKCV/iZwK6gb/ByPBjbzXGXjy26E4oE
ayWad1KE51hPFZsnbTPimpc7J8QJu4oIkMOVyjrxOw9Eqx46VjmZC8mVnRhPbPV6ULblOOos
FdySM1lxUYWWC7SJlXEou/mUkAv70aHIsgQ0Zeu7cDa6wEwPZdF8XkuIPrAkSLv17oh5eZYw
fcYp0GKzj0O2r4w7uQYucxXpyeUy7uzJ7WKLIuoyrmIJdn/WWEJLwr763q9gAapAo7GgQ+FI
LnEYx2gTcyyTDX12TLXj2uni/okh9dCwOziaEehrBalP8Pqx/TYJH81AOJ+lmKxJY0GHNDdW
Qwut+25QEVtXN2Lbf1RkxpWkmLXZziPdSJEUuCZZhmsLKlx2nxI6G3qdVZiyJMqxBuFQgg6W
/SKL5wsX2ofZ5jHad4jdnQ5iBxS93lliTYHf1x8noais6phsqiRhReezFg8sWXdxhHpyk1my
LMZ7gyGqSw0Z+5TmwYOOHpPQtyw4gKEqzzuL7rRfQg61BSgI2wPR8WMKCSTsmE0e/tXx+rny
LdiNrWv4YOWQ6jJXA1Gta4lH9gqxk/kzaN/RsxUcaAkMdryTI/Vq4HU4zDdF2XhnkLUIx/Za
nIeir+C5aRzryzNeUy7McNbTkG1IEDsVW5Ido8xzr9O6naaM0Ftg6ZkhoB15kDLwDLZRPcQ0
SxNM8iXxrLae2PeLPOXBMjs0J3bjenBWFJeDQ9uqoWp0hltfHQ+2k4xg6e7Y5VHmWu8YaBL8
KjXfqCUasMTKKu8luCdBhSsLLE6+NK704iw3qPD6SWhZOkGMENiknCobW37di/sqcbHnpPs8
srJZrHE0Nh+NUKwxKXIbA8schX18m3H4XVKYVjEMloTVQYB0BTNCh0lXOHDsiSdtddmksET4
uq8LDLRFtCGH+iC9efe6oLaH+FGKj8qm7i1zA170irbU7vcqfqsLNL5eYYiIgXJpx/qotBhQ
u1p6/uXaMJzcq94gBOPMdgE4cF8+YjKH7Vu4FYpIZ0oCxTkNA3yB47D17gSoUOUhrVr4RRHI
D4gBaa4ioFjCmTVbqju9aMOIR+sSmBb0W0G52pJds2htC+PF/PT+8ucfIJ42IgmTk1K824lA
YGGkWSDgZN1db6HW16XsB5T9IWKUlbIyP1DLbibXSQp/vGs7Acrt+ikaF3uDh6o5gq8cNeEn
OizRe0368bBDSH6sTHQY2Smja5v29MwmmMUbLnxyPLByzxWFKVhbrHWBD0JJz6wzyvlY9xSC
ltoq1UGXqoUeR60xIVg4Wj3GidJPFZ25woelSWwYfDecaYWnOhRnrua8+ZV8/fHl7evr+4e3
9w9/vH7/k/0GYXAl7Qv4ikcGPKeel+jtL8JONr7FSf/Kcpm6eSwJuxVhYlCDKzYcNdqKyetB
eiqFlZcSPZdNUepF5kTWRO2dbQZsoeyv2KbPJwBp2ASoh074VZc7oGXTlMiFlMsgc/akrNT3
n53K5YHdiJ2VgInQUgmfvNNm1RWvBBQ1FgpWYliyXIcAKboP/0H+/vrt7UPx1r2/seL/9fb+
n+yPH799+/3v9xeQr6qNCg5M2WdK5X8pFZ5h+e2vP7+//N+H6sfv3368PsqnLIzqMxrrwqJD
Aa1d+OLwVPWXqpl1BYel6M7yyDlc2uutIlJ3LARwjEWK57kYJ2kH03h4Sf4rRsmrct6ulKfC
lCKZLsEDr7KKllTKGVzlNfXpPOrj5Ike1iFtnbG3U4U7beDgk8UpBoBmdAd1kKIqeXyqncgp
kE9PfJYUpAf973NJjfHOseZWYucYwD9NjZrYoWU3UG1NrvsRXN/qk6wjIvapMmC7lx+v37X1
hTOCyj4WY1ZiGK7D/Nnz2A5F4y6eL2MYx7mxlgrmQ1vN5xpkSEGaY4/vKut48z3/fmU93yRY
3iVE9KR4Vo7mEwxDTTtVuXLHqqYuyfxUhvHoo36+dtZjVU/sFPgEer01DQ5EFlopbM+EHbSO
z17qBVFZBwkJvRJjrZsalK/ZjzzL/AIvYX25tA07qnRemn8uMJOtnfdjWc/NyPKllRd7+kAU
PMtz1Th4qi2bxFFfTsvkYi3j5WmJuk6UeqAiJVSkGZ9YoufQj5I7lrXEx0p3Lv0syPEiXNob
10vnYwy9TaG8SZIGBMuZkstYTzNtyNGL03slW/buXG1T02qaYWNlv16urLtblK+vB3B8dp7b
Ed6ucjTPdijhHxsuYxBn6RyHqqXZzsn+J+woXxfz7Tb53tELowsq5dg/sYil8PR78lzWbHL1
NEl9NCAXypsZS9nC0l4O7dwf2DgrQ5Rju2wkpZ+UD1iq8EzQmSSxJOFHb5LNWy1c1DKkNSZY
T6zLu/FFlhGPbc1DFAfVERWT4Z8R4q55e2TJ2Qpc1U/t/P+MXVmz2ziu/ivn6d6nqdIuear6
gZZkm7G2SLIt50WV6T7dnbpZupJM9cy/vwApySIJyuchqWN8EPcFAEkg8G/Xg2t5lfHgBSWm
GYv3MNJatxsc2smEwd85fnyNs9vb+QO/d4v8WQvwHgYITLauj2P1bpWNaXvdhZmBLkWHwAvY
uaFatM/qsS9gON66Ez0g+/ZS3KcdKx5v74cjOWWvvANdqh5w9O+83Y7igUWhyaH7hqZxwjD1
Ym8tQ2r7rLJ1tzw7kjvrgihb9ePS1v77p9/+0LUCEcM7M0Vo9EZXV/nI0yryyCvkkgvaH6+f
okLkaxNrXvyBVAn3jnoeBXyLi0TRJzvX228onzPfLrIWRWW6DMY+iBv8iNYgyjwixC6UXaHa
+Go9awa8YnzMx30SOld/PGhbUXUrLDYBVNyavvKDiJiUqOuMTZdEpJMCjSfQBiHolvCPJ9pN
WAnxnUMGIZhRT43VJsko0Uzjxtr6/YlX6PA6jXxoQheEEUsufd2d+J7JG1dxpC3GGmoURsOp
UwCCLdnKJA41FDa5Q6O4B5zIXRWF0JFJZH7QZK7XKU6GhfBeMQzgMsAfQ+SrXsZ0PKbvOyls
ma7Crb+PPC13tA+w7BqHrmsFlht3hv1hZkitM0EsCuUpa5IwMCRzBRzfxZ5rtQUt2opJHNlp
TxdxZuBeJxmsI3PmTC33ouxLoNJm5aA1YjmIWVgUqDIsFg+1HYGnv9oqjmiR7c1kzeYg/EWv
yGibtORx9TVl4JoacwpIZAutldS+YldumC4n8ob7AbFiDpoSCYTD3pgLbdocL9ZeTHnbgkr4
Pi/tPE3hWhd+6AbPlH9ABrcpOXO89cOgf1Smma1Le551htz94V69LxuYvN2FMi6LcgiDiLas
ZGbWrevRbk4mg4AV67hNbb1yTTrp2JXRogOoInnVCxPw+P7C27PWrxiCrWVVJl5tCfHi8P3j
l9eXf/37999fv09uGFaSxWEPenaGPhof6QBNnJ7c16R1M8yWZWFnJuoECWRrGxhmAv8OvCja
PO0NIK2bOyTHDACGxjHfg9asIN29o9NCgEwLgXVaj5pAqeo258dqzKuMM8qmOudYr58gYhXz
AyhkMD7XRy/IfD0yJZoe0EqGL3hyNYG1tWvFCnyTEVxlRzsNlr/n1ZHs3D8/fv/t74/fibeI
2Jxi8ioJNqWn/4Z2PdS4lE6ioNojRtQ30UXq7/QOaqrnqPN8TcehQc4RYGIttfoBUB/UTGrN
tS7S+igM13diMD0QxKBTe63EXa8PAugy8voQQJdr3qmj6bjP9d8gkpa/BOu2vLZq46JHFjy5
UrugczPxRE4tNb6vVKfjlWecESTdLd8DsF8TfvAsA9DG1/IrvZ5hM8YBZbIQg30KIbNml0SQ
xGGzrkD8tyU78927nr+/UIv8g+lI52F7bogVEicY1uHX313SP5XEtE5C47lWACTOMTqKlHaH
NLPRNwsmlOyZ1bDx1VHkG+utvoMsJGLETABL07ywFUrbvJS5w6n9G0dZXsOay/XsznfS7TQg
fnZQZwISZLlMslmPa11ndU1JHwj2iRZ9F5dUUKhgO7UvR3TgHrFW0s6ocCFibQn7KV2MWwla
aqjU5lb2qL62+v7SDLAmJSqrckUPu+UE+8UeNgYcbuoI6EttX0KCbMxCGz3GgPDT6aimzY+3
lveWysyP6VaLwr6Ekd0HoVbOVaSBdUYZ0zQudVyJpwmWFSBHg1JdqkMco2t62mo60YTbgmOm
V3VG0RJsyWniMMfbvq1Z1p3y3DqApN5uRTtY/B3ab61oXTpsM24mJWs8rTSCNl9VMO9h6IzV
Be8UdI/ju0cSXSe8VKnb1wzR1OmocAM7dHR5OxTZYE9IewywOHYg21Jisppgw62JXWGbtbUo
cgWCC3WtLa7wTVwyxy57A5NmgKZYYNEYD+l5bIQjjPMvDsnVFXnejOyAQdKwrjIu1SwPIt9h
L62RLx9Buc6nGwiG47UlURRLMkisbpgf0YNqZpE2ma16LJymMWbhSWcr45hd+Saun6ASLNL8
AqrldhdI5QnGzVbhLdbytbn3afvOiZaobfJOudw002bxtSDjIyHXpG5NmZIanOju/cdf/+/z
pz/+/PnyPy8ob0wvyoxbVnjClRZMzEW8RvdodUTMeMqL+KF/tdTlwSG9gejOQAjGc595Ib1r
Ppjkg1GiWR4syp3xB9l0ofHA7O8mHjzS9ZbiTnFVyQzfCDhWKCYh8y6+UtHIdxhdXgFSTjFW
LE0iHw8RnzdoAGjpcGwzz+pJu4Gtbs0SqVvjl68Kdw09JyajCT+Y9lnkOjHZpG06pFVFNtsU
OGWaGk8mwPw9qHe4sazGPShAIJ2Sqra+6sD6otV3yty41Tin0NWXau1jWPsxzo9cV6QmLQ3C
mBeZSeR5ugsTlZ6VLK+OaP030jndsrxRSS27laD/qUQY/Q1sJR2o2ge8Q6ii76ADTAqICc2l
H7ULlYjWXYdXFYn+n6tBtEF2rxg6w4GNsF53CGIwg1GwzkBg8db0SdIZQb4cWaPVCaPcj6rg
geRr3u7rLhfwgfTFrjDxqtfqrgk7C2n+SGvZvhivDO+doNWObMV3sJnxOb6UynGVAVH1OnQ5
KMdVSu4gor2aS+C440Xx7CR6pin8UTFPTdTApF4Hk8bSXSwP57QGEG60tF7LLmV5174v6rrR
a1P2DbvaatJ36hmUrH7LWTFe3Cgk77c/mkD/EkdLySpvsIRvmKs4ReZk5NEBct26zmydDm1T
Zal3c7d3I5DetHnI13YlkXEmE1RLk7lJYHGsjfCH3o0c0u2xRD3fjfQ005InPu2Je0YVL/mV
8Iig+4eeqZThDMG8c6UXfOUToNLHbKKh0kgzHSL1eOmEHMLJIECSIR/6Ni+1qQd0WDj05N6x
Dx9Ia988PzrFfb4g9nznDVNf0NjSQDrmGwUoeUvvoHKs2Dsbx5Gt5fbsptW+61Kmxi8X4xaG
9AEvA1gXZ04NQcsTXTmlu0B7paXiPedD8wQWdm9L0C1kuiQJHflgAj1j1CCVDpaF4M3T+fd9
QvqKEeOcOa4TaTOi5Iq/QtHhw/2YVyMxjSVirR+OnoT07S5BJVTkgzZW+c1cWNIuDH2jPQQ1
tB/Uyr1qOJA+L3ExZ23BPG1ZOAq//CqtYHeTUX4dEF8H1NfGig9rKum+XkwnbR3N01Pta/so
rzJ+rCkaJ6nZO5p3oJmNOZ5XnevHtuEnUW21OJSJo5FOsm/lPaFvX//358vv377/8frz5ee3
l4+//QZK4afPP//x6evL75++f8Gznx/I8IKfTadAK1frU3qlXlRQ7dzYs++Hwm9dMtjqMsOa
4Hmu26PrucY0K+rC1pHFEAVRkOuiHx8MKaYqvdDY1Zp0ONnkoZbDUpwZi2Fb5uQLwgnbaVNe
kEJtc7hylkijoyplSrK5rik8bX+pO20AXgfP0/K4lwe51oiRcMr+IZ4t6H3L9MHDHqcRedaZ
qOg6veAICK3BUmjE21wSqG+lUrDPNxNo0OOueKykawGICvkSMmFFn5+pPCSDNP5s5CLZOn4s
Wb8+Q1BxefxuyUO3AZJMy+GqJREg5gOzHDRorLDTWDc6lc035paO49bwPCnxds/WOB33nTCw
DiwTeAjOyxMRhxokeBlRXHnpeJFX/diB/MY0AWBStJfxbhaxzamCl3gjsupNCKREy0cNjrai
xgp/yH+JAmOFw7Yc6VHfNDbBtBmYPF0w5IEDb/MbJ1/nybUMfTnr60JTp+dcq1aTiS09Pajk
rk4NgtRs1ChrEzKvExuWBGSbrQQmMr9iNDS1FTaeLxXvR3xEaVO7RSkzQwKdyCK2LveefCy4
uibjZpMoz8AIKP0Agkrsubty2CV+GOPFjdNWbvKbtg+jIBTMmkYnjKNGXyxk6D0rlJW6erhA
XWf9CqCtRBEmEt65EmXl7oge68skNpW9Ryr4NJx8I2KkNoRPExOqHRkWSGupUl9uHiCMCapL
S35ua2Ho6clIxyhdpKdmTgJ+aDksqBhO/bCFtoYIMPvln5LfGEfp/Vjp0xK+FnErsGC3E+/6
Qt8qp3gixvDKctjyKnFDi2iYFdqoDkClo9Jv6Yt8FImS5OH76+uPXz9+fn1JmwseH0nvpN++
fPn2dcX67S98efiD+OSfqpDSCYscPi5T39yvsY7Zdtzl6wsMhsGc3eLrjlw9BITd9CTpHHK3
fQ8D8MDpKxJKEli5p1xDerUJq6tqeid90InBVA6iDS7GkENE87P/cBe71bPKfudhrOnIcx1q
/Lz7EMSB82RQn3l7vtU1sQ+tkSluEOhJY2bskLKiNvFOoGJf7uQb+iK/6iLeg+ec5+We3W2w
uXA/MHx6PB7w2mVW3PHxwnGsWKkrKWK16c/jvk+v3fJUnWGTT6cDotHZl8/f/vj068tfnz/+
hN9ffqizY/L7wC96W0zAcISSZJklSqTC19caH82VlXgBEsTjXl9cVCZsi/bA0nyDiVcboIxm
ZimsODAR9v2nJRZzWAmNRuD2ksAuQkGY9XjpeaHrnhIVkvCxuJC1Pw6r8tN1FD47+poZj1rs
vCga9/TdmGW8Cf5+57ghOd/fMPqU2gwdLTUK4NgX6gvTlXhLfvU+rQkBUoQQGNP122UVUi/e
q5h5UK3irHmfOG5kg7s0dhPDLCb27x5S3RLzZMJjt7dUlLb6IwhaQ/QU1RWSB8YOWxAIq0Rj
PeAUFJozsVJNHPpceEAtzDB5zZj+srN+CdBGqYjB1aGbIQKw91YLlcLnXxsdNr251FKdHmI2
qWECW95obkkIE4/cEukM0S/dWVzysww0jW23s5vdBH/J2v79Nss6SaP8RIpLzrr4Z2ht+7wt
65bYNYv6VrDKWOwExHsQVPGa71b3VPXNTLXO2pqTibK2Qn/hzzsc3fXm3cN1lbW1So6P4m+l
m6jPVTQReL16tq9fX398/IHoD1Oo7U4ByGzEuEeXD7/8l5LCrIkbadeHtYRjVgpwLVYVyQOK
75ZkjSz1wZbB5LujhVGxpclIVihojffYDNcia7aqJs6RNZByr7Vm6/qWp/3I9nxMTzksdk+L
ZpywzxDsLGm+5Itm2+2mGNpLhTuH/WRL5Z9vFPBmWzl4fCFLBPwYb4vrbp+sn8mwsPO1SxBL
oGXoKiv8y6uevmXpk7pjmQ4FSvFozHlTqdq8Z7yarWh9PtCjgi6oeMVnlfFnDvvglaL8nMJ2
8zdWKVSKCosZng6/4XsvqIB9XE9xJaTHkhD6nNzWdSUPveHIz1eGh82gIGSppI7y+fPfn75+
ff1urkzaKnepAr5c/VDrc6kSbn2yrXFMZnutSpcqdAwGPZPAsP4RHJt7uCgGy4TBF2+3zx4K
Z5F5ozGM/RGd4RGGUCR7jrC12tGMUTbUCbRYs2b4mRlD8GEkj9NFv56yQslRJbNwl28tZQCG
TIurZefctnwJNjcR12OMox61SFnJntdbvkQe4a/mNGtkJJ+w2To2FI2WoW8tj7SAUvdUdbZd
7Hq2TGDvKruC04vtVJsiDSPrEeWDr2TDLlHC1pi1VV2jq/is3xmykCmq9K//AUGFf/3x8/u/
v7x+/WmTiHo+5hkGaqQOEvAp/xZ4eYCiGGamoGSsi/VPao2dIyMz6zHYmqtMWUeeDMwM13Rz
/IkozqaVeoHKdE+nP6FNZlpjzeb/1zcMYPry96eff765KzADf3Y0ay0B2+dzuJ9ntaS1dOFi
YMyvpbKkvnUAmaWavd5ulGaKdk4uZhMmFwSLlWvFZzkxGvpDc2R0DsJJA/7dLEKB3ASNF7iL
JlMUcpMjV/iNmHsPVUiLYzQDt3KENZsoJAAsowceQ58pzvbGXafqnU/iXM5NrHcAJwbiEtwD
weZ7+rkah2eNJcSix7LY912XAthlMfQR5WEX14+NkFp2xmdFF2w+XQ431q/7PJDBikQbiP5I
zcDfUNw4sWaQPMkgeVMGO3ofmrE3JmEbD+wSOw6x4wrEdRM7Mp5utnIJmA7DtWK7Jo5llCNk
u9z34CCHSee6MZ3qOXCtZ7AzA1nfcxDoDwgmeuiHNF2/ATLRI5cqM9AD47x3QbZkGWTQb8VJ
eugnhI0Q6CFZFZSaPKpsUpwygX3mJeQX+37s0tqkp+8dZ+dfydkwRyl+tq6mnR8WVGkkQJRG
AkRnSIDoPQkQbYc3TouAzByAkOzACXoyFSSXNWVbWWJS3BbXqreGOTJEZMUDLya2BkEnxpik
2xa4CdXWJpJtGJ6tFcDlu/oF+xmgp45AqBdhKwY1qLUC6JdsF4AeMiLmtQWgdIwp4DVd8NAv
rNewBcfgOUFAfwxQTDpLW0ROeRhtMSQi6oV7u+yCDBEhAJGM8XNJqSDmrLhQRDSaoNv4iUVN
Xkwi6b5HXBIwA6wtCB0Te4alIypbk+Vd7PrbpxbA4gVb+13eJT51Tod0j6i6pNvm5oRuyw3H
vowoceuUsdSizkwQIWtzMR3N+5cCq6p6bM++sykT8w60raIg7LJFGewC2vSwxDiFLWkjbRn3
3kxZ2ggSon3t1oMJIRYDgfhhbMtIXm83D60RC53tASSYSM+CCocS21tDjNvhK+xpwqTIPiO2
YbjgXXZ7moG1rUMbEJGKuzg+dSOMa7p9HVpnzviR94wwpjdp6UaUDoBAnBAL0ATQErkAd8Ty
NAG21pzh7VmNXErAZA3YSh3hp6n7jkPMFwFERE9NwEa2An6eLXQBMbFmZCt9gT+TU4ARYxnT
zp0UJu8/T5Xhme9ZprAo2h8dCoYiMp7QTXQ/oBaatvdiQrIBMqUtAHlHdGbbuw5lKhB0YoGR
9IYElKCdCt14B/lAniwYbR+GLnmYjUZd+4PAiYFsUIvtW95jpum0RiCQLbkUGaiZIujEKivo
liJEZO+FESXmLwZvgp4Quomk2ybWhGodRbDFjvMWLtd9E1f4ZGjQt7IEwkGwJdZF8RbGeDC4
RuhlfEFXZ2YGi3BSzOB/EXlrq9ySVd5f1bHJDGum35Web33pPHOELjnTEIocw15n5Xu25gFf
EG5KKF3PSLEc6dQmD/TQI3ZXoKe7OKJuSOEhCqOPClnnheHmsRFyRKQEi1BsCY2k8FifN04c
GOzPLDYCsUu0jAD0d6MTEAWUCtuD7hNQOlF/YLskpoDi6nsO4yll61mBtoVgzfJsLD14t9bo
hct39Te+KuwNVAus4aeFFkzbwseD11oYUIso29T0ZZYObkDKqn3nM8+LaX9oDyZpQ9kqIrJQ
FsnHAZcJ4KkWVahLxlx/08AkOAKiNQRAnT6AfL3zKcuKAKikboXr0favW+k41veAksH1QmfM
r8Q+fys9cncAukfTQ9dKJzZNpFOmDRl3kqQHpnuHCdHivpAsZPxRhYEYFst1TJMeU4If0j1C
dBB0QgRZHjhRdEs6gYXf0mqWuwiIbC7CgoFYg5FOSUFATxy6CYFuW18mdHthETcm6NrtqKMP
+caMplOyK9JDas4BnRJABZ3uhV1EN82ONmkIZHu7FCxbqg8yJJZWoEyxgk6PxR1lWxB0S213
lnx3ltanrEE3yy1uQSfP+wSy3SQ7h7JDIJ2u4i6m1C/bHRxBp6dVx5LE3X588aHwMSr6Rvk/
iKsHu6jRH/MjWJRBEhJrA5p64pAQXARAKUDCOEQfqZap68fJ1pJZFl7kms42BNRHfkiHClJY
trpQMFCV6SNSKazYJfEpnRuBkJr1lXQMYwGolpcAMbQlQBrM+4ZFoKmzLYFavjGBoYOvydqa
SkayXCeOp2m1w5IUiffDKqvpto16/UT5TupctpdOK1gF7PfpVq/JpVsKnpk3R0989QX8GPfi
Fs5dvPevjv1JQVu2ehdwMb59OB2QF3D/ev3108fPIuPHjZul2fELFmDcNqKpBZi2aw10IY2H
g0ZtmrWpXpAu6DBAq1penNdPz5CWnjBqm07j8Esn1pcja1UadC8rCo2xaeuMn/O7oviJFIQj
B0td07v2cB+J0N7HusLodg/6g2Y0Q44xjXVakSsPvQTtAxRPL90xL/e8pX2iC/zQ0u6fBFjU
La8v1EVShK/8yoq1R0MkQhlEpDyNes/1kt1Yod3iV5LObyJWnzYS7+3szk9Ji6csoxUcgfZ2
7B3bW2JrI9rfeHUiw1PIqlYdh8lUa4OvSIU3Do2YZ3qpi7yqr9SCJMD6yHESGR9NdPzRUM23
MKzHDBLbS7kv8oZlnoSWZBE8gnQHZEt6t1OeF+YoFH7mSxggRueW0Lkt+XBCovdDwTptjLS5
nARaHhzvddSH3sgCnzO0+d2Wx6Xo+TwSlQ+rnhKY/5+1b2tuHMcZ/Supedqt2jlry/eHfZAl
2VZHt4iy4/SLKpN4ul2bTvok6drp/fUHICmJIEGnv6/OS6cNQLwTBEFcEFPWKvCNue3DAnP8
wEYwmKIBdMakSpowuyuOdq0VMB9fcgKJz8JCZuuLfNsN8yyJxgpnaQDdptSpisNnwESYOn0c
3PZIi2QaoCwtuCTREt8kYe581OBKSdAfzPfZvqiyvcNGazbgj9z0mHIzFGZclh5krWRZPjrv
fSrvsBL/xk69Gw+YkkgS6wjEJG9bp7PNrt6LRoUK9Va1x+O1rQQnEEo+mKZ52Vjn3DEt8pKC
Pid1aQ9cB7N2Lqn/812M4gofBE8OGLAxDPvN5miSh25WCVPa4QSAPkc8FUf6itBmV24xjsUM
yHZbwjFLPGvsQu2PtB+vasDz++npKhU7XipS/kiA1vLRUAf7nTIFz+MrsVEIYReIgWgAaRfH
ftOHVWL6shfrttxFqfbj1FmRDJkM8Ani1+lWI9ucZJrgKOJEEMUB0jA5Cnp8nnP2DTnIH01q
BiLuIL1bnxyo/PTt5fWneD8//Ns1xO4/2RcCXaRBKNrnCffp7uXtHTOrv7++PD2REPpDO7vC
mnSTt54M4z3RJ3mCFO1kyWk3e7J6tgqYLupoaC2JOYnhH2loN/ylQuqQg7WHtvK8407XgUSe
WHBIlLVV7rrGINwFhone3YIYGxbbpA92ARScFC4/DIvJKJitePlGUQCj5h3zFPo2GI05xqXa
haFyTNXcAJ0tnXFo9jWIt22ZF6y0LGlkHPqRVaAEBhxw4lSCIdxZW9ceuzJfhyRUTKJgerSh
UbmGmW9v9uvEnVKFq0PeR1zSVFG4mlEXIkpgB3QnDa0mq+nU7jIAZ4Hb5Wo2YhX3HXZ2PA6h
EJxvZwFnMjZgJ04rZrO5MxvVkuSk6YCW+cwwMDNvgxE9n9izYau2JbDPPUC+N/MUSEidbPdZ
2LjbKg6WI2Y8m8lsxSdMkPhCeNdXkTTHdbq16gE5JXJXahOF85knDY0iyKLZauyfWZldwXR2
7PfF7C+ntrIJ2FTnqqSk2ATjdR45n6ViMt5kk/GK18qZNNbjkcWblA/V0/n5338b//0KDqKr
eruWePjmxzPm8mCkiqu/DbLX3x3utkbZlL+8qn19h/n0/Pg8O8LS8A0KBiCyxraB8znfe/cS
MpcL84n4YME9ealhrCTjU/kFn+7fvspEJ83L68NXi8f3Q9u8nr98IcesaiYcF1sSFN4E2ykA
CK6EQ2ZXNu5i1fi84S8whGiXgAC+TkLOQZ0QMpkYCV7Fq+ErCSMQ4dOGu/0ROuSynuJ1nMxW
zqUc1PP39/s/nk5vV+9qZIfFWZze/zw/vcP/Hl6e/zx/ufobTsD7PUYF/js//ujQX4iUBMSk
3QtzYjBKkHDFNJUfBAdsRiV/4D9ERV/hwXYZhdn2ylx7/epa427lNx27BjDHmRDpOs34aUnQ
rhfYMOaaEFFtOklLlBO0AqHm/EsqlS8W9/aGl/sklT8No2pF1rKirkRWVTSlcYUl+IhaUOab
uonsQKMIkiIdQx6jmTCm9TEzyPYwO1CGgTkQYRsQblbZUNwVEeqndWgJlBRlbqXbtDEVcmGN
6qNQDB9s0iLuyEntrQpLSmE6RVz3Ae0JSRqKsjO6SYstiX4Z5pEa5+lIVIl0MTfHDwOJAohN
yQwVoFOA+bCMMBGOx0ea5Bih+2LOaRXi274OMs8qsGOce7JvYpDBmE2bvEtFSgN8pjlcImIr
6qe+fwJsPnWgZdUNhIZfT+jXebSR9ZtNztMMOO2+QVt6dsB6gqPubX/XqzAqW0ghjV38oT2W
vGoDw5Pxg1Gsq40eXrOsChYd/0GVHa3oqDLKBg+i1msSmlPKqo7turWI71tVffCIak1rJVEQ
DHCaW4Sdz7RsS8TAreGX3IQWof2h+5zZ9lQ01+1O8AOIuOjG+kAGSNvhYmvzbc7f+Acafpdg
o61AaRrqAOgNGYD2UtUgpGNDSm2s9VjDCIlQOFMpV1ECwoPgtfoY+ck30V2ZqAmxd78OnOBh
OqUyvxxoEYiaabE2n4/UXs5Um3tOHT2d0eHePEx71uvjNjEGT2eD/AxsGW6gaWxUtN5vupiw
hg88VrRJMxru4lbCmdL3qhzCXuF3m5eHZEhQbjYTsc6BS9EiyTYy/rRTLAiLlQeKh3yTkKgG
Vh/782R/xAx/mRlqFA6nOovom0s8xZNDC/C8PlSRsDhk6aGI0tSbZHjXjOfXbB49+IJGl6nC
WmbQqjD7IccTZVZEpevBkJOC5BVW2HVZNj3ut9+GwnXfQVjDvGJM6SYBuckYCEdjZbS98CiN
9p4kJ4cNq+tAQcJNYYVQU0hVv/GWSq4DGuyLwKbRh7ji95fGrzH8PPtQpQlkXgW3MTnXQkz1
G+X4ZpK0jpSniaRcAqOcwCDvNxvzKoZtpb/QPsCF4AXAHIl0Ex24WT7sStGAYNFkhqytgHVK
33sUFIfYucTLuFZvL3++X+1+fj+9/n64+vLj9PZOlPx6e35E2rVhWyd3JB4+7MjEfEhWv21p
uIeqe5tkLOnnpL1e/ysYTZcXyPLwaFIamRE0cZ5ihHa1Ern9oqhSEbrLVeOqKCNmjQaYWvqY
CM5C2cCbqtABvDTNqkzwnAcv2drziZV8hhKgPwGMSFoGoxFNmUYIqiiYzDXerqOnmE+Qwl8X
7IsltU81EZy2rZviMBq5YxGHYjzP3akA+GjJ9kV+wdQP8CWrNjO+W47cSYrRcp5rWROQXEMG
eDzm6kfEhUmS+Blf3oIFm8rvDpyDDB02DnyTzZiFFmI287QcB+2SxaVpXbbMSkxxzaXB6Dpy
UNH8iG6RpYPIq2jO7p0wvhkH3GulxhdA0rQguM/cudE4tzaJyJlmdIjxPGbaAtgsXFfR5SUO
+81M7jlA45DdzTnXEADvuWHCd6ObiQMXs4Bb1JiR/UNOpxKheJldtFZ7po1cnNpmDKJA3E2L
vlo0DhPFI8+ZthGv3bEHnTWWGIjkgey25GYfSgsZqK7i8MvA9HMYgDOm1QhuL039tfpLklYy
TPYSg+XH2N1jgl5Th3Fo+GU9xJu2e+VNFtOEW/WFem8Hse7t/f7L+fmLraAOHx5OT6fXl2+n
9+5psnsdpxhF/Xz/9PIF86s9nr+c3++fUM8KxTnfXqIzS+rQf5x/fzy/nh7wwkDL7O4OcbOw
cnVqkOuNRhvxURXqunf//f4ByJ4fTt7e9dUuFtO5ed35+GN185O1wx+FFj+f37+e3s5k4Lw0
kqg4vf/n5fXfsmc//3t6/cdV+u376VFWHNGJ6Bs7W00m7PD8YmF6lbzDqoEvT69ffl7JFYFr
KY3MYUkWS3M/akDvFtEvK19Rsqb69PbyhC9RH66xjyh7oxFm8RvawnUr8sXM41yjtlHrmI7q
Jfz4+nJ+pOtegax9CFdAYhvcpbfSmXoNxG3T3Ml0zk3ZhJnMxyuMfFsDXloqK/SQ83krWgzH
hxdOotuCG7qoTP2HluztdwYClmo2K3RMR4A11CUxtOpQ+C7IjWWHly9JDMvq8Wbw2wFYVmuS
ZbvDWCacHViZSjuVH9J1jU/MF+pf12m8hVtftbtzi9XPVE65PofYvpW3XCz5DkvzUPeTUJPI
1OsoV3nZqZ6vy6J0iHbpjaFdLfoES2Z7CTVchENeP3BMM9S8w2pKN5xCYJMmWYxttJKb73I0
ZsHWCzR95/QluztYIZP5YoTKPTKUZRZvUtb4JtrBWkv6BBemIKBiiTkA6qbdAesqF1uGVuya
ygXLvFjkzO0Cl+1g7yUHXvDRNHKVr0NuoXUkhzXTRB2W3EUo6z8Ss7hH4SObBYbBreJBD6hR
eZJlYVEezVwhg+ZavrO3u7KpMlZJqAnoDigzEO+O5XjBuZ7vMM9hlBnbFn7A0OF+vt4bY94R
YqJBYFTG+lZKQF2IOtmeXnrTNZW4pc7hMPjz9HrCo+sRjssvz+QQTCNWQYv1iUr5xwxn+a+V
bsx4JhX+/GPr0Hpk2ovFfOlRJRhUq+lyxvW/ra+XljTZYXbpfDY7sigR5SRjF0GxLokmRTqz
Iq5ZyBlnlERpxvbN0MBNPZdmg2RhKxw63DofL5eeS39HE8VRshjN2YFB3Cqwrwo9VqBvcBtx
lvsGGb41brLkqELccgUxKds4sm2Sp8UHsxFKS29+loO8EkStBUDGr9ss7ZjiX1/abSS5Kev0
xrNxMjEeBcsQOEkWp1u2UfLxjMVUYZaHgkeZdmEGvDwWoX0b7XCHiGM+5q7Kq6CXddjFFC/G
S9aGy5zK9AhygXXlx5GM0KyfNg5bfAszP+P1Uh16YenTOvjK+5kKY7VOG9He1hXGS86KYLmr
IrucdZhegwTZsDsU8SAKYKSV+FDR7jBigwa3mHHRu1o6gnYbehx5OqprPlu5MdQpHL5uj+BT
lQrS36V2VwfcdwUb43zABs4YtKK2C6phB67RYc0T2oJwZOCN8+gw8eklCeHKw9Un87lv+yoh
6sOyF6tldLDVFsaxEZgRRepEJI00kjArFc1+bZB7Lko9Dbb5o9FZl6JhH3PyY+TIC5i8ZJnn
DKywJ0hCfRMtkTe9SuT5y+n5/CCDq7t28HBnS4oU2rI17AgZnAqwaTbDxgazNTsaNt3C85hp
kfnePA2y43jELjpKszQfLTpUE+318BsuF8w4MWsJXS5hTg1+j/F3pGnnReEtPz2e75vTv7GC
YfxN3o13b+ILZSKbYGFp6ikK2LW4408aTZDmW3HnO1k0zQFD0t95dJgW7S7dfFBj0uw+rHEd
V79aIZxrHxa3ncS/VJyl5KYo3ahLFP1geik+VVs1mBcaDGT5ZhtteNNAhjj/xc51E3mpgYek
uNi8+WI++7hd88WCi/tm0awWnpYg6uLSlQQXR1tSHD4Ya0WkevxRcxfzwLc6EPXRspY0anN8
PHySWC3sXyL+cKyX44lP1EfknDcId6h+uU2SWM3PLxK7K95PemFhSIKPpn05XnDWLxbNcnKh
gOVECdS/2EEgj8Jf2aaS9OLCVhQVHsx14hOPLDI+UgdPH8a8UsxXesEJMi6xmt9Lfeqm9UKN
zEF0idrd2B7qGQ2U6deGkOPaONE/SuPM30C3ag1dqPrXEvTmoglr+DeajGEY4VY0DLM0ndzG
IrJAdUXS2RvNoql5JXE4m7iFhgsFo1aasmNVJLpwwn57zp5SxMcZd4HtqUQeY3vZugDOW3+F
1U27jaJ2OVry0ZeQIM8Zik4oBHxYycTCpJs9fD4ac+FtUl3xdGTeazoofuRClyMzHCdCMxaq
aBdEpQQDreBzNuBQj17R18MBPuFOjwFNr2AIzzSc+yxWn63mpsEHQjMXCkWpCSAhuIaazei9
BrENVsQrHur0WRey4hSRxndLq7RqP8DZ8rilcAOrWy0FGkQpwsMA4JjDmHu9xsd2UWkC41Ej
kqU5mY81OPAVJrs0tvPP9Om24Xxg2kKKl733tzaHYphWqeca/4ewKtQ4LElYYb2EaAyoWI+0
A1VtsxQFOPDNHq0Hcew9M3MzF5igVc+OVbvbJLUCbHDXR4UYeg8oPYeA8XRejr9b6FE2gESr
GwoLSAxA3dYxB2QplXfq0My+X+MZO0U93i6t77ddd4+gX1R52lboUwVMO04NrzBl278h58s1
stcjOZ9QR7zJu1ztOS29l4MtDbC2o6fAJE8Olrqr/hxSLT/CFmIVsLE1JXYZLibh1CoGgIvp
iAPaFUrghAM6ikcF9uhHBoLQp+hU6LU9NBIasY1NONrFkgOuGOCKK3TlDrAEs2aTPZYb4BU/
Qvx5ZKA9DZizuvMevXAU1AruYZYDwepDAs81uicIvR0C1Hw7mliLSuxgSdpjj14mUbVtqV1X
h9kmRYBoHjXxoPZiDV9lZXSNHhPslpN1wrFQX8I2FY8F/sC/WTERgMQkmk/7yAFIxR9is+qA
DlIfkCXHu6IU7QRj5vKklHBK32cpckZLYfBzC2+3Yzb95SbPpsGvkoZ1Pp/+Ki3c94Uc+4hV
WGsyIChN9wPpyDb29U5hgw/nDMmmk8sTIZdFukkPibUZJKytatPdS6rBpeuTKCO0FLqAmjjv
KATti4COXn0f9Es2b18cPfHBEdNG0Z7/dtgMDRoYw7HpGZTOpY92MdvmqAAfgNqd7xDt2R2n
3PwG1O5WVGmBW98cnQEqHdA4S4iBQt8vuY9FWnMOIiZFZdqRmQh0sTQwIsnbPeYvpZp38fLj
Fc0Y7AcPGW2A+AQrSFWXa7qyRB1Zb6CdUZEVsaB76evhfY+7jMESwU4zGprLEDuXaG6lhZpD
oNGbpsnrEexBp/r0WCHH9H2YJ6Is5u5n+DDr+6aOmW6qhOu+TzCnewrz5Hyms197+31oZFpa
X7lFFeWLrntkC4dxUkRJ2zSR9+NQ5Cvkyu7HauLj9RHrBq6S79l9V4nFeMxUjm7I/i4VsIzr
5AIBsp6ttNyDOfe2XjeySjErxM56pkeM8kPOjP0MZ8FhkUsXxpTu6bDJgdtVKe+Rq7A+syJZ
lzqrqUGDtBdpcmZxoXlDW1eXRgndh72rCfmutQF1Qz7hBRc7YhxPO729o5yD5s2eMP9OLilh
/Hie3X3Z5DzbTnSXMSvHhYk7Ev+k3XKC6zyvOdVCjzSdWDSw2ttsLM2POMdt1HCrWjSwJngD
zrCJYOTGF/Zb/3ZKB78DQ60wbC6cAGXoM1ixFU7TfKrsIoke1OLb/Ydhmq1LU0kGHc0JpDP1
a/Pdnqz7EHjWBDlFfQsrUn80zDkcKrJFiOA4hQ4ZQepSr/9OWcpwwFeS7oP0ZXBUnFJBmlac
BzSeL1UcObWpTQ7fsHEW0AU/j2+shssIFBj/gkJxU1FC2Sgs2xhykBb20NDUBg2RUuQBvEWT
9/PDlUReVfdfTjKKjRGtcGB38nv0mt02MkSIZFOWIl+vj4+KpW0a7Eutyjo3TNQvNLu63G85
S9xyo8gpR6tCE4ISkE01wHpnUXelqR7wJ+UotYsUkxXI19EtCzdaQNinU4X2Ofj28n76/vry
4ApGdYJRP7U5kgNrIxLhp9vch2oPvNwyYcL6BTUoNHwZnBaoln3/9vaFaZQ2ZB7GEAHSMJkT
TiSyMNRACqKeRjBQkB+j3x0Itnf8HppPmmlsxXJfxOjo4Aw53CKu/iZ+vr2fvl2Vz1fR1/P3
v1+9YWixP2EtM8EkUfqq8jaGlZQWwimvexsSLxEX1VKgOB8WB2pCqOHSyCQU+5q3WlNU2yPe
fNKCtYfvSYYWuvUkiacDFl3O1jS4mDA9VUMgzUOtERgOMonFcw4PQe7SZFCIoixNIUlhqiCU
3xIpSaEuNthtl3m+rsYyaD/1GrGxYlN3bHT9+nL/+PDyjZ/q7i7SuYUYSzFSIS/55EmIBaFW
NIaWSB4wOTmM2cqVa9ax+ufm9XR6e7gH5nvz8pre+KbiZp9GkQ4Nwl1cBIa9amMSES2uwhAV
BoUodYSQzovrg3pVwLT/kx99rUGJYVtFh8CzOo0RkhZ0ZuVOucq0Du5Xf/3Fz4++e93kW1NW
UsCiIj1jipHFJ8/yfMvO7ydV+frH+QmDv/Xsw6k1S5vEDECJP2WPANDUZZaRSHsKu1+jswOG
I/jXdGjUr1euI+YOz+UMX9LCiCEINhit9xBWEYXB5qpDYj6AUPmecFvThIP6mOFNLQakj1U1
16451RA4guuO7OjNj/sn2BeeXalEuVKIVilTrGdsOJTDIobLpe8RHE/V1kzDoKBinTqFZRkr
90lcFWPUw6wirtISc5OnHgy+r7ugKnYqFnnC+XhpXEwPUgm9jQohOo5Khd7a3Ajs2Jr70nnm
qTF0SGQ6/KElJgvSqngWTB9tDXLPQ2lPQW3fuCLYx7YBzbdnzELnPDF5JzXAY0+n+BDABoHv
eXig4JONDfjQaVJerlOS5rwnni7Y9k/ZzprPawZ0wkKjET8CU4+VlEERfkix5l7hegl/W5M0
AIbkr1gRW3pP9eH5xDyPdPp5+J6VMDSeMEOK6sMSA5/aV5krVXRR6Q5l1oTbpCPztFFSTxxq
Y6aQyLhL7qXGTYlInQx0PD+dn+0TtucXHLbPCfBLcnevO8jxNNrUSW82r39ebV+A8PmFihIa
2W7LQ5cxqSziBJk7MxomNTBe1FGERUTCnxESlOhEeOBEJpMOAwKLKrxQENxw04N7Jem6xlw+
4PrdLQft9SopGYEVCFGgMqiIzkUrdx3UMNBtclChaJ22S0TXjKJkXdNY2qqiF2FK1G+veMOp
5pJjEw2Rd5O/3h9ennVIU2OkCHEbxlH7iXhra8RGhKupadGj4bZbtQbn4XE8nS24PMIDxWRC
430MmMVivuLMXE2K5XTCf4wxuz0Pg5JEubD5S6+aYjamxiYaoyQCtAfBaFb+EupmuVpMQmew
RD6b0XjoGoHREu1o9QxN1DkO+6uWVA38Owmo8VuSlzUXNDg17yopxmuzYqYNsDZas2AagZXA
7eC2BhYTLcClaJ/blV2j63pLIiQiWAdRZqK6IVb913SmNr5xSGWtAnlXTxKYJOJWR5cj2jaF
0B/wQ2m0suMGfKyWjrHEx2xiSgYaQL3gJXAROABKtc7Dqekupn7bNBEsbRlJOuOhdi7UOAw8
4lMcTsaczADTXsem664CrCzAeOQMbqObMMEIBkzJ10cRG8XIn7R/18fo0/V4NDbkpzyaBKbH
FNxYQBabOQC74wj2OcQBbjll05ADZjWbjVsa6kFDbQBhYPkxguniTHoAMw+IUV1zvZyQ1J8A
WIcz4g7/vwgC1K+uxWg1rsmqXATUDAog89G8TTdwXGOozRBu4rzxPVCuPNkNQgzCdERjAM8T
jlJRWegOiRomQBmtlDqnMA9ncWBhjlUwOrqw5ZLCUG8kHVgpOIrQMa+rzdgAK9w224pvYFIc
kqysMFBlk0QkO0ZnomJWgu+sWY0HMAHvjiToYaenJjQgtyxiu3VZFaFjtGf0AIsJJZyPmiiY
Lvi7gsQtedMvifMcuygLTOZ8vg8MmjBnuUgeVZOp6bbUeROi7xNIFhiSlo5fUrSfx/aMKsWs
CGsCLcL9YmmGD8Snd3sslJzgnV5lanZXl7TCupg187HVil5SsxsiomDhzgIseyibr1bIiW7z
Mu5TrljvZ4hG9sNf+FSU7420YP4VIt/eBBoZWJ7HSgufaLQcs8HAESmASxscRqe4hwVhDo+M
gzDRW2wAHzZzGTHcDPetjIGO3Uj+T6OZbV5fnt+vkudHU+MJZ1KdiCikelv3C/2O8f0JrmJ2
rtY8mgbWnumfA/oP/heBzMaU2/9iILPo6+nb+QHDk52e36w7YNhksNyrnQ5Yw7JcpEg+l5rE
lCCS+XJk/7Zi+UTCCsKZhjf2Guz3RTwZWYeogpEisRlpjZkZxVZldzH2kJhwSp3D5+WKZL9z
hoQKJTSKj3A2jcoQfH7Un8uYZdHLt28vz+bFnicwF1ou+ipUF/vwfxgHhsyXER2N4NTznKi6
mtxmuEgi9TZWE3icmQ6wi3YHS+5ebQt+uc5GcxJfbjYxVwv8nk7n5PdsFdQyAr0FnRCGB6D5
ygkj2B3PVdm0VoaTWEynbFDe7rSMSQqHeTAxTfPgtJqZYV/x99K03IdDC+MGmIKZ5KRmoT2o
G0iTaQJ4NvOcv4rrxSEfMvHiTPRr6fHHt28/tW6JMjqt9Yn3eU7Cz9s4da/hpHOHsr+nkSVL
mqCSMb2e/u+P0/PDzz5o4n8xNVUci39WWdaFu1TWNNJm4v795fWf8fnt/fX8xw8MCmmu8Yt0
krD6ev92+j0DstPjVfby8v3qb1DP36/+7NvxZrTDLPt/+mX33Qc9JFvpy8/Xl7eHl+8nGNtu
z/dcdTueEy6Lv+lm3RxDEYC4ysMobV7tJyPTG0UD7KuQZgBS2HHuZgNVs51YOdCc1el2TvHP
0/3T+1eDyXXQ1/er+v79dJW/PJ/fyViEm2RqOaehSmk0ZiNoaFRgLka2eANptki158e38+P5
/acxMQMnyoPJmLu8xbuGHnq7GG8T3FM2YILR2JiOXSMCk72o33QOd80+oA8j6YK/RiIiIEKD
0yEdXwW4BuaJ+3a6f/vxevp2AjnnBwwQ6fA6T/Xa4x7Cj6VYLkxlRAexl9Z1fpxz4n9aHNo0
yqfB3CzFhFpnFGBg9c7l6iUqLRPBnGqZyOexOPrgl75p0wkRNi8MnMr5df7y9d3d1WH8KW7F
ZGzdr/dHWK/cWg6zCVkl8Bv2nZn8qYrFamKOm4RY7rChWEwC9uq13o0XJlfA39RDMoIjbLz0
uOYDbsL6RuXQzolVzJxdqoiYz8iAbKsgrEZsrHqFgiEYjUyd4Y2Yw2YJM/JK3gs4IgtWvBc0
JTGzr0rI2DzfP4lwHJiamLqqRzNzz3al9elU+xtzTRN6HmBSp2aobOBZwOHMadQQQwVWlOEY
OLbZw7JqYO65ea2grcEIkUbz0vGYZnlFyJS/5YvmejJhHQthU+wPqaCijwbRLdREYjIdTy2A
qdzsRqyB0Z7NjSGTgKUFWJifAmA6m5B1sxez8TLgXrEOUZHR8VWQidGJQ5LLG6gNMZ94D9mc
+Dp/hhmAcR6brIFufWVgcv/l+fSu1HPsiXKN/uLc/keEqZy7Hq1WlHtohW4ebgsPhwYUcByi
Fo0ms2DKKWVlMT6dbDdbcNGdLcm7NUW4FzdE1jmsp5EPTr+5C/NwF8IfMZuQY4wdSTXGP57e
z9+fTn9RSya8bu3JJZAQ6lPw4en8zExPz+wZvFkDGkW38mm0fwXo0ole/Y5hrZ8fQUx/PhGL
LpkOp0nqel813EuDNTXKJ0Ib8F98l1C0hNI61jAUrYHqO8o3Wh9ozyBDyTSq989ffjzB/7+/
vJ1lmHbnmJP8eNpWpaAb4+MiiHj8/eUdjtWzGfV+uAwGC+58iDGHiPkiANe2KXWSw4sbfxog
RrGUjsdUmS1JetrGthvGkApSWV6t7Lhv3pLV1+oW83p6QymD5R3rajQf5VxMonVeBVRTg7/p
TouzHfA4w1strkA+IaxhV414jW4aVWNbCB+GucrG45mPJVUZsCRyluViZmmHCWrCvS9rplXV
ibBeAzuodSDNpubi2FXBaG6gP1chiDNzB2AHx3emYxD5njF+PcNCXKSe2Je/zt9QLMdd8Xh+
U1o9Z0N1mqn8el2ht98xzdOG3t1RXpmxskCWxmEtDSZbM6RAvh4HdGdUacEHc6s3mE2BFchE
vSGBKY4ra/UAhA+vil8aAhceyJMRfck+ZLNJNjp6c0d8MHz/f1MVKLZ++vYdlQ2ezSgZ3ygE
fp6wES7z7LgazU2RSEHoPDQ5SL9c5BeJMJRSDXByU8KTv4OYsHSmwb1EadpRww/YaMRUE0Fp
zHnPIUYlwm3MuO4IxkVUlcWWQpuyzCy6hJqZ6fpbT55GWQjmgNbOOsMayRNfFHvTpw9+2CHY
EWQlRUOQdBpkQCC9rim4f0J0wehS60B1wF4TmNRZWlgw28IdgZ3PJtmuCPcaicje3Ub2Byot
L7vLEa1dHz3l7dL1oaENS/OtDTiO7UoBFvAPhhoLJ62vTp0EdGvNpd5pdk1ZNVlNOXMihVSK
XxFZndAvpDZQCBdCM7MO0CFUv4GSL5IWCG3HU1HZDe+ePL2jlB89a1y5bcW55dqImCoKV/Pl
zK6rOvJZHBFnRE8G+Y1/M5R0EevFJFHaEbWhGeclSj+Oer4cTENNoBU3QcKyYBlVWWyXL19T
vW1GT0FfzY01q5anfg8ifskaWiVOO9Cp3NsOaV7oaUiTJlFoVQGwXe1ws+Y2cwCYVt5ui/JE
d96x0vrm6uHr+buRerI7xOobnCOiQAKukPJ3yxgdTOETQ1EiXZnDlPCeblHAdo6QvPLZEXd0
0IiLBBgNyU/VLRBZH/9sLaZLvHbWNyzaDLbso+maslsKp55hLIe01WEaJ6aTMfA9wIsmsSIf
ILxo4NrqsRGUBiVYclTm67RgL4KYh3WL9hCYKbxKjSOKYNSJ38vZjZ7J4eprr5K+8VUYXbck
76hMnwS7HjMTkns+Zk+CD8qoMbMoqTjm8MPx7VGYsNmZgZs08CjGNEKcgkunMY8qS1PIo5Yz
7lDo/tS1v1MIbR3g/R6Ti9iNRVsdt0B1oG1vvUVdB6ayRsGysGjMzEEaqg40G2wdOwawyxlV
Mx1Fuxhvm5hoDQrROw2xiIpYxki4TnVCYfIp0YEiv82r8WzhYOy4OBqMQWlsYB/g3O1xtzG9
ve537jbbO83DoDMDTEej6YLzT0gEQAup4/mrG+Du7kr8+ONNGvsPPBiTctTAfmh+qwHY5ikc
0LFCD+weEJ2Qg3bGZcOpBZDKyvqBIO1d7ytX+3ejuTF/sGGjlIftOAhl9C1P3ZRqInPY27Xp
1XrcOhnuPWSy3Uirc2/86ifYVU87tSMqNnJHh0rlt+gaTj+Be61OmtWxxS7CjgxIxoysym3h
jBihKUQgZzSu+bxtspwaaw8bj3DXUUAx/g5j691u9UFpyrq2/B5MtD2WLJGA/cRLPyZRmB1K
2ga8majkEHR41WY4Aks1l66B1HEtnI90GAwGjuwej1amKLigpkVRysmiOMWh20N9xCTP3JrW
FDVIFJ7doeJ9TBYzaduf7UE0qFunFeokkzPNItzhOcAtt4VyoWH7xmS/JnYpw9M5tcFloQ2W
BVz+hClFEJQ7Gohy25FXEw/ULVzG0XFag9A9ucRr4FGwtLvY6S76zsqVIiwMJl88zlBeiRNh
T14ZJVnZaKR3kUuZ5cIO04FJbjDqsjsS6siElRPYtWv3V/be1KPdWZBwZBuiqES7SfKmVCpA
t3Ck2gk5nZcqkYU5g9N1C0NBX+h9HcpgFU6/h0iOeB5YuN7xSf46jjxouSvd2aZ4mHKXPwye
i8ye7ZHNXcWrWYBIS+RxpcLK0uI1Ui45P9rluV1kKme19wg13fSQ1gEkL5y+vUzDfW8iWS2K
SeO2ebjp7CJ7czXqcj6eQPNgMBgBo6eYagrvNoPb+m46WthLzaLB2zpmWNzd+SZOXsTHq2lb
BXva3DjUMhQFh/l8NvVwiE+LYJy0t+lnpjKpotFXHcrQQTyt0iqxVr26I1wnSb4OYY3keXQJ
7zSz15nJY6y0WzqgsWSfhKisrPvQioPSnUis/Sfo+Ek0F3Fj+tLnpvIUfmg9mvEqt7bDe3XS
tukzD10ldmD4uwuX1N7WqSenmSS7huXZOPplq6g8dCicNMLdaV3EdWnn0fWkGI5D45ZWHPIk
t37aymkFlKqA1KFFcBmVZmRalXaqTTZ7QZiY+qC7FCQYD4lj8JSMlKxQ6LLSVTlMGpylskZ2
QNWptLFrHC5hHW91irAJmPagrGoNgR5Hue8xFa0xbD1j8oyPsreV5XFKri7iT/c1rbA4CBi5
bUX9M5S3h69rMmiZpzG1FaPCQkshvjjUYe4s0t3t1fvr/YN8ZrS1ejAuhk6myVXmXLS7poq6
AYXxR7inGKTobIcNkCj3dZQY0W9c3A7Ye7NOwobFbpracghXjKrZsVuM6WxXqFYO9OXg7zbf
1p3igDNjtEjakD5j6kh6VQ1yjt+bpi9Fk0cHbj31VMhcW6rJkDiV3XoA6tI2dZJ8Thys5tTQ
tDhxAhXI8upkm5oaoXLDwyUw3mQupA03e2dEEV6kpdDzVIVRW0z4tHY9vcX2yVDkVeubHfow
CT/bIpGOu21Rxp65AKI8lFco29/apSApmw24nc0VUYKknpGQdYKOzBRYRmRfNQnHB/J91qQw
Y8ekD51l2CdxkaDyPfqQbRergBsoxG5JTCqE6EjAnAmUE6qmAr5aGVxVpFbgRvjddlnWOe6Q
pblSCxvK+DTXQYT4oGbSDgr+XyRRY+//Do6HnkdTbxDJWkrM/sKJr4TUeWwiWCWXm42BrYUE
vIVKaQsVnVEPjcGgfCDOT6crJT6RmT2EaKnRACMU6GYr+IDJAs2qUlgDkbFNkyM+i9OIkR2s
XauQ1xX3frhJs6RFfEojsmA0EHQ5vCMUfHuSIqrvqialKlZAHBIQyDjt2kb0Oc97+liB2FmT
GBkzhNQQej+52ZcNOQEkAHhGI2+gcqbRnZmTfWvAavrbsC6sgVEIKXH66m0b4NPkm03etAfO
NEdhjFu7LCBqaPS+fVNuxBRGjV17Cm1huyGCMWtJ2nkiwKgYkS1dNyVMWxbeWQVqt8WHryfD
LAnGE2oeIqhScBM2wmSJURjtErpEJEhReni4okCdXLm1RB6LxglZ2iHK9Sfc0Vnq2aO6V0od
/3b68fhy9Sds0WGH9iujjMhgSsC17dolofjk0PBO8hJfYVShvIQLSel5r5ZxS3dpFtcJ92p1
ndSF2Rbr+tDkFZ1VCRhYB/8kKmmOYdPwEdfzTdxGNYhvJF84/pHrj1wS3XHsy0lFJLkKhvNO
cqPRZR0W26Qrq2NjkrnwIJTMRbhNTS7+abMRASHvIHqFjIYO9xh5c1Q+bOzIKEIBQm9Y82qJ
vihn+CwS1LGiZSJ6spaSa3IbV9F+JvlQFKxGOw9j/GFTkA0uf8PNzBBa4DJkDaqCrMPoGmOs
3HHkeONpqDEB7EHWgxf2+21ZX/OTWmT0RxfD+F+/nd9elsvZ6vfxb8YVJ0On0ziR+2M64Y2G
CNGCtQylJAtiAkNwSzajlEUS0B4YmJkXs/BXyeYAskjGvoLn3saY/hMWZurFeDswn1/oAJeL
j5CsJv7PVzPeYtgqgH8Mo0TTDxuyXFh9T0WJq65dejo+Jjm7bJQ1LaGI0tTuaFcDd+Cb+MD3
ISe6mvip70Pe/sGk4DNdmhT+LddR+Ma87/fEOyKcjwshsJbjdZku29ouTkK5GOSIzOEWChws
LOyvEBElcN3i7YEGEhAO9zV3telJ6jJs0rCgbZWYuzrNMvMpq8Nsw4SHg6x47YJTaCmI4Ayi
2Js5IkiPU77Tzb6+TgUXKB4p9s3G2Ar7IsXlTlSsCgQX7TqHG8rnsJFBGJJs46pSOx9o84aj
QhWcHn68oqH2y3f09zCkKkxJP9SPv9o6udmjR40jMGLkV5DiMCAeEGLiRO7sbGp8OI27kocL
kbqnaAwrU9218Q5O5aSWnTTFqyTa42WmjUHkkBYgTZ3Sy2pHwtujaSQrpe/CA4i4YR0nBTQO
rzlRWd21YQbXrpAEE3KIzAa4JWygCDzk2Sa55MjkRBXyhnkbEPHxFqaUdaxaEAYtkqXlsF5U
oF5T0cegocpm96/f/vn2x/n5nz/eTq/fXh5Pv389PX0/vf7W68510oNhDswYC5nI//Xb0/3z
I8YC+Af+8/jyn+d//Lz/dg+/7h+/n5//8Xb/5wlaen78x/n5/fQFF+I//vj+529qbV6fXp9P
T1df718fT9JFY1ijOjz0t5fXn1fn5zN6/J7/e6/DEPTX0xRtldAcrihJADxEoK0JzmPfC3pL
7mhQtWeQsLvK044O7e9GHxLE3oSD0Aj7ouwUUNHrz+/vL1cPL6+nq5fXKzUbpi8KEoOwVxGx
UwLDbEtSbBBw4MKTMGaBLqm4jtJqRxLnUIT7yS4UOxboktbmDWKAsYS9AOs03NuS0Nf466py
qa9N9VtXAl4bXFJg+uGWKVfD3Q9sHQqlR8t0mckEObsnIzn9IDk2deiSU+LtZhws833mtKbY
ZzzQbXgl/zpg+YdZQ/tmB+zegevsNRTYB65UGoAffzydH37/9+nn1YPcCF9e779//ems/1qE
Tkmxu96SyG1FErGEsQiZqYHLLiAuzYXIWRd8PUD7+pAEs5nM8q1eMn+8f0UHw4f799PjVfIs
e4k+mP85v3+9Ct/eXh7OEhXfv9873Y6i3Gn6loFFOzi8w2BUldmddlu3t/k2FWPT5b7rTnJj
Zt7th2EXArM8dL1Yy9AveFy8uW1cu2MebdYurHF3TtS4XC2J1szEZDVnwquRJVNdxbXr2Aim
bJBEMGOAv/xi5x/YGOTAZu9OCSod+vHb3b999Q1fHrrt3HHAI9ejg6LsPGJPb+9uDXU0CZg5
QrBbyVEzcnuQ1ll4nQScsREhcOcT6mnGozjduCuZPTO8Q53HUwY2Y9oK0LZizRs6ghQWuDRi
dMelzmMSC6jbKLtwzAKxJg4RzOYceDZmjttdOHGBOQNDZfe63DJ9vq2gZFeHfP7+9fTqrrow
YcSJRJAo6/28lreblJmoDqENrpk2RWGewAWNezrrKfDm0X3v4txVgFB3YGOmPxvPIaZ5JdNe
OK4ruO74mytydwk2tyU7PBo+9E5NyMu37+jQ3MXWsruxycKGk/c7Nvi5dCpaTt0VlX12Gwqw
nbtSP4umj6Ffg2D/8u2q+PHtj9NrF+mLb2lYiLSNqpp9pup6U69l9NC9O12I0UzOGQOJC8Xu
0iksiSJWc25QOPV+SpsmQaPqWt3mXHFNJ62z6+tQTsM8ZF4BuqeoC24Xm2hY6ofq0iD0xCjE
/xJhUkiBs1yj0YjHeqtnNeElKRPHAVPw2PeYp/Mfr/dwb3p9+fF+fmbOuyxds9xHwuuIWbaA
0GdL55NxiYbFqT1vfO6IFz3Rhb2HNL2Ad7EtRA500Ry3Qnh39IG4izmWxpdILlVvHKH+jg7S
4uUue46y3S23d5MDXsBv04L3kzPI4NScms5Uu9u2DosYbbItjPFRl3+EuUAiWszcu5xskvQo
911TDApmXgZsw03bgIZxuoBNGQlswHL3FlJyMJpy1xWkuYku7mNFgimaLrJqoErzbZNE/EUe
8dpoyDdIRgpEZmbCTXKMEjYx+UAVRdZbvoGT3iCCtQo3ByzPym0atduje9W18O4TNmlvsOef
bQ2iziK4jIQUnkA6+J98sos4rXoo7vI8QX2n1JCiJfzQEwNZ7deZphH7tSYbzBQGwub/VXZk
y3Hjxl9R7VNSlbhGjlZrP+iBQ2KGtHiJh2bkF5ZXO6uoHMsqHYk/P32AZDcAjryuWq8H3QRB
HH13oy4kVuCV+19XH4fYoMUxizEkhuNhZH/1Zdx+wGiNa4Rjd4sxM4j6m/UVi64UlEo4QS/y
FW22RftobTgIBsNZaDiZNtAxs8F6gH+SUv188uf3p5Pn+7sHLrtx++/D7df7hzsRi0lOUmmo
bpQP24e3F7/84kDZ9CImyXvew7AX5a0+nivLdFUmUXPjDidsx+aegbPFlxhQEUYeAyt+Yk7G
Ia+zEsdA0TebkYPni6w7z0qsm04BAzoSP1qKVFpnoKrAGsoAmDGjErSYMkaDeUM5LnJ7SJTc
lAvQErNFu0z6uuOqSVRSU5MVZij7Yq3ur2NXg0yMntI8Y7pOV8bUY7GB+bqS6TDHQKdAjlRN
p+eakMCxI503SK3iIev6QXegVXH4Ofl8nI4RAgffrG9CRbUUwlng0ajZRYuCH2Kss7D+E58r
0UwLarFIGgaZwbc4xMLy5JsYmPGLbw6MALScKZpj7gtbMQ7XbcdYDhRPc3VSP7Pw5bSCThXo
GVtDPYMWFcQG3SrcHh4faF0BdGoO4e8/Y7P7e9h/OPfaKDek9nGzSK6gbYxkEZW5rUv7Qlnh
LAiT9kIc2ILX8SevN20Enr8NpkbebjQew4AbruHbdPOq0Hn2cys6G+Wd9woGr5SwdSykGwpN
vI7yMYhw4p54eS+Qimu8ZryJhKqYYrUMne7ATRiUNyjyge3qBidMd6mkH6ekcTIAqN22Sx0Y
AjCZCZUxOb4mTgkWJUkzdMP52Vq6qRECX51HDSYIpMZmEQso6oJOMSbVPOirtMdhrGGeQWtv
LgNboN3mvHji2OOV32pKkitJefNK7TH8fYwClDkGewW2TFcVmSZP+eehi1TnWMAD9J2QAFrU
mYr8gh+bRExYlSUUuw88SW0E2BzjEK6TtvIHtjUdho9Vm0TuIFo83Bs15pcoB94EAkhjOIut
qKMOJhaEowBej9c6wVna5H2bjg78iXsBc05MXXVOG+vuwC/xcq7VxDAxHVpmLaw/RVspJXUo
eWiuNJXbcwSH+RyVp3g2q2QOuJ8cp6OURq2PT/cPL1+5sNy3w/OdH7kQc6bLAPJ7DoJFPjkG
f1vEuOoz012cTetsRVKvhwkDhOZ1hVK1aZoykoF/fCrgPxBp1lWrri1ZHPtk8Lv/z+GfL/ff
rCD2TKi33P7kf+mmgVdTNPTFh9OP7+UCgPbVYvKaDPlrTJSQVQdAYnsarBWEySKw5tLvZ8+3
iSmwpMjaIuokSXQhNJChKvMbt49NRXlEfckP0B4d/vVenKTrAiRHzIhQNEA8vDPRJV0WF9vq
VaMs+7OTRlNMhsr723FrJYffX+/u0CefPTy/PL1itXCd1BGhCgjCdRO6r9KOT8m5YxtRuB3+
feRB8usSXoFJDEf6wQiGpQgVOuOX20RMp/019Ya/F73BBLxUjyfrKeiBDYEXqx+nEgr/7GDB
gGtEXdSikTQFmXrlk511G2FJhDLrQMUZeH/NIUwIDaooP7VQejox8trk/hy690TK2JGpXxFN
jgcfNDS81ka7Krg7hBP3Cim0+Gy1K5UaS7ptlbWVm7Iw9wcnMyT/MwKHybfusbDNQeFfY2AM
y1u9c1nixZdgGPESDOtmpCpgRMPh0CJ7t2k6S1jW3jwS2lP3Y9o8CnkU6QDY9QdWmAOVcN/w
VjuyUFigKmct/PR8tVq5b59wp1CgzfKCTciYATK0seSV9mOIufbIYwQ5BZ6cWJApQeZPDV0C
6wzlOpRrMZ03i5M1XR95pHyhme8lpZCnwPZkkouEOUQ7xi8GAQSl8cDxS7NtGr7cXawdfTUm
uGyA2Pl9KPBxMhi1crodAPrAHcGTrJgW6hvKGYq7HyWaspoJGYjTSu1yXrzQITdXPaY7KSsc
A7IS20MkmsA0DW5n3idx85xUL7mlR/acfZlymTmOEUCkk+r74/M/TvC6nddH5qzpl4c7mX0T
YTk+TJpQCotqxhS6XngpMG2trwOXMrbVpvOB0yytq6rDiy4LiUhvCtmVFpHtcNQpx5cNKdbv
AH4W0lp2VyDfgJSTWJ/6lEh4bJY4xhbEkj9eURYJsBs+9Y6GxY3WZybbxtytOXQw0LdeUyTs
l8bUzHzYfIchOjNL/dvz4/0Dhu3AJ3x7fTn8OMA/Di+37969+7uw7GGyInW5Jel+Si6TqVHX
x1ISqQf8ApcAoTrcd2ZvPP7TwrDxMY9khdF3O4YAt6h2FMLqkZJm15pimZLRGJ0DhW2gHXkN
aABrL05/dZspIqq10HMXygSeUuotysdjKKSBMd6Z96IMeC/o7qC+mH7s7b3/QTx4ZyJYF4aZ
gr0RNPLNz+N6k6vaihqh6aOJg+Pa9Y1xLDnzqsyiyrSpN+5Ds674F3ap/mYgYps82sowcZzR
sYzBOCzUVmCph75sjUngwLFx0ZMTWERZaAbRDXh9azTV/Mpi6x9fXr6coLx6i8Z1QTTt3Gat
120damy3bgtl2GYssc3kEeWpckhAJEcrN15gkS3ELB8dpn5V3MDkgLTPt/hw9Efch2iZt5Kj
3gkSIl3huVREHBHCewchIByLxzUMRRNSW4nOAWO9eH+qetVrjk3mqnXpLQ2QEgeGLZ06kHqy
StVr15/skJ0rq6Q2o3o6yg8wuhS4UM4yTGfGWkOClkBrGd90lSyYUtU8cJVhcC006ONQ+IY6
DeMkN2WEx37jTAx3wCSnIFEdph09JQ4K5s/SbCMmaDWlVEwII7YPci8zkIeDF3+4i8JvjTWd
JxOSe8s83XtI+Moth5MKGputfO99uOjKatPtTpoZvP5Gq5zbkUX0E6vd2UTRA/ej37W/gnMi
R2j5QoxqYQmn54EPo19U53iMDEVXNG6uQDbaBN41OxZJFFkcTLrLo86bKLuR7GZpvU3QlqBN
pJW/O0bApHb4K4V1VqISiyfTZzo6tYKZJbPJCI5KoKMR+lb5OcdlOWLBfh/hwTmyL31zxfja
Tm+aFs6bhmLBgPDBam/KLp37nvOI0A1sLxMKp2Nh93yksvKTU+JjPuBhW/5M3MXpOmb1H18X
5eQgwJlVu5/h/In4v75pHeblbC5PmBgBXQScpHaYxUw6PIw5EU3gUNzBuIHf/HDZ45vIUz0R
IhGJyUHjWHDqTyuLNGmJe7YRVmnWlV2oaZRRjhsMuHKZNTTKmjqWIzLG3Ey3+GgIG+a//+/w
9HgbtKnV8ZTCsjNNI1U+ruvBFAoEVZDZz8/kc6bAS9bZMuLE5GP2Y406mXQ3hJPkugZ23B5W
6IjXCG85ARmavGje5sKhoGcIdUksQnTpBwXti+B+ZZ1Jksd1kllepcgNfmzU5DeDV8VE4dRd
0gcrjlojQRolwOKArLemu1j9OKz4j/BCeAsl3S3d4fkF5W1UYuPv/z08fbk7iKzQvpT+Q7Yy
2Dp/yp4RrOmngGbPm9Q9hQwlIWNB1xiF34G2kiVejrG2LsJoge6qDZGd5a6FZGY6rm0Vxpr3
GxkJp4EdO4CXcSWzatjiBAsJzZYU1fq2VgCERGjgCSRxwJzhcdDB1PllIsvMEXGjMKFWyTHU
XmQl2nNrpzmAmWTX5ypyZD1qWXSAFqX9NfrQXWFeOuI1SLneHdjo0Q2awWmQqdm750UjWHcl
J76GCfGI18Z1qKoRx6gBvKv2zhRNcVOykYmM09j3WeI07Z2IAmoMWUkJ0KCpoEMauzREHa9J
TcCIvI7Yvxumo1mZ4PCPc3q6dTFrCtCwpVCcdXBm8sSlIY2xdQaVyXJigVivJwjiMLcgQMSg
eeQlLhJEeKvqKBpTljYwrxcwbm9xXDu7nlhgljFIy0f2IrvSj+1BCqMLBl6Nr8jU7PJi4MGh
LHI5JsBdrBRwjBkoA0qRtS0en6SK+0KLt2xgWWdMJZXZ0nHt/x+8Mxvh0YUCAA==

--wac7ysb48OaltWcw--
