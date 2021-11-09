Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF73C44B922
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbhKIXBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 18:01:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:21614 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241137AbhKIXAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 18:00:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="232404393"
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="gz'50?scan'50,208,50";a="232404393"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 14:58:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="gz'50?scan'50,208,50";a="669578662"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Nov 2021 14:58:02 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mka42-000E2s-0Y; Tue, 09 Nov 2021 22:58:02 +0000
Date:   Wed, 10 Nov 2021 06:57:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202111100642.6is4RXmp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cb690f5238d71f543f4ce874aa59237cf53a877c
commit: 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e powerpc: inline iomap accessors
date:   11 months ago
config: powerpc64-randconfig-s031-20210929 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse:     expected void [noderef] __iomem *addr
   drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse:     got restricted __be16 *
>> drivers/net/wan/fsl_ucc_hdlc.c:307:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:307:46: sparse:     expected void [noderef] __iomem *addr
   drivers/net/wan/fsl_ucc_hdlc.c:307:46: sparse:     got restricted __be32 *
   drivers/net/wan/fsl_ucc_hdlc.c:316:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:316:57: sparse:     expected void [noderef] __iomem *addr
   drivers/net/wan/fsl_ucc_hdlc.c:316:57: sparse:     got restricted __be16 *
   drivers/net/wan/fsl_ucc_hdlc.c:318:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:318:46: sparse:     expected void [noderef] __iomem *addr
   drivers/net/wan/fsl_ucc_hdlc.c:318:46: sparse:     got restricted __be32 *
   drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __be16 [usertype] @@
   drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse:     expected unsigned short [usertype]
   drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse:     got restricted __be16 [usertype]
   drivers/net/wan/fsl_ucc_hdlc.c:375:36: sparse: sparse: restricted __be16 degrades to integer
   drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd [noderef] __iomem *bd @@     got struct qe_bd *curtx_bd @@
   drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse:     expected struct qe_bd [noderef] __iomem *bd
   drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse:     got struct qe_bd *curtx_bd
   drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd [noderef] __iomem *[assigned] bd @@     got struct qe_bd *tx_bd_base @@
   drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse:     expected struct qe_bd [noderef] __iomem *[assigned] bd
   drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse:     got struct qe_bd *tx_bd_base
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse:    struct qe_bd [noderef] __iomem *
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse:    struct qe_bd *
>> drivers/net/wan/fsl_ucc_hdlc.c:458:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:502:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:524:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:548:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:592:67: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:607:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
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
c19b6d246a3562 Zhao Qiang       2016-06-06 @307  			    &priv->rx_bd_base[i].buf);
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
c19b6d246a3562 Zhao Qiang       2016-06-06  347  static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
c19b6d246a3562 Zhao Qiang       2016-06-06  348  {
c19b6d246a3562 Zhao Qiang       2016-06-06  349  	hdlc_device *hdlc = dev_to_hdlc(dev);
c19b6d246a3562 Zhao Qiang       2016-06-06  350  	struct ucc_hdlc_private *priv = (struct ucc_hdlc_private *)hdlc->priv;
c19b6d246a3562 Zhao Qiang       2016-06-06  351  	struct qe_bd __iomem *bd;
c19b6d246a3562 Zhao Qiang       2016-06-06  352  	u16 bd_status;
c19b6d246a3562 Zhao Qiang       2016-06-06  353  	unsigned long flags;
c19b6d246a3562 Zhao Qiang       2016-06-06  354  	u16 *proto_head;
c19b6d246a3562 Zhao Qiang       2016-06-06  355  
c19b6d246a3562 Zhao Qiang       2016-06-06  356  	switch (dev->type) {
c19b6d246a3562 Zhao Qiang       2016-06-06  357  	case ARPHRD_RAWHDLC:
c19b6d246a3562 Zhao Qiang       2016-06-06  358  		if (skb_headroom(skb) < HDLC_HEAD_LEN) {
c19b6d246a3562 Zhao Qiang       2016-06-06  359  			dev->stats.tx_dropped++;
c19b6d246a3562 Zhao Qiang       2016-06-06  360  			dev_kfree_skb(skb);
c19b6d246a3562 Zhao Qiang       2016-06-06  361  			netdev_err(dev, "No enough space for hdlc head\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  362  			return -ENOMEM;
c19b6d246a3562 Zhao Qiang       2016-06-06  363  		}
c19b6d246a3562 Zhao Qiang       2016-06-06  364  
c19b6d246a3562 Zhao Qiang       2016-06-06  365  		skb_push(skb, HDLC_HEAD_LEN);
c19b6d246a3562 Zhao Qiang       2016-06-06  366  
c19b6d246a3562 Zhao Qiang       2016-06-06  367  		proto_head = (u16 *)skb->data;
c19b6d246a3562 Zhao Qiang       2016-06-06  368  		*proto_head = htons(DEFAULT_HDLC_HEAD);
c19b6d246a3562 Zhao Qiang       2016-06-06  369  
c19b6d246a3562 Zhao Qiang       2016-06-06  370  		dev->stats.tx_bytes += skb->len;
c19b6d246a3562 Zhao Qiang       2016-06-06  371  		break;
c19b6d246a3562 Zhao Qiang       2016-06-06  372  
c19b6d246a3562 Zhao Qiang       2016-06-06  373  	case ARPHRD_PPP:
c19b6d246a3562 Zhao Qiang       2016-06-06  374  		proto_head = (u16 *)skb->data;
c19b6d246a3562 Zhao Qiang       2016-06-06  375  		if (*proto_head != htons(DEFAULT_PPP_HEAD)) {
c19b6d246a3562 Zhao Qiang       2016-06-06  376  			dev->stats.tx_dropped++;
c19b6d246a3562 Zhao Qiang       2016-06-06  377  			dev_kfree_skb(skb);
c19b6d246a3562 Zhao Qiang       2016-06-06  378  			netdev_err(dev, "Wrong ppp header\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  379  			return -ENOMEM;
c19b6d246a3562 Zhao Qiang       2016-06-06  380  		}
c19b6d246a3562 Zhao Qiang       2016-06-06  381  
c19b6d246a3562 Zhao Qiang       2016-06-06  382  		dev->stats.tx_bytes += skb->len;
c19b6d246a3562 Zhao Qiang       2016-06-06  383  		break;
c19b6d246a3562 Zhao Qiang       2016-06-06  384  
8978ca7c8b7b07 David Gounaris   2018-09-03  385  	case ARPHRD_ETHER:
8978ca7c8b7b07 David Gounaris   2018-09-03  386  		dev->stats.tx_bytes += skb->len;
8978ca7c8b7b07 David Gounaris   2018-09-03  387  		break;
8978ca7c8b7b07 David Gounaris   2018-09-03  388  
c19b6d246a3562 Zhao Qiang       2016-06-06  389  	default:
c19b6d246a3562 Zhao Qiang       2016-06-06  390  		dev->stats.tx_dropped++;
c19b6d246a3562 Zhao Qiang       2016-06-06  391  		dev_kfree_skb(skb);
c19b6d246a3562 Zhao Qiang       2016-06-06  392  		return -ENOMEM;
c19b6d246a3562 Zhao Qiang       2016-06-06  393  	}
2e7ad56aa54778 Mathias Thore    2018-11-07  394  	netdev_sent_queue(dev, skb->len);
c19b6d246a3562 Zhao Qiang       2016-06-06  395  	spin_lock_irqsave(&priv->lock, flags);
c19b6d246a3562 Zhao Qiang       2016-06-06  396  
c19b6d246a3562 Zhao Qiang       2016-06-06  397  	/* Start from the next BD that should be filled */
c19b6d246a3562 Zhao Qiang       2016-06-06 @398  	bd = priv->curtx_bd;
c19b6d246a3562 Zhao Qiang       2016-06-06  399  	bd_status = ioread16be(&bd->status);
c19b6d246a3562 Zhao Qiang       2016-06-06  400  	/* Save the skb pointer so we can free it later */
c19b6d246a3562 Zhao Qiang       2016-06-06  401  	priv->tx_skbuff[priv->skb_curtx] = skb;
c19b6d246a3562 Zhao Qiang       2016-06-06  402  
c19b6d246a3562 Zhao Qiang       2016-06-06  403  	/* Update the current skb pointer (wrapping if this was the last) */
c19b6d246a3562 Zhao Qiang       2016-06-06  404  	priv->skb_curtx =
c19b6d246a3562 Zhao Qiang       2016-06-06  405  	    (priv->skb_curtx + 1) & TX_RING_MOD_MASK(TX_BD_RING_LEN);
c19b6d246a3562 Zhao Qiang       2016-06-06  406  
c19b6d246a3562 Zhao Qiang       2016-06-06  407  	/* copy skb data to tx buffer for sdma processing */
c19b6d246a3562 Zhao Qiang       2016-06-06  408  	memcpy(priv->tx_buffer + (be32_to_cpu(bd->buf) - priv->dma_tx_addr),
c19b6d246a3562 Zhao Qiang       2016-06-06  409  	       skb->data, skb->len);
c19b6d246a3562 Zhao Qiang       2016-06-06  410  
c19b6d246a3562 Zhao Qiang       2016-06-06  411  	/* set bd status and length */
c19b6d246a3562 Zhao Qiang       2016-06-06  412  	bd_status = (bd_status & T_W_S) | T_R_S | T_I_S | T_L_S | T_TC_S;
c19b6d246a3562 Zhao Qiang       2016-06-06  413  
c19b6d246a3562 Zhao Qiang       2016-06-06  414  	iowrite16be(skb->len, &bd->length);
02bb56ddc67116 Zhao Qiang       2017-03-14  415  	iowrite16be(bd_status, &bd->status);
c19b6d246a3562 Zhao Qiang       2016-06-06  416  
c19b6d246a3562 Zhao Qiang       2016-06-06  417  	/* Move to next BD in the ring */
c19b6d246a3562 Zhao Qiang       2016-06-06  418  	if (!(bd_status & T_W_S))
c19b6d246a3562 Zhao Qiang       2016-06-06  419  		bd += 1;
c19b6d246a3562 Zhao Qiang       2016-06-06  420  	else
c19b6d246a3562 Zhao Qiang       2016-06-06  421  		bd = priv->tx_bd_base;
c19b6d246a3562 Zhao Qiang       2016-06-06  422  
c19b6d246a3562 Zhao Qiang       2016-06-06  423  	if (bd == priv->dirty_tx) {
c19b6d246a3562 Zhao Qiang       2016-06-06  424  		if (!netif_queue_stopped(dev))
c19b6d246a3562 Zhao Qiang       2016-06-06  425  			netif_stop_queue(dev);
c19b6d246a3562 Zhao Qiang       2016-06-06  426  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  427  
c19b6d246a3562 Zhao Qiang       2016-06-06  428  	priv->curtx_bd = bd;
c19b6d246a3562 Zhao Qiang       2016-06-06  429  
c19b6d246a3562 Zhao Qiang       2016-06-06  430  	spin_unlock_irqrestore(&priv->lock, flags);
c19b6d246a3562 Zhao Qiang       2016-06-06  431  
c19b6d246a3562 Zhao Qiang       2016-06-06  432  	return NETDEV_TX_OK;
c19b6d246a3562 Zhao Qiang       2016-06-06  433  }
c19b6d246a3562 Zhao Qiang       2016-06-06  434  
ba59d5705825fb Mathias Thore    2018-10-22  435  static int hdlc_tx_restart(struct ucc_hdlc_private *priv)
ba59d5705825fb Mathias Thore    2018-10-22  436  {
ba59d5705825fb Mathias Thore    2018-10-22  437  	u32 cecr_subblock;
ba59d5705825fb Mathias Thore    2018-10-22  438  
ba59d5705825fb Mathias Thore    2018-10-22  439  	cecr_subblock =
ba59d5705825fb Mathias Thore    2018-10-22  440  		ucc_fast_get_qe_cr_subblock(priv->ut_info->uf_info.ucc_num);
ba59d5705825fb Mathias Thore    2018-10-22  441  
ba59d5705825fb Mathias Thore    2018-10-22  442  	qe_issue_cmd(QE_RESTART_TX, cecr_subblock,
ba59d5705825fb Mathias Thore    2018-10-22  443  		     QE_CR_PROTOCOL_UNSPECIFIED, 0);
ba59d5705825fb Mathias Thore    2018-10-22  444  	return 0;
ba59d5705825fb Mathias Thore    2018-10-22  445  }
ba59d5705825fb Mathias Thore    2018-10-22  446  
c19b6d246a3562 Zhao Qiang       2016-06-06  447  static int hdlc_tx_done(struct ucc_hdlc_private *priv)
c19b6d246a3562 Zhao Qiang       2016-06-06  448  {
c19b6d246a3562 Zhao Qiang       2016-06-06  449  	/* Start from the next BD that should be filled */
c19b6d246a3562 Zhao Qiang       2016-06-06  450  	struct net_device *dev = priv->ndev;
2e7ad56aa54778 Mathias Thore    2018-11-07  451  	unsigned int bytes_sent = 0;
2e7ad56aa54778 Mathias Thore    2018-11-07  452  	int howmany = 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  453  	struct qe_bd *bd;		/* BD pointer */
c19b6d246a3562 Zhao Qiang       2016-06-06  454  	u16 bd_status;
ba59d5705825fb Mathias Thore    2018-10-22  455  	int tx_restart = 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  456  
c19b6d246a3562 Zhao Qiang       2016-06-06  457  	bd = priv->dirty_tx;
c19b6d246a3562 Zhao Qiang       2016-06-06 @458  	bd_status = ioread16be(&bd->status);
c19b6d246a3562 Zhao Qiang       2016-06-06  459  
c19b6d246a3562 Zhao Qiang       2016-06-06  460  	/* Normal processing. */
c19b6d246a3562 Zhao Qiang       2016-06-06  461  	while ((bd_status & T_R_S) == 0) {
c19b6d246a3562 Zhao Qiang       2016-06-06  462  		struct sk_buff *skb;
c19b6d246a3562 Zhao Qiang       2016-06-06  463  
ba59d5705825fb Mathias Thore    2018-10-22  464  		if (bd_status & T_UN_S) { /* Underrun */
ba59d5705825fb Mathias Thore    2018-10-22  465  			dev->stats.tx_fifo_errors++;
ba59d5705825fb Mathias Thore    2018-10-22  466  			tx_restart = 1;
ba59d5705825fb Mathias Thore    2018-10-22  467  		}
ba59d5705825fb Mathias Thore    2018-10-22  468  		if (bd_status & T_CT_S) { /* Carrier lost */
ba59d5705825fb Mathias Thore    2018-10-22  469  			dev->stats.tx_carrier_errors++;
ba59d5705825fb Mathias Thore    2018-10-22  470  			tx_restart = 1;
ba59d5705825fb Mathias Thore    2018-10-22  471  		}
ba59d5705825fb Mathias Thore    2018-10-22  472  
c19b6d246a3562 Zhao Qiang       2016-06-06  473  		/* BD contains already transmitted buffer.   */
c19b6d246a3562 Zhao Qiang       2016-06-06  474  		/* Handle the transmitted buffer and release */
c19b6d246a3562 Zhao Qiang       2016-06-06  475  		/* the BD to be used with the current frame  */
c19b6d246a3562 Zhao Qiang       2016-06-06  476  
c19b6d246a3562 Zhao Qiang       2016-06-06  477  		skb = priv->tx_skbuff[priv->skb_dirtytx];
c19b6d246a3562 Zhao Qiang       2016-06-06  478  		if (!skb)
c19b6d246a3562 Zhao Qiang       2016-06-06  479  			break;
2e7ad56aa54778 Mathias Thore    2018-11-07  480  		howmany++;
2e7ad56aa54778 Mathias Thore    2018-11-07  481  		bytes_sent += skb->len;
c19b6d246a3562 Zhao Qiang       2016-06-06  482  		dev->stats.tx_packets++;
c19b6d246a3562 Zhao Qiang       2016-06-06  483  		memset(priv->tx_buffer +
c19b6d246a3562 Zhao Qiang       2016-06-06  484  		       (be32_to_cpu(bd->buf) - priv->dma_tx_addr),
c19b6d246a3562 Zhao Qiang       2016-06-06  485  		       0, skb->len);
7c3850adbcccc2 Yang Wei         2019-02-06  486  		dev_consume_skb_irq(skb);
c19b6d246a3562 Zhao Qiang       2016-06-06  487  
c19b6d246a3562 Zhao Qiang       2016-06-06  488  		priv->tx_skbuff[priv->skb_dirtytx] = NULL;
c19b6d246a3562 Zhao Qiang       2016-06-06  489  		priv->skb_dirtytx =
c19b6d246a3562 Zhao Qiang       2016-06-06  490  		    (priv->skb_dirtytx +
c19b6d246a3562 Zhao Qiang       2016-06-06  491  		     1) & TX_RING_MOD_MASK(TX_BD_RING_LEN);
c19b6d246a3562 Zhao Qiang       2016-06-06  492  
c19b6d246a3562 Zhao Qiang       2016-06-06  493  		/* We freed a buffer, so now we can restart transmission */
c19b6d246a3562 Zhao Qiang       2016-06-06  494  		if (netif_queue_stopped(dev))
c19b6d246a3562 Zhao Qiang       2016-06-06  495  			netif_wake_queue(dev);
c19b6d246a3562 Zhao Qiang       2016-06-06  496  
c19b6d246a3562 Zhao Qiang       2016-06-06  497  		/* Advance the confirmation BD pointer */
c19b6d246a3562 Zhao Qiang       2016-06-06  498  		if (!(bd_status & T_W_S))
c19b6d246a3562 Zhao Qiang       2016-06-06  499  			bd += 1;
c19b6d246a3562 Zhao Qiang       2016-06-06  500  		else
c19b6d246a3562 Zhao Qiang       2016-06-06  501  			bd = priv->tx_bd_base;
c19b6d246a3562 Zhao Qiang       2016-06-06  502  		bd_status = ioread16be(&bd->status);
c19b6d246a3562 Zhao Qiang       2016-06-06  503  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  504  	priv->dirty_tx = bd;
c19b6d246a3562 Zhao Qiang       2016-06-06  505  
ba59d5705825fb Mathias Thore    2018-10-22  506  	if (tx_restart)
ba59d5705825fb Mathias Thore    2018-10-22  507  		hdlc_tx_restart(priv);
ba59d5705825fb Mathias Thore    2018-10-22  508  
2e7ad56aa54778 Mathias Thore    2018-11-07  509  	netdev_completed_queue(dev, howmany, bytes_sent);
c19b6d246a3562 Zhao Qiang       2016-06-06  510  	return 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  511  }
c19b6d246a3562 Zhao Qiang       2016-06-06  512  

:::::: The code at line 305 was first introduced by commit
:::::: c19b6d246a35627c3a69b2fa6bdece212b48214b drivers/net: support hdlc function for QE-UCC

:::::: TO: Zhao Qiang <qiang.zhao@nxp.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--G4iJoqBmSsgzjUCe
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--G4iJoqBmSsgzjUCe--
