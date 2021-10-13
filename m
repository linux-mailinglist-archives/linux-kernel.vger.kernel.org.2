Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B3B42CD57
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhJMWKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230251AbhJMWKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:10:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C558610D0;
        Wed, 13 Oct 2021 22:08:37 +0000 (UTC)
Date:   Wed, 13 Oct 2021 18:08:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        samitolvanen@google.com, ndesaulniers@google.com,
        kernel-team@android.com, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/cfi: Fix cmp_entries_* functions signature
 mismatch
Message-ID: <20211013180834.73e2653e@gandalf.local.home>
In-Reply-To: <20210923170908.2184404-1-kaleshsingh@google.com>
References: <20210923170908.2184404-1-kaleshsingh@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 17:09:07 +0000
Kalesh Singh <kaleshsingh@google.com> wrote:


This finally popped up into my queue (from all my traveling and running of
conferences :-p )


> If CONFIG_CFI_CLANG=y, attempting to read an event histogram will cause
> the kernel to panic due to failed CFI check.
> 
>     1. echo 'hist:keys=common_pid' >> events/sched/sched_switch/trigger
>     2. cat >> events/sched/sched_switch/hist

Do you mean:

	  2. cat events/sched/sched_switch/hist

?

Small nits below.

>     3. kernel panices on attempting to read hist
> 
> This happens because the sort() function expects a generic
> int (*)(const void *, const void *) pointer for the compare function.
> To prevent this CFI failure, change tracing map cmp_entries_* function
> signatures to match this.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  kernel/trace/tracing_map.c | 40 ++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> index d6bddb157ef2..a8c80ebbf9da 100644
> --- a/kernel/trace/tracing_map.c
> +++ b/kernel/trace/tracing_map.c
> @@ -834,19 +834,21 @@ int tracing_map_init(struct tracing_map *map)
>  	return err;
>  }
>  
> -static int cmp_entries_dup(const struct tracing_map_sort_entry **a,
> -			   const struct tracing_map_sort_entry **b)
> +static int cmp_entries_dup(const void *__a, const void *__b)

Instead of __a and __b, have it as: 

	const void *A, const void *B


>  {
>  	int ret = 0;
> +	const struct tracing_map_sort_entry *a
> +		= *(const struct tracing_map_sort_entry **)__a;
> +	const struct tracing_map_sort_entry *b
> +		= *(const struct tracing_map_sort_entry **)__b;

Please put these before the ret, we like to have a "upside down xmas tree"
type of declaration, where longer lines come before shorter ones. Also,
this can be "prettified" as:

	const struct tracing_map_sort_entry **pa = A;
	const struct tracing_map_sort_entry **pb = B;
	const struct tracing_map_sort_entry *a = *pa;
	const struct tracing_map_sort_entry *b = *pb;
	int ret = 0;

>  
> -	if (memcmp((*a)->key, (*b)->key, (*a)->elt->map->key_size))
> +	if (memcmp(a->key, b->key, a->elt->map->key_size))
>  		ret = 1;
>  
>  	return ret;
>  }
>  
> -static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
> -			   const struct tracing_map_sort_entry **b)
> +static int cmp_entries_sum(const void *__a, const void *__b)
>  {
>  	const struct tracing_map_elt *elt_a, *elt_b;
>  	struct tracing_map_sort_key *sort_key;
> @@ -854,9 +856,13 @@ static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
>  	tracing_map_cmp_fn_t cmp_fn;
>  	void *val_a, *val_b;
>  	int ret = 0;
> +	const struct tracing_map_sort_entry *a
> +		= *(const struct tracing_map_sort_entry **)__a;
> +	const struct tracing_map_sort_entry *b
> +		= *(const struct tracing_map_sort_entry **)__b;

Same here.

>  
> -	elt_a = (*a)->elt;
> -	elt_b = (*b)->elt;
> +	elt_a = a->elt;
> +	elt_b = b->elt;
>  
>  	sort_key = &elt_a->map->sort_key;
>  
> @@ -873,8 +879,7 @@ static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
>  	return ret;
>  }
>  
> -static int cmp_entries_key(const struct tracing_map_sort_entry **a,
> -			   const struct tracing_map_sort_entry **b)
> +static int cmp_entries_key(const void *__a, const void *__b)
>  {
>  	const struct tracing_map_elt *elt_a, *elt_b;
>  	struct tracing_map_sort_key *sort_key;
> @@ -882,9 +887,13 @@ static int cmp_entries_key(const struct tracing_map_sort_entry **a,
>  	tracing_map_cmp_fn_t cmp_fn;
>  	void *val_a, *val_b;
>  	int ret = 0;
> +	const struct tracing_map_sort_entry *a
> +		= *(const struct tracing_map_sort_entry **)__a;
> +	const struct tracing_map_sort_entry *b
> +		= *(const struct tracing_map_sort_entry **)__b;

And here.

Thanks, and sorry for the long delay.

-- Steve

>  
> -	elt_a = (*a)->elt;
> -	elt_b = (*b)->elt;
> +	elt_a = a->elt;
> +	elt_b = b->elt;
>  
>  	sort_key = &elt_a->map->sort_key;
>  
> @@ -989,10 +998,8 @@ static void sort_secondary(struct tracing_map *map,
>  			   struct tracing_map_sort_key *primary_key,
>  			   struct tracing_map_sort_key *secondary_key)
>  {
> -	int (*primary_fn)(const struct tracing_map_sort_entry **,
> -			  const struct tracing_map_sort_entry **);
> -	int (*secondary_fn)(const struct tracing_map_sort_entry **,
> -			    const struct tracing_map_sort_entry **);
> +	int (*primary_fn)(const void *, const void *);
> +	int (*secondary_fn)(const void *, const void *);
>  	unsigned i, start = 0, n_sub = 1;
>  
>  	if (is_key(map, primary_key->field_idx))
> @@ -1061,8 +1068,7 @@ int tracing_map_sort_entries(struct tracing_map *map,
>  			     unsigned int n_sort_keys,
>  			     struct tracing_map_sort_entry ***sort_entries)
>  {
> -	int (*cmp_entries_fn)(const struct tracing_map_sort_entry **,
> -			      const struct tracing_map_sort_entry **);
> +	int (*cmp_entries_fn)(const void *, const void *);
>  	struct tracing_map_sort_entry *sort_entry, **entries;
>  	int i, n_entries, ret;
>  
> 
> base-commit: 58e2cf5d794616b84f591d4d1276c8953278ce24

