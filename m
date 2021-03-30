Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D2A34EF1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhC3RMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:12:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232582AbhC3RLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:11:50 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UH3qlm007629;
        Tue, 30 Mar 2021 13:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=o+KPlXUSYhIXD6kqR6+4G4cmYVmZzgH80vg9IfaAQ/o=;
 b=YWhES8a2ThGMbr1iWqSjw2hMUuMrEXAL2SZvEWPC0fu/9dhGxjMju3Utfn3qjg1xHT7K
 u+4pVzatwcGE//uuWTtNWEo75ssnR8cC7a0qIu6qwrsK0XbiH0tlTzcOKzKZLaRSsgwt
 66W5hT1HglocWTLavkaVzUZg3OAFpBOdkcbsMy4l6j+1ApljPSpx58hRxSY8l50oJ3y0
 QfeUng+KZRUyeKcB8FQ2VwBAaVgoAOqyeBwHPdDmNpI58OhwxwM1bl3JHK4trncDZWF6
 v8Ihan+M+fKuVAJcsBHtJmButkPo1In6NBh0Yv0riXAfuq+IZgIT94jvIogyL8Vg8JOs bw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jhnmqgp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 13:11:29 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12UH82Cu009437;
        Tue, 30 Mar 2021 17:11:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 37huyhaw55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 17:11:26 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12UHB4mW14418390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 17:11:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22736A4060;
        Tue, 30 Mar 2021 17:11:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C354AA4054;
        Tue, 30 Mar 2021 17:11:22 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.165.64])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 30 Mar 2021 17:11:22 +0000 (GMT)
Date:   Tue, 30 Mar 2021 20:11:19 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Huang Ying <ying.huang@intel.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Move page_mapping_file to pagemap.h
Message-ID: <YGNbt87KmByKVs0P@linux.ibm.com>
References: <20210317123011.350118-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317123011.350118-1-willy@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 24KOkX1OWkqpa1-rf-UthodEnUxHjEdY
X-Proofpoint-ORIG-GUID: 24KOkX1OWkqpa1-rf-UthodEnUxHjEdY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_08:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=947 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 12:30:11PM +0000, Matthew Wilcox (Oracle) wrote:
> page_mapping_file() is only used by some architectures, and then it
> is usually only used in one place.  Make it a static inline function
> so other architectures don't have to carry this dead code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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
 
As the original commit that replaced page_mapping() with
page_mapping_file() [cb9f753a3731 ("mm: fix races between swapoff and flush
dcache")] missed arch/nds32 I think it'll make sense to add the below hunk
to this patch:

diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
index 6eb98a7ad27d..ad5344ef5d33 100644
--- a/arch/nds32/mm/cacheflush.c
+++ b/arch/nds32/mm/cacheflush.c
@@ -238,7 +238,7 @@ void flush_dcache_page(struct page *page)
 {
 	struct address_space *mapping;
 
-	mapping = page_mapping(page);
+	mapping = page_mapping_file(page);
 	if (mapping && !mapping_mapped(mapping))
 		set_bit(PG_dcache_dirty, &page->flags);
 	else {

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
