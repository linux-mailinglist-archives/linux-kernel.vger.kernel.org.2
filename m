Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA30C345EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhCWNF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:05:28 -0400
Received: from foss.arm.com ([217.140.110.172]:46078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231211AbhCWNFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:05:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABBD6106F;
        Tue, 23 Mar 2021 06:05:07 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 721A03F719;
        Tue, 23 Mar 2021 06:05:06 -0700 (PDT)
Subject: Re: [PATCH 3/3] iova: Correct comment for free_cpu_cached_iovas()
To:     John Garry <john.garry@huawei.com>, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
 <1614600741-15696-4-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <87b4af01-2352-e963-824f-1cea1a6ee718@arm.com>
Date:   Tue, 23 Mar 2021 13:05:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1614600741-15696-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-01 12:12, John Garry wrote:
> Function free_cpu_cached_iovas() is not only called when a CPU is
> hotplugged, so remove that part of the code comment.

FWIW I read it as clarifying why this is broken out into a separate 
function vs. a monolithic "free all cached IOVAs" routine that handles 
both the per-cpu and global caches - it never said "*only* used..."

As such I'd hesitate to call it incorrect, but it's certainly arguable 
whether it needs to be stated or not, especially once the hotplug 
callsite is now obvious in the same file - on which note the function 
itself also shouldn't need to be public any more, no?

Robin.

> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/iova.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index c78312560425..465b3b0eeeb0 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -996,7 +996,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   }
>   
>   /*
> - * free all the IOVA ranges cached by a cpu (used when cpu is unplugged)
> + * free all the IOVA ranges cached by a cpu
>    */
>   void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
>   {
> 
