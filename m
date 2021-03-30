Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B2734E46A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhC3J21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:28:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231897AbhC3J16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617096473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWiAbCS12K5/gwjFkwRosz2LP2JMA/qrMhM9SKRN5xY=;
        b=QmKTpahQ2SUOkwGXGa6f7S/ML8m50E8vn/pZAHl4t8ntzWS1iC8g8VCMj39FNgnSNoTVLm
        /jnUboyKKrCBOIthIglPIslANfiF+tnl4cpBD66w7x9ZL8soN2Z6Qh0lYoJL9QvWxvtXgC
        QmnVQ9pAgbdIrvnU467bSFGY9WGUs8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-We0EIDtHPj6WqFFIPDAyzw-1; Tue, 30 Mar 2021 05:27:49 -0400
X-MC-Unique: We0EIDtHPj6WqFFIPDAyzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E9B19CC0E;
        Tue, 30 Mar 2021 09:27:48 +0000 (UTC)
Received: from [10.36.114.210] (ovpn-114-210.ams2.redhat.com [10.36.114.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 688693AC0;
        Tue, 30 Mar 2021 09:27:47 +0000 (UTC)
Subject: Re: [PATCH] mm/ksm: remove unused parameter from
 remove_trailing_rmap_items()
To:     Chengyang Fan <cy.fan@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210330070808.1248087-1-cy.fan@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <af93ede2-99c1-c5b5-e45e-641b807992a9@redhat.com>
Date:   Tue, 30 Mar 2021 11:27:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330070808.1248087-1-cy.fan@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.21 09:08, Chengyang Fan wrote:
> Since commit 6514d511dbe5 ("ksm: singly-linked rmap_list") was
> merged, remove_trailing_rmap_items() doesn't use the 'mm_slot'
> parameter. So remove it, and update caller accordingly.
> 
> Signed-off-by: Chengyang Fan <cy.fan@huawei.com>
> ---
>   mm/ksm.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 9694ee2c71de..dd69f030c8c0 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -817,8 +817,7 @@ static void remove_rmap_item_from_tree(struct rmap_item *rmap_item)
>   	cond_resched();		/* we're called from many long loops */
>   }
>   
> -static void remove_trailing_rmap_items(struct mm_slot *mm_slot,
> -				       struct rmap_item **rmap_list)
> +static void remove_trailing_rmap_items(struct rmap_item **rmap_list)
>   {
>   	while (*rmap_list) {
>   		struct rmap_item *rmap_item = *rmap_list;
> @@ -989,7 +988,7 @@ static int unmerge_and_remove_all_rmap_items(void)
>   				goto error;
>   		}
>   
> -		remove_trailing_rmap_items(mm_slot, &mm_slot->rmap_list);
> +		remove_trailing_rmap_items(&mm_slot->rmap_list);
>   		mmap_read_unlock(mm);
>   
>   		spin_lock(&ksm_mmlist_lock);
> @@ -2337,7 +2336,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
>   	 * Nuke all the rmap_items that are above this current rmap:
>   	 * because there were no VM_MERGEABLE vmas with such addresses.
>   	 */
> -	remove_trailing_rmap_items(slot, ksm_scan.rmap_list);
> +	remove_trailing_rmap_items(ksm_scan.rmap_list);
>   
>   	spin_lock(&ksm_mmlist_lock);
>   	ksm_scan.mm_slot = list_entry(slot->mm_list.next,
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

