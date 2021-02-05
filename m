Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686873109BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhBELAH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Feb 2021 06:00:07 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2887 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhBEKx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:53:28 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DXBzN5jtQz5Nft;
        Fri,  5 Feb 2021 18:50:56 +0800 (CST)
Received: from dggemi709-chm.china.huawei.com (10.3.20.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 5 Feb 2021 18:52:37 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi709-chm.china.huawei.com (10.3.20.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 5 Feb 2021 18:52:37 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Fri, 5 Feb 2021 18:52:37 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [PATCH v2] dma-mapping: benchmark: pretend DMA is transmitting
Thread-Topic: [PATCH v2] dma-mapping: benchmark: pretend DMA is transmitting
Thread-Index: AQHW+2OBR5g3s4IewkuPPN58KPwDpapIw5uAgACOkOD//4Z1gIAAh2xw
Date:   Fri, 5 Feb 2021 10:52:37 +0000
Message-ID: <0509bbb11bc547d1a8d9e85e05810b40@hisilicon.com>
References: <20210205020035.25340-1-song.bao.hua@hisilicon.com>
 <20210205092113.GA870@lst.de>
 <e4c784d93cdd41d285bdddb650fb9471@hisilicon.com>
 <20210205103627.GB6694@lst.de>
In-Reply-To: <20210205103627.GB6694@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Friday, February 5, 2021 11:36 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Christoph Hellwig <hch@lst.de>; m.szyprowski@samsung.com;
> robin.murphy@arm.com; iommu@lists.linux-foundation.org;
> linux-kernel@vger.kernel.org; linuxarm@openeuler.org
> Subject: Re: [PATCH v2] dma-mapping: benchmark: pretend DMA is transmitting
> 
> On Fri, Feb 05, 2021 at 10:32:26AM +0000, Song Bao Hua (Barry Song) wrote:
> > I can keep the struct size unchanged by changing the struct to
> >
> > struct map_benchmark {
> > 	__u64 avg_map_100ns; /* average map latency in 100ns */
> > 	__u64 map_stddev; /* standard deviation of map latency */
> > 	__u64 avg_unmap_100ns; /* as above */
> > 	__u64 unmap_stddev;
> > 	__u32 threads; /* how many threads will do map/unmap in parallel */
> > 	__u32 seconds; /* how long the test will last */
> > 	__s32 node; /* which numa node this benchmark will run on */
> > 	__u32 dma_bits; /* DMA addressing capability */
> > 	__u32 dma_dir; /* DMA data direction */
> > 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
> >
> > 	__u32 exp; /* For future use */
> > 	__u64 expansion[9];	/* For future use */
> > };
> >
> > But the code is really ugly now.
> 
> Thats why we usually use __u8 fields for reserved field.  You might
> consider just switching to that instead while you're at it. I guess
> we'll just have to get the addition into 5.11 then to make sure we
> don't release a kernel with the alignment fix.

I assume there is no need to keep the same size with 5.11-rc, so
could change the struct to:

struct map_benchmark {
	__u64 avg_map_100ns; /* average map latency in 100ns */
	__u64 map_stddev; /* standard deviation of map latency */
	__u64 avg_unmap_100ns; /* as above */
	__u64 unmap_stddev;
	__u32 threads; /* how many threads will do map/unmap in parallel */
	__u32 seconds; /* how long the test will last */
	__s32 node; /* which numa node this benchmark will run on */
	__u32 dma_bits; /* DMA addressing capability */
	__u32 dma_dir; /* DMA data direction */
	__u8 expansion[84]; /* For future use */
};

This won't increase size on 64bit system, but it increases 4bytes
on 32bits system comparing to 5.11-rc. How do you think about it?

Thanks
Barry

