Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640A134297E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 01:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhCTAgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 20:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCTAfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 20:35:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC31DC061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 17:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fgnZ++/+hQjO75AS6knQ0AkaN/9iQL9yrJW9f64F+Xs=; b=QyYaWY09Y2d2E8ke+7SLMyJSEL
        X3H87wPnA/VTX+5iPqcsOuXcTC03haTv9Hc/rAW7klZRhGJ2LrIQu5lcYR4fNYCiNo2H+XIJ4+zSY
        M0nbBO5NdCGEe4kvzHwwWSs0G41CXZp2+o+31O9BOt5ZFcn+yyDjvD/QYUA3ZXDslYTcHRTtmPbzx
        crZTER6q+jjPRYPG5nYQBoAywvbo0rYMIhoz1RtOrdj8fQQhqAcjvifdLhV938p2tFcsGrYwDr87P
        PW+KceRk8wax+0NXhGp8hN6569HZJtwFOCx5VrpD9jVUVgWseYygF33h5rtX49VnITK9OlnfSNni6
        dfi0/UCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNPaG-005BE0-7Q; Sat, 20 Mar 2021 00:35:18 +0000
Date:   Sat, 20 Mar 2021 00:35:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yangfeng1@kingsoft.com,
        sunhao2@kingsoft.com, Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3] mm/gup: check page posion status for coredump.
Message-ID: <20210320003516.GC3420@casper.infradead.org>
References: <20210317163714.328a038d@alex-virtual-machine>
 <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
 <20210318044600.GJ3420@casper.infradead.org>
 <20210318133412.12078eb7@alex-virtual-machine>
 <20210319104437.6f30e80d@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319104437.6f30e80d@alex-virtual-machine>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:44:37AM +0800, Aili Yao wrote:
> +++ b/mm/gup.c
> @@ -1536,6 +1536,10 @@ struct page *get_dump_page(unsigned long addr)
>  				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
>  	if (locked)
>  		mmap_read_unlock(mm);
> +
> +	if (ret == 1 && is_page_poisoned(page))
> +		return NULL;
> +
>  	return (ret == 1) ? page : NULL;
>  }
>  #endif /* CONFIG_ELF_CORE */
> diff --git a/mm/internal.h b/mm/internal.h
> index 25d2b2439..902d993 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -97,6 +97,27 @@ static inline void set_page_refcounted(struct page *page)
>  	set_page_count(page, 1);
>  }
>  
> +/*
> + * When kernel touch the user page, the user page may be have been marked
> + * poison but still mapped in user space, if without this page, the kernel
> + * can guarantee the data integrity and operation success, the kernel is
> + * better to check the posion status and avoid touching it, be good not to
> + * panic, coredump for process fatal signal is a sample case matching this
> + * scenario. Or if kernel can't guarantee the data integrity, it's better
> + * not to call this function, let kernel touch the poison page and get to
> + * panic.
> + */
> +static inline bool is_page_poisoned(struct page *page)
> +{
> +	if (page != NULL) {

Why are you checking page for NULL here?  How can it possibly be NULL?

> +		if (PageHWPoison(page))
> +			return true;
> +		else if (PageHuge(page) && PageHWPoison(compound_head(page)))
> +			return true;
> +	}
> +	return 0;
> +}
> +
>  extern unsigned long highest_memmap_pfn;
>  
>  /*
> -- 
> 1.8.3.1
> 
> 
