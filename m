Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99E23E5867
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbhHJKeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:34:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56516 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238459AbhHJKeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:34:01 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7DB281FE44;
        Tue, 10 Aug 2021 10:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628591618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAQoIZsBJEm9hLtA8ITp/B5urIAxXGex8VLAt9nLDSQ=;
        b=UApo4WB49B/TjENSV8mpLEPciUl4P5R8IAJpY6a+tn1Yr2nRyqfE+uwIOIozK/NtFyDTyu
        rjfxHQUX9BM3WxfgfUXsRUJMY4+s5XthQfzqwB/m1JN4UZiVMZEH4tXegbGSTH4IVo/L7F
        h7TekDlmds3Dln+MC/ZlRC3t7QaiQ3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628591618;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAQoIZsBJEm9hLtA8ITp/B5urIAxXGex8VLAt9nLDSQ=;
        b=H9lwcWJueILBUCjO2xnm0Wtz8EgeEsE508D+MGkjMaztnVMm8avBTHlfMFd5hH8xnmvWpF
        qQBr1PF2pLwrqXAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 585E0133D0;
        Tue, 10 Aug 2021 10:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id jEHlFAJWEmGMeAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 10 Aug 2021 10:33:38 +0000
Subject: Re: [PATCH] highmem: Don't disable preemption on RT in kmap_atomic()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210810091116.pocdmaatdcogvdso@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1458fa2b-d46c-98e9-510a-31e37469914a@suse.cz>
Date:   Tue, 10 Aug 2021 12:33:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810091116.pocdmaatdcogvdso@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 11:11 AM, Sebastian Andrzej Siewior wrote:
> kmap_atomic() disables preemption and pagefaults for historical
> reasons. The conversion to kmap_local(), which only disables
> migration, cannot be done wholesale because quite some call sites need
> to be updated to accommodate with the changed semantics.
> 
> On PREEMPT_RT enabled kernels the kmap_atomic() semantics are
> problematic due to the implicit disabling of preemption which makes it
> impossible to acquire 'sleeping' spinlocks within the kmap atomic
> sections.
> 
> PREEMPT_RT replaces the preempt_disable() with a migrate_disable() for
> more than a decade. It could be argued that this is a justification to
> do this unconditionally, but PREEMPT_RT covers only a limited number of
> architectures and it disables some functionality which limits the
> coverage further.
> 
> Limit the replacement to PREEMPT_RT for now.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Note I use the same pattern in my SLUB series, but for performance reasons
(migrate_disable() is an unconditional function call etc). But I can guess what
would be the answer if I suggested this pattern to get a common shared wrapper,
so I won't :P

> ---
>  include/linux/highmem-internal.h | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index 7902c7d8b55f9..4aa1031d3e4c3 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -90,7 +90,11 @@ static inline void __kunmap_local(void *vaddr)
>  
>  static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
>  {
> -	preempt_disable();
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		migrate_disable();
> +	else
> +		preempt_disable();
> +
>  	pagefault_disable();
>  	return __kmap_local_page_prot(page, prot);
>  }
> @@ -102,7 +106,11 @@ static inline void *kmap_atomic(struct page *page)
>  
>  static inline void *kmap_atomic_pfn(unsigned long pfn)
>  {
> -	preempt_disable();
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		migrate_disable();
> +	else
> +		preempt_disable();
> +
>  	pagefault_disable();
>  	return __kmap_local_pfn_prot(pfn, kmap_prot);
>  }
> @@ -111,7 +119,10 @@ static inline void __kunmap_atomic(void *addr)
>  {
>  	kunmap_local_indexed(addr);
>  	pagefault_enable();
> -	preempt_enable();
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		migrate_enable();
> +	else
> +		preempt_enable();
>  }
>  
>  unsigned int __nr_free_highpages(void);
> @@ -179,7 +190,10 @@ static inline void __kunmap_local(void *addr)
>  
>  static inline void *kmap_atomic(struct page *page)
>  {
> -	preempt_disable();
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		migrate_disable();
> +	else
> +		preempt_disable();
>  	pagefault_disable();
>  	return page_address(page);
>  }
> @@ -200,7 +214,10 @@ static inline void __kunmap_atomic(void *addr)
>  	kunmap_flush_on_unmap(addr);
>  #endif
>  	pagefault_enable();
> -	preempt_enable();
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		migrate_enable();
> +	else
> +		preempt_enable();
>  }
>  
>  static inline unsigned int nr_free_highpages(void) { return 0; }
> 

