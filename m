Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB5D33FAC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 23:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhCQWDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 18:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230456AbhCQWD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 18:03:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5E8964E64;
        Wed, 17 Mar 2021 22:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616018607;
        bh=2n3w4P1GjtrMSjz71K7aiv75/K5sfCyZPkowkP1cYgw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iaFfwnSURRnk54S5AH9kvixkRYpTs+YJRldfCuZJxU3huVrub+mzI/3nVUcjLo4qo
         gU+ehD7xEhReYq25nR1NSMwXpPULiyvuiVjAj1If5IbD2so0OCCsSnBno3xuBzu3xf
         AfHCykW9IBfvHf2NSD61slyrE6+OaZTfwLj5G64A=
Date:   Wed, 17 Mar 2021 15:03:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH v3 1/2] mm: Allow non-VM_DONTEXPAND and VM_PFNMAP
 mappings with MREMAP_DONTUNMAP
Message-Id: <20210317150325.84f6b3fb01402b6bd6dd5ca3@linux-foundation.org>
In-Reply-To: <20210317214147.682687-1-bgeffon@google.com>
References: <20210303175235.3308220-1-bgeffon@google.com>
        <20210317214147.682687-1-bgeffon@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 14:41:46 -0700 Brian Geffon <bgeffon@google.com> wrote:

> Currently MREMAP_DONTUNMAP only accepts private anonymous mappings. This
> change will widen the support to include any mappings which are not
> VM_DONTEXPAND or VM_PFNMAP.

Please update changelog to explain why these two were omitted?

> The primary use case is to support
> MREMAP_DONTUNMAP on mappings which may have been created from a memfd.
> 
> This change will result in mremap(MREMAP_DONTUNMAP) returning -EINVAL
> if VM_DONTEXPAND or VM_PFNMAP mappings are specified.
> 
> Lokesh Gidra who works on the Android JVM, provided an explanation of how
> such a feature will improve Android JVM garbage collection:
> "Android is developing a new garbage collector (GC), based on userfaultfd.
> The garbage collector will use userfaultfd (uffd) on the java heap during
> compaction. On accessing any uncompacted page, the application threads will
> find it missing, at which point the thread will create the compacted page
> and then use UFFDIO_COPY ioctl to get it mapped and then resume execution.
> Before starting this compaction, in a stop-the-world pause the heap will be
> mremap(MREMAP_DONTUNMAP) so that the java heap is ready to receive
> UFFD_EVENT_PAGEFAULT events after resuming execution.
> 
> To speedup mremap operations, pagetable movement was optimized by moving
> PUD entries instead of PTE entries [1]. It was necessary as mremap of even
> modest sized memory ranges also took several milliseconds, and stopping the
> application for that long isn't acceptable in response-time sensitive
> cases.
> 
> With UFFDIO_CONTINUE feature [2], it will be even more efficient to
> implement this GC, particularly the 'non-moveable' portions of the heap.
> It will also help in reducing the need to copy (UFFDIO_COPY) the pages.
> However, for this to work, the java heap has to be on a 'shared' vma.
> Currently MREMAP_DONTUNMAP only supports private anonymous mappings, this
> patch will enable using UFFDIO_CONTINUE for the new userfaultfd-based heap
> compaction."

Is a manpage update planned?  It's appropriate to add this to the
series so folks can check it over.

Can we please get the appropriate updates into
tools/testing/selftests/vm/mremap_test.c for this?

> Signed-off-by: Brian Geffon <bgeffon@google.com>

v3 is getting up there.  Has there been much review activity?

