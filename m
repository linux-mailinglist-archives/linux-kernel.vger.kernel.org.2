Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE624448B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 20:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhKCTFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 15:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhKCTFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 15:05:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B895C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 12:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5QBJKfFT1x1NaSqmO/BJvj40AkB1znqo2ky8ALUH6n4=; b=ezJQGHgxE+i4PGNKcrhgC3Hi/c
        vf9BFCEfOpxYdrfBWeZhTZFdKdrh3PPg/8tYyoWA8RChSKaC2WCvtjKqyNEjDfGbIr37rGczoKnxA
        W6yUafutMLpoiweXSho2/rP5u851XaRiVy3pt81SoRXhZ8sg4X60TwEHTzEtDWegmWCq67QaJYIG4
        +I0qT7O+eu40eeAWnBVSssmHXFWzt3zjXDCB5FbvjJbx8htktk9oar2fXExcULXfDNb/BLvq9XRJo
        i1dYw/kvWaU7e/RkzuDE7O70Ft92VK8dcTKIqEWMRCHYISvOBr1xRohZhmm2Z9oXROY9TKBIeuVnF
        5b5TBBwA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miLSy-005PDK-P3; Wed, 03 Nov 2021 18:58:46 +0000
Date:   Wed, 3 Nov 2021 18:58:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jimmy Shiu <jimmyshiu@google.com>
Cc:     mingo@redhat.com, joaodias@google.com, wvw@google.com,
        Minchan Kim <minchan@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] SCHED: attribute page lock and waitqueue functions as
 sched
Message-ID: <YYLb2BGL1jR+kqF+@casper.infradead.org>
References: <20211103184708.1778294-1-jimmyshiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103184708.1778294-1-jimmyshiu@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:47:03AM +0800, Jimmy Shiu wrote:
> Bug: 144961676
> Bug: 144713689
> Bug: 172212772

A bug number is meaningless without knowing which bug tracker they
refer to.  I suggest contemplating the meaning of the 'U' in URL.

> Signed-off-by: Minchan Kim <minchan@google.com>
> Signed-off-by: Jimmy Shiu <jimmyshiu@google.com>
> (cherry picked from commit 1e4de875d9e0cfaccf5131bcc709ae8646cdc168)

what tree is that commit ID in?  I suggest it's meaningless and
should be removed.

> @@ -687,7 +688,7 @@ static inline void folio_lock(struct folio *folio)
>  /*
>   * lock_page may only be called if we have the page's inode pinned.
>   */
> -static inline void lock_page(struct page *page)
> +static inline __sched void lock_page(struct page *page)

Why do you need to tag a static inline function as __sched?  This would
be the only place where that is done.

> +++ b/kernel/sched/wait.c
> @@ -404,7 +404,8 @@ void finish_wait(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_en
>  }
>  EXPORT_SYMBOL(finish_wait);
>  
> -int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key)
> +__sched int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned int mode,
> +				     int sync, void *key)
>  {

This function doesn't sleep.  Why does it need to be tagged __sched?

> @@ -440,7 +441,7 @@ static inline bool is_kthread_should_stop(void)
>   * }						smp_mb(); // C
>   * remove_wait_queue(&wq_head, &wait);		wq_entry->flags |= WQ_FLAG_WOKEN;
>   */
> -long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout)
> +__sched long wait_woken(struct wait_queue_entry *wq_entry, unsigned int mode, long timeout)

This one makes sense, but you've extended the length of the line past 80
columns, and it seems like it should be a separate patch with its own
justification.

> +__sched int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned int mode,
> +				int sync, void *key)

This doesn't seem to sleep either?

> +++ b/mm/filemap.c
> @@ -1271,7 +1271,7 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
>  /* How many times do we accept lock stealing from under a waiter? */
>  int sysctl_page_lock_unfairness = 5;
>  
> -static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
> +static inline __sched int folio_wait_bit_common(struct folio *folio, int bit_nr,
>  		int state, enum behavior behavior)
>  {
>  	wait_queue_head_t *q = folio_waitqueue(folio);
> @@ -1411,13 +1411,13 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>  	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
>  }
>  
> -void folio_wait_bit(struct folio *folio, int bit_nr)
> +__sched void folio_wait_bit(struct folio *folio, int bit_nr)
>  {
>  	folio_wait_bit_common(folio, bit_nr, TASK_UNINTERRUPTIBLE, SHARED);
>  }
>  EXPORT_SYMBOL(folio_wait_bit);
>  
> -int folio_wait_bit_killable(struct folio *folio, int bit_nr)
> +__sched int folio_wait_bit_killable(struct folio *folio, int bit_nr)
>  {
>  	return folio_wait_bit_common(folio, bit_nr, TASK_KILLABLE, SHARED);
>  }
> @@ -1628,21 +1628,21 @@ EXPORT_SYMBOL_GPL(page_endio);
>   * __folio_lock - Get a lock on the folio, assuming we need to sleep to get it.
>   * @folio: The folio to lock
>   */
> -void __folio_lock(struct folio *folio)
> +__sched void __folio_lock(struct folio *folio)
>  {
>  	folio_wait_bit_common(folio, PG_locked, TASK_UNINTERRUPTIBLE,
>  				EXCLUSIVE);
>  }
>  EXPORT_SYMBOL(__folio_lock);
>  
> -int __folio_lock_killable(struct folio *folio)
> +__sched int __folio_lock_killable(struct folio *folio)
>  {
>  	return folio_wait_bit_common(folio, PG_locked, TASK_KILLABLE,
>  					EXCLUSIVE);
>  }
>  EXPORT_SYMBOL_GPL(__folio_lock_killable);
>  
> -static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
> +static __sched int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
>  {
>  	struct wait_queue_head *q = folio_waitqueue(folio);
>  	int ret = 0;
> @@ -1679,7 +1679,7 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
>   * If neither ALLOW_RETRY nor KILLABLE are set, will always return true
>   * with the folio locked and the mmap_lock unperturbed.
>   */
> -bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
> +__sched bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
>  			 unsigned int flags)
>  {
>  	if (fault_flag_allow_retry_first(flags)) {
> -- 
> 2.34.0.rc0.344.g81b53c2807-goog
> 
> 
