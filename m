Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549133F4734
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhHWJQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:16:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35748 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhHWJQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:16:23 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 695F021E30;
        Mon, 23 Aug 2021 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629710140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwz7ZVM9+zz4C9vi+jtjj4eUPvRpsQp2HFYv2dz4ENQ=;
        b=VVxUy4js0bImYmnlsLav7yFPRCnIvpxQONjK4yPuwJ+qieZQbfxMqds4ZPcR68tF97SFTs
        b5/SMfezCg1CfGU/cGe6TIqoT1XCyVEPKADgASeWLLsrVSChMR46JFotQCgE/hSeD7JaCA
        dy1SIf/AKjbfflvpXm9sVXUwytUh3ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629710140;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwz7ZVM9+zz4C9vi+jtjj4eUPvRpsQp2HFYv2dz4ENQ=;
        b=uLV08PrJO4WMgJ1g2mMe4OjtqnqvExfSv7S3pFhYnEE4yDSQUtZogv7+H9/kayWMjyEhVM
        xJBbqRHcxzRlOkDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5DD2C13A92;
        Mon, 23 Aug 2021 09:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id uV+pFjxnI2F1bQAAGKfGzw
        (envelope-from <osalvador@suse.de>); Mon, 23 Aug 2021 09:15:40 +0000
MIME-Version: 1.0
Date:   Mon, 23 Aug 2021 11:15:40 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        mhocko@suse.com, minchan@kernel.org, cgoldswo@codeaurora.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/memory_hotplug: fix potential permanent lru cache
 disable
In-Reply-To: <20210821094246.10149-3-linmiaohe@huawei.com>
References: <20210821094246.10149-1-linmiaohe@huawei.com>
 <20210821094246.10149-3-linmiaohe@huawei.com>
User-Agent: Roundcube Webmail
Message-ID: <f42d89e40a604944dbefe0b729c1a685@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-21 11:42, Miaohe Lin wrote:
> If offline_pages failed after lru_cache_disable(), it forgot to do
> lru_cache_enable() in error path. So we would have lru cache disabled
> permanently in this case.
> 
> Fixes: d479960e44f2 ("mm: disable LRU pagevec during the migration 
> temporarily")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Should this go to stable?
In case we fail to enable it again, we will bypass the pvec cache 
anytime we add a new page to the LRU which might lead to severe 
performance regression?

> ---
>  mm/memory_hotplug.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index d986d3791986..9fd0be32a281 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -2033,6 +2033,7 @@ int __ref offline_pages(unsigned long start_pfn,
> unsigned long nr_pages,
>  	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
>  	memory_notify(MEM_CANCEL_OFFLINE, &arg);
>  failed_removal_pcplists_disabled:
> +	lru_cache_enable();
>  	zone_pcp_enable(zone);
>  failed_removal:
>  	pr_debug("memory offlining [mem %#010llx-%#010llx] failed due to 
> %s\n",

-- 
Oscar Salvador
SUSE L3
