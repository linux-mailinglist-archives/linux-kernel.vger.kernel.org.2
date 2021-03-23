Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87BB345AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCWJYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:24:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:49021 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhCWJYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:24:40 -0400
IronPort-SDR: NHtiwFk6HxU3Zr6dSY9P1t7y7DezeJndfG/Tk+EbcPrDPA8mqnTDgdW/7WNb7n+fB0ee/DhGMj
 HZvKjuXFSnpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="190467322"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="gz'50?scan'50,208,50";a="190467322"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 02:24:39 -0700
IronPort-SDR: DF0xpKGdKlJdCXgqXcmQuz2nIRCYrOU3h+vx3lNDl26TTG8HeJPV8HHidtU+qPNKKQFqtu4o9v
 77XcKfpcusGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="gz'50?scan'50,208,50";a="414899013"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2021 02:24:37 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lOdHA-0000Uf-A4; Tue, 23 Mar 2021 09:24:36 +0000
Date:   Tue, 23 Mar 2021 17:24:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202103231755.3My0Fk2Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   84196390620ac0e5070ae36af84c137c6216a7dc
commit: 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e powerpc: inline iomap accessors
date:   4 months ago
config: powerpc64-randconfig-s032-20210323 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-277-gc089cd2d-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

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
   drivers/net/wan/fsl_ucc_hdlc.c:631:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/wan/fsl_ucc_hdlc.c:631:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/wan/fsl_ucc_hdlc.c:850:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct qe_mux *qe_mux_reg @@     got struct qe_mux [noderef] __iomem * @@
   drivers/net/wan/fsl_ucc_hdlc.c:853:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:854:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:857:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:860:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *s @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:865:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct qe_mux *qe_mux_reg @@     got struct qe_mux [noderef] __iomem * @@
   drivers/net/wan/fsl_ucc_hdlc.c:867:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:869:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:870:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:872:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:992:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:994:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:1003:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:1005:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:408:35: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:723:29: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:814:21: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:1020:29: sparse: sparse: dereference of noderef expression

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
c19b6d246a3562 Zhao Qiang       2016-06-06  398  	bd = priv->curtx_bd;
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

--2fHTh5uZTiUOsy+g
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
sAEA

--2fHTh5uZTiUOsy+g--
