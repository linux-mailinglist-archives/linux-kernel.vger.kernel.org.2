Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2B391986
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbhEZOIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:08:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49658 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbhEZOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:08:12 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out2.suse.de (Postfix) with ESMTP id 828A41FD29;
        Wed, 26 May 2021 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622037999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+fWJ89PhgnhS/Yf0anDjWgbu8PDm6n5TN+P7qd4Wr8U=;
        b=RDbd3fdHF45PozgvzgXadaMAZxMTQxUQmwVQHJvnnc4S3H6ZtYg0gUDI1CgoRvs7XGAa4j
        J5qqMNGwn+m0/oABtqzrxcdiuttGnWEvVZxePlyeVlIfEr4Ln+ZI3jIDLcCbI2jeJOU3/Z
        tBXmfYg6pVymi3IatniocPvzWYGAkrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622037999;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+fWJ89PhgnhS/Yf0anDjWgbu8PDm6n5TN+P7qd4Wr8U=;
        b=bprVp6ntthqke5j8weOXe3bT25Blzuf6OkkbkDDU5JiA9ypm+J6GeQNVPqgHf991axpd47
        pFpUdVianUHVevCg==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 6249D11A98;
        Wed, 26 May 2021 14:06:39 +0000 (UTC)
Subject: Re: [RFC 2/3] mm/slub: sort objects in cache by frequency of stack
 trace
To:     glittao@gmail.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        faiyazm@codeaurora.org
References: <20210521121127.24653-1-glittao@gmail.com>
 <20210521121127.24653-2-glittao@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c9b88ab1-42dc-1198-4ad1-e9a980d4a6bf@suse.cz>
Date:   Wed, 26 May 2021 16:06:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210521121127.24653-2-glittao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 2:11 PM, glittao@gmail.com wrote:
> From: Oliver Glitta <glittao@gmail.com>
> 
> Sort objects in slub cache by the frequency of stack trace used
> in object location in alloc_calls and free_calls implementation
> in debugfs. Most frequently used stack traces will be the first.

That will make it much more convenient.

> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index d5ed6ed7d68b..247983d647cd 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -37,6 +37,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/random.h>
>  #include <kunit/test.h>
> +#include <linux/sort.h>
>  
>  #include <linux/debugfs.h>
>  #include <trace/events/kmem.h>
> @@ -5893,6 +5894,17 @@ static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
>  	return NULL;
>  }
>  
> +static int cmp_loc_by_count(const void *a, const void *b, const void *data)
> +{
> +	struct location *loc1 = (struct location *)a;
> +	struct location *loc2 = (struct location *)b;
> +
> +	if (loc1->count > loc2->count)
> +		return -1;
> +	else
> +		return 1;
> +}
> +
>  static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
>  {
>  	struct kmem_cache_node *n;
> @@ -5944,6 +5956,11 @@ static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
>  				process_slab(&t, s, page, alloc);
>  			spin_unlock_irqrestore(&n->list_lock, flags);
>  		}
> +
> +		/* Sort locations by count */
> +		sort_r(t.loc, t.count, sizeof(struct location),
> +				cmp_loc_by_count, NULL, NULL);
> +
>  	}
>  
>  	if (*ppos < t.count) {
> 

