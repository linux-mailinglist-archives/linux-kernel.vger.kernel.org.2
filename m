Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0A73445B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhCVN1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231174AbhCVN1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616419654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TbWk1Sl1EYOavMer1olo6Jpzca7vciI8lgyKwGdK0Gs=;
        b=hn06i9QQWKJFzCfaDwwp3gOf3oT1JAWP9i8ynDBGUdzlMlSwvqRsIrRebOzgLkEkbLlBOi
        L8SY3Gu1bUA/eX1x8HdsHjwA26BweKuXL7L+dp6Ywt9qZ9ZzG0GjD0F6HD3oQwSOz8xZ16
        vkM+iFVGh4/Zqw7t6hJ+ORt9qJ9rlys=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-jwlvAYkDOhC3C8VIkGYAkQ-1; Mon, 22 Mar 2021 09:27:33 -0400
X-MC-Unique: jwlvAYkDOhC3C8VIkGYAkQ-1
Received: by mail-qv1-f72.google.com with SMTP id ev19so20044780qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TbWk1Sl1EYOavMer1olo6Jpzca7vciI8lgyKwGdK0Gs=;
        b=bwBRng5XdnDk73czySUJQxDyQk9N/WV4mzXIwoYSLrthhQ0n7V33B+LR/rUT0H2Nt/
         SgZGiXZiAKqnd3BxHaGZoPtP/SLuY2669qOJPgW6MPtLdO+V1oSTNtFFAguQQmeRv/Y2
         9wb2N2kXpwEJZ1e0FSmV2H2BmjHWJX3F4X6kX5gF3CrDRI2VFO6W7USx9IpJpUZQqM+f
         1hrum8nPCYJh0TLkO85SCJjYqdJqDzL0O3Z8iuY2173QS69zO8oazEKEOmJua7WSdZ98
         8KcuxwYGHMWonKCHgvw0M2xdaLpPbK30QStJp3Py1f6e0OSR95KplopMrsU6tflpCoyf
         N0Hw==
X-Gm-Message-State: AOAM531AwmZ+cO6OS8EFLz/9FS6fIG87il9o9hyJuchuX38aO+nDVPjY
        +13m6/Z7kWCO4cu01noN0z+PgkSts6byeKbkr2WI7DPyqgI3E4t2/GHX9/hbsZpVhW1l0i0a7eU
        Vkm6vybox4DaBkLIdyY0dpjzr
X-Received: by 2002:a05:6214:80a:: with SMTP id df10mr5456qvb.46.1616419652239;
        Mon, 22 Mar 2021 06:27:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyC/gQ9X/9EFNMDb1RpfZCxrAAff/wp7MDsEz1JJ8PjeoC0NPY0pqXEBIhZbSMC4EICu8+jgg==
X-Received: by 2002:a05:6214:80a:: with SMTP id df10mr5415qvb.46.1616419651779;
        Mon, 22 Mar 2021 06:27:31 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id k126sm11026555qkb.4.2021.03.22.06.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 06:27:30 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:27:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Bui Quang Minh <minhquangbui99@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH] userfaultfd: Write protect when virtual memory range has
 no page table entry
Message-ID: <20210322132730.GA16645@xz-x1>
References: <20210319152428.52683-1-minhquangbui99@gmail.com>
 <YFhuDf6L7nkUoT7q@dhcp22.suse.cz>
 <YFiU9YWbYpLnlnde@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFiU9YWbYpLnlnde@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:00:37PM +0200, Mike Rapoport wrote:
> On Mon, Mar 22, 2021 at 11:14:37AM +0100, Michal Hocko wrote:
> > Le'ts Andrea and Mike
> > 
> > On Fri 19-03-21 22:24:28, Bui Quang Minh wrote:
> > > userfaultfd_writeprotect() use change_protection() to clear write bit in
> > > page table entries (pte/pmd). So, later write to this virtual address
> > > range causes a page fault, which is then handled by userspace program.
> > > However, change_protection() has no effect when there is no page table
> > > entries associated with that virtual memory range (a newly mapped memory
> > > range). As a result, later access to that memory range causes allocating a
> > > page table entry with write bit still set (due to VM_WRITE flag in
> > > vma->vm_flags).
> > > 
> > > Add checks for VM_UFFD_WP in vma->vm_flags when allocating new page table
> > > entry in missing page table entry page fault path.
> > 
> > From the above it is not really clear whether this is a usability
> > problem or a bug of the interface.
> 
> I'd say it's usability/documentation clarity issue. 
> Userspace can register an area with
> 
> 	UFFDIO_REGISTER_MODE_MISSING | UFFDIO_REGISTER_MODE_WP
> 
> and then it will be notified either when page table has no entry for a
> virtual address or when there is a write to a write protected address.

Right, it's debatable to make it a default behavior since there can be some
application that does not care about zero pages - since currently userfaultfd
wr-protect only works for anonymous page, so any missing entry means a zero
page to be allocated.

Currently if we want to wr-protect all pages including zero pages, we can
either do as what Mike suggested, or one can pre-read the range to fault in the
pages.  The double-mode solution should be even better, since then the user app
would have a chance to know it's zero page without even scanning it.

It'll be a new story for page-cache backed memory regions, and that's indeed
the major work contained in the upcoming shmem+hugetlbfs uffd-wp support series
[1] to allow persisting uffd-wp/write bit even without page table entries,
because then the entry can be null even when there's page cache (so it'll
bypass uffdio missing messages too).

If this behavior is very desired, how about define a new feature bit, say
UFFD_FEATURE_WP_UNALLOCATED?  This could be more efficient than registering
with two modes, since we can do the later UFFDIO_COPY along with the MISSING
page fault as in this patch, meanwhile that'll also contain the same semantic
as UFFDIO_ZEROCOPY so less data copy too (UFFDIO_ZEROCOPY does not support
UFFDIO_COPY_MODE_WP so far).  However we need to be careful on mixture use of
these, e.g., I think UFFD_FEATURE_WP_UNALLOCATED at least shouldn't be allowed
with UFFDIO_REGISTER_MODE_MISSING, otherwise the behavior of missing fault on
uffd-wp area will be undefined.

Thoughts?

[1] https://lore.kernel.org/lkml/20210115170907.24498-1-peterx@redhat.com/

Thanks,

-- 
Peter Xu

