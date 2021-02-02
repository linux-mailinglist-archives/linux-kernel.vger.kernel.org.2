Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C9330C70E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhBBRJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:09:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237247AbhBBRHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612285544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v+1fcZpUJGSqPe1zl7e3r1ocOmADnUob8Rp5BHT4HHk=;
        b=GoxIoHKolpRvHRZsiGHWjG5NaWTImY8wlC9fzyS7IflUCK8XjLYEHZIGYjq9pUtmhLK7dE
        wbHIJ1c4toUhdUSyfFRXd5jFb3icjg7dPz89NT3MGOC6c3rEuLVB/gfNWF42UJ0mEL/I/u
        eD7ZgT1ctvr8NzQunPRVbiLMrcY5PVI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-BuP_ox5cONiNH4NVjwBfTQ-1; Tue, 02 Feb 2021 12:05:41 -0500
X-MC-Unique: BuP_ox5cONiNH4NVjwBfTQ-1
Received: by mail-qv1-f69.google.com with SMTP id k18so2326927qvj.15
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v+1fcZpUJGSqPe1zl7e3r1ocOmADnUob8Rp5BHT4HHk=;
        b=Nz82pRtQSYWHvLQ94VsylMIEySBxcekrN8TD8kCZ3r4Mi1thY4BPeAa47C1xh8Pono
         NdBdaLCIi6cRlggLeQ53uyK2Ij80po72hdpiov0AMj2AIa2xHp/+Ti4toyUnoab0q5eY
         or9T0r1s07N4u+BxyTnNVOyI1mxXGnNTS1hVTocFAkaolMxiL2+POjSv6EOKSXE7ZV3l
         O+gveRSYk6mgF3NuIkuOLqHOJnUmD/ifexRk+w5Jp/sNKio2x8P10LbIeieSrrMgBOLK
         T69LAO4Nn0u+9LF632zu3Ggc0GvNT6ZaV5Vtqf8q3lHaeNTGJmF9VRZwg/ypMUYn75ae
         0/fA==
X-Gm-Message-State: AOAM531uDXfor0f21pVbS8tdgrrTAKK8LT2nPjrvzGRvuC/Y2VVERhiY
        GOPzuQgBu+ct6jX9EhiTSdbdwI84AaAzLoE0aK8O/aqw/jhMLSQLZ1GYr25viMYtu5WUsp77F7E
        rgwzDzqMxPapG77lXfCK8BBs2
X-Received: by 2002:ac8:5c0f:: with SMTP id i15mr21179462qti.152.1612285540352;
        Tue, 02 Feb 2021 09:05:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVYvXbx1aYCp2m6Z1qjq0RDFhIwHj+UOGix7nhMTiN6DYUXpr7fokobWIsOXak0A4NmvHXZw==
X-Received: by 2002:ac8:5c0f:: with SMTP id i15mr21179421qti.152.1612285540084;
        Tue, 02 Feb 2021 09:05:40 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id l38sm16761303qte.88.2021.02.02.09.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 09:05:39 -0800 (PST)
Date:   Tue, 2 Feb 2021 12:05:36 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     20200918161902.GX8409@ziepe.ca,
        Linus Torvalds <torvalds@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Zhang, Wei" <wzam@amazon.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20210202170536.GE6468@xz-x1>
References: <27564187-4a08-f187-5a84-3df50009f6ca@amazon.com>
 <20210202163127.GD6468@xz-x1>
 <20210202164420.GL4718@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210202164420.GL4718@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 12:44:20PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 02, 2021 at 11:31:27AM -0500, Peter Xu wrote:
> > On Tue, Feb 02, 2021 at 04:40:33PM +0200, Gal Pressman wrote:
> > > Hi Peter & Jason,
> > 
> > Hi, Gal, Jason,
> > 
> > > 
> > > It seems the hugetlb part was overlooked?
> > > We're testing if the RDMA fork MADV_DONTFORK stuff can be removed on appropriate
> > > kernels, but our tests still fail due to lacking explicit huge pages support [1].
> > 
> > I didn't think it high priority only because I think most hugetlbfs users
> > should be using it shared, but maybe I'm wrong..  Then it got lost indeed.
> 
> It turns out people are doing this:
> 
> mmap(NULL, SEND_BUFF_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0)
> 
> Which makes some sense...

Yes, thanks Jason.  Though my understanding is that hugetlb pages are normally
reserved in production, used with careful pre-provisioning on which app would
consume how much (either 2M or 1G).  Such an app (especially if it forks
randomly) could actually easily exaust the huge page pool.

> 
> Gal, you could also MADV_DONTFORK this range if you are explicitly
> allocating them via special mmap.

Yeah I wanted to mention this one too but I just forgot when reply: the issue
thread previously pasted smells like some people would like to drop
MADV_DONTFORK, but if it's able to still be applied I don't know why not.. It
should still be better than depending on the coming patch imho - it marks the
region as "not necessary for the fork" then we skip the whole hugetlbfs chunk.
It should at least be more efficient if applicable.

Thanks,

-- 
Peter Xu

