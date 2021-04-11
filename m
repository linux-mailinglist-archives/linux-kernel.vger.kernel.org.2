Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB75335B695
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 20:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhDKSgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 14:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbhDKSgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 14:36:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D937C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YfrfmoP5PpxwHa+M62ueDXBrwjxweQe9FK1YZC/7+gY=; b=MzKYUP5hIQcTDRevqTxYOeUdMu
        oymXgAaqq+dKvIu8vsSsVeY0WsXuNzfUuJXdGaV+CGavfv9DQc+CCjBtWiDILoupnQAODrVWRrGcy
        IHyDcQ8aJdnehwIdEqDFWOe7KVE04gndeL8qusvcxfjBNxeQ2UQvvLkPPsOpLP+faEdfoLkX2NM7v
        ZnYldbPiv+VkHjLh6Ig8iTPtIPhnCe2RX/9wTG/MG3JPi92StcHIa7rY9DXi3hpqwDIjTLA18ZQ/1
        20u42wqQN+G/bCNaR5DO7u9/WYMtuuSV2AQ/J89qmYESOtgAoBwPX8nKE9ni6iztZn14Cq1rHJDMk
        xdRlmPxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVevx-003HbF-3a; Sun, 11 Apr 2021 18:35:51 +0000
Date:   Sun, 11 Apr 2021 19:35:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: eliminate "expecting prototype" kernel-doc warnings
Message-ID: <20210411183545.GD2531743@casper.infradead.org>
References: <20210411174321.7013-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411174321.7013-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 10:43:21AM -0700, Randy Dunlap wrote:
> +++ linux-next-20210409/mm/mmu_gather.c
> @@ -250,7 +250,7 @@ void tlb_flush_mmu(struct mmu_gather *tl
>  }
>  
>  /**
> - * tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
> + * __tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
>   * @tlb: the mmu_gather structure to initialize
>   * @mm: the mm_struct of the target address space
>   * @fullmm: @mm is without users and we're going to destroy the full address

I think this is the wrong fix.  __tlb_gather_mmu is static, so documenting
it isn't going to do much good.  Instead, this doc should be moved
down to tlb_gather_mmu().  For bonus points, add documentation for
tlb_gather_mmu_fullmm().

> --- linux-next-20210409.orig/mm/oom_kill.c
> +++ linux-next-20210409/mm/oom_kill.c
> @@ -171,10 +171,11 @@ static bool oom_unkillable_task(struct t
>  }
>  
>  /**
> - * Check whether unreclaimable slab amount is greater than
> - * all user memory(LRU pages).
> + * should_dump_unreclaim_slab - Check whether unreclaimable slab amount
> + * is greater than all user memory (LRU pages).
> + *
>   * dump_unreclaimable_slab() could help in the case that
> - * oom due to too much unreclaimable slab used by kernel.
> + * oom is due to too much unreclaimable slab used by kernel.
>  */
>  static bool should_dump_unreclaim_slab(void)

This is static.  I'd just remove the second '*' and turn it into a
non-kernel-doc comment.

>  {
> --- linux-next-20210409.orig/mm/shuffle.c
> +++ linux-next-20210409/mm/shuffle.c
> @@ -148,7 +148,7 @@ void __meminit __shuffle_zone(struct zon
>  }
>  
>  /**
> - * shuffle_free_memory - reduce the predictability of the page allocator
> + * __shuffle_free_memory - reduce the predictability of the page allocator
>   * @pgdat: node page data
>   */
>  void __meminit __shuffle_free_memory(pg_data_t *pgdat)

Nobody calls __shuffle_free_memory() directly.  If anything, the doc
should be moved to shuffle_free_memory().  But since it has precisely
one caller, and it's within mm/, I'm more inclined to leave this comment
where it is and turn it into a non-kernel-doc comment.  Thoughts?
