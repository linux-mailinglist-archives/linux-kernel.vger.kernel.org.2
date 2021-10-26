Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFA743AC00
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 08:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhJZGHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 02:07:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:5454 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232875AbhJZGG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 02:06:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="316034768"
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="gz'50?scan'50,208,50";a="316034768"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 23:04:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="gz'50?scan'50,208,50";a="634999524"
Received: from lkp-server01.sh.intel.com (HELO 979d88847c63) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2021 23:04:20 -0700
Received: from kbuild by 979d88847c63 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mfFZL-0000NR-Gg; Tue, 26 Oct 2021 06:04:19 +0000
Date:   Tue, 26 Oct 2021 14:03:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202110261439.Wlu3WZcT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3906fe9bb7f1a2c8667ae54e967dc8690824f4ea
commit: 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e powerpc: inline iomap accessors
date:   11 months ago
config: powerpc-allyesconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc 

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
>> drivers/net/wan/fsl_ucc_hdlc.c:853:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be32 * @@
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

--LQksG6bCIzRHxTLp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--LQksG6bCIzRHxTLp--
