Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0E53FED82
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbhIBMKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:10:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49670 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343985AbhIBMKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:10:11 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 774AA2034E;
        Thu,  2 Sep 2021 12:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630584551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYZpsfq6AVlzLfpcEqifrWBELjivdYHFpOH84L0ZLXQ=;
        b=EJRH8W+p/m6uqdDMja7FOt44cgsMXcmX234zofIjn0ZyqFPP4Y/li8+avvoURuhM50A1XB
        /bnDisnVVHBQLXf1dSkEXVN87UwwjlUbUKOkFgr3lPWYXv3o8Kq6EgGM0Ol1YZKlZiwwe7
        CSULrO4PqjOIUD7CkI3ouabTR1DoxKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630584551;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYZpsfq6AVlzLfpcEqifrWBELjivdYHFpOH84L0ZLXQ=;
        b=guJ2NYobLeNN/a6z/K5U+meE3gXsmEPHBnGib93e1WLppGLVGY94oBEIiszCoxoqdAfP0S
        xdpzrLrEzcK1YrDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5432613732;
        Thu,  2 Sep 2021 12:09:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id /OBIE+e+MGGwfwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 02 Sep 2021 12:09:11 +0000
Message-ID: <dc9fa24b-cd9e-fb7c-047b-75d7e5cb0c1e@suse.cz>
Date:   Thu, 2 Sep 2021 14:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v2] mm/page_alloc.c: avoid accessing uninitialized pcp
 page migratetype
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     peterz@infradead.org, mgorman@techsingularity.net,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210902115447.57050-1-linmiaohe@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210902115447.57050-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 13:54, Miaohe Lin wrote:
> If it's not prepared to free unref page, the pcp page migratetype is
> unset. Thus We will get rubbish from get_pcppage_migratetype() and
> might list_del &page->lru again after it's already deleted from the
> list leading to grumble about data corruption.
> 
> Fixes: df1acc856923 ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Cc: <stable@vger.kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9c09dcb24149..a3c6acafa478 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3420,8 +3420,10 @@ void free_unref_page_list(struct list_head *list)
>  	/* Prepare pages for freeing */
>  	list_for_each_entry_safe(page, next, list, lru) {
>  		pfn = page_to_pfn(page);
> -		if (!free_unref_page_prepare(page, pfn, 0))
> +		if (!free_unref_page_prepare(page, pfn, 0)) {
>  			list_del(&page->lru);
> +			continue;
> +		}
>  
>  		/*
>  		 * Free isolated pages directly to the allocator, see
> 

