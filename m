Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE2844B913
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbhKIW6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 17:58:41 -0500
Received: from mx4.wp.pl ([212.77.101.11]:7638 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242206AbhKIW6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 17:58:35 -0500
Received: (wp-smtpd smtp.wp.pl 20918 invoked from network); 9 Nov 2021 23:29:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1636496946; bh=9zLg6lVT8X5HeHS/AAtjuW/PCf3Zd1CgETFf5MZQb68=;
          h=Subject:To:Cc:From;
          b=T6cTMrLk6e3UqtFl2Ki1JzhKePgjx7znJTTY2IrcTZyaLOlU6lt4efatWZRf//Lgf
           HN1ftTW/gpmgcL/iLruDt3a17GUm/9xWvnJ3/rnOthsdk0bGaUFF4dwrdMCKrRBS2B
           R76WqZ9DglEOGzAV5joCXxqPLqo7ZOoRZbHfXoyU=
Received: from riviera.nat.ds.pw.edu.pl (HELO [192.168.3.133]) (olek2@wp.pl@[194.29.137.1])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-kernel@vger.kernel.org>; 9 Nov 2021 23:29:06 +0100
Subject: Re: drivers/net/ethernet/lantiq_etop.c:265:62: error: 'rx_burst_len'
 undeclared
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202111090621.yjr9xuVj-lkp@intel.com>
 <f0d24e5e-19a3-3606-7259-ccbef304f22b@infradead.org>
From:   Aleksander Bajkowski <olek2@wp.pl>
Message-ID: <13c7af7b-1ed1-4886-f816-9eba0942d407@wp.pl>
Date:   Tue, 9 Nov 2021 23:29:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f0d24e5e-19a3-3606-7259-ccbef304f22b@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-WP-MailID: 93bd93666d50c8c84156891fe82d8a41
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000C [kSME]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/21 8:21 PM, Randy Dunlap wrote:
> On 11/8/21 2:29 PM, kernel test robot wrote:
>> Hi Aleksander,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   d2f38a3c6507b2520101f9a3807ed98f1bdc545a
>> commit: 14d4e308e0aa0b78dc7a059716861a4380de3535 net: lantiq: configure the burst length in ethernet drivers
>> date:   8 weeks ago
>> config: mips-xway_defconfig (attached as .config)
>> compiler: mips-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=14d4e308e0aa0b78dc7a059716861a4380de3535
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 14d4e308e0aa0b78dc7a059716861a4380de3535
>>          # save the attached .config to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     drivers/net/ethernet/lantiq_etop.c: In function 'ltq_etop_hw_init':
>>>> drivers/net/ethernet/lantiq_etop.c:265:62: error: 'rx_burst_len' undeclared (first use in this function)
>>       265 |         ltq_dma_init_port(DMA_PORT_ETOP, priv->tx_burst_len, rx_burst_len);
>>           |                                                              ^~~~~~~~~~~~
> 
>>>>>>>>>>>>>>>>>>>>                                                        priv->rx_burs_len);
> 
>>     drivers/net/ethernet/lantiq_etop.c:265:62: note: each undeclared identifier is reported only once for each function it appears in
>>     drivers/net/ethernet/lantiq_etop.c: In function 'ltq_etop_probe':
>>>> drivers/net/ethernet/lantiq_etop.c:673:15: error: implicit declaration of function 'device_property_read_u32' [-Werror=implicit-function-declaration]
>>       673 |         err = device_property_read_u32(&pdev->dev, "lantiq,tx-burst-length", &priv->tx_burst_len);
>>           |               ^~~~~~~~~~~~~~~~~~~~~~~~
>>     drivers/net/ethernet/lantiq_etop.c: At top level:
>>     drivers/net/ethernet/lantiq_etop.c:730:1: warning: no previous prototype for 'init_ltq_etop' [-Wmissing-prototypes]
>>       730 | init_ltq_etop(void)
>>           | ^~~~~~~~~~~~~
>>     drivers/net/ethernet/lantiq_etop.c: In function 'ltq_etop_hw_init':
>>     drivers/net/ethernet/lantiq_etop.c:276:25: warning: ignoring return value of 'request_irq' declared with attribute 'warn_unused_result' [-Wunused-result]
>>       276 |                         request_irq(irq, ltq_etop_dma_irq, 0, "etop_tx", priv);
>>           |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     drivers/net/ethernet/lantiq_etop.c:284:25: warning: ignoring return value of 'request_irq' declared with attribute 'warn_unused_result' [-Wunused-result]
>>       284 |                         request_irq(irq, ltq_etop_dma_irq, 0, "etop_rx", priv);
>>           |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     cc1: some warnings being treated as errors
> 
> Hi Aleksander,
> Are you taking care of this report from kernel test robot?
> If not, I can send a patch.
> 

Hi Randy,
I have already addressed this bug and sent a patch today. 

>>
>>
>> vim +/rx_burst_len +265 drivers/net/ethernet/lantiq_etop.c
>>
>>     236   
>>     237    static int
>>     238    ltq_etop_hw_init(struct net_device *dev)
>>     239    {
>>     240        struct ltq_etop_priv *priv = netdev_priv(dev);
>>     241        int i;
>>     242   
>>     243        ltq_pmu_enable(PMU_PPE);
>>     244   
>>     245        switch (priv->pldata->mii_mode) {
>>     246        case PHY_INTERFACE_MODE_RMII:
>>     247            ltq_etop_w32_mask(ETOP_MII_MASK,
>>     248                ETOP_MII_REVERSE, LTQ_ETOP_CFG);
>>     249            break;
>>     250   
>>     251        case PHY_INTERFACE_MODE_MII:
>>     252            ltq_etop_w32_mask(ETOP_MII_MASK,
>>     253                ETOP_MII_NORMAL, LTQ_ETOP_CFG);
>>     254            break;
>>     255   
>>     256        default:
>>     257            netdev_err(dev, "unknown mii mode %d\n",
>>     258                priv->pldata->mii_mode);
>>     259            return -ENOTSUPP;
>>     260        }
>>     261   
>>     262        /* enable crc generation */
>>     263        ltq_etop_w32(PPE32_CGEN, LQ_PPE32_ENET_MAC_CFG);
>>     264   
>>   > 265        ltq_dma_init_port(DMA_PORT_ETOP, priv->tx_burst_len, rx_burst_len);
>>     266   
>>     267        for (i = 0; i < MAX_DMA_CHAN; i++) {
>>     268            int irq = LTQ_DMA_CH0_INT + i;
>>     269            struct ltq_etop_chan *ch = &priv->ch[i];
>>     270   
>>     271            ch->idx = ch->dma.nr = i;
>>     272            ch->dma.dev = &priv->pdev->dev;
>>     273   
>>     274            if (IS_TX(i)) {
>>     275                ltq_dma_alloc_tx(&ch->dma);
>>     276                request_irq(irq, ltq_etop_dma_irq, 0, "etop_tx", priv);
>>     277            } else if (IS_RX(i)) {
>>     278                ltq_dma_alloc_rx(&ch->dma);
>>     279                for (ch->dma.desc = 0; ch->dma.desc < LTQ_DESC_NUM;
>>     280                        ch->dma.desc++)
>>     281                    if (ltq_etop_alloc_skb(ch))
>>     282                        return -ENOMEM;
>>     283                ch->dma.desc = 0;
>>     284                request_irq(irq, ltq_etop_dma_irq, 0, "etop_rx", priv);
>>     285            }
>>     286            ch->dma.irq = irq;
>>     287        }
>>     288        return 0;
>>     289    }
>>     290   
>>
>> ---
> 
> 
