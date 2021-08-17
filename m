Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6187A3EE984
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbhHQJUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:20:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33590 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbhHQJSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:18:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9FD8D21AC4;
        Tue, 17 Aug 2021 09:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629191877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcHJOHB9hxwBX95Lq5+fSvyv0D1B8TQkgzP6Tk5EsGg=;
        b=Q1Ue4lmU8mSpZvw1jtNZcNdEjWJ6LtxZEWl1Yuas6TTDZltMyaivB+tgvo/T6NxxAt1ZAP
        K4k08RVwAVpU87Z1J1lAQsmeVXF1UZ2si4CvF0JZS0U1nQW/EPxORvzKlOWQzZhHe8uKwq
        tOcR3TKjclfz/LV/HYh2dqHx0ek5ebU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629191877;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcHJOHB9hxwBX95Lq5+fSvyv0D1B8TQkgzP6Tk5EsGg=;
        b=fmKxYivOY6uxbdXwnLHlF4/urCoLuB7rk5gMhM5bW0KV2l/PByOYtmeqe8r8iKvM5JzJel
        N8WtNzm39EQIyeAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C11FE13D26;
        Tue, 17 Aug 2021 09:17:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5PsCLcR+G2FFTwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Aug 2021 09:17:56 +0000
Subject: Re: [PATCH v4 35/35] mm, slub: convert kmem_cpu_slab protection to
 local_lock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Sven Eckelmann <sven@narfation.org>, akpm@linux-foundation.org,
        brouer@redhat.com, cl@linux.com, efault@gmx.de,
        iamjoonsoo.kim@lge.com, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, penberg@kernel.org,
        rientjes@google.com, tglx@linutronix.de,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>
References: <2666777.vCjUEy5FO1@sven-desktop>
 <7329198a-2a4e-ebc2-abf8-f7f38f00d5e1@suse.cz>
 <20210817091224.nqnrro34cyb67chj@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b1e88f8a-ddf1-67d2-52a3-9e57eac01406@suse.cz>
Date:   Tue, 17 Aug 2021 11:17:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210817091224.nqnrro34cyb67chj@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/21 11:12 AM, Sebastian Andrzej Siewior wrote:
> On 2021-08-17 10:37:48 [+0200], Vlastimil Babka wrote:
>> OK reproduced. Thanks, will investigate.
> 
> With the local_lock at the top, the needed alignment gets broken for dbl
> cmpxchg. On RT it was working ;)

I'd rather have page and partial in the same cacheline as well, is it ok
to just move the lock as last and not care about whether it straddles
cachelines or not? (with CONFIG_SLUB_CPU_PARTIAL it will naturally start
with the next cacheline).

> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index b5bcac29b979c..cd14aa1f9bc3c 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -42,9 +42,9 @@ enum stat_item {
>  	NR_SLUB_STAT_ITEMS };
>  
>  struct kmem_cache_cpu {
> -	local_lock_t lock;	/* Protects the fields below except stat */
>  	void **freelist;	/* Pointer to next available object */
>  	unsigned long tid;	/* Globally unique transaction id */
> +	local_lock_t lock;	/* Protects the fields below except stat */
>  	struct page *page;	/* The slab from which we are allocating */
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  	struct page *partial;	/* Partially allocated frozen slabs */
> 
> Sebastian
> 

