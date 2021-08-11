Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8B13E91B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhHKMlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:41:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42608 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhHKMlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:41:01 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2961221EE;
        Wed, 11 Aug 2021 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628685636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xT4Qi52Yg1wMfKZqVvXG/EH9qJsCPIJhtQKjM9Ipsko=;
        b=lB/2cjau/J6IT5r3aYnJoX1SX2U0FPDgl1BGNfjr7gXhboFWHdRnlnpx2B2MDBx5UfzACg
        jei7JTGrt0haCDfEVoTdKMsv2yyy+Pb7b1bsK362zJK3b5/jZWk1U6Q0SeTNmoODP6XUN3
        V2EeXrkP4x0/bXl/fh87r9y65IxITUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628685636;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xT4Qi52Yg1wMfKZqVvXG/EH9qJsCPIJhtQKjM9Ipsko=;
        b=p01YTSUk3W1YL63lBRMaM7CYoB5UycnyUo1aJjtKetPlzP8qDw2XjDFsU1hn5RgoWyrk6n
        /MX7iRyJWgyZQgBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A000C136D9;
        Wed, 11 Aug 2021 12:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id kPdyJkTFE2FIMAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 12:40:36 +0000
Subject: Re: [PATCH] mm: slub: remove preemption disabling from
 put_cpu_partial
To:     Muchun Song <songmuchun@bytedance.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210811111921.85999-1-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0d6c3e3b-c270-bb7d-c038-64ee3f0257cd@suse.cz>
Date:   Wed, 11 Aug 2021 14:40:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811111921.85999-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 1:19 PM, Muchun Song wrote:
> The commit d6e0b7fa1186 ("slub: make dead caches discard free slabs
> immediately") introduced those logic to speed up the destruction of
> per-memcg kmem caches, because kmem caches created for a memory
> cgroup are only destroyed after the last page charged to the cgroup
> is freed at that time. But since commit 9855609bde03 ("mm: memcg/slab:
> use a single set of kmem_caches for all accounted allocations), we
> do not have per-memcg kmem caches anymore. Are those code pointless?
> No, the kmem_cache->cpu_partial can be set to zero by 'echo 0 > /sys/
> kernel/slab/*/cpu_partial'. In this case, the slab page will be put
> into cpu partial list and then moved to node list (because
> slub_cpu_partial() returns zero). However, we can skip putting the
> slab page to cpu partial list and just move it to node list directly.
> We can adjust the condition of kmem_cache_has_cpu_partial() to
> slub_cpu_partial() in __slab_free() and remove those code from
> put_cpu_partial() for simplification.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Please check again current mmotm/next if this still applies, I think it
shouldn't anymore. Thanks.

> ---
>  mm/slub.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b6c5205252eb..69c8ada322a0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2438,7 +2438,6 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
>  	int pages;
>  	int pobjects;
>  
> -	preempt_disable();
>  	do {
>  		pages = 0;
>  		pobjects = 0;
> @@ -2470,16 +2469,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
>  		page->pobjects = pobjects;
>  		page->next = oldpage;
>  
> -	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
> -								!= oldpage);
> -	if (unlikely(!slub_cpu_partial(s))) {
> -		unsigned long flags;
> -
> -		local_irq_save(flags);
> -		unfreeze_partials(s, this_cpu_ptr(s->cpu_slab));
> -		local_irq_restore(flags);
> -	}
> -	preempt_enable();
> +	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page) != oldpage);
>  #endif	/* CONFIG_SLUB_CPU_PARTIAL */
>  }
>  
> @@ -3059,9 +3049,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
>  		was_frozen = new.frozen;
>  		new.inuse -= cnt;
>  		if ((!new.inuse || !prior) && !was_frozen) {
> -
> -			if (kmem_cache_has_cpu_partial(s) && !prior) {
> -
> +			if (slub_cpu_partial(s) && !prior) {
>  				/*
>  				 * Slab was on no list before and will be
>  				 * partially empty
> @@ -3069,9 +3057,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
>  				 * freeze it.
>  				 */
>  				new.frozen = 1;
> -
>  			} else { /* Needs to be taken off a list */
> -
>  				n = get_node(s, page_to_nid(page));
>  				/*
>  				 * Speculatively acquire the list_lock.
> @@ -3082,17 +3068,14 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
>  				 * other processors updating the list of slabs.
>  				 */
>  				spin_lock_irqsave(&n->list_lock, flags);
> -
>  			}
>  		}
> -
>  	} while (!cmpxchg_double_slab(s, page,
>  		prior, counters,
>  		head, new.counters,
>  		"__slab_free"));
>  
>  	if (likely(!n)) {
> -
>  		if (likely(was_frozen)) {
>  			/*
>  			 * The list lock was not taken therefore no list
> @@ -3118,7 +3101,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
>  	 * Objects left in the slab. If it was not on the partial list before
>  	 * then add it.
>  	 */
> -	if (!kmem_cache_has_cpu_partial(s) && unlikely(!prior)) {
> +	if (unlikely(!prior)) {
>  		remove_full(s, n, page);
>  		add_partial(n, page, DEACTIVATE_TO_TAIL);
>  		stat(s, FREE_ADD_PARTIAL);
> 

