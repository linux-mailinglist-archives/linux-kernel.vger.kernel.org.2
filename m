Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2189337F24
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 21:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhCKUhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 15:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhCKUhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 15:37:36 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E668C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 12:37:36 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id a11so2187543qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 12:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WSwg5k9sbPudFOPM+Iuoe2XRIHWLu4xDbEOxpss2E8Q=;
        b=p71mpGqcQh2nGYEwGZbDtJNzVYMLNwCvhItHWCWoXdSBl+gUn3fIDs6zx0Ecogvm7M
         /udVQPr9G6nsLZ4Vk9EoLyO8XERCpEx2jzP1jqAxXSNUcjirHgBAoubjv1D3l3Mei+LD
         OUiHxciyl9BaZbRcZp/hnDwFDe89W8zEzhYi8jSumr7GF+Nzjhme1pAJKRyF/aT0i9j2
         uXL53EHv+fHY1SZVs2Z97xZBF72wvCfsKNxvObrllw0qpx5F75hS5DHI6U4bjQLEfcb0
         CxERUQEa1tEsmE73GW7lPYP2aYsNbvZ1rXJZ3dcHQaRw6XRXIP4NlXwO45G8jVNZ//Yq
         MNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WSwg5k9sbPudFOPM+Iuoe2XRIHWLu4xDbEOxpss2E8Q=;
        b=Bm/w7F8M4Fg8bWPPJoFYeNqe9ilGp1Ol8EyEnrQ6Ar+2Ig8+Os/0KaGd0IGRqoZ5ew
         /eMyIag1t26uKQt53ZrbsUi/ZoXDrba22rjmCzWi063kQzlj75CwhTmlcBQP77r2XTLq
         WmOlA+FSZQmYrQoKiuwpErfgyM5vjkEtm90S+4LyrM+aeyjW6VjFcAuAvH6nHoWM+Eoo
         pwrDTKBA49O8lwyJqEj70uDqzdjKq8hqyFYhVRglc7a2ucE1Y1h+e373hQ4RsklYUV0W
         DsVcUTaC8+ChrVGLW7JbWz29zjF0So7CjM165PhxOjD9k3VccK9ZotRDZEYZ27VpX9UI
         aQMw==
X-Gm-Message-State: AOAM530Vv5FBRh8C40IrpbhUiewi42FkG4zMls43FyJSKHP7xoAoqFcX
        0ATztUU6xbx5Vs4TlcRf5UqqJYBf3RR8pw==
X-Google-Smtp-Source: ABdhPJyQ3iwvyAvEG4lQaXukQSMbO+5NKXJD5sMobCpHlGQzyLkPHZAYbRMR7r/vKURPU7kdP7p+BQ==
X-Received: by 2002:a05:622a:1c9:: with SMTP id t9mr9071842qtw.244.1615495055065;
        Thu, 11 Mar 2021 12:37:35 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f27sm2692401qkh.118.2021.03.11.12.37.33
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 11 Mar 2021 12:37:34 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:37:20 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Michal Hocko <mhocko@suse.com>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
In-Reply-To: <YEpEzZ1CdXvc5JMt@dhcp22.suse.cz>
Message-ID: <alpine.LSU.2.11.2103111229380.7859@eggly.anvils>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com> <20210304074053.65527-3-zhouguanghui1@huawei.com> <20210308210225.GF3479805@casper.infradead.org> <YEc5iI+ZP7dWr2fC@dhcp22.suse.cz> <20210309123255.GI3479805@casper.infradead.org>
 <YEdyJ+ZK2l7tu0rw@dhcp22.suse.cz> <YEnWrg2XFwZ2PR0N@dhcp22.suse.cz> <YEo1gz6wuYl1Fuqt@cmpxchg.org> <YEpEzZ1CdXvc5JMt@dhcp22.suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021, Michal Hocko wrote:
> On Thu 11-03-21 10:21:39, Johannes Weiner wrote:
> > On Thu, Mar 11, 2021 at 09:37:02AM +0100, Michal Hocko wrote:
> > > Johannes, Hugh,
> > > 
> > > what do you think about this approach? If we want to stick with
> > > split_page approach then we need to update the missing place Matthew has
> > > pointed out.
> > 
> > I find the __free_pages() code quite tricky as well. But for that
> > reason I would actually prefer to initiate the splitting in there,
> > since that's the place where we actually split the page, rather than
> > spread the handling of this situation further out.
> > 
> > The race condition shouldn't be hot, so I don't think we need to be as
> > efficient about setting page->memcg_data only on the higher-order
> > buddies as in Willy's scratch patch. We can call split_page_memcg(),
> > which IMO should actually help document what's happening to the page.
> > 
> > I think that function could also benefit a bit more from step-by-step
> > documentation about what's going on. The kerneldoc is helpful, but I
> > don't think it does justice to how tricky this race condition is.
> > 
> > Something like this?
> > 
> > void __free_pages(struct page *page, unsigned int order)
> > {
> > 	/*
> > 	 * Drop the base reference from __alloc_pages and free. In
> > 	 * case there is an outstanding speculative reference, from
> > 	 * e.g. the page cache, it will put and free the page later.
> > 	 */
> > 	if (likely(put_page_testzero(page))) {
> > 		free_the_page(page, order);
> > 		return;
> > 	}
> > 
> > 	/*
> > 	 * The speculative reference will put and free the page.
> > 	 *
> > 	 * However, if the speculation was into a higher-order page
> > 	 * that isn't marked compound, the other side will know
> > 	 * nothing about our buddy pages and only free the order-0
> > 	 * page at the start of our chunk! We must split off and free
> > 	 * the buddy pages here.
> > 	 *
> > 	 * The buddy pages aren't individually refcounted, so they
> > 	 * can't have any pending speculative references themselves.
> > 	 */
> > 	if (!PageHead(page) && order > 0) {
> > 		split_page_memcg(page, 1 << order);
> > 		while (order-- > 0)
> > 			free_the_page(page + (1 << order), order);
> > 	}
> > }
> 
> Fine with me. Mathew was concerned about more places that do something
> similar but I would say that if we find out more places we might
> reconsider and currently stay with a reasonably clear model that it is
> only head patch that carries the memcg information and split_page_memcg
> is necessary to break such page into smaller pieces.

I agree: I do like Johannes' suggestion best, now that we already
have split_page_memcg().  Not too worried about contrived use of
free_unref_page() here; and whether non-compound high-order pages
should be perpetuated is a different discussion.

Hugh
