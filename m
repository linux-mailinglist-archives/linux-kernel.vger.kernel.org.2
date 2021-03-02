Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B9232ADE5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360107AbhCBWQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350794AbhCBUZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:25:39 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24D8C061793
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 12:24:54 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id w3so1571464oti.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 12:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rMkgjXu4HqK6AGDgPAImtrd+WKS0Hl1peOdH+4k/40k=;
        b=MKNfDFW9y7HE6vqY/Kti99VHmPpEZu6BfTtHm9fp4+lu/79NT4UgN7yjAZgmGDJA+P
         3QS/eB1EXyO+Vvsq2qjzzzsJCPWyoefukxqLEy4hvqNhdOdk1CIjjGZAb12x/0WiOX6y
         sBohPMz8+S/mnIX1ExsIohkId4JO+PDvVKRLh2JjJA77+PoTQUC6eru+yu+F80WHxf6Z
         W8BX2CZ9ULy7OIJTNGmD2lw2ezfuGn4lZNcnURDHv2yoLDHGzV6R2YZy3jqsP+VnczzI
         idMW9278VPnyt+RJPWdr10w1NNmgdrzEMsUasvvsq+xFWjh3g7eqmQL41qjt4BozM0jB
         5dxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rMkgjXu4HqK6AGDgPAImtrd+WKS0Hl1peOdH+4k/40k=;
        b=R3MtkSCaSasLVahPPtJs8AEMR8ITlVgz1NwFHz9qrP5z9VisghGZx2hfRh/4z3n+Pn
         s/i24Du0p0030gfduy/UY8gYpLXi7XsSGdFdl4xKcfeu0qfdAOGoZu9AEikOoBfiywbR
         pZ0tOQdqAuEFpDuTQeFGNxgF9s8sY2Hdqz+bC4JURtAykdVbRrsQgsIDepwmWIQIXBVz
         hzf1XYbTxHMIVlrhjFPADcq0v8WTc5GzIpTocEl3J6djIcWUcRzPZjwEoAnVbiXEtPHO
         2PO8sUFMoWHK7+voApSyUCaxe7qx+hAQCaDGtFSehZVBUSZwdSLlZovd/S9V7yroMQOf
         FyqA==
X-Gm-Message-State: AOAM530iyyxLf0wd550knnNLH1ZRFRGoWetaJbh0A2y4eXJyU3ux3WXL
        A5u2XQ5QylWnIzzNqH7q6ITieuw+XwnCcw==
X-Google-Smtp-Source: ABdhPJzyHceXXb047BveFKynelFazGRdbf+UR2pJ1+1z2T8M5lo5k0X69WsSl5cfmMlh1X7clmabKQ==
X-Received: by 2002:a9d:701e:: with SMTP id k30mr19258139otj.157.1614716693963;
        Tue, 02 Mar 2021 12:24:53 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m34sm2754046otc.25.2021.03.02.12.24.52
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 02 Mar 2021 12:24:53 -0800 (PST)
Date:   Tue, 2 Mar 2021 12:24:41 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com, Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/memcg: set memcg when split pages
In-Reply-To: <YD4CciUX0/eXFLM0@dhcp22.suse.cz>
Message-ID: <alpine.LSU.2.11.2103021157160.8450@eggly.anvils>
References: <20210302013451.118701-1-zhouguanghui1@huawei.com> <YD4CciUX0/eXFLM0@dhcp22.suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021, Michal Hocko wrote:
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

Yes, it's a bit worrying that such a low-level thing as split_page()
can now get caught up in memcg accounting, but I suppose that's okay.

I feel rather strongly that whichever way it is done, THP splitting
and split_page() should use the same interface to memcg.

And a look at mem_cgroup_split_huge_fixup() suggests that nowadays
there need to be css_get()s too - or better, a css_get_many().

Its #ifdef CONFIG_TRANSPARENT_HUGEPAGE should be removed, rename
it mem_cgroup_split_page_fixup(), and take order from caller.

Though I've never much liked that separate pass: would it be
better page by page, like this copy_page_memcg() does?  Though
mem_cgroup_disabled() and css_getting make that less appealing.

Hugh

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
> 
> > +}
> > +
> >  struct mem_cgroup *lock_page_memcg(struct page *page);
> >  void __unlock_page_memcg(struct mem_cgroup *memcg);
> >  void unlock_page_memcg(struct page *page);
> > @@ -1291,6 +1297,10 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
> >  {
> >  }
> >  
> > +static inline void copy_page_memcg(struct page *dst, struct page *src)
> > +{
> > +}
> > +
> >  static inline struct mem_cgroup *lock_page_memcg(struct page *page)
> >  {
> >  	return NULL;
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3e4b29ee2b1e..ee0a63dc1c9b 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3307,8 +3307,10 @@ void split_page(struct page *page, unsigned int order)
> >  	VM_BUG_ON_PAGE(PageCompound(page), page);
> >  	VM_BUG_ON_PAGE(!page_count(page), page);
> >  
> > -	for (i = 1; i < (1 << order); i++)
> > +	for (i = 1; i < (1 << order); i++) {
> >  		set_page_refcounted(page + i);
> > +		copy_page_memcg(page + i, page);
> > +	}
> >  	split_page_owner(page, 1 << order);
> >  }
> >  EXPORT_SYMBOL_GPL(split_page);
> > -- 
> > 2.25.0
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
