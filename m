Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1363D45709A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhKSO2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:28:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45926 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhKSO2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:28:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3469C1FD3C;
        Fri, 19 Nov 2021 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637331939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wm4Uvhu20tXaQ171tTZLKuWEI2LRkW51/Udm0dRJZLw=;
        b=jR4fBVfaVLhGUw7EBI2Dm+Hmb0AIpBox1nopYMYHCSO3w7yA/q+z+nvoLNIny7wSs1klRv
        Ukpgp2Brd6rNLiOrOHD13Ok16QEYT0Dp+n8XUBAEpxXbrx3jlB2YLvcf9KdFwVgI1D9byW
        4uKxsU4F6yh/aE4FNp0p8JLgH7rNH3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637331939;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wm4Uvhu20tXaQ171tTZLKuWEI2LRkW51/Udm0dRJZLw=;
        b=z7Nm9cDrvv4lAfHuK1UCFe1FDRp8/ENWMtXaeK/DkFvZcBIhhgS6GRaxqB3IIPB40PvTPR
        mtuG0VaffaM87XDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F07F013B32;
        Fri, 19 Nov 2021 14:25:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jOxIOeKzl2GuAQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 19 Nov 2021 14:25:38 +0000
Message-ID: <48c8a614-5338-4381-8b1b-5c0962bed8b0@suse.cz>
Date:   Fri, 19 Nov 2021 15:25:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/2] kasan: add ability to detect
 double-kmem_cache_destroy()
Content-Language: en-US
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20211119142219.1519617-1-elver@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211119142219.1519617-1-elver@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/21 15:22, Marco Elver wrote:
> Because mm/slab_common.c is not instrumented with software KASAN modes,
> it is not possible to detect use-after-free of the kmem_cache passed
> into kmem_cache_destroy(). In particular, because of the s->refcount--
> and subsequent early return if non-zero, KASAN would never be able to
> see the double-free via kmem_cache_free(kmem_cache, s). To be able to
> detect a double-kmem_cache_destroy(), check accessibility of the
> kmem_cache, and in case of failure return early.
> 
> While KASAN_HW_TAGS is able to detect such bugs, by checking
> accessibility and returning early we fail more gracefully and also
> avoid corrupting reused objects (where tags mismatch).
> 
> A recent case of a double-kmem_cache_destroy() was detected by KFENCE:
> https://lkml.kernel.org/r/0000000000003f654905c168b09d@google.com
> , which was not detectable by software KASAN modes.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slab_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e5d080a93009..4bef4b6a2c76 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -491,7 +491,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  {
>  	int err;
>  
> -	if (unlikely(!s))
> +	if (unlikely(!s || !kasan_check_byte(s)))
>  		return;
>  
>  	cpus_read_lock();
> 

