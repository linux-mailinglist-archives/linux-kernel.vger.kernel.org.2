Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67808316092
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhBJIGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:06:52 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8017 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhBJIGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:06:31 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602393dd0000>; Wed, 10 Feb 2021 00:05:49 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 08:05:49 +0000
Received: from [10.2.50.67] (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 08:05:48 +0000
Subject: Re: [PATCH v3] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <gregkh@linuxfoundation.org>,
        <surenb@google.com>, <joaodias@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20210210075509.3788729-1-minchan@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <070ca72a-c99f-a2a7-c460-0a823cc262f4@nvidia.com>
Date:   Wed, 10 Feb 2021 00:05:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210210075509.3788729-1-minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612944349; bh=3DRbDpk2yftmsNrGO2Hor5bMwar2FFnuYuElfqbamlc=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=f9B87MU3ZMuTMiVYxSbiP768NEDcYg9GilAyKlh3cOw7ToVdhEVBN8TSi7K4F6p6e
         yDdWEpzY65IUM6UW0Pta/6Bcj5Gd7No0vgkOWjTO0drts/xdw8txUPD40vO3r/qLcx
         9vu/inz+MRtbgwcu5K1UioJw46+JC3VgTxqBXwheN7o751XbRlS3UJ2JL/Pvaek9LM
         fRbgPZy0Ml5KIndri+lPERYG9SrvbldL1CtNfVCwXBUqVU4vwQmogY+YM72brsz+Ex
         w7dl+6CzfrAXW5FI5n2W+mwgjn4+Y9qPpkLwHKFB1w12MeP6d9+dtHKcbL58ok29W0
         kKY7YWf47j+BA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 11:55 PM, Minchan Kim wrote:
> Since CMA is getting used more widely, it's more important to
> keep monitoring CMA statistics for system health since it's
> directly related to user experience.
> 
> This patch introduces sysfs statistics for CMA, in order to provide
> some basic monitoring of the CMA allocator.
> 
>   * the number of CMA page allocation attempts
>   * the number of CMA page allocation failures
> 
> These two values allow the user to calcuate the allocation
> failure rate for each CMA area.
> 
> e.g.)
>    /sys/kernel/mm/cma/WIFI/cma_alloc_pages_[attempts|fails]
>    /sys/kernel/mm/cma/SENSOR/cma_alloc_pages_[attempts|fails]
>    /sys/kernel/mm/cma/BLUETOOTH/cma_alloc_pages_[attempts|fails]
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---

Looks good.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

>  From v2 - https://lore.kernel.org/linux-mm/20210208180142.2765456-1-minchan@kernel.org/
>   * sysfs doc and description modification - jhubbard
> 
>  From v1 - https://lore.kernel.org/linux-mm/20210203155001.4121868-1-minchan@kernel.org/
>   * fix sysfs build and refactoring - willy
>   * rename and drop some attributes - jhubbard
>   Documentation/ABI/testing/sysfs-kernel-mm-cma |  25 ++++
>   mm/Kconfig                                    |   7 ++
>   mm/Makefile                                   |   1 +
>   mm/cma.c                                      |   6 +-
>   mm/cma.h                                      |  18 +++
>   mm/cma_sysfs.c                                | 114 ++++++++++++++++++
>   6 files changed, 170 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-cma
>   create mode 100644 mm/cma_sysfs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-cma b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> new file mode 100644
> index 000000000000..f518af819cee
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> @@ -0,0 +1,25 @@
> +What:		/sys/kernel/mm/cma/
> +Date:		Feb 2021
> +Contact:	Minchan Kim <minchan@kernel.org>
> +Description:
> +		/sys/kernel/mm/cma/ contains a subdirectory for each CMA
> +		heap name (also sometimes called CMA areas).
> +
> +		Each CMA heap subdirectory (that is, each
> +		/sys/kernel/mm/cma/<cma-heap-name> directory) contains the
> +		following items:
> +
> +			cma_alloc_pages_attempts
> +			cma_alloc_pages_fails
> +
> +What:		/sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_pages_attempts
> +Date:		Feb 2021
> +Contact:	Minchan Kim <minchan@kernel.org>
> +Description:
> +		the number of pages CMA API tried to allocate
> +
> +What:		/sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_pages_fails
> +Date:		Feb 2021
> +Contact:	Minchan Kim <minchan@kernel.org>
> +Description:
> +		the number of pages CMA API failed to allocate
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ec35bf406439..ad7e9c065657 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -513,6 +513,13 @@ config CMA_DEBUGFS
>   	help
>   	  Turns on the DebugFS interface for CMA.
>   
> +config CMA_SYSFS
> +	bool "CMA information through sysfs interface"
> +	depends on CMA && SYSFS
> +	help
> +	  This option exposes some sysfs attributes to get information
> +	  from CMA.
> +
>   config CMA_AREAS
>   	int "Maximum count of the CMA areas"
>   	depends on CMA
> diff --git a/mm/Makefile b/mm/Makefile
> index b2a564eec27f..e10c14300191 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -109,6 +109,7 @@ obj-$(CONFIG_CMA)	+= cma.o
>   obj-$(CONFIG_MEMORY_BALLOON) += balloon_compaction.o
>   obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
>   obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
> +obj-$(CONFIG_CMA_SYSFS) += cma_sysfs.o
>   obj-$(CONFIG_USERFAULTFD) += userfaultfd.o
>   obj-$(CONFIG_IDLE_PAGE_TRACKING) += page_idle.o
>   obj-$(CONFIG_DEBUG_PAGE_REF) += debug_page_ref.o
> diff --git a/mm/cma.c b/mm/cma.c
> index 23d4a97c834a..b42ccafc71e5 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -447,9 +447,10 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   	offset = cma_bitmap_aligned_offset(cma, align);
>   	bitmap_maxno = cma_bitmap_maxno(cma);
>   	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
> +	cma_sysfs_alloc_count(cma, count);
>   
>   	if (bitmap_count > bitmap_maxno)
> -		return NULL;
> +		goto out;
>   
>   	for (;;) {
>   		mutex_lock(&cma->lock);
> @@ -504,6 +505,9 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   			__func__, count, ret);
>   		cma_debug_show_areas(cma);
>   	}
> +out:
> +	if (!page)
> +		cma_sysfs_fail_count(cma, count);
>   
>   	pr_debug("%s(): returned %p\n", __func__, page);
>   	return page;
> diff --git a/mm/cma.h b/mm/cma.h
> index 42ae082cb067..24a1d61eabc7 100644
> --- a/mm/cma.h
> +++ b/mm/cma.h
> @@ -3,6 +3,14 @@
>   #define __MM_CMA_H__
>   
>   #include <linux/debugfs.h>
> +#include <linux/kobject.h>
> +
> +struct cma_stat {
> +	spinlock_t lock;
> +	unsigned long pages_attempts;	/* the number of CMA page allocation attempts */
> +	unsigned long pages_fails;	/* the number of CMA page allocation failures */
> +	struct kobject kobj;
> +};
>   
>   struct cma {
>   	unsigned long   base_pfn;
> @@ -16,6 +24,9 @@ struct cma {
>   	struct debugfs_u32_array dfs_bitmap;
>   #endif
>   	char name[CMA_MAX_NAME];
> +#ifdef CONFIG_CMA_SYSFS
> +	struct cma_stat	*stat;
> +#endif
>   };
>   
>   extern struct cma cma_areas[MAX_CMA_AREAS];
> @@ -26,4 +37,11 @@ static inline unsigned long cma_bitmap_maxno(struct cma *cma)
>   	return cma->count >> cma->order_per_bit;
>   }
>   
> +#ifdef CONFIG_CMA_SYSFS
> +void cma_sysfs_alloc_count(struct cma *cma, size_t count);
> +void cma_sysfs_fail_count(struct cma *cma, size_t count);
> +#else
> +static inline void cma_sysfs_alloc_count(struct cma *cma, size_t count) {};
> +static inline void cma_sysfs_fail_count(struct cma *cma, size_t count) {};
> +#endif
>   #endif
> diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
> new file mode 100644
> index 000000000000..d281bf95a614
> --- /dev/null
> +++ b/mm/cma_sysfs.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CMA SysFS Interface
> + *
> + * Copyright (c) 2021 Minchan Kim <minchan@kernel.org>
> + */
> +
> +#include <linux/cma.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +
> +#include "cma.h"
> +
> +static struct cma_stat *cma_stats;
> +
> +void cma_sysfs_alloc_count(struct cma *cma, size_t count)
> +{
> +	spin_lock(&cma->stat->lock);
> +	cma->stat->pages_attempts += count;
> +	spin_unlock(&cma->stat->lock);
> +}
> +
> +void cma_sysfs_fail_count(struct cma *cma, size_t count)
> +{
> +	spin_lock(&cma->stat->lock);
> +	cma->stat->pages_fails += count;
> +	spin_unlock(&cma->stat->lock);
> +}
> +
> +#define CMA_ATTR_RO(_name) \
> +	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
> +
> +static struct kobject *cma_kobj;
> +
> +static ssize_t cma_alloc_pages_attempts_show(struct kobject *kobj,
> +			struct kobj_attribute *attr, char *buf)
> +{
> +	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
> +
> +	return sysfs_emit(buf, "%lu\n", stat->pages_attempts);
> +}
> +CMA_ATTR_RO(cma_alloc_pages_attempts);
> +
> +static ssize_t cma_alloc_pages_fails_show(struct kobject *kobj,
> +			struct kobj_attribute *attr, char *buf)
> +{
> +	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
> +
> +	return sysfs_emit(buf, "%lu\n", stat->pages_fails);
> +}
> +CMA_ATTR_RO(cma_alloc_pages_fails);
> +
> +static void cma_kobj_release(struct kobject *kobj)
> +{
> +	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
> +
> +	kfree(stat);
> +}
> +
> +static struct attribute *cma_attrs[] = {
> +	&cma_alloc_pages_attempts_attr.attr,
> +	&cma_alloc_pages_fails_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(cma);
> +
> +static struct kobj_type cma_ktype = {
> +	.release = cma_kobj_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = cma_groups
> +};
> +
> +static int __init cma_sysfs_init(void)
> +{
> +	int i = 0;
> +	struct cma *cma;
> +
> +	cma_kobj = kobject_create_and_add("cma", mm_kobj);
> +	if (!cma_kobj) {
> +		pr_err("failed to create cma kobject\n");
> +		return -ENOMEM;
> +	}
> +
> +	cma_stats = kzalloc(array_size(sizeof(struct cma_stat),
> +				cma_area_count), GFP_KERNEL);
> +	if (!cma_stats) {
> +		pr_err("failed to create cma_stats\n");
> +		goto out;
> +	}
> +
> +	do {
> +		cma = &cma_areas[i];
> +		cma->stat = &cma_stats[i];
> +		spin_lock_init(&cma->stat->lock);
> +		if (kobject_init_and_add(&cma->stat->kobj, &cma_ktype,
> +					cma_kobj, "%s", cma->name)) {
> +			kobject_put(&cma->stat->kobj);
> +			goto out;
> +		}
> +	} while (++i < cma_area_count);
> +
> +	return 0;
> +out:
> +	while (--i >= 0) {
> +		cma = &cma_areas[i];
> +		kobject_put(&cma->stat->kobj);
> +	}
> +
> +	kfree(cma_stats);
> +	kobject_put(cma_kobj);
> +
> +	return -ENOMEM;
> +}
> +subsys_initcall(cma_sysfs_init);
> 

