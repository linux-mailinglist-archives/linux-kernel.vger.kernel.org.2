Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E014B325864
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhBYVIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhBYU7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:59:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF78C061756;
        Thu, 25 Feb 2021 12:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Fb28fR8D4293sacImRBpNCIWgpc/QGNK8lBvO/1bYzg=; b=Nin3NxV9mb61KAV3Ka9c6CkJOo
        CO75+0rPm7YtE02SFNN+05E/mv3JMOCIU23JcT5Bwnp222OF4KGYM+j66gP3eoerx0YQ97McoJXWZ
        6l6aW7GsZ+2hN1d8NSYTQbD39T5RDOpPYrh+1aEjbf+ibrPds5JV6js5BTJt2w4b6r7ItWlCSbo7W
        fSx8yper9oa7cZu6vk4gvqhI9jq1xd2H2hGEs5/Q6iOqdW0PnAojQb2RoytNT+kjWP6RVqwnMQwKj
        KvwwOYuC1F6L/1aiFly2NRckR12/6oVAPbdmFH2x+aJE7pfFZUhb7UQz3jZQXVaQaaLKwRzmXu//l
        tzmdbAyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFNiG-00BAcs-P4; Thu, 25 Feb 2021 20:58:23 +0000
Date:   Thu, 25 Feb 2021 20:58:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Freeing page tables through RCU
Message-ID: <20210225205820.GC2858050@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to walk the page tables without the mmap semaphore, it must
be possible to prevent them from being freed and reused (eg if munmap()
races with viewing /proc/$pid/smaps).

There is various commentary within the mm on how to prevent this.  One way
is to disable interrupts, relying on that to block rcu_sched or IPIs.
I don't think the RT people are terribly happy about reading a proc file
disabling interrupts, and it doesn't work for architectures that free
page tables directly instead of batching them into an rcu_sched (because
the IPI may not be sent to this CPU if the task has never run on it).

See "Fast GUP" in mm/gup.c

Ideally, I'd like rcu_read_lock() to delay page table reuse.  This is
close to trivial for architectures which use entire pages or multiple
pages for levels of their page tables as we can use the rcu_head embedded
in struct page to queue the page for RCU.

s390 and powerpc are the only two architectures I know of that have
levels of their page table that are smaller than their PAGE_SIZE.
I'd like to discuss options.  There may be a complicated scheme that
allows partial pages to be freed via RCU, but I have something simpler
in mind.  For powerpc in particular, it can have a PAGE_SIZE of 64kB
and then the MMU wants to see 4kB entries in the PMD.  I suggest that
instead of allocating each 4kB entry individually, we allocate a 64kB
page and fill in 16 consecutive PMDs.  This could cost a bit more memory
(although if you've asked for a CONFIG_PAGE_SIZE of 64kB, you presumably
don't care too much about it), but it'll make future page faults cheaper
(as the PMDs will already be present, assuming you have good locality
of reference).

I'd like to hear better ideas than this.
