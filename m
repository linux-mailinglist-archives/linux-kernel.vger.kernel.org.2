Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB432BB93
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446571AbhCCMiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:38:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:59770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1839263AbhCCIEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:04:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614757598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OOQ383+Q5BRADLNbFs/GIzJCC2iBj+msFFS1hOt4mJc=;
        b=OJloQZPJ/ac4oM2t6bl1Eg/xrZTWfP7OMnsoCQzGEuCIgLJgxH0sY68EVFm3+UWjyhq3VP
        4oXsdSQTzoYK+E+8D/NLlf5WLz44cggPeiBGvbcwJws1q34tno44zgjdLBMMERGzku9Mh7
        yNIN5axBOj2jWiqjki26ctg3QPmyZ68=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65226AE88;
        Wed,  3 Mar 2021 07:46:38 +0000 (UTC)
Date:   Wed, 3 Mar 2021 08:46:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        guohanjun@huawei.com, dingtianhong@huawei.com,
        chenweilong@huawei.com, rui.xiang@huawei.com,
        Nicholas Piggin <npiggin@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm/memcg: set memcg when split pages
Message-ID: <YD8+2P6J9+NhLZoX@dhcp22.suse.cz>
References: <20210302013451.118701-1-zhouguanghui1@huawei.com>
 <YD4CciUX0/eXFLM0@dhcp22.suse.cz>
 <alpine.LSU.2.11.2103021157160.8450@eggly.anvils>
 <YD7Ch/8QebzmneCR@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD7Ch/8QebzmneCR@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-03-21 17:56:07, Johannes Weiner wrote:
> On Tue, Mar 02, 2021 at 12:24:41PM -0800, Hugh Dickins wrote:
> > On Tue, 2 Mar 2021, Michal Hocko wrote:
> > > [Cc Johannes for awareness and fixup Nick's email]
> > > 
> > > On Tue 02-03-21 01:34:51, Zhou Guanghui wrote:
> > > > When split page, the memory cgroup info recorded in first page is
> > > > not copied to tail pages. In this case, when the tail pages are
> > > > freed, the uncharge operation is not performed. As a result, the
> > > > usage of this memcg keeps increasing, and the OOM may occur.
> > > > 
> > > > So, the copying of first page's memory cgroup info to tail pages
> > > > is needed when split page.
> > > 
> > > I was not aware that alloc_pages_exact is used for accounted allocations
> > > but git grep told me otherwise so this is not a theoretical one. Both
> > > users (arm64 and s390 kvm) are quite recent AFAICS. split_page is also
> > > used in dma allocator but I got lost in indirection so I have no idea
> > > whether there are any users there.
> > 
> > Yes, it's a bit worrying that such a low-level thing as split_page()
> > can now get caught up in memcg accounting, but I suppose that's okay.
> > 
> > I feel rather strongly that whichever way it is done, THP splitting
> > and split_page() should use the same interface to memcg.
> > 
> > And a look at mem_cgroup_split_huge_fixup() suggests that nowadays
> > there need to be css_get()s too - or better, a css_get_many().
> > 
> > Its #ifdef CONFIG_TRANSPARENT_HUGEPAGE should be removed, rename
> > it mem_cgroup_split_page_fixup(), and take order from caller.
> 
> +1
> 
> There is already a split_page_owner() in both these places as well
> which does a similar thing. Mabye we can match that by calling it
> split_page_memcg() and having it take a nr of pages?

Sounds good to me.

-- 
Michal Hocko
SUSE Labs
