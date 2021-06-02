Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D7D39806F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 06:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhFBEkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 00:40:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:28865 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhFBEkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 00:40:24 -0400
IronPort-SDR: cPtzjus+TvFU7UGrYXUrbhfmrjdwHQvxPIeyydEudbKopFw8Ywv3wetgYQFeZ9W1HB850BiReb
 z75sYEkKphDg==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="200688619"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="200688619"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 21:38:36 -0700
IronPort-SDR: WnxDIDJVtYV3cqi62LfVUsTHx0jekxNgcPoporyzqfr3Kmq/YTcQXgtBigUP9h1PnoepDUO6vb
 CcHBzb8MVLZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="633098715"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105]) ([10.239.159.105])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2021 21:38:34 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] iommu: Allow IOVA rcache range be configured
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com
References: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <834ad35a-7310-1738-7d17-7c061ca73e4c@linux.intel.com>
Date:   Wed, 2 Jun 2021 12:37:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 10:29 PM, John Garry wrote:
> For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
> exceeds the IOVA rcache upper limit (meaning that they are not cached),
> performance can be reduced.
> 
> This is much more pronounced from commit 4e89dce72521 ("iommu/iova: Retry
> from last rb tree node if iova search fails"), as discussed at [0].
> 
> IOVAs which cannot be cached are highly involved in the IOVA ageing issue,
> as discussed at [1].
> 
> This series allows the IOVA rcache range be configured, so that we may
> cache all IOVAs per domain, thus improving performance.
> 
> A new IOMMU group sysfs file is added - max_opt_dma_size - which is used
> indirectly to configure the IOVA rcache range:
> /sys/kernel/iommu_groups/X/max_opt_dma_size
> 
> This file is updated same as how the IOMMU group default domain type is
> updated, i.e. must unbind the only device in the group first.

Could you explain why it requires singleton group and driver unbinding
if the user only wants to increase the upper limit? I haven't dived into
the details yet, sorry if this is a silly question.

Best regards,
baolu
