Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB14F37ED54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386336AbhELUUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:20:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:40297 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383784AbhELTx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 15:53:59 -0400
IronPort-SDR: AiHTI8shXb4a8vbjgvSVgIIcinDyq8pSWmho6aLVo58NazsWpJXC8QIhcF4UCLvk9zY5vj6TSy
 DnhSLCNC4X+A==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="285298634"
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="gz'50?scan'50,208,50";a="285298634"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 12:52:50 -0700
IronPort-SDR: zbONvQjH+mvgdfjEMCajUcMprBhmaHhvtOLmTrZsfWg7HSYeEWWnud1RHsAYXiDUR3bC7Xrkm5
 9dkunx4NsELA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="gz'50?scan'50,208,50";a="469595688"
Received: from lkp-server01.sh.intel.com (HELO 1e931876798f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 12 May 2021 12:52:48 -0700
Received: from kbuild by 1e931876798f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lguuV-0000TG-B9; Wed, 12 May 2021 19:52:47 +0000
Date:   Thu, 13 May 2021 03:52:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: drivers/net/wan/fsl_ucc_hdlc.c:305:17: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202105130338.QylmHibK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88b06399c9c766c283e070b022b5ceafa4f63f19
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   9 months ago
config: arm-randconfig-s032-20210513 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=arm 

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

--PNTmBPCT7hxwcZjr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
dqqYiKSI+1bwAGwV94UyJP8HYltM/2IlAgA=

--PNTmBPCT7hxwcZjr--
