Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4834F323B21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhBXLOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhBXLL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:11:59 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6E0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 03:11:19 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d16so1011793plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 03:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vAKxjW8aVSXqFqWx4f3GRoI/AUfMwclY5/WIXe9xg20=;
        b=eMtl3I/NFjT2Y6XNR8VbwQqWB+0/pvmOd+Gu9gejW7FK5oNjcH6PCWbYgKDUlSJ8Lq
         QHlgHp8zhjE6agmTGG0kPHqiKn9BSTZze0BRGkgoSR6gTO6W+mbHvBLpQOBCHoc3ZP7q
         ZmcP8aUI9ZhLnvV0h4trYmT8+QmfCQ/UsMZVkqp3JeesqDVSX3wNxTr0ihjFStDFtwF3
         EMV0xuGA6rZkRTyNy6rt+Sa0BfM713DH+mfADzQkBS8OrbPZxLvZqC/Yl+CftksTg1NL
         BPyUyeTSBjkMHMXorCl+Kb7BdpSgu8GxHBJHhexH4bJHinCErOdVex7alK2li2f1H4u+
         mA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAKxjW8aVSXqFqWx4f3GRoI/AUfMwclY5/WIXe9xg20=;
        b=rDDJiSIy6s8/KR+KpwboyyFUuDNMJPsgy8K5YYG3oafl+NsezlrEW2I11u7tJSI6il
         euK8Z5sWRBovQTdhMUXgxxPQYLqK8iDCdwx+9AlcXi1WFmD5pnxeaOxlp1ewidK4Y4SF
         FsJsvKywSgmDbb5G1+8AC4cACB0TKhX+caRVupD2N4lS3LaEwODqzlFlW3p3YCpyjfre
         r3hAZagAt5SVYtvSe8dIAPKEWrBESDoQDK0jlZVYUtM/g4BWo2vQYY5VUkmjopKEJROc
         wCFBixjMaypWxZ3zqVCClo9cMx0lC2rW8OrQxoIkitdkdy/7e6AMy/zBdPqnxz+sOD51
         C9sg==
X-Gm-Message-State: AOAM532sjx3t4IXfXrk9/QEOxL5C/ocmSddSdxIwuZKWQXBcJPDDKB4u
        Q1x+5jiiBVC/JDTADi8Nirn+UwV3A2CtKtPbRCUpfg==
X-Google-Smtp-Source: ABdhPJyi8JLZm8Sa4P/gfDzgwCWFgJv+NI/R93nDiZML3L91yMZveEWGbhtavjmU6DxpKeqJeaPFJuDCAvmqRxXIfDY=
X-Received: by 2002:a17:902:e54e:b029:e3:9f84:db8e with SMTP id
 n14-20020a170902e54eb02900e39f84db8emr31888446plf.24.1614165079161; Wed, 24
 Feb 2021 03:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20210223215544.313871-1-mike.kravetz@oracle.com> <YDYfwuSjFsa8iWTT@dhcp22.suse.cz>
In-Reply-To: <YDYfwuSjFsa8iWTT@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 24 Feb 2021 19:10:42 +0800
Message-ID: <CAMZfGtXBKvz6wg-N5LpwMcensRiiwnKYa5XDnGi2ueBMa0Q+NA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] hugetlb: fix uninitialized subpool pointer
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 5:43 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 23-02-21 13:55:44, Mike Kravetz wrote:
> > Gerald Schaefer reported a panic on s390 in hugepage_subpool_put_pages()
> > with linux-next 5.12.0-20210222.
> > Call trace:
> >   hugepage_subpool_put_pages.part.0+0x2c/0x138
> >   __free_huge_page+0xce/0x310
> >   alloc_pool_huge_page+0x102/0x120
> >   set_max_huge_pages+0x13e/0x350
> >   hugetlb_sysctl_handler_common+0xd8/0x110
> >   hugetlb_sysctl_handler+0x48/0x58
> >   proc_sys_call_handler+0x138/0x238
> >   new_sync_write+0x10e/0x198
> >   vfs_write.part.0+0x12c/0x238
> >   ksys_write+0x68/0xf8
> >   do_syscall+0x82/0xd0
> >   __do_syscall+0xb4/0xc8
> >   system_call+0x72/0x98
> >
> > This is a result of the change which moved the hugetlb page subpool
> > pointer from page->private to page[1]->private.  When new pages are
> > allocated from the buddy allocator, the private field of the head
> > page will be cleared, but the private field of subpages is not modified.
> > Therefore, old values may remain.
>
> Very interesting. I have expected that the page->private would be in a
> reasonable state when allocated. On the other hand hugetlb doesn't do
> __GFP_COMP so tail pages are not initialized by the allocator.

It seems that the buddy allocator does not initialize the private field
of the tail page even when we specify __GFP_COMP.


>
> > Fix by initializing hugetlb page subpool pointer in prep_new_huge_page().
> >
> > Fixes: f1280272ae4d ("hugetlb: use page.private for hugetlb specific page flags")
>
> This is not a stable sha to refer to as it comes from linux next.
>
> > Reported-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> I think this would be worth a separate patch rather than having it
> folded into the original patch. Thi is really subtle.
>
> > ---
> >  mm/hugetlb.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index c232cb67dda2..7ae5c18c98a7 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1465,6 +1465,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
> >  {
> >       INIT_LIST_HEAD(&page->lru);
> >       set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> > +     hugetlb_set_page_subpool(page, NULL);
> >       set_hugetlb_cgroup(page, NULL);
> >       set_hugetlb_cgroup_rsvd(page, NULL);
> >       spin_lock(&hugetlb_lock);
> > --
> > 2.29.2
> >
>
> --
> Michal Hocko
> SUSE Labs
