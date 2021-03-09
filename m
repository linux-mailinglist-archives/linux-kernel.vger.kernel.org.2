Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27D4331B73
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhCIAK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:10:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhCIAKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:10:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F2DA61554;
        Tue,  9 Mar 2021 00:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615248610;
        bh=G+XxYbDAZEkn2FIZ+ZBvU40zQIFN6Avf7NxiFSYEp+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cPGCohWHaDmvGP+xRZcMObUGnPY8ZJoLv2uLCDc6nKdz6svpz8QkZJQ3dCWFZ6u3m
         KGe9rrv+60owkCDCYKYR20N18wfksSbR2QEfIIcSCEHP0LFIi8O23dBhdeLtuHWQqy
         9Fe2cX7n5o2MdY3XBYVkwW2cRKxJotHsPvXaIzUY=
Date:   Mon, 8 Mar 2021 16:10:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hannes@cmpxchg.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Message-Id: <20210308161008.a5d17c56551bf59b778c1d75@linux-foundation.org>
In-Reply-To: <20210308204731.GE3479805@casper.infradead.org>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
        <20210304074053.65527-3-zhouguanghui1@huawei.com>
        <YEIblNv0BMITFzYO@dhcp22.suse.cz>
        <20210305155840.4bb6dea4fb473d9ffbe49c99@linux-foundation.org>
        <YEXjQsUVCGuPM7Yi@dhcp22.suse.cz>
        <20210308124227.f9b343f006d26ba8d47a959c@linux-foundation.org>
        <20210308204731.GE3479805@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2021 20:47:31 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Mar 08, 2021 at 12:42:27PM -0800, Andrew Morton wrote:
> > On Mon, 8 Mar 2021 09:41:38 +0100 Michal Hocko <mhocko@suse.com> wrote:
> > 
> > > On Fri 05-03-21 15:58:40, Andrew Morton wrote:
> > > > On Fri, 5 Mar 2021 12:52:52 +0100 Michal Hocko <mhocko@suse.com> wrote:
> > > > 
> > > > > On Thu 04-03-21 07:40:53, Zhou Guanghui wrote:
> > > > > > As described in the split_page function comment, for the non-compound
> > > > > > high order page, the sub-pages must be freed individually. If the
> > > > > > memcg of the fisrt page is valid, the tail pages cannot be uncharged
> > > > > > when be freed.
> > > > > > 
> > > > > > For example, when alloc_pages_exact is used to allocate 1MB continuous
> > > > > > physical memory, 2MB is charged(kmemcg is enabled and __GFP_ACCOUNT is
> > > > > > set). When make_alloc_exact free the unused 1MB and free_pages_exact
> > > > > > free the applied 1MB, actually, only 4KB(one page) is uncharged.
> > > > > > 
> > > > > > Therefore, the memcg of the tail page needs to be set when split page.
> > > > > > 
> > > > > 
> > > > > As already mentioned there are at least two explicit users of
> > > > > __GFP_ACCOUNT with alloc_exact_pages added recently. It would be good to
> > > > > mention that explicitly and maybe even mention 7efe8ef274024 resp.
> > > > > c419621873713 so that it is clear this is not just a theoretical issue.
> > > > 
> > > > I added
> > > > 
> > > > : Michel:
> > > > : 
> > > > : There are at least two explicit users of __GFP_ACCOUNT with
> > > > : alloc_exact_pages added recently.  See 7efe8ef274024 ("KVM: arm64:
> > > > : Allocate stage-2 pgd pages with GFP_KERNEL_ACCOUNT") and c419621873713
> > > > : ("KVM: s390: Add memcg accounting to KVM allocations"), so this is not
> > > > : just a theoretical issue.
> > > > 
> > > > And should we cc:stable on this one?
> > > 
> > > Somebody more familiar with iommu dma allocation layer should have a
> > > look as well (__iommu_dma_alloc_pages) so that we know whether there are
> > > kernels outside of the above two ones mentioned above that need a fix.
> > > But in general this sounds like a good fit for the stable tree.
> > 
> > OK.  I reversed the order of these two patches so we don't need to
> > burden -stable with a cosmetic rename.
> 
> Eek, no.
> 
> The alloc_pages_exact() is done to pages that _aren't_ compound.
> So you have to pass the number of pages to the memcg split function,
> because a non-compound page doesn't know the size of its allocation.

Ah, OK, the patch title fooled me.

It should have been a three-patch series, really

1: add nr_pages arg to mem_cgroup_split_huge_fixup()
2: call mem_cgroup_split_huge_fixup() when splitting
3: rename mem_cgroup_split_huge_fixup() to split_page_memcg()

That way, the third cosmetic patch could be deferred so we don't feed
the cosmetic renaming into -stable.

But whatever, the rename isn't a big deal so I'll go with the 2-patch
series as sent for -stable.
