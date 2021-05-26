Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01D139165B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 13:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhEZLkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 07:40:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50614 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbhEZLk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 07:40:28 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out1.suse.de (Postfix) with ESMTP id 75A4D218C1;
        Wed, 26 May 2021 11:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622029135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZMLKJ3g2uF5XP58ZulrZ6HcURlFo8YK464UzICdsloc=;
        b=vZBTntcid0MBQhk3mgUlykZziAwTvECahzhTNqFi8OhbewI3fbACPrSXpsWym91OR3sTy/
        SYnm7FO+OGEFWmCX3sj+Vny8WsL2p9DMqgmnJWBtLr7LKyri5pf0srnunXVcfZcnX0C4H7
        yNHDVhbadzNf4gTXr/rC4p5UIsqPaN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622029135;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZMLKJ3g2uF5XP58ZulrZ6HcURlFo8YK464UzICdsloc=;
        b=ftHQakNkhgLCrJD9r+k5CSqcr7GksDBU+n1aXpUo8Si8IFd+DTJPbNYz6JR6Gd5IDuP/XF
        Q2+lgwvIOxBLX0Dw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 53C6611A98;
        Wed, 26 May 2021 11:38:55 +0000 (UTC)
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com
Cc:     vinmenon@codeaurora.org
References: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <86d843f0-bbef-7c3b-6b6a-5d6b32434bee@suse.cz>
Date:   Wed, 26 May 2021 13:38:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 9:38 AM, Faiyaz Mohammed wrote:
> alloc_calls and free_calls implementation in sysfs have two issues,
> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
> to "one value per file" rule.
> 
> To overcome this issues, move the alloc_calls and free_calls implemeation
> to debugfs.
> 
> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
> to be inline with what it does.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

These were IIRC bot reports for some bugs in the previous versions, so keeping
the Reported-by: for the whole patch is misleading - these were not reports for
the sysfs issues this patch fixes by moving the files to debugfs.

> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> ---
> changes in V7:
>         - Drop the older alloc_calls and free_calls interface.
> changes in v6:
>         - https://lore.kernel.org/linux-mm/1621341949-26762-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v5:
>         - https://lore.kernel.org/linux-mm/1620296523-21922-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v4:
>         - https://lore.kernel.org/linux-mm/1618583239-18124-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v3:
>         - https://lore.kernel.org/linux-mm/1617712064-12264-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v2:
>         - https://lore.kernel.org/linux-mm/3ac1d3e6-6207-96ad-16a1-0f5139d8b2b5@codeaurora.org/
> 
> changes in v1:
>         - https://lore.kernel.org/linux-mm/1610443287-23933-1-git-send-email-faiyazm@codeaurora.org/
> 
>  include/linux/slub_def.h |   8 ++
>  mm/slab_common.c         |   9 ++
>  mm/slub.c                | 353 ++++++++++++++++++++++++++++++++++-------------
>  3 files changed, 276 insertions(+), 94 deletions(-)

I don't see any of the symlinks under /sys/kernel/debug/slab/, so I think the
aliases handling code is wrong, and I can see at least two reasons why it could be:

> @@ -4525,6 +4535,8 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
>  			s->refcount--;
>  			s = NULL;
>  		}
> +
> +		debugfs_slab_alias(s, name);

Here you might be calling debugfs_slab_alias() with NULL if the
sysfs_slab_alias() above returned true.

>  	}
>  
>  	return s;

...

> +static int __init slab_debugfs_init(void)
> +{
> +	struct kmem_cache *s;
> +
> +	slab_debugfs_root = debugfs_create_dir("slab", NULL);
> +
> +	slab_state = FULL;
> +
> +	list_for_each_entry(s, &slab_caches, list)
> +		debugfs_slab_add(s);
> +
> +	while (alias_list) {
> +		struct saved_alias *al = alias_list;

alias_list a single list and both slab_sysfs_init() and slab_debugfs_init()
flush it. So only the init call that happens to be called first, does actually
find an unflushed list. I think you
need to use a separate list for debugfs (simpler) or a shared list with both
sysfs and debugfs processing (probably more complicated).

And finally a question, perhaps also for Greg. With sysfs, we hand out the
lifecycle of struct kmem_cache to sysfs, to ensure we are not reading sysfs
files of a cache that has been removed.

But with debugfs, what are the guarantees that things won't blow up when a
debugfs file is being read while somebody calls kmem_cache_destroy() on the cache?

> +
> +		alias_list = alias_list->next;
> +
> +		debugfs_slab_alias(al->s, al->name);
> +
> +		kfree(al);
> +	}
> +
> +	return 0;
> +
> +}
> +__initcall(slab_debugfs_init);
> +#endif
>  /*
>   * The /proc/slabinfo ABI
>   */
> 

