Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC543E40F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 09:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhHIHmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 03:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233467AbhHIHmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 03:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628494952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rpTchTW2WHBbp1FKZwjHPai3s4d7skP1b3ls4uFFkQM=;
        b=VOMQEzhr9grrnoTBTxRICfIpqMVHm8yvO2nxzJvBZMLEhjXc3E7KbcJIfMKmVEXnuBqiZ9
        AYtQHVKC15CoTGkp4CNRQeqccgBgE+f1K1ppzDRedIkMO89vMQ1vvV48O9CAP51S7OuxFv
        rczKIFfdSryWYJstljIZuUCorH7Ffpg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-Q7RPeezcP8epFNQAXxi9qA-1; Mon, 09 Aug 2021 03:42:29 -0400
X-MC-Unique: Q7RPeezcP8epFNQAXxi9qA-1
Received: by mail-wr1-f72.google.com with SMTP id z1-20020adfdf810000b0290154f7f8c412so168337wrl.21
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 00:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rpTchTW2WHBbp1FKZwjHPai3s4d7skP1b3ls4uFFkQM=;
        b=HmUc1UGEhnCS7prnb0ZuSQpvQLbHBmAZSr3tq38YHKbEUuaIvB5Q6AeMP4j/shBfID
         Vd3tCm/RHqQm4Wk69G5caeoV/V2kKXqdcfrPuhC6pe0CHzJTcgvBfvT9J7m/0zIYoAAT
         8PUkadJqT0t9R6efGt0Q6Lstl/nwTh9XDIOv3THyrKUciPjoiUksKxaq691wCrftq9Rv
         5yq2zQ0sW6p/5zfIwNdnXvdzJYAL+gnsQbc+Y1j1wEGy5n+7laXdnllGkyX+Jxlq1ggh
         ZtUNSGq+41LOdIlUeT64Vl17+Uw9mMKb8YFVxrR9RZLfWobGjGWYf1cUWuFnHDVFSt2/
         GRZA==
X-Gm-Message-State: AOAM530lfxrCb29rKBwu3u4RdwsWUpkNjdbeIimRnO+J8ll7lzgA8HoE
        iWKpy7bdfszg3jUP8napMCqIGtYkVVsPwB8Y8lVP/5rL/npd00yhH9gpNIb8yOO3Ts95S4s10XY
        hMGr1BhmVQ1dFQxy45jiRnhTO
X-Received: by 2002:a5d:4a50:: with SMTP id v16mr785820wrs.77.1628494948483;
        Mon, 09 Aug 2021 00:42:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxIs0Mx3OKFD9xz5+nORNxkQlRcKGJL37rseXuAmlE7FZXZNGrGWmsWEyh3ihAd2BaJSF+0Q==
X-Received: by 2002:a5d:4a50:: with SMTP id v16mr785813wrs.77.1628494948372;
        Mon, 09 Aug 2021 00:42:28 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id a11sm4453865wrw.67.2021.08.09.00.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 00:42:28 -0700 (PDT)
Subject: Re: [RFC PATCH 10/15] virtio: virtio_balloon: use PAGES_PER_SECTION
 instead of MAX_ORDER_NR_PAGES.
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <20210805190253.2795604-11-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3e27818c-970d-7138-0258-928274bf294e@redhat.com>
Date:   Mon, 9 Aug 2021 09:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805190253.2795604-11-zi.yan@sent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.21 21:02, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It keeps the existing behavior when MAX_ORDER grows beyond a section.
> 

... but it breaks/changes existing behavior if MAX_ORDER is smaller than 
a section?

> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/virtio/virtio_balloon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 47dce91f788c..de8d0355d827 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -36,7 +36,7 @@
>   #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWARN | \
>   					     __GFP_NOMEMALLOC)
>   /* The order of free page blocks to report to host */
> -#define VIRTIO_BALLOON_HINT_BLOCK_ORDER (MAX_ORDER - 1)
> +#define VIRTIO_BALLOON_HINT_BLOCK_ORDER (PFN_SECTION_SHIFT - 1)
>   /* The size of a free page block in bytes */
>   #define VIRTIO_BALLOON_HINT_BLOCK_BYTES \
>   	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
> 


-- 
Thanks,

David / dhildenb

