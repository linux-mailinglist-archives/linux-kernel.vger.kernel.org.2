Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C0E36EC63
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbhD2Oaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:30:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36506 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbhD2Oa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:30:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TEGLHI007806;
        Thu, 29 Apr 2021 14:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=C65XH8xoI5TYZm566O43/WYrIfY3ecy/PjkGC3++hGw=;
 b=gR13sC9s01nkeqaIUKKoIMpE6HJcW3wjIDkol3KzComfT9SdkrS3htqUWVttrSKXqadI
 hLx/vmqyW/GPjbYiAHsQQvZ8BR5IJzN1t1ABn30qfIT66N4hhDkdaizay+3s0gyM9d4t
 aijBVtOr0NxfUj9n3+CBMRGpnTELq2Fx1GUbuDxT9DUG8xRY5MkWgqcLkSa059xuG2GP
 0CrxbluwqxOv0OZ8gv9Ij2yE8nXf8+C4f+RyAwHlfzWosTC1Eab9tMFTKsOVhzgOHwd4
 q1pONk+g5z5GpKWM2yHKskY1X+iHH9zkfdSvaj6lw9NhQXPK9WIc45fM/ImlqlmHiC5g fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 385ahbvk77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:29:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TEEh70117475;
        Thu, 29 Apr 2021 14:29:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 384w3wcc3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:29:35 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13TENJRu156594;
        Thu, 29 Apr 2021 14:29:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 384w3wcc2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:29:34 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13TETXdF003385;
        Thu, 29 Apr 2021 14:29:33 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Apr 2021 07:29:33 -0700
Date:   Thu, 29 Apr 2021 17:29:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:721
 dpaa2_eth_build_sg_fd_single_buf() warn: overwrite may leak 'sgt_buf'
Message-ID: <202104281748.NQlMojCM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: SF4CG-DNFrOuRhZh2PkWJB2UwHmssTd9
X-Proofpoint-ORIG-GUID: SF4CG-DNFrOuRhZh2PkWJB2UwHmssTd9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Why is kbuild sending out 8 month old bug reports??? -dan ]

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   acd3d28594536e9096c1ea76c5867d8a68babef6
commit: 5d8dccf8bad96bdc5bd5594344ff67539cf3a733 dpaa2-eth: add a dpaa2_eth_ prefix to all functions in dpaa2-eth.c
config: arm-randconfig-m031-20210428 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:721 dpaa2_eth_build_sg_fd_single_buf() warn: overwrite may leak 'sgt_buf'

vim +/sgt_buf +721 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c

5d8dccf8bad96b drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-08-31  696  static int dpaa2_eth_build_sg_fd_single_buf(struct dpaa2_eth_priv *priv,
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  697  					    struct sk_buff *skb,
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  698  					    struct dpaa2_fd *fd)
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  699  {
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  700  	struct device *dev = priv->net_dev->dev.parent;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  701  	struct dpaa2_eth_sgt_cache *sgt_cache;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  702  	struct dpaa2_sg_entry *sgt;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  703  	struct dpaa2_eth_swa *swa;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  704  	dma_addr_t addr, sgt_addr;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  705  	void *sgt_buf = NULL;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  706  	int sgt_buf_size;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  707  	int err;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  708  
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  709  	/* Prepare the HW SGT structure */
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  710  	sgt_cache = this_cpu_ptr(priv->sgt_cache);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  711  	sgt_buf_size = priv->tx_data_offset + sizeof(struct dpaa2_sg_entry);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  712  
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  713  	if (sgt_cache->count == 0)
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  714  		sgt_buf = kzalloc(sgt_buf_size + DPAA2_ETH_TX_BUF_ALIGN,
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  715  				  GFP_ATOMIC);

sgt_buf is assigned here.

d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  716  	else
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  717  		sgt_buf = sgt_cache->buf[--sgt_cache->count];
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  718  	if (unlikely(!sgt_buf))
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  719  		return -ENOMEM;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  720  
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29 @721  	sgt_buf = PTR_ALIGN(sgt_buf, DPAA2_ETH_TX_BUF_ALIGN);

We're losing track of the original "sgt_buf" pointer so we won't be
able to pass it to kfree().

d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  722  	sgt = (struct dpaa2_sg_entry *)(sgt_buf + priv->tx_data_offset);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  723  
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  724  	addr = dma_map_single(dev, skb->data, skb->len, DMA_BIDIRECTIONAL);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  725  	if (unlikely(dma_mapping_error(dev, addr))) {
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  726  		err = -ENOMEM;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  727  		goto data_map_failed;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  728  	}
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  729  
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  730  	/* Fill in the HW SGT structure */
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  731  	dpaa2_sg_set_addr(sgt, addr);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  732  	dpaa2_sg_set_len(sgt, skb->len);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  733  	dpaa2_sg_set_final(sgt, true);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  734  
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  735  	/* Store the skb backpointer in the SGT buffer */
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  736  	swa = (struct dpaa2_eth_swa *)sgt_buf;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  737  	swa->type = DPAA2_ETH_SWA_SINGLE;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  738  	swa->single.skb = skb;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  739  	swa->sg.sgt_size = sgt_buf_size;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  740  
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  741  	/* Separately map the SGT buffer */
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  742  	sgt_addr = dma_map_single(dev, sgt_buf, sgt_buf_size, DMA_BIDIRECTIONAL);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  743  	if (unlikely(dma_mapping_error(dev, sgt_addr))) {
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  744  		err = -ENOMEM;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  745  		goto sgt_map_failed;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  746  	}
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  747  
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  748  	dpaa2_fd_set_offset(fd, priv->tx_data_offset);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  749  	dpaa2_fd_set_format(fd, dpaa2_fd_sg);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  750  	dpaa2_fd_set_addr(fd, sgt_addr);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  751  	dpaa2_fd_set_len(fd, skb->len);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  752  	dpaa2_fd_set_ctrl(fd, FD_CTRL_PTA);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  753  
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  754  	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
5d8dccf8bad96b drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-08-31  755  		dpaa2_eth_enable_tx_tstamp(fd, sgt_buf);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  756  
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  757  	return 0;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  758  
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  759  sgt_map_failed:
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  760  	dma_unmap_single(dev, addr, skb->len, DMA_BIDIRECTIONAL);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  761  data_map_failed:
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  762  	if (sgt_cache->count >= DPAA2_ETH_SGT_CACHE_SIZE)
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  763  		kfree(sgt_buf);
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  764  	else
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  765  		sgt_cache->buf[sgt_cache->count++] = sgt_buf;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  766  
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  767  	return err;
d70446ee1f406e drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c Ioana Ciornei   2020-06-29  768  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

