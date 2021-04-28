Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA5B36D46B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhD1JEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:04:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:10915 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230191AbhD1JEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:04:37 -0400
IronPort-SDR: QK/lExu+DIPxS1P3Q+Zkp8neCSUb9WGa35xVQ4qzXXDBtSF3H7ny53rUpcl1y6H8sFcRPdPKnX
 l6Z55XB9ZYBg==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="257995456"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="gz'50?scan'50,208,50";a="257995456"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 02:03:52 -0700
IronPort-SDR: 3Rs7+ARy7GTZZjqHa6PK5SMExIJl2I7aKgBA2XCN7GQ245bg8zEv+5xmXIMDB1QnpBZ5iKVJXI
 T5fl+OALrihQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="gz'50?scan'50,208,50";a="403611684"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Apr 2021 02:03:49 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lbg6m-00072t-Jp; Wed, 28 Apr 2021 09:03:48 +0000
Date:   Wed, 28 Apr 2021 17:03:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/ppc4xx/adma.c:4094:14: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202104281747.UFKwMlTD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   acd3d28594536e9096c1ea76c5867d8a68babef6
commit: 68f35add4ba4c850a33878633e10c02d7ba32d84 dmaengine: ppc4xx: make ppc440spe_adma_chan_list static
date:   6 months ago
config: powerpc64-randconfig-s031-20210428 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68f35add4ba4c850a33878633e10c02d7ba32d84
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 68f35add4ba4c850a33878633e10c02d7ba32d84
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/dma/ppc4xx/adma.c:1159:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1159:38: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1159:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:911:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:911:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:911:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:912:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:912:40: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:912:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:974:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:974:32: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:974:32: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:979:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:979:40: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:979:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:984:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:984:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:984:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:985:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:985:34: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:985:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:986:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:986:34: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:986:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:993:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:993:55: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:993:55: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:995:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:997:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:997:51: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:997:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:999:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:999:46: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:999:46: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1008:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1008:35: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1008:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1027:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1027:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1027:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:1031:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1031:31: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1031:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1031:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1031:60: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1031:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1032:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1032:31: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1032:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1032:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1032:60: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1032:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1038:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1038:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1038:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1039:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1039:37: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1039:37: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1053:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1053:48: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1053:48: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1055:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1055:25: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1055:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1062:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1062:41: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1062:41: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1064:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1064:39: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1064:39: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1065:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1065:25: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1065:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1066:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1066:33: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1066:33: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1067:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1067:22: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1067:22: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1080:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1080:48: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1080:48: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:1090:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1090:26: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1090:26: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1210:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1210:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1210:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1214:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1214:30: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1214:30: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:2777:62: sparse: sparse: Using plain integer as NULL pointer
>> drivers/dma/ppc4xx/adma.c:4094:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *regs @@     got void [noderef] __iomem * @@
   drivers/dma/ppc4xx/adma.c:4094:14: sparse:     expected void *regs
   drivers/dma/ppc4xx/adma.c:4094:14: sparse:     got void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:4102:31: sparse: sparse: too many warnings

vim +4094 drivers/dma/ppc4xx/adma.c

12458ea06efd7b Anatolij Gustschin       2009-12-11  4003  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4004  /**
12458ea06efd7b Anatolij Gustschin       2009-12-11  4005   * ppc440spe_adma_probe - probe the asynch device
12458ea06efd7b Anatolij Gustschin       2009-12-11  4006   */
463a1f8b3ceebe Bill Pemberton           2012-11-19  4007  static int ppc440spe_adma_probe(struct platform_device *ofdev)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4008  {
05c02542c20aa0 Anatolij Gustschin       2010-06-03  4009  	struct device_node *np = ofdev->dev.of_node;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4010  	struct resource res;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4011  	struct ppc440spe_adma_device *adev;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4012  	struct ppc440spe_adma_chan *chan;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4013  	struct ppc_dma_chan_ref *ref, *_ref;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4014  	int ret = 0, initcode = PPC_ADMA_INIT_OK;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4015  	const u32 *idx;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4016  	int len;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4017  	void *regs;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4018  	u32 id, pool_size;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4019  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4020  	if (of_device_is_compatible(np, "amcc,xor-accelerator")) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4021  		id = PPC440SPE_XOR_ID;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4022  		/* As far as the XOR engine is concerned, it does not
12458ea06efd7b Anatolij Gustschin       2009-12-11  4023  		 * use FIFOs but uses linked list. So there is no dependency
12458ea06efd7b Anatolij Gustschin       2009-12-11  4024  		 * between pool size to allocate and the engine configuration.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4025  		 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4026  		pool_size = PAGE_SIZE << 1;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4027  	} else {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4028  		/* it is DMA0 or DMA1 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4029  		idx = of_get_property(np, "cell-index", &len);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4030  		if (!idx || (len != sizeof(u32))) {
c6c93048baff25 Rob Herring              2017-07-18  4031  			dev_err(&ofdev->dev, "Device node %pOF has missing "
12458ea06efd7b Anatolij Gustschin       2009-12-11  4032  				"or invalid cell-index property\n",
c6c93048baff25 Rob Herring              2017-07-18  4033  				np);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4034  			return -EINVAL;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4035  		}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4036  		id = *idx;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4037  		/* DMA0,1 engines use FIFO to maintain CDBs, so we
12458ea06efd7b Anatolij Gustschin       2009-12-11  4038  		 * should allocate the pool accordingly to size of this
12458ea06efd7b Anatolij Gustschin       2009-12-11  4039  		 * FIFO. Thus, the pool size depends on the FIFO depth:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4040  		 * how much CDBs pointers the FIFO may contain then so
12458ea06efd7b Anatolij Gustschin       2009-12-11  4041  		 * much CDBs we should provide in the pool.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4042  		 * That is
12458ea06efd7b Anatolij Gustschin       2009-12-11  4043  		 *   CDB size = 32B;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4044  		 *   CDBs number = (DMA0_FIFO_SIZE >> 3);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4045  		 *   Pool size = CDBs number * CDB size =
12458ea06efd7b Anatolij Gustschin       2009-12-11  4046  		 *      = (DMA0_FIFO_SIZE >> 3) << 5 = DMA0_FIFO_SIZE << 2.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4047  		 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4048  		pool_size = (id == PPC440SPE_DMA0_ID) ?
12458ea06efd7b Anatolij Gustschin       2009-12-11  4049  			    DMA0_FIFO_SIZE : DMA1_FIFO_SIZE;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4050  		pool_size <<= 2;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4051  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4052  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4053  	if (of_address_to_resource(np, 0, &res)) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4054  		dev_err(&ofdev->dev, "failed to get memory resource\n");
12458ea06efd7b Anatolij Gustschin       2009-12-11  4055  		initcode = PPC_ADMA_INIT_MEMRES;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4056  		ret = -ENODEV;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4057  		goto out;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4058  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4059  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4060  	if (!request_mem_region(res.start, resource_size(&res),
12458ea06efd7b Anatolij Gustschin       2009-12-11  4061  				dev_driver_string(&ofdev->dev))) {
a584bff5efae8c Joe Perches              2010-11-12  4062  		dev_err(&ofdev->dev, "failed to request memory region %pR\n",
a584bff5efae8c Joe Perches              2010-11-12  4063  			&res);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4064  		initcode = PPC_ADMA_INIT_MEMREG;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4065  		ret = -EBUSY;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4066  		goto out;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4067  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4068  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4069  	/* create a device */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4070  	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4071  	if (!adev) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4072  		initcode = PPC_ADMA_INIT_ALLOC;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4073  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4074  		goto err_adev_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4075  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4076  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4077  	adev->id = id;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4078  	adev->pool_size = pool_size;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4079  	/* allocate coherent memory for hardware descriptors */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4080  	adev->dma_desc_pool_virt = dma_alloc_coherent(&ofdev->dev,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4081  					adev->pool_size, &adev->dma_desc_pool,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4082  					GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4083  	if (adev->dma_desc_pool_virt == NULL) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4084  		dev_err(&ofdev->dev, "failed to allocate %d bytes of coherent "
12458ea06efd7b Anatolij Gustschin       2009-12-11  4085  			"memory for hardware descriptors\n",
12458ea06efd7b Anatolij Gustschin       2009-12-11  4086  			adev->pool_size);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4087  		initcode = PPC_ADMA_INIT_COHERENT;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4088  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4089  		goto err_dma_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4090  	}
d73111c6d43f08 Masanari Iida            2012-08-04  4091  	dev_dbg(&ofdev->dev, "allocated descriptor pool virt 0x%p phys 0x%llx\n",
12458ea06efd7b Anatolij Gustschin       2009-12-11  4092  		adev->dma_desc_pool_virt, (u64)adev->dma_desc_pool);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4093  
12458ea06efd7b Anatolij Gustschin       2009-12-11 @4094  	regs = ioremap(res.start, resource_size(&res));
12458ea06efd7b Anatolij Gustschin       2009-12-11  4095  	if (!regs) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4096  		dev_err(&ofdev->dev, "failed to ioremap regs!\n");
f3b77727e82722 Julia Lawall             2013-12-29  4097  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4098  		goto err_regs_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4099  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4100  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4101  	if (adev->id == PPC440SPE_XOR_ID) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4102  		adev->xor_reg = regs;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4103  		/* Reset XOR */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4104  		iowrite32be(XOR_CRSR_XASR_BIT, &adev->xor_reg->crsr);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4105  		iowrite32be(XOR_CRSR_64BA_BIT, &adev->xor_reg->crrr);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4106  	} else {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4107  		size_t fifo_size = (adev->id == PPC440SPE_DMA0_ID) ?
12458ea06efd7b Anatolij Gustschin       2009-12-11  4108  				   DMA0_FIFO_SIZE : DMA1_FIFO_SIZE;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4109  		adev->dma_reg = regs;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4110  		/* DMAx_FIFO_SIZE is defined in bytes,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4111  		 * <fsiz> - is defined in number of CDB pointers (8byte).
12458ea06efd7b Anatolij Gustschin       2009-12-11  4112  		 * DMA FIFO Length = CSlength + CPlength, where
12458ea06efd7b Anatolij Gustschin       2009-12-11  4113  		 * CSlength = CPlength = (fsiz + 1) * 8.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4114  		 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4115  		iowrite32(DMA_FIFO_ENABLE | ((fifo_size >> 3) - 2),
12458ea06efd7b Anatolij Gustschin       2009-12-11  4116  			  &adev->dma_reg->fsiz);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4117  		/* Configure DMA engine */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4118  		iowrite32(DMA_CFG_DXEPR_HP | DMA_CFG_DFMPP_HP | DMA_CFG_FALGN,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4119  			  &adev->dma_reg->cfg);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4120  		/* Clear Status */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4121  		iowrite32(~0, &adev->dma_reg->dsts);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4122  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4123  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4124  	adev->dev = &ofdev->dev;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4125  	adev->common.dev = &ofdev->dev;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4126  	INIT_LIST_HEAD(&adev->common.channels);
dd3daca162f741 Jingoo Han               2013-05-24  4127  	platform_set_drvdata(ofdev, adev);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4128  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4129  	/* create a channel */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4130  	chan = kzalloc(sizeof(*chan), GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4131  	if (!chan) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4132  		initcode = PPC_ADMA_INIT_CHANNEL;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4133  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4134  		goto err_chan_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4135  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4136  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4137  	spin_lock_init(&chan->lock);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4138  	INIT_LIST_HEAD(&chan->chain);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4139  	INIT_LIST_HEAD(&chan->all_slots);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4140  	chan->device = adev;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4141  	chan->common.device = &adev->common;
8ac695463f37af Russell King - ARM Linux 2012-03-06  4142  	dma_cookie_init(&chan->common);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4143  	list_add_tail(&chan->common.device_node, &adev->common.channels);
7f8281765f9949 Allen Pais               2020-08-31  4144  	tasklet_setup(&chan->irq_tasklet, ppc440spe_adma_tasklet);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4145  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4146  	/* allocate and map helper pages for async validation or
12458ea06efd7b Anatolij Gustschin       2009-12-11  4147  	 * async_mult/async_sum_product operations on DMA0/1.
12458ea06efd7b Anatolij Gustschin       2009-12-11  4148  	 */
12458ea06efd7b Anatolij Gustschin       2009-12-11  4149  	if (adev->id != PPC440SPE_XOR_ID) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4150  		chan->pdest_page = alloc_page(GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4151  		chan->qdest_page = alloc_page(GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4152  		if (!chan->pdest_page ||
12458ea06efd7b Anatolij Gustschin       2009-12-11  4153  		    !chan->qdest_page) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4154  			if (chan->pdest_page)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4155  				__free_page(chan->pdest_page);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4156  			if (chan->qdest_page)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4157  				__free_page(chan->qdest_page);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4158  			ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4159  			goto err_page_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4160  		}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4161  		chan->pdest = dma_map_page(&ofdev->dev, chan->pdest_page, 0,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4162  					   PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4163  		chan->qdest = dma_map_page(&ofdev->dev, chan->qdest_page, 0,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4164  					   PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4165  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4166  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4167  	ref = kmalloc(sizeof(*ref), GFP_KERNEL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4168  	if (ref) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4169  		ref->chan = &chan->common;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4170  		INIT_LIST_HEAD(&ref->node);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4171  		list_add_tail(&ref->node, &ppc440spe_adma_chan_list);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4172  	} else {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4173  		dev_err(&ofdev->dev, "failed to allocate channel reference!\n");
12458ea06efd7b Anatolij Gustschin       2009-12-11  4174  		ret = -ENOMEM;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4175  		goto err_ref_alloc;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4176  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4177  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4178  	ret = ppc440spe_adma_setup_irqs(adev, chan, &initcode);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4179  	if (ret)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4180  		goto err_irq;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4181  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4182  	ppc440spe_adma_init_capabilities(adev);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4183  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4184  	ret = dma_async_device_register(&adev->common);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4185  	if (ret) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4186  		initcode = PPC_ADMA_INIT_REGISTER;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4187  		dev_err(&ofdev->dev, "failed to register dma device\n");
12458ea06efd7b Anatolij Gustschin       2009-12-11  4188  		goto err_dev_reg;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4189  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4190  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4191  	goto out;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4192  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4193  err_dev_reg:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4194  	ppc440spe_adma_release_irqs(adev, chan);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4195  err_irq:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4196  	list_for_each_entry_safe(ref, _ref, &ppc440spe_adma_chan_list, node) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4197  		if (chan == to_ppc440spe_adma_chan(ref->chan)) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4198  			list_del(&ref->node);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4199  			kfree(ref);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4200  		}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4201  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4202  err_ref_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4203  	if (adev->id != PPC440SPE_XOR_ID) {
12458ea06efd7b Anatolij Gustschin       2009-12-11  4204  		dma_unmap_page(&ofdev->dev, chan->pdest,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4205  			       PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4206  		dma_unmap_page(&ofdev->dev, chan->qdest,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4207  			       PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4208  		__free_page(chan->pdest_page);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4209  		__free_page(chan->qdest_page);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4210  	}
12458ea06efd7b Anatolij Gustschin       2009-12-11  4211  err_page_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4212  	kfree(chan);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4213  err_chan_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4214  	if (adev->id == PPC440SPE_XOR_ID)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4215  		iounmap(adev->xor_reg);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4216  	else
12458ea06efd7b Anatolij Gustschin       2009-12-11  4217  		iounmap(adev->dma_reg);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4218  err_regs_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4219  	dma_free_coherent(adev->dev, adev->pool_size,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4220  			  adev->dma_desc_pool_virt,
12458ea06efd7b Anatolij Gustschin       2009-12-11  4221  			  adev->dma_desc_pool);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4222  err_dma_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4223  	kfree(adev);
12458ea06efd7b Anatolij Gustschin       2009-12-11  4224  err_adev_alloc:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4225  	release_mem_region(res.start, resource_size(&res));
12458ea06efd7b Anatolij Gustschin       2009-12-11  4226  out:
12458ea06efd7b Anatolij Gustschin       2009-12-11  4227  	if (id < PPC440SPE_ADMA_ENGINES_NUM)
12458ea06efd7b Anatolij Gustschin       2009-12-11  4228  		ppc440spe_adma_devices[id] = initcode;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4229  
12458ea06efd7b Anatolij Gustschin       2009-12-11  4230  	return ret;
12458ea06efd7b Anatolij Gustschin       2009-12-11  4231  }
12458ea06efd7b Anatolij Gustschin       2009-12-11  4232  

:::::: The code at line 4094 was first introduced by commit
:::::: 12458ea06efd7b44281e68fe59c950ec7d59c649 ppc440spe-adma: adds updated ppc440spe adma driver

:::::: TO: Anatolij Gustschin <agust@denx.de>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
RG5e4vEBAA==

--VbJkn9YxBvnuCH5J--
