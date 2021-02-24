Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48BE324724
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 23:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbhBXWts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 17:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbhBXWtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 17:49:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4E0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 14:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XbA6TlSG8cohloQ6JT5bPa8tRn+Sri1QB1baZ+jGvOo=; b=a+t3MaKCLIK05PAG+wf61LEp8K
        meEktumY8DILhz0wq75h3QK/pQO3p3eXgxKQ7XEdzEJvlcXsJcPRYoazZPHkWOaFD+Xy40jm0JNGm
        IPlguJbKbGEnCCbHIWTC3sOG+l7V+IQJWwyt+UOAJXYJcJ2K0cmZYsRMQmsYhFCwaIXMAEk2cZJik
        ooNlOiSKQe5oyv2eW8zUHqrxjv87kTrSykgDGiqGVPZBKSw/Q6x2qQ52ZoUErDvVwzvZuqcmM1jWk
        KA5ThEZL12MJc6x144zNuY9pOEcYyDfbluwDTbg2DAJSQNkKbfmlT45m02bwOZ1x7Tw3m2Y4j/Cxb
        U45S6V1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lF2xa-009z1I-Ce; Wed, 24 Feb 2021 22:48:49 +0000
Date:   Wed, 24 Feb 2021 22:48:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        alex.shi@linux.alibaba.com, guro@fb.com, hannes@cmpxchg.org,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH] mm: test page->flags directly in page_lru()
Message-ID: <20210224224846.GU2858050@casper.infradead.org>
References: <20210122220600.906146-11-yuzhao@google.com>
 <20210224084807.2179942-1-yuzhao@google.com>
 <20210224051558.79e31c60eea2c088f4a1b300@linux-foundation.org>
 <20210224215639.GT2858050@casper.infradead.org>
 <YDbUaJ0j2YisyyuK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDbUaJ0j2YisyyuK@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 03:34:16PM -0700, Yu Zhao wrote:
> > If only somebody were working on a patch series to get rid of
> > all those calls to compound_head()!  Some reviews on
> > https://lore.kernel.org/linux-mm/20210128070404.1922318-2-willy@infradead.org/
> > would be nice.
> 
> I'm on board with the idea and have done some research in this
> direction. We've found that the ideal *anon* page size for Chrome OS
> is not 4KB or 2MB, but 32KB. I hope we could leverage the folio to
> support flexible anon page size to reduce the number of page faults
> (vs 4KB) or internal fragmentation (vs 2MB).
> 
> That being said, it seems to me this is a long term plan and right
> now we need something smaller. So if you don't mind, I'll just go
> ahead and remove compound_head() from Page{LRU,Active,Unevictable,
> SwapBacked} first?

It's really not a big change I'm suggesting here.  You need
https://lore.kernel.org/linux-mm/20210128070404.1922318-2-willy@infradead.org/
https://lore.kernel.org/linux-mm/20210128070404.1922318-5-willy@infradead.org/
https://lore.kernel.org/linux-mm/20210128070404.1922318-8-willy@infradead.org/
and then the patch I sent above to create folio_lru().

Then any changes you want to make to use folios more broadly will
incrementally move us towards your goal of 32kB anon pages.
