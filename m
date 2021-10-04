Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB84442116E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhJDOe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:34:28 -0400
Received: from out2.migadu.com ([188.165.223.204]:61281 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234021AbhJDOe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:34:27 -0400
Date:   Mon, 4 Oct 2021 23:32:28 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633357957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sqfgVz/9I9K4KamPvNycNExje+swH63ObdWWIwX9lL0=;
        b=ab9jun9Daj2WzTS+9xxyU1duapIjcVsi7r15EhDxVhJlyYsph6hq5CgjfP2mcN/6r8vXhh
        JMzR+JMq7ofPAFz/Y39rIlxlZUH96f4qs4g9xizVi3KtC/4AuKxmBKIGiqBs0pZkDW6ACL
        JgtcZqPUxwwVZOrPYEHfSp227Xv38U8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Bin Wang <wangbin224@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm, pagemap: expose hwpoison entry
Message-ID: <20211004143228.GA1545442@u2004>
References: <20211004115001.1544259-1-naoya.horiguchi@linux.dev>
 <258d0ddb-6c82-0c95-a15e-b085b59d2142@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <258d0ddb-6c82-0c95-a15e-b085b59d2142@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 01:55:30PM +0200, David Hildenbrand wrote:
> On 04.10.21 13:50, Naoya Horiguchi wrote:
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > 
> > A hwpoison entry is a non-present page table entry to report
> > memory error events to userspace. If we have an easy way to know
> > which processes have hwpoison entries, that might be useful for
> > user processes to take proper actions. But we don't have it now.
> > So make pagemap interface expose hwpoison entries to userspace.
> 
> Noting that this is only a way to inspect hwpoison set for private anonymous
> memory. You cannot really identify anything related to shared memory.
> 
> Do you also handle private hugetlb pages?

I think yes.  As long as hugepages are mmap()ed, we should be able to
identify them with hwpoison entry (even if used via private/shared mapping).

> 
> > 
> > Hwpoison entry for hugepage is also exposed by this patch. The below
> > example shows how pagemap is visible in the case where a memory error
> > hit a hugepage mapped to a process.
> > 
> >      $ ./page-types --no-summary --pid $PID --raw --list --addr 0x700000000+0x400
> >      voffset offset  len     flags
> >      700000000       12fa00  1       ___U_______Ma__H_G_________________f_______1
> >      700000001       12fa01  1ff     ___________Ma___TG_________________f_______1
> >      700000200       12f800  1       __________B________X_______________f______w_
> >      700000201       12f801  1       ___________________X_______________f______w_   // memory failure hit this page
> >      700000202       12f802  1fe     __________B________X_______________f______w_
> > 
> > The entries with both of "X" flag (hwpoison flag) and "w" flag (swap
> > flag) are considered as hwpoison entries.  So all pages in 2MB range
> > are inaccessible from the process.  We can get actual error location
> > by page-types in physical address mode.
> > 
> >      $ ./page-types --no-summary --addr 0x12f800+0x200 --raw --list
> >      offset  len     flags
> >      12f800  1       __________B_________________________________
> >      12f801  1       ___________________X________________________
> >      12f802  1fe     __________B_________________________________
> > 
> > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > ---
> >   fs/proc/task_mmu.c      | 41 ++++++++++++++++++++++++++++++++---------
> >   include/linux/swapops.h | 13 +++++++++++++
> >   tools/vm/page-types.c   |  7 ++++++-
> >   3 files changed, 51 insertions(+), 10 deletions(-)
> 
> 
> Please also update the documentation located at
> 
> Documentation/admin-guide/mm/pagemap.rst

I will do this in the next post.

Thanks,
Naoya Horigcuhi
