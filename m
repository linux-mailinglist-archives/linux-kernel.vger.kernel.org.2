Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8142140AEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 15:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhINNLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 09:11:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39940 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhINNLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 09:11:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 58CB9220F9;
        Tue, 14 Sep 2021 13:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631624982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ToQgPqXFhXn24AFdoHNLcJdrXS2GGWSJfWpLbEnTLm8=;
        b=mn6W7skUkKMXhcDVe9ION+lu/bqTUGFF/SmN8+RHcgLfyEzo3BPMxAnJkCiQOaGXyA785U
        pJsAllnu9Gg3A/Zy3ysWNkSVQi3h4eXKnKGRRO9Rd83mNMeotVyx8sglYehn9QYQ11qfq5
        zR7uJMrqvlkp0s5iNCiAIuh8fEOoRb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631624982;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ToQgPqXFhXn24AFdoHNLcJdrXS2GGWSJfWpLbEnTLm8=;
        b=1XRMyWMKXp2dsSRk3WFBve6Te9kH3HBWnfjXcp5MTLAVhc83IQKffrQmoNgnHwHy7DjIPZ
        VqrjpG10rGEV9pAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35D5B13B88;
        Tue, 14 Sep 2021 13:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KhKJDBafQGGJRAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Sep 2021 13:09:42 +0000
Message-ID: <6d27e47b-66da-4a51-fa16-056e3ab2eedf@suse.cz>
Date:   Tue, 14 Sep 2021 15:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3] mm/page_isolation: guard against possible putback
 unisolated page
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     david@redhat.com, jhubbard@nvidia.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210914114508.23725-1-linmiaohe@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210914114508.23725-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/21 13:45, Miaohe Lin wrote:
> Isolating a free page in an isolated pageblock is expected to always work
> as watermarks don't apply here. But if __isolate_free_page() failed, due
> to condition changes, the page will be left on the free list. And the page
> will be put back to free list again via __putback_isolated_page(). This may
> trigger VM_BUG_ON_PAGE() on page->flags checking in __free_one_page() if
> PageReported is set. Or we will corrupt the free list because list_add()
> will be called for pages already on another list. Add a VM_WARN_ON() to
> complain about this change.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> v1->v2:
>   Add VM_WARN_ON to catch unexpected isolating failure.
> v2->v3:
>   Change the patch description+subject and remove Fixes.
> ---
>  mm/page_isolation.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index f93cc63d8fa1..f67c4c70f17f 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -94,8 +94,13 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>  			buddy = page + (buddy_pfn - pfn);
>  
>  			if (!is_migrate_isolate_page(buddy)) {
> -				__isolate_free_page(page, order);
> -				isolated_page = true;
> +				isolated_page = !!__isolate_free_page(page, order);
> +				/*
> +				 * Isolating a free page in an isolated pageblock
> +				 * is expected to always work as watermarks don't
> +				 * apply here.
> +				 */
> +				VM_WARN_ON(!isolated_page);
>  			}
>  		}
>  	}
> 

