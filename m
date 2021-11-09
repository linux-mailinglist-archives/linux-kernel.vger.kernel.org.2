Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A380344B321
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 20:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243091AbhKITYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 14:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbhKITYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:24:18 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4DBC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 11:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=NovNJYCaWpgGz9EEw+32EzKJ/V8I3cZjDAmaUUJefrE=; b=BOx7lDdyb5Iyl+3g/pM+lCxra1
        hDhgSY/fGABrRS/r2IHj4Nd113rF5k1O+c7XURBQB7TNTmCB7cf0HWEleEDk34PMu5gusjN2HjVl1
        E/1VdjFgG2ZlCgOAixQm/5tWxeduSREG55ehYQ8BaQ3LdIvfx/dZ2NNhS8MVEQApnekzyWkyT7wvQ
        Ton4toVS3XPqn+fRkbTqRLgdWOY9D49Q9g5Tmi53bx6bKlNGV9gAlAnyt/xIdRYIkrbPAHPj+kzBH
        IpeBIP7AvlpNnezVpe0duIe8Ym29tuTgMj7x4L8vdQZSJhfdQvGow3Og6wbmXrSptgFM40U2xn3/D
        JBlniiIQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by merlin.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkWgT-008oii-T5; Tue, 09 Nov 2021 19:21:30 +0000
Subject: Re: drivers/net/ethernet/lantiq_etop.c:265:62: error: 'rx_burst_len'
 undeclared
To:     kernel test robot <lkp@intel.com>,
        Aleksander Jan Bajkowski <olek2@wp.pl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202111090621.yjr9xuVj-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f0d24e5e-19a3-3606-7259-ccbef304f22b@infradead.org>
Date:   Tue, 9 Nov 2021 11:21:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <202111090621.yjr9xuVj-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/21 2:29 PM, kernel test robot wrote:
> Hi Aleksander,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d2f38a3c6507b2520101f9a3807ed98f1bdc545a
> commit: 14d4e308e0aa0b78dc7a059716861a4380de3535 net: lantiq: configure the burst length in ethernet drivers
> date:   8 weeks ago
> config: mips-xway_defconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=14d4e308e0aa0b78dc7a059716861a4380de3535
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 14d4e308e0aa0b78dc7a059716861a4380de3535
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/net/ethernet/lantiq_etop.c: In function 'ltq_etop_hw_init':
>>> drivers/net/ethernet/lantiq_etop.c:265:62: error: 'rx_burst_len' undeclared (first use in this function)
>       265 |         ltq_dma_init_port(DMA_PORT_ETOP, priv->tx_burst_len, rx_burst_len);
>           |                                                              ^~~~~~~~~~~~

>>>>>>>>>>>>>>>>>>>                                                        priv->rx_burs_len);

>     drivers/net/ethernet/lantiq_etop.c:265:62: note: each undeclared identifier is reported only once for each function it appears in
>     drivers/net/ethernet/lantiq_etop.c: In function 'ltq_etop_probe':
>>> drivers/net/ethernet/lantiq_etop.c:673:15: error: implicit declaration of function 'device_property_read_u32' [-Werror=implicit-function-declaration]
>       673 |         err = device_property_read_u32(&pdev->dev, "lantiq,tx-burst-length", &priv->tx_burst_len);
>           |               ^~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/net/ethernet/lantiq_etop.c: At top level:
>     drivers/net/ethernet/lantiq_etop.c:730:1: warning: no previous prototype for 'init_ltq_etop' [-Wmissing-prototypes]
>       730 | init_ltq_etop(void)
>           | ^~~~~~~~~~~~~
>     drivers/net/ethernet/lantiq_etop.c: In function 'ltq_etop_hw_init':
>     drivers/net/ethernet/lantiq_etop.c:276:25: warning: ignoring return value of 'request_irq' declared with attribute 'warn_unused_result' [-Wunused-result]
>       276 |                         request_irq(irq, ltq_etop_dma_irq, 0, "etop_tx", priv);
>           |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/net/ethernet/lantiq_etop.c:284:25: warning: ignoring return value of 'request_irq' declared with attribute 'warn_unused_result' [-Wunused-result]
>       284 |                         request_irq(irq, ltq_etop_dma_irq, 0, "etop_rx", priv);
>           |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors

Hi Aleksander,
Are you taking care of this report from kernel test robot?
If not, I can send a patch.

> 
> 
> vim +/rx_burst_len +265 drivers/net/ethernet/lantiq_etop.c
> 
>     236	
>     237	static int
>     238	ltq_etop_hw_init(struct net_device *dev)
>     239	{
>     240		struct ltq_etop_priv *priv = netdev_priv(dev);
>     241		int i;
>     242	
>     243		ltq_pmu_enable(PMU_PPE);
>     244	
>     245		switch (priv->pldata->mii_mode) {
>     246		case PHY_INTERFACE_MODE_RMII:
>     247			ltq_etop_w32_mask(ETOP_MII_MASK,
>     248				ETOP_MII_REVERSE, LTQ_ETOP_CFG);
>     249			break;
>     250	
>     251		case PHY_INTERFACE_MODE_MII:
>     252			ltq_etop_w32_mask(ETOP_MII_MASK,
>     253				ETOP_MII_NORMAL, LTQ_ETOP_CFG);
>     254			break;
>     255	
>     256		default:
>     257			netdev_err(dev, "unknown mii mode %d\n",
>     258				priv->pldata->mii_mode);
>     259			return -ENOTSUPP;
>     260		}
>     261	
>     262		/* enable crc generation */
>     263		ltq_etop_w32(PPE32_CGEN, LQ_PPE32_ENET_MAC_CFG);
>     264	
>   > 265		ltq_dma_init_port(DMA_PORT_ETOP, priv->tx_burst_len, rx_burst_len);
>     266	
>     267		for (i = 0; i < MAX_DMA_CHAN; i++) {
>     268			int irq = LTQ_DMA_CH0_INT + i;
>     269			struct ltq_etop_chan *ch = &priv->ch[i];
>     270	
>     271			ch->idx = ch->dma.nr = i;
>     272			ch->dma.dev = &priv->pdev->dev;
>     273	
>     274			if (IS_TX(i)) {
>     275				ltq_dma_alloc_tx(&ch->dma);
>     276				request_irq(irq, ltq_etop_dma_irq, 0, "etop_tx", priv);
>     277			} else if (IS_RX(i)) {
>     278				ltq_dma_alloc_rx(&ch->dma);
>     279				for (ch->dma.desc = 0; ch->dma.desc < LTQ_DESC_NUM;
>     280						ch->dma.desc++)
>     281					if (ltq_etop_alloc_skb(ch))
>     282						return -ENOMEM;
>     283				ch->dma.desc = 0;
>     284				request_irq(irq, ltq_etop_dma_irq, 0, "etop_rx", priv);
>     285			}
>     286			ch->dma.irq = irq;
>     287		}
>     288		return 0;
>     289	}
>     290	
> 
> ---


-- 
~Randy
