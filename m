Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F283BDE6C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 22:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhGFU3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 16:29:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhGFU3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 16:29:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5C9F61C8C;
        Tue,  6 Jul 2021 20:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1625603214;
        bh=JBUwlxlI8gE1oqPvzBshifB+DVQmCTX9FdZGWFRtxiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nUyYUbAlvH2OW/GGOiYtlUj+QHcLyb+/xnsr3VDm4hCWo1xnnhuAlTZC5Jh0wsLlU
         GNu6MhnL0pMjpsT/ByzQVTaJPaF3WCHdlV0niIzEfOlPksNdn9t9pZWKBwb2pxqavK
         376cF59WNCjf38gp4UcKRfba1Z02OeeygOTRcsxA=
Date:   Tue, 6 Jul 2021 13:26:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/2] mm/vmalloc: Use batched page requests in
 bulk-allocator
Message-Id: <20210706132653.8374852963b25989e360d599@linux-foundation.org>
In-Reply-To: <20210705170537.43060-1-urezki@gmail.com>
References: <20210705170537.43060-1-urezki@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Jul 2021 19:05:36 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> In case of simultaneous vmalloc allocations, for example it is 1GB and
> 12 CPUs my system is able to hit "BUG: soft lockup" for !CONFIG_PREEMPT
> kernel.
> 
> <snip>
> ...
>
> are obtained, i.e. do batched page requests adding cond_resched() meanwhile
> to reschedule. Batched value is hard-coded and is 100 pages per call.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Can we please have a Fixes: for this?

Is this fix important enough for 4.14-rcx?  I think so...

> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2785,10 +2785,32 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  	 * to fails, fallback to a single page allocator that is
>  	 * more permissive.
>  	 */
> -	if (!order)
> -		nr_allocated = alloc_pages_bulk_array_node(
> -			gfp, nid, nr_pages, pages);
> -	else
> +	if (!order) {
> +		while (nr_allocated < nr_pages) {
> +			int nr, nr_pages_request;
> +
> +			/*
> +			 * A maximum allowed request is hard-coded and is 100
> +			 * pages per call. That is done in order to prevent a
> +			 * long preemption off scenario in the bulk-allocator
> +			 * so the range is [1:100].
> +			 */
> +			nr_pages_request = min(100, (int)(nr_pages - nr_allocated));

Yes, they types are all over the place.

nr_pages: unsigned long
nr_allocated: unsigned int
nr, nr_pages_request: int

Can we please choose the most appropriate type and use that
consistently?


