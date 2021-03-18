Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C7434086E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhCRPHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhCRPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:07:26 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DFBC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:07:26 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id l4so2317427qkl.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fbzGRMSg35Yk7urbJWTBF/LFrWpG+uSfyGbnx+dj3t0=;
        b=YnGk2Gkg4F4VvEzaISXtVkjvk97Qrijt2BYdZXCmtZvDgopwnUvrdbiEgmzSjdca8i
         LOGqc2jFPYkk7w8JqSaQu/0tXg3/dujRJQ8C7/rvrC/ExOY5oGEpviDlgvcV9a+6Eh/1
         rG/y/UdySEHq6xwg/3Jmbd5cD2nhGiX+uOXSXIs8pznMBuUis3eK74kW3rEj4ZPpHRlK
         zz2zgQabP+miGKRY9FUEwlGuaE2jZ4An87vNYT3gU+AL2b3TAa3IYzp+GuvTPAm/Fg+n
         +jcaLh+MuyUVsEKF3OzcAk7WAaxHTD4XwhVDxS212TySZhAUBVZIpXEz5b9FDTPinCiO
         dnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fbzGRMSg35Yk7urbJWTBF/LFrWpG+uSfyGbnx+dj3t0=;
        b=VVu5Mp5NkgX77iXvF+gCzMQ2aObF8jBXZBcdMyLS0hwKOjkq54c0VDfHclFWXTWgZ/
         FpcMphB6fMEgPis4jcroeXgDx7w8zyIWnr/Z9KcbW2vHGHiJ51RcVSuoVfON9gJxiaBR
         p4dGeu2G8EY9COduz4sr6zQYFTB99yjKWjgg5796TchjUnxOJjqtbJLE/6qtDpSloHe9
         QFg541QijD6Gk5RjMbwVKc/vEI1/uRRDyBCEeI1E7XDFELjTcKIVc+WQpS8jlez8cZ+S
         b3SVr6Y+uYD7ckeZHPTDadcdquvpw+vztkWyNMvIwAWcn/F7B42uqlwqWfuKVHOl965q
         Afeg==
X-Gm-Message-State: AOAM530hO/X6luXPm8txlr3todLiFh1JjBrdSpl7EC1FKwYyJp9T3Mc5
        j1A+5FmclHhwAr4kqmQiF5zQgQ==
X-Google-Smtp-Source: ABdhPJyIQeHdZA/rfnRB/C17jU6bZVTKobbbpa/iz+WUIeYllggLUQMyN9HqrYM3KdWSrlzD4zDhFA==
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr4514571qkx.501.1616080045272;
        Thu, 18 Mar 2021 08:07:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e46c])
        by smtp.gmail.com with ESMTPSA id t2sm1612214qtd.13.2021.03.18.08.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:07:24 -0700 (PDT)
Date:   Thu, 18 Mar 2021 11:07:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        npiggin@gmail.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
        guohanjun@huawei.com, dingtianhong@huawei.com,
        chenweilong@huawei.com, rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Message-ID: <YFNsq2OcWKJV7Cnv@cmpxchg.org>
References: <20210304074053.65527-3-zhouguanghui1@huawei.com>
 <20210308210225.GF3479805@casper.infradead.org>
 <YEc5iI+ZP7dWr2fC@dhcp22.suse.cz>
 <20210309123255.GI3479805@casper.infradead.org>
 <YEdyJ+ZK2l7tu0rw@dhcp22.suse.cz>
 <YEnWrg2XFwZ2PR0N@dhcp22.suse.cz>
 <YEo1gz6wuYl1Fuqt@cmpxchg.org>
 <YEpEzZ1CdXvc5JMt@dhcp22.suse.cz>
 <alpine.LSU.2.11.2103111229380.7859@eggly.anvils>
 <YFNeDDkTOtls9/XU@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFNeDDkTOtls9/XU@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 03:05:00PM +0100, Michal Hocko wrote:
> On Thu 11-03-21 12:37:20, Hugh Dickins wrote:
> > On Thu, 11 Mar 2021, Michal Hocko wrote:
> > > On Thu 11-03-21 10:21:39, Johannes Weiner wrote:
> > > > On Thu, Mar 11, 2021 at 09:37:02AM +0100, Michal Hocko wrote:
> > > > > Johannes, Hugh,
> > > > > 
> > > > > what do you think about this approach? If we want to stick with
> > > > > split_page approach then we need to update the missing place Matthew has
> > > > > pointed out.
> > > > 
> > > > I find the __free_pages() code quite tricky as well. But for that
> > > > reason I would actually prefer to initiate the splitting in there,
> > > > since that's the place where we actually split the page, rather than
> > > > spread the handling of this situation further out.
> > > > 
> > > > The race condition shouldn't be hot, so I don't think we need to be as
> > > > efficient about setting page->memcg_data only on the higher-order
> > > > buddies as in Willy's scratch patch. We can call split_page_memcg(),
> > > > which IMO should actually help document what's happening to the page.
> > > > 
> > > > I think that function could also benefit a bit more from step-by-step
> > > > documentation about what's going on. The kerneldoc is helpful, but I
> > > > don't think it does justice to how tricky this race condition is.
> > > > 
> > > > Something like this?
> > > > 
> > > > void __free_pages(struct page *page, unsigned int order)
> > > > {
> > > > 	/*
> > > > 	 * Drop the base reference from __alloc_pages and free. In
> > > > 	 * case there is an outstanding speculative reference, from
> > > > 	 * e.g. the page cache, it will put and free the page later.
> > > > 	 */
> > > > 	if (likely(put_page_testzero(page))) {
> > > > 		free_the_page(page, order);
> > > > 		return;
> > > > 	}
> > > > 
> > > > 	/*
> > > > 	 * The speculative reference will put and free the page.
> > > > 	 *
> > > > 	 * However, if the speculation was into a higher-order page
> > > > 	 * that isn't marked compound, the other side will know
> > > > 	 * nothing about our buddy pages and only free the order-0
> > > > 	 * page at the start of our chunk! We must split off and free
> > > > 	 * the buddy pages here.
> > > > 	 *
> > > > 	 * The buddy pages aren't individually refcounted, so they
> > > > 	 * can't have any pending speculative references themselves.
> > > > 	 */
> > > > 	if (!PageHead(page) && order > 0) {
> > > > 		split_page_memcg(page, 1 << order);
> > > > 		while (order-- > 0)
> > > > 			free_the_page(page + (1 << order), order);
> > > > 	}
> > > > }
> > > 
> > > Fine with me. Mathew was concerned about more places that do something
> > > similar but I would say that if we find out more places we might
> > > reconsider and currently stay with a reasonably clear model that it is
> > > only head patch that carries the memcg information and split_page_memcg
> > > is necessary to break such page into smaller pieces.
> > 
> > I agree: I do like Johannes' suggestion best, now that we already
> > have split_page_memcg().  Not too worried about contrived use of
> > free_unref_page() here; and whether non-compound high-order pages
> > should be perpetuated is a different discussion.
> 
> Matthew, are you planning to post a patch with suggested changes or
> should I do it?

I'll post a proper patch.
