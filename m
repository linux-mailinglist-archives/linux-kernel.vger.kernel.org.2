Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944F73FC58A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 12:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbhHaKVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 06:21:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57852 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbhHaKVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:21:15 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7295F221F2;
        Tue, 31 Aug 2021 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630405219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpSsXvykYNxP6O/KJXAtzalCJEzC7b1UFSE2Gtv43HY=;
        b=bKJb7owMtYJrRNv5VDrvvGVp07A/pa7iex0XjJ0+R8PU4XQD6fasNj+V/Plqr/wZYkcmjo
        NeNsoC7sbZq43MwjOZqsDF97Yf1vaySJQwCgG4nVkrroThrwpt6KhK2BYzUQ/dDxgu0rZC
        T+sJJ/gtSHHxwveL4jYvw/XxEa1Un2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630405219;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpSsXvykYNxP6O/KJXAtzalCJEzC7b1UFSE2Gtv43HY=;
        b=AzUwivJ+XLu5WUD2QTK4k2lJplQkfMSiRyVTG1JT/kB7bRb3QDQ6AMgLI0ror9DP2zzYGZ
        tp69pYhhuczEMaAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4322F13A7A;
        Tue, 31 Aug 2021 10:20:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id E/+2D2MCLmE8egAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 31 Aug 2021 10:20:19 +0000
Message-ID: <17a36dfc-cbd1-56c5-46a9-9f4043bb56e6@suse.cz>
Date:   Tue, 31 Aug 2021 12:20:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v1 2/2] mm: remove redundant smp_wmb()
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210828042306.42886-1-zhengqi.arch@bytedance.com>
 <20210828042306.42886-3-zhengqi.arch@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210828042306.42886-3-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/21 06:23, Qi Zheng wrote:
> The smp_wmb() which is in the __pte_alloc() is used to
> ensure all ptes setup is visible before the pte is made
> visible to other CPUs by being put into page tables. We
> only need this when the pte is actually populated, so
> move it to pte_install(). __pte_alloc_kernel(),

It's named pmd_install()?

> __p4d_alloc(), __pud_alloc() and __pmd_alloc() are similar
> to this case.
> 
> We can also defer smp_wmb() to the place where the pmd entry
> is really populated by preallocated pte. There are two kinds
> of user of preallocated pte, one is filemap & finish_fault(),
> another is THP. The former does not need another smp_wmb()
> because the smp_wmb() has been done by pte_install().

Same here.

> Fortunately, the latter also does not need another smp_wmb()
> because there is already a smp_wmb() before populating the
> new pte when the THP uses a preallocated pte to split a huge
> pmd.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memory.c         | 47 ++++++++++++++++++++---------------------------
>  mm/sparse-vmemmap.c |  2 +-
>  2 files changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index ef7b1762e996..9c7534187454 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -439,6 +439,20 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
>  
>  	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
>  		mm_inc_nr_ptes(mm);
> +		/*
> +		 * Ensure all pte setup (eg. pte page lock and page clearing) are
> +		 * visible before the pte is made visible to other CPUs by being
> +		 * put into page tables.
> +		 *
> +		 * The other side of the story is the pointer chasing in the page
> +		 * table walking code (when walking the page table without locking;
> +		 * ie. most of the time). Fortunately, these data accesses consist
> +		 * of a chain of data-dependent loads, meaning most CPUs (alpha
> +		 * being the notable exception) will already guarantee loads are
> +		 * seen in-order. See the alpha page table accessors for the
> +		 * smp_rmb() barriers in page table walking code.
> +		 */
> +		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */

So, could it? :)
