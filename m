Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60E431094E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhBEKkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:40:12 -0500
Received: from verein.lst.de ([213.95.11.211]:59845 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbhBEKhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:37:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 40F1C68AFE; Fri,  5 Feb 2021 11:36:27 +0100 (CET)
Date:   Fri, 5 Feb 2021 11:36:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH v2] dma-mapping: benchmark: pretend DMA is transmitting
Message-ID: <20210205103627.GB6694@lst.de>
References: <20210205020035.25340-1-song.bao.hua@hisilicon.com> <20210205092113.GA870@lst.de> <e4c784d93cdd41d285bdddb650fb9471@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4c784d93cdd41d285bdddb650fb9471@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 10:32:26AM +0000, Song Bao Hua (Barry Song) wrote:
> I can keep the struct size unchanged by changing the struct to
> 
> struct map_benchmark {
> 	__u64 avg_map_100ns; /* average map latency in 100ns */
> 	__u64 map_stddev; /* standard deviation of map latency */
> 	__u64 avg_unmap_100ns; /* as above */
> 	__u64 unmap_stddev;
> 	__u32 threads; /* how many threads will do map/unmap in parallel */
> 	__u32 seconds; /* how long the test will last */
> 	__s32 node; /* which numa node this benchmark will run on */
> 	__u32 dma_bits; /* DMA addressing capability */
> 	__u32 dma_dir; /* DMA data direction */
> 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
> 
> 	__u32 exp; /* For future use */
> 	__u64 expansion[9];	/* For future use */
> };
> 
> But the code is really ugly now.

Thats why we usually use __u8 fields for reserved field.  You might
consider just switching to that instead while you're at it. I guess
we'll just have to get the addition into 5.11 then to make sure we
don't release a kernel with the alignment fix.
