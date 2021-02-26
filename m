Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A2D3268CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBZUco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhBZU2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:28:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F662C061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wQi4bcARQ7gLU2OqClFICiAmMPFf5VMCacL0HPG2n1w=; b=Q2m92VFS6HI2HJw14kJKQAgBgB
        S0W5w58KIgzHfDVOXHRaxEIvKz8Nz+AJngwNXbytYupLecd/Den/y3KB84XYalFHxXI5dkjvdi9gn
        Q7exwHJ+sCb3TBVgq5CiLKCuFUij8TzEBRkx9n1rmI9k/EPQmJvxAQp4REN2FoVLN+bfzYlVUVzuO
        GqSLj6uFPJ6wrLyYa/TXQCnHXk+OCChzAjOkER9lpOF1OG+smrdgPokgI2y8X7Rwh12p3AfVTjsSt
        UDfhrt4UC5Vs6SZyLSppqmFUflkubv6qFdp1IQLcWxMoCrkUkPIPAVybpio9tpLIBE8qu0GUT0t4B
        3+lyXKrw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFji6-00CTN4-GU; Fri, 26 Feb 2021 20:27:39 +0000
Date:   Fri, 26 Feb 2021 20:27:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        vbabka@suse.cz, guro@fb.com, hannes@cmpxchg.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH v2 3/3] mm: use PF_ONLY_HEAD for PG_active and
 PG_unevictable
Message-ID: <20210226202738.GG2723601@casper.infradead.org>
References: <20210224084807.2179942-1-yuzhao@google.com>
 <20210226091718.2927291-1-yuzhao@google.com>
 <20210226091718.2927291-4-yuzhao@google.com>
 <20210226121314.GB2723601@casper.infradead.org>
 <YDlQ1VLtGsTbwp4z@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDlQ1VLtGsTbwp4z@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:49:41PM -0700, Yu Zhao wrote:
> On Fri, Feb 26, 2021 at 12:13:14PM +0000, Matthew Wilcox wrote:
> > On Fri, Feb 26, 2021 at 02:17:18AM -0700, Yu Zhao wrote:
> > > All places but one test, set or clear PG_active and PG_unevictable on
> > > small or head pages. Use compound_head() explicitly for that singleton
> > > so the rest can rid of redundant compound_head().
> > 
> > How do you know it's only one place?  I really wish you'd work with me
> > on folios.  They make the compiler prove that it's not a tail page.
> 
> I hasn't been following the effort closely, so I'm rereading the very
> first discussion "Are THPs the right model for the pagecache?" and
> then I need to rewatch the recorded Zoom meeting. As I said I'm on
> board with the idea, but I can't create a roadmap based on my current
> rough understanding, unless you prefer me to just randomly throw some
> reviewed-bys at your patches in the next few days. (Our long-term plan
> for folios is to support arbitrary anon page sizes because anon memory
> is more than 90% of total user memory on Android, Chrome OS and in our
> data centers.)
> 
> That said, if you have something ready to test, we could do it for you
> in our runtime environments immediately.

I don't have anything ready to test for anonymous memory; indeed I have no
plans to work on anonymous memory myself.  My focus is on the page cache.

But, once we get the folio _concept_ into the kernel (ie a struct page
which is definitely not a tail page), it can be used more widely than
the page cache, and independently from anything I'm working on.  The
biggest risk is that we end up duplicating work ...
