Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A8739D95B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFGKN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:13:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56642 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhFGKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:13:56 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E065F21A6C;
        Mon,  7 Jun 2021 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623060724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZFfZGuTAFS1TquvApI1+CiK8J/Pij4y4hPO/LGf4RI=;
        b=KXf0D21g/8C9XmrVp61JJq/W8aEHtJJhgANM4xoKYVhS6M+dfqSZbrA7iMIczG5YQxi3SL
        VII+TIZd67tSHdXR5ZaoeIrl100ZiLEc+I8tMAVeXcF+jw87e7Cs2Wu4tiTD8OsnXX5X+w
        zscuK6f8zydM4t2WK7edTrNwQ9ceR7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623060724;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZFfZGuTAFS1TquvApI1+CiK8J/Pij4y4hPO/LGf4RI=;
        b=/Xvg3qiuRA0/+G8iqXVLPBWNSe/nUknS+Dilj+gGjMur/haz2KaDhVhE9xdQDL5cvYETRf
        FNEdbI9j+9zueGAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B704D118DD;
        Mon,  7 Jun 2021 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623060724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZFfZGuTAFS1TquvApI1+CiK8J/Pij4y4hPO/LGf4RI=;
        b=KXf0D21g/8C9XmrVp61JJq/W8aEHtJJhgANM4xoKYVhS6M+dfqSZbrA7iMIczG5YQxi3SL
        VII+TIZd67tSHdXR5ZaoeIrl100ZiLEc+I8tMAVeXcF+jw87e7Cs2Wu4tiTD8OsnXX5X+w
        zscuK6f8zydM4t2WK7edTrNwQ9ceR7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623060724;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZFfZGuTAFS1TquvApI1+CiK8J/Pij4y4hPO/LGf4RI=;
        b=/Xvg3qiuRA0/+G8iqXVLPBWNSe/nUknS+Dilj+gGjMur/haz2KaDhVhE9xdQDL5cvYETRf
        FNEdbI9j+9zueGAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id UBgmLPTwvWAgLAAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Mon, 07 Jun 2021 10:12:04 +0000
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com
Cc:     vinmenon@codeaurora.org
References: <1622996045-25826-1-git-send-email-faiyazm@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v10] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <c12f642f-0f04-5a58-0966-41cbeb74c066@suse.cz>
Date:   Mon, 7 Jun 2021 12:12:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1622996045-25826-1-git-send-email-faiyazm@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/21 6:14 PM, Faiyaz Mohammed wrote:
> alloc_calls and free_calls implementation in sysfs have two issues,
> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
> to "one value per file" rule.
> 
> To overcome this issues, move the alloc_calls and free_calls implemeation
> to debugfs.
> 
> Debugfs cache will be created if SLAB_STORE_USER flag is set.
> 
> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
> to be inline with what it does.
> 
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> ---
>  mm/slab.h        |   8 ++
>  mm/slab_common.c |   2 +
>  mm/slub.c        | 292 +++++++++++++++++++++++++++++++++++++------------------
>  3 files changed, 209 insertions(+), 93 deletions(-)
> 

...

> +static int slab_debug_trace_open(struct inode *inode, struct file *filep)
> +{
> +
> +	struct kmem_cache_node *n;
> +	enum track_item alloc;
> +	int node;
> +	struct loc_track *t = __seq_open_private(filep, &slab_debugfs_sops,
> +						sizeof(struct loc_track));
> +	struct kmem_cache *s = file_inode(filep)->i_private;
> +
> +	if (strcmp(filep->f_path.dentry->d_name.name, "alloc_traces") == 0)
> +		alloc =  TRACK_ALLOC;

			^ extra space here?

> +	else
> +		alloc =  TRACK_FREE;

same here

> +
> +	if (!alloc_loc_track(t, PAGE_SIZE / sizeof(struct location), GFP_KERNEL)) {
> +		pr_err("Out of memory\n");

Hm I would remove this. It doesn't print any context, so it's not useful to let
users know where/why we ran out of memory. Also if a GFP_KERNEL allocation
fails, there will be a big warning including stacktrace from the page allocator
anyway.

> +		return -ENOMEM;
> +	}
> +
> +	/* Push back cpu slabs */
> +	flush_all(s);
> +
> +	for_each_kmem_cache_node(s, node, n) {
> +		unsigned long flags;
> +		struct page *page;
> +
> +		if (!atomic_long_read(&n->nr_slabs))
> +			continue;
> +
> +		spin_lock_irqsave(&n->list_lock, flags);
> +		list_for_each_entry(page, &n->partial, slab_list)
> +			process_slab(t, s, page, alloc);
> +		list_for_each_entry(page, &n->full, slab_list)
> +			process_slab(t, s, page, alloc);
> +			spin_unlock_irqrestore(&n->list_lock, flags);

At least this is not Python, so it's just a visual flaw :)

> +	}
> +
> +	return 0;
> +}
> +
> +static int slab_debug_trace_release(struct inode *inode, struct file *file)
> +{
> +	struct seq_file *seq = file->private_data;
> +	struct loc_track *t = seq->private;
> +
> +	free_loc_track(t);
> +	kfree(seq->private);
> +	seq->private = NULL;
> +	return seq_release(inode, file);

You can call seq_release_private() instead and deal just with free_loc_track here.

Thanks!
Vlastimil
