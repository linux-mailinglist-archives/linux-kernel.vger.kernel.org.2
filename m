Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43BD323B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhBXLha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:37:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:45872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234970AbhBXLhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:37:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614166591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0541fh0BrcejOOEU1ZwkNGq54Tbr8fji1MTShXhrzVs=;
        b=t4nsHb6IxWwH+2Y3foM95FqT/cti2mxfXB6ltZyHOInHU6SC3EJ74DIkngi9TcsckOUIWD
        zHeqF8VUevSWaZsgXHO59UyyQnsuPD4c3tOf978cpczTn7uzOC62QH5qxk+IPUyihg6mCh
        JBHIQEi9tvsmeMCayOPVO3zBVxeKohA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9164ADDC;
        Wed, 24 Feb 2021 11:36:31 +0000 (UTC)
Date:   Wed, 24 Feb 2021 12:36:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [External] Re: [PATCH] hugetlb: fix uninitialized subpool pointer
Message-ID: <YDY6PkTcUOXZE/Xg@dhcp22.suse.cz>
References: <20210223215544.313871-1-mike.kravetz@oracle.com>
 <YDYfwuSjFsa8iWTT@dhcp22.suse.cz>
 <CAMZfGtXBKvz6wg-N5LpwMcensRiiwnKYa5XDnGi2ueBMa0Q+NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXBKvz6wg-N5LpwMcensRiiwnKYa5XDnGi2ueBMa0Q+NA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-02-21 19:10:42, Muchun Song wrote:
> On Wed, Feb 24, 2021 at 5:43 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 23-02-21 13:55:44, Mike Kravetz wrote:
> > > Gerald Schaefer reported a panic on s390 in hugepage_subpool_put_pages()
> > > with linux-next 5.12.0-20210222.
> > > Call trace:
> > >   hugepage_subpool_put_pages.part.0+0x2c/0x138
> > >   __free_huge_page+0xce/0x310
> > >   alloc_pool_huge_page+0x102/0x120
> > >   set_max_huge_pages+0x13e/0x350
> > >   hugetlb_sysctl_handler_common+0xd8/0x110
> > >   hugetlb_sysctl_handler+0x48/0x58
> > >   proc_sys_call_handler+0x138/0x238
> > >   new_sync_write+0x10e/0x198
> > >   vfs_write.part.0+0x12c/0x238
> > >   ksys_write+0x68/0xf8
> > >   do_syscall+0x82/0xd0
> > >   __do_syscall+0xb4/0xc8
> > >   system_call+0x72/0x98
> > >
> > > This is a result of the change which moved the hugetlb page subpool
> > > pointer from page->private to page[1]->private.  When new pages are
> > > allocated from the buddy allocator, the private field of the head
> > > page will be cleared, but the private field of subpages is not modified.
> > > Therefore, old values may remain.
> >
> > Very interesting. I have expected that the page->private would be in a
> > reasonable state when allocated. On the other hand hugetlb doesn't do
> > __GFP_COMP so tail pages are not initialized by the allocator.
> 
> It seems that the buddy allocator does not initialize the private field
> of the tail page even when we specify __GFP_COMP.

Yes it doesn't. What I meant to say is that even if it did a lack of
__GFP_COMP would result in not doing so. I do not remember why hugetlb
doesn't use __GFP_COMP but I believe this was never the case.
-- 
Michal Hocko
SUSE Labs
