Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957E43FD613
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243360AbhIAI7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:59:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51588 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243362AbhIAI7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:59:21 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9C3D2224F7;
        Wed,  1 Sep 2021 08:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630486704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYk0l+EdwreY98ZhJQynz+aInvTJ1n/sBiNgZ6uBg9I=;
        b=dyQ2tadrZ364NOrfIoza+rII+plniVQnP7o5fg5O8ngtD1M4I0kczC4pc3uUI2Yf/Twlx3
        f1f7rJUyN/6lWX2G+Oi4QUJYG4dwDhmoMINQ5Jtqu9FVOOQRRmzQ7JNBqAAdu0dEfWoVZU
        HCobDkoL/BH18ne/nkYHJYLQuZF6iTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630486704;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYk0l+EdwreY98ZhJQynz+aInvTJ1n/sBiNgZ6uBg9I=;
        b=Mp875vo8Z7xDqBoOjqlZoAsTuRd/uTGeGsMhX0AFffQrABujV/y5XYoZIAEhGSy5YamCW7
        ttRw5DLuinrs60Aw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7E80F13A41;
        Wed,  1 Sep 2021 08:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 7GeqHbBAL2E3EwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 01 Sep 2021 08:58:24 +0000
Message-ID: <78d24243-9d92-43fd-92b5-17b88cc24314@suse.cz>
Date:   Wed, 1 Sep 2021 10:58:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Content-Language: en-US
To:     Imran Khan <imran.f.khan@oracle.com>, geert@linux-m68k.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>
References: <20210901051914.971603-1-imran.f.khan@oracle.com>
 <20210901051914.971603-2-imran.f.khan@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 1/2] lib, stackdepot: check stackdepot handle before
 accessing slabs.
In-Reply-To: <20210901051914.971603-2-imran.f.khan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC linux-mm, Alex

On 9/1/21 07:19, Imran Khan wrote:
> stack_depot_save allocates slabs that will be used for storing
> objects in future.If this slab allocation fails we may get to
> a situation where space allocation for a new stack_record fails,
> causing stack_depot_save to return 0 as handle.
> If user of this handle ends up invoking stack_depot_fetch with
> this handle value, current implementation of stack_depot_fetch
> will end up using slab from wrong index.
> To avoid this check handle value at the beginning.
> Also issue a warning for nil handle values and when slab allocation
> for stackdepot fails for the first time.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>

Agree but without the warnings please, especially the "stack depot handle is
absent" one. It's just something that can happen e.g. in GFP_NOWAIT contexts
and no need to spam dmesg.

> ---
>  lib/stackdepot.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 0a2e417f83cb..1d42ef9ef766 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -232,6 +232,10 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>  	struct stack_record *stack;
>  
>  	*entries = NULL;
> +	if (!handle) {
> +		WARN(1, "stack depot handle is absent.\n");
> +		return 0;
> +	}
>  	if (parts.slabindex > depot_index) {
>  		WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
>  			parts.slabindex, depot_index, handle);
> @@ -303,6 +307,8 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>  		page = alloc_pages(alloc_flags, STACK_ALLOC_ORDER);
>  		if (page)
>  			prealloc = page_address(page);
> +		else
> +			WARN_ONCE(1, "slab allocation for stack depot failed.\n");
>  	}
>  
>  	raw_spin_lock_irqsave(&depot_lock, flags);
> 

