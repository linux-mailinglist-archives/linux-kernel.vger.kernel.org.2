Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98FD3117DC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBFAhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:37:50 -0500
Received: from verein.lst.de ([213.95.11.211]:59914 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231897AbhBEK5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:57:19 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 41BE168B05; Fri,  5 Feb 2021 11:56:35 +0100 (CET)
Date:   Fri, 5 Feb 2021 11:56:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH v2] dma-mapping: benchmark: pretend DMA is transmitting
Message-ID: <20210205105634.GA7267@lst.de>
References: <20210205020035.25340-1-song.bao.hua@hisilicon.com> <20210205092113.GA870@lst.de> <e4c784d93cdd41d285bdddb650fb9471@hisilicon.com> <20210205103627.GB6694@lst.de> <0509bbb11bc547d1a8d9e85e05810b40@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0509bbb11bc547d1a8d9e85e05810b40@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 10:52:37AM +0000, Song Bao Hua (Barry Song) wrote:
> I assume there is no need to keep the same size with 5.11-rc, so
> could change the struct to:
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
> 	__u8 expansion[84]; /* For future use */
> };
> 
> This won't increase size on 64bit system, but it increases 4bytes
> on 32bits system comparing to 5.11-rc. How do you think about it?

Yes, that sounds good.  Please send me a two patch series with the
first one changing the alignment, and the second adding the delay.
I'll send the first one off to Linus ASAP then.
