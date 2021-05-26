Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4181D39197F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhEZOHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:07:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51560 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbhEZOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:07:11 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out1.suse.de (Postfix) with ESMTP id EE7A5218C8;
        Wed, 26 May 2021 14:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622037938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5uq+iBNj/jjKcCv0AbmZt9FsbJ5C2SxKHh2ZYO11Y8=;
        b=GXFhjtivA+yau+jptz0ryc39hOn393V1Niz2K+YXW66qHZJ67dVsVVN4vIIQiXD23RU/p9
        zXxpr5KawZe8wjIOCFx5HkcMxkzsHvDzb7imSX85UH23i2+IjEykID31tsN4hsxvwGw3Hs
        MnrKmCCbpXFxAyKmfMCL1B2ilEksFrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622037938;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5uq+iBNj/jjKcCv0AbmZt9FsbJ5C2SxKHh2ZYO11Y8=;
        b=wgWZH1T3XTSkWg1osds4EiFDOoiGOlz1GJYNhqM26yjkBbhN8OdLb0HsW5lEDNtMltl6x9
        URn+bd6mF3kdD/Dw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id CB30411A98;
        Wed, 26 May 2021 14:05:38 +0000 (UTC)
Subject: Re: [RFC 1/3] mm/slub: aggregate objects in cache by stack trace
To:     glittao@gmail.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        faiyazm@codeaurora.org
References: <20210521121127.24653-1-glittao@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <127bfde8-7356-8c2a-6a5a-7fa17db7fa33@suse.cz>
Date:   Wed, 26 May 2021 16:05:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210521121127.24653-1-glittao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 2:11 PM, glittao@gmail.com wrote:
> From: Oliver Glitta <glittao@gmail.com>
> 
> Aggregate objects in slub cache by stack trace in addition to caller
> address during alloc_calls and free_calls implementation
> in debugfs. Add stack trace to output.

Yes, the immediate callers alone often don't tell much.

> Add all_objects implementation to debugfs to print information
> about all objects.

Looks like this sentence applies only to patch 3/3.

> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> Based on next-20210518 and
> https://lore.kernel.org/r/1621341949-26762-1-git-send-email-faiyazm@codeaurora.org/
> 
>  mm/slub.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index e9b84eddc50d..d5ed6ed7d68b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4770,6 +4770,7 @@ EXPORT_SYMBOL(validate_slab_cache);
>   */
> 
>  struct location {
> +	depot_stack_handle_t handle;
>  	unsigned long count;
>  	unsigned long addr;
>  	long long sum_time;
> @@ -4822,9 +4823,15 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>  {
>  	long start, end, pos;
>  	struct location *l;
> -	unsigned long caddr;
> +	unsigned long caddr, chandle;
>  	unsigned long age = jiffies - track->when;
> +	depot_stack_handle_t handle;
> 
> +#ifdef CONFIG_STACKDEPOT
> +	handle = READ_ONCE(track->handle);
> +#else
> +	handle = 0;
> +#endif
>  	start = -1;
>  	end = t->count;
> 
> @@ -4839,7 +4846,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>  			break;
> 
>  		caddr = t->loc[pos].addr;
> -		if (track->addr == caddr) {
> +		chandle = t->loc[pos].handle;
> +		if ((track->addr == caddr) && (handle == chandle)) {
> 
>  			l = &t->loc[pos];
>  			l->count++;
> @@ -4864,6 +4872,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
> 
>  		if (track->addr < caddr)
>  			end = pos;
> +		else if (track->addr == caddr && handle < chandle)
> +			end = pos;
>  		else
>  			start = pos;
>  	}
> @@ -4886,6 +4896,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>  	l->max_time = age;
>  	l->min_pid = track->pid;
>  	l->max_pid = track->pid;
> +	l->handle = handle;
>  	cpumask_clear(to_cpumask(l->cpus));
>  	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
>  	nodes_clear(l->nodes);
> @@ -5837,6 +5848,21 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
>  			seq_printf(seq, " nodes=%*pbl",
>  				 nodemask_pr_args(&l->nodes));
> 
> +#ifdef CONFIG_STACKDEPOT
> +		{
> +			depot_stack_handle_t handle;
> +			unsigned long *entries;
> +			unsigned int nr_entries, j;
> +
> +			handle = READ_ONCE(l->handle);
> +			if (handle) {
> +				nr_entries = stack_depot_fetch(handle, &entries);
> +				seq_puts(seq, "\n");
> +				for (j = 0; j < nr_entries; j++)
> +					seq_printf(seq, "\t%pS\n", (void *)entries[j]);
> +			}
> +		}
> +#endif
>  		seq_puts(seq, "\n");
>  	}
> 
> --
> 2.31.1.272.g89b43f80a5
> 

