Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D74449EAB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 23:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240531AbhKHWch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 17:32:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:65458 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239746AbhKHWcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 17:32:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="232284034"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="gz'50?scan'50,208,50";a="232284034"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 14:29:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="gz'50?scan'50,208,50";a="669180459"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Nov 2021 14:29:49 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mkD9A-000Cfp-7n; Mon, 08 Nov 2021 22:29:48 +0000
Date:   Tue, 9 Nov 2021 06:29:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aleksander Jan Bajkowski <olek2@wp.pl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/lantiq_etop.c:265:62: error: 'rx_burst_len'
 undeclared
Message-ID: <202111090621.yjr9xuVj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Aleksander,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f38a3c6507b2520101f9a3807ed98f1bdc545a
commit: 14d4e308e0aa0b78dc7a059716861a4380de3535 net: lantiq: configure the burst length in ethernet drivers
date:   8 weeks ago
config: mips-xway_defconfig (attached as .config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=14d4e308e0aa0b78dc7a059716861a4380de3535
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 14d4e308e0aa0b78dc7a059716861a4380de3535
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/lantiq_etop.c: In function 'ltq_etop_hw_init':
>> drivers/net/ethernet/lantiq_etop.c:265:62: error: 'rx_burst_len' undeclared (first use in this function)
     265 |         ltq_dma_init_port(DMA_PORT_ETOP, priv->tx_burst_len, rx_burst_len);
         |                                                              ^~~~~~~~~~~~
   drivers/net/ethernet/lantiq_etop.c:265:62: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/lantiq_etop.c: In function 'ltq_etop_probe':
>> drivers/net/ethernet/lantiq_etop.c:673:15: error: implicit declaration of function 'device_property_read_u32' [-Werror=implicit-function-declaration]
     673 |         err = device_property_read_u32(&pdev->dev, "lantiq,tx-burst-length", &priv->tx_burst_len);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/lantiq_etop.c: At top level:
   drivers/net/ethernet/lantiq_etop.c:730:1: warning: no previous prototype for 'init_ltq_etop' [-Wmissing-prototypes]
     730 | init_ltq_etop(void)
         | ^~~~~~~~~~~~~
   drivers/net/ethernet/lantiq_etop.c: In function 'ltq_etop_hw_init':
   drivers/net/ethernet/lantiq_etop.c:276:25: warning: ignoring return value of 'request_irq' declared with attribute 'warn_unused_result' [-Wunused-result]
     276 |                         request_irq(irq, ltq_etop_dma_irq, 0, "etop_tx", priv);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/lantiq_etop.c:284:25: warning: ignoring return value of 'request_irq' declared with attribute 'warn_unused_result' [-Wunused-result]
     284 |                         request_irq(irq, ltq_etop_dma_irq, 0, "etop_rx", priv);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/rx_burst_len +265 drivers/net/ethernet/lantiq_etop.c

   236	
   237	static int
   238	ltq_etop_hw_init(struct net_device *dev)
   239	{
   240		struct ltq_etop_priv *priv = netdev_priv(dev);
   241		int i;
   242	
   243		ltq_pmu_enable(PMU_PPE);
   244	
   245		switch (priv->pldata->mii_mode) {
   246		case PHY_INTERFACE_MODE_RMII:
   247			ltq_etop_w32_mask(ETOP_MII_MASK,
   248				ETOP_MII_REVERSE, LTQ_ETOP_CFG);
   249			break;
   250	
   251		case PHY_INTERFACE_MODE_MII:
   252			ltq_etop_w32_mask(ETOP_MII_MASK,
   253				ETOP_MII_NORMAL, LTQ_ETOP_CFG);
   254			break;
   255	
   256		default:
   257			netdev_err(dev, "unknown mii mode %d\n",
   258				priv->pldata->mii_mode);
   259			return -ENOTSUPP;
   260		}
   261	
   262		/* enable crc generation */
   263		ltq_etop_w32(PPE32_CGEN, LQ_PPE32_ENET_MAC_CFG);
   264	
 > 265		ltq_dma_init_port(DMA_PORT_ETOP, priv->tx_burst_len, rx_burst_len);
   266	
   267		for (i = 0; i < MAX_DMA_CHAN; i++) {
   268			int irq = LTQ_DMA_CH0_INT + i;
   269			struct ltq_etop_chan *ch = &priv->ch[i];
   270	
   271			ch->idx = ch->dma.nr = i;
   272			ch->dma.dev = &priv->pdev->dev;
   273	
   274			if (IS_TX(i)) {
   275				ltq_dma_alloc_tx(&ch->dma);
   276				request_irq(irq, ltq_etop_dma_irq, 0, "etop_tx", priv);
   277			} else if (IS_RX(i)) {
   278				ltq_dma_alloc_rx(&ch->dma);
   279				for (ch->dma.desc = 0; ch->dma.desc < LTQ_DESC_NUM;
   280						ch->dma.desc++)
   281					if (ltq_etop_alloc_skb(ch))
   282						return -ENOMEM;
   283				ch->dma.desc = 0;
   284				request_irq(irq, ltq_etop_dma_irq, 0, "etop_rx", priv);
   285			}
   286			ch->dma.irq = irq;
   287		}
   288		return 0;
   289	}
   290	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--oyUTqETQ0mS9luUI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--oyUTqETQ0mS9luUI--
