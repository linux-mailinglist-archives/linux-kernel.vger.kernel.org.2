Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC87451C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348063AbhKPAPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:15:19 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52368 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351031AbhKOXD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:03:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA4CD21940;
        Mon, 15 Nov 2021 23:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637017229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tv2l7OmgBO3VNlOr+5wFoFOCDao3ZEdQfNhQzSu6PEs=;
        b=v+bP61DlGlDBVOJVwTx1Atz/noWtGyuFU1RgyRzTJqgXWaot/o8is0KaJzf/H7yn9Yb+7n
        yRxuSuAYJpEG/zUh66gc3du/rPgcsKmyflID5TjaGeoRR8y7nI4gUerWcx/dNxH4qGx+BM
        DIwr3QhhM/mlwTBI+74qPj+JPBKgRaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637017229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tv2l7OmgBO3VNlOr+5wFoFOCDao3ZEdQfNhQzSu6PEs=;
        b=s1qts7AuCC141sp/2w356DtJzFjWb344g/z4fle7N0P82MrA9VFpil21vTL1utXOpExIVU
        b4dooB4CqWjMgmAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A16613B26;
        Mon, 15 Nov 2021 23:00:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id at+dFI3mkmG/QgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 15 Nov 2021 23:00:29 +0000
Message-ID: <93376a9d-681c-b8e2-0aae-031ae036789e@suse.cz>
Date:   Tue, 16 Nov 2021 00:00:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mm: kmemleak: slob: respect SLAB_NOLEAKTRACE flag
Content-Language: en-US
To:     Rustam Kovhaev <rkovhaev@gmail.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        gregkh@linuxfoundation.org
References: <20211115020850.3154366-1-rkovhaev@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211115020850.3154366-1-rkovhaev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 03:08, Rustam Kovhaev wrote:
> When kmemleak is enabled for SLOB, system does not boot and does not
> print anything to the console. At the very early stage in the boot
> process we hit infinite recursion from kmemleak_init() and eventually
> kernel crashes.
> kmemleak_init() specifies SLAB_NOLEAKTRACE for KMEM_CACHE(), but
> kmem_cache_create_usercopy() removes it because CACHE_CREATE_MASK is not
> valid for SLOB.
> Let's fix CACHE_CREATE_MASK and make kmemleak work with SLOB
> 
> Fixes: d8843922fba4 ("slab: Ignore internal flags in cache creation")
> Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 58c01a34e5b8..56ad7eea3ddf 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -147,7 +147,7 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
>  #define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE | SLAB_RECLAIM_ACCOUNT | \
>  			  SLAB_TEMPORARY | SLAB_ACCOUNT)
>  #else
> -#define SLAB_CACHE_FLAGS (0)
> +#define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE)
>  #endif
>  
>  /* Common flags available with current configuration */
> 

