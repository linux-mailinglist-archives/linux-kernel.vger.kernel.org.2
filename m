Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2143A3892C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354163AbhESPju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:39:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:51854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhESPjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:39:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47B2EAEF8;
        Wed, 19 May 2021 15:38:28 +0000 (UTC)
Subject: Re: [PATCH] mm, page_alloc: really disable DEBUG_PAGEALLOC with
 hibernation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Akinobu Mita <akinobu.mita@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Guilherme Piccoli <gpiccoli@canonical.com>
References: <20210519152804.27063-1-krzysztof.kozlowski@canonical.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <892e685f-004b-88db-b1e6-a05c0c84b43a@suse.cz>
Date:   Wed, 19 May 2021 17:38:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519152804.27063-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 5:28 PM, Krzysztof Kozlowski wrote:
> The documentation of DEBUG_PAGEALLOC states that it cannot be used with
> hibernation, however the Kconfig entry would allow it if
> ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC.
> 
> Fixes: ee3b4290aec0 ("generic debug pagealloc: build fix")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Hmm the documentation seems wrong, as going through history it was indeed in
conflict only on PPC and SPARC.

> ---
>  mm/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 1e73717802f8..0ace5b2a9d04 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -11,7 +11,7 @@ config PAGE_EXTENSION
>  config DEBUG_PAGEALLOC
>  	bool "Debug page memory allocations"
>  	depends on DEBUG_KERNEL
> -	depends on !HIBERNATION || ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC
> +	depends on !HIBERNATION && ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC
>  	select PAGE_POISONING if !ARCH_SUPPORTS_DEBUG_PAGEALLOC
>  	help
>  	  Unmap pages from the kernel linear mapping after free_pages().
> 

