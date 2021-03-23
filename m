Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D131345BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCWKYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229836AbhCWKX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616495039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLZ5nMEJ4tec7irmbW0K+juMgN+jQFrKCu8kDdRqTRs=;
        b=iprKI4929KTE0cyxaLbcVnbmdjbYMxUdYi7hLJchMxmxie+k4k/hnfCY4vGQI6WB7rsWvQ
        RyKRugw67JrDT7OTEmK1xL4eVIcOEurl5p8q6fpvhtE13Hg1c+925J4yS0bmeVPJQT/f1H
        S4bzq7lpEXS13xLCxauN18S2pmNNDpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-SVjAu0dwMkmQxUsQ-RPp5Q-1; Tue, 23 Mar 2021 06:23:57 -0400
X-MC-Unique: SVjAu0dwMkmQxUsQ-RPp5Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE5958015BD;
        Tue, 23 Mar 2021 10:23:55 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 939CA59452;
        Tue, 23 Mar 2021 10:23:54 +0000 (UTC)
Subject: Re: [PATCH 2/5] mm/migrate.c: remove unnecessary rc !=
 MIGRATEPAGE_SUCCESS check in 'else' case
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     jglisse@redhat.com, shy828301@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210320093701.12829-1-linmiaohe@huawei.com>
 <20210320093701.12829-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <db2547db-5510-1fb6-9714-670b3fa18a39@redhat.com>
Date:   Tue, 23 Mar 2021 11:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210320093701.12829-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.21 10:36, Miaohe Lin wrote:
> It's guaranteed that in the 'else' case of the rc == MIGRATEPAGE_SUCCESS
> check, rc does not equal to MIGRATEPAGE_SUCCESS. Remove this unnecessary
> check.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/migrate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e4ca5ef508ea..20a3bf75270a 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1374,7 +1374,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>   out:
>   	if (rc == MIGRATEPAGE_SUCCESS)
>   		putback_active_hugepage(hpage);
> -	else if (rc != -EAGAIN && rc != MIGRATEPAGE_SUCCESS)
> +	else if (rc != -EAGAIN)
>   		list_move_tail(&hpage->lru, ret);
>   
>   	/*
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

