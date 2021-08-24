Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49BC3F627D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhHXQNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:13:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42092 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhHXQNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:13:43 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E773622114;
        Tue, 24 Aug 2021 16:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629821577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLqt1sJCjtHeRT1hMjT3Qa89LnenIkk+XF2NTSNgPfw=;
        b=CDZDWY1gKpWFXIuZ+ZtioFff0Bxqmq0D04eJO5mgcr1yz2YShGruWRGeL0+fCvT2TnNdrW
        e+A+1V7CB33QYJCpfl7EI8I+rnYTw54I53QtDvh0nV8vvXUJ4G03nKt1XSZS9XdLF1fL/W
        nWFtjNVcHWGnwxGnVt6aC3ZlLwz14bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629821577;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLqt1sJCjtHeRT1hMjT3Qa89LnenIkk+XF2NTSNgPfw=;
        b=ZdT1ggIplj4rN8+1m5btYrAKGxrc8jLM+fL6Hj4ob/eJuaUmlrC2BmRX+asNQis45mmoct
        4jZX6pYT3ANAdfAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A4E6F13A5B;
        Tue, 24 Aug 2021 16:12:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 8u0dJ4gaJWHiVwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 24 Aug 2021 16:12:56 +0000
Message-ID: <de84f992-752c-fe40-0cf5-02c1cb7bea78@suse.cz>
Date:   Tue, 24 Aug 2021 18:12:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [RFC PATCH 3/4] mm/page_alloc: introduce __GFP_PTE_MAPPED flag to
 allocate pte-mapped pages
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210823132513.15836-1-rppt@kernel.org>
 <20210823132513.15836-4-rppt@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210823132513.15836-4-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/21 15:25, Mike Rapoport wrote:
> @@ -3283,5 +3283,7 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +void pte_mapped_cache_init(void);
> +
>  #endif /* __KERNEL__ */
>  #endif /* _LINUX_MM_H */
> diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
> index 973fd731a520..4faf8c542b00 100644
> --- a/include/linux/pageblock-flags.h
> +++ b/include/linux/pageblock-flags.h
> @@ -21,6 +21,8 @@ enum pageblock_bits {
>  			/* 3 bits required for migrate types */
>  	PB_migrate_skip,/* If set the block is skipped by compaction */
>  
> +	PB_pte_mapped, /* If set the block is mapped with PTEs in direct map */
> +
>  	/*
>  	 * Assume the bits will always align on a word. If this assumption
>  	 * changes then get/set pageblock needs updating.

You have broken this assumption :)
> @@ -536,7 +558,7 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
>  	unsigned long bitidx, word_bitidx;
>  	unsigned long old_word, word;
>  
> -	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
> +	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 5);

This is not sufficient to satisfy the "needs updating" part. We would now need
NR_PAGEBLOCK_BITS == 8.
