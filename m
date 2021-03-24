Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FF63473C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhCXIgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:36:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:39418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhCXIg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:36:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616574981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mt21mzndWXnoKj4VEg4Qe8nZIASbLqeRQGWJ6Q9oDrk=;
        b=sr7h+ok4LZNJXBiqpPlUhNKwnC5jT9zVd+NpJX3fysewOyKvA8Z1AtV1P7iMzP1xzs2/cI
        2Khivmn/kTad78NGlzjLvA4nYkvo4sSpSMXIOLe0VpfVHyd8cLVQTGFNH2UXJaNFuRg8kJ
        qL31d3LDsokJnpodB9pzK+XI9j7pVS4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E16DAB9B;
        Wed, 24 Mar 2021 08:36:21 +0000 (UTC)
Date:   Wed, 24 Mar 2021 09:36:19 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/8] hugetlb: recompute min_count when dropping
 hugetlb_lock
Message-ID: <YFr6A927XhhiciFj@dhcp22.suse.cz>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-3-mike.kravetz@oracle.com>
 <YFikrdN6DHQSEm6a@dhcp22.suse.cz>
 <a7d90d58-fa6a-7fa1-77c9-a08515746018@oracle.com>
 <YFmd3d5B2VT4GkiG@dhcp22.suse.cz>
 <YFmgPkTzZY6Ocj6X@hirez.programming.kicks-ass.net>
 <YFmjVNnnHHpyxqKe@dhcp22.suse.cz>
 <52db15d1-4ed1-6c3c-b638-6efdccf6e62e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52db15d1-4ed1-6c3c-b638-6efdccf6e62e@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-03-21 16:18:08, Mike Kravetz wrote:
[...]
> Here is another thought.
> In patch 5 you suggest removing all pages from hugetlb with the lock
> held, and adding them to a list.  Then, drop the lock and free all
> pages on the list.  If we do this, then the value computed here (min_count)
> can not change while we are looping.  So, this patch would be unnecessary.
> That is another argument in favor of batching the frees.
> 
> Unless there is something wrong in my thinking, I am going to take that
> approach and drop this patch.

Makes sense
-- 
Michal Hocko
SUSE Labs
