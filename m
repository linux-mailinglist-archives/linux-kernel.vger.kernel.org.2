Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE68730BBE0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhBBKOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:14:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbhBBKNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612260739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vD8PHPyil13+cFynwED/4DGpe6PkeJdZOFIJ/bAVG5k=;
        b=KznHSiayr/Mfx204Cv/JHLKeRix2EBy76GfnfHeWbIiUmVnHGpXarxpxyg2b+pTJlqLSCP
        RFeTm/OQjCuyVIZ1BjvwBEZyxB7oe6xuWqQcGoLpVN1Rgu3AHnz/nWy1UGOfjkpNe4dVmB
        2wt2hKE4cRXS1n8M+pPcQ/0bPHfbwmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-kfemGAIxMniu1GGx-XQtMQ-1; Tue, 02 Feb 2021 05:12:18 -0500
X-MC-Unique: kfemGAIxMniu1GGx-XQtMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC0D01005504;
        Tue,  2 Feb 2021 10:12:16 +0000 (UTC)
Received: from [10.36.114.148] (ovpn-114-148.ams2.redhat.com [10.36.114.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C9647216E;
        Tue,  2 Feb 2021 10:12:15 +0000 (UTC)
Subject: Re: [PATCH] mm/swap_slots.c: remove redundant NULL check
To:     Yang Li <abaci-bugfix@linux.alibaba.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1611214229-11225-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <56166666-4bbf-30b1-3f96-32fe972abc43@redhat.com>
Date:   Tue, 2 Feb 2021 11:12:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1611214229-11225-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.21 08:30, Yang Li wrote:
> Fix below warnings reported by coccicheck:
> ./mm/swap_slots.c:197:3-9: WARNING: NULL check before some freeing
> functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
> ---
>   mm/swap_slots.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 0357fbe..be9de6d 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -193,8 +193,7 @@ static void drain_slots_cache_cpu(unsigned int cpu, unsigned int type,
>   			cache->slots_ret = NULL;
>   		}
>   		spin_unlock_irq(&cache->free_lock);
> -		if (slots)
> -			kvfree(slots);
> +		kvfree(slots);
>   	}
>   }
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

