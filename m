Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0634B566
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 09:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhC0IPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 04:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhC0IPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 04:15:02 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B60FC0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 01:15:02 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y32so4989598pga.11
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 01:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9SuRsp6Io/cDI1hjneWpkO0uDGTpyrTqoHXxffNgOg=;
        b=Sm8Qi4ZLNKguLJdP9CxB2MawgHBEIfbU8+D5Cc1+g8m99gbexr/jBgGkd/MgTtxI+4
         EL88od/C68WV5Tv/1GrQZCk2E/fZoCyGXna0xQAs3HkQasg1x9pWNxk2AgblMbag9xQD
         r3QxJ/M+i6sruMHNqMfeM/zZRwl4lGh40epL7dVuZIowt8+tho+ZpmWJvT6A7peZepZ0
         6K5ekReujWYPmmLduh3CV//RXP31c7WT6ihyY1kgkyPq4lyUDqz5FhXY+BBnEu4WfhuR
         w+NFoFaKVlJS5gHTXFssE4FJrsfOB7Pnn+yN8WrR/hyWhRkhq4z4SRgQ6B/fS/ofGWic
         0ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9SuRsp6Io/cDI1hjneWpkO0uDGTpyrTqoHXxffNgOg=;
        b=kdX5wanBKHW3Ef1Y4QkCjON4eKgNN3ED+z1GLRZLJwfW2CiVH1KKytfOmRp6mwS2ve
         4kO6qSQN9b/yOJy75S8xRNMXeEM0kJFA7HfZ6rm4jW+vWf9Aj6S26yaV5m8ltKBpVFfV
         69NCEM1JLp+YDjE09FaNmQDVRipcPFZKs/E8/RBJmROCv5NNqbmfwI+MbrlQZXzoSbEy
         eFH25kjWvSO2PCdB40cmdajHhmknw+a2Mydgy9wHn25WFhrcu4hfO8s787SYjpUoyxQ9
         TYlB6sY2YuPoQnMDzQLo0+dKeCz2RZB0mlhAvsMwS+L2RxmRALicpeoR5/WXJXGWZ1wL
         zIYw==
X-Gm-Message-State: AOAM531dFWMhy09PTAv15T2zl9C17UXEXTj2Z3qctwOgGCO19/ausTE4
        3EcKKDDRoRVAhWQZtYHh5Fa9xYJ5YaOfjAqjPdt0Mg==
X-Google-Smtp-Source: ABdhPJyPAY4rJVQ8oKa0JIYUA80rdLbdE0GTrkHAaoRoWJHiy2D+bfKN3zaMI/BQjnwjqCc+bPGKo7D8Ysj0UfTcnCM=
X-Received: by 2002:aa7:9e5b:0:b029:1f1:5ba4:57a2 with SMTP id
 z27-20020aa79e5b0000b02901f15ba457a2mr16430493pfq.59.1616832901457; Sat, 27
 Mar 2021 01:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210325002835.216118-1-mike.kravetz@oracle.com> <20210325002835.216118-9-mike.kravetz@oracle.com>
In-Reply-To: <20210325002835.216118-9-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 27 Mar 2021 16:14:25 +0800
Message-ID: <CAMZfGtXy9EJMpQa9Cyne_2n4XzYFVe2hEuizOsZe7oL5n3yyMQ@mail.gmail.com>
Subject: Re: [External] [PATCH 8/8] hugetlb: add lockdep_assert_held() calls
 for hugetlb_lock
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 8:29 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> After making hugetlb lock irq safe and separating some functionality
> done under the lock, add some lockdep_assert_held to help verify
> locking.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

> ---
>  mm/hugetlb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e4c441b878f2..de5b3cf4a155 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1062,6 +1062,8 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>  static void enqueue_huge_page(struct hstate *h, struct page *page)
>  {
>         int nid = page_to_nid(page);
> +
> +       lockdep_assert_held(&hugetlb_lock);
>         list_move(&page->lru, &h->hugepage_freelists[nid]);
>         h->free_huge_pages++;
>         h->free_huge_pages_node[nid]++;
> @@ -1073,6 +1075,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>         struct page *page;
>         bool pin = !!(current->flags & PF_MEMALLOC_PIN);
>
> +       lockdep_assert_held(&hugetlb_lock);
>         list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
>                 if (pin && !is_pinnable_page(page))
>                         continue;
> @@ -1345,6 +1348,7 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
>  {
>         int nid = page_to_nid(page);
>
> +       lockdep_assert_held(&hugetlb_lock);
>         if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>                 return;
>
> @@ -1690,6 +1694,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
>         int nr_nodes, node;
>         struct page *page = NULL;
>
> +       lockdep_assert_held(&hugetlb_lock);
>         for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
>                 /*
>                  * If we're returning unused surplus pages, only examine
> @@ -1939,6 +1944,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
>         long needed, allocated;
>         bool alloc_ok = true;
>
> +       lockdep_assert_held(&hugetlb_lock);
>         needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
>         if (needed <= 0) {
>                 h->resv_huge_pages += delta;
> @@ -2032,6 +2038,7 @@ static void return_unused_surplus_pages(struct hstate *h,
>         struct page *page, *t_page;
>         struct list_head page_list;
>
> +       lockdep_assert_held(&hugetlb_lock);
>         /* Uncommit the reservation */
>         h->resv_huge_pages -= unused_resv_pages;
>
> @@ -2527,6 +2534,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>         struct list_head page_list;
>         struct page *page, *next;
>
> +       lockdep_assert_held(&hugetlb_lock);
>         if (hstate_is_gigantic(h))
>                 return;
>
> @@ -2573,6 +2581,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
>  {
>         int nr_nodes, node;
>
> +       lockdep_assert_held(&hugetlb_lock);
>         VM_BUG_ON(delta != -1 && delta != 1);
>
>         if (delta < 0) {
> --
> 2.30.2
>
