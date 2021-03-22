Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BD9344775
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhCVOgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:36:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:40490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhCVOf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:35:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616423726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ka7o8YzjuihRvqSaAHVBlNM4iZuzXnEWVNYaDHEt30s=;
        b=GsJ4VZ8ch9CqRDYUamqSvXfTADUchqiUp0ZGbfgY38XyC6G9M+qr/s72nDN88PGa3HNYR5
        7K9yw3l9nCL2UkCkB2dK+T9geEcMlPuaheGoomXCXjb6umrBmsz6YGbL4+0+Qm81qfsAWY
        9Hw3Jxm9ZX6Z1dMYd20+UqMQKMlqksc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB4A5AC1F;
        Mon, 22 Mar 2021 14:35:25 +0000 (UTC)
Date:   Mon, 22 Mar 2021 15:35:25 +0100
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
Subject: Re: [RFC PATCH 6/8] hugetlb: make free_huge_page irq safe
Message-ID: <YFirLYVAQBjA8TVi@dhcp22.suse.cz>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-7-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319224209.150047-7-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-03-21 15:42:07, Mike Kravetz wrote:
> Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in
> non-task context") was added to address the issue of free_huge_page
> being called from irq context.  That commit hands off free_huge_page
> processing to a workqueue if !in_task.  However, as seen in [1] this
> does not cover all cases.  Instead, make the locks taken in the
> free_huge_page irq safe.
> 
> This patch does the following:
> - Make hugetlb_lock irq safe.  This is mostly a simple process of
>   changing spin_*lock calls to spin_*lock_irq* calls.
> - Make subpool lock irq safe in a similar manner.
> - Revert the !in_task check and workqueue handoff.

This is not sufficient (and 0day bot has captured that already). You
cannot call update_and_free_page from the same context.

-- 
Michal Hocko
SUSE Labs
