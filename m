Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C4439F7E5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhFHNhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhFHNhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:37:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C8C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 06:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=riDPbwo++OTuXYeZ0Bw40T80J63Mte6osn02rTiXE80=; b=oTf6wBN4d87+zmVui/ismOVXis
        8f2sKfpd48v6VEaJ0yWlEJcuiqjxDpIndI4WRT4NQtxegM1werAAqhchcI8u0gs3g0IiHeB4ypwtp
        t8xscgHa2qxvXzQX7gDY8Uuy1qQyUaSaytX8Tk2ck/9/4lJXtmOmV8BKzMQuUpw5rwAEkZ1O4k1DS
        Hffvs4DrlOBR2orC2zlaSOlN1wPdXrjWRsfyuRXlTMDlb6urtuqu5UvKc21xZssTYlEkMkL7M+thQ
        Kr31qquX/XL6MBLzP6SQFcr46c7TLrswlBcZxv4xCM8AyHzlAuzZ+Hqk9iEetwHpNtZrZh4XVJnOQ
        iHiAlkJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqbt6-00Gyyh-0i; Tue, 08 Jun 2021 13:35:28 +0000
Date:   Tue, 8 Jun 2021 14:35:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Xu Yu <xuyu@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hughd@google.com,
        akpm@linux-foundation.org, gavin.dg@linux.alibaba.com
Subject: Re: [PATCH v2] mm, thp: use head page in __migration_entry_wait
Message-ID: <YL9yG/zXqSu+U47y@casper.infradead.org>
References: <b9836c1dd522e903891760af9f0c86a2cce987eb.1623144009.git.xuyu@linux.alibaba.com>
 <20210608120026.ugfh72ydjeba44bo@box.shutemov.name>
 <YL9jVYgWYBydOYst@casper.infradead.org>
 <20210608125838.6ixdlz3t334gjnp7@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608125838.6ixdlz3t334gjnp7@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 03:58:38PM +0300, Kirill A. Shutemov wrote:
> On Tue, Jun 08, 2021 at 01:32:21PM +0100, Matthew Wilcox wrote:
> > On Tue, Jun 08, 2021 at 03:00:26PM +0300, Kirill A. Shutemov wrote:
> > > But there's one quirk: if split succeed we effectively wait on wrong
> > > page to be unlocked. And it may take indefinite time if split_huge_page()
> > > was called on the head page.
> > 
> > Hardly indefinite time ... callers of split_huge_page_to_list() usually
> > unlock the page soon after.  Actually, I can't find one that doesn't call
> > unlock_page() within a few lines of calling split_huge_page_to_list().
> 
> I didn't check all callers, but it's not guaranteed by the interface and
> it's not hard to imagine a future situation when a page got split on the
> way to IO and kept locked until IO is complete.

I would say that can't happen.  Pages are locked when added to the page
cache and are !Uptodate.  You can't put a PTE in a process page table
until it's Uptodate, and once it's Uptodate, the page is unlocked.  So
any subsequent locks are transient, and not for the purposes of IO
(writebacks only take the page lock transiently).

> The wake up shouldn't have much overhead as in most cases split going to
> be called on the head page.

I'm not convinced about that.  We go out of our way to not wake up pages
(eg PageWaiters), and we've had some impressively long lists in the past
(which is why we now have the bookmarks).
