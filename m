Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD0A377851
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 21:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhEITsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 15:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhEITsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 15:48:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAF1C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 12:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m3qKaE/dAAtd9qSEfx7CFC7FcoGRyDQMt5A8LQjD2Q4=; b=vNbaXLHh3DOxM3jJaJM8IPKm7X
        fzRlZNDS6xgR9xru48M+QhuNWoOO5lqtIXBMIcQYlpdFlysG6BQpmdG7JIGYXuOV+IQun1e3lL9Cq
        wwxyKnmVcDvKwuY+0mGPi9bsio8tYUs6NzjZHr1WCCWlKo+s1LWFnR3vo/TcjbtoeWU+oV8D94TB7
        ouY3ckmGTP9YE8Q+OArQ/gm1dVmOMVrGnCo5LjM+DLfyeq1A00ArvMb2GLLZPaUW0RS2o534NhABz
        ms5U1X7bt+1pKfO4H1jI2dZR2EbB+Qe+6uOp6C4GHu3xu15Vw7Cq7/7676g+n5m53pYogu1b/xwGk
        L0GSQTDg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lfpOS-005NoZ-37; Sun, 09 May 2021 19:47:14 +0000
Date:   Sun, 9 May 2021 20:47:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/2] mm/vmalloc: Print a warning message first on
 failure
Message-ID: <YJg8QO2JXm0+8UH6@casper.infradead.org>
References: <20210509193844.2562-1-urezki@gmail.com>
 <20210509193844.2562-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509193844.2562-2-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 09:38:44PM +0200, Uladzislau Rezki (Sony) wrote:
>  export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> -			      -O2 -fomit-frame-pointer -std=gnu89
> +			      -O0 -g -fomit-frame-pointer -std=gnu89

You clearly didn't intend to submit this portion ...

> +++ b/mm/vmalloc.c
> @@ -2781,11 +2781,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	}
>  
>  	if (!area->pages) {
> -		free_vm_area(area);
>  		warn_alloc(gfp_mask, NULL,
>  			   "vmalloc size %lu allocation failure: "
>  			   "page array size %lu allocation failed",
>  			   nr_small_pages * PAGE_SIZE, array_size);
> +		free_vm_area(area);
>  		return NULL;
>  	}

I think this is a bad idea.  We're clearly low on memory (a memory
allocation just failed).  We should free the memory we have allocated
to improve the chances of the warning message making it out.
