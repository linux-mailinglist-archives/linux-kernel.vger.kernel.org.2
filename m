Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D4E3E32A8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 04:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhHGCDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 22:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhHGCDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 22:03:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF67C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 19:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w9N8Ou48Y2LFVsV0kIh2BGeXdTIG63Sn+jN5i3pEhAw=; b=EkD06ErMt8LCsJv+sA6F2x0MRG
        GSAvw4jk71oNuw//OcjExjulPEF7NOAc08+bDZQJWORiX9WSOGPZRl5BZVspOfe55axgP+vTCJj92
        SH1iX/JPxZobF97Nfpg/1LouHMGysLjk6Mt8Gw/EuE38n55bNxyKnwVtf3nC+8BZLgtX6Lws3Bpqv
        P3iDwTKF35sj1JHnSROYyDuHZqC7ME0RPUWHFT6gWrOIwgwYfqxbDdFBvstKJGdN/XRskxMUBkZ4t
        pHbYL0+e03gaOJu2a9hV0XdsryZqo9jdhaaxEBlpKD/WDfKchVk51sV489zxAKiqcxdF3l2EuRqOJ
        1JOoiz1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCBfV-008mWL-Cp; Sat, 07 Aug 2021 02:02:45 +0000
Date:   Sat, 7 Aug 2021 03:02:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: migrate: Move the page count validation to the
 proper place
Message-ID: <YQ3puWSgUvfvIYjv@casper.infradead.org>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
 <1f7e1d083864fbb17a20a9c8349d2e8b427e20a3.1628174413.git.baolin.wang@linux.alibaba.com>
 <YQwBD55FZyoY+C5D@casper.infradead.org>
 <a02346d7-1a79-eb92-cb1f-033e6b58fa3f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a02346d7-1a79-eb92-cb1f-033e6b58fa3f@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 11:07:18AM +0800, Baolin Wang wrote:
> Hi Matthew,
> 
> > On Thu, Aug 05, 2021 at 11:05:56PM +0800, Baolin Wang wrote:
> > > We've got the expected count for anonymous page or file page by
> > > expected_page_refs() at the beginning of migrate_page_move_mapping(),
> > > thus we should move the page count validation a little forward to
> > > reduce duplicated code.
> > 
> > Please add an explanation to the changelog for why it's safe to pull
> > this out from under the i_pages lock.
> 
> Sure. In folio_migrate_mapping(), we are sure that the migration page was
> isolated from lru list and locked, so I think there are no race to get the
> page count without i_pages lock. Please correct me if I missed something
> else. Thanks.

Unless the page has been removed from i_pages, this isn't a correct
explanation.  Even if it has been removed from i_pages, unless an
RCU grace period has passed, another CPU may still be able to inc the
refcount on it (temporarily).  The same is true for the page tables,
by the way; if someone is using get_user_pages_fast(), they may still
be able to see the page.
