Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8059434A720
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCZM17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhCZM1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:27:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175C0C0613AA;
        Fri, 26 Mar 2021 05:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=QxJHG67cnzAtp1qB+aYyj2WZtARO+XJmoqLkBw1fYTc=; b=L4C7D/iPJwNEbqcG8xy4WpMw5n
        BDecPJA0uQZuls/0/G6uBNfjaVsne8JK4g9DymhDULa+eE/btqy5hDts7uILquN4NfBruQ7m6EygX
        uWFIPixKNNiLamhYLsHw1z2qRKsswDbAFiY8guxFj1j7+XhVZ/+Ne3MKO0lrFlLhviJk0ieIkb5iw
        nTTZrkFH6Vb3euOOrFUWyGvV9L7lPH4LKeEy/tDHKU7wlaS6J37Ny5jh7srf6YMpq6M2SVKHchBie
        +F9XhvGqXqFXL+7/CYEpUX4V3YRUzD3SLO2iT79Z0cqJgDLw0j4ODKCeGop1vldaRMNCK4PGzPKGi
        IpW8DCOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lPlYb-00En34-Ov; Fri, 26 Mar 2021 12:27:25 +0000
Date:   Fri, 26 Mar 2021 12:27:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] mm/page_alloc: remove duplicated include from
 page_alloc.c
Message-ID: <20210326122717.GE1719932@casper.infradead.org>
References: <20210326025542.3565329-1-miaoqinglang@huawei.com>
 <20210326034208.GC1719932@casper.infradead.org>
 <d3a42312-397d-e7e7-0aa8-819a7b3731db@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3a42312-397d-e7e7-0aa8-819a7b3731db@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 04:18:38PM +0800, Qinglang Miao wrote:
> Hey, Matthew
> 
> Thanks for your advice towards hulk robot. We'd like to improve the
> capbility of hulk robot whole the time.
> 
> This patch is just a small cleanup reported by hulk robot, But the robot can
> do more than this. For example, it finds crucial and useful bugs as well.

I'll have to take your word for it.  Most of what I see from Hulk Robot
is trivialities.

> As for 'Untangle the mass of header includes' you mentioned, could you
> please offer more details? Because I didn't find pagemap.h in net/ipv4/tcp.c
> in -next like what you said.

Exactly!  But check net/ipv4/.tcp.o.d -- you'll see include/linux/pagemap.h
in its dependencies.  So it's being pulled in through another file that is
included by tcp.c, either directly or indirectly.

You can run a file through the preprocessor:

$ make net/ipv4/tcp.i
  CPP     net/ipv4/tcp.i

and then look to see what included it:

# 12 "../include/linux/swap.h" 2

# 1 "../include/linux/pagemap.h" 1

So the question then becomes _either_ "Does swap.h need pagemap.h?",
_or_ "Does tcp.c need swap.h"

So we can try both things, first deleting the include of pagemap.h from
swap.h (compilation fails) and then deleting the include of swap.h from
tcp.c (compilation also fails).  This is a simple example because swap.h
is included directly from tcp.c; the chain can be quite long.

Some human intervention at this point might be possible.  For example,
nr_free_buffer_pages could be exposed through mm.h instead of swap.h,
and then tcp.c wouldn't need swap.h.  Or find_get_incore_page() could be
moved from swap.h to pagemap.h and then swap.h wouldn't need pagemap.h.
But then pagemap.h would acquire a dependency on CONFIG_SWAP (if it
doesn't have that already).  I don't think those are reasonable solutions
for a bot to find.  Or are they?

Anyway, I'm sure there are a lot of obsolete includes.  I have a patch
sitting in my tree which removed pagemap.h from mempolicy.h.  That causes
a build failure in fs/aio.c, so the same patch adds pagemap.h to aio.c.
It's not a particularly large win; only 5 files lose a dependency on
pagemap.h, so I haven't decided what to do with it yet.

> 在 2021/3/26 11:42, Matthew Wilcox 写道:
> > On Fri, Mar 26, 2021 at 10:55:42AM +0800, Qinglang Miao wrote:
> > > Remove duplicated include.
> > > 
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> > 
> > can't you make hulk robot do something useful, like untangle the
> > mass of header includes?  For example, in -next, net/ipv4/tcp.c
> > has a dependency on pagemap.h.  Why?
> > .
> > 
> 
