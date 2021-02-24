Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580AB3235F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 04:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhBXDNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 22:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhBXDNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 22:13:30 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C38C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 19:12:49 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o6so376925pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 19:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFULzAc/mZwTu4MwnUnbVT8/ReUTi/Z2jlYjFg/fijQ=;
        b=s/FXoGhB+0wBSwCAVj7xFyxtkvRH+Dfq7i7VMgepshay+dgQFsx+8F2j+1A1l+yZSW
         uS0C10xE4DuvW9ZZgu5+C4vUhoLisBLVAEoCRhoWLU0YFWuAKDWMRFrNyHk69BIl1/FL
         7+uz4hjNg+KVEVs5xsTjCN4rMAjcTFu26gjKK8AEkT8utljA2m1x4wAQ3stquQ+9Fskf
         KsXenCVK0XTKM0zmWIpAxhjvw4EBcv87kfXrzo08DwaMH3VmFUDK/nPiOVL74ev5+V6G
         kLlqYdito6kvqJzhA5KNP9XXsPMPPQQVLYM45rspSTLDZSsGdbJPkva/nmCgLRhqMFST
         zslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFULzAc/mZwTu4MwnUnbVT8/ReUTi/Z2jlYjFg/fijQ=;
        b=qA2ZXAujpwlirJwJmYN4eS9tQD8GXshMyloHZwDcUk//4tgL1eBkyXimAoHffrTDYd
         2CfA0L1tKNbilc6NBoAOtfTkBh2PSHUXDIERGxU3hm7vTYhc2J5oijS6xI5F1F+k9HgM
         RtffOrKgN0zJK2Q9RE593hja8tg2zJqtTOP7Pn5nNFfBjMiq8gMepPMnCJQsgXdi7zZ4
         iJgJZ95EXCTKOYPdW/UuaFipvxMpqXtwcBYNR7Eu67XC1ul6rvOJzb3R13DcdNj3DaFR
         GXEEbYb4jAkOVWtl6bHKjDpJvvX8YDnNEBmZQ4PuO1e17qa6Ws+IhPUvwxAqE+smJAo9
         rbPA==
X-Gm-Message-State: AOAM530ilO3vl6G8QGg9PsoyOibGL52Lc+ZXunhkP+e0we/TqP3zLZ8d
        wtBHEELVmdsIlFGO//TVtZWQx8vmffxVSYLcr0CFBA==
X-Google-Smtp-Source: ABdhPJy6WO/CqnMs2EePcUsJytickc8pRFSiapLFnOudH7qIQmg47W4SHQgO4ywBZcbN9C3IPV/QtkFbBdPlRS+4M4E=
X-Received: by 2002:a17:902:d4c2:b029:e3:cb77:e51 with SMTP id
 o2-20020a170902d4c2b02900e3cb770e51mr22057294plg.20.1614136369167; Tue, 23
 Feb 2021 19:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20210223215544.313871-1-mike.kravetz@oracle.com>
In-Reply-To: <20210223215544.313871-1-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 24 Feb 2021 11:12:12 +0800
Message-ID: <CAMZfGtXVdrYbZwj1D6pp2fcKLytaZDJNK0u1hBfR-w+7H-zEeg@mail.gmail.com>
Subject: Re: [External] [PATCH] hugetlb: fix uninitialized subpool pointer
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 5:56 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Gerald Schaefer reported a panic on s390 in hugepage_subpool_put_pages()
> with linux-next 5.12.0-20210222.
> Call trace:
>   hugepage_subpool_put_pages.part.0+0x2c/0x138
>   __free_huge_page+0xce/0x310
>   alloc_pool_huge_page+0x102/0x120
>   set_max_huge_pages+0x13e/0x350
>   hugetlb_sysctl_handler_common+0xd8/0x110
>   hugetlb_sysctl_handler+0x48/0x58
>   proc_sys_call_handler+0x138/0x238
>   new_sync_write+0x10e/0x198
>   vfs_write.part.0+0x12c/0x238
>   ksys_write+0x68/0xf8
>   do_syscall+0x82/0xd0
>   __do_syscall+0xb4/0xc8
>   system_call+0x72/0x98
>
> This is a result of the change which moved the hugetlb page subpool
> pointer from page->private to page[1]->private.  When new pages are
> allocated from the buddy allocator, the private field of the head
> page will be cleared, but the private field of subpages is not modified.
> Therefore, old values may remain.
>
> Fix by initializing hugetlb page subpool pointer in prep_new_huge_page().
>
> Fixes: f1280272ae4d ("hugetlb: use page.private for hugetlb specific page flags")
> Reported-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

> ---
>  mm/hugetlb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c232cb67dda2..7ae5c18c98a7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1465,6 +1465,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  {
>         INIT_LIST_HEAD(&page->lru);
>         set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> +       hugetlb_set_page_subpool(page, NULL);
>         set_hugetlb_cgroup(page, NULL);
>         set_hugetlb_cgroup_rsvd(page, NULL);
>         spin_lock(&hugetlb_lock);
> --
> 2.29.2
>
