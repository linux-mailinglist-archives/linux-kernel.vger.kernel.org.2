Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509D04223A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhJEKiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:38:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44848 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbhJEKiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:38:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1F2F2223D4;
        Tue,  5 Oct 2021 10:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633430177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDN9V/BeLKiMrD/NI8A/rmkR0bzQ+C++6QXeRdaaYE0=;
        b=oA3nljbIC/pdvSjSnrz7YNsY0WuV1FIdyTQeaopxKgA6982NbAlTK5yNADNxfiQp6kOgju
        p2JE2R4TF8RDIEvhpjbQ9qcqZ9NToZmRmSkHeUQUOXl2XpT7mKr0uJNg1N1ymfyFYiQLLg
        jSKEL/c1AOLFPiKl/E1nIufeEeDV//8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633430177;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDN9V/BeLKiMrD/NI8A/rmkR0bzQ+C++6QXeRdaaYE0=;
        b=71FMYGcWvcmw0sGzEsYP4E1jrTuz5NfQBhdP/YnVwklCYQlb6FUWz5Fj+D2mOCjYbJoCLp
        yK2/E3sch7y7HnBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA02313C2B;
        Tue,  5 Oct 2021 10:36:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b3cYMKAqXGHcIwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 05 Oct 2021 10:36:16 +0000
Message-ID: <81ba4693-2928-931c-ab92-17359277f018@suse.cz>
Date:   Tue, 5 Oct 2021 12:36:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 4/5] mm, slub: fix potential use-after-free in
 slab_debugfs_fops
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com
Cc:     gregkh@linuxfoundation.org, faiyazm@codeaurora.org,
        andreyknvl@gmail.com, ryabinin.a.a@gmail.com, thgarnie@google.com,
        keescook@chromium.org, bharata@linux.ibm.com, guro@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210916123920.48704-1-linmiaohe@huawei.com>
 <20210916123920.48704-5-linmiaohe@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210916123920.48704-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 14:39, Miaohe Lin wrote:
> When sysfs_slab_add failed, we shouldn't call debugfs_slab_add() for s
> because s will be freed soon. And slab_debugfs_fops will use s later
> leading to a use-after-free.
> 
> Fixes: 64dd68497be7 ("mm: slub: move sysfs slab alloc/free interfaces to debugfs")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index bf1793fb4ce5..f3df0f04a472 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4887,13 +4887,15 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
>  		return 0;
>  
>  	err = sysfs_slab_add(s);
> -	if (err)
> +	if (err) {
>  		__kmem_cache_release(s);
> +		return err;
> +	}
>  
>  	if (s->flags & SLAB_STORE_USER)
>  		debugfs_slab_add(s);
>  
> -	return err;
> +	return 0;
>  }
>  
>  void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
> 

