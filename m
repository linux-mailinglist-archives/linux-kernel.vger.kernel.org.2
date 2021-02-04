Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933F930EF10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhBDIvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:51:44 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19579 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbhBDIvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:51:41 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601bb5730000>; Thu, 04 Feb 2021 00:50:59 -0800
Received: from [10.2.50.90] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb
 2021 08:50:58 +0000
Subject: Re: [PATCH] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <gregkh@linuxfoundation.org>, <surenb@google.com>,
        <joaodias@google.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20210203155001.4121868-1-minchan@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <7e7c01a7-27fe-00a3-f67f-8bcf9ef3eae9@nvidia.com>
Date:   Thu, 4 Feb 2021 00:50:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210203155001.4121868-1-minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612428659; bh=Snwt9NrcbI2KHKMG8oc1z+F40/Bsst2a9cRRDYfL5lM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=cQZjXp8CboxruJI1hhMlYdyq+rfZrhisOx1M5P1pKIhSHL0tAMS+SY60Kcg5M5Q+U
         5cBvmBhu5MogZHtOVEKk/X94s2AmRnpgxfNe2S8oitjlrktIy1In1Ye7HrOo2LFpd3
         eK1x1NPcDaBShmABV9Pzc+gNbV8/5Te6x9YufPpOx4OgDRE8DDcCSrqvI9+bdbhkpl
         /tRkR29n4QXoUeMyLFA5HsBRHD56tVn4ys74iRwP2MkkZgzOR8S5i3C1J/FqaS+5Fq
         kVg7kMpVQo86kIs8FxLlrgKr9rhFTr8nNaGtFS0rHwNawaLq/bFKe/ulpTQi9HYSxR
         epZ4XSHohq6Jw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 7:50 AM, Minchan Kim wrote:
> Since CMA is getting used more widely, it's more important to
> keep monitoring CMA statistics for system health since it's
> directly related to user experience.
> 
> This patch introduces sysfs for the CMA and exposes stats below
> to keep monitor for telemetric in the system.
> 
>   * the number of CMA allocation attempts
>   * the number of CMA allocation failures
>   * the number of CMA page allocation attempts
>   * the number of CMA page allocation failures

The desire to report CMA data is understandable, but there are a few
odd things here:

1) First of all, this has significant overlap with /sys/kernel/debug/cma
items. I suspect that all of these items could instead go into
/sys/kernel/debug/cma, right?

2) The overall CMA allocation attempts/failures (first two items above) seem
an odd pair of things to track. Maybe that is what was easy to track, but I'd
vote for just omitting them.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>   Documentation/ABI/testing/sysfs-kernel-mm-cma |  39 +++++
>   include/linux/cma.h                           |   1 +
>   mm/Makefile                                   |   1 +
>   mm/cma.c                                      |   6 +-
>   mm/cma.h                                      |  20 +++
>   mm/cma_sysfs.c                                | 143 ++++++++++++++++++
>   6 files changed, 209 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-cma
>   create mode 100644 mm/cma_sysfs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-cma b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> new file mode 100644
> index 000000000000..2a43c0aacc39
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> @@ -0,0 +1,39 @@
> +What:		/sys/kernel/mm/cma/
> +Date:		Feb 2021
> +Contact:	Minchan Kim <minchan@kernel.org>
> +Description:
> +		/sys/kernel/mm/cma/ contains a number of subdirectories by
> +		cma-heap name. The subdirectory contains a number of files
> +		to represent cma allocation statistics.

Somewhere, maybe here, there should be a mention of the closely related
/sys/kernel/debug/cma files.

> +
> +		There are number of files under
> +				/sys/kernel/mm/cma/<cma-heap-name> directory
> +
> +			- cma_alloc_attempt
> +			- cma_alloc_fail

Are these really useful? They a summary of the alloc_pages items, really.

> +			- alloc_pages_attempt
> +			- alloc_pages_fail

This should also have "cma" in the name, really: cma_alloc_pages_*.

> +
> +What:		/sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_attempt
> +Date:		Feb 2021
> +Contact:	Minchan Kim <minchan@kernel.org>
> +Description:
> +		the number of cma_alloc API attempted
> +
> +What:		/sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_fail
> +Date:		Feb 2021
> +Contact:	Minchan Kim <minchan@kernel.org>
> +Description:
> +		the number of CMA_alloc API failed
> +
> +What:		/sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_attempt
> +Date:		Feb 2021
> +Contact:	Minchan Kim <minchan@kernel.org>
> +Description:
> +		the number of pages CMA API tried to allocate
> +
> +What:		/sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_fail
> +Date:		Feb 2021
> +Contact:	Minchan Kim <minchan@kernel.org>
> +Description:
> +		the number of pages CMA API failed to allocate
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 217999c8a762..71a28a5bb54e 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -49,4 +49,5 @@ extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
>   
>   extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
> +

A single additional blank line seems to be the only change to this file. :)

thanks,
-- 
John Hubbard
NVIDIA
