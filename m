Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A3C34C534
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhC2HtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:49:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:41870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhC2HtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:49:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617004157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vFHJ4JGDDiBA44nm8xVddU83hXh/LFKuGl5xqRH1qKc=;
        b=c1htYbeZQB91YR1m5OPqrf+mR8rUAcSzMa/VloNbI5FSETiXYdF9JKOtrd/0R7G2yLHviW
        H6Qv8jJzuQl/OxYGwZdR/K7MUAMshYhNjILe8lTwZ6wzT73yJ7VhagFGCkLqG5t6DSPdl/
        ITh7Z38NLoNb/F29zCoS1QNOipwZW/A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46305B333;
        Mon, 29 Mar 2021 07:49:17 +0000 (UTC)
Date:   Mon, 29 Mar 2021 09:49:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [External] [PATCH 7/8] hugetlb: make free_huge_page irq safe
Message-ID: <YGGGfBE0JVrxyFsW@dhcp22.suse.cz>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-8-mike.kravetz@oracle.com>
 <CAMZfGtVghACpXiXRrNhQa-fM8A+-xBZvsW+QiEUU1Rqjhd2W5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVghACpXiXRrNhQa-fM8A+-xBZvsW+QiEUU1Rqjhd2W5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 27-03-21 15:06:36, Muchun Song wrote:
> On Thu, Mar 25, 2021 at 8:29 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in
> > non-task context") was added to address the issue of free_huge_page
> > being called from irq context.  That commit hands off free_huge_page
> > processing to a workqueue if !in_task.  However, as seen in [1] this
> > does not cover all cases.  Instead, make the locks taken in the
> > free_huge_page irq safe.
> >
> > This patch does the following:
> > - Make hugetlb_lock irq safe.  This is mostly a simple process of
> >   changing spin_*lock calls to spin_*lock_irq* calls.
> > - Make subpool lock irq safe in a similar manner.
> > - Revert the !in_task check and workqueue handoff.
> >
> > [1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
> >
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> The changes are straightforward.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> 
> Since this patchset aims to fix a real word issue. Should we add a Fixes
> tag?

Do we know since when it is possible to use hugetlb in the networking
context? Maybe this is possible since ever but I am wondering why the
lockdep started complaining only now. Maybe just fuzzing finally started
using this setup which nobody does normally.
-- 
Michal Hocko
SUSE Labs
