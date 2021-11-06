Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D461544709D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 22:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhKFVPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 17:15:09 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:51460 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhKFVPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 17:15:08 -0400
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id jSz9mfgMFUujjjSz9mX72k; Sat, 06 Nov 2021 22:12:25 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Nov 2021 22:12:25 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [dborkman-bpf:pr/bpf-tstamp 3/3]
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:2482:44: warning: shift
 count >= width of type
References: <f98d886c-dc50-9c8b-c160-6e8ecd895cb0@wanadoo.fr>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-Forwarded-Message-Id: <f98d886c-dc50-9c8b-c160-6e8ecd895cb0@wanadoo.fr>
Message-ID: <7658171d-e551-cc94-b6b6-0c8bd13d00eb@wanadoo.fr>
Date:   Sat, 6 Nov 2021 22:12:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f98d886c-dc50-9c8b-c160-6e8ecd895cb0@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(resend because of HTML issue reported by mailing list daemon)


Le 06/11/2021 à 19:42, Andy Shevchenko a écrit :
> +Cc Christophe (can you look into this? It seems your code is involved)
>
> On Sat, Nov 6, 2021 at 3:52 AM kernel test robot<lkp@intel.com>  wrote:
>> tree:https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git  pr/bpf-tstamp
>> head:   f7d619a946e981177777983af26e9e31163ffb38
>> commit: f7d619a946e981177777983af26e9e31163ffb38 [3/3] net: skb clock bases
>> config: i386-randconfig-a005-20210928 (attached as .config)
>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project  dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
>> reproduce (this is a W=1 build):
>>          wgethttps://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          #https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git/commit/?id=f7d619a946e981177777983af26e9e31163ffb38
>>          git remote add dborkman-bpfhttps://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git
>>          git fetch --no-tags dborkman-bpf pr/bpf-tstamp
>>          git checkout f7d619a946e981177777983af26e9e31163ffb38
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot<lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     In file included from drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:9:
>>     In file included from drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h:22:
>>     include/net/tcp.h:812:27: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
>>             return tcp_ns_to_ts(skb->skb_mstamp_ns);
>>                                 ~~~  ^
>>     include/net/tcp.h:818:22: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
>>             return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
>>                            ~~~  ^
>>     include/net/tcp.h:2367:8: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
>>                     skb->skb_mstamp_ns += (u64)tp->tcp_tx_delay * NSEC_PER_USEC;
>>                     ~~~  ^
>>>> drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:2482:44: warning: shift count >= width of type [-Wshift-count-overflow]
>>             if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
>>                                                       ^~~~~~~~~~~~~~~~
>>     include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
>>     #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>>                                                          ^ ~~~

Hi,

DMA_BIT_MASK(64) means n=64, so we get ~0ULL and the other side of the : operator is not taken.
So, IMOH, this warning is a false positive that should be triggered in many places.

Unless I miss something obvious, I don't know why it is reported here.

'DMA_BIT_MASK(64)' is used quite often and should trigger the same warning every time.
grep -r --include=*.[ch] "DMA_BIT_MASK(64)" * | wc -l
235

Maybe a "Trojan Source  <https://www.trojansource.codes/>" is lurking here :) ?

CJ

>>     1 warning and 3 errors generated.
>> --
>>     In file included from drivers/net/ethernet/emulex/benet/be_main.c:16:
>>     In file included from drivers/net/ethernet/emulex/benet/be.h:20:
>>     include/net/tcp.h:812:27: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
>>             return tcp_ns_to_ts(skb->skb_mstamp_ns);
>>                                 ~~~  ^
>>     include/net/tcp.h:818:22: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
>>             return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
>>                            ~~~  ^
>>     include/net/tcp.h:2367:8: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
>>                     skb->skb_mstamp_ns += (u64)tp->tcp_tx_delay * NSEC_PER_USEC;
>>                     ~~~  ^
>>>> drivers/net/ethernet/emulex/benet/be_main.c:5843:49: warning: shift count >= width of type [-Wshift-count-overflow]
>>             status = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>>                                                            ^~~~~~~~~~~~~~~~
>>     include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
>>     #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>>                                                          ^ ~~~

Same here.

>>     1 warning and 3 errors generated.
>>
>>
>> vim +2482 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
>>
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2470
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2471  static int pch_gbe_probe(struct pci_dev *pdev,
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2472                          const struct pci_device_id *pci_id)
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2473  {
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2474        struct net_device *netdev;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2475        struct pch_gbe_adapter *adapter;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2476        int ret;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2477
>> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2478        ret = pcim_enable_device(pdev);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2479        if (ret)
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2480                return ret;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2481
>> 8ff39301efd9d21 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Christophe JAILLET 2020-11-21 @2482        if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
>> 8ff39301efd9d21 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Christophe JAILLET 2020-11-21  2483                ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2484                if (ret) {
>> 8ff39301efd9d21 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Christophe JAILLET 2020-11-21  2485                        dev_err(&pdev->dev, "ERR: No usable DMA configuration, aborting\n");
>> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2486                        return ret;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2487                }
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2488        }
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2489
>> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2490        ret = pcim_iomap_regions(pdev, 1 << PCH_GBE_PCI_BAR, pci_name(pdev));
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2491        if (ret) {
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2492                dev_err(&pdev->dev,
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2493                        "ERR: Can't reserve PCI I/O and memory resources\n");
>> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2494                return ret;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2495        }
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2496        pci_set_master(pdev);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2497
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2498        netdev = alloc_etherdev((int)sizeof(struct pch_gbe_adapter));
>> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2499        if (!netdev)
>> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2500                return -ENOMEM;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2501        SET_NETDEV_DEV(netdev, &pdev->dev);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2502
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2503        pci_set_drvdata(pdev, netdev);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2504        adapter = netdev_priv(netdev);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2505        adapter->netdev = netdev;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2506        adapter->pdev = pdev;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2507        adapter->hw.back = adapter;
>> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2508        adapter->hw.reg = pcim_iomap_table(pdev)[PCH_GBE_PCI_BAR];
>> 9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2021-05-10  2509
>> f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2013-05-18  2510        adapter->pdata = (struct pch_gbe_privdata *)pci_id->driver_data;
>> 9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2021-05-10  2511        if (adapter->pdata && adapter->pdata->platform_init) {
>> 9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2021-05-10  2512                ret = adapter->pdata->platform_init(pdev);
>> 9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2021-05-10  2513                if (ret)
>> 9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2021-05-10  2514                        goto err_free_netdev;
>> 9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2021-05-10  2515        }
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2516
>> 2e1c8725bb834f1 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Sinan Kaya         2017-12-19  2517        adapter->ptp_pdev =
>> 2e1c8725bb834f1 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Sinan Kaya         2017-12-19  2518                pci_get_domain_bus_and_slot(pci_domain_nr(adapter->pdev->bus),
>> 2e1c8725bb834f1 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Sinan Kaya         2017-12-19  2519                                            adapter->pdev->bus->number,
>> 1a0bdadb4e36aba drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Takahiroi Shimizu  2012-03-07  2520                                            PCI_DEVFN(12, 4));
>> 1a0bdadb4e36aba drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Takahiroi Shimizu  2012-03-07  2521
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2522        netdev->netdev_ops = &pch_gbe_netdev_ops;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2523        netdev->watchdog_timeo = PCH_GBE_WATCHDOG_PERIOD;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2524        netif_napi_add(netdev, &adapter->napi,
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2525                       pch_gbe_napi_poll, PCH_GBE_RX_WEIGHT);
>> 756a6b03da98903 drivers/net/pch_gbe/pch_gbe_main.c                   Michał Mirosław    2011-04-19  2526        netdev->hw_features = NETIF_F_RXCSUM |
>> 756a6b03da98903 drivers/net/pch_gbe/pch_gbe_main.c                   Michał Mirosław    2011-04-19  2527                NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
>> 756a6b03da98903 drivers/net/pch_gbe/pch_gbe_main.c                   Michał Mirosław    2011-04-19  2528        netdev->features = netdev->hw_features;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2529        pch_gbe_set_ethtool_ops(netdev);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2530
>> 44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jarod Wilson       2016-10-17  2531        /* MTU range: 46 - 10300 */
>> 44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jarod Wilson       2016-10-17  2532        netdev->min_mtu = ETH_ZLEN - ETH_HLEN;
>> 44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jarod Wilson       2016-10-17  2533        netdev->max_mtu = PCH_GBE_MAX_JUMBO_FRAME_SIZE -
>> 44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jarod Wilson       2016-10-17  2534                          (ETH_HLEN + ETH_FCS_LEN);
>> 44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jarod Wilson       2016-10-17  2535
>> 98200ec28a66c8d drivers/net/pch_gbe/pch_gbe_main.c                   Toshiharu Okada    2011-02-13  2536        pch_gbe_mac_load_mac_addr(&adapter->hw);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2537        pch_gbe_mac_reset_hw(&adapter->hw);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2538
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2539        /* setup the private structure */
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2540        ret = pch_gbe_sw_init(adapter);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2541        if (ret)
>> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko    2013-06-28  2542                goto err_free_netdev;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2543
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2544        /* Initialize PHY */
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2545        ret = pch_gbe_init_phy(adapter);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2546        if (ret) {
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2547                dev_err(&pdev->dev, "PHY initialize error\n");
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2548                goto err_free_adapter;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2549        }
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2550
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2551        /* Read the MAC address. and store to the private data */
>> 9c020d7b0525d3b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Paul Burton        2018-06-22  2552        ret = pch_gbe_mac_read_mac_addr(&adapter->hw);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2553        if (ret) {
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2554                dev_err(&pdev->dev, "MAC address Read Error\n");
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2555                goto err_free_adapter;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2556        }
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2557
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2558        memcpy(netdev->dev_addr, adapter->hw.mac.addr, netdev->addr_len);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2559        if (!is_valid_ether_addr(netdev->dev_addr)) {
>> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2560                /*
>> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2561                 * If the MAC is invalid (or just missing), display a warning
>> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2562                 * but do not abort setting up the device. pch_gbe_up will
>> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2563                 * prevent the interface from being brought up until a valid MAC
>> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2564                 * is set.
>> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2565                 */
>> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2566                dev_err(&pdev->dev, "Invalid MAC address, "
>> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2012-01-16  2567                                    "interface disabled.\n");
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2568        }
>> e99e88a9d2b0674 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Kees Cook          2017-10-16  2569        timer_setup(&adapter->watchdog_timer, pch_gbe_watchdog, 0);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2570
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2571        INIT_WORK(&adapter->reset_task, pch_gbe_reset_task);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2572
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2573        pch_gbe_check_options(adapter);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2574
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2575        /* initialize the wol settings based on the eeprom settings */
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2576        adapter->wake_up_evt = PCH_GBE_WL_INIT_SETTING;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2577        dev_info(&pdev->dev, "MAC address : %pM\n", netdev->dev_addr);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2578
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2579        /* reset the hardware with the new settings */
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2580        pch_gbe_reset(adapter);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2581
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2582        ret = register_netdev(netdev);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2583        if (ret)
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2584                goto err_free_adapter;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2585        /* tell the stack to leave us alone until pch_gbe_open() is called */
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2586        netif_carrier_off(netdev);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2587        netif_stop_queue(netdev);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2588
>> 1a0bdadb4e36aba drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Takahiroi Shimizu  2012-03-07  2589        dev_dbg(&pdev->dev, "PCH Network Connection\n");
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2590
>> f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2013-05-18  2591        /* Disable hibernation on certain platforms */
>> f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2013-05-18  2592        if (adapter->pdata && adapter->pdata->phy_disable_hibernate)
>> f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2013-05-18  2593                pch_gbe_phy_disable_hibernate(&adapter->hw);
>> f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darren Hart        2013-05-18  2594
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2595        device_set_wakeup_enable(&pdev->dev, 1);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2596        return 0;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2597
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2598  err_free_adapter:
>> 7dbe38aed0ba01e drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Paul Burton        2018-06-22  2599        pch_gbe_phy_hw_reset(&adapter->hw);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2600  err_free_netdev:
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2601        free_netdev(netdev);
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2602        return ret;
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2603  }
>> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake    2010-09-21  2604
>>
>> :::::: The code at line 2482 was first introduced by commit
>> :::::: 8ff39301efd9d21cd62caad3504aa8d6e35d8304 net: pch_gbe: Use dma_set_mask_and_coherent to simplify code
>>
>> :::::: TO: Christophe JAILLET<christophe.jaillet@wanadoo.fr>
>> :::::: CC: Jakub Kicinski<kuba@kernel.org>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
