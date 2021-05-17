Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBE13826E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhEQI0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:26:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:38840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235544AbhEQI0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:26:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 763A3AF16;
        Mon, 17 May 2021 08:24:52 +0000 (UTC)
Date:   Mon, 17 May 2021 09:24:50 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] mm/vmalloc: Switch to bulk allocator in
 __vmalloc_area_node()
Message-ID: <20210517082449.GT3672@suse.de>
References: <20210516202056.2120-1-urezki@gmail.com>
 <20210516202056.2120-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210516202056.2120-3-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 10:20:55PM +0200, Uladzislau Rezki (Sony) wrote:
> Recently there has been introduced a page bulk allocator for
> users which need to get number of pages per one call request.
> 
> For order-0 pages switch to an alloc_pages_bulk_array_node()
> instead of alloc_pages_node(), the reason is the former is
> not capable of allocating set of pages, thus a one call is
> per one page.
> 
> Second, according to my tests the bulk allocator uses less
> cycles even for scenarios when only one page is requested.
> Running the "perf" on same test case shows below difference:
> 
> <default>
>   - 45.18% __vmalloc_node
>      - __vmalloc_node_range
>         - 35.60% __alloc_pages
>            - get_page_from_freelist
>                 3.36% __list_del_entry_valid
>                 3.00% check_preemption_disabled
>                 1.42% prep_new_page
> <default>
> 
> <patch>
>   - 31.00% __vmalloc_node
>      - __vmalloc_node_range
>         - 14.48% __alloc_pages_bulk
>              3.22% __list_del_entry_valid
>            - 0.83% __alloc_pages
>                 get_page_from_freelist
> <patch>
> 
> The "test_vmalloc.sh" also shows performance improvements:
> 
> fix_size_alloc_test_4MB   loops: 1000000 avg: 89105095 usec
> fix_size_alloc_test       loops: 1000000 avg: 513672   usec
> full_fit_alloc_test       loops: 1000000 avg: 748900   usec
> long_busy_list_alloc_test loops: 1000000 avg: 8043038  usec
> random_size_alloc_test    loops: 1000000 avg: 4028582  usec
> fix_align_alloc_test      loops: 1000000 avg: 1457671  usec
> 
> fix_size_alloc_test_4MB   loops: 1000000 avg: 62083711 usec
> fix_size_alloc_test       loops: 1000000 avg: 449207   usec
> full_fit_alloc_test       loops: 1000000 avg: 735985   usec
> long_busy_list_alloc_test loops: 1000000 avg: 5176052  usec
> random_size_alloc_test    loops: 1000000 avg: 2589252  usec
> fix_align_alloc_test      loops: 1000000 avg: 1365009  usec
> 
> For example 4MB allocations illustrates ~30% gain, all the
> rest is also better.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

FWIW, it passed build and boot tests.

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
