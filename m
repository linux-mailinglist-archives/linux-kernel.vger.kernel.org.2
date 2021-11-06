Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F0A446FE7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 19:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhKFSpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhKFSpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 14:45:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B08CC061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 11:42:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ee33so45276785edb.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nmMW/bRpfkZA3Xd61ksvQBtvOl9Kk780q2pxepoh9bM=;
        b=m3VzxhsDgo+rOYWgt6LN+gkL49diJgJAu2GT21FgoehmQJrSyGetvCFmSdk4HeiQnk
         5ZiN81wa6J/TB9pAvzJxhKi4RD/ajPS0MudZiGjqxuJ5GvufX9Ct51CdzgltCB59KfUh
         IRbyTOaR80jFU7d4Oo/UubJGT0vphUAitd29u4dn2BMd0R/14Vf9JFr4ykP7zcv2sije
         dl1Otq5VPsPNo6FTmtsUMfPjgAlpvwsG+5OZUGA2Ac5r42MfPF7Yj67ZinlpW7Hk50+r
         7esJZ3/t6qAmZCkB/x3cEMn4jKEq+HvzCdnQGAOhVUDlQcgiFPj7kxfQppJFoSv3e1hy
         gClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nmMW/bRpfkZA3Xd61ksvQBtvOl9Kk780q2pxepoh9bM=;
        b=f/gdXCV/x2Ks9bWOK7o5Goqt/iRprD5qxK13rwfD1Nzsu4XOINJxjkKUOFwqh3IChc
         0wyjYu3QzU/ynZXi7ttmL+bqOiahNRTjnaxwgQUnNT5OsaUbTkfHGrHBN3Td2DqtABdN
         EDtckNAgYODpxbRJsffc64SmPcYuevI4bu5oTt67Xs9Rl5IuNIv6wBR0sRZJ/psOezvw
         96dm/VEqjUpPQYNesNV0JanIySIPQhi6Q/rxqo/r3ROPvoQydKXj692tit1Fko75/eSU
         +4ze6kyW0z3pwlcSsrCEc6TZBGtCV45KwF/HMUa4jzIsBWMMFkeJpdHL+BHs80pdaxd9
         9vcQ==
X-Gm-Message-State: AOAM533PJhPbwvYCDeWRtIQpKppvNAqJgHjIkTp6430f+j78nf1u44u1
        74eQemPTUgKwfQDfhmazJBbe4hJD0+MprWK0yl0=
X-Google-Smtp-Source: ABdhPJz6R4fdM9UpoG5Yg8qESczZ83bu1+C92OhW8k9Atxwc6srk1WYczcKJkrqDCrMAMrYPWa53rbcVJY5QoKDp424=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr82793201ejc.69.1636224168916;
 Sat, 06 Nov 2021 11:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <202111060804.OP5qAfyw-lkp@intel.com>
In-Reply-To: <202111060804.OP5qAfyw-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Nov 2021 20:42:12 +0200
Message-ID: <CAHp75VezOpe4OtPMm3bQziCY7fkMPKu4Vu09zXaUicpruKFeuA@mail.gmail.com>
Subject: Re: [dborkman-bpf:pr/bpf-tstamp 3/3] drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:2482:44:
 warning: shift count >= width of type
To:     kernel test robot <lkp@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Christophe (can you look into this? It seems your code is involved)

On Sat, Nov 6, 2021 at 3:52 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git =
pr/bpf-tstamp
> head:   f7d619a946e981177777983af26e9e31163ffb38
> commit: f7d619a946e981177777983af26e9e31163ffb38 [3/3] net: skb clock bas=
es
> config: i386-randconfig-a005-20210928 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e=
8dfdfe7efecfda318d43a06fae18b40eb498)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.gi=
t/commit/?id=3Df7d619a946e981177777983af26e9e31163ffb38
>         git remote add dborkman-bpf https://git.kernel.org/pub/scm/linux/=
kernel/git/dborkman/bpf.git
>         git fetch --no-tags dborkman-bpf pr/bpf-tstamp
>         git checkout f7d619a946e981177777983af26e9e31163ffb38
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 ARCH=3Di386
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ma=
in.c:9:
>    In file included from drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h:=
22:
>    include/net/tcp.h:812:27: error: no member named 'skb_mstamp_ns' in 's=
truct sk_buff'
>            return tcp_ns_to_ts(skb->skb_mstamp_ns);
>                                ~~~  ^
>    include/net/tcp.h:818:22: error: no member named 'skb_mstamp_ns' in 's=
truct sk_buff'
>            return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
>                           ~~~  ^
>    include/net/tcp.h:2367:8: error: no member named 'skb_mstamp_ns' in 's=
truct sk_buff'
>                    skb->skb_mstamp_ns +=3D (u64)tp->tcp_tx_delay * NSEC_P=
ER_USEC;
>                    ~~~  ^
> >> drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:2482:44: warning:=
 shift count >=3D width of type [-Wshift-count-overflow]
>            if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
>                                                      ^~~~~~~~~~~~~~~~
>    include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_=
MASK'
>    #define DMA_BIT_MASK(n) (((n) =3D=3D 64) ? ~0ULL : ((1ULL<<(n))-1))
>                                                         ^ ~~~
>    1 warning and 3 errors generated.
> --
>    In file included from drivers/net/ethernet/emulex/benet/be_main.c:16:
>    In file included from drivers/net/ethernet/emulex/benet/be.h:20:
>    include/net/tcp.h:812:27: error: no member named 'skb_mstamp_ns' in 's=
truct sk_buff'
>            return tcp_ns_to_ts(skb->skb_mstamp_ns);
>                                ~~~  ^
>    include/net/tcp.h:818:22: error: no member named 'skb_mstamp_ns' in 's=
truct sk_buff'
>            return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
>                           ~~~  ^
>    include/net/tcp.h:2367:8: error: no member named 'skb_mstamp_ns' in 's=
truct sk_buff'
>                    skb->skb_mstamp_ns +=3D (u64)tp->tcp_tx_delay * NSEC_P=
ER_USEC;
>                    ~~~  ^
> >> drivers/net/ethernet/emulex/benet/be_main.c:5843:49: warning: shift co=
unt >=3D width of type [-Wshift-count-overflow]
>            status =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(=
64));
>                                                           ^~~~~~~~~~~~~~~=
~
>    include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_=
MASK'
>    #define DMA_BIT_MASK(n) (((n) =3D=3D 64) ? ~0ULL : ((1ULL<<(n))-1))
>                                                         ^ ~~~
>    1 warning and 3 errors generated.
>
>
> vim +2482 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
>
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2470
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2471  static int pch_gbe_probe(struct pci_dev *p=
dev,
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2472                          const struct pci_d=
evice_id *pci_id)
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2473  {
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2474        struct net_device *netdev;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2475        struct pch_gbe_adapter *adapter;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2476        int ret;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2477
> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy=
 Shevchenko    2013-06-28  2478        ret =3D pcim_enable_device(pdev);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2479        if (ret)
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2480                return ret;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2481
> 8ff39301efd9d21 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Chri=
stophe JAILLET 2020-11-21 @2482        if (dma_set_mask_and_coherent(&pdev-=
>dev, DMA_BIT_MASK(64))) {
> 8ff39301efd9d21 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Chri=
stophe JAILLET 2020-11-21  2483                ret =3D dma_set_mask_and_coh=
erent(&pdev->dev, DMA_BIT_MASK(32));
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2484                if (ret) {
> 8ff39301efd9d21 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Chri=
stophe JAILLET 2020-11-21  2485                        dev_err(&pdev->dev, =
"ERR: No usable DMA configuration, aborting\n");
> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy=
 Shevchenko    2013-06-28  2486                        return ret;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2487                }
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2488        }
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2489
> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy=
 Shevchenko    2013-06-28  2490        ret =3D pcim_iomap_regions(pdev, 1 <=
< PCH_GBE_PCI_BAR, pci_name(pdev));
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2491        if (ret) {
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2492                dev_err(&pdev->dev,
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2493                        "ERR: Can't reserve =
PCI I/O and memory resources\n");
> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy=
 Shevchenko    2013-06-28  2494                return ret;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2495        }
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2496        pci_set_master(pdev);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2497
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2498        netdev =3D alloc_etherdev((int)sizeo=
f(struct pch_gbe_adapter));
> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy=
 Shevchenko    2013-06-28  2499        if (!netdev)
> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy=
 Shevchenko    2013-06-28  2500                return -ENOMEM;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2501        SET_NETDEV_DEV(netdev, &pdev->dev);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2502
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2503        pci_set_drvdata(pdev, netdev);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2504        adapter =3D netdev_priv(netdev);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2505        adapter->netdev =3D netdev;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2506        adapter->pdev =3D pdev;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2507        adapter->hw.back =3D adapter;
> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy=
 Shevchenko    2013-06-28  2508        adapter->hw.reg =3D pcim_iomap_table=
(pdev)[PCH_GBE_PCI_BAR];
> 9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy=
 Shevchenko    2021-05-10  2509
> f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darr=
en Hart        2013-05-18  2510        adapter->pdata =3D (struct pch_gbe_p=
rivdata *)pci_id->driver_data;
> 9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy=
 Shevchenko    2021-05-10  2511        if (adapter->pdata && adapter->pdata=
->platform_init) {
> 9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy=
 Shevchenko    2021-05-10  2512                ret =3D adapter->pdata->plat=
form_init(pdev);
> 9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy=
 Shevchenko    2021-05-10  2513                if (ret)
> 9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy=
 Shevchenko    2021-05-10  2514                        goto err_free_netdev=
;
> 9e3617a7b84512b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy=
 Shevchenko    2021-05-10  2515        }
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2516
> 2e1c8725bb834f1 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Sina=
n Kaya         2017-12-19  2517        adapter->ptp_pdev =3D
> 2e1c8725bb834f1 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Sina=
n Kaya         2017-12-19  2518                pci_get_domain_bus_and_slot(=
pci_domain_nr(adapter->pdev->bus),
> 2e1c8725bb834f1 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Sina=
n Kaya         2017-12-19  2519                                            =
adapter->pdev->bus->number,
> 1a0bdadb4e36aba drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Taka=
hiroi Shimizu  2012-03-07  2520                                            =
PCI_DEVFN(12, 4));
> 1a0bdadb4e36aba drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Taka=
hiroi Shimizu  2012-03-07  2521
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2522        netdev->netdev_ops =3D &pch_gbe_netd=
ev_ops;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2523        netdev->watchdog_timeo =3D PCH_GBE_W=
ATCHDOG_PERIOD;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2524        netif_napi_add(netdev, &adapter->nap=
i,
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2525                       pch_gbe_napi_poll, PC=
H_GBE_RX_WEIGHT);
> 756a6b03da98903 drivers/net/pch_gbe/pch_gbe_main.c                   Mich=
a=C5=82 Miros=C5=82aw    2011-04-19  2526        netdev->hw_features =3D NE=
TIF_F_RXCSUM |
> 756a6b03da98903 drivers/net/pch_gbe/pch_gbe_main.c                   Mich=
a=C5=82 Miros=C5=82aw    2011-04-19  2527                NETIF_F_IP_CSUM | =
NETIF_F_IPV6_CSUM;
> 756a6b03da98903 drivers/net/pch_gbe/pch_gbe_main.c                   Mich=
a=C5=82 Miros=C5=82aw    2011-04-19  2528        netdev->features =3D netde=
v->hw_features;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2529        pch_gbe_set_ethtool_ops(netdev);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2530
> 44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jaro=
d Wilson       2016-10-17  2531        /* MTU range: 46 - 10300 */
> 44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jaro=
d Wilson       2016-10-17  2532        netdev->min_mtu =3D ETH_ZLEN - ETH_H=
LEN;
> 44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jaro=
d Wilson       2016-10-17  2533        netdev->max_mtu =3D PCH_GBE_MAX_JUMB=
O_FRAME_SIZE -
> 44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jaro=
d Wilson       2016-10-17  2534                          (ETH_HLEN + ETH_FC=
S_LEN);
> 44770e1180decf9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jaro=
d Wilson       2016-10-17  2535
> 98200ec28a66c8d drivers/net/pch_gbe/pch_gbe_main.c                   Tosh=
iharu Okada    2011-02-13  2536        pch_gbe_mac_load_mac_addr(&adapter->=
hw);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2537        pch_gbe_mac_reset_hw(&adapter->hw);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2538
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2539        /* setup the private structure */
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2540        ret =3D pch_gbe_sw_init(adapter);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2541        if (ret)
> 29cc436cb90da4c drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy=
 Shevchenko    2013-06-28  2542                goto err_free_netdev;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2543
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2544        /* Initialize PHY */
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2545        ret =3D pch_gbe_init_phy(adapter);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2546        if (ret) {
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2547                dev_err(&pdev->dev, "PHY ini=
tialize error\n");
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2548                goto err_free_adapter;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2549        }
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2550
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2551        /* Read the MAC address. and store t=
o the private data */
> 9c020d7b0525d3b drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Paul=
 Burton        2018-06-22  2552        ret =3D pch_gbe_mac_read_mac_addr(&a=
dapter->hw);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2553        if (ret) {
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2554                dev_err(&pdev->dev, "MAC add=
ress Read Error\n");
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2555                goto err_free_adapter;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2556        }
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2557
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2558        memcpy(netdev->dev_addr, adapter->hw=
.mac.addr, netdev->addr_len);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2559        if (!is_valid_ether_addr(netdev->dev=
_addr)) {
> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darr=
en Hart        2012-01-16  2560                /*
> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darr=
en Hart        2012-01-16  2561                 * If the MAC is invalid (or=
 just missing), display a warning
> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darr=
en Hart        2012-01-16  2562                 * but do not abort setting =
up the device. pch_gbe_up will
> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darr=
en Hart        2012-01-16  2563                 * prevent the interface fro=
m being brought up until a valid MAC
> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darr=
en Hart        2012-01-16  2564                 * is set.
> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darr=
en Hart        2012-01-16  2565                 */
> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darr=
en Hart        2012-01-16  2566                dev_err(&pdev->dev, "Invalid=
 MAC address, "
> 2b53d07891630de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darr=
en Hart        2012-01-16  2567                                    "interfa=
ce disabled.\n");
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2568        }
> e99e88a9d2b0674 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Kees=
 Cook          2017-10-16  2569        timer_setup(&adapter->watchdog_timer=
, pch_gbe_watchdog, 0);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2570
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2571        INIT_WORK(&adapter->reset_task, pch_=
gbe_reset_task);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2572
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2573        pch_gbe_check_options(adapter);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2574
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2575        /* initialize the wol settings based=
 on the eeprom settings */
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2576        adapter->wake_up_evt =3D PCH_GBE_WL_=
INIT_SETTING;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2577        dev_info(&pdev->dev, "MAC address : =
%pM\n", netdev->dev_addr);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2578
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2579        /* reset the hardware with the new s=
ettings */
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2580        pch_gbe_reset(adapter);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2581
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2582        ret =3D register_netdev(netdev);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2583        if (ret)
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2584                goto err_free_adapter;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2585        /* tell the stack to leave us alone =
until pch_gbe_open() is called */
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2586        netif_carrier_off(netdev);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2587        netif_stop_queue(netdev);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2588
> 1a0bdadb4e36aba drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Taka=
hiroi Shimizu  2012-03-07  2589        dev_dbg(&pdev->dev, "PCH Network Con=
nection\n");
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2590
> f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darr=
en Hart        2013-05-18  2591        /* Disable hibernation on certain pl=
atforms */
> f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darr=
en Hart        2013-05-18  2592        if (adapter->pdata && adapter->pdata=
->phy_disable_hibernate)
> f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darr=
en Hart        2013-05-18  2593                pch_gbe_phy_disable_hibernat=
e(&adapter->hw);
> f1a26fdf5944ff9 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Darr=
en Hart        2013-05-18  2594
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2595        device_set_wakeup_enable(&pdev->dev,=
 1);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2596        return 0;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2597
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2598  err_free_adapter:
> 7dbe38aed0ba01e drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Paul=
 Burton        2018-06-22  2599        pch_gbe_phy_hw_reset(&adapter->hw);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2600  err_free_netdev:
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2601        free_netdev(netdev);
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2602        return ret;
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2603  }
> 77555ee72282342 drivers/net/pch_gbe/pch_gbe_main.c                   Masa=
yuki Ohtake    2010-09-21  2604
>
> :::::: The code at line 2482 was first introduced by commit
> :::::: 8ff39301efd9d21cd62caad3504aa8d6e35d8304 net: pch_gbe: Use dma_set=
_mask_and_coherent to simplify code
>
> :::::: TO: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> :::::: CC: Jakub Kicinski <kuba@kernel.org>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



--=20
With Best Regards,
Andy Shevchenko
