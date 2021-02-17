Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE82931D895
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhBQLlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:41:46 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:38116 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231948AbhBQLkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:40:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613561983; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=lVzO4MMTKs/GQ0p7ipk8MCORfbpIyJW+dWosnLIyNwA=; b=dYiqohDkJtZ8RCO1e+d/s4Mf+g9eUBANTTUaoRnVBwGHIU/tV97RC7RoaK/kJYapmB+Kynbu
 3U+YTDMs+O50X6d2CeASYIullXECHUhBrHhriU2mFjBaS5mJeBp8gUt8LKcbUKued2tHJ1Qu
 DUoeIXiL+DDFaAuDqDLFF82eK1Y=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 602d005beb4f89cdf85421d0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 11:39:07
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 401E0C4346A; Wed, 17 Feb 2021 11:39:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.147.187] (unknown [106.195.78.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A1E6C433C6;
        Wed, 17 Feb 2021 11:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A1E6C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v2] mm: slub: Convert sys slab alloc_calls, free_calls to
 bin attribute
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     vinmenon@codeaurora.org
References: <1613543513-11965-1-git-send-email-faiyazm@codeaurora.org>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <3526a099-777f-9adc-01ba-e6ea992236c6@codeaurora.org>
Date:   Wed, 17 Feb 2021 17:08:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1613543513-11965-1-git-send-email-faiyazm@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+linux-mm, linux-kernel.

On 2/17/2021 12:01 PM, Faiyaz Mohammed wrote:
> Reading the sys slab alloc_calls, free_calls returns the available object
> owners, but the size of this file is limited to PAGE_SIZE
> because of the limitation of sysfs attributes, it is returning the
> partial owner info, which is not sufficient to debug/account the slab
> memory and alloc_calls output is not matching with /proc/slabinfo.
> 
> To remove the PAGE_SIZE limitation converted the sys slab
> alloc_calls, free_calls to bin attribute.
> 
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> ---
>  mm/slub.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 63 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b22a4b1..71cfe3b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -37,6 +37,9 @@
>  
>  #include <trace/events/kmem.h>
>  
> +#define TRACE_ENTRY_MAX 80
> +#define TRACKS_PER_PAGE  ((PAGE_SIZE - KSYM_SYMBOL_LEN - 100) / TRACE_ENTRY_MAX)
> +
>  #include "internal.h"
>  
>  /*
> @@ -4748,6 +4751,7 @@ static int list_locations(struct kmem_cache *s, char *buf,
>  	struct loc_track t = { 0, 0, NULL };
>  	int node;
>  	struct kmem_cache_node *n;
> +	unsigned int previous_read_count = 0;
>  
>  	if (!alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
>  			     GFP_KERNEL)) {
> @@ -4756,6 +4760,11 @@ static int list_locations(struct kmem_cache *s, char *buf,
>  	/* Push back cpu slabs */
>  	flush_all(s);
>  
> +	if (offset != 0)
> +		previous_read_count = (offset / TRACE_ENTRY_MAX);
> +
> +	memset(buf, 0, PAGE_SIZE);
> +
>  	for_each_kmem_cache_node(s, node, n) {
>  		unsigned long flags;
>  		struct page *page;
> @@ -4771,48 +4780,62 @@ static int list_locations(struct kmem_cache *s, char *buf,
>  		spin_unlock_irqrestore(&n->list_lock, flags);
>  	}
>  
> -	for (i = 0; i < t.count; i++) {
> +	for (i = previous_read_count; i < t.count; i++) {
>  		struct location *l = &t.loc[i];
> +		unsigned int cur_len = 0;
>  
> -		len += sysfs_emit_at(buf, len, "%7ld ", l->count);
> +		cur_len += sysfs_emit_at(buf, cur_len + len, "%7ld ", l->count);
>  
>  		if (l->addr)
> -			len += sysfs_emit_at(buf, len, "%pS", (void *)l->addr);
> +			cur_len += sysfs_emit_at(buf, cur_len + len, "%pS", (void *)l->addr);
>  		else
> -			len += sysfs_emit_at(buf, len, "<not-available>");
> +			cur_len += sysfs_emit_at(buf, cur_len + len, "<not-available>");
>  
>  		if (l->sum_time != l->min_time)
> -			len += sysfs_emit_at(buf, len, " age=%ld/%ld/%ld",
> +			cur_len += sysfs_emit_at(buf, cur_len + len, " age=%ld/%ld/%ld",
>  					     l->min_time,
>  					     (long)div_u64(l->sum_time,
>  							   l->count),
>  					     l->max_time);
>  		else
> -			len += sysfs_emit_at(buf, len, " age=%ld", l->min_time);
> +			cur_len += sysfs_emit_at(buf, cur_len + len, " age=%ld", l->min_time);
>  
>  		if (l->min_pid != l->max_pid)
> -			len += sysfs_emit_at(buf, len, " pid=%ld-%ld",
> +			cur_len += sysfs_emit_at(buf, cur_len + len, " pid=%ld-%ld",
>  					     l->min_pid, l->max_pid);
>  		else
> -			len += sysfs_emit_at(buf, len, " pid=%ld",
> +			cur_len += sysfs_emit_at(buf, cur_len + len, " pid=%ld",
>  					     l->min_pid);
>  
>  		if (num_online_cpus() > 1 &&
>  		    !cpumask_empty(to_cpumask(l->cpus)))
> -			len += sysfs_emit_at(buf, len, " cpus=%*pbl",
> +			cur_len += sysfs_emit_at(buf, cur_len + len, " cpus=%*pbl",
>  					     cpumask_pr_args(to_cpumask(l->cpus)));
>  
>  		if (nr_online_nodes > 1 && !nodes_empty(l->nodes))
> -			len += sysfs_emit_at(buf, len, " nodes=%*pbl",
> +			cur_len += sysfs_emit_at(buf, cur_len + len, " nodes=%*pbl",
>  					     nodemask_pr_args(&l->nodes));
>  
> +		if (cur_len >= TRACE_ENTRY_MAX)
> +			cur_len -= (cur_len % TRACE_ENTRY_MAX) - 1;
> +		else if (cur_len < TRACE_ENTRY_MAX)
> +			cur_len += TRACE_ENTRY_MAX - (cur_len % TRACE_ENTRY_MAX) - 1;
> +
> +		len += cur_len;
> +
>  		len += sysfs_emit_at(buf, len, "\n");
> +
> +		if (i >= (previous_read_count + TRACKS_PER_PAGE))
> +			break;
> +
>  	}
>  
> -	free_loc_track(&t);
> -	if (!t.count)
> -		len += sysfs_emit_at(buf, len, "No data\n");
> +	if (((previous_read_count > t.count) | (i >= t.count)) && (offset != 0))
> +		len = 0;
> +	else if (!t.count)
> +		len += sprintf(buf, "No data\n");
>  
> +	free_loc_track(&t);
>  	return len;
>  }
>  #endif	/* CONFIG_SLUB_DEBUG */
> @@ -5280,21 +5303,33 @@ static ssize_t validate_store(struct kmem_cache *s,
>  }
>  SLAB_ATTR(validate);
>  
> -static ssize_t alloc_calls_show(struct kmem_cache *s, char *buf)
> +static ssize_t alloc_calls_read(struct file *filp, struct kobject *kobj,
> +				struct bin_attribute *bin_attr, char *buf,
> +					loff_t offset, size_t count)
>  {
> +	struct kmem_cache *s;
> +
> +	s = to_slab(kobj);
>  	if (!(s->flags & SLAB_STORE_USER))
>  		return -ENOSYS;
> -	return list_locations(s, buf, TRACK_ALLOC);
> +
> +	return list_locations(s, buf, offset, TRACK_ALLOC);
>  }
> -SLAB_ATTR_RO(alloc_calls);
> +BIN_ATTR_RO(alloc_calls, 0);
>  
> -static ssize_t free_calls_show(struct kmem_cache *s, char *buf)
> +static ssize_t free_calls_read(struct file *filp, struct kobject *kobj,
> +				struct bin_attribute *bin_attr, char *buf,
> +					loff_t offset, size_t count)
>  {
> +	struct kmem_cache *s;
> +
> +	s = to_slab(kobj);
>  	if (!(s->flags & SLAB_STORE_USER))
>  		return -ENOSYS;
> -	return list_locations(s, buf, TRACK_FREE);
> +
> +	return list_locations(s, buf, offset, TRACK_FREE);
>  }
> -SLAB_ATTR_RO(free_calls);
> +BIN_ATTR_RO(free_calls, 0);
>  #endif /* CONFIG_SLUB_DEBUG */
>  
>  #ifdef CONFIG_FAILSLAB
> @@ -5430,6 +5465,14 @@ STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
>  STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
>  #endif	/* CONFIG_SLUB_STATS */
>  
> +
> +static struct bin_attribute *slab_bin_attrs[] = {
> +#ifdef CONFIG_SLUB_DEBUG
> +	&bin_attr_alloc_calls,
> +	&bin_attr_free_calls,
> +#endif
> +};
> +
>  static struct attribute *slab_attrs[] = {
>  	&slab_size_attr.attr,
>  	&object_size_attr.attr,
> @@ -5458,8 +5501,6 @@ static struct attribute *slab_attrs[] = {
>  	&poison_attr.attr,
>  	&store_user_attr.attr,
>  	&validate_attr.attr,
> -	&alloc_calls_attr.attr,
> -	&free_calls_attr.attr,
>  #endif
>  #ifdef CONFIG_ZONE_DMA
>  	&cache_dma_attr.attr,
> @@ -5505,6 +5546,7 @@ static struct attribute *slab_attrs[] = {
>  
>  static const struct attribute_group slab_attr_group = {
>  	.attrs = slab_attrs,
> +	.bin_attrs = slab_bin_attrs,
>  };
>  
>  static ssize_t slab_attr_show(struct kobject *kobj,
> 
