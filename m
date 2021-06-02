Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E33984D3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhFBJDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230145AbhFBJDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622624512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njnWJTDlbIZm6prQ7E30GXwheWyUoE2xiy3Ax+zybeA=;
        b=gPWv9jxWLeONdCcecwIHYnJ5y0TvHQv7kCt/2xrhsBEHmuuDWYZl1nTfp8am/l7tfd/uEc
        sXQQulSJbIVcTvGWTm2WulurHAiIgwx9hxoINKCbOVaUm/svGfKxfwDj9e9HUJU8AIqVv3
        eIrkuS06jRXk5jkREsIbgJhHghFa6BM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-6XVtIL1QM2-c6E-4vCSllg-1; Wed, 02 Jun 2021 05:01:51 -0400
X-MC-Unique: 6XVtIL1QM2-c6E-4vCSllg-1
Received: by mail-wr1-f69.google.com with SMTP id f22-20020a5d58f60000b029011634e39889so735549wrd.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 02:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=njnWJTDlbIZm6prQ7E30GXwheWyUoE2xiy3Ax+zybeA=;
        b=C5Io0UDzXbGbQ4Yfg70AzzZKdtOkZFdnb8v67bdtfv1JgMEGEJpGQPIZi0xhrVEIas
         0lIPzLUctvJTTebeeEkWk45o4QdIVbF8dH8pJ7S3eeL4XGbZSV2dMaRwCo7zOCrZ56i1
         gML7h8jYTqlilzIlf6awjr/8yIJQHZnQLrGaXhjAfNCqYzZywGYx9GEOlU2piI0lvHD1
         C/F8Izx2miDQ94b/36J62+ETo9AkhVn7QYwmN8GbLWZUjI+BXiP67a4b8sKclKRxxaot
         83jBdvvEUX/k2AcwpCcnxV4N/GxKYzKa3cdkA1PbXUt6cGBofu7glTWVq4xUEKQEOjlL
         U3/w==
X-Gm-Message-State: AOAM533HEWnXxR75y7eOn6AtOArFpbcTUC+I9r/YhDYWKZ98t+QeWtaB
        ObB+9/2omxETUt1uXaBzXiQcVEfuoYaicbF3GQ6PGH8ME4leg7ZcGSLbWJnET8iU+xXkS4GptVI
        dl7F6ms9OAPN27NjUgCXu2IyT
X-Received: by 2002:adf:ce90:: with SMTP id r16mr25980516wrn.146.1622624510125;
        Wed, 02 Jun 2021 02:01:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNVBmXAyq37FqDobGkcDp4OJuhWbvV0DTLa/PhMfqGvVUJbx2BhUaiURI8cN1Anujmf0Glyw==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr25980499wrn.146.1622624509984;
        Wed, 02 Jun 2021 02:01:49 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6b6d.dip0.t-ipconnect.de. [91.12.107.109])
        by smtp.gmail.com with ESMTPSA id s8sm7204322wrr.36.2021.06.02.02.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 02:01:49 -0700 (PDT)
Subject: Re: [PATCH 2/2] mm,memory_hotplug: print the min alignment in
 check_pfn_span
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        logang@deltatee.com
References: <20210602084752.3534-1-mgurtovoy@nvidia.com>
 <20210602084752.3534-2-mgurtovoy@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <adcc88c9-6e75-07a1-2d3d-7fa4bda88137@redhat.com>
Date:   Wed, 2 Jun 2021 11:01:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602084752.3534-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.21 10:47, Max Gurtovoy wrote:
> The warning only prints the start and end pfns. Add min_align to the
> warning print to add more info regarding the failure.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   mm/memory_hotplug.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8c3b423c1141..9e86e9ee0a10 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -289,8 +289,8 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>   	else
>   		min_align = PAGES_PER_SECTION;
>   	if (!IS_ALIGNED(pfn, min_align) || !IS_ALIGNED(nr_pages, min_align)) {
> -		WARN(1, "Misaligned __%s_pages start: %#lx end: %#lx\n",
> -		     reason, pfn, pfn + nr_pages - 1);
> +		WARN(1, "Misaligned __%s_pages min_align: %#lx start: %#lx end: %#lx\n",
> +		     reason, min_align, pfn, pfn + nr_pages - 1);
>   		return -EINVAL;
>   	}
>   	return 0;
> 

Not sure if we really care. I expect only developers will run into that 
hacking on something new, and they will have to dig deeper either way.

While at it, I'd suggest converting this to pr_warn(), as WARN() is 
frowned upon as it can crash the kernel with panic_on_warn as set by 
some distros.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

