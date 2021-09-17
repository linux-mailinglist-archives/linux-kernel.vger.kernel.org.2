Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1382740EFDE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 04:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243049AbhIQC5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 22:57:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:40280 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234959AbhIQC5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 22:57:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="245098920"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="245098920"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 19:56:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="546107273"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.133])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 19:56:19 -0700
Date:   Fri, 17 Sep 2021 11:03:35 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] swiotlb: allocate memory in a cache-friendly way
Message-ID: <20210917030334.GA20257@gao-cwp>
References: <20210901042135.103981-1-chao.gao@intel.com>
 <YUNnkxiVnHUszg7G@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUNnkxiVnHUszg7G@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 11:49:39AM -0400, Konrad Rzeszutek Wilk wrote:
>On Wed, Sep 01, 2021 at 12:21:35PM +0800, Chao Gao wrote:
>> Currently, swiotlb uses a global index to indicate the starting point
>> of next search. The index increases from 0 to the number of slots - 1
>> and then wraps around. It is straightforward but not cache-friendly
>> because the "oldest" slot in swiotlb tends to be used first.
>> 
>> Freed slots are probably accessed right before being freed, especially
>> in VM's case (device backends access them in DMA_TO_DEVICE mode; guest
>> accesses them in other DMA modes). Thus those just freed slots may
>> reside in cache. Then reusing those just freed slots can reduce cache
>> misses.
>> 
>> To that end, maintain a free list for free slots and insert freed slots
>> from the head and searching for free slots always starts from the head.
>> 
>> With this optimization, network throughput of sending data from host to
>> guest, measured by iperf3, increases by 7%.
>
>Wow, that is pretty awesome!
>
>Are there any other benchmarks that you ran that showed a negative
>performance?

TBH, yes. Recently I do fio tests with this patch. The impact of this patch
is: (+ means performance improvement; - means performance regression)

1-job fio:
randread: +6.7%
randwrite: -1.6%
read: +8.2%
write: +7.4%

8-job fio:
randread: -5.5%
randwrite: -12.6%
read: -24.8%
write: -45.5%

I haven't figured out why multi-job fio tests suffer. Will post v2 once
the issue gets resolved.

Thanks
Chao
