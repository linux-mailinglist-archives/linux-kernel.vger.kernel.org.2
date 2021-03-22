Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2E13447B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCVOql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:46:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:48104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhCVOq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:46:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616424386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Icvrunq7s47g5UuOx3C1ykL1/UQNOPaopN5BLnKRXPs=;
        b=kmtnnvMkJ8AWU2nH5OpmmbR+C/wd6mZIE+1qW7VfAkrjeffS1DtbbwRtgNc/msHHnaFcoI
        JAjpo8Tt2kccfF+GHA/8PToU4TLpURCzaSIwT/Fc3LzteK7qXCvlMaEbbWFIIAGMxRLstT
        dToveiO9mjjsJTGvlsxIMzds5dOWeoQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 462A5ACFC;
        Mon, 22 Mar 2021 14:46:26 +0000 (UTC)
Date:   Mon, 22 Mar 2021 15:46:25 +0100
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
Message-ID: <YFitwcr8HCKdSP+V@dhcp22.suse.cz>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-8-mike.kravetz@oracle.com>
 <YFis0mIbkTWaX7tM@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFis0mIbkTWaX7tM@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-03-21 15:42:27, Michal Hocko wrote:
[...]
> Besides that the changelog doesn't really say anything about changed
> user visible behavior change. Now if somebody decreases the GB huge pool
> from the userspace the real effect on the freed up memory will be
> postponed to some later time. That "later" is unpredictable as it
> depends on WQ utilization. We definitely need some sort of
> wait_for_inflight pages. One way to do that would be to have a dedicated
> WQ and schedule a sync work item after the pool has been shrunk and wait
> for that item.

Scratch that. It is not really clear from the patch context but after
looking at the resulting code set_max_huge_pages will use the blockable
update_and_free_page so we should be fine.

Sorry about the noise!
-- 
Michal Hocko
SUSE Labs
