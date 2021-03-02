Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F0E32A9D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581443AbhCBSvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:51:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:42628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1449106AbhCBQE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:04:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614700270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pdDWsFQcF7rXCFOv6YgPKx+U/DSX9HDlai1p+dLPtQc=;
        b=CUKK1D189WviMnFB36MEnc7SszarLzXWujqx5F/zbGbrjbAMHbx+ODykvZMkOihPe4jgPF
        tNbDp+jlZb+Htf35AEd5RHN2RToqnRoSS4Kvg7KSFayMPDXjmLaI8DiP3AXqO4ZMPHJbD8
        mPFJAXJztUY614pfLqEgcN6XgNcqrzE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 68E73B02E;
        Tue,  2 Mar 2021 15:51:09 +0000 (UTC)
Date:   Tue, 2 Mar 2021 16:51:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        guohanjun@huawei.com, dingtianhong@huawei.com,
        chenweilong@huawei.com, rui.xiang@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] mm/memcg: set memcg when split pages
Message-ID: <YD5e2k0ecvGt8sqR@dhcp22.suse.cz>
References: <20210302013451.118701-1-zhouguanghui1@huawei.com>
 <YD4CciUX0/eXFLM0@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD4CciUX0/eXFLM0@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-03-21 10:17:03, Michal Hocko wrote:
> [Cc Johannes for awareness and fixup Nick's email]
> 
> On Tue 02-03-21 01:34:51, Zhou Guanghui wrote:
> > When split page, the memory cgroup info recorded in first page is
> > not copied to tail pages. In this case, when the tail pages are
> > freed, the uncharge operation is not performed. As a result, the
> > usage of this memcg keeps increasing, and the OOM may occur.
> > 
> > So, the copying of first page's memory cgroup info to tail pages
> > is needed when split page.
> 
> I was not aware that alloc_pages_exact is used for accounted allocations
> but git grep told me otherwise so this is not a theoretical one. Both
> users (arm64 and s390 kvm) are quite recent AFAICS. split_page is also
> used in dma allocator but I got lost in indirection so I have no idea
> whether there are any users there.
> 
> The page itself looks reasonable to me.
> 
> > Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Minor nit
> 
> > ---
> >  include/linux/memcontrol.h | 10 ++++++++++
> >  mm/page_alloc.c            |  4 +++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index e6dc793d587d..c7e2b4421dc1 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -867,6 +867,12 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
> >  extern bool cgroup_memory_noswap;
> >  #endif
> >  
> > +static inline void copy_page_memcg(struct page *dst, struct page *src)
> > +{
> > +	if (src->memcg_data)
> > +		dst->memcg_data = src->memcg_data;
> 
> I would just drop the test. The struct page is a single cache line which
> is dirty by the reference count so another store will unlikely be
> noticeable even when NULL is stored here and you safe a conditional.

Disregard this. As Zi Yan mentioned in other reply, we need to keep the
check and take a css reference along with transfering the memcg.

-- 
Michal Hocko
SUSE Labs
