Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353BF3C8417
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbhGNLw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhGNLw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:52:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4627DC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tmi1aGCU02tV/tT14lWcuB+Jy5Xv5YI9llZbtJNYfEE=; b=pLOe/ifFVz7tyt1jNKOzq+ybQS
        f7OiCWTvC4JFt8F7TvGA3GErQObr/+sdi3DOUZwuXbN5pMUTirft/5hyBz4QROEAPgOvOdhzCG4PP
        xrIvVHrr5vhAptoWG71Uww8/zV5DHHaX0SDEDBJO8CrN9y5sXteAqx3+0BWQUdvw6N6U2Ow/9xwXL
        Pv0M9oVwB+K0j2a6BQmg9YHr/0I9n1PqjxcqwAQWGV8nmXTpcKgnLAFnev3Rmohck7pVApSAPBew+
        7AxeB3uJsfyXfxrvyPrpmG/Fjv3TSv9WJzV2ULhzQ5tI5j2KRk3sLQZialdfB/A8b3btBICob44fu
        MPeRvbMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3dNk-002AhM-8V; Wed, 14 Jul 2021 11:48:58 +0000
Date:   Wed, 14 Jul 2021 12:48:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        akpm@linux-foundation.org, hannes@cmpxchg.org, vbabka@suse.cz,
        axboe@kernel.dk, iamjoonsoo.kim@lge.com, alexs@kernel.org,
        apopple@nvidia.com, minchan@kernel.org, david@redhat.com,
        shli@fb.com, hillf.zj@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm/vmscan: put the redirtied MADV_FREE pages back to
 anonymous LRU list
Message-ID: <YO7PJCm+1zFPZZPS@casper.infradead.org>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-2-linmiaohe@huawei.com>
 <YOvtmy9ggJA4KUIQ@dhcp22.suse.cz>
 <9409189e-44f7-2608-68af-851629b6d453@huawei.com>
 <YO1dGvcTLaRJplRQ@dhcp22.suse.cz>
 <ec86d902-1da5-2f49-7324-a796d32ac979@huawei.com>
 <YO2WUx0a5go71Vhm@casper.infradead.org>
 <b17caa5f-f3db-9fb0-fe1f-45510ff902c8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b17caa5f-f3db-9fb0-fe1f-45510ff902c8@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 07:36:57PM +0800, Miaohe Lin wrote:
> On 2021/7/13 21:34, Matthew Wilcox wrote:
> > On Tue, Jul 13, 2021 at 09:13:51PM +0800, Miaohe Lin wrote:
> >>>> When the MADV_FREE pages are redirtied before they could be reclaimed, the pages
> >>>> should be put back to anonymous LRU list by setting SwapBacked flag, thus the
> >>>> pages will be reclaimed in normal swapout way.
> >>>
> >>> Agreed. But the question is why this needs an explicit handling here
> >>> when we already do handle this case when trying to unmap the page.
> >>
> >> This makes me think more. It seems even the page_ref_freeze call is guaranteed to
> >> success as no one can grab the page refcnt after the page is successfully unmapped.
> > 
> > NO!  This is wrong.  Every page can have its refcount speculatively raised
> > (and then lowered).  The two prime candidates for this are lockless GUP
> > and page cache lookups, but there can be others too.
> > 
> 
> Many thanks for pointing this out. My overlook! Sorry!
> So, it seems lockless GUP can redirty the MADV_FREE page. But is it ok to just release
> a redirtied MADV_FREE pages? Because we hold the last reference here and the page will
> be freed anyway...

I don't see how lockless GUP can redirty the page.  It can grab the
refcount, thus making the refcount here two.  Then the call to freeze
here fails and the page stays on the list.  But the lockless GUP checks
the page is still in the page table (and discovers it isn't, so releases
the reference count).  Am I missing a path that lets lockless GUP dirty
the page?
