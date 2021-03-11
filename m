Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606B833793E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbhCKQYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbhCKQYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:24:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA9CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=exR+xERV3ojcQqtp1j0CKhkbLxukivv9ZQ+vpw6IcR0=; b=sor4KBFsMgwGYPobUwV20byRF6
        nBo+e/5ydiYY7zAVnWIC7bmIw/77x1crliFWRtXap/kK1cXup1NcCnY4Y7aEUM/Y9V424KOMOsU6B
        UH8KjHCWcb6E7RUaEwvpfJzQFRwP4JYXoQ7RHAGOdzcnOU2wL9nxu/mopE+YSdk4dFcRRmB2X0ki0
        E2ZCW/N9/LPg2PBknxSeOWa0yTFRC8KcHTB6OAtff6aan5rINwoWkVU5u3UpOlnN0jZNfDByV8mQF
        c2topVR7aDG+eIu78x5P89Nf+uOqbkbmscM3kJ2ZvpPTLnDU7Ya4cD9E0WF1J0lnAw3hOmQXnfXPT
        4YeMVTDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKO6D-007jCd-AU; Thu, 11 Mar 2021 16:23:48 +0000
Date:   Thu, 11 Mar 2021 16:23:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Message-ID: <20210311162345.GW3479805@casper.infradead.org>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-3-zhouguanghui1@huawei.com>
 <20210308210225.GF3479805@casper.infradead.org>
 <YEc5iI+ZP7dWr2fC@dhcp22.suse.cz>
 <20210309123255.GI3479805@casper.infradead.org>
 <YEdyJ+ZK2l7tu0rw@dhcp22.suse.cz>
 <YEnWrg2XFwZ2PR0N@dhcp22.suse.cz>
 <YEo1gz6wuYl1Fuqt@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEo1gz6wuYl1Fuqt@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:21:39AM -0500, Johannes Weiner wrote:
> On Thu, Mar 11, 2021 at 09:37:02AM +0100, Michal Hocko wrote:
> > Johannes, Hugh,
> > 
> > what do you think about this approach? If we want to stick with
> > split_page approach then we need to update the missing place Matthew has
> > pointed out.
> 
> I find the __free_pages() code quite tricky as well. But for that
> reason I would actually prefer to initiate the splitting in there,
> since that's the place where we actually split the page, rather than
> spread the handling of this situation further out.

Mmm.  The thing is, we don't actually split the page because it was
never compound.  I don't know whether anybody actually does this,
but it's legitimate to write:

	struct page *p = alloc_pages(GFP_KERNEL, 2);

	free_unref_page(p + 1);
	free_unref_page(p + 3);
	free_unref_page(p + 2);
	__free_page(p);

The good news is that I recently made free_unref_page() local to
mm/internal.h, so we don't need to worry about device drivers doing this.
As far as I can tell, we don't have any exposure to this kind of thing
today through functions exported from mm, but I might have missed
something.

I'd really like to get rid of non-compound high-order pages.  Slab,
filesystems and anonymous memory all use compound pages.  I think
it's just crusty old device drivers that don't.  And alloc_pages_exact(),
of course, but that's kind of internal.

> The race condition shouldn't be hot, so I don't think we need to be as
> efficient about setting page->memcg_data only on the higher-order
> buddies as in Willy's scratch patch. We can call split_page_memcg(),
> which IMO should actually help document what's happening to the page.

I'm cool with that.  I agree, this is not a performance case!

> I think that function could also benefit a bit more from step-by-step
> documentation about what's going on. The kerneldoc is helpful, but I
> don't think it does justice to how tricky this race condition is.

Always good to have other people read over your explanation ...
the kernel-doc could probably be simplified as a result.

