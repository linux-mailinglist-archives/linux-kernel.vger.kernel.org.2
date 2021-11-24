Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5953A45B8EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 12:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240716AbhKXLOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 06:14:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240066AbhKXLOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 06:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637752252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vpE3uP5Ts9fATTGHNvJfdwKZOAJEcAEIb3v/zQVqyQU=;
        b=Zsy3OLR/G26sZ0cPW2ODZBnRGdC/4bBHKj2gwyQfCuN2xe0y/zYuZ4f+pJPtQuQrT1LZIH
        mXMMe+vSC51yfAtgdrJnuNrfKg7FRzwMyQ49JJq+ynS8DYLRZWNgeoV4PhDqnn/UnuDf4i
        xZH2V+XrvL6yPYEGfhkapZqX3XFcDqw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-ZhJEHqlQMrOubed6yoDcmA-1; Wed, 24 Nov 2021 06:10:51 -0500
X-MC-Unique: ZhJEHqlQMrOubed6yoDcmA-1
Received: by mail-wm1-f72.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so2829654wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 03:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=vpE3uP5Ts9fATTGHNvJfdwKZOAJEcAEIb3v/zQVqyQU=;
        b=BDP2y6T4k6ivp43OMxLBS9d++OveiLIM+U6E1ylyPBW8H5SND8yFlanQ07pMkHnXL2
         QRXGhD6ErvfH0LApjVL9/UetBpdTMUXBwnjcfGarZ2q8jOF35HrkcQ3+jcrOdOjKj+Is
         DNTENXdzGbXyFTYY56cj7RVPWW5WwvEVv7iWa6aQmfpTGwiIOcpVTVgoOdQIwz6xhQvQ
         wLkid2abUgC1uwcJTNZ9o8PJ5u8Y9xXaHMgohDTlszHZFHT8Na1qGFHSGsqnE87sEMiD
         aIt7cwdLE+amAPTG+A3edWk3Z/aUZWc4YbOdMBeZ8lfF2lOyun9jV6Br5W8+N9uSnxuG
         S90g==
X-Gm-Message-State: AOAM531L5Z2gJzecaeXNownGDPUKy8LgruS3eNyellw9tjQpvuLH2l10
        x4MRVfF2FltuhAIE8OUJ2vmhvZ5f0Lu39LmJFwzqcobc5x8iamhIUkzSzq8n11IrOqkKBA0g31H
        NSJVEv/h9C4a8836PhVvTIy/9
X-Received: by 2002:a5d:4107:: with SMTP id l7mr17164663wrp.209.1637752250458;
        Wed, 24 Nov 2021 03:10:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/35pNqxIt/3x1nXEuvBK3BdN1xHIMOgL0EuPUrA8pSNn6Wr5VuEfMwehTjz1oqeOxyanzyw==
X-Received: by 2002:a5d:4107:: with SMTP id l7mr17164617wrp.209.1637752250154;
        Wed, 24 Nov 2021 03:10:50 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6380.dip0.t-ipconnect.de. [91.12.99.128])
        by smtp.gmail.com with ESMTPSA id 9sm19103331wry.0.2021.11.24.03.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 03:10:49 -0800 (PST)
Message-ID: <f106fc33-4935-6f07-3e93-35bfd0d2434d@redhat.com>
Date:   Wed, 24 Nov 2021 12:10:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mm: Use BUG_ON instead of if condition followed by BUG
Content-Language: en-US
To:     cgel.zte@gmail.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211124030849.34998-1-chi.minghao@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211124030849.34998-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.11.21 04:08, cgel.zte@gmail.com wrote:
> From: chiminghao <chi.minghao@zte.com.cn>

"mm/memory_hotplug: Use BUG_ON instead of if condition followed by BUG"

Would be better

> 
> Fix the following coccinelle report:
> ./mm/memory_hotplug.c:2210:2-5:
> WARNING  Use BUG_ON instead of if condition followed by BUG.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
> ---
>  mm/memory_hotplug.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 3de7933e5302..aecb12bb7513 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -2212,8 +2212,7 @@ void __remove_memory(u64 start, u64 size)
>  	 * trigger BUG() if some memory is not offlined prior to calling this
>  	 * function
>  	 */
> -	if (try_remove_memory(start, size))
> -		BUG();
> +	BUG_ON(try_remove_memory(start, size));
>  }
>  
>  /*
> 

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

