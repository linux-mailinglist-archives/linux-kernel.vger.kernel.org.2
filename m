Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CCA344795
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCVOmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:42:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:45364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230356AbhCVOm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:42:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616424147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qE0A1N7/F7ncLf984ovqgJKYsAY3yE04wS+vinpzFio=;
        b=r2N4CanunEnJFd1mm3gd/ItVBlnWonx5pC0IRjlo/fHZvc5DU9RITCU5X+6U+D5tL2gpj3
        6u7stEgpGh0zbOmfbJGnJHPslt4ZCskJ04e16QDYxQxHiRPuNVqlXoYOVckRykomSLgWnf
        36rOF0eVyh6c+Yr9f8HeuLcefZ9h+Ns=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E22FAD4A;
        Mon, 22 Mar 2021 14:42:27 +0000 (UTC)
Date:   Mon, 22 Mar 2021 15:42:26 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 7/8] hugetlb: add update_and_free_page_no_sleep for
 irq context
Message-ID: <YFis0mIbkTWaX7tM@dhcp22.suse.cz>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-8-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319224209.150047-8-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-03-21 15:42:08, Mike Kravetz wrote:
> The locks acquired in free_huge_page are irq safe.  However, in certain
> circumstances the routine update_and_free_page could sleep.  Since
> free_huge_page can be called from any context, it can not sleep.
> 
> Use a waitqueue to defer freeing of pages if the operation may sleep.  A
> new routine update_and_free_page_no_sleep provides this functionality
> and is only called from free_huge_page.
> 
> Note that any 'pages' sent to the workqueue for deferred freeing have
> already been removed from the hugetlb subsystem.  What is actually
> deferred is returning those base pages to the low level allocator.

This patch or its alternative would need to be applied prior to patch 6
which makes the whole context IRQ safe.

Besides that the changelog doesn't really say anything about changed
user visible behavior change. Now if somebody decreases the GB huge pool
from the userspace the real effect on the freed up memory will be
postponed to some later time. That "later" is unpredictable as it
depends on WQ utilization. We definitely need some sort of
wait_for_inflight pages. One way to do that would be to have a dedicated
WQ and schedule a sync work item after the pool has been shrunk and wait
for that item.

-- 
Michal Hocko
SUSE Labs
