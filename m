Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44843399F96
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhFCLOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:14:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45354 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhFCLOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:14:11 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B9441FD4D;
        Thu,  3 Jun 2021 11:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622718746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Tg4eGxOYRMP7AnDXTIBqH4B03Wi9EvZGTT7BGEojbM=;
        b=JSHEoOkMX5hlsMiXdOMTr2MYMDFJVtoJBg+yrKiJrLxn7lNT2yXi0buxweriMDuYJG3Icq
        kQ3AsTXJRoGiwhtB6H1vRluTALn1/vtMxqhApGW3wwFPuSf26eGfIPOyCmHmDzU0hqVuhN
        jS4aTod+9jlFYIFFh1QWnyGdMCDgz8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622718746;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Tg4eGxOYRMP7AnDXTIBqH4B03Wi9EvZGTT7BGEojbM=;
        b=Qo2a+bEhRUMhMnZKIVV4eFd4zGVPhc/N/gVn178l5vRWIvU1+JCYhZdi8SwwDJalS808hv
        guofDRMZeGY0vZCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 64CEF118DD;
        Thu,  3 Jun 2021 11:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622718746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Tg4eGxOYRMP7AnDXTIBqH4B03Wi9EvZGTT7BGEojbM=;
        b=JSHEoOkMX5hlsMiXdOMTr2MYMDFJVtoJBg+yrKiJrLxn7lNT2yXi0buxweriMDuYJG3Icq
        kQ3AsTXJRoGiwhtB6H1vRluTALn1/vtMxqhApGW3wwFPuSf26eGfIPOyCmHmDzU0hqVuhN
        jS4aTod+9jlFYIFFh1QWnyGdMCDgz8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622718746;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Tg4eGxOYRMP7AnDXTIBqH4B03Wi9EvZGTT7BGEojbM=;
        b=Qo2a+bEhRUMhMnZKIVV4eFd4zGVPhc/N/gVn178l5vRWIvU1+JCYhZdi8SwwDJalS808hv
        guofDRMZeGY0vZCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 4oIbGBq5uGCecwAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Thu, 03 Jun 2021 11:12:26 +0000
Subject: Re: [PATCH 1/2] mm/page_alloc: Move free_the_page
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210603084621.24109-1-mgorman@techsingularity.net>
 <20210603084621.24109-2-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2ba608e9-f5b1-9f78-4734-17b5adb1256a@suse.cz>
Date:   Thu, 3 Jun 2021 13:12:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603084621.24109-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 10:46 AM, Mel Gorman wrote:
> In the next page, free_compount_page is going to use the common helper
> free_the_page. This patch moves the definition to ease review. No
> functional change.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4c468aa596aa..99ddac0ffece 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -687,6 +687,14 @@ static void bad_page(struct page *page, const char *reason)
>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  }
>  
> +static inline void free_the_page(struct page *page, unsigned int order)
> +{
> +	if (order == 0)		/* Via pcp? */
> +		free_unref_page(page);
> +	else
> +		__free_pages_ok(page, order, FPI_NONE);
> +}
> +
>  /*
>   * Higher-order pages are called "compound pages".  They are structured thusly:
>   *
> @@ -5345,14 +5353,6 @@ unsigned long get_zeroed_page(gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(get_zeroed_page);
>  
> -static inline void free_the_page(struct page *page, unsigned int order)
> -{
> -	if (order == 0)		/* Via pcp? */
> -		free_unref_page(page);
> -	else
> -		__free_pages_ok(page, order, FPI_NONE);
> -}
> -
>  /**
>   * __free_pages - Free pages allocated with alloc_pages().
>   * @page: The page pointer returned from alloc_pages().
> 

