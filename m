Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA6634A968
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhCZORF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:17:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:43686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhCZORB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:17:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2F6FAC6A;
        Fri, 26 Mar 2021 14:17:00 +0000 (UTC)
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
References: <20210326112650.307890-1-slyfox@gentoo.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: page_alloc: ignore init_on_free=1 for page alloc
Message-ID: <6c4a20f3-16ab-3c6c-1d6d-4708db4e9ebf@suse.cz>
Date:   Fri, 26 Mar 2021 15:17:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210326112650.307890-1-slyfox@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 12:26 PM, Sergei Trofimovich wrote:
> init_on_free=1 does not guarantee that free pages contain only zero bytes.
> 
> Some examples:
> 1. page_poison=on takes presedence over init_on_alloc=1 / ini_on_free=1

Yes, and it spits out a message that you enabled both and poisoning takes
precedence. It was that way even before my changes IIRC, but not consistent.

> 2. free_pages_prepare() always poisons pages:
> 
>        if (want_init_on_free())
>            kernel_init_free_pages(page, 1 << order);
>        kernel_poison_pages(page, 1 << order

kernel_poison_pages() includes a test if poisoning is enabled. And in that case
want_init_on_free() shouldn't be. see init_mem_debugging_and_hardening()

> 
> I observed use of poisoned pages as the crash on ia64 booted with
> init_on_free=1 init_on_alloc=1 (CONFIG_PAGE_POISONING=y config).
> There pmd page contained 0xaaaaaaaa poison pages and led to early crash.

Hm but that looks lika a sign that ia64 pmd allocation should use __GFP_ZERO and
doesn't. It shouldn't rely on init_on_alloc or init_on_free being enabled.

> The change drops the assumption that init_on_free=1 guarantees free
> pages to contain zeros.

The change assumes that page_poison=on also leaves want_init_on_free() enabled,
but it doesn't.

> Alternative would be to make interaction between runtime poisoning and
> sanitizing options and build-time debug flags like CONFIG_PAGE_POISONING
> more coherent. I took the simpler path.

So that was done in 5.11 and the decisions can be seen in
init_mem_debugging_and_hardening(). There might be of course a bug, or later
changes broke something. Which was the version that you observed a bug?

> Tested the fix on rx3600.
> 
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: linux-mm@kvack.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cfc72873961d..d57d9b4f7089 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2301,7 +2301,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  	kernel_unpoison_pages(page, 1 << order);
>  	set_page_owner(page, order, gfp_flags);
>  
> -	if (!want_init_on_free() && want_init_on_alloc(gfp_flags))
> +	if (want_init_on_alloc(gfp_flags))
>  		kernel_init_free_pages(page, 1 << order);
>  }
>  
> 

