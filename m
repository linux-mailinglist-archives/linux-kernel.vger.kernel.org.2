Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10A63318C9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhCHUmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:42:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231252AbhCHUm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:42:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B45F64F09;
        Mon,  8 Mar 2021 20:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615236148;
        bh=Q+729RpzRWiSDmoA11m7P/RlPUtuXJidEKu+QeR4f/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1yponGFO48b8sMeILoThXvXh9tf+Ef1H/UzKG0/b/7o2Tw5lIezwZ2bJ2+wEX3UmW
         vWfMeRlABfpwkoSlKzsWMqpPj/dFDXrIv2GV+x7cF1oHNKP+peFF1aLwYYyLFGi/Uj
         Z1hV9D/lK3y7sTFlvnWV6ocaAoI4OZqCDyjut2S8=
Date:   Mon, 8 Mar 2021 12:42:27 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hannes@cmpxchg.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Message-Id: <20210308124227.f9b343f006d26ba8d47a959c@linux-foundation.org>
In-Reply-To: <YEXjQsUVCGuPM7Yi@dhcp22.suse.cz>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
        <20210304074053.65527-3-zhouguanghui1@huawei.com>
        <YEIblNv0BMITFzYO@dhcp22.suse.cz>
        <20210305155840.4bb6dea4fb473d9ffbe49c99@linux-foundation.org>
        <YEXjQsUVCGuPM7Yi@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2021 09:41:38 +0100 Michal Hocko <mhocko@suse.com> wrote:

> On Fri 05-03-21 15:58:40, Andrew Morton wrote:
> > On Fri, 5 Mar 2021 12:52:52 +0100 Michal Hocko <mhocko@suse.com> wrote:
> > 
> > > On Thu 04-03-21 07:40:53, Zhou Guanghui wrote:
> > > > As described in the split_page function comment, for the non-compound
> > > > high order page, the sub-pages must be freed individually. If the
> > > > memcg of the fisrt page is valid, the tail pages cannot be uncharged
> > > > when be freed.
> > > > 
> > > > For example, when alloc_pages_exact is used to allocate 1MB continuous
> > > > physical memory, 2MB is charged(kmemcg is enabled and __GFP_ACCOUNT is
> > > > set). When make_alloc_exact free the unused 1MB and free_pages_exact
> > > > free the applied 1MB, actually, only 4KB(one page) is uncharged.
> > > > 
> > > > Therefore, the memcg of the tail page needs to be set when split page.
> > > > 
> > > 
> > > As already mentioned there are at least two explicit users of
> > > __GFP_ACCOUNT with alloc_exact_pages added recently. It would be good to
> > > mention that explicitly and maybe even mention 7efe8ef274024 resp.
> > > c419621873713 so that it is clear this is not just a theoretical issue.
> > 
> > I added
> > 
> > : Michel:
> > : 
> > : There are at least two explicit users of __GFP_ACCOUNT with
> > : alloc_exact_pages added recently.  See 7efe8ef274024 ("KVM: arm64:
> > : Allocate stage-2 pgd pages with GFP_KERNEL_ACCOUNT") and c419621873713
> > : ("KVM: s390: Add memcg accounting to KVM allocations"), so this is not
> > : just a theoretical issue.
> > 
> > And should we cc:stable on this one?
> 
> Somebody more familiar with iommu dma allocation layer should have a
> look as well (__iommu_dma_alloc_pages) so that we know whether there are
> kernels outside of the above two ones mentioned above that need a fix.
> But in general this sounds like a good fit for the stable tree.

OK.  I reversed the order of these two patches so we don't need to
burden -stable with a cosmetic rename.

