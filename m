Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177E33FA9B9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 09:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhH2HHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 03:07:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234753AbhH2HHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 03:07:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C1FB60F39;
        Sun, 29 Aug 2021 07:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630220777;
        bh=/n4BHEfwRpAkQl+6zQT6qVT0qSub4et7m03Zgo/XEPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EK1gvSJl2SZyOTieaHwz8h6/K/9AimVgahG7x7Na6f2EmGseoRAYhFnD2I5Wk88mY
         vtw76Km759OuxFL4PaH4rm1Na3bvOhwUTJf4o6gY4BGmcJZAwRHUBMXne8y0Zlwrs2
         QWsG6/UABUy2XIw2tAqEcwe2Kn/e0oOxfB4gA83FQ1xfuTy6eMLNN9TpXmW4kGEu/2
         WnFg/z7uZw8sR1a+ZHcxXa8vyV05GBVBk3wsKUrF+LHV4eJPY24I7c8r7vJG1CwemG
         RBLFJX1sihXBRR8AecUcgjX++DyavEPQy9+RiIeu51ZGAOnrVMm6ZLuQnE6iM5RSZL
         OGfNNfU3f3/bw==
Date:   Sun, 29 Aug 2021 10:06:10 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [RFC PATCH 0/4] mm/page_alloc: cache pte-mapped allocations
Message-ID: <YSsx4qFlvQEwI1kz@kernel.org>
References: <20210823132513.15836-1-rppt@kernel.org>
 <9d61b4f7-82d0-5caf-88fa-ff1b78704eea@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d61b4f7-82d0-5caf-88fa-ff1b78704eea@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 06:09:44PM +0200, Vlastimil Babka wrote:
> On 8/23/21 15:25, Mike Rapoport wrote:
> >
> > The idea is to use a gfp flag that will instruct the page allocator to use
> > the cache of pte-mapped pages because the caller needs to remove them from
> > the direct map or change their attributes. 
> 
> Like Dave, I don't like much the idea of a new GFP flag that all page
> allocations now have to check, and freeing that has to check a new pageblock
> flag, although I can see some of the benefits this brings...
> 
> > When the cache is empty there is an attempt to refill it using PMD-sized
> > allocation so that once the direct map is split we'll be able to use all 4K
> > pages made available by the split. 
> > 
> > If the high order allocation fails, we fall back to order-0 and mark the
> 
> Yeah, this fallback is where we benefit from the page allocator implementation,
> because of the page freeing hook that will recognize page from such fallback
> blocks and free them to the cache. But does that prevent so much fragmentation
> to be worth it? I'd see first if we can do without it.

I've run 'stress-ng --mmapfork 20 -t 30' in a VM with 4G or RAM and then
checked splits reported in /proc/vmstat to get some ideas what may be the
benefit.

I've compared Rick's implementation of grouped alloc (rebased on v5.14-rc6)
with this set. For that simple test there were ~30% less splits.

                      | grouped alloc | pte-mapped
----------------------+---------------+------------
PMD splits after boot |       16      |     14
PMD splits after test |       49      |     34

(there were no PUD splits at all).

I think the closer we have such cache to the buddy, the better would be
memory utilization. The downside is that it will be harder to reclaim 2M
blocks than with separate caches because at page allocator level we don't
have enough information to make the pages allocated from the cache movable.

-- 
Sincerely yours,
Mike.
