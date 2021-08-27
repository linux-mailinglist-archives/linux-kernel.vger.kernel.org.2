Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8483F93E0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 07:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbhH0E7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 00:59:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:9260 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhH0E67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 00:58:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="205031547"
X-IronPort-AV: E=Sophos;i="5.84,355,1620716400"; 
   d="gz'50?scan'50,208,50";a="205031547"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 21:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,355,1620716400"; 
   d="gz'50?scan'50,208,50";a="517162715"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2021 21:58:08 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mJTwO-0001zL-04; Fri, 27 Aug 2021 04:58:08 +0000
Date:   Fri, 27 Aug 2021 12:57:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: drivers/net/wan/fsl_ucc_hdlc.c:305:17: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202108271217.Vc8pZwIm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77dd11439b86e3f7990e4c0c9e0b67dca82750ba
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   12 months ago
config: arm-randconfig-s032-20210827 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-348-gf0e6938b-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/wan/fsl_ucc_hdlc.c:305:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:305:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/wan/fsl_ucc_hdlc.c:305:17: sparse:     got restricted __be16 *
   drivers/net/wan/fsl_ucc_hdlc.c:306:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:306:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/fsl_ucc_hdlc.c:306:17: sparse:     got restricted __be32 *
   drivers/net/wan/fsl_ucc_hdlc.c:316:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:316:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/wan/fsl_ucc_hdlc.c:316:17: sparse:     got restricted __be16 *
   drivers/net/wan/fsl_ucc_hdlc.c:317:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:317:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/fsl_ucc_hdlc.c:317:17: sparse:     got restricted __be32 *
   drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __be16 [usertype] @@
   drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse:     expected unsigned short [usertype]
   drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse:     got restricted __be16 [usertype]
   drivers/net/wan/fsl_ucc_hdlc.c:375:36: sparse: sparse: restricted __be16 degrades to integer
   drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd [noderef] __iomem *bd @@     got struct qe_bd *curtx_bd @@
   drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse:     expected struct qe_bd [noderef] __iomem *bd
   drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse:     got struct qe_bd *curtx_bd
   drivers/net/wan/fsl_ucc_hdlc.c:408:35: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd [noderef] __iomem *[assigned] bd @@     got struct qe_bd *tx_bd_base @@
   drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse:     expected struct qe_bd [noderef] __iomem *[assigned] bd
   drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse:     got struct qe_bd *tx_bd_base
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse:    struct qe_bd [noderef] __iomem *
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse:    struct qe_bd *
   drivers/net/wan/fsl_ucc_hdlc.c:458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:502:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:502:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:502:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:502:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:524:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:524:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:524:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:524:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:592:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:607:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:607:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:607:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:607:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:408:35: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:408:35: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:723:29: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:814:21: sparse: sparse: dereference of noderef expression

vim +305 drivers/net/wan/fsl_ucc_hdlc.c

c19b6d246a3562 Zhao Qiang       2016-06-06   77  
c19b6d246a3562 Zhao Qiang       2016-06-06   78  static int uhdlc_init(struct ucc_hdlc_private *priv)
c19b6d246a3562 Zhao Qiang       2016-06-06   79  {
c19b6d246a3562 Zhao Qiang       2016-06-06   80  	struct ucc_tdm_info *ut_info;
c19b6d246a3562 Zhao Qiang       2016-06-06   81  	struct ucc_fast_info *uf_info;
c19b6d246a3562 Zhao Qiang       2016-06-06   82  	u32 cecr_subblock;
c19b6d246a3562 Zhao Qiang       2016-06-06   83  	u16 bd_status;
c19b6d246a3562 Zhao Qiang       2016-06-06   84  	int ret, i;
c19b6d246a3562 Zhao Qiang       2016-06-06   85  	void *bd_buffer;
c19b6d246a3562 Zhao Qiang       2016-06-06   86  	dma_addr_t bd_dma_addr;
be2e9415f8b366 Rasmus Villemoes 2019-11-28   87  	s32 riptr;
be2e9415f8b366 Rasmus Villemoes 2019-11-28   88  	s32 tiptr;
c19b6d246a3562 Zhao Qiang       2016-06-06   89  	u32 gumr;
c19b6d246a3562 Zhao Qiang       2016-06-06   90  
c19b6d246a3562 Zhao Qiang       2016-06-06   91  	ut_info = priv->ut_info;
c19b6d246a3562 Zhao Qiang       2016-06-06   92  	uf_info = &ut_info->uf_info;
c19b6d246a3562 Zhao Qiang       2016-06-06   93  
c19b6d246a3562 Zhao Qiang       2016-06-06   94  	if (priv->tsa) {
c19b6d246a3562 Zhao Qiang       2016-06-06   95  		uf_info->tsa = 1;
c19b6d246a3562 Zhao Qiang       2016-06-06   96  		uf_info->ctsp = 1;
040b7c94e4ec58 David Gounaris   2018-09-03   97  		uf_info->cds = 1;
040b7c94e4ec58 David Gounaris   2018-09-03   98  		uf_info->ctss = 1;
040b7c94e4ec58 David Gounaris   2018-09-03   99  	} else {
040b7c94e4ec58 David Gounaris   2018-09-03  100  		uf_info->cds = 0;
040b7c94e4ec58 David Gounaris   2018-09-03  101  		uf_info->ctsp = 0;
040b7c94e4ec58 David Gounaris   2018-09-03  102  		uf_info->ctss = 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  103  	}
067bb938dad61e Holger Brunck    2017-05-17  104  
067bb938dad61e Holger Brunck    2017-05-17  105  	/* This sets HPM register in CMXUCR register which configures a
067bb938dad61e Holger Brunck    2017-05-17  106  	 * open drain connected HDLC bus
067bb938dad61e Holger Brunck    2017-05-17  107  	 */
067bb938dad61e Holger Brunck    2017-05-17  108  	if (priv->hdlc_bus)
067bb938dad61e Holger Brunck    2017-05-17  109  		uf_info->brkpt_support = 1;
067bb938dad61e Holger Brunck    2017-05-17  110  
c19b6d246a3562 Zhao Qiang       2016-06-06  111  	uf_info->uccm_mask = ((UCC_HDLC_UCCE_RXB | UCC_HDLC_UCCE_RXF |
c19b6d246a3562 Zhao Qiang       2016-06-06  112  				UCC_HDLC_UCCE_TXB) << 16);
c19b6d246a3562 Zhao Qiang       2016-06-06  113  
c19b6d246a3562 Zhao Qiang       2016-06-06  114  	ret = ucc_fast_init(uf_info, &priv->uccf);
c19b6d246a3562 Zhao Qiang       2016-06-06  115  	if (ret) {
c19b6d246a3562 Zhao Qiang       2016-06-06  116  		dev_err(priv->dev, "Failed to init uccf.");
c19b6d246a3562 Zhao Qiang       2016-06-06  117  		return ret;
c19b6d246a3562 Zhao Qiang       2016-06-06  118  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  119  
c19b6d246a3562 Zhao Qiang       2016-06-06  120  	priv->uf_regs = priv->uccf->uf_regs;
c19b6d246a3562 Zhao Qiang       2016-06-06  121  	ucc_fast_disable(priv->uccf, COMM_DIR_RX | COMM_DIR_TX);
c19b6d246a3562 Zhao Qiang       2016-06-06  122  
c19b6d246a3562 Zhao Qiang       2016-06-06  123  	/* Loopback mode */
c19b6d246a3562 Zhao Qiang       2016-06-06  124  	if (priv->loopback) {
c19b6d246a3562 Zhao Qiang       2016-06-06  125  		dev_info(priv->dev, "Loopback Mode\n");
54e9e0874938ba Holger Brunck    2017-05-17  126  		/* use the same clock when work in loopback */
54e9e0874938ba Holger Brunck    2017-05-17  127  		qe_setbrg(ut_info->uf_info.rx_clock, 20000000, 1);
54e9e0874938ba Holger Brunck    2017-05-17  128  
c19b6d246a3562 Zhao Qiang       2016-06-06  129  		gumr = ioread32be(&priv->uf_regs->gumr);
c19b6d246a3562 Zhao Qiang       2016-06-06  130  		gumr |= (UCC_FAST_GUMR_LOOPBACK | UCC_FAST_GUMR_CDS |
c19b6d246a3562 Zhao Qiang       2016-06-06  131  			 UCC_FAST_GUMR_TCI);
c19b6d246a3562 Zhao Qiang       2016-06-06  132  		gumr &= ~(UCC_FAST_GUMR_CTSP | UCC_FAST_GUMR_RSYN);
c19b6d246a3562 Zhao Qiang       2016-06-06  133  		iowrite32be(gumr, &priv->uf_regs->gumr);
c19b6d246a3562 Zhao Qiang       2016-06-06  134  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  135  
c19b6d246a3562 Zhao Qiang       2016-06-06  136  	/* Initialize SI */
c19b6d246a3562 Zhao Qiang       2016-06-06  137  	if (priv->tsa)
c19b6d246a3562 Zhao Qiang       2016-06-06  138  		ucc_tdm_init(priv->utdm, priv->ut_info);
c19b6d246a3562 Zhao Qiang       2016-06-06  139  
c19b6d246a3562 Zhao Qiang       2016-06-06  140  	/* Write to QE CECR, UCCx channel to Stop Transmission */
c19b6d246a3562 Zhao Qiang       2016-06-06  141  	cecr_subblock = ucc_fast_get_qe_cr_subblock(uf_info->ucc_num);
c19b6d246a3562 Zhao Qiang       2016-06-06  142  	ret = qe_issue_cmd(QE_STOP_TX, cecr_subblock,
c19b6d246a3562 Zhao Qiang       2016-06-06  143  			   QE_CR_PROTOCOL_UNSPECIFIED, 0);
c19b6d246a3562 Zhao Qiang       2016-06-06  144  
c19b6d246a3562 Zhao Qiang       2016-06-06  145  	/* Set UPSMR normal mode (need fixed)*/
c19b6d246a3562 Zhao Qiang       2016-06-06  146  	iowrite32be(0, &priv->uf_regs->upsmr);
c19b6d246a3562 Zhao Qiang       2016-06-06  147  
067bb938dad61e Holger Brunck    2017-05-17  148  	/* hdlc_bus mode */
067bb938dad61e Holger Brunck    2017-05-17  149  	if (priv->hdlc_bus) {
067bb938dad61e Holger Brunck    2017-05-17  150  		u32 upsmr;
067bb938dad61e Holger Brunck    2017-05-17  151  
067bb938dad61e Holger Brunck    2017-05-17  152  		dev_info(priv->dev, "HDLC bus Mode\n");
067bb938dad61e Holger Brunck    2017-05-17  153  		upsmr = ioread32be(&priv->uf_regs->upsmr);
067bb938dad61e Holger Brunck    2017-05-17  154  
067bb938dad61e Holger Brunck    2017-05-17  155  		/* bus mode and retransmit enable, with collision window
067bb938dad61e Holger Brunck    2017-05-17  156  		 * set to 8 bytes
067bb938dad61e Holger Brunck    2017-05-17  157  		 */
067bb938dad61e Holger Brunck    2017-05-17  158  		upsmr |= UCC_HDLC_UPSMR_RTE | UCC_HDLC_UPSMR_BUS |
067bb938dad61e Holger Brunck    2017-05-17  159  				UCC_HDLC_UPSMR_CW8;
067bb938dad61e Holger Brunck    2017-05-17  160  		iowrite32be(upsmr, &priv->uf_regs->upsmr);
067bb938dad61e Holger Brunck    2017-05-17  161  
067bb938dad61e Holger Brunck    2017-05-17  162  		/* explicitly disable CDS & CTSP */
067bb938dad61e Holger Brunck    2017-05-17  163  		gumr = ioread32be(&priv->uf_regs->gumr);
067bb938dad61e Holger Brunck    2017-05-17  164  		gumr &= ~(UCC_FAST_GUMR_CDS | UCC_FAST_GUMR_CTSP);
067bb938dad61e Holger Brunck    2017-05-17  165  		/* set automatic sync to explicitly ignore CD signal */
067bb938dad61e Holger Brunck    2017-05-17  166  		gumr |= UCC_FAST_GUMR_SYNL_AUTO;
067bb938dad61e Holger Brunck    2017-05-17  167  		iowrite32be(gumr, &priv->uf_regs->gumr);
067bb938dad61e Holger Brunck    2017-05-17  168  	}
067bb938dad61e Holger Brunck    2017-05-17  169  
c19b6d246a3562 Zhao Qiang       2016-06-06  170  	priv->rx_ring_size = RX_BD_RING_LEN;
c19b6d246a3562 Zhao Qiang       2016-06-06  171  	priv->tx_ring_size = TX_BD_RING_LEN;
c19b6d246a3562 Zhao Qiang       2016-06-06  172  	/* Alloc Rx BD */
c19b6d246a3562 Zhao Qiang       2016-06-06  173  	priv->rx_bd_base = dma_alloc_coherent(priv->dev,
5b8aad93c52bdd Holger Brunck    2017-05-17  174  			RX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a3562 Zhao Qiang       2016-06-06  175  			&priv->dma_rx_bd, GFP_KERNEL);
c19b6d246a3562 Zhao Qiang       2016-06-06  176  
c19b6d246a3562 Zhao Qiang       2016-06-06  177  	if (!priv->rx_bd_base) {
c19b6d246a3562 Zhao Qiang       2016-06-06  178  		dev_err(priv->dev, "Cannot allocate MURAM memory for RxBDs\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  179  		ret = -ENOMEM;
1efb597d8bf56c Zhao Qiang       2016-07-15  180  		goto free_uccf;
c19b6d246a3562 Zhao Qiang       2016-06-06  181  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  182  
c19b6d246a3562 Zhao Qiang       2016-06-06  183  	/* Alloc Tx BD */
c19b6d246a3562 Zhao Qiang       2016-06-06  184  	priv->tx_bd_base = dma_alloc_coherent(priv->dev,
5b8aad93c52bdd Holger Brunck    2017-05-17  185  			TX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a3562 Zhao Qiang       2016-06-06  186  			&priv->dma_tx_bd, GFP_KERNEL);
c19b6d246a3562 Zhao Qiang       2016-06-06  187  
c19b6d246a3562 Zhao Qiang       2016-06-06  188  	if (!priv->tx_bd_base) {
c19b6d246a3562 Zhao Qiang       2016-06-06  189  		dev_err(priv->dev, "Cannot allocate MURAM memory for TxBDs\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  190  		ret = -ENOMEM;
1efb597d8bf56c Zhao Qiang       2016-07-15  191  		goto free_rx_bd;
c19b6d246a3562 Zhao Qiang       2016-06-06  192  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  193  
c19b6d246a3562 Zhao Qiang       2016-06-06  194  	/* Alloc parameter ram for ucc hdlc */
85deed56032b6c Holger Brunck    2017-05-22  195  	priv->ucc_pram_offset = qe_muram_alloc(sizeof(struct ucc_hdlc_param),
c19b6d246a3562 Zhao Qiang       2016-06-06  196  				ALIGNMENT_OF_UCC_HDLC_PRAM);
c19b6d246a3562 Zhao Qiang       2016-06-06  197  
be2e9415f8b366 Rasmus Villemoes 2019-11-28  198  	if (priv->ucc_pram_offset < 0) {
24a24d07d688a4 Colin Ian King   2016-08-28  199  		dev_err(priv->dev, "Can not allocate MURAM for hdlc parameter.\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  200  		ret = -ENOMEM;
1efb597d8bf56c Zhao Qiang       2016-07-15  201  		goto free_tx_bd;
c19b6d246a3562 Zhao Qiang       2016-06-06  202  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  203  
6396bb221514d2 Kees Cook        2018-06-12  204  	priv->rx_skbuff = kcalloc(priv->rx_ring_size,
6396bb221514d2 Kees Cook        2018-06-12  205  				  sizeof(*priv->rx_skbuff),
c19b6d246a3562 Zhao Qiang       2016-06-06  206  				  GFP_KERNEL);
c19b6d246a3562 Zhao Qiang       2016-06-06  207  	if (!priv->rx_skbuff)
1efb597d8bf56c Zhao Qiang       2016-07-15  208  		goto free_ucc_pram;
c19b6d246a3562 Zhao Qiang       2016-06-06  209  
6396bb221514d2 Kees Cook        2018-06-12  210  	priv->tx_skbuff = kcalloc(priv->tx_ring_size,
6396bb221514d2 Kees Cook        2018-06-12  211  				  sizeof(*priv->tx_skbuff),
c19b6d246a3562 Zhao Qiang       2016-06-06  212  				  GFP_KERNEL);
c19b6d246a3562 Zhao Qiang       2016-06-06  213  	if (!priv->tx_skbuff)
1efb597d8bf56c Zhao Qiang       2016-07-15  214  		goto free_rx_skbuff;
c19b6d246a3562 Zhao Qiang       2016-06-06  215  
c19b6d246a3562 Zhao Qiang       2016-06-06  216  	priv->skb_curtx = 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  217  	priv->skb_dirtytx = 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  218  	priv->curtx_bd = priv->tx_bd_base;
c19b6d246a3562 Zhao Qiang       2016-06-06  219  	priv->dirty_tx = priv->tx_bd_base;
c19b6d246a3562 Zhao Qiang       2016-06-06  220  	priv->currx_bd = priv->rx_bd_base;
c19b6d246a3562 Zhao Qiang       2016-06-06  221  	priv->currx_bdnum = 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  222  
c19b6d246a3562 Zhao Qiang       2016-06-06  223  	/* init parameter base */
c19b6d246a3562 Zhao Qiang       2016-06-06  224  	cecr_subblock = ucc_fast_get_qe_cr_subblock(uf_info->ucc_num);
c19b6d246a3562 Zhao Qiang       2016-06-06  225  	ret = qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, cecr_subblock,
c19b6d246a3562 Zhao Qiang       2016-06-06  226  			   QE_CR_PROTOCOL_UNSPECIFIED, priv->ucc_pram_offset);
c19b6d246a3562 Zhao Qiang       2016-06-06  227  
c19b6d246a3562 Zhao Qiang       2016-06-06  228  	priv->ucc_pram = (struct ucc_hdlc_param __iomem *)
c19b6d246a3562 Zhao Qiang       2016-06-06  229  					qe_muram_addr(priv->ucc_pram_offset);
c19b6d246a3562 Zhao Qiang       2016-06-06  230  
c19b6d246a3562 Zhao Qiang       2016-06-06  231  	/* Zero out parameter ram */
c19b6d246a3562 Zhao Qiang       2016-06-06  232  	memset_io(priv->ucc_pram, 0, sizeof(struct ucc_hdlc_param));
c19b6d246a3562 Zhao Qiang       2016-06-06  233  
c19b6d246a3562 Zhao Qiang       2016-06-06  234  	/* Alloc riptr, tiptr */
c19b6d246a3562 Zhao Qiang       2016-06-06  235  	riptr = qe_muram_alloc(32, 32);
be2e9415f8b366 Rasmus Villemoes 2019-11-28  236  	if (riptr < 0) {
c19b6d246a3562 Zhao Qiang       2016-06-06  237  		dev_err(priv->dev, "Cannot allocate MURAM mem for Receive internal temp data pointer\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  238  		ret = -ENOMEM;
1efb597d8bf56c Zhao Qiang       2016-07-15  239  		goto free_tx_skbuff;
c19b6d246a3562 Zhao Qiang       2016-06-06  240  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  241  
c19b6d246a3562 Zhao Qiang       2016-06-06  242  	tiptr = qe_muram_alloc(32, 32);
be2e9415f8b366 Rasmus Villemoes 2019-11-28  243  	if (tiptr < 0) {
c19b6d246a3562 Zhao Qiang       2016-06-06  244  		dev_err(priv->dev, "Cannot allocate MURAM mem for Transmit internal temp data pointer\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  245  		ret = -ENOMEM;
1efb597d8bf56c Zhao Qiang       2016-07-15  246  		goto free_riptr;
c19b6d246a3562 Zhao Qiang       2016-06-06  247  	}
148587a59f6b85 Rasmus Villemoes 2019-11-28  248  	if (riptr != (u16)riptr || tiptr != (u16)tiptr) {
148587a59f6b85 Rasmus Villemoes 2019-11-28  249  		dev_err(priv->dev, "MURAM allocation out of addressable range\n");
148587a59f6b85 Rasmus Villemoes 2019-11-28  250  		ret = -ENOMEM;
148587a59f6b85 Rasmus Villemoes 2019-11-28  251  		goto free_tiptr;
148587a59f6b85 Rasmus Villemoes 2019-11-28  252  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  253  
c19b6d246a3562 Zhao Qiang       2016-06-06  254  	/* Set RIPTR, TIPTR */
c19b6d246a3562 Zhao Qiang       2016-06-06  255  	iowrite16be(riptr, &priv->ucc_pram->riptr);
c19b6d246a3562 Zhao Qiang       2016-06-06  256  	iowrite16be(tiptr, &priv->ucc_pram->tiptr);
c19b6d246a3562 Zhao Qiang       2016-06-06  257  
c19b6d246a3562 Zhao Qiang       2016-06-06  258  	/* Set MRBLR */
c19b6d246a3562 Zhao Qiang       2016-06-06  259  	iowrite16be(MAX_RX_BUF_LENGTH, &priv->ucc_pram->mrblr);
c19b6d246a3562 Zhao Qiang       2016-06-06  260  
c19b6d246a3562 Zhao Qiang       2016-06-06  261  	/* Set RBASE, TBASE */
c19b6d246a3562 Zhao Qiang       2016-06-06  262  	iowrite32be(priv->dma_rx_bd, &priv->ucc_pram->rbase);
c19b6d246a3562 Zhao Qiang       2016-06-06  263  	iowrite32be(priv->dma_tx_bd, &priv->ucc_pram->tbase);
c19b6d246a3562 Zhao Qiang       2016-06-06  264  
c19b6d246a3562 Zhao Qiang       2016-06-06  265  	/* Set RSTATE, TSTATE */
c19b6d246a3562 Zhao Qiang       2016-06-06  266  	iowrite32be(BMR_GBL | BMR_BIG_ENDIAN, &priv->ucc_pram->rstate);
c19b6d246a3562 Zhao Qiang       2016-06-06  267  	iowrite32be(BMR_GBL | BMR_BIG_ENDIAN, &priv->ucc_pram->tstate);
c19b6d246a3562 Zhao Qiang       2016-06-06  268  
c19b6d246a3562 Zhao Qiang       2016-06-06  269  	/* Set C_MASK, C_PRES for 16bit CRC */
c19b6d246a3562 Zhao Qiang       2016-06-06  270  	iowrite32be(CRC_16BIT_MASK, &priv->ucc_pram->c_mask);
c19b6d246a3562 Zhao Qiang       2016-06-06  271  	iowrite32be(CRC_16BIT_PRES, &priv->ucc_pram->c_pres);
c19b6d246a3562 Zhao Qiang       2016-06-06  272  
c19b6d246a3562 Zhao Qiang       2016-06-06  273  	iowrite16be(MAX_FRAME_LENGTH, &priv->ucc_pram->mflr);
c19b6d246a3562 Zhao Qiang       2016-06-06  274  	iowrite16be(DEFAULT_RFTHR, &priv->ucc_pram->rfthr);
c19b6d246a3562 Zhao Qiang       2016-06-06  275  	iowrite16be(DEFAULT_RFTHR, &priv->ucc_pram->rfcnt);
045f77baf6b429 David Gounaris   2018-09-03  276  	iowrite16be(priv->hmask, &priv->ucc_pram->hmask);
c19b6d246a3562 Zhao Qiang       2016-06-06  277  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr1);
c19b6d246a3562 Zhao Qiang       2016-06-06  278  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr2);
c19b6d246a3562 Zhao Qiang       2016-06-06  279  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr3);
c19b6d246a3562 Zhao Qiang       2016-06-06  280  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr4);
c19b6d246a3562 Zhao Qiang       2016-06-06  281  
c19b6d246a3562 Zhao Qiang       2016-06-06  282  	/* Get BD buffer */
750afb08ca7131 Luis Chamberlain 2019-01-04  283  	bd_buffer = dma_alloc_coherent(priv->dev,
750afb08ca7131 Luis Chamberlain 2019-01-04  284  				       (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
c19b6d246a3562 Zhao Qiang       2016-06-06  285  				       &bd_dma_addr, GFP_KERNEL);
c19b6d246a3562 Zhao Qiang       2016-06-06  286  
c19b6d246a3562 Zhao Qiang       2016-06-06  287  	if (!bd_buffer) {
c19b6d246a3562 Zhao Qiang       2016-06-06  288  		dev_err(priv->dev, "Could not allocate buffer descriptors\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  289  		ret = -ENOMEM;
1efb597d8bf56c Zhao Qiang       2016-07-15  290  		goto free_tiptr;
c19b6d246a3562 Zhao Qiang       2016-06-06  291  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  292  
c19b6d246a3562 Zhao Qiang       2016-06-06  293  	priv->rx_buffer = bd_buffer;
c19b6d246a3562 Zhao Qiang       2016-06-06  294  	priv->tx_buffer = bd_buffer + RX_BD_RING_LEN * MAX_RX_BUF_LENGTH;
c19b6d246a3562 Zhao Qiang       2016-06-06  295  
c19b6d246a3562 Zhao Qiang       2016-06-06  296  	priv->dma_rx_addr = bd_dma_addr;
c19b6d246a3562 Zhao Qiang       2016-06-06  297  	priv->dma_tx_addr = bd_dma_addr + RX_BD_RING_LEN * MAX_RX_BUF_LENGTH;
c19b6d246a3562 Zhao Qiang       2016-06-06  298  
c19b6d246a3562 Zhao Qiang       2016-06-06  299  	for (i = 0; i < RX_BD_RING_LEN; i++) {
c19b6d246a3562 Zhao Qiang       2016-06-06  300  		if (i < (RX_BD_RING_LEN - 1))
c19b6d246a3562 Zhao Qiang       2016-06-06  301  			bd_status = R_E_S | R_I_S;
c19b6d246a3562 Zhao Qiang       2016-06-06  302  		else
c19b6d246a3562 Zhao Qiang       2016-06-06  303  			bd_status = R_E_S | R_I_S | R_W_S;
c19b6d246a3562 Zhao Qiang       2016-06-06  304  
c19b6d246a3562 Zhao Qiang       2016-06-06 @305  		iowrite16be(bd_status, &priv->rx_bd_base[i].status);
c19b6d246a3562 Zhao Qiang       2016-06-06  306  		iowrite32be(priv->dma_rx_addr + i * MAX_RX_BUF_LENGTH,
c19b6d246a3562 Zhao Qiang       2016-06-06  307  			    &priv->rx_bd_base[i].buf);
c19b6d246a3562 Zhao Qiang       2016-06-06  308  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  309  
c19b6d246a3562 Zhao Qiang       2016-06-06  310  	for (i = 0; i < TX_BD_RING_LEN; i++) {
c19b6d246a3562 Zhao Qiang       2016-06-06  311  		if (i < (TX_BD_RING_LEN - 1))
c19b6d246a3562 Zhao Qiang       2016-06-06  312  			bd_status =  T_I_S | T_TC_S;
c19b6d246a3562 Zhao Qiang       2016-06-06  313  		else
c19b6d246a3562 Zhao Qiang       2016-06-06  314  			bd_status =  T_I_S | T_TC_S | T_W_S;
c19b6d246a3562 Zhao Qiang       2016-06-06  315  
c19b6d246a3562 Zhao Qiang       2016-06-06  316  		iowrite16be(bd_status, &priv->tx_bd_base[i].status);
c19b6d246a3562 Zhao Qiang       2016-06-06  317  		iowrite32be(priv->dma_tx_addr + i * MAX_RX_BUF_LENGTH,
c19b6d246a3562 Zhao Qiang       2016-06-06  318  			    &priv->tx_bd_base[i].buf);
c19b6d246a3562 Zhao Qiang       2016-06-06  319  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  320  
c19b6d246a3562 Zhao Qiang       2016-06-06  321  	return 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  322  
1efb597d8bf56c Zhao Qiang       2016-07-15  323  free_tiptr:
c19b6d246a3562 Zhao Qiang       2016-06-06  324  	qe_muram_free(tiptr);
1efb597d8bf56c Zhao Qiang       2016-07-15  325  free_riptr:
c19b6d246a3562 Zhao Qiang       2016-06-06  326  	qe_muram_free(riptr);
1efb597d8bf56c Zhao Qiang       2016-07-15  327  free_tx_skbuff:
c19b6d246a3562 Zhao Qiang       2016-06-06  328  	kfree(priv->tx_skbuff);
1efb597d8bf56c Zhao Qiang       2016-07-15  329  free_rx_skbuff:
c19b6d246a3562 Zhao Qiang       2016-06-06  330  	kfree(priv->rx_skbuff);
1efb597d8bf56c Zhao Qiang       2016-07-15  331  free_ucc_pram:
c19b6d246a3562 Zhao Qiang       2016-06-06  332  	qe_muram_free(priv->ucc_pram_offset);
1efb597d8bf56c Zhao Qiang       2016-07-15  333  free_tx_bd:
c19b6d246a3562 Zhao Qiang       2016-06-06  334  	dma_free_coherent(priv->dev,
5b8aad93c52bdd Holger Brunck    2017-05-17  335  			  TX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a3562 Zhao Qiang       2016-06-06  336  			  priv->tx_bd_base, priv->dma_tx_bd);
1efb597d8bf56c Zhao Qiang       2016-07-15  337  free_rx_bd:
c19b6d246a3562 Zhao Qiang       2016-06-06  338  	dma_free_coherent(priv->dev,
5b8aad93c52bdd Holger Brunck    2017-05-17  339  			  RX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a3562 Zhao Qiang       2016-06-06  340  			  priv->rx_bd_base, priv->dma_rx_bd);
1efb597d8bf56c Zhao Qiang       2016-07-15  341  free_uccf:
c19b6d246a3562 Zhao Qiang       2016-06-06  342  	ucc_fast_free(priv->uccf);
c19b6d246a3562 Zhao Qiang       2016-06-06  343  
c19b6d246a3562 Zhao Qiang       2016-06-06  344  	return ret;
c19b6d246a3562 Zhao Qiang       2016-06-06  345  }
c19b6d246a3562 Zhao Qiang       2016-06-06  346  

:::::: The code at line 305 was first introduced by commit
:::::: c19b6d246a35627c3a69b2fa6bdece212b48214b drivers/net: support hdlc function for QE-UCC

:::::: TO: Zhao Qiang <qiang.zhao@nxp.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--a8Wt8u1KmwUX3Y2C
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
mh8CAA==

--a8Wt8u1KmwUX3Y2C--
