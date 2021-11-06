Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2640D446BA3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 01:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhKFArE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 20:47:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:23469 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232396AbhKFArD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 20:47:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="292839074"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="gz'50?scan'50,208,50";a="292839074"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 17:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="gz'50?scan'50,208,50";a="586586862"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 05 Nov 2021 17:44:19 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mj9og-0008RG-WF; Sat, 06 Nov 2021 00:44:19 +0000
Date:   Sat, 6 Nov 2021 08:43:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [dborkman-bpf:pr/bpf-tstamp 3/3]
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:2482:44: warning: shift
 count >= width of type
Message-ID: <202111060804.OP5qAfyw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git pr/bpf-tstamp
head:   f7d619a946e981177777983af26e9e31163ffb38
commit: f7d619a946e981177777983af26e9e31163ffb38 [3/3] net: skb clock bases
config: i386-randconfig-a005-20210928 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git/commit/?id=f7d619a946e981177777983af26e9e31163ffb38
        git remote add dborkman-bpf https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git
        git fetch --no-tags dborkman-bpf pr/bpf-tstamp
        git checkout f7d619a946e981177777983af26e9e31163ffb38
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:9:
   In file included from drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h:22:
   include/net/tcp.h:812:27: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
           return tcp_ns_to_ts(skb->skb_mstamp_ns);
                               ~~~  ^
   include/net/tcp.h:818:22: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
           return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
                          ~~~  ^
   include/net/tcp.h:2367:8: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
                   skb->skb_mstamp_ns += (u64)tp->tcp_tx_delay * NSEC_PER_USEC;
                   ~~~  ^
>> drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:2482:44: warning: shift count >= width of type [-Wshift-count-overflow]
           if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
                                                     ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning and 3 errors generated.
--
   In file included from drivers/net/ethernet/emulex/benet/be_main.c:16:
   In file included from drivers/net/ethernet/emulex/benet/be.h:20:
   include/net/tcp.h:812:27: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
           return tcp_ns_to_ts(skb->skb_mstamp_ns);
                               ~~~  ^
   include/net/tcp.h:818:22: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
           return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
                          ~~~  ^
   include/net/tcp.h:2367:8: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
                   skb->skb_mstamp_ns += (u64)tp->tcp_tx_delay * NSEC_PER_USEC;
                   ~~~  ^
>> drivers/net/ethernet/emulex/benet/be_main.c:5843:49: warning: shift count >= width of type [-Wshift-count-overflow]
           status = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
                                                          ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning and 3 errors generated.


vim +2482 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c

77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2470  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2471  static int pch_gbe_probe(struct pci_dev *pdev,
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2472  			  const struct pci_device_id *pci_id)
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2473  {
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2474  	struct net_device *netdev;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2475  	struct pch_gbe_adapter *adapter;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2476  	int ret;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2477  
29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2478  	ret = pcim_enable_device(pdev);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2479  	if (ret)
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2480  		return ret;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2481  
8ff39301efd9d21 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Christophe JAILLET 2020-11-21 @2482  	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
8ff39301efd9d21 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Christophe JAILLET 2020-11-21  2483  		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2484  		if (ret) {
8ff39301efd9d21 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Christophe JAILLET 2020-11-21  2485  			dev_err(&pdev->dev, "ERR: No usable DMA configuration, aborting\n");
29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2486  			return ret;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2487  		}
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2488  	}
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2489  
29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2490  	ret = pcim_iomap_regions(pdev, 1 << PCH_GBE_PCI_BAR, pci_name(pdev));
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2491  	if (ret) {
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2492  		dev_err(&pdev->dev,
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2493  			"ERR: Can't reserve PCI I/O and memory resources\n");
29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2494  		return ret;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2495  	}
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2496  	pci_set_master(pdev);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2497  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2498  	netdev = alloc_etherdev((int)sizeof(struct pch_gbe_adapter));
29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2499  	if (!netdev)
29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2500  		return -ENOMEM;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2501  	SET_NETDEV_DEV(netdev, &pdev->dev);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2502  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2503  	pci_set_drvdata(pdev, netdev);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2504  	adapter = netdev_priv(netdev);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2505  	adapter->netdev = netdev;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2506  	adapter->pdev = pdev;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2507  	adapter->hw.back = adapter;
29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2508  	adapter->hw.reg = pcim_iomap_table(pdev)[PCH_GBE_PCI_BAR];
9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2021-05-10  2509  
f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2013-05-18  2510  	adapter->pdata = (struct pch_gbe_privdata *)pci_id->driver_data;
9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2021-05-10  2511  	if (adapter->pdata && adapter->pdata->platform_init) {
9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2021-05-10  2512  		ret = adapter->pdata->platform_init(pdev);
9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2021-05-10  2513  		if (ret)
9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2021-05-10  2514  			goto err_free_netdev;
9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2021-05-10  2515  	}
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2516  
2e1c8725bb834f1 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Sinan Kaya         2017-12-19  2517  	adapter->ptp_pdev =
2e1c8725bb834f1 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Sinan Kaya         2017-12-19  2518  		pci_get_domain_bus_and_slot(pci_domain_nr(adapter->pdev->bus),
2e1c8725bb834f1 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Sinan Kaya         2017-12-19  2519  					    adapter->pdev->bus->number,
1a0bdadb4e36aba drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Takahiroi Shimizu  2012-03-07  2520  					    PCI_DEVFN(12, 4));
1a0bdadb4e36aba drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Takahiroi Shimizu  2012-03-07  2521  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2522  	netdev->netdev_ops = &pch_gbe_netdev_ops;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2523  	netdev->watchdog_timeo = PCH_GBE_WATCHDOG_PERIOD;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2524  	netif_napi_add(netdev, &adapter->napi,
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2525  		       pch_gbe_napi_poll, PCH_GBE_RX_WEIGHT);
756a6b03da98903 drivers/net/pch_gbe/pch_gbe_main.c                   Michał Mirosław    2011-04-19  2526  	netdev->hw_features = NETIF_F_RXCSUM |
756a6b03da98903 drivers/net/pch_gbe/pch_gbe_main.c                   Michał Mirosław    2011-04-19  2527  		NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
756a6b03da98903 drivers/net/pch_gbe/pch_gbe_main.c                   Michał Mirosław    2011-04-19  2528  	netdev->features = netdev->hw_features;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2529  	pch_gbe_set_ethtool_ops(netdev);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2530  
44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jarod Wilson       2016-10-17  2531  	/* MTU range: 46 - 10300 */
44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jarod Wilson       2016-10-17  2532  	netdev->min_mtu = ETH_ZLEN - ETH_HLEN;
44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jarod Wilson       2016-10-17  2533  	netdev->max_mtu = PCH_GBE_MAX_JUMBO_FRAME_SIZE -
44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jarod Wilson       2016-10-17  2534  			  (ETH_HLEN + ETH_FCS_LEN);
44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jarod Wilson       2016-10-17  2535  
98200ec28a66c8d drivers/net/pch_gbe/pch_gbe_main.c                   Toshiharu Okada    2011-02-13  2536  	pch_gbe_mac_load_mac_addr(&adapter->hw);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2537  	pch_gbe_mac_reset_hw(&adapter->hw);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2538  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2539  	/* setup the private structure */
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2540  	ret = pch_gbe_sw_init(adapter);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2541  	if (ret)
29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2542  		goto err_free_netdev;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2543  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2544  	/* Initialize PHY */
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2545  	ret = pch_gbe_init_phy(adapter);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2546  	if (ret) {
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2547  		dev_err(&pdev->dev, "PHY initialize error\n");
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2548  		goto err_free_adapter;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2549  	}
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2550  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2551  	/* Read the MAC address. and store to the private data */
9c020d7b0525d3b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Paul Burton        2018-06-22  2552  	ret = pch_gbe_mac_read_mac_addr(&adapter->hw);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2553  	if (ret) {
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2554  		dev_err(&pdev->dev, "MAC address Read Error\n");
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2555  		goto err_free_adapter;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2556  	}
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2557  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2558  	memcpy(netdev->dev_addr, adapter->hw.mac.addr, netdev->addr_len);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2559  	if (!is_valid_ether_addr(netdev->dev_addr)) {
2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2560  		/*
2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2561  		 * If the MAC is invalid (or just missing), display a warning
2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2562  		 * but do not abort setting up the device. pch_gbe_up will
2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2563  		 * prevent the interface from being brought up until a valid MAC
2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2564  		 * is set.
2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2565  		 */
2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2566  		dev_err(&pdev->dev, "Invalid MAC address, "
2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2567  		                    "interface disabled.\n");
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2568  	}
e99e88a9d2b0674 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Kees Cook          2017-10-16  2569  	timer_setup(&adapter->watchdog_timer, pch_gbe_watchdog, 0);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2570  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2571  	INIT_WORK(&adapter->reset_task, pch_gbe_reset_task);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2572  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2573  	pch_gbe_check_options(adapter);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2574  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2575  	/* initialize the wol settings based on the eeprom settings */
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2576  	adapter->wake_up_evt = PCH_GBE_WL_INIT_SETTING;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2577  	dev_info(&pdev->dev, "MAC address : %pM\n", netdev->dev_addr);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2578  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2579  	/* reset the hardware with the new settings */
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2580  	pch_gbe_reset(adapter);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2581  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2582  	ret = register_netdev(netdev);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2583  	if (ret)
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2584  		goto err_free_adapter;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2585  	/* tell the stack to leave us alone until pch_gbe_open() is called */
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2586  	netif_carrier_off(netdev);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2587  	netif_stop_queue(netdev);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2588  
1a0bdadb4e36aba drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Takahiroi Shimizu  2012-03-07  2589  	dev_dbg(&pdev->dev, "PCH Network Connection\n");
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2590  
f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2013-05-18  2591  	/* Disable hibernation on certain platforms */
f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2013-05-18  2592  	if (adapter->pdata && adapter->pdata->phy_disable_hibernate)
f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2013-05-18  2593  		pch_gbe_phy_disable_hibernate(&adapter->hw);
f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2013-05-18  2594  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2595  	device_set_wakeup_enable(&pdev->dev, 1);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2596  	return 0;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2597  
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2598  err_free_adapter:
7dbe38aed0ba01e drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Paul Burton        2018-06-22  2599  	pch_gbe_phy_hw_reset(&adapter->hw);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2600  err_free_netdev:
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2601  	free_netdev(netdev);
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2602  	return ret;
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2603  }
77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2604  

:::::: The code at line 2482 was first introduced by commit
:::::: 8ff39301efd9d21cd62caad3504aa8d6e35d8304 net: pch_gbe: Use dma_set_mask_and_coherent to simplify code

:::::: TO: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--OXfL5xGRrasGEqWY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICGTJhWEAAy5jb25maWcAlDxdd9yoku/zK/pkXuY+zMR2O07O7vEDkpCaaSEUkPrDLxyP
08l4r2Nn2/bcyb/fKtAHINSZzUOSriqggKK+KPTzTz8vyOvL09fbl/u724eH74svh8fD8fbl
8Gnx+f7h8N+LTCwq0SxoxprfgLi8f3z9++398sPV4t1v55e/nS3Wh+Pj4WGRPj1+vv/yCk3v
nx5/+vmnVFQ5K3Sa6g2ViolKN3TXXL+5e7h9/LL463B8BroF9gB9/PLl/uW/3r6Fv7/eH49P
x7cPD3991d+OT/9zuHtZfLh8f3v14ez9cnnxx/ny8+Xy/dnl8uL93cWn5dn52fJwd7a8fH/3
/v2/3vSjFuOw12cOK0zptCRVcf19AOLPgfb88gz+9DiisEFRtSM5gHrai+W7s4seXmbT8QAG
zcsyG5uXDp0/FjCXkkqXrFo7zI1ArRrSsNTDrYAborguRCNmEVq0Td02I74RolRatXUtZKMl
LWW0LatgWDpBVULXUuSspDqvNGkapzWTH/VWSGcCScvKrGGc6oYk0ETBkA4nK0kJLFKVC/gL
SBQ2Bdn5eVEYKXxYPB9eXr+N0sQq1mhabTSRsJiMs+Z6eQHkPY+C18hZQ1WzuH9ePD69YA/D
6ouUlP3yv3kTA2vSumtp+NeKlI1DvyIbqtdUVrTUxQ2rR3IXkwDmIo4qbziJY3Y3cy3EHOIy
jrhRDcrdsDQOv+7KhHjDdWTpfM7DVrubU30C86fRl6fQOJEIQxnNSVs2RiKcvenBK6GainB6
/eaXx6fHw6gZ1JY4G6b2asPqdALAf9OmHOG1UGyn+ceWtjQOnTTZkiZd6aBFKoVSmlMu5B5P
D0lX7nq2ipYsiUyXtKB/g50mEvo3CByalM7YAdQcKTidi+fXP56/P78cvo5HqqAVlSw1hxdO
duIw66LUSmzjGJrnNG0YMpTnmttDHNDVtMpYZTREvBPOCgn6Dc5lFM2q33EMF70iMgMUaLIt
KDEFA8Sbpiv3hCIkE5ywyocpxmNEesWoxHXeTzvnisXn0yGi4xic4LydWQbSSJAo2DXQSY2Q
cSqcrtyY5dJcZNQfIhcypVmnXJlr61RNpKLzm5DRpC1yZQTy8Php8fQ5EJrRaIp0rUQLA1kx
z4QzjJFLl8Sc0e+xxhtSsow0VJdENTrdp2VE/Iz92ExkvEeb/uiGVo06idSJFCRLYaDTZBy2
nWS/t1E6LpRua2Q5OIxWFaR1a9iVylizwBr+Exoz2XWLdg6tWH94m/uv4DHFzi84BWstKgoH
1GEYzPTqBu0hN2dmUDAArGEmImNpRMvYVixzd8HAvC5YsUIR7Cbh6+5ObCbsDga1zoOFowDS
v7NhpvAzNk2kGkVgYKZrHJkLYtqqlmwzGAWR52HbGvwfkIroJHxOxnbQhvK6gZWpaNRy9QQb
UbZVQ+Q+wl5H4whH1ygV0GYC9lRfT5rtwcQZn3AYWqUrOPupkB5nZmFB7t42t8//XrzA5ixu
YY7PL7cvz4vbu7un18eX+8cvgVChoJLU8OOpEVQVRkxjSLOnlguyCRR+ojI0MSkFEwhtG28z
ApzeLKNri0cGXWEVX3nFolv5D+Y+qCeYNVOi7K2RWTuZtgsVOXuwERpw062xwIEv+KnpDk5e
TFKV14PpMwDhnE0fnR6KoCagNqMxeCNJGiCwY1jSshz1hYOpKGylokWalEw1rm3wF2WQjrX9
jyMv62FxhCesbL0CExXokMEpR+8bzvyK5c31xZkLxy3iZOfgzy/GDWBVA9ESyWnQx/nSk9G2
Ul1MYo8MWoB+u9Xdn4dPrw+H4+Lz4fbl9Xh4tieoc9IgZuS1Wc+osEVae6ZxS6pGJ2g2Ydy2
4gT6KhOdl61aOWaykKKtlbte4DamRVTuk3LdNYiiLcrO9BRBzbL4uerwMuPkFD4H2b2hMk5S
g3M7c2y75hndsDSuUjsK6ASVw8k5UJmfwqNWP4HmTKWneQQfKWY6IdgA/wr0l+fPgz9RxcTb
6M/Ko8WwI0oL6yYDWtioOG1Fm4AU9jxd1wJOBRrtJrAMgeHA6HdejMD+5gpWAJQceKc0FpaB
OSWOr4xyCbtqPEDpOOjmN+HQm3UEnQhOZn1QPWrPbDYuBZQfTQNgdxM0ngtADSoefAJqJvBM
hEAj7au4NNUCjDRnNxT9byOEQnJSpdTbi4BMwX9iui/TQtYrUoGqkI46DiNMq8dYdn4V0oCx
SanxGqzCD53VVNVr4BKMHLLpsjhrpYJxODhUDCXTGbqgDYZ/euKqW8GZgHOYoudrWgfZ+pWu
TUWVHv7WFWduosbZDVrmxgVymkwm3LcjEBDlrcdV29Bd8BMOnNN9LbzJsaIiZe5It5mACzCR
hQtQK9DlTsTEnPQOE7qVnk9Fsg1TtF8/Z2Wgk4RIydxdWCPJnqspRHuLP0DNEuC5xRg+SEZI
4zjnsXNgTBlmBEcmgMMqDVZ+nXIn/Ibw86MnbTyhWRbVJFZQgQM9xHbGCHfp5vpw/Px0/Hr7
eHdY0L8Oj+DMETC/KbpzEHqMPprfxTCy0eMWCfPUG25i7qg9/4cj9gNuuB3OevKeJKuyTezI
juoQvCbgD5ggcFS1JYmlgbCDkAw2QBa0D3LiihvJ0DijC6clnDrBo727ZJhgAXfTk9o2z8Fj
qgmMF8lRmOmhc1YT2TDiK4CGcg1xM8H8N8tZSsKYBpPKntgbzWUsl5eS8FPDPfHuw5VeOvlW
+O2aG9XI1iSQYJ1SkbkHxubHtdHXzfWbw8Pn5cWveMHhJojXYPX6nLkzrYaka+tRT3Bejscc
Fo6enqzAmDGbZrj+cApPdtfnV3GCXmZ+0I9H5nU3ZH0U0ZlrPnuEJ6K2V7LvjYfOs3TaBHQT
SyQmczLfCRg0BYoGKppdBAebD2dF1wUIQpjoBL/ROnY2JJXUYdiEJz3KqBPoSmIyadW6Vyke
nRHgKJnlhyVUVja/BiZJscQ1UoZEtQpzmnNo4+KbhSGlXrVgGMvEk02QVa1czdj1aoQIU0yY
iXU0Rw52kRJZ7lPM+bm2oy5sGFOC0gHbcGG1ZH18ujs8Pz8dFy/fv9mI1wllevF1GUCmckqa
VlLrzPooXpvkobPtosxyprz0taQN2EY2kxbBbqwIgIsiy4gCQoqEFRO+6K6BxcYNjHgsSNAz
MzsuKBFawlmJhz8jxceWyPUMZ5airJUKhyd8ZC0SxQyGXeWaJ8xz+jvYbFyB3cssXV6c78JR
QYQqkAZQQlUGunqmMVAxyTyWra8vOAOtB144Ji9xbjJmhfdwZsD7AGe1aKmbEgVxIBsmvSRO
D5vOZkqialaZTPAM36sNapQyAQ0LJiP1DM0abGzAjk061y0mL0FrlE3npI0Db+LSMTAUpLRi
ObuetE8WjJH55YcrtYv2j6g44t0JRDMThSKO812EOX5lLN5ICfoJPHTOWLyjAX0az09i48ET
X89MbP1+Bv4hDk9lq0RcmXCagxNBRRXHblmFFz/pDCMdehlXBxxs1Ey/BQXnodidn8DqckYQ
0r1ku9n13jCSLvXFPHJm7dDdnmkF3lnMzTMKM0wk9gpOVjiFlICK6PJmVy5JeT6Ps/oRo4ZU
1Hu/a/SxazBqNh2hWu6jQdx9AEQNu3RVXF2GYLEJ7BKrGG+5MSw54azc+0wZTQQRMVduoQIB
rYjGTnvxNNJv+G7ODOIQYKHtPKdgMAJT4GpfuF5uD07h+JBWThHgTFaKU3CTXWe2x96siNi5
V4qrmlrFJQMYhfgcXTHZOAubuRFzZVwhhdEAOEMJLaDfizgS71avLkNcF3BgAYaPcSDW0iju
+swGxNMpBAN74e+GKc3QpJ5IqogAJZXgy9vMSiLFmlY2WYO3xIHQuBmRDoDJ4pIWJN2Hdpab
K0zY85mzhHhv841LUKUMg8DYUOZuVq1EmU1R9qa7D3bdmPPr0+P9y9PR3tOM5msMb/sDWIXX
P7OkktRujcMEn+JNi5cTcGmM1yO2Ub8hpLNMuWHczNS83TfbAUfSjeX8X0h2fpW498vGYVQ1
eMzmCPlOnqhL/IvKmGJsBGi1xCtwYR/mvEFJUbhglDBJz1IpMMSc9TRBFc30afwXt7NK4G0r
+Psx18xiLgu3QQe8uoz7L3CYRZ5DPHV99nd6Zv8E/QUKtya28kw1LHVOkXG3clAx0AL0A4lE
SCZemEfTEuS8r4TBKgZHElmJW1/2fimWCbT0+syfZt3EhNwwjTYGAgmhMBkl2/761NsF3D10
6HjPw0hqO4j5WI2U3l7Db61IxRp2Ez0GOBCE4MHcwRgqiNvwUKAtzQK0zc/4+6A4CWIicN3q
iXibU9uonVlQ3OofhDsjaTXDfUDXlceNCbw87s6sbvT52dkc6uLdWUygb/Ty7MyTZtNLnPZ6
OYrumu6oWxopiVrprOXeAhki/TtAY0djtVcMbQ0Iu8TTce4fDiwTSEnjC7LdKEzmYw7V3x6T
bzCt3Ex2PwopWVHBKBf+CQSJLFtj7sc2o5w6aG+VbCrTxcYvsGw2aJOp+G1IyjMM3XHAmKWD
7Wf5XpdZ49Vh9Nr8RL7BTyOtajxwmKKymQw8eoOGsEbv6T+H4wIsw+2Xw9fD44vpjaQ1Wzx9
w+JiJ4MxSdfYC2XHt7B5mgmgv6p03KauFzqEnWqKDPSIO7KqSI01OBj/xwSMg2hlNjPa+PWn
iCopdc53D+kyNKP15eYAGlw8mOV6S9Z0Lq6uuTdGn4n2+s82eGuVzSYkgAYLk6YrOzAd67Yr
O2hiVUeATksnB7f9aN0KbUI840X1vqareSCAKTrLMXc9MeTTUHocLTv51bsa5oArcDvFug2T
cxxsTtNVXmKT2k2CGkiX5bbMG9dJTfPChtIsUeGKnwfW3cXaMFnbfZ1Ky2FsvoaiEyO/naQb
LTZUSpbRIWE51wWoSLcM0EWR2OYZTEIaMNP7YDZJ2zRu8GOAG2BCBLCcVJPBmrAoy1snETXP
BmcCQUlBhpQKxunqiyA8GBzbONqvgPORAdzX2T6bY4ekKCRIWCNiToKd7wp8UvfKxPbQJxW7
mvsAnbYKQnydKVDKBj0qlSGx3q0mpojbupAkCzs5hZscZctViqImYrfEli0B0S2Ykrm1YsIP
3qzsJuF2Wc/IH7qbMUTIKzF7a2iltabOIffh/t2xSx5IPNIWKxqvWhlJKERtPyLBy4b5tKhd
7brJT6wp/D93nQmINLSoQa68i7Rk1+htOsE69SDABxbV+iRz426YCGIr1OZdxmFkv/YilL7e
cJEfD//7eni8+754vrt98EoM+3PqZznMyS3ExrwswYufGfS0snVA49Geq0CyFH09KHbkVGr8
PxqhhlcgUv+8CWp0Ux8UWehoA5MVaRtWzqyAX2ISpei5jC7TLFNxUlFlFAaLnblgY6quOH0z
x5c7s0FSPoeSsvh0vP/Lu8kHMrtKvlB0MKMrwfeapjQhjpzkMYwg4/Mq2342TOpNSkjkdoPL
XImtXgd5iRHxfhbR+yL+bdbOeFc8quFMNFhDdAG+hk0kSlYFabMpXvehizfQSMfS+buzkUpx
NrcIl/ZSBHgOB+m3qDIPE+KpapvrqwrZzsWhiF3B4Qh7p6OYy4kKev7z9nj4NA0b/FmVLHFD
mbjeGgSVfXo4+FrM9xZ6iBH1kmReOOIhOXVfFnqohorw0A64/nIrav0sqr8IC6dleB+SLOZo
hGQ/Dr5slf7rcw9Y/AL+wOLwcvfbv7zEJDgJhcAkTDxSMWjO7c8TJBmTdKbi0xKIso5GFQZJ
KscrRRAy5EPsAD6s58uH4khOksrWTmAi2gO6iW0M8N2NtJCVtBY0wnU3xNAAf+udONd1LAXY
Y99Bx65DUzLvsriizbt3Z+eRDgrqrgYmaqtkoiT2Kk/89e8fSMSFwArI/ePt8fuCfn19uA1O
X5eI6LKzfV8Tet91A68P61WEzYOZIfL749f/wAFfZKGloJlbfJdl3cuPDpAzybdE0i4PMSIy
zljm/bSViwEIn+Rykq4wWYIX8DTHEMbmDJxRtjrNi7ADF9pnXNwFB3EuSjqwGKvDxOHS2tUq
A6irerIvhg5fjreLz/0aWWtqMP0bnThBj56srrcf641Xg4G34i2I3Y3JhcR8SQhENrt3586l
FoDUipzrioWwi3dXIbSpSauGDFFfAnZ7vPvz/uVwh3mmXz8dvgHrqLIm+t4mBIPCRJMO9GF9
gOJdWPX1TWhJvbuhtS3SiaomTDOC9k/83MSoB8xjbpNpwkx4PvNg2T6QGrIgbWXyhlinnWJg
OU0rmwfLDat04r9zNR0xmCvm3SIVVuuw3shCsZ4nhhB1HN51g5m9PFZ3nLeVLcKjUmKYHXvV
CWRedDY+dTU9roRYB0hUwhhysqIVbeQNoIKtMNbTPokMVs0UnwnZYHKzK0afEkAg0uUqZ5DW
iGg+WXTLuX3obosQ9XbFGto9pnH7wqIx1T/qsm8DbYsoXSVsWWOAXF4kzLx005Pnwopjtqx7
6B5uHUSBcESrzNY0dgLm2zZLp9yQzd9VfJQ/23C11Qmsgn2KEOA424FQj2hl2AmIzDMIkMhW
VjB52C+v7DksF44IERa0oo9qXnE0pqTItIh1Ehm/rxWW3RJ19wuTzR6P/mmsW3PdkXHe6oJg
KqjLymCWOorGl1kxkk4o7SGyr6C6UoqQmU6TdDKJV4MBRdfO3sHP4DLRzhQ/4msW+9y4/+BC
ZDEUTdEZOIHq6kIdnypsMiEclWyHsQUrc/lsZ0jc1hJkMJjPkEUuGxF+PmSGAE68W6aBcHwt
GpvoliFtJ1OmHC8UvB+/t+QC5bPNomAegntlWuEVLdoVLFD1BWDcR8RhH2iXZTgBUCf9ZS9N
sajbkVWRtZhKR6OE7zHk5DgokTc4NVAcYtstQES7msb9RVtsJl7ZdEBAd/iOOqb2/VZDATU6
9Ukb6C+IbPFeDPgDnyxzxhD4cRBWdFchywmCBNZt8HxRR+OWxuYz3iqurVB0N/ZunW2cJPYG
YGKsGjCJTf9xDbl1arFPoMLmdnejzWOocXL43np50V+ndnZomBdqZ/fxROwOy313Aj5ZKvf1
pF589K5CHT55OT0R+LnHV/5J756PwKEx7yBCsrqEDQZz6NavDYzjbW4lWKbL82x49Wn92lRs
fv3j9vnwafFv++jk2/Hp8/1DUPODZN02nVogQ9Z/rCe4rz01krdi+CUl9IlZFX2E8QMPvO9K
glzgOypXt5l3Rwrf3YyfTOq0hisTnTyZ5JEO3+r7NG2F+NnGFh0vlRz9ojk89qNkOnwnqIx7
9j0li9maDolqQKKX1NmEsPGAn/1aT0g48wGekCx80hgSoixv8Qmswo+1DE9aNeNG6uMzMj4/
Vrmsrt+8ff7j/vHt16dPIE1/HN6ExsC8bQ8vV5OumHr4CW5vqvDa8qNf4t0/Jk1UEQX2ebwA
g3muQrJmH515T3UDWxF97gn4bRJwAQDNP4ZMoEbwr03NXLDUviZxaUEC+6GtXpUF4bMtiLg9
vtzjgVo037/5b9GHeoLh4j62SSoTyik9GFMjOfPAYxYwGNGdKP+IyTB/8gDDFIBbvolgt97A
bLPGokdwX8c3xL3qY2J8N+9E7tAxE7ZANAMj7n+SzEGu94nv/PWIJP8YzV35442ZhurcyatU
3d7gWwWjPiYeylhhYBNUkjtfSTIqzza2To7ryMqtAgM2gzRrNYMbYn3zaalsfEgxksxjwsZy
G286gQ9WBTNeWE1QkrpGLUGyzOgWoyliHkP/JlQnNMd/MITyv1rk0JrCIr2V0Lk757FaxwgL
/ftw9/py+8fDwXykcGEKSV8csUlYlfMGfUdH2Mt8qEEd/DHgB+O44eYNvc35j1J03apUMtfp
6MD46QDX15P/x9qXNrltJAv+lY75sO9txPMOARAguBH6UMRBQsTVKPBofUG0pfa4Y9qSVt2e
sffXb2YVjjqy2N6NdYQsMTNR95GZlUc2m6CNi87VbtGp6um3bz/+vKsW1bulx6KNJufuTPaY
FatPjGINFptMSaIwbxOGAFmhB6XUjxGb9upBPjZLDZ6iTrA08pqoRlWbWh3yTG0vlr4wI18b
tmuJQ7cozFq7DPehJhoRMcUSoSYaJp5tOYeB2ySfZqVnUIMygS6H2xqII1cGb1pPQsyQEaXS
7sN6tY2WSikRjH6IBaFUmooSLcw76JOu7Uv0IH3w84blwYzNqRWPWEOFjSBoNOMfNhPok16/
+DlzHU03jwb8XRoPsU5aV9AG5wfxmn5bvFED7b5064MD7Zbl/MQRRMJF/+FvX55+eXl8W1gn
SfmpbZpyKXR3Su0xNGiCHK7aG401yLntAO8m//C3//3z71+MNs5RtpT9Jr5Sfu5UHYVsorps
KkOYmiDiBFrAs0YeHWIntfaCFrpecSigxvhYWPoa4YsslELydtcUC8gI6j7RZ6E0zzVrE7id
hFOOMxLVHp15aK3+Igj2mdScqCfxEWszdG48S7qsl6fzfJm474vps1o1n8HIMDAUnXw3EDdO
/fT2728//onGFtZVA8ftMTOcOxEypAWjRBvglRSBH3/BNamGuMglsGk0Jl3AzCKXE7KkB/ea
d5XgI0gs9vSY0ez+NW0HjrH+SGmmqPUuF62Mc4JBA8nigGA2mBXOR9SbLhC1tbo+xe8hPSSt
URmChb23qzIk6FhH48UMtw6JUSL3yO9k1YlyIJUUQ3+qa52tAA4OjqrmWDjeuuSH5572BEBs
3pxu4ZZq6QpwWgZGG6gIHIipbmTR4jnrmO2luyoQF6QB6pN2AuvFn9LWvYAFRccu71AgFuaF
911DL1usHf65vyXlzTTJaadya9O5POE//O3z7z8/f/6bXnqVhrTOAmY20pfpORrXOqrTaA8T
QSRDHaHj0JA69C7Y++jW1EY35zYiJldvQ1W0tAuwwBYlHc5MII0FraJ40VtDArAhIr3wBbpO
QToY0Lm2f2gz62u5DG/0A4+hthzjaDu2iSAUU+PG82wfDeXlvfoE2aFiNLsj10Bb/oWCioZV
71QIE+l+Ka9aWJ30aYWBU/FqrFh31O+5tm/xHYbzItde7KeP2sODUL/D9V21tK8/kNovSjOQ
3IdSL/PtxxNerCDfvT39cEXFXwparmQLheOC4eB/c6IwwqGCxqhXdS2YHg2Krq3AxDuJiUFU
sWjGruu1NLSYOzIWnUqV962j8qJLAEOXDf0Ubnx0rDutC4VRfq+MHzGB0wjuy1M2JBSbBoXU
wHX+pv+2OoIw2QUdZjYIYRXj96dstLNXe2zvaqvBV0nz4Te5zq5CjfB69/nbbz8/f336cvfb
N9RlvVJr7Io1d0fz07fHH/94enN90bNun4lId/W0PIiFuBDqq0slkKNIzMHycY2R4xzb3CbO
ZV03S+wy23DwBrkyMzd7+ZeGAk6silsz9dvj2+dfb0wQRotHLYG4H+jyJRG1yW0qafL8m2IA
eutk0rhMnjm53TO3Tryi/Z9/4cDLkQ/pmLgV1sZ+lwy5wNAXBGwQOISuDzdJUgzNYOD1MxAY
Z+tcHJuzALsMjZIMOPQcUEU770ENPl4UBnReiMKh30Aae0L7YlmLtDBRY5T9el9mdgnAatLa
7htzNE7iv6Jb00hPF81aadPlJBmnK6Kna5mFiJqySB3PyDU3kRwq3A34zegbahLYsxfdnL7I
NQHR7Rm4NcDkNomc1+KuK1KHrnDXyv64NnCaJE7pkicOybNzhAUGlpT0Cew141D4CdxYQR3v
iCqZ/giKsKptaM4ckbvOj2L6GCj9nqqG94r4vcdjQNX9ugdTyGacESWeodVDvPI95RVwgQ37
s16HgqrODvE9zZI6I9PWlIo0Bz9UG9qeqZ6z+JDJWhATdHDZ60blSdO6JIg0pcbv6oeamQZr
qeCU7aEx9CdR2VxaRyilIssyHJGQPLDxqh1DI4jT5/73p9+fnr/+4+/jo53mSjZSD8nu3uDW
BfjQU62dsbn6ajNB5RI2gHp8mgkqRLN7G96pgR0mIM93FJBsd5/dU484M3qX20UlO24DgTkg
y2fYoRs17MkupNwWuBAOf2cVVU/aUVqxefjux2G1vuPH3TsNTA7NMbNbck+PZ2K6ilsU+b1N
ZBbCqBpzYv4PB3LU28J91iB+FAhvNEF/N1smmZODb5uEyev85fH19fmX58+2ZAqHtVUUgNBg
pyCzhoz4PinqNDM9TwRKKCVcGx0J8gv12SmgYn7PhfJzq4/DBI2owkBquDhHHgnsAPrmALS5
XR8Wqz4DTnDBdxjZSoSuUiBu1ML0xBhC94kWuk1Jh5WcCPZMtRTfi2+6xjhuEFoVnbWxEc5Z
1eo+ghMGmKsbFdestwtrMy1h1VxHoUe0mOHHHX7gnB+kSfiJcoKau9WW3K4Qb14bas3k2Abp
vmj2Ps9soNRn4TsD1Z09I4MTCXV0nomarDN0RFCn4YgaN5hzkPoEqTBa6o3TIy9y5RJLE+05
Jq3R9J435Zl8ydjBtciEqZFi/DDDpn86kCUj4SnT88AsmJo6bBR8pedyUss0wxYoOOSgDZXf
TNa0WX3ml4LeoOfx4Uhj7EaY61lsxpdN044OYsvHwmRqpnGYHygUVoKWSYulP1jYOwEhw543
Oo04lrXn0Vqkj1CykBy4qQAd5PgYUW40ijJAGbYXdl401X3Xu9/u6sTM4jMxmPjkijxul+VJ
TS3yrlU63uUilZD6uoPjOHRXaeWE3jqt1v2rHsptTPkhNMoGI0LRSI0z9QIgXoEwXw1/GPTk
Abv7Uh99vE7GzJb6K+3d29Prm2EILFp27PcZzWIL8aVr2gHWTGHEHpkFU6t4A6G+Ds+rglUd
S8U5NRoofv7n09td9/jl+RsaEr99+/ztRQ3TZAgQ+Bs2PtqWlK4oCtD4jgxf2jWLIyC7/g8/
vPs6duHL07+ePz/ZgQOqY6HHbI7wLdshPt9n6GBDCZGJFrMymcOcLw+lAOy7awZsKV04e4AN
PKALUZ5ST7AKwSFVntMfmPbyf7PXytJ0SF47+pplOazRrqVffAB5TKjZqBJVtr4UXVZqzxkT
BG8lBQq/DN9LARozROmgQrlQknyPQqNipFmXAiCMLXSzwokWj4ysxKCPwqQfdjwniNDcGNoq
0nmI0G37dEeQoe3k5CGBJMgBUMVNr64tjZwiLJmYpEuZHTNqRl/kKC6vYywRCGpiRhQqgtHa
5CBSZglbFyWQYpcfCzKUAJ4dW4O93raWle8Iti7chBWONEtZexiMHKeKkov05J8ZU50l0lQS
xAPjxNNglH+09lGYYwxEnJXmLTl54ppgvDQqblyTsKj0ZM05K0o0jF0gcJJgsuX5IWo8tFK5
YS2vdemxJCMIzB3D30SnxkwMihm2+WNMP6oHOxBGktKWUblVi4zRQVwRw9vKouYieJw738hM
RAbKIYlw0dvRahYaOkyPQja0qjuVhKhKHBHWgRcWgEzVijg8Do7mSN2KbJ+gz4K0VxttXTFY
H91c2JV6JheEYYpLADu+YL0+l0OWMKN/aDsrDlsJ05GFCJ2tV9hRJg4CA7J+ahQ+urTOJUze
8hj5wVQvIOzzt69vP769YCI860rGAvMe/u+JABkKFDM3W3zujLDilouJvmLmmKsBlIF4D0Ur
vlw23+vzP75eMLABtlE8ivHfv3//9uNNa102pBejwPQylWRAtdCNIwyjEdFQRyECpUfvEygZ
pmV/cUxUBdKa5rpxq4PSzvzbzzAZzy+IfjIHYLEudFNJDvTxyxOGbhboZaYx5ys1mAlLMy1S
lQqlRmRCEeOooqZP9THTKDIy3isM3ceN7+ktkiCqzBFjht2cnlbfHYzZsYbeF/Oeyb5++f7t
+as+fBiA3XCbV6FUbDhEw3HSZ9z8CKB1rwU80uqdW/L67+e3z7++u4n5ZRQI+ywxC3UXMTM2
11I3rUdApauRR5Awo8NzgdUpaakOZHpgzzZJWKcdYlVSMH1iESK8CoekcOSmhDKgicQJ99Pn
xx9f7n7+8fzlH7pT1gNG96fviDTa+FvqWTf2V1vlYQd+B5EmM/UJqXwdu2BkbpddR18d03ej
Y22RqhzcCBh6XsASt+HCbg2NpZpT/yFQWceRYLzrQL7tr4PLT3AuDWS+rN4bUW9mrMNHf6nq
VEk1NPV1cqgcEs9EIdwYh8TQSsgMv4/fn7+gU5hcs8tatwqBgQo3lPQ2t6Plw/VKjnAYxWTL
4Qu42Wj/hYmouwqigDyBHM1fouU8fx4ZzrvGCqJ8wvuTdQ+DwRmepCv2IStbkj+EceyrVjcN
m2BDhQ7cZIdkwqLyRvZsUe0cpglj2tiGdnN8opdvcPr+WLqTX8SG1tzHJpBwC0gxKbDCpV/7
js21YQjVuSnLdyLuh3MgFrrJpUOre5I+7NhKY9tngZeJWMdn1XlsmiThmkvjDKgyF+iSmoIA
7bAHGAmyc+cwKZUEIt6zLAY4XIwqQR1E1XDfcD11/XJ4YQlMuAKO5YgDi1pTIzrTS5oEtynX
HOaBA+baOPZU9PlUYvq1HSztvlD9zkFs19xF5O+h8BMLxsui0q6nCa5eMzOssoEXzwJVlXb6
jpWradKXSgZ2rlSnMlSYYRgOsYJzdYUjKhc8zxR3SXfVt7f/HMZP6o9UdVlz7fV3fHy1QZ+a
ajBuwumLQ2GeHSPohrw0UYhAfXLiyKNNbaNyLTcg7ieWUnNaCDX5glr1enSAPhXri7jcZ//n
748/XnVlYo8xTzbCb1r1CQTwFEGfQDU5BYWZFBlqbqCkFSN6TEo/+Z88ZwEiPpiIq6G+7tlk
GA2lqcsHjV2zOizG4QT/BFFAWJaKbKf9j8evrzJC3135+Kc1MrvyCMeJ0RfDwz9Xcy7V8pei
Auox9ghtMoJI+o7M08HATUuXy2SVy1quTEptPTQu2xhEop+bEzk70mMyI/H8YTMZrPp711R/
z18eX4Ev/vX5O6GsxoWUF+Y6/ZilWeI6NJEAtpDJBY5FiWevprWirUzoujH7ZRDs4A5+QF81
6eVpFVAqeOfwIOE+a6qs7x4cdeGpt2P1cbgUaX8YPL0nBta/iV3bo1B4BMwopVGV2TMRSuCa
+noe2Crl9pGCGOBxKLXdhNbjOostyiqzHPr5Q5w/O57Vvbp/b6wsKfQ/fv+uBFVGz3NJ9fgZ
83YYy6/B4/46vY8ZuxmTmGgXqAIcIxzRuCm1SqynVlFJyqz+QCJwasXMLjnKVHSTm4M3YTBe
C0hAZMIDlW6fYSY5Vyn7FjOOpSl924ijYZcM+yuZmBGxIu4r5i3IS6bnTBXVJJQeTmJMmXWB
Dgzkuwfgsx1X3ag6OnewwztjSkrWd/qj0nsrRCwj/vTyy08ozz8KnwMoyv3ohtVUSRga207C
MMFwrnqMKigjQTZiMHE0OXIzYrh0RZ/J5NKu82UhtvZ5lRxaPzj6YWTD13EZrVc6nPPeD40t
zMtOVcjK9WOB4I8Jw+Q+fdNj9iF8nhFRAnQsMLJ8dFT2/FgtTtytvmRspILz+fWfPzVff0pw
7lxPDWI0mmSvhCzbSc8C4NOrD97ahvYiHsO4WN5fB/LpGgQ9vVKEGA9/4tytM8SQwHFO5QTT
FJZWWEXKudYv+RHlX/HK3MMIO1YM6pzGho1agn//HRikx5eXpxfRu7tf5IG76PyI/qYZBm7V
W6cg9KcbE5n2BC5h+vPXguBhGLhOIUFRXc2BkkPYqmLJDFYSLtttMFS6M4bBalWtrmbEmEF5
X03jWT2/ftYHDNgzU/k/f47/A1GEwMDkNwdqDAt+bESqV3K0FrRknW4GUbrxkYiAo19cJulu
1xMLGGU8dX1lSQJb7B+wqWw9+lxqliRkbwCO6tgDAxGT9Gk0KWFzqzcAVflsDII7WTSxbPEa
/G/yb/8OrqK732QkAvIKEGR6p++Bj29mXnWu4v2CrZEzr7URKB7p18KtESQnTtPwC/ptczMt
goME4zCdRVyb0pGP2PjumJHvDkgid4GmQ9DA43mwSCw6ctyRjvk97YyzBADDpVRSjhrXiyDY
ZbvR6Mhf6X1CLIb6qW6w9kiDfpQ7R2rjqZKSTtuEeJFnXFO1pGrmWp2/a0Qsid4RXgOwGGWm
1+LiAlBGCyFRsBYrC3hsdh81gBU0EmDT3ldhmjIHftdqGI4GfZswQwpKiWq4JYlAy0sNJkNt
mWGnlVxkMs7uaC+yKFEliNLTqaEoRBwKoeOroBdsn82xQVrFimsRwDmDL+hCjcQKEiAMeoZc
R+ivNGMAPrXxU0y++lSW+IO2YhqJcjqywITG90DOke0q2sC/0saznwwOwCoFrTdvEqTd7nY7
6nfw/ErnQJ/wrhYmKaxdNAJM0rMjY1rPxCpCcxSSYDQyfW+g3+thx/XRlRzgucrs93WEGlzg
PE5n1YxDEMrYBxhfUocfLrotLMJytuu0RLUSql2YAuSIKiBQwvPPKGJ0B2wZcP6H7kRjcZnY
NUlcThvWqSS96Zo3Xb7qIM58k624ZWnoh9chbRvtLFDAqOWmF4lCA7cMpZg/VdWDfrYVuwqj
yiub+8DqXk1d2xd5ZUy0AG2uV09tIkzZNvD5mkxSAlxm2XBMyI7nZpFoOdmR3w2HKt+rAflU
6GyJh03fGBSJEnGYd2qIu3YoSjVPYZvybbzymWozVvDS365WgdYTAfOpnLU8qzmwI0MPJGGo
54UZUbuDt9nQ6VsnEtGS7Yri8Q9VEgWhlvQ65V4UU040LToSHU6KiSNejDC4wBy2gWVAxDWZ
Nb0MVxSmxemqXTuqWYLjfpbGOgNPczVnLwZPHLqeq1GjC17A/47ZAzB0qi2mb1hHit+wQKGN
rBt8T4yt5KczvNptXlrC4Wj0FUXhAgwt4JwZXgdX7BrFG5t8GyRXzQlphl+va8rlecQXaT/E
20ObqeMw4rLMW63WGsOu924ej93GWxm7TsIMzYoChH3MT9WsIx4zyPzx+HpXfH19+/E7xhd7
nfJpveEjAFZ594LCwhc4jJ6/4z+XAe5RBaq29f+hMHvtlwUPzCNs2qDo9CxylbdaNCdkmys1
E+QMGtSLZoH2Vz06z4w4pA7P6bN8pj5XpBYPrcE15iaphjPJBuMOYGWCWSk0hcC0M1xgbXMc
2I7VbGCaBHFCNwjqEDi3rNas6STAeKScoJNcMmkM1UtIqgfRc2NUBFl7TgR11hysOlakItGj
cqYilf5LD8YnIItBrWJ7z4uJ27S4ENGusUEyQfV/wjr753/dvT1+f/qvuyT9CfaRlr1sZsvI
hIeHTiJ1z6XpE8pCYP5Et5KeoKS/kejSfPlZnU2EcU/tiD8oSMpmv6dVAQItMlmJV/lpy4uB
6qcd+WpMnniRtqcLWBsSXIj/UxiO6aAc8LLYwV/kB+YyQKiwCuVaQhCB6tq5hkVrafTOGq1L
iZ4C7vFMDyR/Ri37+VzSWo13pmHsiCCMkybfWTSuHZj2XYP5MzBbEnXmAY0IbW9+KPL1kb0Q
l7YeMG0MW7UYLf77+e1XwH79ief53dfHt+d/Pd09f317+vHL42fliBdlsYN6JglQ1eww4UAp
LLvLAm7NlfUJoVcU4CQ7a48dAnjfdAWVfFOUVsDB5EW+5nUsqxEWcFiAeyR4UfqUV7LAiZRx
clfAOHw2B+jz769v3367g8NJGxzF1A92hcC6ar/nLvMF2birq2m7Sh6JsnEAoVsoyBTpAKe+
UN9cRDXpJbHGDmAihYnRfJPE8vqYMWeXJZ9cIWejDfXZKgU5m4LTurZp7lzl84IbFfDzxYCc
SnPdngtzp54LYGEXZ7P2r4602NOaxl9C1Ew8EtL1TWvCepgj3Qxcgts4Is0OBTqp0mh9NYpC
IcdfEcBgZZUvBSJn8YiNzJIeJlM3vSiQt+hlLbCHtg8iigWesRuzHwi8+jUFDUigzjIIRNHH
vmdSC6BZ20fhOGDWBpIFXA2lAQVGJCGgRf2RBb41MDWPN2vPOciw4/T9KaHAlNvdgdPFX/nW
SOGhI2Mq6zWjtyZ/oN6JJTpNjIJ44vkrc+nw5GCVLFSZHUZVdJYOOzWKrbIKe+H0DT8UO+rI
keiuyEs9vkQ7blzXJ5ei3jXL80pbND99+/ryp7mL9Ywa03ZaOd7l5XogpkrOr9lTnECrzfIF
31X4fWqeHd0nEP7sXTv2bziXO+tKn+z+fnl8efn58fM/7/5+9/L0j8fPf1LGzVgYYYSn1mWK
wOppNvG+lW4MkwojTZlsj5J4UhGAm6mvOKmQClYWxLMhNtFae75PKc0hQIU6SOnIbrHP1SA3
bBdHgpE1v2XlOFJK29cu2xe876wkqbY6mXremSMy6sJADwJlYb2taGjMAEUG0kFkq4tcCEJr
Z8UyaopdsGhGFXUX8sUSTl3Hu9ZSp+YnPR2g/K2/h42wPLHJVNlghAnH1r1mGjFiEt24cIQS
YpEMgpdl2Z0XbNd3/5k//3i6wJ//bsuxedFl6NWsFTzChsbFb84UMCS0nf9MQUcBW9AN10w3
b7Z6XvYY9ALP19HAWn0UZcmQVSe0I8p2vR5cAtairm+tikIjsFYjHke0yCkUyCop9mZ/Yh39
rJDdi4TCN2K8OzTqhZmtWvmkz2hTD5aMcWKWswtAvePNs2iRmtYFXV0YPF0doQ52rMtOKV3X
ngxoB63jmR62DP7FG8NLeoTZL5eA0+NQiEgSInN8U/cd/EMLadTvxsWgjlCHpq60h0d/oscA
4MNZrJqu4SDqkxlXMvW4Ht+mtCfUutTNQw6FjmddYsShk5ABWBqPbNeEX4U38UZsRx2Z6Lax
E7Sptqs//rhV6khCns9TxQUc8XTpwKX59IMBhkocNzullsQoF8YwYZHnrE6bbggS0vhUoWAp
a3t1DY4AYeaZG+ej+t0+I/OaqyQlS9BWJlEWAi+LpDHiZC/0faalG0qyWncRk5ABRErMu7mH
O4Bi7EYdcs8zupqKfWq0QyKr2TyQ73RJ54zgZ+x5nvNJtnQ6ukOZgXI1j5agdZXoca4K3XkQ
6huue9J2XG0kHLl1r4rB7H7ODEeQd65ocBMBDk1jqLVK6jUKwAqDh78y/ac+m6U7BtZY9a5r
WPruGgaqxAjGvatpjY3y1Wj49j7ZuXAGLJtoDlnJ9XhfI2jo6aNoRge30XR81AV9psNzqG0r
uo40LdZoeKI8FJjbTqUU2bkoiSe5YiQD7SBK391PaWZV1J/KG7lPpu/w3eB20cALSSlzWhGZ
r10v8vdsfbCsHAmHv+hLfkIHRPUjUmz7zqqKHx8O7HJ0jGz2CQ0M3+t4fvpY9NydhmUk2zfN
3mHhplAdTuySUSeoQlPEfqh6waoofFPTzlEQbqk7ypR5BcCR3GJPc30Adyz14ur6xDwpdYyr
uLWrZYBwfeM4RfLKW9HSXLF/58wVyitMrb2M/MfKdReXcMm6UgFN5Zl6r+pcaf7j/KgmDsdf
hF4YocgA84I6UGB9+2oRD75dhNokaA+rm/caDgOhhn478jhe+/rvUDNCkZChIuMhHfkn+P5q
2maaI/9XtqKcoqx6ZwNVD53ujwK/vdWezAGYsbK2Aq+O5dSsNysjyTJgflx6CZ2ua+qmeveQ
qN/pX30uUpXXEC9Zqcb9K9TNUYvscBj2qqcbfNW4bp4xb5mMOvDOfdZmNcfc6mQT7stmrwpR
9yULruoRd18mxgUoIQOHgXUEQpQEaUJF/RmRpp1b1l+zetDe7e8zjb28x+Sv7jqz9N3JQ+Eb
7fBvD5emN+6i1XrlmAOMi9Rn9JGmkcEMsXfmqMNYmFZUyhHJWcVPjuieKlmW3b9L05QgyMCf
dweLF4bQT5GoT1IF3+oXG0C8LS3GqYVU3GFEqLY6Qbn86g6lOxH24hx6p9knjcU5sLZ9qDJH
Mmsc+IxaMQnGxdSd6+riXVaEP9RNazxaUHR9djiRqbpUGlXBWWC8jYtIAsV1PqR3KW+UoujX
BoXgUnzS+EX5e7iEWqirGRoQUOE4Lxy/dX3ZjCxqO7sNRcdqyhdOaawZOWs0zssqlpSFnql1
RLFrIdBEuSNFWcKcAAV5iF6LLmmMiHJChEWE31J7P0/V55A0y6/6a/8xp69cuIpJS1bBUu9G
3nJqxOFBpo+fCr0ARNGAw4Had8V+j6EpVEReXLN0BEnL3KK4g5+2W6QmiyMFIQWnRa0XP0nk
BvQax5tttNOhk8hrQJMqXHv4lmVAN3B1WcB4HceeDd0QpFJlaAxbUoBwbLR2lPxG4CLjgXg8
tpYYiiJpS4wNoX9TXnuTfuGMhaHe9cIeHEWWaE3VeyvPS8xyRybX8eGEBeZL79mEiOOrD//Z
pV7l89awdxScAQME1yKwxkbBgne1ypsD2jmKm/G9Z5cnOE4D3PQN7kZjydTifYpZ9dfXdkjW
4dB/ZJ4nVwS1u4BKodCVP/EqcH13r7Rv0TFLvsE56SPD4CgSOYVpvJStDbeoAelBsNRtLlAR
CAu8SFxlp20cxPOcK8A+iT3PBsPOIoDRhgJudeBohqIDx7N2D+eN3+3ls4y2UjA4PY+321C3
4ZGHFCb6cfoGy0hc+PCjLBUEav5Z+QWTWQ66MNjkBgAt0QzQVH6X6dEoRA1Fv2MO9k0S4Otk
XbgSUwoaYTeem3eUTlOdT5xiuSUSAznDkFZW+4r2fr3ytu5ygSBeRWt7xAF5V/3+8vb8/eXp
D3u88bKuTld7wBE6OecaQzEip9SgVzI0lU5aYbLs/XRXtQm/cU8BdrgiidbZObyf9el8lbaq
SVPbDjuO15IBXFLBK0A74yZCq7Z1RAprx/zMDqUe4BstkQ8CjCon81cFJJ7qe9VCgJeFamBa
HnSTOcDOgb8y+jVT0GDiHPKVHJEYu1r8SzFhgDU6BnE33mwRkTDVQxIhR3bRxGeEtdme8ZPx
adeXsad7oCxgWn2JeOCONzEZ4wKx8Md4T5qaj/yKt6F19jrNdvA2McVfT2RJmogHF3uMADNk
qkOliqgTAiG1mG48IqqdfgrMM1JtI9JZaSLg3XajMpgKPCbhcOhsNIWpitmGOs874fZl5K9u
jVeNHE9szbTg3Ur6CJzwVcI3cUB+2mE2Y2HIfHuqQCTccaF7Gd2snSRmLRj5oAqjwL0YWe1v
HC+fiN5l5bGghHLxbVfBkXGyhjRreVP7cRw7vjsmPojp1Ih8Yif6sWTu6jX2A281WBsUkUdW
VqoqbILfA0d0uagPexMGuN3Qu3rGiZAmSxI2BV60B1mt1mxeZF3HHNYmSHAuI2qlJoetT8HZ
feJ5Hn2mBEOW0P6rF1p1ctGtMQ5pmVh3Klq6vDy9vt4BsXpx4YiRl5b2wUJ/rq74qkpJnvLR
ZNA5FejW2hw2VVOAAdAKl+bMjhIvvxjN69Ce3TCwSmur58XX77+/OR1tiro9KStA/EQJlpuw
PEcXdD1fg8TwlnU8O2phniSmYiAHX0fMHCPu5RFGeDaDfzXaMgjbImk+QsIxxL/K/BhYDtxs
Vg/XD97KX9+mefiwiWJVKESij82DEfJVQ2dnomnZWT5AKOPtYpjlB8fsYddo8YYnCMj17WiI
vbw1aDjywDFItlTB/XGXksXew7Ef0qejRrOh3t0UCt+LVkTF6Zh1qIvikECXR1e7kJO9VaMI
tIWGSBk1kH3CorUX0Zh47cUERi5YqpFVHPiBAxFQCBDoN0FITUSVcLK7wBN6Pv2QP9PU2aVv
qDNwpsC0VGhnx4maR4U3gdk3ZZoX/CDdm+n28b65sAujheuF6lQfHc7/SklVSz1NzQTFPTfc
dJb+wWlC+boss1v5Q9+ckoNMt2air+M2MOEJa1ENQda5I7PZLBPXH4dWM5lTzhtVg4KhZlru
EyDgYdTkLwt895BSYHxdgr9V6WlBgkzC2l6LbEAggVfUZPSFZPHVsOst8mzXNEcKJ9INT6Hn
F/Fzxmdwe6OdFiV4Ls3LUDWnP4wpVYh5daT+W8iakkw1vBDkTYK6It1FYUGfK/Hv2w2lRo9n
XcFKEyqz7GLTTQwqXLebtd2K5IG1ZExIgcWR1GMQ6/ARZ5Q5Y0XTnYXD2jXiw4y96Isr9dgt
sbggd5W1LIDLW7XMWsJnfr1eGTPBRlwxOaTzeiU6vCClX7N9l3PAUuK+JBBpwPXg0wIiGf8k
Sxjl0qvSFG2fHR0FHFh9YaR5s0J03MGPpV8KxpLGR5xcZMD1Jk21tjstFprkcJz9Rn9w87SK
47aKV9ehqY08lRLN0o23psXykaBP/Gj6/iZdlZV43IqG3iDcVcwLKZZjZLqC62rYnfpefe+W
qDbh7bGz+4B38iYKV3YbdbLEC0CaHdpLR5dfVcBAhCsTDFu21t8IJVzwKbsso+PBKzRphhmF
O7NcgTsXu46ZmAt6iDT1sOtriy1nfcn4hLHmoBDB2XuH/dnMpQJvX4+Utwiv/UdazznOByZt
qtjNMh4y5tDMSXxSeaut2Uf0CShZj1Zm4hww8SdSvGmTPFxFAUxwdbLHBrBxuKFYjLHOY7wK
cW1o/IUyU13TY34EZMOIyUzZxo9XY3uJqUnZdhX676xQJIqCeavqawI4Ug+3od1tW0Jj6bUM
1ldquwuEI4CGTqN540hUUWGsdmJ0gbPzoy11tc34yI+shZ5ULDDs+zTEzXYWaQZbE2Ouwr92
jDgY0u4szq5xVtzjjnRRqMwegd640B2GYOOtdq4YDeE9MpLejUO0q4q1cKSxBP3D448vIlFE
8ffmzgzJkGnp6Im4cAaF+DkU8Uo1g5NA+L8eU0eCkz72k43qaCfhbVJoPK+ElsWOgHbsYoJG
O3uCGECo0Lc+6BKKmrVjhYuaXcClEMkpQ/PTNCbzJ3tWZWaovFljRI3/7HdFKWGkHurXxx+P
n98w35EZokt7VjirQYxGVx3guGtesikQz0w5EVAw2AWZmoPscCGpF/CwK4SXlqLEq4vrNh7a
Xk1mOaqkXEAo7QSCgR/O4SRLkSwIfT4xHcqkPeFPP54fX+zwoCPTI+IyJurZNiJiP1yRQLhU
QZoReQ6UuPYEnYx1qK2OCeVFYbhiw5kByBlDRaHP0b6AuspUImvUtUZrYWzUVmohNBREdtUP
Nq2q95tcZTXwPZSKX6Wqu+Ek0k+sKWwHM1xU2UxCVpRd+6xOXS9fCiHjbQZzdj453sHU0bpI
wxKynJTOD6E1vPfjmHqqUolAQHesnKpIicoxVCgRflVGOvz29Sf8FCBiuYtYQ69KYj29KOBb
A8PqnSa50QccRtNKy0BNS/L9QpaF4BkUeiQxBaisd7P+j5xSr4xIXuTFmfpKIqg2m5Sod6CD
wowlJUl9ba1WS7Bzn/LEiwqO1k5kn2c01fT5U5ptscj0+L8SC1ttl3UpI5q2S6ooIGseMX9l
1MaL92PP9re34EiIRFZLFBwuUZHxzTo8VKIdO6UdvvV7XuivVq5WCdp3lyuafpPNmhDOyR0t
ZlpOf6+jnaWwLiHmABmUd5uORLDJ5IB5Vhmdwy98ROccVn17e9oETVFjlIyxj2QpC8X7jU7Q
mFikJSv2RQL3OnUj2UTvF4y30ycvCKm91HaUjmba+nBYkTM4IUQ8ANcoz0TkdpnTG2gci9ny
pO9KQ7E1omTCxTrV3oGq5sqkeWJpmPEgQhiFFHTCeLREES8te9IdTjyLLvXMCn+NyVShYwxs
a23Xw55rZg5186lxuYxgUGYoi2jQ4Tyld7MGBp/oNOWqAhfDCSXqEsjo+U1cMQXIU6iIS0tH
cAAg2I0WbGLcu5yR3rTAEHfo7aHoOGeQSHkJooKRjHTBiwm9Vage72kB79g68CjEPmt0X9QF
RRudq3g9LfuCSWB0VUZ/wVzRLKDTwq2lvSMGNKq7C9qdljf1g7jKRpMyEdfms1sCmte0rinB
aG0Vq4f1inQFXNC6jwlPOn9NsUhFi+Elyik+1Wy25miesikvdLryMYWPvu3bJN4E0R8GtAYh
yDTZg+VYkc4R9dlI/QSUtjw6zV5LWmvAZtgnhwwjtOCq1XTXCfxpyXAyWZnoidngCiwf0FYw
KZnKGE9wgtIMADwjmpyoUmAntf6UO9mei5F62ojdCTOCt0rMbQ2Dme3mhJ/yuR44MNsqQn1q
EGap+G7StBiTR1OsAVS8AWKWCh1sJrcSsAOQauYDAJSWnNLwc7H5FO0SaXkIsQA/Y91O6i6g
0LLMatLXbyzfWHILtNLNmiZE2SfrYEXFXZso2oRtw7VHfSxRf9z6uKjxGLcbJM1NFWCa3aSv
ymvSjhHMpjizt4ZQb6zM0Co0EI7GTm9880JhL//49uP57dffXrW1AlzpvtkZtjgjuE2oxb1g
mdp6o4653lm1hPktlwUxnqJ30E6A//rt9e1mCm5ZaeGFQaiPpQBGAQG8msAq3ahxsxbYwNdx
7FsjIGNX0DevxA+Vg5cVD5mxIwqLQHLX+5FAVvSxiEiMx0Zq+AFXC99SX+/jCIRObmNj8KRr
Kmymk9l5XvAw3IbOVgA+CsgHLoncRle9Ki3q5Ahou2ZaoSKSKznrPKkK7cD78/Xt6be7nzFb
6pjC7T9/g+Xz8ufd028/P3358vTl7u8j1U/fvv6Eud3+u15kgge3eXHJPcuLfS2iXFP6Dyct
GT4PibK9v7K2VlZlZ/eycVgOiUPcMI4RyyFhapBZfalcyccKwHTHwDo9eVH1GfkSAcjZf06G
m/8D7rGvIDkA6u9yBz9+efz+5tq5adHgA/5JvZoEvKyNxZq0fuQZq7Rrdk2fnz59Ghpe5Gaz
e9bwAZgO54D2RS0C6zt6di4wI89o0SZ617z9Kk/gsWvKUtO7hWNfcC1as+CdWLLTe5Crgedk
pSMfqx2f5FFpTFJ/cnWEl0xXNs3AMbK+ezMLIkxjgOmGbqx4DKBvvt8QJHg7vENiWHFow0D0
PCBVTa2VPsoZjhe9c0SuWmWyEJbNKdowG0j1+IpreAkSrRhBavVIVQ4ty87oIc0dDsRIcpVx
xqW7vqPJo5uQ2UsiMI+NRdf21Eq+tZxa1tBdXGGQJVLX3kvYGD5fLwf2tKMUuQ00atRSopKG
zsWCFOY5LQsqHdlbECt1pgNX7UQQ3sizQAfCGemr3ggLzO7x5GdnNocnXgz34crV71kPrK48
LT0hQnrgqMoiz1HDp2Ou6LtoVipPZOf6+vRQ31ftsL93j5OU25fFr7CfdlIDbPLC7SP9lDlr
3DWvOjH8MeLoiamZI2zSOVPEOJRZ5F9X+hBYh9sMFKKga+AFAX+AjV9NEf+MRWxGDNTT23Oh
gil4EUQbpUUH9TyHH5ogJR+0eWEE3l3AL8+YF0Q9UrAIFLCIbrStHj+4JYKwSl665VPRlNyF
H8LywgRARyE803VNNOKFU5H/F8y4H+c6/4Hhdx/fvv2wufu+hRZ9+/xPezkBavDCOB4MyVyH
j4+ewipR8h1fH39+ebqT3th3aItfZz3GZBZBDrBbvGcV5nK+e/sGPXu6g6scWJMvIuU78Cui
Oa//w9UQfesZuOO5cuKKtI/9NtAyJNkkDtcQg/Bc0a9+5tg4kmjZoz632ZRFx0DIE2LYd81J
NeUFuOarqdCjCJuf4DP9URpLgn/RVUiEov9BRmCsm+7x2C7Gg41PJneaCLSI8yOwAl4y4KtY
14hYWO2KNLHafI44DsvL8fw0k1y9kHzQnAn6Kr9ShUszP4e/10QkzLhuUjRJVjZkVsSpntmH
nhuavpFgxx76jhUl1cjkkHXdw7nIHAt1JCsf4HZHm+ob7ZhCpJkTWqaYDvKYEQ3rmqtm1zi3
itV1U9MfJVnKOhCRjjYKmKVz1pElZuXxgK/GZJEZMD893526PTVEMs06fnmr8zBLZNkf0YDA
0X+E5kVmBL+fkNmlEG26tfZOdVfwbLJ2N7B9sZ9rlqmg4Xx/fXy9+/789fPbjxfNg3o8clwk
VtNhxdVsr8ZBX9Z9mqk2ovPE8fWmVAVCDRETiOz+BJzRritOynGNa1wL4DECRMpXDJw+ZoUN
PX+iaHJD9Sg0lnpOz6mUors3+UJ5ujmEean8NPijGTicKYdbgbYSgAuo8NdZLapYmU34t8fv
35++3IkmEG7v4svN+iq95V0VSknGHIQqVbMQyoabWbKlVfCFtTurk2jvQ54cApv3+NfKo7RL
6iAQuXUkuiPm7VBeUgNUqHe9gIi4Z2drdHdxxDdXqxdVVn/y/I2rlZxVLEx9WJfN7mQUaQoE
EvjAE92uUhpPX+OQSqUhkJck3Ro2sAJuCwfG/A25nhP7xpqRvBwwEj+NWLQRNFaVNn8bL46v
5mD38cbsrzX+AAk8z/x0yW2hQbkXJetY7cPNNs76QwF9+uM7cI/UjnD7KY5o3dROrjiQjkva
KkzZn/SdvhD4tDAnjTzxYYLMd7+gVQFlhKI1uDmcfVskfuytTOWTMS7yJMlTe7ys0fLNinfp
ZhX6sTVOAPdiMi/MgvZj82ARCXvMc0VYmptATZsod3QbbNeBuaGNu2aeAmS8SHBogoUXoDWw
PAq33srq9gUESEzumTTkg6ukEZbv5hqv4u1Wy4RJTMj4kFK8u7Dt5wxt8Pv4atZfAYvSmJu0
1T3PRlgB8g38w6Me3iaSTNL4a+v7Lk0C37ux/nmDYbRKhxkL0ftZS/HOqMAF6EXUc8o0+4G3
teZF7mfP6kaVBEEc39jnbcEbMm2iPLQ75q1X1moFdjfTUowS3ZIO6nx3e7dqqu65OOIzUdz5
+cfb7yAz3zjq2X7fZXt0YrEanRxPrVoLWdr0zcWbeBfvp38/jwrwRa00D+LFG7W4wtuZjIy7
kKTcX+tBLHQcmS5YJfEuFf21g6tbCPheSyBKdErtLH95/JdqOQLljJotkLMU7maGc8NYZ0Zg
t1bU+apTxO6PYwxFlqKKjlzFGrFHhZLQi4ucNfnvfQwiLtF1/DRYuRCes7rg3bYGMV1quLrS
iE3saMcm9mhEnK3WrhbGmbchDzd9kSgiHzqmwWxx0lJGYvmpbUvNIVKFO19LNCIr/nuLgQ+R
ghpR6cCF6+ek8UkjwvUdqoMlchk5VIhiHErkMVaRNrU71sM2gxv14q88WhMykeB8RPSRrJLE
lLShEZANEBjqHJkI0J2b+pDvaL+GqdMufMVqRuCN0nf3/kaL2GwgdJWYiTyk925k2g8nWAEw
YUOtKkTnEQHOTN2gKlzl2CY43KXeRhq70RjXN1pCw2nYJvdIdcgnXMFbLO/msEPJMbSfMswb
Kco23vgbu2Zd5lzKE9NlI8o+iEKPgidrL/JLqgPY7XW4oSTOiUSmoGtG2kg1d1FKMThaHbMl
B08MzPZW1ZIiJortoyAiqoMVtfbCK1WbQG1J+0iFwg+JeUDERre2VlAhVHhzASBN/F7N4Tam
+xNGV2JR8moXrImmCoFhpbMo0xLfs9M+w9Xgb9cUzz7TjVbP9ibp+nBFb4Su365D+tScSE4J
91bke+bc23S73YbrpV4jerv4CRynpqaUwNGOwMggIJ2LZBZmwoWu5k3HB7Yr+tP+1Gn2ShaS
2r8zUboJvDX5ebpZe5QooBHE9KeVt/KpedIpFI5GR0QuxNaBUC2rVYS32TgauAV27GYD+81V
94BdEIELsXYjyAYCIvLpBgJq43ITU2nohTvTHHrvnVJ4QAaDWvDJJvI9spHXYshZPb0k3yjk
GPdZ1VJlHL0Vom42MWeVFx5sZsluEEZn4RXthzV1Z6fFY1/g6KJI9rK/treWcgL/Y0U3JNJ8
z4Ft+clGCqcJ18ik3PXutVDA1XiraSlGqeZVRdQsQxOwNKGqLsLjwCrag3Scko0HAkluFyy0
nX6+pzBhsAm5jZhidDA1q8T8FU8O6mvmBN+XoRdzomeA8Fe6V8uMAs7XYaS0UJBGKxNa6HNZ
bdd6KA6RpwfNXAYzJF0blBUyrQHzS6kktkr8mKxvtRL2Sef5PrHIRVhyLW3PhLBfomaUuHND
qh0StTE9H510DtMblWpLtVogyGNSsIfhrS2AFL7nav7a913OdwrNmlIhaBQR3WxAEMc+8qIe
dR8gQuWlVXi0iojbUmC8LdU7gYrim71Dmu3mPZLAo60NdJKAGALARPLuoBABcZkLxJqca4Ei
gwhpFFt6AKGF1NqqkjZYUS3sk0jl5mZwy/0gJme128DBE9gIONZM/91xgVTRLc6srDbkeQLw
dz4jFgpAiXEBaExBY2o5VzHROYDSe6uKb6+rsiKlCgVNb/hqe7vz29APiHkTiDUxbRJBjJh0
8SJnAFFr/3b/6j6R+sqCg/x5o8l10sM2JYYWEZsNObqA2sS0eeVE0YpMH1S38jjcKgPRVoZ/
5khHg5Gn9qOIapRAvcOO7jC7RU57B48ULRs6HlEsWs7bIXiw4cWuGpI8b4nmpi3f+is1KNv8
Uc3bUzcULae+K7og9GmmF1DRbdkGKDAXAFVqy8P1iliFBS+jGLggan364YoecHEvbqinWYUi
iD3HvREGVEvGu4ZovbxQHN/4qw3N/UjczStans4x3cxgvV67Co4j8mF6pmgxpDdRagvDRu6r
tqjWgX+rzLaKNtG6J/ik9prBVUw29T5c84/eKma3dizv2zRNKEYC7pz1CjgVqmjAhUG02d4o
+JSk2xW1nxDhU4hr2mae79uIT2VECk981/OCAncVBQaZlJhsAFMXMYCDP0jwmgYn5LYlHLjM
s6LKgIshGe4MRJQ1qQZVKHyPuv0BEaFWnmxTxZP1prq1NyYS+jaU2F1AKiKXhdXzTUiNbFVF
FFMJDIvnx2nsEXuHpXyj2SRoiA2l5IABiKmJLWrmrwgWEOHUzQXwwKdZtQ2pwOoPVXKTX+yr
1lsRy1zAA7JIxNzmqYFk7XB0VEkc0aEVktCjUz1PJOeCoXe0qT2xqaI4YnYnz73nU0LIuceE
BTb8EgebTUDI9YiIPVJ1gqitR8f0UCh8Qr4XCGI/CTh5eEsMiuemAbVNWMJ10xP3vkRFNd3N
yN8cCJWHxGSHnGyVeOi70Zormu+RjIZIbFZ5q2FXjclALf0w7SY6bz30djdeEWdcf1x5qrZS
MKtMT4soQZipwIznadHwnvUFd0RcnIiyKuuguxhGDlvV5DmqqNjDUPEPK7tMq88Gvsmt5g+X
rhCxdTFtn+4qMlGkWc5OZT/smzNmAGsx8irFkVL0Oary+IHp7mIUJQYcxHQKpFva9IFVJIGf
m0ij0R9uGJ3iCPTSDLXBcGxMVETr0uycd9m9siKsaTzJSIXUIDisZyd7MqXUMcXC29MLuqX8
+I2KFSg3gVgtSclUJRlwf3OdZ/HIp+PaIz6jV63dDVkmb5Ih7WGbNTw3wn7pBEaDxZYDimC9
ut5sNxLYlYs9ObVbS1QtP4m0jTjaPNysU2/1DlMlVkXi6jaGy3Kg+gRDXTRlMXpYzvEuqRlS
Jr4QQ0Wsp8XagfXJIW1IT1SMjt1wXmiJgjjfaT8wNJQarkd8lRSYiUj9ejlDF7yrThERxiyA
JDBakhbNjc8mtA6V0ZGMR/FdUjGiFAQbRLK+pHBQz3h1CBYEzA71Yor4sV3Up1OTKwaroqLT
42qErSOYlSQiffSEi+Uvv3/9jO5odkq66ejIU2ODCshkB7vYggCUJX28XYdkvH1E82CjMj0T
TBV2xO4hUrcIWtb78WZlOX2rJCImOvrwJuqKXVCHMlEfOhAhcgesdC2hgKfbcONVFzqftyjy
2vorV+xBJDCNexeYlVlgwdCKejnqk/+J9p0AB5R0NWNj+iNH9usFT/q54RQJy5qrMW+mWQ2W
M751aY5tCpwYBoGhNVkTmnwnmpEBUSIdAF8gpaG29sGe9Rl6cvJhz51zm3h6InoFaEYDUFE3
VkvrR/7W/O5QRCCviAEmxwRk7qFlvEgoCRmRUKGM7aMUKu+c+xPrjnOcj4WibBPdIQUBmofE
ckmLiYd775I4scmhTxMtG7hBUHU53UA9VKwOn7yftMFS0HQclIWorUS76RLairq6BN7KqIPQ
j6z+BAd1kzqOYaQ5Aj9UUuIYImXSiJXeWQm0tq4AR6RLpzxGpGWWeeyYLgULNCShcURBVbFw
hsZra89J4zVaTT/jfdehNVp4WVXpRl0CaBh0TbDtxmpRVue+tyMNFLJP1ymsv34KItDRRs2A
XYHX/TWzDrUu60+OcigzwTmzAkvpXT8TOMy/RZ3SkUFvXdev48AzYaZ1loAmYR/G1KkisMd4
ZUxFV4d95BlAniUE/8CL9SYyA/4KRBXq6roZ6OZxBMnxIYZV77oXJhcZ6YnRV8+ff3x7enn6
/Pbj29fnz693MpFWMeXSs9PNCQLztpJA475ePCP+ejVaUy3PO4T2GCEjCEIQanhiLAqFbHYx
0j5GM1FSWT+WXOrpO8SiZGXFSG1CyyNvpVtKSttB0kdSojbWgSnhMeWhs6C3Fgso4L5pnG70
Bnob0IaVCkUYuVmMsRZa1TgTxJHrBKacrxS477TZ0IjcfCCQwF2hOxj0l3K9CmzmWCWIVuub
3POl9PxNQOzKsgpC+4BYAme7O5MEYby9MRn31dW5CISzqdEQxVRGZ8W74lNTs5sjO9FYG1Yd
gipekwZDI1L6xZmfoDeBm68bCQieEDGhK+fKSDA53akHbXOopIMimRdaJRldH8mPHRiQeq7V
KTfOZZlPxQTKwBFqg2cfYE30EhmtSCAlAdyD8DYIfog6tKbsL/Yy1ZS2qhblpqg7lzvlQFoK
XdIiCRGaQuTFFZMrNGWv2XYtBBhd7STDdfOTESd2oUJVodAUznTkEl0+ACZwb5xANBUO4ztU
KLfHjvNQoUrDYEufiQqRkPH/AhFp1KSQmEtmQVHyuoJ1uvUaNOrqV1HW8lcWgSHf6hhd7tRw
HmmyoJH46nOAgfHIhcfqMAjVA9LAxTFZohnCTEn9JSTNc0SefwtZwcttsCLrRUsKf+MxCgd3
SBQ4Jm0+1t9ZOMjebG4PpSAh50g4y5ArSvADZIdKeYE5Wg3IaEPdXguNIowRJQhLEPL+02gM
wc3EhS5cHK0dTRfI6PY8I02sins6ahv67rK3pJWcQaPKdyaK3JyKXErXK+TT90czXpELROJ8
V/HSUPqdFYpUMak2U2laDyaNbkMbarmWVUwcq2mQdUxELuyqvd9sdUWqggQp+d2jWhDdPk2R
xKeXCWBCeiYR41qbQqJ/t8qtY09h+Ik1qe3TaFqqWZQormDz+PrO2djmp0+Zt3KMeHuGM/md
rgka+uQWqC2JEhyTHi3QQGIi1LO0KiRa1jHe7jCOlgj9OOc9hWsYg1S+s0aEKuA9GqkbuNl1
5D8dzevXrvjVOlHwPhGqOt4lirx3pglINMNVFXPve6oVrIqqzvRBDh9FG9eByv2qZe92H6n4
u/uZh1W8iSiLJYWm3IeeZrSm4Ew5QEE9xN4qIu9+QMX+mjyiBGpTUyg0r/PgbKFHZVJE3OwK
EvmaflDHwSlMnlyK2sKB2zr2uMB6we0bQCoY1g5uaFIfvFfEpAOwRQ49suKCMAO7aBhD0DTO
j5Ltit2OXl2JS6mQWMo/hNRNX+SF5oiciaCMavUjaIBDCRnL+iMl6GYYMB4pMTyAlshG1HzY
BOrbIsIMz2j8NEsUiMgXfSp5FiNSbRBiOlbU/MDS5oJYZ4us1mhgEBlLLfbzhN2l3VlkUeBZ
mSX9hzmC2pfnx0loffvz+5MWhWQcA1aJp0NZA63dEISsZmWzH/rzX6DFvFI9Jkj7K8Qdw3A6
BJ3eybRzjc4UQM2FF1EZFpwSLMwanunDc5FmmAz6bJYFP9Bnslyyl5yfvzx9W5fPX3//4+7b
d1QTKMpfWc55XSqLaYHp8QsUOM5oBjOqPn1KNEvPs0ZhHkeJkvqEqqjFrVzvM0oJK4qvssqH
P4MRuU/g8pLxw1BCSSKrDKmfprqsLDglAYY1IOYowmFxf8L5YUpSopenx9cnrFZMzK+PbyL+
7ZOImvvFrqR7+l+/P72+3TGpncuubdYVVVbDClTDOzobp+6VWXsvgKOW/e6X55e3px9Q9+Mr
jASq5fHfb3f/kQvE3W/qx/9hbzI8Ad7fCGgp4t4GYpJ3p9w3zsUFTiwzAYepblRviQWTVnIu
ij1ZXsVKkK9dH3LzI7mA+nZvLKplg0qbE8e6XJalpDJLX1atSBJWMjVMIx4PZjVKAVC6OAUc
RZ+Lyt6IhfT6t4Hj+U4gMJMdbCr+IVpbFfiV/Q2mJ0+II8l83BHL4wAfwSmcFGWJyc3lqa8f
9Y9fPz+/vDz++NNcyI+/f3n+9l93/8KNKwJO/3gEgAiYN2Ufefz97dtP8+L++c+7/2AAkQC7
4P+YSj7PRYo64Dj9/O2LUjOqzP8/VCP7h4UxmaHj1d7aGta4Ak71cmL3v39dMnz8PzTILhmT
jrSqeZeK61MW+6rwZSFVbtFAeoD1nNhtrIajVJFV76+ujmKvib/SNPgaLtT4dx23duKqZL0G
tjKYx/jbt5dXjF4O1+vTy7fvd1+f/n33yw84fGHKiLmzV66g2f94/P4rvn9aodfZXpHD4Qcm
S1LPHQHq6ecagasog4oRo/pRIcgI74wgmXPIrJEXdLwjgRN2QY5KtbxCCMjyvEgyLdOZeKPY
92rSxT3DLGQWQBxE+xZkdi9SjmJA8kvRY9zrhnr6T9UwbfADmAnMLbArKKieBAPhKYzd6Tql
WCPHQZCJuCkVHUR+IQBWNnekV0CiY8XH9GFmM3LBO83Gzo7vMQXdAAs4Bb6pqy6aHffYGe2Y
R1jfG+ODuQCXVuiUJHyPCRzQwJPAYY9cOPyOH/D2o7AcZnTOgYGH7dNXcQjffftx9+vTy3f4
F6aPUtgw/Eqmw9us9Oh2E4YXpRFR0iLBpCd4CG3JxN0WVWjFanU1Uxpsd5WSjVKr/NjA0cNI
1lT9Sv8IxIysoe1hEQ27HjaME103p3PGKEMc0c+t6hk3QQaRsWxou2aXffjb3yx0wtr+1GVS
UCU+x/yFXca5kwCf/tqewkxcNeaSaE79Bx8O7pXdPpFgZ6LxSBqsQ7pHCPnyxNusTj/4oU15
yFjX7zLWyySuZ1YimU0HfcqqdmlbtLZp8Pya+rA78YcLK/oPMdU+3jet2gWLQKTTKDG3bHrq
pPuDp8/teU9m+hQo2JTm7jhXl33uWvH7ioXqHYmwU1rqAMZ7s9Bqz/Y+qSIWazdhHSYqOqSV
cRYLTHlOrVbeX0kfEcDsmuTA9VJaVmezp0T6/Pr95fHPu/bx69OLcWYIwoHt+uFhFQCDsYo2
jCgK7iAYJ2C0YbzLjCSAlTR8Wq1gGVRhGw51H4Th1jqJJPGuyYD7xecdf7Olrm2dtD97K+9y
gk1bRlTdKaapqSjMOJAWfGbviMZlZZGy4ZgGYe+R4TkX0jwrrkWNsZO8AQSCHVv5dJlA+IAO
QvnDarPy12nhRyxY0aG5l68KTJZ9hL+2AflGTlAWwEF6CdXloq6bEjN/rjbbTwmj2/kxLYay
hzZW2SqkMwEvxMcDSxkfer4KV1SNx6LepwVv0bHsmK62m1QPM6pMU8ZSbH/ZH6GsQ+Cto8vN
qpUPoJmHFLjqLV00ZxU/wciX6XZFBhpTCgWq3SoI712ziAT7dUg+aC5UNeo1y3i1jg+l59El
1c2ZYfvFLiHVuyRtFG18cnsqNNuVR26SCrOPYX5Xlq/CzSULHU1rSjhfr0OZpPjP+gQLnLa1
VD7BvB19lhyGpkcbky0d3En5gKf4B7ZN74fxZgiDnuKjlw/g/4w3dZEM5/PVW+WrYF3rT2sL
reMB62b5HXtICzhguiraeGpUDpIk9s0bYSRp6l0zdDvYP2ngaN20HnmUelFKm+NQ1FlwYHSI
JJI6Cj6uriv6dcvxQfV/0Zg4ZivgsPg69LN8RZlh0J8xRg7cTNLkUBxNkhXHZlgHl3Pu7R1D
C3JKO5T3sKw6j1/fa5ak5qtgc96klxU56TPROui9Mls59gwveph72F2832zeq1ejDejbSSGJ
t2eSpqkfBpZc1/6aHdtbFGEUsiN5O/ZpM/QlrNYLPwTkqPctUKQrP+5he5MjNFKsg6rPmJui
3WtOzgq2O5UPI7ewGS731z15wJ0LDoxec8Xtt/W3W4oGTirgZffDtW1XYZj4G1+VTwwuSGOg
uiLdk1zNjNEYqcVqe/fj+cs/bHkmSWuMCkgZ7Qr0oWibOhuKpI40ky6JhLlHxQCKcoGxPqbr
FEC14WsrZWA44+GMKvt46/k7c7Eu6G1EZlywiU7XxCwFOA34E0W0JZsoAriuYVGFqlxxtmfY
e4yGkbZXdILaZ8MuDlfnYMhdd359KVUdhYoBWbTt62AdWYsLxcOh5XGkvvsZqLXxFcjI8KeI
I986vQG8XTlSoUx4P6DCtEos8pvkQusPRY0h9ZMogHHzVv7awDf8UOyYtJ/eRBZrYuBdLTDI
Nu8UQ5ln2GQbQ0ju4cbN27W509EzuY5CmL04cGIiu6g29Xy+0r0chbglXi7hfGT1NQrIqIAm
2UbLIqJh09aBwM8i39QDYIb19LwJzX2rIGxFkzgQqkPaxuHa6CgpBY7A+eHZOMPsA0j9OOtr
di6MW2ME2j7nYlteuQXId8awdEm7P5lTkRRdB4LffVa5VS37yvNPgSOG6rI7UkdSczQ7QqrD
NQ7CDS0zTTQoAPmkK5lKEagB6FTEWl2FE6Iq4P4L7nsb02Ut03R3EwLu7ZAqCu/zIDQO7fOu
uYr3I3Ns9ye3gFjiQfpwk9EArhyfTFFBMtyfiu7Ip3ss//H429Pdz7//8gtmkp5VcmMJ+Q6E
6RRDlC7tBJgw1XhQQcq/R42r0L9qX6WqizX83jVNP5wzTlhGYL3wJy/KspM2DzoiadoHqINZ
iKJi+2wHErCG4Q+cLgsRZFmIUMuaBxxb1XRZsa+HrE4LRskSU43awywOQJaDLJKlg2psgsTn
PdMy/+HgsORYFvuD3t4KLtJRS6wXjaoYbGovA0XYU/vrlLedSLOHYyf2Lt2XtvK1uuA3jGbe
IAcyMh/GCCUPIHT5tM4A0HB8GB8wuG1hLOkHdDGtvHciYfT+D2NX1tw27uS/ip625v8wNSJ1
erfyAJGUxBEvE6COvLA8iSZxjcfO2k7VzrffboAHjoY8D4nt/jVxo9EAGt1mTCcDhPHlw4q5
xzAOsP2O8lcAQAl6JV7Sc6sKPIjlS276K/dGaSB63vmMuGMSMkLDKPFVo06P3uqnK/IQBJG1
vmx3hHYnti7RsHIBYpaspwvdgykOB1bD5CvRcEV/LY7jWYZIsuqmiCBrsywpQP2ky9hzXbhI
75uESLbdUUTrYZGWEjuSJwPYivJ6wUhNkZzqd2R99hrdoWBfUBucCeIShGbzKZJHIgBo/91G
DssQjzKLYnvqIUrrsh1KDjJt4M9MYTZzBD1nR+MV1EBymq8jsyjSr2QRSLn9dzszT316qifY
DsqC1DOni6QEWZ/aA+NwqambVEBmsf7CrSMMxdbTkIB3hh/LMi7LwEjqKGDPMbOSEbBbSPzy
kdW0JzAprakjSjUrc3th72igOTBQE4+m6zEDjBouSs/U3CWwTFkVkLQ284hHhe7MNu2Jgd3L
+O7bV110v9iQNzgAGpc1KME2oFmdxdy41cGcx4gl5viRb/Z8WecJHtWUOWXyivAG+vVsVrGj
SeuwXewIpg71vV6VIx7VZS/KYU2aUmbdsqVWgXEqQqqCUk/YPHz56+nx2/f3yX9NQIL0ZpWO
3QYeFEvLQjSUSnUTLkSy+XYKW9pQ6CddEsg5aNW7renTQiLiOFtM749EDRBWKv7ZTE1q9bo9
PRJFXIbz3KQdd7twPgvZ3CRrIXuNsrCcz5Z3292UepjVVQMG5mFruqlERG1XPJ+VIp/BPkX3
L9ULXLsxh0RHjoOIwwU1w0eW4Zm2m7y1MBPpK48+N9Mf3j8Sn8voHze/lmbkpyyJqQLabilG
hLM9q8k2c59ja8VRLqRuFgh41mv9DMmCViREvREyumA5oxwCa2n3brCIzz3ePLT0j1CrVVZR
JdvEy2C68rRHHZ2jgtJ6tD5QD6uppLPEiNL5gZjovwd9HT1T2mau9N6mOw9R25WX57eXJ9jC
dEcfaivjiiG0hYJfeWle6+bxQKY2y02eX7TPKDL8zJq84J/WUxqvyxP/FC4GKQsrJah6W9j2
uSkTYBcbra1q2HvWl9u8dSl6h483U+z2nIIdkvLYWVR1HfZBgw5SqtwZBxL4dyvvA2FDWlAj
U+OQuzNNwo5IlDUiDI3YwY5J4JgpL5vCOAORQ2Kfxm7/762IXmk8xjQUdVLsxJ4oM7DV7DSW
tNnr5xeYyBjZXlm//rh+eXx4kmUgdtX4BZvjVSidGaiLdXO2CyqJ7XZLLumSwSNRJdbUiX6e
J2ueZAfzDQ1S0Uywps6MFJjCXxcznS5okk1sjAA1e2knHbEss7+W9qQW7SItoEwi9MGuLGrl
W1U75uqpVtNoXyY5B9CuKL6ZIfVUCX4+JBe7j/NNWtsdvzXVAUnLyjotyTMThI+w8c7i1P4K
8pP30N7uPVx8nXtimSgrO8Fjmpzkbbjnq92ltqQEUtOIxYlFEomd9u9sU1M7JsTEKS32zEr2
kBQ8hellZ5dFlsdjSUycWQr7/fJIWxhIuNyl9nwyGOQmLodO8bVhDm1Y26XL2UU+jLFLA1JT
DjtfWmlUl7zcCis1vLGr7WGVN5lIZc+b9EL3f4eEshbJwS5JxQo8q4cRRxlISY5EsOxSnM3E
KpjHasfvEo1DW51OnDPosDc96E9rLoMmXcjb68gFLlw47oo18i0JKFdH+sQCYZBS0IQ3YGlf
4GlHnuQp0QEyEJ3tb1vHRcJys45ASjIO60ViVR5yrzLzxbUcbTl1RSynMJqsMG4eHw5Ev0Dk
oEOI38uLnZtO938t0mNplxHkD4eG8H2xh7lvtUKDa2pb6WdEUpalaV66AuecFjmlTiD2OalL
uyY9zV+Lz5cYVtTSWf+Uy/V231AB9eRSmnWeynu3bcRiP0S0N7WQISN8GYaQZ8qmToh7PZ3B
3tuTON4xKoWBdAjWw7o/9pHW7soyTs96/nZW9kfdw7SBn+LFCpf7KG3xJgKUT3VDoqlU41M5
kwhLtBXBG6n4UFHUKTVXEW6yKm2NiEgqqaKw3vMiGXY6+3bPeLvX5VfDN3amtINQmURRgA4a
JW2RnLo9+XCNlj++fbk+PT08X19+vsm+HF9HGsn3/uhxl5OSDyCQaws5pEUq0EFkJ0HMVC4F
ky5S8UEo/SpF9oXY3cLQej1uIpFZBbE7gctekDF3+cbzglE20GhErmIIfArNtKhwCXLcv7y9
42akf7zp+FmUHbtcnadTp//aMw44mhpvdoZLjwHA8zbYCCSccQodT4A0KCHzkdQabzJBlrRC
2D0lcSFwzMiXHJ6mk2xbntFZekpUnpswmO6rrlRGvhhJPFieEfJ27RbGACRg8+gdhsGewoDK
oOzK5k29CWbhTQaerYPgRub1mi2XaAnmNDo2iemSvacaTup7onwdmqsz6WHMqQPOSfT08Pbm
+jeXwzmy2hsUj8J4oo/EU2xxiXzYIRawxv33RNZVlKBLJpOv1x/4Rm7y8jzhEU8nf/x8n2yy
A4qTlseTvx/+GV51Pr29TP64Tp6v16/Xr/8DjXM1Utpfn35M/nx5nfz98nqdPD7/+WKWvuOz
u60je6+gdB7cTFrKUEeSU72ibTSMXJhgW0b7h9D5tqDN0Ns0nSvlsWFtq2PwOxM0xOO4nt75
GgLRBWUlojP93uQV35eeDFjGmpjRWFkkltqvowdW58xXsm5/3EIbRpSaovOCLGubzTJcWM3T
MK4P+vTvh2+Pz9+0t1f6ZI+jtd28cpOjxsBITatRGzCoR0ImGAxdFAb7s4b0XKtAy8WiXAnQ
gorWIxAxQz305BlBancs3iUUM5FILsVJXEcU2a2XAlQG3vEveWL0A1lbp5Kds4SHd5jif092
Tz+vk+zhn+vr8GZayrCcwfT/ejWcEkhJlZYw8jLqgEfmeIpmdnGRJlUqb2Elhyd8x4APLep+
+m/rqVb/CbeP9YaEQH+132R3WOhS+r5RT44fvn67vv8W/3x4+vUVTz6x9Sav1//9+fh6VXqb
YulVW3zl/MfgnsJR5jB9dEhRwe7cczE48JHVJ9huCGbJIGrYoMPE5BzUY15uHeUQjWrTOKFO
bnrNYLW05rkiBrBfc7zbdPwqboldfoJPjQDJ6UvKPxKwB2S7EweqUt5BY5sNPXxmquDkig6b
+6U1RIAULk0SixvRnC2BnRx5srPrkyW7UuDJll97vqH/9PI9uqwiMuqwYpJWmlZvxfKQyyRu
RZy2oHU72yh5YtxZixO5SLjNt6B/Mi7wgTehNaSg12+OO9qWSFbUp8UJvFyEzdKm7pzomiOi
PLG6TslovPLrxBbDyZ7D6JIq3TY94xtbeyTj2dX2ZOd0AU7qHlOm+Vk24Dm0P0KdHn6Gi+Ds
V2L2HHZi8MtsQYaj1Fnmy+ncLC4eKrXQMejzwakrdEbJjSNq2Z/CGg7ydKrXMswhdsb7BL+K
nrBdlkB6nmKfpVaV6xpE9f2ft8cvD09qNaKnWbXXSlyUlUorSnQ7ZLk44jJ1dHbwKCVm3fMa
7XDEk7ORILn4dALJEaxeJrQVJR0suYxW0TsQ69TK26SQQHudrWjyVt3WcWOj3Ak56q5y7Ibr
6+OP79dXaI5x32z2whaHpK3P9Vs+Qs7v6tarhw17Mee05MzClW9a5ccuH4s2s7ZzvLDddvdU
+Fzufa00sCiWHN8Ap5MZ6N5huApJIro5IjvvnMKcPNsVVTvh6Y0mUjfB/U5ZH7hkX5lCYIP+
AEqeCluou7tQUH54m1nb3H7Q2NQEVw/7+3KTnG1a4WaTuKRqj/sZhzFxi9hsuMtYF3HKbWKO
Ji7jbtXA7Pm1bZtjZJOMe1pFEnbR1a+ErtTRCcWC5oPu8K3UPYvbvAPktPKAOI2tI2RzDgxE
q44f210zIENX0vXUe+WjCm9hOLbcVwS3FzXI6TsNU11NF2/bH8Z83GNyNJBCtFP1f7xev7z8
/ePl7foVPcj9+fjt5+uD5doOU8TbBksXEXuHQHUHkp2e2LmjQUkgZ9A3RYR3Yn56VxDzcG9E
ZYl8J80j22jeYEm+D0dCJzkFqo7u8vvR3NpRfan3ZBy1HvGI6sUhdU5QMKRn3ubeJVxdx9pJ
SSLVfT0UEYumfcFjofFmV92AT8kmYj6BgjdnmkajrSgfD9wxI3GpSJ+kMge0EFJeo8waI9BH
O8Yj8RHNc6MNqlPNk3vYRZHxszrU9bCRY5S1rIyo+1SM1tk2rBb2B7bDKHUOkke/8fg3/OjG
NYKRjm+HjRiP7doqEmxUpHk3x0DNdsEUhyey3IB3genc7zKxzekkS1j+a8YZ7dnI5JObgJsF
QC5xF3izik9Rzvek/9qBDe1GCt2wd4S2+FN/Oj5CeZptEtYIEztteGxSWBaZW0TZ7ek2x7Nx
T7HcRgUZVu7byOmmaLMi3WsgdpReaK3BLYEGlWjPVw00l5l7AxVOlzB9rHboz82tqK46hBOb
zia6dwblnt+bhP4xbmVz5uJAdck5KXQ7GG0g5PqNmTZ88+ViTgHJGUR3gaG2zaPsPMkx9jg1
xfEC1TQXkbeM0tqZorWOfY6GSdkclVlJ6wKSc1PjoUCBpy37E26ri13iGhMCq7uhld+zYjYN
F3fMKhyrGqdQ7BROA+ocQBUkypcz+b7HKiDSF7S7fFXXejoN5kFAe22TLEkWLMLpbOoJ7CN5
pC34RzjlX2hEZ1YjoG3zPCSId4ZlPlLtmBCSCFro3HiRLamn2gy7KIkYxOFG8axwpbIcGPlu
ThBNg/WOvJieabuiHl+cz52twi02NB/3lTHKkmMJOlWa0bVb3CgAMiw9MexUo3UhxQQTpGGi
ZLJj9A7Ehd2JMYuCcM6n64UFEDGx1CiOw/XUbdguriufhzeHppgt7mgvNWpiubb7JgMRikWH
RcTQeb9VZJFFi7vAGX5uCJ2e3AWocafN4v98OZciNJ+qqVbhs2CbzYI76vhE51CPhiwJJa9+
/3h6fP7rl+A/UimsdxuJQ2I/n9HzImGyNPllNNT6jyXjNngUmVsVHsJOGq2Qnc3YwT21No/I
JRl9DPoqWKTRar2x256jWc9FV/VVT8mIlKOpkCNu7K5FYriyJz8VqVKx79xd4vbp4e27dIAs
Xl6/fL+1QjARGI6AFZWDbFwwJy98tbO8o304DWWfBt6RoQXdNb+r8TEbdZvdoeuF6UJDNfgu
nwXmW+BhtInXx2/f3Op2BkH2at3bCaFfRls49FgJy7C6SjdL0eOw/aJ0BoMnF7H3+8FVpb91
e9bbz6cN1sjjP9RgYrCVPqaCumUx+IiFaqh9Zx8mh7jshccf73j5+DZ5V10xTvDi+q6c13e7
v8kv2GPvD6+wObRn99AzNSs4OoPwtp8KGvFRFSpWmEcFBgpruuUlmE4DH2XYc3lozCY2Q9KZ
9SBbWW3R0g36QNTuIFgQXEAHZPiiXHuI07/iePjr5w9sQvkW5u3H9frluxbit0rYodFU4o7Q
nWroHTkgl0LsoSyF4MbUd/GKfthpMVZlllFmsRZbExv+Yk10U3B/UeIkEhltMu0wgrr/7xj/
Vd1iK1+S6ZBcqshXsQxS8GGddb4nb14dyoYyZjDZxLnSzUys8uOhv3484xlOYxlS+L+AnVpB
7WgTULlgk16ibSeP6kY75ZeQY/RSi6g1XIcgARSh+XIdrF2k32GN9lxA3EewebzQVqSIAyZK
8lwAUTsEKpCKY54Ml4ZAmDz2Poq0ZQQZQTHcYvJbp0wSqeqSHkMDBy1kZLHqY3+hOlhSY1Gc
1btnVjFRz2ZNZOidzWbxOdHth0YkKT/fUfQznZIMcOrSY46vtH30NgJp3eivAXVc1280+nJF
5LO/5OvFkqgIqBPLOys83Qhh3EVvN4w8ZPSwkaMP0WghfcB4J9GaLyJorhuJpjwLQj3avAlQ
Ld0hRDnOQF+45Crarhch0WQSmFKNKZGZF7HiweoQuXcZmnAeCCMAoEFvT7Gg0u1iPd9Id3M/
Cw9uslqwchexQ4z1XRZhNL87qhx8tpjdTSmtoufYgg46I4dgDbMp8AQrHlkWazICrJZGSPRv
ks+mITH16uNsGtLjEhA6jtvAsF5Pid7ni5wgxjDD14MuUqW3hRR29h05gCRCOfwzhElIfSoR
T5hnjWXuiY+os9ySAchwRw1gFD7BkmzrO9qD6tirc+h2ovdQdswJyaAEHSEYYP6FATXP86ha
3VkDR7r3K+Lu7HnoOdwmfrjMxHwWzjzdgEi7P/lOl8yy3mpqOXrvIjIbhbnZOE27VF5aTQPN
m3WL8pK7LQj9HlKSH+iG40SdviB6Ale19aLdsjzN6MVwuV54xvdyfffR4F2F6w/nwGr+L3jW
/yadWwIk5uHc9I4+IPKU7tanfcBxW8yIQ7ASjJoR87WgegfpM7I5EVlQviwGBp4vwzk5+Db3
c5DDt0V5tYhuTnocv4QYcYJYjrPFDd7bYZ8vxX1O38/2LIU4m9encj68PP+KBwLmbHC+7S7L
bi16An6bUqtsF4vYbf3I52Vu4OijINsNu1JGdYPfBH6FLcrr7SmteULqkDhn49s3h+Y6q9Ow
o3Pzqlwp58z1PIlB6JJiZzioQlrng0ne4RRJZhbCumNFiv7+Ee/Zagbjc2fYfsWnlp1T5Nad
kfEMtlzmjZY6x06B6gmeU0V7TIa6Cc/O9v2YsjPrxmAbV/SH0j3OHvNs811u6HgjRHwHlcIK
OQ81OvqNL6wrSiAnVhY2hp+QL+55Y1eaw66OLrBq3EzxD+Mienq8Pr9r44LBvjuCPbmdMPxJ
2gcAfdNs3ViVMpltapol8JOk0wYbXUpEw0mgzctjMnpG1QuGqN/6tGPoQ2LR+/COaZ+wig7b
adVz/JI1Z7/td2M8k03LNkq3JqGSUiAp0vreBGIMWDUAYzOhoUTiaUIMBZvUUclpVVLmh57Q
lCGSl6dIBH0JJhOoG04a/gCWb5e6S21Zja1mM3ncAiUt87yRZjOBiejVlJxFKXnJokgG2iRE
QrkdnxXkWnsjhCbAVgkkpc2TwlOAuKKm2VE+40hLoVuQHs3XTooHU7ZphvGnIuEzRqNcknrk
tHGPQtFxBu9eh3fuiz8ND6m/vL68vfz5Ptn/8+P6+utx8k3GfyVewO+hi+ojORs+SmVMZFcn
lw15WRphIDKjaoritR8aYHWCLyd1+jlpD5tP4XS+vsEG2xKdc2qx5imPWie6aQduyiJ2iN3J
l13yitXeMLUdC+egRRa0TtSxpJzdGKl9Vvj82lPkdbhYmIYqHcBi+O/ERLSPyx2NMkw4mM7C
W7Dhz5GAdYdUBLycE22nMSxJ/cvhC6fmRs9loIOCOXyzwIxB4DIsSI3Z5TvrF90DnGFnLEPz
HM5EV2fSCaDJtA48LSfRu4CMM+Ew0aVAjTgNaAMum8nTWj1KnbI5THRFOpQ07zCZ2tiIKN9h
eZVFiEDH0xNAMlRROFvexpczW0+zONIwpE6DHK6ZO1PgL5FE3krEjE/XZOliMZsSMw+dVch2
U0Fr7RLvQLjtq5haKXv5t12e506yaVTZdrxDCe83Javxsbhbmt/rGVn4A94MNt37fruMkfQL
AjUnY2rYTG6LKkR/I24guf+jnPoqT+ZU1XJ8cH/vkIu0XS70Q06dTnYJIsvpjQmPDKupK0uA
nrFNFZEtXMhVwbrUNbCcdHPZsdQiXpAzmy9DyiXrsHjqliTD6pRHKdMWKKLDoU+CZRvR+rgx
F6Ib62Ahh2O7ggkfuX3coSgR5pbFqt2iH2SSo/JOJXDfMBmODfKpbiYi3zB5VuxY3K0Dd8kt
5FfLhR4wa0wtbtwBoshbpqubBsTTnbmx69BjflhPb627oFS4MgI1DVr94O6sOqifxqUpIbhv
CW1aWHqnCQUIQuQW6GKm6WI7uJqe21+S2iZnZhveG3iXLPnUkQu2U/kN32LwgwxGYhx5To75
wriOUz6mdRu6LtG2dwapbWbipGw/lzUZT0OhadXM2jSXcWdUEOHnr68vj1/1s4G9ungeIwZ3
LHYB5PKgFyATSbuLc1j3SdfhaZ2c4J/zyG57EuIiA9qKUjDQYEC75p+WcxePIMMOng2PQne8
3VY7hoFQtF1pkfIL55XuVxM9wOuOBtXfLcNwOsv5od1mDraJl8vZfDW3ehAhdEc9n27oWwad
Z0XZKGgMi1ns5NuF5nHo6JY70M+mNbrhrtugL2j63MM/D0j6fG37kB8RaunoGKooXi906+GO
XrP1euWWjC/jacjcEmB4xyCkSsCTCuYMZa7XM+yD4P8Ze7amxnUm/wo1T7tV59tDQoCwVedB
tpXEE9+QnRB4ceVAZib1AZkKUN+Z/fXbLVm2Lq0wL8Oku627Wq1WX86v/BLrZDSe3lAlyojv
p0qUBHSRFxdE4xF+ScDd9EUG3EpT2MEx7ZEVOlLDs3o6PqdW6Soe0ZnpBvz1OTWqqyqBL6/P
aR1tR3Qnbc/KhrL/yaWOAj3OCl6Y3DX3dCAS4mVsktAkzemXDomlU0Is62vrNaBKJ6a9/SbN
UFVdy/Q7xlCmPEuky7mtU1rk6LmA6o26pXUct5npc5vPknaRXmHAr7oy05Btpld9CLLW0/6j
0r29M+nhRxvlpR2Md8XuuKQjB0Wpf/HDOsqAb+IsguDyCW2zWBUJF1GZkfO4ye12VRyELQuy
SVmZ69YPSqEUmPI9HAl3ZFBOFnOxSKzeIajFIyLjpPZR4e1aWA4nQk6rOfEWWd9Fq6Yhz1oV
s2Oe2/GjZd7tjFVNSetvJJ5q5PAmYU20EgYxlB+Vbny2+po29aqr0FiNHbxhUWZ7g84rPALj
JW/aWcCnbVGpLCokUje9XZTNkpPRqyt7epsY+Oe5O/CY9kM0VJ9UWFCoIGFm7i40mF9WLNHv
S31JFkIpBmcsRuvTlJSqCPpALSAG1GzGHTcpm8TjOzZajVKL1qOnmpLZg0MuAbnjTuxFabJY
V+M247Q3rEMWCB2nqGRk7nUo2033CFc0cAMet+tAagRFlfMiK61IMAq+jpqAS2XtcSg9LOXo
suUgqRm2UlWsXiilI5hxO+rzjDs7Q8NvTRavHfcikCtmyzTLfNTCXowd1OUmOOVxHrC6zeYE
Y9Dd6BNqew2+rxueX18576oYBrhhwiNHuxjlKZ0WQFA0KbNj/ObZpl9bFEe5gxXSCNcPsJvx
qvYnUgQCl3YeRxjoOFYZ6k6QRZvmDu5vaHPbBF5z0i4Lb5OgPyr6NYdWULfwxCxLPiercvVA
e4pkhWFg04qSFrpexivEu+MFYH+8kJZ+lDLwXqxRq54W7qHGGsUu4LYeINpkAISXyr57LgTc
Pvvy6RMoh8OGYXLnE+tE3kLthML1SgDjDRSuDwdMZBKb1uIa0laYvlPYeqK8LDpq8/bcQTtz
E++5OX4+PP7bdNFi0AOx+7Y77l4fd2dPu7f9d/MZOo0tTQgUXFcq+d6QpOP3itRlZPnyfDL1
Xh50u7UlLq1IMajganQZKEPa7J4uoE4vrcuYg7oMokaTEGYSxFyfk5g4ifn1+VUQdzMOdTCu
UXXcxhS3NKse51U9oruCFiXwd86LQB1ZGS8KNmeUc5xBto4vyfKj5Ho0dV5zNG6WbnjS5rml
ScIq53kbz41H3c4EZW2zisVdXaWFG53BWN714eP4uPONhqTXl2VxoyCVKCNuNaUWcZtOx6aZ
H0D5unGh8ieO1dKijIC7+t9jqXavZfhSjIcIzKi5mkT+vnL60n/I0iwqjeHtRaJ8YQxgFRt8
V5sXWd91BTnB3ZSNQVqumQtj5kGrQIPTh4phuXvdHfePZ8r2oNp+30n/MCNe5pBO5xNSux4l
vtqnbIfoYpbDsdwAE1/NqZQ25UyRu82njahcw4kO21k16IKUB8nu5fC++3k8PJLGdhwzCfiu
It0QEB+rQn++vH0n7N6qvLaUnhKA1mbUPlXIwjR6lRBpmTVHf9owBgEu1rDy0M23mmmcd5gN
Ce9D3hatYSD+q/719r57OStfz+If+5//jV5Ij/tvsBKGkChKhfryfPgO4PpgGzJq9SmBVgkB
j4ft0+PhJfQhiVchsTfVn7Pjbvf2uIWFeHs4prehQj4jVd6R/5NvQgV4OInkMpbrWbZ/3yls
9LF/RnfKfpB8D9+0MUN6yZ8wBbF8KhVwv7LTav1+DbJBtx/bZxir4GCS+F5EL1Ei1Vtls3/e
v/4TKojC9n5rv7VsBqkP1UAzwW91zd3Ps/kBCF8P5uh1KBAM110ooLYsEp6zwlLBm2QVF8hs
GW09a1Fi+NUa5Lhhekw0ep/XFYsDaORo6Zq7nfDyDwz9VTfToTS+wRuGLoD/8/54eNWx5b1i
FHE7qxlIV+duIY5bcAfs77sXkxvLScLCywsHKVB3ZCDRjSaX15TXwEBxcWE+lw1w7WtOIKYT
EtFFSbDhVVNcji7PiU6IZnpzfUHZq3UEdX55aXuvdAgdR/RU34EGNgmGwyRTP+ZwggjLZhMf
ZdAyEKMD03mIUlLrUDRWOhH4iRoFmrBNbY8tBPGKsi9FjArS1diXHkSApDavSjKfEaKbsjQu
a/ID2Fo2RLqE226la7inqbisclnDT2Dp+6fvxJpG0pjdjOKNGQQGoU2djkwnHITN2JJbpR62
xycqUNc6T5H+emo/ZvQfhrYYfoSb3hyn6s6P7JCK27NHYHJ+9kDAoMRo6VYykKnJwFgsQZFP
28DqVDpu2ca6qTB4N62MFxwjGztHioVTe31+F/y4SYeIHcpxZ3EP0t7fb5KxD33U6cCtSL0G
EARn1E9aaBmoFG4QFhBpY1aoNYQRfs2wD1Gct8uyYDKEMvWddI+ANSqExVNNZNeGYS4NXJ1y
QUYqsIhYZieyQiRa96f5ZprfBsJuqTHYIGf1RwKR1Ya142mRy9DOARR220blrJJxN9s8ya+u
TFsCxJYxz0p8FRSJ+b6CKCk3qkjSbl8MVEor/5BK6x6xTUEi5JGjMWljh+jORB9vkSXcctyG
DGg3HGC/M+zl2JeNZ7jj79Lp91hF6a7TBGSItPjKY4uFJk1FqYvy2OLKeewlebJwWeX7+1S7
I7q/bVHh8nJ43b8fjpZFsu7eCTJjL7NAYEo7NPhEX8jaO+EGvpy0S6kXdO181Wc5o2Ml+gYT
RSJKO1lqB2qjFB/WXMVj0LAiYYZ8rP3/zZ+9m78NrPDBLzFz53XphluOdzqvFGFEFljcnb0f
t4+Yz8Rj4rUZIx1+oA6iKduI1XbUkgEF7WvJYBBAoaM8GCC4gInYDCbi4/pANG6FHX6GmRwo
+VatfTO2rIbYdnU91FbP9+C5HRW2h9dk/tseDYyCqrmhqhjcvXRaOH9S9EcoVXnakgrXWGtH
//ZQTgxwKZ7lc9ET1nYYSBcfrysC2Sm/6C/TmE/OA7icxYtNOSawkUgTO3lC1wLMb/TAOzz1
uqTaUmH8n7hcVZl5jMqiBZ9bWVzLGQ3Xoispzs5y+qmhJ2Az+v2jJyjSUsdzA0mmLdxogy69
tV5ntf1DJ9Jri9LMRouYnNWNFyjJQCzM0CgGXIVBtToPyJrOLSVREXeMKQBYmmq9hvcSK/yX
uleb4P7QwXcwmMeNnEnl2vLx/L7/+bz7x8qbMJw9q03Lkvn1zZgSaTpsPZqYJnYItccIIZ0O
dPCGISo2brZlZZ28dVpSNnB1luZWqgYEKOEjbkRm8wYRq1c3Qz3b21abZGJVgcRryn4z4I+3
K5Yk9lVnUOQ2cESDrICJP4JM7JabIUwt3yZpfCOlpcQOuittfpx4MoN3nX3bULHh9hjeR0oy
prIjBu7A27tSJF00KuMCxLIUjVpaDL/ORG1t8hqVnrYMBNfXMSDoW/FFa6tqO1CLYbJhqcT0
c72mqnm8EnSkMiCZ+GVP8FbVzkohWxX+bKjfuv5PzEodjGMGIWGDeGOM39cosVQA+DvojYUx
7CM5GYZswVMYdIwJbwcc0mAgjukwWD0JKpoxhhOtcDAqaDf4lk007Kuu3/htDtrQvdPzhGhn
6OQXmEAZA+8aVWycKvF396rQric2/HZVNswGEVOKYDtCN0LKAo4xriJX0fZFKM0yQb+Jb3SH
iM6CGDx2Zq2MFYwsK2rULFBqkTTrC9NrZeytCQnCsaQL6b5Qk+x99+k21FQnpleSyAVJtUw9
yKgrUBqIF6IrQUtGTDSVkqZkOOim8B7awrhYXK6gYCqSOxwj5EClcFVDvGW8jikLiljcV3Zq
egsMstO8tnBrbnOPHuTugwERrVI4hws41OYFwzPDKpHw1lYg8mSRGE+5NGP+Jz1SbqYwBm1J
5VuQPAxn9G1AUsaNxRow/easnoRWv0IHVq7k47anCIDCb3HOroOBzdi9U7aSY7aPP8wQDgWm
sjBeLwe9pULA5iIbWGuubchw6lT1PvEoFsD6yrlgtH2Zpgo742uKMsKd1bqZkfWAIY1MEmUI
OD3Mj4Fh4AIN1G/SagjVcCb/ggvwn8k6kaKGJ2mkdXlzdXXuzM/XMksDCScfUswWSKJWycxb
S7pJdDPUe0lZ/zljzZ98g/8WDd3QmWSihghWw3dOs9ezIKdlTf8AHcM9ocI0QZOL64EzueUr
iP4mLfHxFrPnfPl4/zb90q/OxuP5EhReGxIt7shROjkSSoX0tvt4Opx9o0ZIChVmFyRgad+K
JWydB4GdYTYqKyqHAHXCTeYAcSAxI3dqxfGWKBC0s0Twwv0C081jHnUVYHzALrmwstM4up4m
r7yf1CGjEN6RuljNgU1G5OrIORqtx4Iz28sP/wzzq9Vz/hT05aCLvdyh0uTRZnkC0wWE+ClL
vHXUgby1otGzUFlcnn2u8K2B0Nm6lv5LlHGbI+LB7ypbuS2Lgt2IvF4ESb/OXPlJQzrOd27K
sB1G6jBVtrtgkfUqz5kZ6LL/Wq8JF04soh7n3zYUyhCHQGZBScNmoJLoIUupZwGFzB5Kt1CB
lk5+MSAHp7Rw1rUFs5K3RVnQehmTqMIsmY6oSBJiJIlg0xXJjK3LlbC6AQ11VpCGoC8CPsQn
auQIArIgOYQUuLZjdysEw/HTsgKlHdefe9yhx5yQpYeurJoFL+ByxGzBM4YD2ey7+q0EW+VU
YyOc+OP17YrVC3KzrN27V54WsGRNSJl7e29RhTbfbbGZOCUC6IoGeYKI6OqiHngwxZd5ssjf
/TG6RPsk9Imp/xqdjyfnPlmGmg29ubxyYI2YyOHhSKMnPTrYOKRaxOE6ppPxqTpw5f1GJcHi
3T7qsSG7U3pk9Ksb1bHf+cLsK0VP96lv8pen3bfn7fvui0fovGd0cNcsrgMLMnkZnKFrZ0Gv
vGU3nDPCv6uYV4W7UizNo5m60ptx4ODH0M3922E6vbz51+iLUWZW95JkC5IkXeBAcn1xbZc+
YEwvUAsztc1cHBylP3NILk98/mmLp2Z6bwczChd89Xm77OjFDo6KjeGQnOjWFWWT7pDcBLp1
c3EVLPjmknqhcD4fhz+fULEu7XaZQbgRAxctXHXtNNDc0fjE8gDkiN4LGSYUiVPSoMiodUQ3
xuuiRlDxcEx8oHPeVGrEVbD1muL6Uwo6XKvVSzqGnEUSWpA9gbN9l2U6bQUBW9kwDJMIRykr
fHDMMRsZBS8avjITiPYYUYI0QpZ1L9Issx+sNW7OeJZSJkk9geB86ZcJN8SMmRHDekSxSptA
N8nWNSuxtCKDImLVzKz4TUlGZrcs0lg9+Q0HhAKBLCxylqUPUkDrgyJS+riyvbOsrqz3GGUK
vXv8OO7ff/nRH5f83jqe8Hcr+O0K08pLbQ199nJRp3AIFQ1+IeAmRl6lhgr0EaeUmiBCExW3
yQLuIVzIHtOnIFJJLWMnuJIBOzrxFwMz1tIerBGp+QJn3IcGwbWDBU7fvszuGD5NVDHSrkA6
WS2YSHgBA7CSASCr+5ZlIFzbOcQ8ohMouMNkGebvMfS5cHVADa0yr7C6iW8isfwW7z8LnlWB
zMF9Z2pY4p/0tynz8p5+B+ppWFUxqPOTyrKSJVXgotgT3bNAFNahzWyGVoCBhLRGbXCpKe+K
NqtpNelACZwikKUVNdZzdzn1wEHffupTmeLHEp/TQBf5mmIj+m4yLH0zgi/07q8vz9vXJ/Tz
+QP/eTr85/WPX9uXLfzaPv3cv/7xtv22gwL3T39gipLvyCz++Pvnty+Kfyx3x9fd89mP7fFp
94oWLQMfUQ/6u5fD8dfZ/nX/vt8+7/9P5t4dmEwcw7KVd86yXTMB/U4bP+cRSdWlmjYGNsXQ
Gmg76ioLfArYGEY1VBlIgVWQYy3p5PMLTL2RjypUKRq0w1ljZ64abA/oMdLo8BD3jgkuE9eV
b0qhLuhmKAoZ1texJpKwnOexyVAUdGOyHwWqbl2IYGlyBQw1Li1FADB0nCOlqz/++vl+OHs8
HHdnh+PZj93zz93RWAmSGB+0LPcuCzz24ZwlJNAnrZdxWi1MewIH4X+yYObZbQB9UmHFneph
JKFxKXYaHmwJCzV+WVU+9bKq/BLwfuuTguQCArVfbgf3P1jVYWrMS4cRLbyIW4pqPhuNp/kq
8xDFKqOBtoeuglfyL/XipPDyD7EopForJgoMCE96daS5X1gfdV09W3z8/bx//Ne/d7/OHuUi
/37c/vzxy1vbwgqopmCJv8C4aVnVw0jChCiRxyKxc6rpngRi7ehxW4k1H19ejqx7hTKK/Xj/
sXt93z9u33dPZ/xV9hIYzdl/9u8/ztjb2+FxL1HJ9n3rdTuOc38pELB4AUIlG59XZXaPAZqI
fT1PMVEG1Td+m1JprvoxWTBgxGs9Y5H0a305PJlvsboZkT/88SzyYY2/D2Ji1fPY/zYTdx6s
nEXkao+oG0yH3RD1gSDsJgbW44expJsVJSbotqKrlx6kBeb11GPkrRY6QL7mkVaeAN1YamTX
ilI9le6/797e/QkR8cWY2rgK4QdeIaj8mUIojG6m+JFb9GaDbP7UdokytuRj6gHEIvDnB2pu
RueJGURebwryvDG2g9uGPCFDrWqkv4PyFDaCdNjwZ0LkycjUiemdtTDDtQ3A8eUVBb4cESfv
gl34wJyANSAkRaV/kt5Vqly1EPc/f1j+TD17qKlFzzEt7qmZRIoiPRG/p5/Q8g6DdpxkogyD
c6S0hN7T1A2d/sYgIINPdEcG2c/ZZ8dix139QeeislyLbHhb13zcXk6J2c4nHgyuwHYqFBve
RWAIolU1apYPLz+Pu7c3+7qgR0C+Mvhs1Xxk62DTCSVEZA8ndo58afAK6h7llGc8XJkOL2fF
x8vfu6MKIaAvNt7qKuq0jStBvkjr/oho7uQSMDEdN3VLVrhP2JQkikkjS4PCq/drincjjm52
5o3AkAFbSkzXCC05u63p8VrmDjerJ6UkaxMJ22Xti7s9RXdDCLaEF1JiLSN80wkE0+vZE22N
ZVwMpNmrc+N53v993ML97nj4eN+/EhJHlkYd8/Lh3SmiHQ+ppTxQnVjSQKQ4gFFSiCRQCS0g
+nRJoCv6IAM5OH3gf41OkZxqZFA+HHpwQohEosDxJVEEU1v4whp6ZFQs6YKueJtuwOLEnmLl
A2G9IG4HHBPLOGpgA7dIZ0V7fXNJxnweyFiTo3/82B/PAUvdOgYsjtj5hFoZSBPTUYAGglvm
ny8dHG5A05vLf2KSw3UkcSCdl0t2Nd4Eq5nYeR3oNqx9ocxqwyk8VB5A9yFLfBSqIzcxp0RQ
NbAgEJ1k7zhDeVbO07idbygpmNX3ec5Rzy1V5Jizx1LeaGS1irKOpl5FNtnm8vymjbnotOt8
8MwY1P7LuJ6iAc4a8TKmoqSh3tuB9Loz1OKek4fC4p0cSzGrQH0pT9qKK4NptF7Wyn7fznZ3
fMeoHHArfZMBwTAA2Pb947g7e/yxe/z3/vW7mecKH83bRqzq7v1BWJbYPr7+68sXB8s3DbrR
DYPkfe9RSDOkvybnN1c9JYf/JEzcf9oY4PjxEk1vf4NCHkz4P7/Vgq9LNYSKwC3EwOtuD1av
vzHGurgoLbBXsD6KZqbPxyx4MCp1oqlm1JA24kUMApEwHjXQoYKJVpogmiYpzLGoj1K4X2Cs
TmNutEM/XD2KGJ9MhPQUN1ekSZLxIoAteCPD/tU+apYWCcZHh6mIUsvfSySWY7xAA69ilUdW
fgH16mWGVO+jEMRp7xHloBywNElFHTqmFdCOd6nZD0mBdu/AEkBoLcqGabu/nuXEwJBAMLRA
Vp4goPDvttCYZtXaXzmx9+Rl/MRDZkcADIpH91PiU4Who1l3JEzchYIlKwqYG7rqK0skiO1f
1+Y6jHpdxUBgGDgorYIx5vi248s6sJCTMjdGZEA55lsGFJ1iXTiaF6JEal+WHpSQ5kAd4zMD
SpUcsjJDGzWyJaZdmQOm6DcPrfJutH5j4F0PJiMjVD5tysx564DMjNk5wJoFbDoPgfkF/HKj
+KsHsydp6FA7f0grEpE9WOk1B8Tmwd/MxDswyAVJC1eW0rpOm1As1NycUew4y4s1y1rUuJjy
QF3GKWz8NYdhEcx6XZbel2bQAgWSHnIWs0G4nT0Uk4ya8XkL2U6FAJY6b+zkqdj0jElTuwW3
454gNnbLrrgArqkRSpe4+7b9eH4/ezy8vu+/fxw+3s5e1DPb9rjbwlH1f7v/NS5i8LHMLpcr
881zD1Gj1kwhTe5joqEVaMHC5gEmYxUVeMm2iRgp9GIO1wxkoRwHZmrYkSCiCufek/lRWUWd
oPU8U4vM4FzSra5/ozYQ1aoV1nwnt+bZlJWR/YtgY0VmG6vH2QPGQjeHNhW3obDceWUnoIEf
s8QoHWNzoM///1d2JLtx29BfybEF0sB2nXRy8EEjcWaE0UiKKFnOSXCdgWGkdozYBvz5fQsl
cXmUk0ORmnzkUFzevgDBdi4wXOrxRV1mugrf2Va16GNdbbJEyPmDYwZblex0kHO2TS43FSrP
wsgubBeDeBB+9bryZli92o9YYyYYO13VGGuS7vvETttLTZmq7aopbNgmbhA4DyD+Z9M910D8
xshqw94F3Jlr7x95aGp9/Hn38Pydqrt/uz8+3YbeRMT57QcTAuA2pomfyolWSqk/KDoxG3Kp
ykrKjrgDiD8F8HXFZFf9JwrxpctVe3E+3SQjhAQznM9rwcoz40oz5dWInR/f1zLB7NgLNWxt
iHhKa2C/1hVKYqppYICc2w9ngP8usayDVvapRU9iUqre/Xf86/nu3jDpTwR6w+0/w3Pj3zJa
raANnlnWpcrLUTj1auAxJZ7KAsn6pNlQCjYy0Un+4j60zOX5UFJ9lzrZ4W1A+kRLG9atU6Fi
m60xMDuv5QfawHFQaPbF6vTzmX1bYQjQTkzgE0nZ3agkIz1jEvEn2ilMk6Y5K7yI9fgDNQcz
YzDWAYuAWq/b66GVYri5HQ1Mn1BXuV/DjyffVJhzp1fJHokZYnoxkO+Xb5GTi9dgjuz478vt
Lbqx5A9Pzz9f7t3a1YcEVRkgfdq1lK3GyYWG9bYXJ6+nEpRfhCrsQ5Nxh9nPLKHY7IIWdkYT
feyHpbPBaJJcM9wBc3kszBNxUSIiRTh9D5fRHo9/S+qdUbDr1jopQcop8xb5h8T2qKA+ezIG
BgQr6u1Sa8I1JtG1hUC7k1jEAEQe+PYIvcs3bbjKLL+MO2IxSFfC+wL8ARdiAcrEK/uxXx4U
oHvZCsjdquzkB2y+b2TMxAgr4YSm8aTxIpDYtdinOB4FhdxLpvtLT8y9qxiOqgofp2OI58hB
G6+0aTKLliPJVFetKnVeleElx37iJkUUDGOrvvS0h6QJrHIssVFGyOc0NSBTOeEogzRVlrRh
djf/vTBwf+Vvgd0y6VlaL2CY/h596Oav4GaTkm5hiXwTI/7ERbcewSLerggRs0XRTTFHDMJa
Abg8PKCxZ2GJzCt2OibNaJAPMgOlyixMCyPv9+VhqLdU9ShcVcR/NRgWmTlv2i4phGm5Izo3
p7YlP03hKjMZRLlp6UD3KFehjC5q4IlFZ0FAW6CG3HoJjfwJZ6iF39/lWyzruHwf6LAwN8XG
K/gjdMfJwj5BLBTa5+xe3YM0tw2pBvrHY2nJspqxYJa5mh+LAm6IPE898t+YtbOmVJes0bg4
PTnxIABlj0/u4uzjR398S3oXwr/EWmg7ONsAzbmWRI4owJXB5u4w4a1vpSD4d9WPx6f374of
N99fHpmR2l0/3NqyU4KFhzAU21GiOM2YOKuzjKrcSdJs1876DLQ0doiiWtgNW5+kq00bdjpC
UJ0A92gD0m9IwR1RYLNKa38xaMH7XfGlYteww+ysbaL3NtJmdnDqmr75fHUirX8GfHv5Huy0
egPYf8ESiekuq7YBJedvEi/L8qlzVA5w1d9ekJUWyC+jXi+dDze6chq1EaGwmQVpbhcj4g7u
laod44nBh41Sh3qqs4HLt9iNP54e7x7QtRK+7P7l+fh6hP85Pt98+PDhT6tSAFq7aTqqMzur
SCatAGAhKx/STF+po0l6nqKEfY5xC2xRh0+Pon1UWnaturItRuatmsouAXMkg/c99wBdrnqM
7/EBml5ztgynlZ0DXJ0bh9LXQQOaJvTF6Ue/mURmbXo/+b1MnI0WhUA+L4GQXojhzoMfypu0
K5JmAJGpG2c785GcgY5uOZW2AymsUEogeebA2T3IaAwlDoc2DtAEaiVZ8X4/PcjpKGaNo8Wx
bJxh4tv8nQs9/ipvH+D3TeEQPbd9KN1adEZfYXqlYLVJB2YPI6EeY1O6UiuVwZtna9ESc8K0
L0J9vrPM8O36+fodCgs3aMB1PH7N8eSROnIGMbzRr5e4eo7bU00kTx2xwgNx9cByYz7MIJ2b
g1ojn+T/atrA/mEBviLM0wXXXZR8GAOllqOefBMBBC5cUkjt3ohZRwR9INpY44RbgUDIkJKW
aKJ1Z6fOD/iXBhvVFzFv01hDx/lef6eA0DEX2ghKoZHFg0XtgHAWzEpSDgjK0i89Yegu069O
YURyyLP0vgFZKKuav6zxmMVNV7Lma7l32yT1ToYZVbObcefinUOftzu0LvgsqwSW5Q2yLajf
9sEN2IFyvlLgVJN5IJiRig4ZIUln50+SmoE8i495UpeINVTUnbILzY1UqYXgHWKPRwcCvimp
EWya4QLQRCMuLpjPNIjmkCDDt0Pv80wN1S7NT//+zFnbUU6TsCVJAY7mzggGSXeV5bqOKe4N
FG8ZbUdELrfh2BzwNhypu6KrHTGzsOhdP6wbkNBpZ5d+Z4+ZmZcATHGuIo8VizVw/FcsyJlh
Ljc5xhWoy+HQRrIshZBZ/RuQw0ZOihoCr6t0J5JNhrQY81BfQGnyc6OKda0XHBFuYAKy8Lr6
JJEFj9IHqCvkBEIYlTTF19HO1GnbG2H1aTCWHpJNuloeFZkrW28jAyjH81W2TkO+BHPJFZ2O
xqpj+mwfT09T4ILRowGLI0hOPbONt2KL2nBytTp5C0JJJsCpv6N/HAPy2BVNHWbsaGTfQ3lP
vvtpnSxZ9WgOdJSP2AWZwTnkS+5NvGFkH6jtyomkdECu2Zf2urLn2hOhQccQdPem2qbb9vj0
jLwtipwpViK7vj1aWR+60nZRY73HXPXQaXZt+tymrgz+87hv7iVy5vP1E8zIBqLps2reytwb
z+47HhwrnXRSptXliLidu94A1USzfcuSJIVgxBR46BoHKMH95rnBj9aWdzkI6WYr+v9tNKgk
1mgCAA==

--OXfL5xGRrasGEqWY--
