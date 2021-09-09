Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54936404CF8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 14:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245125AbhIIL7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:59:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42420 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241088AbhIILzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:55:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1BDBA1FDEA;
        Thu,  9 Sep 2021 11:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631188472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bnU+HtTYKZVwaE80A++rJfB4IJVmmPy41Bjr0LW+UBk=;
        b=q2SbhZ0A68UeuUHoQJhZFlAC/dQtGULYwguqWPb5BCrAFM0VNKmRU5aIYFYXCAc+35lB9S
        jgXR4ZnEOb5a5ieqf4ChqPNoVAvYjJmSZdnuuj0t+QoT5x+5L21OKadwWXs9RYKtL1lrwS
        43kIF58v8EpO+s0zxt/PszKVUVtg83Q=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A23FDA3D64;
        Thu,  9 Sep 2021 11:54:31 +0000 (UTC)
Date:   Thu, 9 Sep 2021 13:54:31 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Hillf Danton <hdanton@sina.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
Message-ID: <YTn196em42sDsXs+@dhcp22.suse.cz>
References: <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
 <b4401912-b59a-2150-feef-468c2d25ba3e@oracle.com>
 <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
 <10d86c18-f0cf-395f-4209-17ac71b9fc03@oracle.com>
 <efcf6049-6110-d516-b21f-41bb8775f042@suse.cz>
 <2d826470-d345-0196-1359-b79ed08dfc66@oracle.com>
 <b3b334ea-0e6f-ced9-e444-df4ec49455a0@suse.cz>
 <02a1a50f-4e7c-4eb7-519c-35b26ec2c6af@oracle.com>
 <20210907085001.3773-1-hdanton@sina.com>
 <6c42bed7-d4dd-e5eb-5a74-24cf64bf52d3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c42bed7-d4dd-e5eb-5a74-24cf64bf52d3@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-09-21 14:00:19, Mike Kravetz wrote:
> On 9/7/21 1:50 AM, Hillf Danton wrote:
> > On Mon, 6 Sep 2021 16:40:28 +0200 Vlastimil Babka wrote:
> >> On 9/2/21 20:17, Mike Kravetz wrote:
> >>>
> >>> Here is some very high level information from a long stall that was
> >>> interrupted.  This was an order 9 allocation from alloc_buddy_huge_page().
> >>>
> >>> 55269.530564] __alloc_pages_slowpath: jiffies 47329325 tries 609673 cpu_tries 1   node 0 FAIL
> >>> [55269.539893]     r_tries 25       c_tries 609647   reclaim 47325161 compact 607     
> >>>
> >>> Yes, in __alloc_pages_slowpath for 47329325 jiffies before being interrupted.
> >>> should_reclaim_retry returned true 25 times and should_compact_retry returned
> >>> true 609647 times.
> >>> Almost all time (47325161 jiffies) spent in __alloc_pages_direct_reclaim, and
> >>> 607 jiffies spent in __alloc_pages_direct_compact.
> >>>
> >>> Looks like both
> >>> reclaim retries > MAX_RECLAIM_RETRIES
> >>> and
> >>> compaction retries > MAX_COMPACT_RETRIES
> >>>
> >> Yeah AFAICS that's only possible with the scenario I suspected. I guess
> >> we should put a limit on compact retries (maybe some multiple of
> >> MAX_COMPACT_RETRIES) even if it thinks that reclaim could help, while
> >> clearly it doesn't (i.e. because somebody else is stealing the page like
> >> in your test case).
> > 
> > And/or clamp reclaim retries for costly orders
> > 
> > 	reclaim retries = MAX_RECLAIM_RETRIES - order;
> > 
> > to pull down the chance for stall as low as possible.
> 
> Thanks, and sorry for not replying quickly.  I only get back to this as
> time allows.
> 
> We could clamp the number of compaction and reclaim retries in
> __alloc_pages_slowpath as suggested.  However, I noticed that a single
> reclaim call could take a bunch of time.  As a result, I instrumented
> shrink_node to see what might be happening.  Here is some information
> from a long stall.  Note that I only dump stats when jiffies > 100000.
> 
> [ 8136.874706] shrink_node: 507654 total jiffies,  3557110 tries
> [ 8136.881130]              130596341 reclaimed, 32 nr_to_reclaim
> [ 8136.887643]              compaction_suitable results:
> [ 8136.893276]     idx COMPACT_SKIPPED, 3557109

Can you get a more detailed break down of where the time is spent. Also
How come the number of reclaimed pages is so excessive comparing to the
reclaim target? There is something fishy going on here.
-- 
Michal Hocko
SUSE Labs
