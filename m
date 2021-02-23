Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE6323410
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhBWXAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:00:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:49214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232598AbhBWWqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:46:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A642AC69;
        Tue, 23 Feb 2021 22:45:42 +0000 (UTC)
Date:   Tue, 23 Feb 2021 23:45:40 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: fix uninitialized subpool pointer
Message-ID: <20210223224540.GB2740@localhost.localdomain>
References: <20210223215544.313871-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223215544.313871-1-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 01:55:44PM -0800, Mike Kravetz wrote:
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

Do we need the hugetlb_set_page_subpool() in __free_huge_page?

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
