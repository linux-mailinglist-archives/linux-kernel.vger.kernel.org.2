Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725DD39786E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhFAQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhFAQv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:51:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB4BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uoEFmf5kb5KFlqxqauxZeSleaFg1sIWMRHac0kPaDds=; b=QaTRb/vo4Mlhk4WOH24mmh1piU
        NHXuUXlAilh3g/CVLQD5LGxZ/DlX4G4bFI0Bu3KcNPpWiqFijDwJVTini6zxCrHqtFW/aArwoNqyV
        O3YIKk3S+K+8di4nips6N7qU+DdOuSpiCpnqTIulknZO5Hs1zCfj9G0EDOy2vpj4FHUNNV0uFfcPm
        85yHYHSJtU9ihPW/HIzfhQw9/KF1w6l6BIwG9AxC70RjsFb72zIojOVAQunpPbX33Pqn/QpyJkft4
        hKMmQoZ8I1w5r/Y6GrI27CND/UAu4MQyAtwazqQKOAsG/sHmwg3JcyQ4kZV7h01FGMI5Aujg/WmSQ
        xXdCBlJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lo7Zy-00ADnn-Q1; Tue, 01 Jun 2021 16:49:27 +0000
Date:   Tue, 1 Jun 2021 17:49:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xu Yu <xuyu@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, gavin.dg@linux.alibaba.com,
        Hugh Dickins <hughd@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm, thp: relax migration wait when failed to get tail
 page
Message-ID: <YLZlEqHlX18/eKhn@casper.infradead.org>
References: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 12:31:41AM +0800, Xu Yu wrote:
> We notice that hung task happens in a conner but practical scenario when
> CONFIG_PREEMPT_NONE is enabled, as follows.
> 
> Process 0                       Process 1                     Process 2..Inf
> split_huge_page_to_list
>     unmap_page
>         split_huge_pmd_address
>                                 __migration_entry_wait(head)
>                                                               __migration_entry_wait(tail)
>     remap_page (roll back)
>         remove_migration_ptes
>             rmap_walk_anon
>                 cond_resched
> 
> Where __migration_entry_wait(tail) is occurred in kernel space, e.g.,
> copy_to_user, which will immediately fault again without rescheduling,
> and thus occupy the cpu fully.
> 
> When there are too many processes performing __migration_entry_wait on
> tail page, remap_page will never be done after cond_resched.
> 
> This relaxes __migration_entry_wait on tail page, thus gives remap_page
> a chance to complete.

I don't like this at all.  If only we could call wait_on_page_locked()
without having a reference to the page.

I /think/ the only obstacle to doing that is that Slab may reuse
the PG_locked bit without following the pagecache wakeup protocol.
That wouldn't be a hard thing to change; I think it's only slub that
uses that bit, and it really could use any bit in the page flags.

> Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
> ---
>  mm/migrate.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b234c3f3acb7..df2dc39fe566 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -301,8 +301,11 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>  	 * is zero; but we must not call put_and_wait_on_page_locked() without
>  	 * a ref. Use get_page_unless_zero(), and just fault again if it fails.
>  	 */
> -	if (!get_page_unless_zero(page))
> -		goto out;
> +	if (!get_page_unless_zero(page)) {
> +		pte_unmap_unlock(ptep, ptl);
> +		cond_resched();
> +		return;
> +	}
>  	pte_unmap_unlock(ptep, ptl);
>  	put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
>  	return;
> -- 
> 2.20.1.2432.ga663e714
> 
> 
