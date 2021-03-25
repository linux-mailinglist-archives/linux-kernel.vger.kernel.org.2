Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B31F3492F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhCYNSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231136AbhCYNSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616678302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uSM6XsoCExKe4rLBLCAD8bfv90jOFRgqC0PeCEkln9I=;
        b=ZzSAdBbgU+owxcKbG7FNQzhbEW7soZXbmTDD0otZc5kNOB+bX/amZSjC2NzzEO5Q6D3u46
        qn698I3m3brxBUERkijP1wuQygSwhA4feQ2xKdKC036c9TWLG70gl51cMHFnf5Gzjyad01
        i/ezEI8R0z+bDRjLgzJnEf253ujzqbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-Djy4CsTBNNiX3Lo24tAg5g-1; Thu, 25 Mar 2021 09:18:18 -0400
X-MC-Unique: Djy4CsTBNNiX3Lo24tAg5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2975994F1A;
        Thu, 25 Mar 2021 13:17:19 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEC605D9CA;
        Thu, 25 Mar 2021 13:17:16 +0000 (UTC)
Subject: Re: [PATCH v3 1/5] mm/migrate.c: make putback_movable_page() static
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     jglisse@redhat.com, shy828301@gmail.com, aquini@redhat.com,
        apopple@nvidia.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210325131524.48181-1-linmiaohe@huawei.com>
 <20210325131524.48181-2-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f1fbfe7e-74ac-e60c-b984-ab4c03445d07@redhat.com>
Date:   Thu, 25 Mar 2021 14:17:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210325131524.48181-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.21 14:15, Miaohe Lin wrote:
> The putback_movable_page() is just called by putback_movable_pages() and
> we know the page is locked and both PageMovable() and PageIsolated() is
> checked right before calling putback_movable_page(). So we make it static
> and remove all the 3 VM_BUG_ON_PAGE().
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   include/linux/migrate.h | 1 -
>   mm/migrate.c            | 7 +------
>   2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index fdf65f23acec..1d8095069b1c 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -44,7 +44,6 @@ extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
>   		unsigned long private, enum migrate_mode mode, int reason);
>   extern struct page *alloc_migration_target(struct page *page, unsigned long private);
>   extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
> -extern void putback_movable_page(struct page *page);
>   
>   extern void migrate_prep(void);
>   extern void migrate_prep_local(void);
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 47df0df8f21a..61e7f848b554 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -140,15 +140,10 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
>   	return -EBUSY;
>   }
>   
> -/* It should be called on page which is PG_movable */
> -void putback_movable_page(struct page *page)
> +static void putback_movable_page(struct page *page)
>   {
>   	struct address_space *mapping;
>   
> -	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	VM_BUG_ON_PAGE(!PageMovable(page), page);
> -	VM_BUG_ON_PAGE(!PageIsolated(page), page);
> -
>   	mapping = page_mapping(page);
>   	mapping->a_ops->putback_page(page);
>   	__ClearPageIsolated(page);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

