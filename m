Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89E3FC70E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhHaMIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 08:08:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51074 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbhHaMH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:07:56 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 17AD61FE79;
        Tue, 31 Aug 2021 12:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630411620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B76cia+77ekkr69gJ9o/UvwsYHQ+OHYWjhSshJwhB6U=;
        b=LtYofda91clqaXsXXRUGIyqzZOUEDKTz8p/nLPl/raPBLPOWZfMM8QsNOuEjuMtssi5FzH
        E4ymFttScah10uTzXQ4LlvjbfahqgAp/9+dKTHLJuQJ4BFARMJFRmsZah36ZxN7FQwknxK
        8or9k+pKocwi98T9FjALk9sJJ6s6nyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630411620;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B76cia+77ekkr69gJ9o/UvwsYHQ+OHYWjhSshJwhB6U=;
        b=ELHxz13DHttSe8KYEx6ZZnxwQTIZIQI9qBHcT9CpECFUsO0/fvSbWFI0FQEOBTcLC/FIG4
        rMrEobnNCqnO5xBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E579413A92;
        Tue, 31 Aug 2021 12:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2KYlN2MbLmE+FgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 31 Aug 2021 12:06:59 +0000
Message-ID: <2772cf56-4183-857f-d070-c54bceb5c8d9@suse.cz>
Date:   Tue, 31 Aug 2021 14:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Content-Language: en-US
To:     Imran Khan <imran.f.khan@oracle.com>, cl@linux.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Oliver Glitta <glittao@gmail.com>
References: <20210831062539.898293-1-imran.f.khan@oracle.com>
 <20210831062539.898293-3-imran.f.khan@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 2/2] mm, slub: Use stackdepot to store user
 information for slub object.
In-Reply-To: <20210831062539.898293-3-imran.f.khan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/21 08:25, Imran Khan wrote:
> SLAB_STORE_USER causes information about allocating and freeing context
> of a slub object, to be stored in metadata area in a couple of struct
> track objects. These objects store allocation and/or freeing stack trace
> in an array. This may result in same stack trace getting stored in metadata
> area of multiple objects.
> STACKDEPOT can be used to store unique stack traces without any
> duplication,so use STACKDEPOT to store allocation and/or freeing stack
> traces as well.
> This results in low memory footprint, as we are not storing multiple
> copies of the same stack trace for an allocation or free.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> ---
>  mm/slub.c | 87 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 48 insertions(+), 39 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index df1ac8aff86f..8e2a2b837106 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -264,8 +264,8 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
>  #define TRACK_ADDRS_COUNT 16
>  struct track {
>  	unsigned long addr;	/* Called from address */
> -#ifdef CONFIG_STACKTRACE
> -	unsigned long addrs[TRACK_ADDRS_COUNT];	/* Called from address */
> +#ifdef CONFIG_STACKDEPOT
> +	depot_stack_handle_t stack;
>  #endif
>  	int cpu;		/* Was running on cpu */
>  	int pid;		/* Pid context */
> @@ -668,6 +668,27 @@ static inline unsigned int get_info_end(struct kmem_cache *s)
>  		return s->inuse;
>  }
>  
> +#ifdef CONFIG_STACKDEPOT
> +static depot_stack_handle_t slub_debug_save_stack(gfp_t flags)
> +{
> +	unsigned long entries[TRACK_ADDRS_COUNT];
> +	unsigned int nr_entries;
> +
> +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 4);
> +	nr_entries = filter_irq_stacks(entries, nr_entries);
> +	return stack_depot_save(entries, nr_entries, flags);
> +}
> +
> +static void print_stack(depot_stack_handle_t stack)
> +{
> +	unsigned long *entries;
> +	unsigned int nr_entries;
> +
> +	nr_entries = stack_depot_fetch(stack, &entries);
> +	stack_trace_print(entries, nr_entries, 0);
> +}

This function could become part of stackdepot itself?

> +#endif
> +
>  static struct track *get_track(struct kmem_cache *s, void *object,
>  	enum track_item alloc)
>  {
> @@ -679,21 +700,13 @@ static struct track *get_track(struct kmem_cache *s, void *object,
>  }
>  
>  static void set_track(struct kmem_cache *s, void *object,
> -			enum track_item alloc, unsigned long addr)
> +			enum track_item alloc, unsigned long addr, gfp_t flags)
>  {
>  	struct track *p = get_track(s, object, alloc);
>  
>  	if (addr) {
> -#ifdef CONFIG_STACKTRACE
> -		unsigned int nr_entries;
> -
> -		metadata_access_enable();
> -		nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
> -					      TRACK_ADDRS_COUNT, 3);
> -		metadata_access_disable();
> -
> -		if (nr_entries < TRACK_ADDRS_COUNT)
> -			p->addrs[nr_entries] = 0;
> +#ifdef CONFIG_STACKDEPOT
> +		p->stack = slub_debug_save_stack(flags);
>  #endif
>  		p->addr = addr;
>  		p->cpu = smp_processor_id();
> @@ -709,10 +722,11 @@ static void init_tracking(struct kmem_cache *s, void *object)
>  	if (!(s->flags & SLAB_STORE_USER))
>  		return;
>  
> -	set_track(s, object, TRACK_FREE, 0UL);
> -	set_track(s, object, TRACK_ALLOC, 0UL);
> +	set_track(s, object, TRACK_FREE, 0UL, 0U);
> +	set_track(s, object, TRACK_ALLOC, 0UL, 0U);
>  }
>  
> +
>  static void print_track(const char *s, struct track *t, unsigned long pr_time)
>  {
>  	if (!t->addr)
> @@ -720,15 +734,11 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
>  
>  	pr_err("%s in %pS age=%lu cpu=%u pid=%d\n",
>  	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
> -#ifdef CONFIG_STACKTRACE
> -	{
> -		int i;
> -		for (i = 0; i < TRACK_ADDRS_COUNT; i++)
> -			if (t->addrs[i])
> -				pr_err("\t%pS\n", (void *)t->addrs[i]);
> -			else
> -				break;
> -	}
> +#ifdef CONFIG_STACKDEPOT
> +	if (t->stack)
> +		print_stack(t->stack);
> +	else
> +		pr_err("(stack is not available)\n");
>  #endif
>  }
>  
> @@ -1261,7 +1271,8 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
>  
>  static noinline int alloc_debug_processing(struct kmem_cache *s,
>  					struct page *page,
> -					void *object, unsigned long addr)
> +					void *object, unsigned long addr,
> +					gfp_t flags)
>  {
>  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
>  		if (!alloc_consistency_checks(s, page, object))
> @@ -1270,7 +1281,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
>  
>  	/* Success perform special debug activities for allocs */
>  	if (s->flags & SLAB_STORE_USER)
> -		set_track(s, object, TRACK_ALLOC, addr);
> +		set_track(s, object, TRACK_ALLOC, addr, flags);
>  	trace(s, page, object, 1);
>  	init_object(s, object, SLUB_RED_ACTIVE);
>  	return 1;
> @@ -1350,7 +1361,7 @@ static noinline int free_debug_processing(
>  	}
>  
>  	if (s->flags & SLAB_STORE_USER)
> -		set_track(s, object, TRACK_FREE, addr);
> +		set_track(s, object, TRACK_FREE, addr, GFP_NOWAIT);
>  	trace(s, page, object, 0);
>  	/* Freepointer not overwritten by init_object(), SLAB_POISON moved it */
>  	init_object(s, object, SLUB_RED_INACTIVE);
> @@ -2987,7 +2998,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  check_new_page:
>  
>  	if (kmem_cache_debug(s)) {
> -		if (!alloc_debug_processing(s, page, freelist, addr)) {
> +		if (!alloc_debug_processing(s, page, freelist, addr, gfpflags)) {
>  			/* Slab failed checks. Next slab needed */
>  			goto new_slab;
>  		} else {
> @@ -4275,6 +4286,8 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
>  	void *objp0;
>  	struct kmem_cache *s = page->slab_cache;
>  	struct track __maybe_unused *trackp;
> +	unsigned long __maybe_unused *entries;
> +	unsigned int __maybe_unused nr_entries;
>  
>  	kpp->kp_ptr = object;
>  	kpp->kp_page = page;
> @@ -4297,19 +4310,15 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
>  	objp = fixup_red_left(s, objp);
>  	trackp = get_track(s, objp, TRACK_ALLOC);
>  	kpp->kp_ret = (void *)trackp->addr;
> -#ifdef CONFIG_STACKTRACE
> -	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
> -		kpp->kp_stack[i] = (void *)trackp->addrs[i];
> -		if (!kpp->kp_stack[i])
> -			break;
> -	}
> +#ifdef CONFIG_STACKDEPOT
> +	nr_entries = stack_depot_fetch(trackp->stack, &entries);
> +	for (i = 0; i < nr_entries; i++)
> +		kpp->kp_stack[i] = (void *)entries[i];

Hmm, in case stack_depot_save() fails and returns a zero handle (e.g. due to
enomem) this seems to rely on stack_depot_fetch() returning gracefully with
zero nr_entries for a zero handle. But I don't see such guarantee?
stack_depot_init() isn't creating such entry and stack_depot_save() doesn't
have such check. So it will work accidentally, or return garbage? But it
would be IMHO useful to add such guarantee to stackdepot one way or another.

>  	trackp = get_track(s, objp, TRACK_FREE);
> -	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
> -		kpp->kp_free_stack[i] = (void *)trackp->addrs[i];
> -		if (!kpp->kp_free_stack[i])
> -			break;
> -	}
> +	nr_entries = stack_depot_fetch(trackp->stack, &entries);
> +	for (i = 0; i < nr_entries; i++)
> +		kpp->kp_free_stack[i] = (void *)entries[i];
>  #endif
>  #endif
>  }
> 

