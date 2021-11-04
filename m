Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C18A4452F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKDM0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhKDM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:26:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D1EC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kvPhcl8s+fMEqS/cULaE6wmnEx5WH+3Y6yjBqC86VnA=; b=scbFgVK7CaJK9pBBTNZP3VS7Dr
        Je5lwmD2hXfS2o/ckGm9yYsYKDxHT9R7NINusm+P7s51+WjacR697MYsYKzGQiJdoewlWfX6iMMq4
        LVMfW+mHSFqhtf66Hz9vQBjp7ArM7VokDVWE7sPuXEPhEOtQSw4DXYujEN4zj2Gmt9PVR7N8t/NdV
        N/UTRd8fU69+vOmBCW6TQ8eKZOicv2sBejeLCgZvhha7uYO4fkIBWe0WrSUoZmm5ocgWd2Cl8zk8/
        nJkrlwIPRMRkjJi20BVa/ER0xfWco665pMZUTox/zw0f5u2i68u/h1QgyhF1gTo1NqW6HkhANTb8J
        5/zgY5tQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mibkd-005rNG-CC; Thu, 04 Nov 2021 12:22:07 +0000
Date:   Thu, 4 Nov 2021 12:21:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        jglisse@redhat.com, jgg@nvidia.com, rcampbell@nvidia.com,
        jhubbard@nvidia.com
Subject: Re: [PATCH] mm/migrate.c: Rework migration_entry_wait() to not take
 a pageref
Message-ID: <YYPQX2Y5u+ujrAOv@casper.infradead.org>
References: <20211104103338.891258-1-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104103338.891258-1-apopple@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 09:33:38PM +1100, Alistair Popple wrote:
> +++ b/mm/filemap.c
> @@ -1356,6 +1356,88 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
>  	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
>  }
>  
> +/**
> + * migration_entry_wait_on_locked - Wait for a migration entry to be removed
> + * @page: page referenced by the migration entry.
> + * @ptep: mapped pte pointer. This function will return with the ptep unmapped.
> + * @ptl: already locked ptl. This function will drop the lock.
> + *
> + * Wait for a migration entry referencing the given page to be removed. This is
> + * equivalent to put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE) except
> + * this can be called without taking a reference on the page. Instead this
> + * should be called while holding the ptl for the migration entry referencing
> + * the page.
> + *
> + * Returns after unmapping and unlocking the pte/ptl with pte_unmap_unlock().
> + *
> + * This follows the same logic as wait_on_page_bit_common() so see the comments
> + * there.
> + */
> +void migration_entry_wait_on_locked(struct page *page, pte_t *ptep,
> +				spinlock_t *ptl)
> +{
> +	struct wait_page_queue wait_page;
> +	wait_queue_entry_t *wait = &wait_page.wait;
> +	bool thrashing = false;
> +	bool delayacct = false;
> +	unsigned long pflags;
> +	wait_queue_head_t *q;
> +
> +	q = page_waitqueue(page);

You're going to need to update this patch to apply to Linus' current
tree; page_waitqueue() went away in favour of folio_waitqueue().

It seems like it would look simpler if this were a patch which modified
folio_wait_bit_common() instead of doing a manual inline of it into
this function.

