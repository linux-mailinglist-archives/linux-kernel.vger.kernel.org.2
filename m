Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A009305848
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbhA0KXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:23:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:52140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235531AbhA0KV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:21:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611742840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ASjQD3e6RwZwXm35tKuOYLz+UbqyeCf/0FdsdUp4d+A=;
        b=MjrJgZgmwyXZqp1xptBq6z5ghgTvIWtUOucoeIznfMKkYBt4Cbp7NremW1haOkSjAEtpEA
        ImR7qQh0gorEhaLTPxJ7RVPhUmnkLeDMghbOp8gfCvWduOsCpzayUijBufCS+KU7HKlilA
        UUxnjTurMC45y43jJ2Nt7B+Egp2yUSE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 793F0AD2B;
        Wed, 27 Jan 2021 10:20:40 +0000 (UTC)
Date:   Wed, 27 Jan 2021 11:20:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/5] hugetlb: use page.private for hugetlb specific
 page flags
Message-ID: <20210127102035.GF827@dhcp22.suse.cz>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122195231.324857-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry for jumping in late]

On Fri 22-01-21 11:52:27, Mike Kravetz wrote:
> As hugetlbfs evolved, state information about hugetlb pages was added.
> One 'convenient' way of doing this was to use available fields in tail
> pages.  Over time, it has become difficult to know the meaning or contents
> of fields simply by looking at a small bit of code.  Sometimes, the
> naming is just confusing.  For example: The PagePrivate flag indicates
> a huge page reservation was consumed and needs to be restored if an error
> is encountered and the page is freed before it is instantiated.  The
> page.private field contains the pointer to a subpool if the page is
> associated with one.

OK, I thought the page.private was abused more than for this very
specific case.

> In an effort to make the code more readable, use page.private to contain
> hugetlb specific page flags.  These flags will have test, set and clear
> functions similar to those used for 'normal' page flags.  More importantly,
> an enum of flag values will be created with names that actually reflect
> their purpose.

This is definitely a step into the right direction!

> In this patch,
> - Create infrastructure for hugetlb specific page flag functions
> - Move subpool pointer to page[1].private to make way for flags
>   Create routines with meaningful names to modify subpool field

This makes some sense as well. It is really important that the primary
state is stored in the head page. The respective data can be in tail
pages.

> - Use new HPageRestoreReserve flag instead of PagePrivate

Much better! Although wouldn't HPageReserve be sufficient? The flag name
doesn't really need to tell explicitly what to do with the reserve,
right? Or would that be too confusing?

> Conversion of other state information will happen in subsequent patches.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

I do not see any problems with the patch. I hope I haven't overlooked
anything...

Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  fs/hugetlbfs/inode.c    | 12 ++------
>  include/linux/hugetlb.h | 68 +++++++++++++++++++++++++++++++++++++++++
>  mm/hugetlb.c            | 48 +++++++++++++++--------------
>  3 files changed, 96 insertions(+), 32 deletions(-)
-- 
Michal Hocko
SUSE Labs
