Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767C8391550
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhEZKuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:50:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48228 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbhEZKuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:50:20 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out2.suse.de (Postfix) with ESMTP id DE0581FD29;
        Wed, 26 May 2021 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622026127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KbKOu0mEdoI8kb/j45kMc9SQNVujWd8DYO1qXhK9sJU=;
        b=eecEfF7/YaFpVcAsGAC8iuypEktd/q31uW5UstHTYrO+KI+9bc56yLBywjUGd33D8LMDME
        FtmYR41nzqhyTIp5StyyCIrjds3f5mkpYVvcOnj9nWFWH3bauf3T+FqXQXN/Qf2p82bNfK
        IDPJs96YXhFX9p2wUgtDZVyU+hD4JZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622026127;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KbKOu0mEdoI8kb/j45kMc9SQNVujWd8DYO1qXhK9sJU=;
        b=e03ko3PzoWQAGjlT5ZrE2L6sVje8ABvU+ugaDtkfvtUe43QjLEZUJcE0uvbOOLUwEHVBJW
        hRjijFPGMSrYtyCA==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id C1F6A11A98;
        Wed, 26 May 2021 10:48:47 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] slub: Force on no_hash_pointers when slub_debug is
 enabled
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
References: <20210526025625.601023-1-swboyd@chromium.org>
 <20210526025625.601023-5-swboyd@chromium.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <555eaf8b-deb2-fa49-ddef-a74645848159@suse.cz>
Date:   Wed, 26 May 2021 12:48:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210526025625.601023-5-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 4:56 AM, Stephen Boyd wrote:
> Obscuring the pointers that slub shows when debugging makes for some
> confusing slub debug messages:
> 
>  Padding overwritten. 0x0000000079f0674a-0x000000000d4dce17
> 
> Those addresses are hashed for kernel security reasons. If we're trying
> to be secure with slub_debug on the commandline we have some big
> problems given that we dump whole chunks of kernel memory to the kernel
> logs. Let's force on the no_hash_pointers commandline flag when
> slub_debug is on the commandline. This makes slub debug messages more
> meaningful and if by chance a kernel address is in some slub debug
> object dump we will have a better chance of figuring out what went
> wrong.
> 
> Note that we don't use %px in the slub code because we want to reduce
> the number of places that %px is used in the kernel. This also nicely
> prints a big fat warning at kernel boot if slub_debug is on the
> commandline so that we know that this kernel shouldn't be used on
> production systems.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> I opted for extern because I guess we don't want to advertise
> no_hash_pointers_enable() in some sort of header file? It can be put in
> a header file

Hm looks like the bots disagree. I suppose a declaration right above definition
in lib/vsprintf.c would silence them, but I'll leave it to printk maintainers if
they would prefer that way or traditionally
include/linux/kernel.h

> but I see that the no_hash_pointers variable is also not 
> in a header file but exported as symbol.

Yeah it's only used by tests, and a variable doesn't need separate declaration.

>  lib/vsprintf.c | 2 +-
>  mm/slub.c      | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index f0c35d9b65bf..cc281f5895f9 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2186,7 +2186,7 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
>  bool no_hash_pointers __ro_after_init;
>  EXPORT_SYMBOL_GPL(no_hash_pointers);
>  
> -static int __init no_hash_pointers_enable(char *str)
> +int __init no_hash_pointers_enable(char *str)
>  {
>  	if (no_hash_pointers)
>  		return 0;
> diff --git a/mm/slub.c b/mm/slub.c
> index bf4949115412..1c30436d3e6c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4451,6 +4451,8 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
>  	return s;
>  }
>  
> +extern int no_hash_pointers_enable(char *str);
> +
>  void __init kmem_cache_init(void)
>  {
>  	static __initdata struct kmem_cache boot_kmem_cache,
> @@ -4470,6 +4472,10 @@ void __init kmem_cache_init(void)
>  	for_each_node_state(node, N_NORMAL_MEMORY)
>  		node_set(node, slab_nodes);
>  
> +	/* Print slub debugging pointers without hashing */
> +	if (static_branch_unlikely(&slub_debug_enabled))
> +		no_hash_pointers_enable(NULL);
> +
>  	create_boot_cache(kmem_cache_node, "kmem_cache_node",
>  		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
>  
> 

