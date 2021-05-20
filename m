Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0C5389B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 04:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhETCED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 22:04:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:14801 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhETCEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 22:04:02 -0400
IronPort-SDR: YvpilHeYB0JJkp35945FMdPpp946ppBj80D5Qmga/r0fHqeKhGiHwXyYQddeo9x0/7DJEkcaot
 6VhihCYObDoQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="265037582"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="265037582"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 19:02:41 -0700
IronPort-SDR: eXSSXvm3wsOSj1KkoIHphzBsfrtTYJf7wjh/Q3f7UMkasrm/SmK8Jx45sKQyfT8jF8YB6GIm6F
 U6+TNCOEHaEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="474933431"
Received: from pl-dbox.sh.intel.com (HELO pl-dbox) ([10.239.159.39])
  by fmsmga002.fm.intel.com with ESMTP; 19 May 2021 19:02:39 -0700
Date:   Thu, 20 May 2021 09:59:09 +0800
From:   Philip Li <philip.li@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>, lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild] drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:721
 dpaa2_eth_build_sg_fd_single_buf() warn: overwrite may leak 'sgt_buf'
Message-ID: <20210520015909.GB3327173@pl-dbox>
References: <202104281748.NQlMojCM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104281748.NQlMojCM-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 10:29:27PM +0800, Dan Carpenter wrote:
> [ Why is kbuild sending out 8 month old bug reports??? -dan ]
hi Dan, it's possible such issue is just discovered by the newly
generated randconfig arm-randconfig-m031-20210428.

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   acd3d28594536e9096c1ea76c5867d8a68babef6
> commit: 5d8dccf8bad96bdc5bd5594344ff67539cf3a733 dpaa2-eth: add a dpaa2_eth_ prefix to all functions in dpaa2-eth.c
> config: arm-randconfig-m031-20210428 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:721 dpaa2_eth_build_sg_fd_single_buf() warn: overwrite may leak 'sgt_buf'
> 
> vim +/sgt_buf +721 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> 
> 5d8dccf8bad96b drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-08-31  696  static int dpaa2_eth_build_sg_fd_single_buf(struct dpaa2_eth_priv *priv,
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  697                                             struct sk_buff *skb,
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  698                                             struct dpaa2_fd *fd)
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  699  {
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  700         struct device *dev = priv->net_dev->dev.parent;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  701         struct dpaa2_eth_sgt_cache *sgt_cache;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  702         struct dpaa2_sg_entry *sgt;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  703         struct dpaa2_eth_swa *swa;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  704         dma_addr_t addr, sgt_addr;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  705         void *sgt_buf = NULL;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  706         int sgt_buf_size;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  707         int err;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  708
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  709         /* Prepare the HW SGT structure */
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  710         sgt_cache = this_cpu_ptr(priv->sgt_cache);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  711         sgt_buf_size = priv->tx_data_offset + sizeof(struct dpaa2_sg_entry);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  712
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  713         if (sgt_cache->count == 0)
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  714                 sgt_buf = kzalloc(sgt_buf_size + DPAA2_ETH_TX_BUF_ALIGN,
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  715                                   GFP_ATOMIC);
> 
> sgt_buf is assigned here.
> 
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  716         else
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  717                 sgt_buf = sgt_cache->buf[--sgt_cache->count];
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  718         if (unlikely(!sgt_buf))
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  719                 return -ENOMEM;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  720
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29 @721         sgt_buf = PTR_ALIGN(sgt_buf, DPAA2_ETH_TX_BUF_ALIGN);
> 
> We're losing track of the original "sgt_buf" pointer so we won't be
> able to pass it to kfree().
> 
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  722         sgt = (struct dpaa2_sg_entry *)(sgt_buf + priv->tx_data_offset);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  723
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  724         addr = dma_map_single(dev, skb->data, skb->len, DMA_BIDIRECTIONAL);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  725         if (unlikely(dma_mapping_error(dev, addr))) {
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  726                 err = -ENOMEM;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  727                 goto data_map_failed;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  728         }
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  729
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  730         /* Fill in the HW SGT structure */
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  731         dpaa2_sg_set_addr(sgt, addr);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  732         dpaa2_sg_set_len(sgt, skb->len);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  733         dpaa2_sg_set_final(sgt, true);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  734
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  735         /* Store the skb backpointer in the SGT buffer */
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  736         swa = (struct dpaa2_eth_swa *)sgt_buf;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  737         swa->type = DPAA2_ETH_SWA_SINGLE;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  738         swa->single.skb = skb;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  739         swa->sg.sgt_size = sgt_buf_size;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  740
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  741         /* Separately map the SGT buffer */
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  742         sgt_addr = dma_map_single(dev, sgt_buf, sgt_buf_size, DMA_BIDIRECTIONAL);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  743         if (unlikely(dma_mapping_error(dev, sgt_addr))) {
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  744                 err = -ENOMEM;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  745                 goto sgt_map_failed;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  746         }
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  747
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  748         dpaa2_fd_set_offset(fd, priv->tx_data_offset);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  749         dpaa2_fd_set_format(fd, dpaa2_fd_sg);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  750         dpaa2_fd_set_addr(fd, sgt_addr);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  751         dpaa2_fd_set_len(fd, skb->len);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  752         dpaa2_fd_set_ctrl(fd, FD_CTRL_PTA);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  753
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  754         if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
> 5d8dccf8bad96b drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-08-31  755                 dpaa2_eth_enable_tx_tstamp(fd, sgt_buf);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  756
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  757         return 0;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  758
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  759  sgt_map_failed:
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  760         dma_unmap_single(dev, addr, skb->len, DMA_BIDIRECTIONAL);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  761  data_map_failed:
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  762         if (sgt_cache->count >= DPAA2_ETH_SGT_CACHE_SIZE)
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  763                 kfree(sgt_buf);
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  764         else
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  765                 sgt_cache->buf[sgt_cache->count++] = sgt_buf;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  766
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  767         return err;
> d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  768  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org
