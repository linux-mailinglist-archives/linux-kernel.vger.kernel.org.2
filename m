Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9BE386FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 04:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345862AbhERCgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 22:36:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:47654 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230228AbhERCgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 22:36:46 -0400
IronPort-SDR: PRjRzvz3VM0RY04FasuvjL2KR1hNG4qwx2ORW3anGQa2XSSKXoga8QX6jTyxig99MkgndRmFVJ
 cGC3E2Un4TNA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="261842152"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="gz'50?scan'50,208,50";a="261842152"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 19:35:28 -0700
IronPort-SDR: F/Gh5/4a8LSx/9e1GBOJl/34zwEagfNWkqFbCL06ub9iWYrJxv3yoDZX2+ep4e9xRqokPrdqVv
 WxK+XGJxJ8oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="gz'50?scan'50,208,50";a="411082961"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 17 May 2021 19:35:26 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lipZt-00020j-De; Tue, 18 May 2021 02:35:25 +0000
Date:   Tue, 18 May 2021 10:35:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/ppc4xx/adma.c:4094:14: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202105181055.I05DWy2h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ac91e6c6033ebc12c5c1e4aa171b81a662bd70f
commit: 68f35add4ba4c850a33878633e10c02d7ba32d84 dmaengine: ppc4xx: make ppc440spe_adma_chan_list static
date:   7 months ago
config: powerpc64-randconfig-s032-20210518 (attached as .config)
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

--X1bOJ3K7DJ5YkBrT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
RPVgJ3ICAA==

--X1bOJ3K7DJ5YkBrT--
