Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFF4387FED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351665AbhERSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:52:35 -0400
Received: from foss.arm.com ([217.140.110.172]:59300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234553AbhERSwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:52:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BAB5101E;
        Tue, 18 May 2021 11:51:15 -0700 (PDT)
Received: from [10.57.66.179] (unknown [10.57.66.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96D703F719;
        Tue, 18 May 2021 11:51:14 -0700 (PDT)
Subject: Re: [PATCH 1/1] dma-contiguous: return early for dt case in
 dma_contiguous_reserve
To:     Dong Aisheng <aisheng.dong@nxp.com>,
        iommu@lists.linux-foundation.org
Cc:     dongas86@gmail.com, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210518112857.1198415-1-aisheng.dong@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fe37a3d0-1360-77e8-f594-c9f32cc39cf2@arm.com>
Date:   Tue, 18 May 2021 19:51:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518112857.1198415-1-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-18 12:28, Dong Aisheng wrote:
> dma_contiguous_reserve() aims to support cmdline case for CMA memory
> reserve. But if users define reserved memory in DT,
> 'dma_contiguous_default_area' will not be 0, then it's meaningless
> to continue to run dma_contiguous_reserve(). So we return early
> if detect 'dma_contiguous_default_area' is unzero.

But dma_contiguous_default_area *shouldn't* be set if the command-line 
argument is present - see the "if (size_cmdline != -1 && default_cma)" 
part of rmem_cma_setup(). Are you seeing something different in practice?

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   kernel/dma/contiguous.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 3d63d91cba5c..ebade9f43eff 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -171,6 +171,9 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>   	phys_addr_t selected_limit = limit;
>   	bool fixed = false;
>   
> +	if (dma_contiguous_default_area)
> +		return;
> +
>   	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
>   
>   	if (size_cmdline != -1) {
> @@ -191,7 +194,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>   #endif
>   	}
>   
> -	if (selected_size && !dma_contiguous_default_area) {
> +	if (selected_size) {

Either way, does skipping a handful of trivial calculations and a 
debugging message really matter even when it is redundant? I can't 
imagine it has any measurable effect on boot times...

Robin.

>   		pr_debug("%s: reserving %ld MiB for global area\n", __func__,
>   			 (unsigned long)selected_size / SZ_1M);
>   
> 
