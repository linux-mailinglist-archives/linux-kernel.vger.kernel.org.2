Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57ECA3F5D48
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbhHXLrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:47:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43228 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbhHXLrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:47:53 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 29514220DF;
        Tue, 24 Aug 2021 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629805629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7CGzf9FJOzjRTBuWlM6TaHEz3xnmJ9+L7ISqNo4hB0A=;
        b=YT8AxCBRWrdZTy0Hfsu2JT4y3vK2TeGh2pJKlGIhsGkJTkb7jc74nP4ugMdCH846BPI+LE
        peUG0ieY1yRIEO4ojF6YHINdWaqtEFKRwRKVPfDDG1D9RexHJ71usfqQPThUI/idZANTRk
        Oj1eCLjLHAAUcxU2+P2rY6tHepgnu0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629805629;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7CGzf9FJOzjRTBuWlM6TaHEz3xnmJ9+L7ISqNo4hB0A=;
        b=IjZ0KmtgMH9247YoIjO3QaOxZS70AnMfvK/obgnHSA3F0tBrmFhEzWp/hVtp3BaEWJy9oo
        sOwLS59vxZeWRhBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 08F2313A50;
        Tue, 24 Aug 2021 11:47:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id yu/HAD3cJGFFHwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 24 Aug 2021 11:47:09 +0000
Message-ID: <5a440ea3-da45-49d9-f3c6-de7be31f69bb@suse.cz>
Date:   Tue, 24 Aug 2021 13:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/4] mm: Kconfig: move swap and slab config options to the
 MM section
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20210819195533.211756-1-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210819195533.211756-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/21 21:55, Johannes Weiner wrote:
> These are currently under General Setup. MM seems like a better fit.

Right. I've been also wondering about that occasionally.

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  init/Kconfig | 120 ---------------------------------------------------
>  mm/Kconfig   | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+), 120 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index a61c92066c2e..a2358cd5498a 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -331,23 +331,6 @@ config DEFAULT_HOSTNAME
>  	  but you may wish to use a different default here to make a minimal
>  	  system more usable with less configuration.
>  
> -#
> -# For some reason microblaze and nios2 hard code SWAP=n.  Hopefully we can
> -# add proper SWAP support to them, in which case this can be remove.
> -#
> -config ARCH_NO_SWAP
> -	bool
> -
> -config SWAP
> -	bool "Support for paging of anonymous memory (swap)"
> -	depends on MMU && BLOCK && !ARCH_NO_SWAP
> -	default y
> -	help
> -	  This option allows you to choose whether you want to have support
> -	  for so called swap devices or swap files in your kernel that are
> -	  used to provide more virtual memory than the actual RAM present
> -	  in your computer.  If unsure say Y.
> -
>  config SYSVIPC
>  	bool "System V IPC"
>  	help
> @@ -1862,109 +1845,6 @@ config COMPAT_BRK
>  
>  	  On non-ancient distros (post-2000 ones) N is usually a safe choice.
>  
> -choice
> -	prompt "Choose SLAB allocator"
> -	default SLUB
> -	help
> -	   This option allows to select a slab allocator.
> -
> -config SLAB
> -	bool "SLAB"
> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> -	help
> -	  The regular slab allocator that is established and known to work
> -	  well in all environments. It organizes cache hot objects in
> -	  per cpu and per node queues.
> -
> -config SLUB
> -	bool "SLUB (Unqueued Allocator)"
> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> -	help
> -	   SLUB is a slab allocator that minimizes cache line usage
> -	   instead of managing queues of cached objects (SLAB approach).
> -	   Per cpu caching is realized using slabs of objects instead
> -	   of queues of objects. SLUB can use memory efficiently
> -	   and has enhanced diagnostics. SLUB is the default choice for
> -	   a slab allocator.
> -
> -config SLOB
> -	depends on EXPERT
> -	bool "SLOB (Simple Allocator)"
> -	help
> -	   SLOB replaces the stock allocator with a drastically simpler
> -	   allocator. SLOB is generally more space efficient but
> -	   does not perform as well on large systems.
> -
> -endchoice
> -
> -config SLAB_MERGE_DEFAULT
> -	bool "Allow slab caches to be merged"
> -	default y
> -	help
> -	  For reduced kernel memory fragmentation, slab caches can be
> -	  merged when they share the same size and other characteristics.
> -	  This carries a risk of kernel heap overflows being able to
> -	  overwrite objects from merged caches (and more easily control
> -	  cache layout), which makes such heap attacks easier to exploit
> -	  by attackers. By keeping caches unmerged, these kinds of exploits
> -	  can usually only damage objects in the same cache. To disable
> -	  merging at runtime, "slab_nomerge" can be passed on the kernel
> -	  command line.
> -
> -config SLAB_FREELIST_RANDOM
> -	bool "Randomize slab freelist"
> -	depends on SLAB || SLUB
> -	help
> -	  Randomizes the freelist order used on creating new pages. This
> -	  security feature reduces the predictability of the kernel slab
> -	  allocator against heap overflows.
> -
> -config SLAB_FREELIST_HARDENED
> -	bool "Harden slab freelist metadata"
> -	depends on SLAB || SLUB
> -	help
> -	  Many kernel heap attacks try to target slab cache metadata and
> -	  other infrastructure. This options makes minor performance
> -	  sacrifices to harden the kernel slab allocator against common
> -	  freelist exploit methods. Some slab implementations have more
> -	  sanity-checking than others. This option is most effective with
> -	  CONFIG_SLUB.
> -
> -config SHUFFLE_PAGE_ALLOCATOR
> -	bool "Page allocator randomization"
> -	default SLAB_FREELIST_RANDOM && ACPI_NUMA
> -	help
> -	  Randomization of the page allocator improves the average
> -	  utilization of a direct-mapped memory-side-cache. See section
> -	  5.2.27 Heterogeneous Memory Attribute Table (HMAT) in the ACPI
> -	  6.2a specification for an example of how a platform advertises
> -	  the presence of a memory-side-cache. There are also incidental
> -	  security benefits as it reduces the predictability of page
> -	  allocations to compliment SLAB_FREELIST_RANDOM, but the
> -	  default granularity of shuffling on the "MAX_ORDER - 1" i.e,
> -	  10th order of pages is selected based on cache utilization
> -	  benefits on x86.
> -
> -	  While the randomization improves cache utilization it may
> -	  negatively impact workloads on platforms without a cache. For
> -	  this reason, by default, the randomization is enabled only
> -	  after runtime detection of a direct-mapped memory-side-cache.
> -	  Otherwise, the randomization may be force enabled with the
> -	  'page_alloc.shuffle' kernel command line parameter.
> -
> -	  Say Y if unsure.
> -
> -config SLUB_CPU_PARTIAL
> -	default y
> -	depends on SLUB && SMP
> -	bool "SLUB per cpu partial cache"
> -	help
> -	  Per cpu partial caches accelerate objects allocation and freeing
> -	  that is local to a processor at the price of more indeterminism
> -	  in the latency of the free. On overflow these caches will be cleared
> -	  which requires the taking of locks that may cause latency spikes.
> -	  Typically one would choose no for a realtime system.
> -
>  config MMAP_ALLOW_UNINITIALIZED
>  	bool "Allow mmapped anonymous memory to be uninitialized"
>  	depends on EXPERT && !MMU
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 02d44e3420f5..894858536e7f 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -2,6 +2,126 @@
>  
>  menu "Memory Management options"
>  
> +#
> +# For some reason microblaze and nios2 hard code SWAP=n.  Hopefully we can
> +# add proper SWAP support to them, in which case this can be remove.
> +#
> +config ARCH_NO_SWAP
> +	bool
> +
> +config SWAP
> +	bool "Support for paging of anonymous memory (swap)"
> +	depends on MMU && BLOCK && !ARCH_NO_SWAP
> +	default y
> +	help
> +	  This option allows you to choose whether you want to have support
> +	  for so called swap devices or swap files in your kernel that are
> +	  used to provide more virtual memory than the actual RAM present
> +	  in your computer.  If unsure say Y.
> +
> +choice
> +	prompt "Choose SLAB allocator"
> +	default SLUB
> +	help
> +	   This option allows to select a slab allocator.
> +
> +config SLAB
> +	bool "SLAB"
> +	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> +	help
> +	  The regular slab allocator that is established and known to work
> +	  well in all environments. It organizes cache hot objects in
> +	  per cpu and per node queues.
> +
> +config SLUB
> +	bool "SLUB (Unqueued Allocator)"
> +	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> +	help
> +	   SLUB is a slab allocator that minimizes cache line usage
> +	   instead of managing queues of cached objects (SLAB approach).
> +	   Per cpu caching is realized using slabs of objects instead
> +	   of queues of objects. SLUB can use memory efficiently
> +	   and has enhanced diagnostics. SLUB is the default choice for
> +	   a slab allocator.
> +
> +config SLOB
> +	depends on EXPERT
> +	bool "SLOB (Simple Allocator)"
> +	help
> +	   SLOB replaces the stock allocator with a drastically simpler
> +	   allocator. SLOB is generally more space efficient but
> +	   does not perform as well on large systems.
> +
> +endchoice
> +
> +config SLAB_MERGE_DEFAULT
> +	bool "Allow slab caches to be merged"
> +	default y
> +	help
> +	  For reduced kernel memory fragmentation, slab caches can be
> +	  merged when they share the same size and other characteristics.
> +	  This carries a risk of kernel heap overflows being able to
> +	  overwrite objects from merged caches (and more easily control
> +	  cache layout), which makes such heap attacks easier to exploit
> +	  by attackers. By keeping caches unmerged, these kinds of exploits
> +	  can usually only damage objects in the same cache. To disable
> +	  merging at runtime, "slab_nomerge" can be passed on the kernel
> +	  command line.
> +
> +config SLAB_FREELIST_RANDOM
> +	bool "Randomize slab freelist"
> +	depends on SLAB || SLUB
> +	help
> +	  Randomizes the freelist order used on creating new pages. This
> +	  security feature reduces the predictability of the kernel slab
> +	  allocator against heap overflows.
> +
> +config SLAB_FREELIST_HARDENED
> +	bool "Harden slab freelist metadata"
> +	depends on SLAB || SLUB
> +	help
> +	  Many kernel heap attacks try to target slab cache metadata and
> +	  other infrastructure. This options makes minor performance
> +	  sacrifices to harden the kernel slab allocator against common
> +	  freelist exploit methods. Some slab implementations have more
> +	  sanity-checking than others. This option is most effective with
> +	  CONFIG_SLUB.
> +
> +config SHUFFLE_PAGE_ALLOCATOR
> +	bool "Page allocator randomization"
> +	default SLAB_FREELIST_RANDOM && ACPI_NUMA
> +	help
> +	  Randomization of the page allocator improves the average
> +	  utilization of a direct-mapped memory-side-cache. See section
> +	  5.2.27 Heterogeneous Memory Attribute Table (HMAT) in the ACPI
> +	  6.2a specification for an example of how a platform advertises
> +	  the presence of a memory-side-cache. There are also incidental
> +	  security benefits as it reduces the predictability of page
> +	  allocations to compliment SLAB_FREELIST_RANDOM, but the
> +	  default granularity of shuffling on the "MAX_ORDER - 1" i.e,
> +	  10th order of pages is selected based on cache utilization
> +	  benefits on x86.
> +
> +	  While the randomization improves cache utilization it may
> +	  negatively impact workloads on platforms without a cache. For
> +	  this reason, by default, the randomization is enabled only
> +	  after runtime detection of a direct-mapped memory-side-cache.
> +	  Otherwise, the randomization may be force enabled with the
> +	  'page_alloc.shuffle' kernel command line parameter.
> +
> +	  Say Y if unsure.
> +
> +config SLUB_CPU_PARTIAL
> +	default y
> +	depends on SLUB && SMP
> +	bool "SLUB per cpu partial cache"
> +	help
> +	  Per cpu partial caches accelerate objects allocation and freeing
> +	  that is local to a processor at the price of more indeterminism
> +	  in the latency of the free. On overflow these caches will be cleared
> +	  which requires the taking of locks that may cause latency spikes.
> +	  Typically one would choose no for a realtime system.
> +
>  config SELECT_MEMORY_MODEL
>  	def_bool y
>  	depends on ARCH_SELECT_MEMORY_MODEL
> 

