Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B338942BF69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhJMMFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhJMMFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:05:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01027C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=02qcczvmiTPBk4ptDZ1neiPQwv8s8RqHEA5AhOmIAco=; b=HA3yRevrF7fYlWESRxE76oYSxF
        4/lVeYUpyh7cDbMv1BrD9HmogKARDoPyuvC9scK2sApMEVu8jZLOr+AZ3PJldRoS2WFnesRw/7do7
        SPZP79RwmvWse/QKhq+wng1vckyx57ljCD72JylKSBwqJge8e14HPxBW30K6nMx/8Dgd41harCx5P
        7oxqcCpn58YCkpgVEpKZoo9qdndo8F+LnY34KzWjOAyt/cnH3I8h3reoPOwxg4UPWzHNsYKjUr9DG
        D22qiqDW2NdrlVHt/RDm7holMhIrK64Agu7grYDKkiUddNmuKKkDFdY0qDfHd6kQdER8ybHG3t5yC
        5TUo6WCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1macx2-007OqE-Qg; Wed, 13 Oct 2021 12:02:10 +0000
Date:   Wed, 13 Oct 2021 13:01:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?6rmA7ISx7ZuI?= <sfoon.kim@samsung.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hillf Danton <hdanton@sina.com>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] mm/thp: decrease nr_thps in file's mapping on THP split
Message-ID: <YWbKpH3vroAF7yw4@casper.infradead.org>
References: <CGME20211012120247eucas1p1f66926c6fc334216cdbdd39285601aa8@eucas1p1.samsung.com>
 <20211012120237.2600-1-m.szyprowski@samsung.com>
 <YWWC9+93pHQ77Ir3@casper.infradead.org>
 <5eafae55-f207-38a8-d6d3-8bda74ae9c60@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eafae55-f207-38a8-d6d3-8bda74ae9c60@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 12:47:03PM +0200, Marek Szyprowski wrote:
> On 12.10.2021 14:43, Matthew Wilcox wrote:
> > On Tue, Oct 12, 2021 at 02:02:37PM +0200, Marek Szyprowski wrote:
> >> Decrease nr_thps counter in file's mapping to ensure that the page cache
> >> won't be dropped excessively on file write access if page has been
> >> already splitted.
> >>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Fixes: 09d91cda0e82 ("mm,thp: avoid writes to file with THP in pagecache")
> >> Fixes: 06d3eff62d9d ("mm/thp: fix node page state in split_huge_page_to_list()")
> >> ---
> >> I've analyzed the code a few times but either I missed something or the
> >> nr_thps counter is not decremented during the THP split on non-shmem file
> >> pages.
> > This looks OK to me, but have you tested it?  If so, what workload did
> > you use?  The way you wrote this changelog makes it sound like you only
> > read the code and there have been rather too many bugs introduced recently
> > that way :-(
> 
> Well, indeed I've found it while reading the code. However I've just 
> tried a test scenario, where one runs a big binary, kernel remaps it 
> with THPs, then one forces THP split with 
> /sys/kernel/debug/split_huge_pages. During any further open of that 
> binary with O_RDWR or O_WRITEONLY kernel drops page cache for it, 
> because of non-zero thps counter.

... and with this patch, it no longer happens?  Good enough for me!

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
