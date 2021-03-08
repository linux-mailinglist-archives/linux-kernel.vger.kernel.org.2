Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1D033099B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhCHImD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:42:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:51258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232274AbhCHIlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:41:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615192901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQsvUx1bc3HFAYXXFvyw7hGdS+2IRJnswNDb2Qjo34s=;
        b=PLdDqTyvNh44Ko31OLNkhQ4lo2iW9kZb39drwp7Ug4ZL5qvM0LFz9RcF6zAonW5aAxx5Ok
        iBhillVC6cvC7rgKI8x9y/+HV379hZA5TU7oXWi8SoPY4mPBzOECsszlW87YDvAkfhRAs8
        h+Tnu48JBm7b+qsoVBrrvVXYgCNEENQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02E72AC0C;
        Mon,  8 Mar 2021 08:41:41 +0000 (UTC)
Date:   Mon, 8 Mar 2021 09:41:38 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hannes@cmpxchg.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Message-ID: <YEXjQsUVCGuPM7Yi@dhcp22.suse.cz>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-3-zhouguanghui1@huawei.com>
 <YEIblNv0BMITFzYO@dhcp22.suse.cz>
 <20210305155840.4bb6dea4fb473d9ffbe49c99@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305155840.4bb6dea4fb473d9ffbe49c99@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 05-03-21 15:58:40, Andrew Morton wrote:
> On Fri, 5 Mar 2021 12:52:52 +0100 Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Thu 04-03-21 07:40:53, Zhou Guanghui wrote:
> > > As described in the split_page function comment, for the non-compound
> > > high order page, the sub-pages must be freed individually. If the
> > > memcg of the fisrt page is valid, the tail pages cannot be uncharged
> > > when be freed.
> > > 
> > > For example, when alloc_pages_exact is used to allocate 1MB continuous
> > > physical memory, 2MB is charged(kmemcg is enabled and __GFP_ACCOUNT is
> > > set). When make_alloc_exact free the unused 1MB and free_pages_exact
> > > free the applied 1MB, actually, only 4KB(one page) is uncharged.
> > > 
> > > Therefore, the memcg of the tail page needs to be set when split page.
> > > 
> > 
> > As already mentioned there are at least two explicit users of
> > __GFP_ACCOUNT with alloc_exact_pages added recently. It would be good to
> > mention that explicitly and maybe even mention 7efe8ef274024 resp.
> > c419621873713 so that it is clear this is not just a theoretical issue.
> 
> I added
> 
> : Michel:
> : 
> : There are at least two explicit users of __GFP_ACCOUNT with
> : alloc_exact_pages added recently.  See 7efe8ef274024 ("KVM: arm64:
> : Allocate stage-2 pgd pages with GFP_KERNEL_ACCOUNT") and c419621873713
> : ("KVM: s390: Add memcg accounting to KVM allocations"), so this is not
> : just a theoretical issue.
> 
> And should we cc:stable on this one?

Somebody more familiar with iommu dma allocation layer should have a
look as well (__iommu_dma_alloc_pages) so that we know whether there are
kernels outside of the above two ones mentioned above that need a fix.
But in general this sounds like a good fit for the stable tree.

-- 
Michal Hocko
SUSE Labs
