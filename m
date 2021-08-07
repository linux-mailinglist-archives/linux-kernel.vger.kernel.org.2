Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF193E3717
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 23:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhHGVYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 17:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHGVYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 17:24:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B5AC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aA5HS3VKpHetp3gEzc9iEc7bj1aIHq24Bb+xq3Es5LU=; b=ZANN2lpGFk3nRvYarK5XIJERCS
        +NWy2JNCxNY8Xi5VPTrnA35PD3MBwN1VX1/TbeotRkLWlnE9uGyLrEOAms1Uj+oQrn7pFH2b//W9q
        pCO1iHwG8qo4Kh5SstGa3R6JtvKOXW3mZhNjtWW0tRJ3VHP4nvelHc3CxVpboE5tVqK+94MPyo6iz
        ARzIkO/WcEkruk+OoNSXvfG5pdzyj7PFkOg3nOXp4xU+m3lQavDI7OaUtAsAtj0Ml8WlJX00dNnm6
        OKXvflohBcntsuD/TJCGb0oivj3nXcoHSORrezQhpl4j1tJOTk6eWTKmlTibiU4nXfYOdVQWwjxZk
        mu9nrYOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCTmj-009Smd-Tl; Sat, 07 Aug 2021 21:23:17 +0000
Date:   Sat, 7 Aug 2021 22:23:13 +0100
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
Message-ID: <YQ75wVUXPO6yRx7T@casper.infradead.org>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <0d374eed-cc52-a656-b338-1156782bdf7e@suse.cz>
 <F34DBD0A-22DE-4CF2-B784-BBDD80A8E85A@nvidia.com>
 <6ae6cd92-3ff4-7ed3-b337-a4dfe33da1c@google.com>
 <YQ3dn1oR2d0sO5jl@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQ3dn1oR2d0sO5jl@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2021 at 02:10:55AM +0100, Matthew Wilcox wrote:
> This hasn't been helped by the scarce number of 1GB TLB entries in Intel
> CPUs until very recently (and even those are hard to come by today).

Minor correction to this.  I just fixed x86info to work on my Core
i7-1165G7 (Tiger Lake, launched about a year ago) and discovered it has:

 L1 Store Only TLB: 1GB/4MB/2MB/4KB pages, fully associative, 16 entries
 L1 Load Only TLB: 1GB pages, fully associative, 8 entries
 L2 Unified TLB: 1GB/4KB pages, 8-way associative, 1024 entries

My prior laptop (i7-7500U, Kaby Lake, 2016) has only 4x 1GB TLB entries at
the L1 level, and no support for L2 1GB pages.  So this speaks to Intel
finally taking performance of 1GB TLB entries seriously.  Perhaps more
seriously than they need to for a laptop with 16GB of memory!  There are
Xeon-W versions of this CPU, so I imagine that there are versions which
can support 1TB or more memory.

I still think that 1GB pages are too big for anything but specialist
use cases, but those do exist.
