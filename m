Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95049344DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhCVR62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:58:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2728 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhCVR6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:58:10 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F42B73Xq5z6829K;
        Tue, 23 Mar 2021 01:51:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 18:58:08 +0100
Received: from [10.210.167.192] (10.210.167.192) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 17:58:07 +0000
Subject: Re: [PATCH 0/3] iommu/iova: Add CPU hotplug handler to flush rcaches
 to core code
To:     <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <robin.murphy@arm.com>
References: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7ff533de-d9da-6325-4275-79951fa5657c@huawei.com>
Date:   Mon, 22 Mar 2021 17:55:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.192]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2021 12:12, John Garry wrote:
> The Intel IOMMU driver supports flushing the per-CPU rcaches when a CPU is
> offlined.
> 
> Let's move it to core code, so everyone can take advantage.
> 
> Also correct a code comment.
> 
> Based on v5.12-rc1. Tested on arm64 only.

Hi guys,

Friendly reminder ...

Thanks
John

> 
> John Garry (3):
>    iova: Add CPU hotplug handler to flush rcaches
>    iommu/vt-d: Remove IOVA domain rcache flushing for CPU offlining
>    iova: Correct comment for free_cpu_cached_iovas()
> 
>   drivers/iommu/intel/iommu.c | 31 -------------------------------
>   drivers/iommu/iova.c        | 32 ++++++++++++++++++++++++++++++--
>   include/linux/cpuhotplug.h  |  2 +-
>   include/linux/iova.h        |  1 +
>   4 files changed, 32 insertions(+), 34 deletions(-)
> 

