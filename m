Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB3433F26F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhCQOSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:18:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12714 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231815AbhCQORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:17:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12HE2wvq015080;
        Wed, 17 Mar 2021 10:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=TyeTqPqIiZArDCIWNRMe534vyHT8v+gN/rr7HRuS/Tg=;
 b=q3ZZGV/+SUoTObHlihGXhTVQIFa9+vHDXMGE6v6b9JwxrbB3rBz9TpCuzaJP8ZfGoCQK
 P1ozPNX9xtkJQcgYwSwUfuzTlU6DgVMHVD5eGHLgkLzhtiQIv7gbxCTXFw0sYhnLdzSE
 l+MnsaHKqiQl6LnbAG3Csy/1ad2JJZxfRg/yVBHjhg4ZHvNsNchSLubS7q0HRkRrJTNw
 +nqTMNOuhSC/NaRDvF1xsp5hfovH1ovt4yIqioKvINCbQ1FWb1MPlhqa9JbWqeXvVvHU
 NzQ3coLoaEKRCwY+Up/cVd7iWEEHcoLhRP+FlOt79L2Be9YWUU3G0wi9UGXHeHpo2pLg 0Q== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37bbvtdcjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Mar 2021 10:17:21 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12HEHKDw029329;
        Wed, 17 Mar 2021 14:17:20 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 37b6xjga2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Mar 2021 14:17:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12HEH15m33751546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 14:17:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD50042041;
        Wed, 17 Mar 2021 14:17:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 199A842042;
        Wed, 17 Mar 2021 14:17:17 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.165.64])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 17 Mar 2021 14:17:16 +0000 (GMT)
Date:   Wed, 17 Mar 2021 16:17:15 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Huang Ying <ying.huang@intel.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Move page_mapping_file to pagemap.h
Message-ID: <YFIPa0NryqYJYNtr@linux.ibm.com>
References: <20210317123011.350118-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317123011.350118-1-willy@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-17_07:2021-03-17,2021-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103170106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 12:30:11PM +0000, Matthew Wilcox (Oracle) wrote:
> page_mapping_file() is only used by some architectures, and then it
> is usually only used in one place.  Make it a static inline function
> so other architectures don't have to carry this dead code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> v2: Ensure pagemap.h is included in all the files which use page_mapping_file
>  arch/arm/mm/copypage-v4mc.c   |  1 +
>  arch/arm/mm/copypage-v6.c     |  1 +
>  arch/arm/mm/copypage-xscale.c |  1 +
>  arch/csky/abiv1/cacheflush.c  |  1 +
>  arch/mips/mm/cache.c          |  1 +
>  arch/nios2/mm/cacheflush.c    |  1 +
>  arch/sh/mm/cache-sh4.c        |  1 +
>  arch/sh/mm/cache-sh7705.c     |  1 +
>  arch/sparc/mm/tlb.c           |  1 +
>  include/linux/mm.h            |  1 -
>  include/linux/pagemap.h       | 10 ++++++++++
>  mm/util.c                     | 10 ----------
>  12 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
> index 44f7292ec27b..f1da3b439b96 100644
> --- a/arch/arm/mm/copypage-v4mc.c
> +++ b/arch/arm/mm/copypage-v4mc.c
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  #include <linux/highmem.h>
> +#include <linux/pagemap.h>
> 
>  #include <asm/tlbflush.h>
>  #include <asm/cacheflush.h>
> diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
> index 6a769a6c314e..d8a115de5507 100644
> --- a/arch/arm/mm/copypage-v6.c
> +++ b/arch/arm/mm/copypage-v6.c
> @@ -8,6 +8,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/mm.h>
>  #include <linux/highmem.h>
> +#include <linux/pagemap.h>
> 
>  #include <asm/shmparam.h>
>  #include <asm/tlbflush.h>
> diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
> index eb5d338657d1..bcb485620a05 100644
> --- a/arch/arm/mm/copypage-xscale.c
> +++ b/arch/arm/mm/copypage-xscale.c
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  #include <linux/highmem.h>
> +#include <linux/pagemap.h>
> 
>  #include <asm/tlbflush.h>
>  #include <asm/cacheflush.h>
> diff --git a/arch/csky/abiv1/cacheflush.c b/arch/csky/abiv1/cacheflush.c
> index 9f1fe80cc847..07ff17ea33de 100644
> --- a/arch/csky/abiv1/cacheflush.c
> +++ b/arch/csky/abiv1/cacheflush.c
> @@ -4,6 +4,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/fs.h>
> +#include <linux/pagemap.h>
>  #include <linux/syscalls.h>
>  #include <linux/spinlock.h>
>  #include <asm/page.h>
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 7719d632df8d..a7bf0c80371c 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -15,6 +15,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/mm.h>
>  #include <linux/highmem.h>
> +#include <linux/pagemap.h>
> 
>  #include <asm/cacheflush.h>
>  #include <asm/processor.h>
> diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
> index 65de1bd6a760..6aa9257c3ede 100644
> --- a/arch/nios2/mm/cacheflush.c
> +++ b/arch/nios2/mm/cacheflush.c
> @@ -11,6 +11,7 @@
>  #include <linux/sched.h>
>  #include <linux/mm.h>
>  #include <linux/fs.h>
> +#include <linux/pagemap.h>
> 
>  #include <asm/cacheflush.h>
>  #include <asm/cpuinfo.h>
> diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
> index ddfa9685f1ef..72c2e1b46c08 100644
> --- a/arch/sh/mm/cache-sh4.c
> +++ b/arch/sh/mm/cache-sh4.c
> @@ -16,6 +16,7 @@
>  #include <linux/mutex.h>
>  #include <linux/fs.h>
>  #include <linux/highmem.h>
> +#include <linux/pagemap.h>
>  #include <asm/mmu_context.h>
>  #include <asm/cache_insns.h>
>  #include <asm/cacheflush.h>
> diff --git a/arch/sh/mm/cache-sh7705.c b/arch/sh/mm/cache-sh7705.c
> index 4c67b3d88775..9b63a53a5e46 100644
> --- a/arch/sh/mm/cache-sh7705.c
> +++ b/arch/sh/mm/cache-sh7705.c
> @@ -13,6 +13,7 @@
>  #include <linux/mman.h>
>  #include <linux/mm.h>
>  #include <linux/fs.h>
> +#include <linux/pagemap.h>
>  #include <linux/threads.h>
>  #include <asm/addrspace.h>
>  #include <asm/page.h>
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index 20ee14739333..9a725547578e 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -9,6 +9,7 @@
>  #include <linux/mm.h>
>  #include <linux/swap.h>
>  #include <linux/preempt.h>
> +#include <linux/pagemap.h>
> 
>  #include <asm/tlbflush.h>
>  #include <asm/cacheflush.h>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fbe0843daa90..f69a72f63e44 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1645,7 +1645,6 @@ static inline pgoff_t page_index(struct page *page)
> 
>  bool page_mapped(struct page *page);
>  struct address_space *page_mapping(struct page *page);
> -struct address_space *page_mapping_file(struct page *page);
> 
>  /*
>   * Return true only if the page has been allocated with
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 08fa117f405c..f68fe61c1dec 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -162,6 +162,16 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
> 
>  void release_pages(struct page **pages, int nr);
> 
> +/*
> + * For file cache pages, return the address_space, otherwise return NULL
> + */
> +static inline struct address_space *page_mapping_file(struct page *page)
> +{
> +	if (unlikely(PageSwapCache(page)))
> +		return NULL;
> +	return page_mapping(page);
> +}
> +
>  /*
>   * speculatively take a reference to a page.
>   * If the page is free (_refcount == 0), then _refcount is untouched, and 0
> diff --git a/mm/util.c b/mm/util.c
> index 143c627fb3e8..972e7a0cda5e 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -711,16 +711,6 @@ struct address_space *page_mapping(struct page *page)
>  }
>  EXPORT_SYMBOL(page_mapping);
> 
> -/*
> - * For file cache pages, return the address_space, otherwise return NULL
> - */
> -struct address_space *page_mapping_file(struct page *page)
> -{
> -	if (unlikely(PageSwapCache(page)))
> -		return NULL;
> -	return page_mapping(page);
> -}
> -
>  /* Slow path of page_mapcount() for compound pages */
>  int __page_mapcount(struct page *page)
>  {
> -- 
> 2.30.1
> 

-- 
Sincerely yours,
Mike.
