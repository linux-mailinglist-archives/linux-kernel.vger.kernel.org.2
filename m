Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC03318D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCHUsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCHUro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:47:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFEEC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 12:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S8kLJfmqAJcSNKPP/uGFO3wlaQE7WCfmpBxfBgbGWzs=; b=sgEbgjhhl1XKdQuxnjeM+ztcDv
        xXYbiSAGxXCc4V8wlrxciQiXqReDvbhH1OkFtp11pdyAjPCzzOwUbS2PObqZTLHfXHVilL9qJhcaJ
        m6dXlBPUl7PCtcBK9djCtFn2O5WP/Y+3wgj6FmutLfd1yLB/RnTAW3LSPHsk2gHP9FKKTVySaglF7
        mUvlD24kJqHuUUN1vRF/O2X9Hkre977avXNRxJb1eeVW1RwJEuut4G9LbzB+Yf27VFO/QsMapVXQU
        Vvl541QKW6OK1DRZ93BPHB51Lq7lyqhbeCDhzgmj6TdeWi7kkIbqxyX2rTPTDCj/U0pavLGT7NJVI
        OMktH/uw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJMmp-00GEge-Rf; Mon, 08 Mar 2021 20:47:34 +0000
Date:   Mon, 8 Mar 2021 20:47:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hannes@cmpxchg.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Message-ID: <20210308204731.GE3479805@casper.infradead.org>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-3-zhouguanghui1@huawei.com>
 <YEIblNv0BMITFzYO@dhcp22.suse.cz>
 <20210305155840.4bb6dea4fb473d9ffbe49c99@linux-foundation.org>
 <YEXjQsUVCGuPM7Yi@dhcp22.suse.cz>
 <20210308124227.f9b343f006d26ba8d47a959c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308124227.f9b343f006d26ba8d47a959c@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 12:42:27PM -0800, Andrew Morton wrote:
> On Mon, 8 Mar 2021 09:41:38 +0100 Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Fri 05-03-21 15:58:40, Andrew Morton wrote:
> > > On Fri, 5 Mar 2021 12:52:52 +0100 Michal Hocko <mhocko@suse.com> wrote:
> > > 
> > > > On Thu 04-03-21 07:40:53, Zhou Guanghui wrote:
> > > > > As described in the split_page function comment, for the non-compound
> > > > > high order page, the sub-pages must be freed individually. If the
> > > > > memcg of the fisrt page is valid, the tail pages cannot be uncharged
> > > > > when be freed.
> > > > > 
> > > > > For example, when alloc_pages_exact is used to allocate 1MB continuous
> > > > > physical memory, 2MB is charged(kmemcg is enabled and __GFP_ACCOUNT is
> > > > > set). When make_alloc_exact free the unused 1MB and free_pages_exact
> > > > > free the applied 1MB, actually, only 4KB(one page) is uncharged.
> > > > > 
> > > > > Therefore, the memcg of the tail page needs to be set when split page.
> > > > > 
> > > > 
> > > > As already mentioned there are at least two explicit users of
> > > > __GFP_ACCOUNT with alloc_exact_pages added recently. It would be good to
> > > > mention that explicitly and maybe even mention 7efe8ef274024 resp.
> > > > c419621873713 so that it is clear this is not just a theoretical issue.
> > > 
> > > I added
> > > 
> > > : Michel:
> > > : 
> > > : There are at least two explicit users of __GFP_ACCOUNT with
> > > : alloc_exact_pages added recently.  See 7efe8ef274024 ("KVM: arm64:
> > > : Allocate stage-2 pgd pages with GFP_KERNEL_ACCOUNT") and c419621873713
> > > : ("KVM: s390: Add memcg accounting to KVM allocations"), so this is not
> > > : just a theoretical issue.
> > > 
> > > And should we cc:stable on this one?
> > 
> > Somebody more familiar with iommu dma allocation layer should have a
> > look as well (__iommu_dma_alloc_pages) so that we know whether there are
> > kernels outside of the above two ones mentioned above that need a fix.
> > But in general this sounds like a good fit for the stable tree.
> 
> OK.  I reversed the order of these two patches so we don't need to
> burden -stable with a cosmetic rename.

Eek, no.

The alloc_pages_exact() is done to pages that _aren't_ compound.
So you have to pass the number of pages to the memcg split function,
because a non-compound page doesn't know the size of its allocation.
