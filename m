Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B2238C57E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhEULPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:15:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:56356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhEULPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:15:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09F4FABB1;
        Fri, 21 May 2021 11:13:52 +0000 (UTC)
Subject: Re: [PATCH v6] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, glittao@gmail.com, greg@kroah.com
Cc:     vinmenon@codeaurora.org
References: <1621341949-26762-1-git-send-email-faiyazm@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a8247d42-01d3-6d9c-678f-382ea1e02945@suse.cz>
Date:   Fri, 21 May 2021 13:13:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1621341949-26762-1-git-send-email-faiyazm@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/21 2:45 PM, Faiyaz Mohammed wrote:
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
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>


> @@ -5817,6 +5769,249 @@ static int __init slab_sysfs_init(void)
>  __initcall(slab_sysfs_init);
>  #endif /* CONFIG_SYSFS */
>  
> +#if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
> +static int debugfs_slab_alias(struct kmem_cache *s, const char *name)
> +{
> +	struct saved_alias *al;
> +	struct dentry *slab_cache_dir;
> +
> +	if (slab_state == FULL) {
> +		/*
> +		 * If we have a leftover link then remove it.
> +		 */
> +		slab_cache_dir = debugfs_lookup(s->name, slab_debugfs_root);
> +		debugfs_remove(slab_cache_dir);
> +		debugfs_create_symlink(name, slab_debugfs_root, NULL);

v6 got stuck on boot for me, unlike v5, seems like here you should return 0?
That helped

> +	}
> +
> +	al = kmalloc(sizeof(struct saved_alias), GFP_KERNEL);
> +	if (!al)
> +		return -ENOMEM;
> +
> +	al->s = s;
> +	al->name = name;
> +	al->next = alias_list;
> +	alias_list = al;
> +	return 0;
> +}
> +
