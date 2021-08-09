Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968EB3E44A0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhHILYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbhHILYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:24:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B088C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZQlR1NWfHc+K2Vy1e2qCq+hN81CMxlQnYLSgBZIPQtI=; b=vE/x5V/fQGAhEsUx/0Tq/oFp+8
        8qfJ1r70h1lFCEfpcF3WVqLy+X6C4CYvVpfu5Hqpsb1+HqdI4PWBkvXg5GN7C9tfiacnedxtzb9uw
        27IwLkwx5gbEr5T1CYXsbgv8MaHJ8zaMbnXWYoNvFIAi8HIuZPUlJx0Im6FUtu/x/CmJhLh5Kj1u7
        uY0jAGC84TCRhLuy5L3OCiB2MLJ01+H7EfgbJCABLlu2Boe4LXBTZ2C29L2LqcqVEM1Cizy+mgA+U
        8P5xWjNSRTDdC0cYdOCnw7U74higL7DAztsHHHCagXcBC46tfLd4Hrps4KySWHp0mhEIuKFn+0fIw
        L6l5grFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mD3M9-00AwAT-BA; Mon, 09 Aug 2021 11:22:28 +0000
Date:   Mon, 9 Aug 2021 12:22:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot
 time parameter.
Message-ID: <YREP4ZzFMfkC6N/L@casper.infradead.org>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <0d374eed-cc52-a656-b338-1156782bdf7e@suse.cz>
 <F34DBD0A-22DE-4CF2-B784-BBDD80A8E85A@nvidia.com>
 <6ae6cd92-3ff4-7ed3-b337-a4dfe33da1c@google.com>
 <YQ3dn1oR2d0sO5jl@casper.infradead.org>
 <c2a4dd1d-c1ac-876b-4a3-c5ea7555498@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2a4dd1d-c1ac-876b-4a3-c5ea7555498@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2021 at 09:29:29PM -0700, Hugh Dickins wrote:
> On Sat, 7 Aug 2021, Matthew Wilcox wrote:
> > 
> > I am, however, of the opinion that 2MB pages give us so much trouble
> > because they're so very special.  Few people exercise those code paths and
> > it's easy to break them without noticing.  This is partly why I want to
> > do arbitrary-order pages.  If everybody is running with compound pages
> > all the time, we'll see the corner cases often, and people other than
> > Hugh, Kirill and Mike will be able to work on them.
> 
> I don't entirely agree.  I'm all for your use of compound pages in page
> cache, but don't think its problems are representative of the problems
> in aiming for a PMD (or PUD) bar, with the weird page table transitions
> we expect of "THP" there.
> 
> I haven't checked: is your use of compound pages in page cache still
> limited to the HAVE_ARCH_TRANSPARENT_HUGEPAGE architectures?  When
> the others could just as well use compound pages in page cache too.

It is no longer gated by whether TRANSPARENT_HUGEPAGE is enabled or not.
That's a relatively recent change, and I can't say that I've tested it.
I'll give it a try today on a PA-RISC system I've booted recently.

One of the followup pieces of work that I hope somebody other than
myself will undertake is using 64KB PTEs on a 4KB PAGE_SIZE ARM/POWER
machine if the stars align.
