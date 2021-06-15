Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E193A7CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFOLLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:11:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:46007 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230012AbhFOLLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:11:51 -0400
IronPort-SDR: 7FOYPxA1vJmWDLspN0Td+QMFSvgV43IHUH/kbx2N/wFrAWSvoPwG0HQPB/cmBaVLYuIyr1KbKV
 koMMDpi7mc9w==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="193085974"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="gz'50?scan'50,208,50";a="193085974"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 04:09:45 -0700
IronPort-SDR: Ah2YSpKmFh/PDf8B+DEA7LCKw3YAbdsqB/m8XCxJ7Mt6+ta7pgQ9nW0gMKZUkHKjJqAw24RWaw
 CCuNSsMCOCdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="gz'50?scan'50,208,50";a="451938517"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2021 04:09:43 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lt6ww-0000OB-Jb; Tue, 15 Jun 2021 11:09:42 +0000
Date:   Tue, 15 Jun 2021 19:09:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: drivers/net/wan/fsl_ucc_hdlc.c:305:17: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202106151924.PKPTrVYR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   009c9aa5be652675a06d5211e1640e02bbb1c33d
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   10 months ago
config: arm-randconfig-s032-20210615 (attached as .config)
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
   drivers/net/wan/fsl_ucc_hdlc.c:850:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct qe_mux *qe_mux_reg @@     got struct qe_mux [noderef] __iomem * @@
   drivers/net/wan/fsl_ucc_hdlc.c:853:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:853:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:853:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:853:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:853:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:853:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:854:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:854:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:854:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:854:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:854:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:854:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:857:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:857:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:857:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:857:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:857:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:857:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:860:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:865:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct qe_mux *qe_mux_reg @@     got struct qe_mux [noderef] __iomem * @@
   drivers/net/wan/fsl_ucc_hdlc.c:867:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:869:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:870:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:872:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:992:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:993:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:1003:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:1004:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:408:35: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:408:35: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:723:29: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:814:21: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:1020:29: sparse: sparse: dereference of noderef expression

vim +305 drivers/net/wan/fsl_ucc_hdlc.c

c19b6d246a35627 Zhao Qiang       2016-06-06   77  
c19b6d246a35627 Zhao Qiang       2016-06-06   78  static int uhdlc_init(struct ucc_hdlc_private *priv)
c19b6d246a35627 Zhao Qiang       2016-06-06   79  {
c19b6d246a35627 Zhao Qiang       2016-06-06   80  	struct ucc_tdm_info *ut_info;
c19b6d246a35627 Zhao Qiang       2016-06-06   81  	struct ucc_fast_info *uf_info;
c19b6d246a35627 Zhao Qiang       2016-06-06   82  	u32 cecr_subblock;
c19b6d246a35627 Zhao Qiang       2016-06-06   83  	u16 bd_status;
c19b6d246a35627 Zhao Qiang       2016-06-06   84  	int ret, i;
c19b6d246a35627 Zhao Qiang       2016-06-06   85  	void *bd_buffer;
c19b6d246a35627 Zhao Qiang       2016-06-06   86  	dma_addr_t bd_dma_addr;
be2e9415f8b366a Rasmus Villemoes 2019-11-28   87  	s32 riptr;
be2e9415f8b366a Rasmus Villemoes 2019-11-28   88  	s32 tiptr;
c19b6d246a35627 Zhao Qiang       2016-06-06   89  	u32 gumr;
c19b6d246a35627 Zhao Qiang       2016-06-06   90  
c19b6d246a35627 Zhao Qiang       2016-06-06   91  	ut_info = priv->ut_info;
c19b6d246a35627 Zhao Qiang       2016-06-06   92  	uf_info = &ut_info->uf_info;
c19b6d246a35627 Zhao Qiang       2016-06-06   93  
c19b6d246a35627 Zhao Qiang       2016-06-06   94  	if (priv->tsa) {
c19b6d246a35627 Zhao Qiang       2016-06-06   95  		uf_info->tsa = 1;
c19b6d246a35627 Zhao Qiang       2016-06-06   96  		uf_info->ctsp = 1;
040b7c94e4ec585 David Gounaris   2018-09-03   97  		uf_info->cds = 1;
040b7c94e4ec585 David Gounaris   2018-09-03   98  		uf_info->ctss = 1;
040b7c94e4ec585 David Gounaris   2018-09-03   99  	} else {
040b7c94e4ec585 David Gounaris   2018-09-03  100  		uf_info->cds = 0;
040b7c94e4ec585 David Gounaris   2018-09-03  101  		uf_info->ctsp = 0;
040b7c94e4ec585 David Gounaris   2018-09-03  102  		uf_info->ctss = 0;
c19b6d246a35627 Zhao Qiang       2016-06-06  103  	}
067bb938dad61e5 Holger Brunck    2017-05-17  104  
067bb938dad61e5 Holger Brunck    2017-05-17  105  	/* This sets HPM register in CMXUCR register which configures a
067bb938dad61e5 Holger Brunck    2017-05-17  106  	 * open drain connected HDLC bus
067bb938dad61e5 Holger Brunck    2017-05-17  107  	 */
067bb938dad61e5 Holger Brunck    2017-05-17  108  	if (priv->hdlc_bus)
067bb938dad61e5 Holger Brunck    2017-05-17  109  		uf_info->brkpt_support = 1;
067bb938dad61e5 Holger Brunck    2017-05-17  110  
c19b6d246a35627 Zhao Qiang       2016-06-06  111  	uf_info->uccm_mask = ((UCC_HDLC_UCCE_RXB | UCC_HDLC_UCCE_RXF |
c19b6d246a35627 Zhao Qiang       2016-06-06  112  				UCC_HDLC_UCCE_TXB) << 16);
c19b6d246a35627 Zhao Qiang       2016-06-06  113  
c19b6d246a35627 Zhao Qiang       2016-06-06  114  	ret = ucc_fast_init(uf_info, &priv->uccf);
c19b6d246a35627 Zhao Qiang       2016-06-06  115  	if (ret) {
c19b6d246a35627 Zhao Qiang       2016-06-06  116  		dev_err(priv->dev, "Failed to init uccf.");
c19b6d246a35627 Zhao Qiang       2016-06-06  117  		return ret;
c19b6d246a35627 Zhao Qiang       2016-06-06  118  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  119  
c19b6d246a35627 Zhao Qiang       2016-06-06  120  	priv->uf_regs = priv->uccf->uf_regs;
c19b6d246a35627 Zhao Qiang       2016-06-06  121  	ucc_fast_disable(priv->uccf, COMM_DIR_RX | COMM_DIR_TX);
c19b6d246a35627 Zhao Qiang       2016-06-06  122  
c19b6d246a35627 Zhao Qiang       2016-06-06  123  	/* Loopback mode */
c19b6d246a35627 Zhao Qiang       2016-06-06  124  	if (priv->loopback) {
c19b6d246a35627 Zhao Qiang       2016-06-06  125  		dev_info(priv->dev, "Loopback Mode\n");
54e9e0874938ba5 Holger Brunck    2017-05-17  126  		/* use the same clock when work in loopback */
54e9e0874938ba5 Holger Brunck    2017-05-17  127  		qe_setbrg(ut_info->uf_info.rx_clock, 20000000, 1);
54e9e0874938ba5 Holger Brunck    2017-05-17  128  
c19b6d246a35627 Zhao Qiang       2016-06-06  129  		gumr = ioread32be(&priv->uf_regs->gumr);
c19b6d246a35627 Zhao Qiang       2016-06-06  130  		gumr |= (UCC_FAST_GUMR_LOOPBACK | UCC_FAST_GUMR_CDS |
c19b6d246a35627 Zhao Qiang       2016-06-06  131  			 UCC_FAST_GUMR_TCI);
c19b6d246a35627 Zhao Qiang       2016-06-06  132  		gumr &= ~(UCC_FAST_GUMR_CTSP | UCC_FAST_GUMR_RSYN);
c19b6d246a35627 Zhao Qiang       2016-06-06  133  		iowrite32be(gumr, &priv->uf_regs->gumr);
c19b6d246a35627 Zhao Qiang       2016-06-06  134  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  135  
c19b6d246a35627 Zhao Qiang       2016-06-06  136  	/* Initialize SI */
c19b6d246a35627 Zhao Qiang       2016-06-06  137  	if (priv->tsa)
c19b6d246a35627 Zhao Qiang       2016-06-06  138  		ucc_tdm_init(priv->utdm, priv->ut_info);
c19b6d246a35627 Zhao Qiang       2016-06-06  139  
c19b6d246a35627 Zhao Qiang       2016-06-06  140  	/* Write to QE CECR, UCCx channel to Stop Transmission */
c19b6d246a35627 Zhao Qiang       2016-06-06  141  	cecr_subblock = ucc_fast_get_qe_cr_subblock(uf_info->ucc_num);
c19b6d246a35627 Zhao Qiang       2016-06-06  142  	ret = qe_issue_cmd(QE_STOP_TX, cecr_subblock,
c19b6d246a35627 Zhao Qiang       2016-06-06  143  			   QE_CR_PROTOCOL_UNSPECIFIED, 0);
c19b6d246a35627 Zhao Qiang       2016-06-06  144  
c19b6d246a35627 Zhao Qiang       2016-06-06  145  	/* Set UPSMR normal mode (need fixed)*/
c19b6d246a35627 Zhao Qiang       2016-06-06  146  	iowrite32be(0, &priv->uf_regs->upsmr);
c19b6d246a35627 Zhao Qiang       2016-06-06  147  
067bb938dad61e5 Holger Brunck    2017-05-17  148  	/* hdlc_bus mode */
067bb938dad61e5 Holger Brunck    2017-05-17  149  	if (priv->hdlc_bus) {
067bb938dad61e5 Holger Brunck    2017-05-17  150  		u32 upsmr;
067bb938dad61e5 Holger Brunck    2017-05-17  151  
067bb938dad61e5 Holger Brunck    2017-05-17  152  		dev_info(priv->dev, "HDLC bus Mode\n");
067bb938dad61e5 Holger Brunck    2017-05-17  153  		upsmr = ioread32be(&priv->uf_regs->upsmr);
067bb938dad61e5 Holger Brunck    2017-05-17  154  
067bb938dad61e5 Holger Brunck    2017-05-17  155  		/* bus mode and retransmit enable, with collision window
067bb938dad61e5 Holger Brunck    2017-05-17  156  		 * set to 8 bytes
067bb938dad61e5 Holger Brunck    2017-05-17  157  		 */
067bb938dad61e5 Holger Brunck    2017-05-17  158  		upsmr |= UCC_HDLC_UPSMR_RTE | UCC_HDLC_UPSMR_BUS |
067bb938dad61e5 Holger Brunck    2017-05-17  159  				UCC_HDLC_UPSMR_CW8;
067bb938dad61e5 Holger Brunck    2017-05-17  160  		iowrite32be(upsmr, &priv->uf_regs->upsmr);
067bb938dad61e5 Holger Brunck    2017-05-17  161  
067bb938dad61e5 Holger Brunck    2017-05-17  162  		/* explicitly disable CDS & CTSP */
067bb938dad61e5 Holger Brunck    2017-05-17  163  		gumr = ioread32be(&priv->uf_regs->gumr);
067bb938dad61e5 Holger Brunck    2017-05-17  164  		gumr &= ~(UCC_FAST_GUMR_CDS | UCC_FAST_GUMR_CTSP);
067bb938dad61e5 Holger Brunck    2017-05-17  165  		/* set automatic sync to explicitly ignore CD signal */
067bb938dad61e5 Holger Brunck    2017-05-17  166  		gumr |= UCC_FAST_GUMR_SYNL_AUTO;
067bb938dad61e5 Holger Brunck    2017-05-17  167  		iowrite32be(gumr, &priv->uf_regs->gumr);
067bb938dad61e5 Holger Brunck    2017-05-17  168  	}
067bb938dad61e5 Holger Brunck    2017-05-17  169  
c19b6d246a35627 Zhao Qiang       2016-06-06  170  	priv->rx_ring_size = RX_BD_RING_LEN;
c19b6d246a35627 Zhao Qiang       2016-06-06  171  	priv->tx_ring_size = TX_BD_RING_LEN;
c19b6d246a35627 Zhao Qiang       2016-06-06  172  	/* Alloc Rx BD */
c19b6d246a35627 Zhao Qiang       2016-06-06  173  	priv->rx_bd_base = dma_alloc_coherent(priv->dev,
5b8aad93c52bdda Holger Brunck    2017-05-17  174  			RX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a35627 Zhao Qiang       2016-06-06  175  			&priv->dma_rx_bd, GFP_KERNEL);
c19b6d246a35627 Zhao Qiang       2016-06-06  176  
c19b6d246a35627 Zhao Qiang       2016-06-06  177  	if (!priv->rx_bd_base) {
c19b6d246a35627 Zhao Qiang       2016-06-06  178  		dev_err(priv->dev, "Cannot allocate MURAM memory for RxBDs\n");
c19b6d246a35627 Zhao Qiang       2016-06-06  179  		ret = -ENOMEM;
1efb597d8bf56cb Zhao Qiang       2016-07-15  180  		goto free_uccf;
c19b6d246a35627 Zhao Qiang       2016-06-06  181  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  182  
c19b6d246a35627 Zhao Qiang       2016-06-06  183  	/* Alloc Tx BD */
c19b6d246a35627 Zhao Qiang       2016-06-06  184  	priv->tx_bd_base = dma_alloc_coherent(priv->dev,
5b8aad93c52bdda Holger Brunck    2017-05-17  185  			TX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a35627 Zhao Qiang       2016-06-06  186  			&priv->dma_tx_bd, GFP_KERNEL);
c19b6d246a35627 Zhao Qiang       2016-06-06  187  
c19b6d246a35627 Zhao Qiang       2016-06-06  188  	if (!priv->tx_bd_base) {
c19b6d246a35627 Zhao Qiang       2016-06-06  189  		dev_err(priv->dev, "Cannot allocate MURAM memory for TxBDs\n");
c19b6d246a35627 Zhao Qiang       2016-06-06  190  		ret = -ENOMEM;
1efb597d8bf56cb Zhao Qiang       2016-07-15  191  		goto free_rx_bd;
c19b6d246a35627 Zhao Qiang       2016-06-06  192  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  193  
c19b6d246a35627 Zhao Qiang       2016-06-06  194  	/* Alloc parameter ram for ucc hdlc */
85deed56032b6c9 Holger Brunck    2017-05-22  195  	priv->ucc_pram_offset = qe_muram_alloc(sizeof(struct ucc_hdlc_param),
c19b6d246a35627 Zhao Qiang       2016-06-06  196  				ALIGNMENT_OF_UCC_HDLC_PRAM);
c19b6d246a35627 Zhao Qiang       2016-06-06  197  
be2e9415f8b366a Rasmus Villemoes 2019-11-28  198  	if (priv->ucc_pram_offset < 0) {
24a24d07d688a46 Colin Ian King   2016-08-28  199  		dev_err(priv->dev, "Can not allocate MURAM for hdlc parameter.\n");
c19b6d246a35627 Zhao Qiang       2016-06-06  200  		ret = -ENOMEM;
1efb597d8bf56cb Zhao Qiang       2016-07-15  201  		goto free_tx_bd;
c19b6d246a35627 Zhao Qiang       2016-06-06  202  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  203  
6396bb221514d28 Kees Cook        2018-06-12  204  	priv->rx_skbuff = kcalloc(priv->rx_ring_size,
6396bb221514d28 Kees Cook        2018-06-12  205  				  sizeof(*priv->rx_skbuff),
c19b6d246a35627 Zhao Qiang       2016-06-06  206  				  GFP_KERNEL);
c19b6d246a35627 Zhao Qiang       2016-06-06  207  	if (!priv->rx_skbuff)
1efb597d8bf56cb Zhao Qiang       2016-07-15  208  		goto free_ucc_pram;
c19b6d246a35627 Zhao Qiang       2016-06-06  209  
6396bb221514d28 Kees Cook        2018-06-12  210  	priv->tx_skbuff = kcalloc(priv->tx_ring_size,
6396bb221514d28 Kees Cook        2018-06-12  211  				  sizeof(*priv->tx_skbuff),
c19b6d246a35627 Zhao Qiang       2016-06-06  212  				  GFP_KERNEL);
c19b6d246a35627 Zhao Qiang       2016-06-06  213  	if (!priv->tx_skbuff)
1efb597d8bf56cb Zhao Qiang       2016-07-15  214  		goto free_rx_skbuff;
c19b6d246a35627 Zhao Qiang       2016-06-06  215  
c19b6d246a35627 Zhao Qiang       2016-06-06  216  	priv->skb_curtx = 0;
c19b6d246a35627 Zhao Qiang       2016-06-06  217  	priv->skb_dirtytx = 0;
c19b6d246a35627 Zhao Qiang       2016-06-06  218  	priv->curtx_bd = priv->tx_bd_base;
c19b6d246a35627 Zhao Qiang       2016-06-06  219  	priv->dirty_tx = priv->tx_bd_base;
c19b6d246a35627 Zhao Qiang       2016-06-06  220  	priv->currx_bd = priv->rx_bd_base;
c19b6d246a35627 Zhao Qiang       2016-06-06  221  	priv->currx_bdnum = 0;
c19b6d246a35627 Zhao Qiang       2016-06-06  222  
c19b6d246a35627 Zhao Qiang       2016-06-06  223  	/* init parameter base */
c19b6d246a35627 Zhao Qiang       2016-06-06  224  	cecr_subblock = ucc_fast_get_qe_cr_subblock(uf_info->ucc_num);
c19b6d246a35627 Zhao Qiang       2016-06-06  225  	ret = qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, cecr_subblock,
c19b6d246a35627 Zhao Qiang       2016-06-06  226  			   QE_CR_PROTOCOL_UNSPECIFIED, priv->ucc_pram_offset);
c19b6d246a35627 Zhao Qiang       2016-06-06  227  
c19b6d246a35627 Zhao Qiang       2016-06-06  228  	priv->ucc_pram = (struct ucc_hdlc_param __iomem *)
c19b6d246a35627 Zhao Qiang       2016-06-06  229  					qe_muram_addr(priv->ucc_pram_offset);
c19b6d246a35627 Zhao Qiang       2016-06-06  230  
c19b6d246a35627 Zhao Qiang       2016-06-06  231  	/* Zero out parameter ram */
c19b6d246a35627 Zhao Qiang       2016-06-06  232  	memset_io(priv->ucc_pram, 0, sizeof(struct ucc_hdlc_param));
c19b6d246a35627 Zhao Qiang       2016-06-06  233  
c19b6d246a35627 Zhao Qiang       2016-06-06  234  	/* Alloc riptr, tiptr */
c19b6d246a35627 Zhao Qiang       2016-06-06  235  	riptr = qe_muram_alloc(32, 32);
be2e9415f8b366a Rasmus Villemoes 2019-11-28  236  	if (riptr < 0) {
c19b6d246a35627 Zhao Qiang       2016-06-06  237  		dev_err(priv->dev, "Cannot allocate MURAM mem for Receive internal temp data pointer\n");
c19b6d246a35627 Zhao Qiang       2016-06-06  238  		ret = -ENOMEM;
1efb597d8bf56cb Zhao Qiang       2016-07-15  239  		goto free_tx_skbuff;
c19b6d246a35627 Zhao Qiang       2016-06-06  240  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  241  
c19b6d246a35627 Zhao Qiang       2016-06-06  242  	tiptr = qe_muram_alloc(32, 32);
be2e9415f8b366a Rasmus Villemoes 2019-11-28  243  	if (tiptr < 0) {
c19b6d246a35627 Zhao Qiang       2016-06-06  244  		dev_err(priv->dev, "Cannot allocate MURAM mem for Transmit internal temp data pointer\n");
c19b6d246a35627 Zhao Qiang       2016-06-06  245  		ret = -ENOMEM;
1efb597d8bf56cb Zhao Qiang       2016-07-15  246  		goto free_riptr;
c19b6d246a35627 Zhao Qiang       2016-06-06  247  	}
148587a59f6b858 Rasmus Villemoes 2019-11-28  248  	if (riptr != (u16)riptr || tiptr != (u16)tiptr) {
148587a59f6b858 Rasmus Villemoes 2019-11-28  249  		dev_err(priv->dev, "MURAM allocation out of addressable range\n");
148587a59f6b858 Rasmus Villemoes 2019-11-28  250  		ret = -ENOMEM;
148587a59f6b858 Rasmus Villemoes 2019-11-28  251  		goto free_tiptr;
148587a59f6b858 Rasmus Villemoes 2019-11-28  252  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  253  
c19b6d246a35627 Zhao Qiang       2016-06-06  254  	/* Set RIPTR, TIPTR */
c19b6d246a35627 Zhao Qiang       2016-06-06  255  	iowrite16be(riptr, &priv->ucc_pram->riptr);
c19b6d246a35627 Zhao Qiang       2016-06-06  256  	iowrite16be(tiptr, &priv->ucc_pram->tiptr);
c19b6d246a35627 Zhao Qiang       2016-06-06  257  
c19b6d246a35627 Zhao Qiang       2016-06-06  258  	/* Set MRBLR */
c19b6d246a35627 Zhao Qiang       2016-06-06  259  	iowrite16be(MAX_RX_BUF_LENGTH, &priv->ucc_pram->mrblr);
c19b6d246a35627 Zhao Qiang       2016-06-06  260  
c19b6d246a35627 Zhao Qiang       2016-06-06  261  	/* Set RBASE, TBASE */
c19b6d246a35627 Zhao Qiang       2016-06-06  262  	iowrite32be(priv->dma_rx_bd, &priv->ucc_pram->rbase);
c19b6d246a35627 Zhao Qiang       2016-06-06  263  	iowrite32be(priv->dma_tx_bd, &priv->ucc_pram->tbase);
c19b6d246a35627 Zhao Qiang       2016-06-06  264  
c19b6d246a35627 Zhao Qiang       2016-06-06  265  	/* Set RSTATE, TSTATE */
c19b6d246a35627 Zhao Qiang       2016-06-06  266  	iowrite32be(BMR_GBL | BMR_BIG_ENDIAN, &priv->ucc_pram->rstate);
c19b6d246a35627 Zhao Qiang       2016-06-06  267  	iowrite32be(BMR_GBL | BMR_BIG_ENDIAN, &priv->ucc_pram->tstate);
c19b6d246a35627 Zhao Qiang       2016-06-06  268  
c19b6d246a35627 Zhao Qiang       2016-06-06  269  	/* Set C_MASK, C_PRES for 16bit CRC */
c19b6d246a35627 Zhao Qiang       2016-06-06  270  	iowrite32be(CRC_16BIT_MASK, &priv->ucc_pram->c_mask);
c19b6d246a35627 Zhao Qiang       2016-06-06  271  	iowrite32be(CRC_16BIT_PRES, &priv->ucc_pram->c_pres);
c19b6d246a35627 Zhao Qiang       2016-06-06  272  
c19b6d246a35627 Zhao Qiang       2016-06-06  273  	iowrite16be(MAX_FRAME_LENGTH, &priv->ucc_pram->mflr);
c19b6d246a35627 Zhao Qiang       2016-06-06  274  	iowrite16be(DEFAULT_RFTHR, &priv->ucc_pram->rfthr);
c19b6d246a35627 Zhao Qiang       2016-06-06  275  	iowrite16be(DEFAULT_RFTHR, &priv->ucc_pram->rfcnt);
045f77baf6b429a David Gounaris   2018-09-03  276  	iowrite16be(priv->hmask, &priv->ucc_pram->hmask);
c19b6d246a35627 Zhao Qiang       2016-06-06  277  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr1);
c19b6d246a35627 Zhao Qiang       2016-06-06  278  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr2);
c19b6d246a35627 Zhao Qiang       2016-06-06  279  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr3);
c19b6d246a35627 Zhao Qiang       2016-06-06  280  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr4);
c19b6d246a35627 Zhao Qiang       2016-06-06  281  
c19b6d246a35627 Zhao Qiang       2016-06-06  282  	/* Get BD buffer */
750afb08ca71310 Luis Chamberlain 2019-01-04  283  	bd_buffer = dma_alloc_coherent(priv->dev,
750afb08ca71310 Luis Chamberlain 2019-01-04  284  				       (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
c19b6d246a35627 Zhao Qiang       2016-06-06  285  				       &bd_dma_addr, GFP_KERNEL);
c19b6d246a35627 Zhao Qiang       2016-06-06  286  
c19b6d246a35627 Zhao Qiang       2016-06-06  287  	if (!bd_buffer) {
c19b6d246a35627 Zhao Qiang       2016-06-06  288  		dev_err(priv->dev, "Could not allocate buffer descriptors\n");
c19b6d246a35627 Zhao Qiang       2016-06-06  289  		ret = -ENOMEM;
1efb597d8bf56cb Zhao Qiang       2016-07-15  290  		goto free_tiptr;
c19b6d246a35627 Zhao Qiang       2016-06-06  291  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  292  
c19b6d246a35627 Zhao Qiang       2016-06-06  293  	priv->rx_buffer = bd_buffer;
c19b6d246a35627 Zhao Qiang       2016-06-06  294  	priv->tx_buffer = bd_buffer + RX_BD_RING_LEN * MAX_RX_BUF_LENGTH;
c19b6d246a35627 Zhao Qiang       2016-06-06  295  
c19b6d246a35627 Zhao Qiang       2016-06-06  296  	priv->dma_rx_addr = bd_dma_addr;
c19b6d246a35627 Zhao Qiang       2016-06-06  297  	priv->dma_tx_addr = bd_dma_addr + RX_BD_RING_LEN * MAX_RX_BUF_LENGTH;
c19b6d246a35627 Zhao Qiang       2016-06-06  298  
c19b6d246a35627 Zhao Qiang       2016-06-06  299  	for (i = 0; i < RX_BD_RING_LEN; i++) {
c19b6d246a35627 Zhao Qiang       2016-06-06  300  		if (i < (RX_BD_RING_LEN - 1))
c19b6d246a35627 Zhao Qiang       2016-06-06  301  			bd_status = R_E_S | R_I_S;
c19b6d246a35627 Zhao Qiang       2016-06-06  302  		else
c19b6d246a35627 Zhao Qiang       2016-06-06  303  			bd_status = R_E_S | R_I_S | R_W_S;
c19b6d246a35627 Zhao Qiang       2016-06-06  304  
c19b6d246a35627 Zhao Qiang       2016-06-06 @305  		iowrite16be(bd_status, &priv->rx_bd_base[i].status);
c19b6d246a35627 Zhao Qiang       2016-06-06  306  		iowrite32be(priv->dma_rx_addr + i * MAX_RX_BUF_LENGTH,
c19b6d246a35627 Zhao Qiang       2016-06-06  307  			    &priv->rx_bd_base[i].buf);
c19b6d246a35627 Zhao Qiang       2016-06-06  308  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  309  
c19b6d246a35627 Zhao Qiang       2016-06-06  310  	for (i = 0; i < TX_BD_RING_LEN; i++) {
c19b6d246a35627 Zhao Qiang       2016-06-06  311  		if (i < (TX_BD_RING_LEN - 1))
c19b6d246a35627 Zhao Qiang       2016-06-06  312  			bd_status =  T_I_S | T_TC_S;
c19b6d246a35627 Zhao Qiang       2016-06-06  313  		else
c19b6d246a35627 Zhao Qiang       2016-06-06  314  			bd_status =  T_I_S | T_TC_S | T_W_S;
c19b6d246a35627 Zhao Qiang       2016-06-06  315  
c19b6d246a35627 Zhao Qiang       2016-06-06  316  		iowrite16be(bd_status, &priv->tx_bd_base[i].status);
c19b6d246a35627 Zhao Qiang       2016-06-06  317  		iowrite32be(priv->dma_tx_addr + i * MAX_RX_BUF_LENGTH,
c19b6d246a35627 Zhao Qiang       2016-06-06  318  			    &priv->tx_bd_base[i].buf);
c19b6d246a35627 Zhao Qiang       2016-06-06  319  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  320  
c19b6d246a35627 Zhao Qiang       2016-06-06  321  	return 0;
c19b6d246a35627 Zhao Qiang       2016-06-06  322  
1efb597d8bf56cb Zhao Qiang       2016-07-15  323  free_tiptr:
c19b6d246a35627 Zhao Qiang       2016-06-06  324  	qe_muram_free(tiptr);
1efb597d8bf56cb Zhao Qiang       2016-07-15  325  free_riptr:
c19b6d246a35627 Zhao Qiang       2016-06-06  326  	qe_muram_free(riptr);
1efb597d8bf56cb Zhao Qiang       2016-07-15  327  free_tx_skbuff:
c19b6d246a35627 Zhao Qiang       2016-06-06  328  	kfree(priv->tx_skbuff);
1efb597d8bf56cb Zhao Qiang       2016-07-15  329  free_rx_skbuff:
c19b6d246a35627 Zhao Qiang       2016-06-06  330  	kfree(priv->rx_skbuff);
1efb597d8bf56cb Zhao Qiang       2016-07-15  331  free_ucc_pram:
c19b6d246a35627 Zhao Qiang       2016-06-06  332  	qe_muram_free(priv->ucc_pram_offset);
1efb597d8bf56cb Zhao Qiang       2016-07-15  333  free_tx_bd:
c19b6d246a35627 Zhao Qiang       2016-06-06  334  	dma_free_coherent(priv->dev,
5b8aad93c52bdda Holger Brunck    2017-05-17  335  			  TX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a35627 Zhao Qiang       2016-06-06  336  			  priv->tx_bd_base, priv->dma_tx_bd);
1efb597d8bf56cb Zhao Qiang       2016-07-15  337  free_rx_bd:
c19b6d246a35627 Zhao Qiang       2016-06-06  338  	dma_free_coherent(priv->dev,
5b8aad93c52bdda Holger Brunck    2017-05-17  339  			  RX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a35627 Zhao Qiang       2016-06-06  340  			  priv->rx_bd_base, priv->dma_rx_bd);
1efb597d8bf56cb Zhao Qiang       2016-07-15  341  free_uccf:
c19b6d246a35627 Zhao Qiang       2016-06-06  342  	ucc_fast_free(priv->uccf);
c19b6d246a35627 Zhao Qiang       2016-06-06  343  
c19b6d246a35627 Zhao Qiang       2016-06-06  344  	return ret;
c19b6d246a35627 Zhao Qiang       2016-06-06  345  }
c19b6d246a35627 Zhao Qiang       2016-06-06  346  

:::::: The code at line 305 was first introduced by commit
:::::: c19b6d246a35627c3a69b2fa6bdece212b48214b drivers/net: support hdlc function for QE-UCC

:::::: TO: Zhao Qiang <qiang.zhao@nxp.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ibTvN161/egqYuK8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ibTvN161/egqYuK8--
