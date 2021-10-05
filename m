Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9CD4222ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhJEJ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:59:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39724 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbhJEJ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:59:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60D55223BB;
        Tue,  5 Oct 2021 09:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633427863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRWNNjHGGhrCYYyeUxzn4qH1ns33EY4uqx/qy+c8tD4=;
        b=zmNpd1LPU+i6LV/vk/jaPKsic6J7OavgFVXgg47zkc4+sYi2aurkO6BeZs622F8YoVft9K
        OShcKd4081TDebr+33MfokPn+p02LD3pcEooAmtnzuBl88aAcAY87pVU01t0r11YV1Levq
        7LpGiWgVDP84ks6iQqN8D+H1Pa56jFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633427863;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRWNNjHGGhrCYYyeUxzn4qH1ns33EY4uqx/qy+c8tD4=;
        b=8h9LNLWMJ//vEFu3Mkf1RG2jWiciK2vadOyQzVvNlsSeCA4Y+DIBcwORYKITH76DIG5dta
        PqXu+hHmuvko9lAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2264913C23;
        Tue,  5 Oct 2021 09:57:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6DhsB5chXGFqEQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 05 Oct 2021 09:57:43 +0000
Message-ID: <3b0351d3-4753-1d69-a115-60b20c69656c@suse.cz>
Date:   Tue, 5 Oct 2021 11:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 2/5] mm, slub: fix mismatch between reconstructed freelist
 depth and cnt
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com
Cc:     gregkh@linuxfoundation.org, faiyazm@codeaurora.org,
        andreyknvl@gmail.com, ryabinin.a.a@gmail.com, thgarnie@google.com,
        keescook@chromium.org, bharata@linux.ibm.com, guro@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210916123920.48704-1-linmiaohe@huawei.com>
 <20210916123920.48704-3-linmiaohe@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210916123920.48704-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 14:39, Miaohe Lin wrote:
> If object's reuse is delayed, it will be excluded from the reconstructed
> freelist. But we forgot to adjust the cnt accordingly. So there will be
> a mismatch between reconstructed freelist depth and cnt. This will lead
> to free_debug_processing() complain about freelist count or a incorrect
> slub inuse count.
> 
> Fixes: c3895391df38 ("kasan, slub: fix handling of kasan_slab_free hook")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

I was worried about taking pointer of the cnt parameter when it's hardcoded
1, whether it would destroy inlining. Looks like not, luckily, the function
is just renamed:

> ./scripts/bloat-o-meter mm/slub.o slub.o.after
add/remove: 1/1 grow/shrink: 0/0 up/down: 292/-292 (0)
Function                                     old     new   delta
slab_free_freelist_hook.constprop              -     292    +292
slab_free_freelist_hook                      292       -    -292

> ---
>  mm/slub.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ed160b6c54f8..a56a6423d4e8 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1701,7 +1701,8 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
>  }
>  
>  static inline bool slab_free_freelist_hook(struct kmem_cache *s,
> -					   void **head, void **tail)
> +					   void **head, void **tail,
> +					   int *cnt)
>  {
>  
>  	void *object;
> @@ -1728,6 +1729,12 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>  			*head = object;
>  			if (!*tail)
>  				*tail = object;
> +		} else {
> +			/*
> +			 * Adjust the reconstructed freelist depth
> +			 * accordingly if object's reuse is delayed.
> +			 */
> +			--(*cnt);
>  		}
>  	} while (object != old_tail);
>  
> @@ -3480,7 +3487,7 @@ static __always_inline void slab_free(struct kmem_cache *s, struct page *page,
>  	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
>  	 * to remove objects, whose reuse must be delayed.
>  	 */
> -	if (slab_free_freelist_hook(s, &head, &tail))
> +	if (slab_free_freelist_hook(s, &head, &tail, &cnt))
>  		do_slab_free(s, page, head, tail, cnt, addr);
>  }
>  
> 

