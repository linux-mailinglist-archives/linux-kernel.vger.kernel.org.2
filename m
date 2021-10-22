Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC5B4375E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 13:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhJVLTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 07:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhJVLTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 07:19:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C568C061766
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 04:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j71blNuhZOgX+/cgAj5pKSXOeyCTnqXp4/c8vquRDLs=; b=YGQJcluzDOvsTvrCMCXr4eZ5MS
        BhPc8iNKXeVEE3JCb8WYseynOwxBsc+mprdRTAMR+C926bc876bLxJ5dZGb3fl0VfiO1xMdBOB8Gm
        bHnR9iydqms+CjZ7dkGSS1fmWV+38XjkCDd5KAgJLwnKiaNDt2Xl8ZVF7EDMY6ya+wB6KuoiIPAmN
        u20EGiSICFTSFDSMGe6ZBg0S8reu945elOtwxhtYvRE3lfzJy+zZSliiJBqN2mHHycIiBxh2rudTQ
        mKCPmApMyk2Q5y+hKE5PGIeJ2xe/eFyq+ta1es3VIQRKXjF+shGWh0lcYe7muFSbK2Fb2cBj2sjbq
        l9PTSomA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdsW4-00DruN-8E; Fri, 22 Oct 2021 11:15:29 +0000
Date:   Fri, 22 Oct 2021 12:15:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: fix sleeping copy_huge_page called from atomic
 context
Message-ID: <YXKdRDKp+l6lis/R@casper.infradead.org>
References: <20211022074619.57355-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022074619.57355-1-andrea.righi@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 09:46:19AM +0200, Andrea Righi wrote:
> copy_huge_page() can be called with mapping->private_lock held from
> __buffer_migrate_page() -> migrate_page_copy(), so it is not safe to
> do a cond_resched() in this context.
> 
> Introduce migrate_page_copy_nowait() and copy_huge_page_nowait()
> variants that can be used from an atomic context.

I think this is a consequence of THPs being created when they should not
be.  This is the wrong way to fix this problem; and I suspect it may
already be fixed at least in -mm.  We should have taken this path:

        if (!page_has_buffers(page))
                return migrate_page(mapping, newpage, page, mode);

but since we didn't, we can infer that there's a THP which has buffers
(this should never occur).  It's the same root cause as the invalidatepage
problem, just with a very different signature.
