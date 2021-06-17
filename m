Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0696D3AACDB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFQHBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:01:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:18011 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhFQHBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:01:42 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G5CbV4X8kzBDx3;
        Thu, 17 Jun 2021 08:59:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LWQ9nsdPA2gf; Thu, 17 Jun 2021 08:59:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G5CbV3ZxXzBDwb;
        Thu, 17 Jun 2021 08:59:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E9478B803;
        Thu, 17 Jun 2021 08:59:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2IndrkMHscKX; Thu, 17 Jun 2021 08:59:34 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 93D628B801;
        Thu, 17 Jun 2021 08:59:33 +0200 (CEST)
Subject: Re: [PATCH v14 2/4] kasan: allow architectures to provide an outline
 readiness check
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
References: <20210617063956.94061-1-dja@axtens.net>
 <20210617063956.94061-3-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1a8960b7-fcaa-3649-1e8f-01911112209c@csgroup.eu>
Date:   Thu, 17 Jun 2021 08:59:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617063956.94061-3-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/06/2021 à 08:39, Daniel Axtens a écrit :
> Allow architectures to define a kasan_arch_is_ready() hook that bails
> out of any function that's about to touch the shadow unless the arch
> says that it is ready for the memory to be accessed. This is fairly
> uninvasive and should have a negligible performance penalty.
> 
> This will only work in outline mode, so an arch must specify
> ARCH_DISABLE_KASAN_INLINE if it requires this.
> 
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> --
> 
> Both previous RFCs for ppc64 - by 2 different people - have
> needed this trick! See:
>   - https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
>   - https://patchwork.ozlabs.org/patch/795211/      # ppc radix series
> 
> I haven't been able to exercise the arch hook error for !GENERIC as I
> don't have a particularly modern aarch64 toolchain or a lot of experience
> cross-compiling with clang. But it does fire for GENERIC + INLINE on x86.
> ---
>   mm/kasan/common.c  | 4 ++++
>   mm/kasan/generic.c | 3 +++
>   mm/kasan/kasan.h   | 8 ++++++++
>   mm/kasan/shadow.c  | 8 ++++++++
>   4 files changed, 23 insertions(+)
> 
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8f450bc28045..b18abaf8c78e 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -449,6 +449,14 @@ static inline void kasan_poison_last_granule(const void *address, size_t size) {
>   
>   #endif /* CONFIG_KASAN_GENERIC */
>   
> +#ifndef kasan_arch_is_ready
> +static inline bool kasan_arch_is_ready(void)	{ return true; }
> +#else
> +#if !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
> +#error kasan_arch_is_ready only works in KASAN generic outline mode!
> +#endif
> +#endif

Would be cleaner and more readable as

+#ifndef kasan_arch_is_ready
+static inline bool kasan_arch_is_ready(void)	{ return true; }
+#elif !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
+#error kasan_arch_is_ready only works in KASAN generic outline mode!
+#endif

> +
>   /*
>    * Exported functions for interfaces called from assembly or from generated
>    * code. Declarations here to avoid warning about missing declarations.
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 082ee5b6d9a1..3c7f7efe6f68 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -73,6 +73,10 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
>   {
>   	void *shadow_start, *shadow_end;
>   
> +	/* Don't touch the shadow memory if arch isn't ready */
> +	if (!kasan_arch_is_ready())
> +		return;
> +
>   	/*
>   	 * Perform shadow offset calculation based on untagged address, as
>   	 * some of the callers (e.g. kasan_poison_object_data) pass tagged
> @@ -99,6 +103,10 @@ EXPORT_SYMBOL(kasan_poison);
>   #ifdef CONFIG_KASAN_GENERIC
>   void kasan_poison_last_granule(const void *addr, size_t size)
>   {
> +	/* Don't touch the shadow memory if arch isn't ready */
> +	if (!kasan_arch_is_ready())
> +		return;
> +
>   	if (size & KASAN_GRANULE_MASK) {
>   		u8 *shadow = (u8 *)kasan_mem_to_shadow(addr + size);
>   		*shadow = size & KASAN_GRANULE_MASK;
> 
