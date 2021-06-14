Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA043A663B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhFNMGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:06:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55208 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbhFNMGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:06:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15EC4A5m099471;
        Mon, 14 Jun 2021 12:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=mdlMmyqEE4DXsTzal67kMC06Y3asTLPKia/p10d3n3U=;
 b=PGLRLRrciCKxXYlTDGXYSv9X6vwnDqlotSuyp4hZAH+iPHg2tNXuBoNMBbJdsZvJQrAN
 mko4c4HxjSO7HBLkXVzeP6rOLU0EBew2UrIQ1wjV2Fu1FkVvneWcwkzXqwANnVOj9lB0
 nG3WLN4wWbWRrY8Pu2AFScGArOuZeWp9wDEUbTqwL4obqxjFC5oTYMB1AanzrmkZNNBl
 e7k+iw1gDuRWv09R3M0F/TCTl/QFx+5Yz1T5IWxvB8AZxsYWUvIL6xCEBwqaWdNLQDp1
 8+r/0bMcwJBDH4fo8qzYMon8p0Tgf0t8xqo8T1agIYf3M4aTtQQBqy71YKoWST1tA/1+ kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 394mvnb5rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 12:04:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15EBuih6001062;
        Mon, 14 Jun 2021 12:04:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 394j1t2an1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 12:04:39 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15EC4c1M026243;
        Mon, 14 Jun 2021 12:04:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 394j1t2amf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 12:04:38 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15EC4aPe002959;
        Mon, 14 Jun 2021 12:04:36 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Jun 2021 12:04:35 +0000
Date:   Mon, 14 Jun 2021 15:04:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Christoph Hellwig <hch@lst.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: drivers/xen/swiotlb-xen.c:315 xen_swiotlb_alloc_coherent() error: we
 previously assumed 'hwdev' could be null (see line 308)
Message-ID: <202106130525.akNbMu0d-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: Qj9L9ioOEn8aM1SsMFM9JV0Zs1ZrodNe
X-Proofpoint-GUID: Qj9L9ioOEn8aM1SsMFM9JV0Zs1ZrodNe
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10014 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=999 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   43cb5d49a99b3ecd9fef9826899aac948c3048da
commit: 7bc5c428a660d4d1bc95ba54bf4cb6bccf8c3029 dma-direct: remove __dma_to_phys
config: x86_64-randconfig-m001-20210612 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/xen/swiotlb-xen.c:315 xen_swiotlb_alloc_coherent() error: we previously assumed 'hwdev' could be null (see line 308)

vim +/hwdev +315 drivers/xen/swiotlb-xen.c

dceb1a6819ab2c Christoph Hellwig     2017-05-21  276  static void *
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  277  xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
baa676fcf8d555 Andrzej Pietrasiewicz 2012-03-27  278  			   dma_addr_t *dma_handle, gfp_t flags,
00085f1efa387a Krzysztof Kozlowski   2016-08-03  279  			   unsigned long attrs)
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  280  {
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  281  	void *ret;
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  282  	int order = get_order(size);
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  283  	u64 dma_mask = DMA_BIT_MASK(32);
6810df88dcfc22 Konrad Rzeszutek Wilk 2011-08-25  284  	phys_addr_t phys;
6810df88dcfc22 Konrad Rzeszutek Wilk 2011-08-25  285  	dma_addr_t dev_addr;
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  286  
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  287  	/*
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  288  	* Ignore region specifiers - the kernel's ideas of
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  289  	* pseudo-phys memory layout has nothing to do with the
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  290  	* machine physical layout.  We can't allocate highmem
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  291  	* because we can't return a pointer to it.
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  292  	*/
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  293  	flags &= ~(__GFP_DMA | __GFP_HIGHMEM);
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  294  
7250f422da0480 Joe Jin               2018-10-16  295  	/* Convert the size to actually allocated. */
7250f422da0480 Joe Jin               2018-10-16  296  	size = 1UL << (order + XEN_PAGE_SHIFT);
7250f422da0480 Joe Jin               2018-10-16  297  
1b65c4e5a9af1a Stefano Stabellini    2013-10-10  298  	/* On ARM this function returns an ioremap'ped virtual address for
1b65c4e5a9af1a Stefano Stabellini    2013-10-10  299  	 * which virt_to_phys doesn't return the corresponding physical
1b65c4e5a9af1a Stefano Stabellini    2013-10-10  300  	 * address. In fact on ARM virt_to_phys only works for kernel direct
1b65c4e5a9af1a Stefano Stabellini    2013-10-10  301  	 * mapped RAM memory. Also see comment below.
1b65c4e5a9af1a Stefano Stabellini    2013-10-10  302  	 */
1b65c4e5a9af1a Stefano Stabellini    2013-10-10  303  	ret = xen_alloc_coherent_pages(hwdev, size, dma_handle, flags, attrs);
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  304  
6810df88dcfc22 Konrad Rzeszutek Wilk 2011-08-25  305  	if (!ret)
6810df88dcfc22 Konrad Rzeszutek Wilk 2011-08-25  306  		return ret;
6810df88dcfc22 Konrad Rzeszutek Wilk 2011-08-25  307  
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11 @308  	if (hwdev && hwdev->coherent_dma_mask)
                                                            ^^^^^
Hopefully this check can be removed.

038d07a283d623 Christoph Hellwig     2018-03-19  309  		dma_mask = hwdev->coherent_dma_mask;
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  310  
91ffe4ad534ab2 Stefano Stabellini    2020-07-10  311  	/* At this point dma_handle is the dma address, next we are
1b65c4e5a9af1a Stefano Stabellini    2013-10-10  312  	 * going to set it to the machine address.
1b65c4e5a9af1a Stefano Stabellini    2013-10-10  313  	 * Do not use virt_to_phys(ret) because on ARM it doesn't correspond
1b65c4e5a9af1a Stefano Stabellini    2013-10-10  314  	 * to *dma_handle. */
91ffe4ad534ab2 Stefano Stabellini    2020-07-10 @315  	phys = dma_to_phys(hwdev, *dma_handle);
                                                                           ^^^^^
dma_to_phys() does not check.

91ffe4ad534ab2 Stefano Stabellini    2020-07-10  316  	dev_addr = xen_phys_to_dma(hwdev, phys);
6810df88dcfc22 Konrad Rzeszutek Wilk 2011-08-25  317  	if (((dev_addr + size - 1 <= dma_mask)) &&
6810df88dcfc22 Konrad Rzeszutek Wilk 2011-08-25  318  	    !range_straddles_page_boundary(phys, size))
6810df88dcfc22 Konrad Rzeszutek Wilk 2011-08-25  319  		*dma_handle = dev_addr;
6810df88dcfc22 Konrad Rzeszutek Wilk 2011-08-25  320  	else {
1b65c4e5a9af1a Stefano Stabellini    2013-10-10  321  		if (xen_create_contiguous_region(phys, order,
69908907b02efe Stefano Stabellini    2013-10-09  322  						 fls64(dma_mask), dma_handle) != 0) {
1b65c4e5a9af1a Stefano Stabellini    2013-10-10  323  			xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  324  			return NULL;
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  325  		}
91ffe4ad534ab2 Stefano Stabellini    2020-07-10  326  		*dma_handle = phys_to_dma(hwdev, *dma_handle);
b877ac9815a8fe Juergen Gross         2019-06-14  327  		SetPageXenRemapped(virt_to_page(ret));
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  328  	}
6810df88dcfc22 Konrad Rzeszutek Wilk 2011-08-25  329  	memset(ret, 0, size);
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  330  	return ret;
b097186fd29d5b Konrad Rzeszutek Wilk 2010-05-11  331  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

