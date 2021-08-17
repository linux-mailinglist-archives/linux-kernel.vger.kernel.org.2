Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9423EE9EF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhHQJdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:33:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35534 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbhHQJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:33:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5A10621DF7;
        Tue, 17 Aug 2021 09:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629192756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J27QbjsN89ukN+TPv/Yz4fAGneJrqaWAet+7YsBbiqQ=;
        b=1dRcIUB+LqODIrzX8P6kAvT7FXl8zWFVaINvGes9qvux3FmKE0P50q1kQ5Bglpghk3j0j2
        sp6Y8e144ldHIOV++B7BsfLE5ZNBxNXEPOLPxyuB6xTkzBwTUkjIaYQPnjz8V4Zx0sM1FA
        wKGrSnvEvIQY0ODCrmaX407LI4A/ddk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629192756;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J27QbjsN89ukN+TPv/Yz4fAGneJrqaWAet+7YsBbiqQ=;
        b=eWnYWRfyqexr3GcZQ+/fW4Q3l0L5iJCEAxHz+fTXU94OtlwObGwGQWGn9LxcePQf0Qz00D
        EtJbbp2QOnAsolDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DDA313D26;
        Tue, 17 Aug 2021 09:32:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l0yCGzOCG2HaUwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Aug 2021 09:32:35 +0000
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
Message-ID: <3da13f0a-2720-a38c-33a7-744668013390@suse.cz>
Date:   Tue, 17 Aug 2021 11:31:56 +0200
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
> cmpxchg.

Right. I wondered why the checks in __pcpu_double_call_return_bool
didn't trigger. They are VM_BUG_ON() so they did trigger after enabling
DEBUG_VM.

> 
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

