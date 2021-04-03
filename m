Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906F33532C7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 08:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhDCGAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 02:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhDCGAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 02:00:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296ABC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 23:00:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d8so3355038plh.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAaQKl6l+W+OYMTU/EWUYcBRjjRXwk1ePM5tTcAuzD4=;
        b=S0ytL73GU9TrzlJmzOtQDr3rN4+twMJGmAEHr+f9DVxxiZhQGSscza27Em+aSYSnMC
         YdnNjTGCZUgSOAcBOwXwjs+HkUNzQ2N6lMYIWPkrTKo4vhSLu+D/QiFDbfl4BCC4uruu
         DgK+PBuXCG5d5rl1YpOH1yi4IbBdMAHHonaCBCdZ9geV/+B2z4EyLAme3FOR8MkXqLM3
         ay99Bn2AsnVUVb5Im/vcptHz8wrXl1m5PaUgQ6Yls8y0PSSMbop4LLf9u3Q2+UYawPcs
         Q3Vx4cUeNJv0Y/iXXvfm2AU0kL4Cm40DeWaSglrrKsAf+eIzZiOqDICAIoJNtz2zBz5J
         RcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAaQKl6l+W+OYMTU/EWUYcBRjjRXwk1ePM5tTcAuzD4=;
        b=SQbW59PQipGzNZ6aWyAUt5TAu5mCCag0G3ud8pziEu8GidlLpKAMvsxOjkPkNkhltH
         dF8VCwpd+MYzV33nBvc8lQrN7TD8F4mxRSKu2X633HnF+HlI/gwSSl+T3cq8RvU7JK0h
         HSP5xICQiw0e3W5CtgYnfvKgeMPfzUZ1ZNqZABAZ26NbYfF7Gyid/KjIEphMvERrYLxe
         i/CND8QSfznSvA+0m+mG5v0ywOMQhU/Fb0k4hhcZ3XtRXZZHPtkrqxbjS1ApamjMGs6G
         Hr1VMYIuFmya58fUsZ3zbDIbBYlcM6t+HjZWfdRraLeB4md2Sl3G6QqGXDvxBD6bVCAq
         kmfg==
X-Gm-Message-State: AOAM531R8U3kkGRrzQHqFMRLdxjXBTCiEwYu54pNiGb49jHcZ9VwA22n
        9s1YHx9FlxqhH6PxIjyPDd/0kntAa97/fySn8RT8/RCuo48ta/0Y
X-Google-Smtp-Source: ABdhPJwlbyVSIA0F18NFErjNqJXZlz9e7drZLaW2EH6P1KcKnQnYUsCm9jYailPuhgKVIkl68eFHVRLPVRDvhM0xleQ=
X-Received: by 2002:a17:902:da91:b029:e5:e7cf:d737 with SMTP id
 j17-20020a170902da91b02900e5e7cfd737mr15434281plx.24.1617429618554; Fri, 02
 Apr 2021 23:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210331034148.112624-1-mike.kravetz@oracle.com>
 <20210331034148.112624-8-mike.kravetz@oracle.com> <CAMZfGtUUWD4WkTOXL3D--jfbHYXUuYQsWtiX0k3UD=_x2SC78g@mail.gmail.com>
 <b0b081e2-9d78-77ab-684f-a0989a7f1d27@oracle.com>
In-Reply-To: <b0b081e2-9d78-77ab-684f-a0989a7f1d27@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 3 Apr 2021 13:59:42 +0800
Message-ID: <CAMZfGtXjhq41iHDy-9gB5Uf8iYrXV1G_eeDgH1XPL-6WgROcuw@mail.gmail.com>
Subject: Re: [External] [PATCH v3 7/8] hugetlb: make free_huge_page irq safe
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 3, 2021 at 4:56 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 4/2/21 5:47 AM, Muchun Song wrote:
> > On Wed, Mar 31, 2021 at 11:42 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in
> >> non-task context") was added to address the issue of free_huge_page
> >> being called from irq context.  That commit hands off free_huge_page
> >> processing to a workqueue if !in_task.  However, this doesn't cover
> >> all the cases as pointed out by 0day bot lockdep report [1].
> >>
> >> :  Possible interrupt unsafe locking scenario:
> >> :
> >> :        CPU0                    CPU1
> >> :        ----                    ----
> >> :   lock(hugetlb_lock);
> >> :                                local_irq_disable();
> >> :                                lock(slock-AF_INET);
> >> :                                lock(hugetlb_lock);
> >> :   <Interrupt>
> >> :     lock(slock-AF_INET);
> >>
> >> Shakeel has later explained that this is very likely TCP TX zerocopy
> >> from hugetlb pages scenario when the networking code drops a last
> >> reference to hugetlb page while having IRQ disabled. Hugetlb freeing
> >> path doesn't disable IRQ while holding hugetlb_lock so a lock dependency
> >> chain can lead to a deadlock.
> >>
> >> This commit addresses the issue by doing the following:
> >> - Make hugetlb_lock irq safe.  This is mostly a simple process of
> >>   changing spin_*lock calls to spin_*lock_irq* calls.
> >> - Make subpool lock irq safe in a similar manner.
> >> - Revert the !in_task check and workqueue handoff.
> >>
> >> [1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
> >>
> >> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >> Acked-by: Michal Hocko <mhocko@suse.com>
> >> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> >
> > Hi Mike,
> >
> > Today I pulled the newest code (next-20210401). I found that
> > alloc_and_dissolve_huge_page is not updated. In this function,
> > hugetlb_lock is still non-irq safe. Maybe you or Oscar need
> > to fix.
> >
> > Thanks.
>
> Thank you Muchun,
>
> Oscar's changes were not in Andrew's tree when I started on this series
> and I failed to notice their inclusion.  In addition,
> isolate_or_dissolve_huge_page also needs updating as well as a change in
> set_max_huge_pages that was omitted while rebasing.
>
> Andrew, the following patch addresses those missing changes.  Ideally,
> the changes should be combined/included in this patch.  If you want me
> to sent another version of this patch or another series, let me know.
>
> From 450593eb3cea895f499ddc343c22424c552ea502 Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Fri, 2 Apr 2021 13:18:13 -0700
> Subject: [PATCH] hugetlb: fix irq locking omissions
>
> The pach "hugetlb: make free_huge_page irq safe" changed spin_*lock
> calls to spin_*lock_irq* calls.  However, it missed several places
> in the file hugetlb.c.  Add the overlooked changes.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks MIke. But there are still some places that need
improvement. See below.

> ---
>  mm/hugetlb.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c22111f3da20..a6bfc6bcbc81 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2284,7 +2284,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>          */
>         page_ref_dec(new_page);
>  retry:
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>         if (!PageHuge(old_page)) {
>                 /*
>                  * Freed from under us. Drop new_page too.
> @@ -2297,7 +2297,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>                  * Fail with -EBUSY if not possible.
>                  */
>                 update_and_free_page(h, new_page);

Now update_and_free_page can be called without holding
hugetlb_lock. We can move it out of hugetlb_lock. In this
function, there are 3 places which call update_and_free_page().
We can move all of them out of hugetlb_lock. Right?

This optimization can squash to the commit:

    "hugetlb: call update_and_free_page without hugetlb_lock"

Thanks.

> -               spin_unlock(&hugetlb_lock);
> +               spin_unlock_irq(&hugetlb_lock);
>                 if (!isolate_huge_page(old_page, list))
>                         ret = -EBUSY;
>                 return ret;
> @@ -2307,7 +2307,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>                  * freelist yet. Race window is small, so we can succed here if
>                  * we retry.
>                  */
> -               spin_unlock(&hugetlb_lock);
> +               spin_unlock_irq(&hugetlb_lock);
>                 cond_resched();
>                 goto retry;
>         } else {
> @@ -2323,7 +2323,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>                 __enqueue_huge_page(&h->hugepage_freelists[nid], new_page);
>         }
>  unlock:
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>
>         return ret;
>  }
> @@ -2339,15 +2339,15 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
>          * to carefully check the state under the lock.
>          * Return success when racing as if we dissolved the page ourselves.
>          */
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>         if (PageHuge(page)) {
>                 head = compound_head(page);
>                 h = page_hstate(head);
>         } else {
> -               spin_unlock(&hugetlb_lock);
> +               spin_unlock_irq(&hugetlb_lock);
>                 return 0;
>         }
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>
>         /*
>          * Fence off gigantic pages as there is a cyclic dependency between
> @@ -2737,7 +2737,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>          * pages in hstate via the proc/sysfs interfaces.
>          */
>         mutex_lock(&h->resize_lock);
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>
>         /*
>          * Check for a node specific request.
> --
> 2.30.2
>
