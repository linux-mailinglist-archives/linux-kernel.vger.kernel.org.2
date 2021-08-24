Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F673F5D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhHXMFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:05:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51118 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbhHXMFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:05:45 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4460220057;
        Tue, 24 Aug 2021 12:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629806700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCkQsq0WCN+4UlXYY516S9PjlUNpzxgDb/+/yCJ+4UE=;
        b=w0bzVJBr/Y45U89rR/wwPcUn7p75zM0HP7T1dS9RhzY2IMl10I30SQ1RjbFQpyXN8Hl4Sv
        0LLa75bmvd4bfNmZ68kbE5+JA1Jr6BVfya6wkVtSuU5NFhc6MVhUSEU05jLO2kk+gFquiK
        E0k2gViwBsNy9EIKLgiTOzwC9u2plMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629806700;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCkQsq0WCN+4UlXYY516S9PjlUNpzxgDb/+/yCJ+4UE=;
        b=E29NqGDUvuPGyumXpN6Ar0bF6fHp8YSpdv7YYzMr3fm4W0Ccd9ljcteW/ai9ekwigeWzIr
        g6WJe9AhFjFNm/Bg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 20F1A13A50;
        Tue, 24 Aug 2021 12:05:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id qETQBmzgJGHfIgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 24 Aug 2021 12:05:00 +0000
Message-ID: <a4df6392-68b6-ef4f-2ace-78c16b59016a@suse.cz>
Date:   Tue, 24 Aug 2021 14:04:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 3/4] mm: Kconfig: simplify zswap configuration
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitalywool@gmail.com>
References: <20210819195533.211756-1-hannes@cmpxchg.org>
 <20210819195533.211756-3-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210819195533.211756-3-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC zswap maintainers

On 8/19/21 21:55, Johannes Weiner wrote:
> Clean up option ordering; make prompts and help text more concise and
> actionable for non-developers; turn depends into selects where
> possible, so that users can simply select the functionality they want
> without having to chase down obscure code dependencies.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  drivers/block/zram/Kconfig |  3 ++-
>  mm/Kconfig                 | 53 ++++++++++++++++++--------------------
>  2 files changed, 27 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> index 668c6bf2554d..e4163d4b936b 100644
> --- a/drivers/block/zram/Kconfig
> +++ b/drivers/block/zram/Kconfig
> @@ -1,8 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config ZRAM
>  	tristate "Compressed RAM block device support"
> -	depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
> +	depends on BLOCK && SYSFS
>  	depends on CRYPTO_LZO || CRYPTO_ZSTD || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842
> +	select ZSMALLOC
>  	help
>  	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
>  	  Pages written to these disks are compressed and stored in memory
> diff --git a/mm/Kconfig b/mm/Kconfig
> index dbceaa2a04a4..62c6e6092a0a 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -21,9 +21,13 @@ menuconfig SWAP
>  
>  if SWAP
>  
> +config ZPOOL
> +	bool
> +
>  config ZSWAP
>  	bool "Compressed cache for swap pages (EXPERIMENTAL)"
> -	depends on FRONTSWAP && CRYPTO=y
> +	select FRONTSWAP
> +	select CRYPTO
>  	select ZPOOL
>  	help
>  	  A lightweight compressed cache for swap pages.  It takes
> @@ -39,8 +43,18 @@ config ZSWAP
>  	  they have not be fully explored on the large set of potential
>  	  configurations and workloads that exist.
>  
> +config ZSWAP_DEFAULT_ON
> +	bool "Enable the compressed cache for swap pages by default"
> +	depends on ZSWAP
> +	help
> +	  If selected, the compressed cache for swap pages will be enabled
> +	  at boot, otherwise it will be disabled.
> +
> +	  The selection made here can be overridden by using the kernel
> +	  command line 'zswap.enabled=' option.
> +
>  choice
> -	prompt "Compressed cache for swap pages default compressor"
> +	prompt "Default compressor"
>  	depends on ZSWAP
>  	default ZSWAP_COMPRESSOR_DEFAULT_LZO
>  	help
> @@ -106,7 +120,7 @@ config ZSWAP_COMPRESSOR_DEFAULT
>         default ""
>  
>  choice
> -	prompt "Compressed cache for swap pages default allocator"
> +	prompt "Default allocator"
>  	depends on ZSWAP
>  	default ZSWAP_ZPOOL_DEFAULT_ZBUD
>  	help
> @@ -146,24 +160,9 @@ config ZSWAP_ZPOOL_DEFAULT
>         default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
>         default ""
>  
> -config ZSWAP_DEFAULT_ON
> -	bool "Enable the compressed cache for swap pages by default"
> -	depends on ZSWAP
> -	help
> -	  If selected, the compressed cache for swap pages will be enabled
> -	  at boot, otherwise it will be disabled.
> -
> -	  The selection made here can be overridden by using the kernel
> -	  command line 'zswap.enabled=' option.
> -
> -config ZPOOL
> -	tristate "Common API for compressed memory storage"
> -	help
> -	  Compressed memory storage API.  This allows using either zbud or
> -	  zsmalloc.
> -
>  config ZBUD
> -	tristate "Low (Up to 2x) density storage for compressed pages"
> +	tristate "2:1 compression allocator (zbud)"
> +	depends on ZSWAP
>  	help
>  	  A special purpose allocator for storing compressed pages.
>  	  It is designed to store up to two compressed pages per physical
> @@ -172,8 +171,8 @@ config ZBUD
>  	  density approach when reclaim will be used.
>  
>  config Z3FOLD
> -	tristate "Up to 3x density storage for compressed pages"
> -	depends on ZPOOL
> +	tristate "3:1 compression allocator (z3fold)"
> +	depends on ZSWAP
>  	help
>  	  A special purpose allocator for storing compressed pages.
>  	  It is designed to store up to three compressed pages per physical
> @@ -181,15 +180,13 @@ config Z3FOLD
>  	  still there.
>  
>  config ZSMALLOC
> -	tristate "Memory allocator for compressed pages"
> +	tristate
> +	prompt "N:1 compression allocator (zsmalloc)" if ZSWAP
>  	depends on MMU
>  	help
>  	  zsmalloc is a slab-based memory allocator designed to store
> -	  compressed RAM pages.  zsmalloc uses virtual memory mapping
> -	  in order to reduce fragmentation.  However, this results in a
> -	  non-standard allocator interface where a handle, not a pointer, is
> -	  returned by an alloc().  This handle must be mapped in order to
> -	  access the allocated space.
> +	  pages of various compression levels efficiently. It achieves
> +	  the highest storage density with the least amount of fragmentation.
>  
>  config ZSMALLOC_STAT
>  	bool "Export zsmalloc statistics"
> 

