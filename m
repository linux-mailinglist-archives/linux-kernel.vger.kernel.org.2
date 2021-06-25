Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD673B3C64
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhFYF66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:58:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:20816 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhFYF6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:58:55 -0400
IronPort-SDR: btPqYOpZ1YRfBi3Va7JquyEDlTzBHReMx0SdyEkxc7pZKyzodz4ogh3WE60qePOeIXbC5hRRJz
 OACaWpolpOKQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="194757956"
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="gz'50?scan'50,208,50";a="194757956"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 22:56:34 -0700
IronPort-SDR: b9jZuZC9ZwOiD+MTwz62suJY/Igx+i8SbE0K6teSBeQk3FFBwMAuj97BsqF9kT+FmrDng6GMiM
 FHjGjantUd0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="gz'50?scan'50,208,50";a="488059365"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2021 22:56:32 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lwepM-0006we-0V; Fri, 25 Jun 2021 05:56:32 +0000
Date:   Fri, 25 Jun 2021 13:55:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202106251340.vUQvfGbc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   44db63d1ad8d71c6932cbe007eb41f31c434d140
commit: 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e powerpc: inline iomap accessors
date:   7 months ago
config: powerpc64-randconfig-s031-20210625 (attached as .config)
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

--ew6BAiZeqk4r7MaW
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ew6BAiZeqk4r7MaW--
