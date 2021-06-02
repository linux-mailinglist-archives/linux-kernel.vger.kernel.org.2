Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCCD398E57
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhFBPU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:20:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59320 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhFBPUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:20:12 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 79F8922C3D;
        Wed,  2 Jun 2021 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622647107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95+gVSKdXSeqrGajzQBt/N7prqq4lqW4DujdQ82G5mY=;
        b=qgAwrc94oVdW6YtQzM+BQjrgCjd9694/CCkB+nL89OaC262rnedK5CIbu/fhujFU4z5Ltn
        CW3zqlemZbk+ZEtBhc9L2M0m8u5tpPZFbCAGZhxqCgKFGnuqZtYkkLE5JdZ1WJqfQHcCOz
        3zo6iF8rYfLy7GuWMOVAIJh/RLnJybM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622647107;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95+gVSKdXSeqrGajzQBt/N7prqq4lqW4DujdQ82G5mY=;
        b=8bPMi/WJ1NvkQinMQVnUZ/YMq/V9OpV+x5PBw2TdKS0dupANh954pMEYK0CUs9pTlaCyW2
        c/saRuszwy85wrBA==
Received: by imap.suse.de (Postfix, from userid 51)
        id 739BC11CDC; Wed,  2 Jun 2021 16:20:03 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 13EB311DA5;
        Wed,  2 Jun 2021 10:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622631004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95+gVSKdXSeqrGajzQBt/N7prqq4lqW4DujdQ82G5mY=;
        b=OKt1PYimoMkY0KDdQmL7eA3UQMDxBIoT5LyONbhZVPFqoPZxOUaXwmYs+IBce1kOWCFwBl
        CRNGMdKlG7A0OXuiPQ5abeXCWN1gGIvFmevh/lBFW0IdFgSsuXydYYNm0CAZTFSql5e8gL
        uOHQWgGN4k46gF2fAY5woda6u6Ys58c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622631004;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95+gVSKdXSeqrGajzQBt/N7prqq4lqW4DujdQ82G5mY=;
        b=NzKYfasRSjg2oWXjqmJuM3cBfnUHhByiTeN0dYBNWaxauwf8wGyKWmehlPV40+OXEWZucr
        FIXvDDKby+2TBsDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id XFlkBFxit2BaWwAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 02 Jun 2021 10:50:04 +0000
Subject: Re: [PATCH v3 4/4] slub: Force on no_hash_pointers when slub_debug is
 enabled
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
References: <20210601182202.3011020-1-swboyd@chromium.org>
 <20210601182202.3011020-5-swboyd@chromium.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5b1e2626-1d70-26cd-bb17-f7f8f80ac377@suse.cz>
Date:   Wed, 2 Jun 2021 12:50:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601182202.3011020-5-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 8:22 PM, Stephen Boyd wrote:
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

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/kernel.h | 2 ++
>  lib/vsprintf.c         | 2 +-
>  mm/slub.c              | 4 ++++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 15d8bad3d2f2..bf950621febf 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -357,6 +357,8 @@ int sscanf(const char *, const char *, ...);
>  extern __scanf(2, 0)
>  int vsscanf(const char *, const char *, va_list);
>  
> +extern int no_hash_pointers_enable(char *str);
> +
>  extern int get_option(char **str, int *pint);
>  extern char *get_options(const char *str, int nints, int *ints);
>  extern unsigned long long memparse(const char *ptr, char **retptr);
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
> index bf4949115412..a722794f1dbd 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4460,6 +4460,10 @@ void __init kmem_cache_init(void)
>  	if (debug_guardpage_minorder())
>  		slub_max_order = 0;
>  
> +	/* Print slub debugging pointers without hashing */
> +	if (static_branch_unlikely(&slub_debug_enabled))
> +		no_hash_pointers_enable(NULL);
> +
>  	kmem_cache_node = &boot_kmem_cache_node;
>  	kmem_cache = &boot_kmem_cache;
>  
> 

