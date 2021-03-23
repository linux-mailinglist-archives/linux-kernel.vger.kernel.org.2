Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B06346172
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhCWO1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232129AbhCWO1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616509639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DIxwh79zPLwHGUGDrqcLjesEnHFkUQgilSVBipYKhCw=;
        b=HjMB7RcaMRz70Zoi9VgcprWFj3wQUGim2EpIp9BWzQNVKn82LLnpFah+skchSQJsYNUHK7
        zgeS7CJd/+KtlV6iYDXBJHE93njHaj1G4T6OsW4XiNMBVtSat70cnf26cD8P2M4MXHlOAP
        n++0CInIlC2SCEwwkBxRRX9WV9jR0as=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-6i6RmrVTMmedm_5mnsaAdQ-1; Tue, 23 Mar 2021 10:27:18 -0400
X-MC-Unique: 6i6RmrVTMmedm_5mnsaAdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA7D1108BD06;
        Tue, 23 Mar 2021 14:27:16 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03E73196E3;
        Tue, 23 Mar 2021 14:27:14 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] mm/migrate.c: remove unnecessary VM_BUG_ON_PAGE on
 putback_movable_page()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     jglisse@redhat.com, shy828301@gmail.com, aquini@redhat.com,
        apopple@nvidia.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210323135405.65059-1-linmiaohe@huawei.com>
 <20210323135405.65059-2-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0017dfc4-05a4-1989-59dc-3f34f7b3517c@redhat.com>
Date:   Tue, 23 Mar 2021 15:27:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323135405.65059-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.21 14:54, Miaohe Lin wrote:
> The !PageLocked() check is implicitly done in PageMovable(). Remove this
> explicit one.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/migrate.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 47df0df8f21a..facec65c7374 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -145,7 +145,6 @@ void putback_movable_page(struct page *page)
>   {
>   	struct address_space *mapping;
>   
> -	VM_BUG_ON_PAGE(!PageLocked(page), page);
>   	VM_BUG_ON_PAGE(!PageMovable(page), page);
>   	VM_BUG_ON_PAGE(!PageIsolated(page), page);
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

