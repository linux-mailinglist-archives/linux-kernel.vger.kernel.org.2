Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E767428578
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 05:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhJKDLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 23:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbhJKDL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:11:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0643EC061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 20:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XctTWDeHDnCbqssJ7+LWVDey5JZcj1NKOhdkWH7mY54=; b=h1kn/eph8rckOBheDKL4QO47Aj
        PZ2Plmp4fXyonfDChq6FqSb3Lzm/3/i45EnlmXINzkDNDD9QwVI7hv0LhS541Jr2Jm26O7iovHa+z
        hxFCBDE0APAWpOJSptZODFkdAo1OKcdb1ocXg4v4eXIIR0zk7w6aKFg8AyvBlIgANu7yw6u2kN9KL
        ENSRbyTJEv3KgWsZ5Y6XdRb26h3jn4DlWuPAq8moX2EdI8+v9dzr1mJ3SwrfwiER0FZhAOdkW22Ui
        Z6BrgplL8EXnD8A5Hm3GwWz8moMwfQRjWZA+z0iC3Sl9VXJqfZ9XFSuUGQzPjf0LRqVHQJt8Cx8LR
        yBxCt5nA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZlfq-005DCU-HK; Mon, 11 Oct 2021 03:08:36 +0000
Date:   Mon, 11 Oct 2021 04:08:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, song@kernel.org,
        william.kucharski@oracle.com, hughd@google.com, shy828301@gmail.com
Subject: Re: [PATCH v4 2/2] mm, thp: bail out early in collapse_file for
 writeback page
Message-ID: <YWOqpgZlqjLhX6oC@casper.infradead.org>
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
 <20211011022241.97072-1-rongwei.wang@linux.alibaba.com>
 <20211011022241.97072-3-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011022241.97072-3-rongwei.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 10:22:41AM +0800, Rongwei Wang wrote:
> Currently collapse_file does not explicitly check PG_writeback, instead,
> page_has_private and try_to_release_page are used to filter writeback
> pages. This does not work for xfs with blocksize equal to or larger
> than pagesize, because in such case xfs has no page->private.
> 
> This makes collapse_file bail out early for writeback page. Otherwise,
> xfs end_page_writeback will panic as follows.
> 
> Fixes: eb6ecbed0aa2 ("mm, thp: relax the VM_DENYWRITE constraint on file-backed THPs")

This is the wrong Fixes line.  This same bug exists earlier than this.
Your testing may not show it before then, but if you mmap something
that isn't an executable, you can provoke it.  It should be:

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")

(unless there's something I'm missing?)

Also, this should surely have a Cc: stable@vger.kernel.org in the
tags section?  It's a user-visible bug, we want it backported.

> Suggested-by: Yang Shi <shy828301@gmail.com>
> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
> Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/khugepaged.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 045cc579f724..48de4e1b0783 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1763,6 +1763,10 @@ static void collapse_file(struct mm_struct *mm,
>  				filemap_flush(mapping);
>  				result = SCAN_FAIL;
>  				goto xa_unlocked;
> +			} else if (PageWriteback(page)) {
> +				xas_unlock_irq(&xas);
> +				result = SCAN_FAIL;
> +				goto xa_unlocked;
>  			} else if (trylock_page(page)) {
>  				get_page(page);
>  				xas_unlock_irq(&xas);
> @@ -1798,7 +1802,8 @@ static void collapse_file(struct mm_struct *mm,
>  			goto out_unlock;
>  		}
>  
> -		if (!is_shmem && PageDirty(page)) {
> +		if (!is_shmem && (PageDirty(page) ||
> +				  PageWriteback(page))) {
>  			/*
>  			 * khugepaged only works on read-only fd, so this
>  			 * page is dirty because it hasn't been flushed
> -- 
> 2.27.0
> 
