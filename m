Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9BB435D59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhJUIyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230269AbhJUIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634806256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TMKCQhzyCZoKip7jkhipm5coeXVlUYjq8hHmo56D0kM=;
        b=MVjrjySRWbvnyHImFAmxP1i/zXp1Zq69odDVz333BSGjV8vn66TpOVThAjQYcErocTDTzo
        3YtXugSsuNhuMpxWZVQST49DCWYVYKnkdQS/ulDckey3prGKe6D8tcXzgKUDhwru7wLMhJ
        7wctT3NJBj1ULVkcr7eTeVtoInbHM7k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-EyjltW9SPJmUGCW2KLfwXA-1; Thu, 21 Oct 2021 04:50:55 -0400
X-MC-Unique: EyjltW9SPJmUGCW2KLfwXA-1
Received: by mail-wr1-f72.google.com with SMTP id v15-20020adfa1cf000000b00160940b17a2so11069963wrv.19
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=TMKCQhzyCZoKip7jkhipm5coeXVlUYjq8hHmo56D0kM=;
        b=O6yClye5cnX6cNm5INbWMAqRKRsgsDjP3Topxog1dKy2gIrao5Fr+XfWEns7TiJc6v
         RFMOC7ZkkgrQ1MLWbnRryIUkCRZ3j5id0bFRC0HFIMXID0CE5LYlJt7vlRuJiDROYShR
         yztYpqFsTjxHfbeQaPHaFq6j/LYjvE7Dk8YADwe2S4KNqzf6rZ6OFw+CxDqxHSXm12rm
         5cAMSdbYQ9MoWwF84B+G9o96CuL+pQeTxoAZ1OSMH5T4JlHgUwBDuufxwr1VD6ZLXo4k
         d/hc+mUg6ooxSxg0ioAqR3ZsvQLF3a6DT2fl+OYKWA0Ykh0lehOSVigKxi6G3loBWsPW
         6PRQ==
X-Gm-Message-State: AOAM533BACIEoaxVWzVivJO+fpqCTbL/1RWgqO9g1rQ7DM8CdmBWl3qi
        4jVxCKLYeV4TmeDRGhMdhQTnEIqEVpTQFAC29DPxxRxNJhEBvoGXy5DdTPRWM8RZi4Ar6Ukzzfo
        j6lLP43iJ7k8CCr348l4N7sEs
X-Received: by 2002:a7b:c4c8:: with SMTP id g8mr5037465wmk.101.1634806253952;
        Thu, 21 Oct 2021 01:50:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEHGgkVyg0q1OaErEei7VkUfa1cHgmw1g0ZMcPOr7mjHHlR0oZ31aOenII21AbbYuKXfXn3w==
X-Received: by 2002:a7b:c4c8:: with SMTP id g8mr5037448wmk.101.1634806253781;
        Thu, 21 Oct 2021 01:50:53 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23aba.dip0.t-ipconnect.de. [79.242.58.186])
        by smtp.gmail.com with ESMTPSA id s8sm4281769wrr.15.2021.10.21.01.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 01:50:53 -0700 (PDT)
Message-ID: <60939c5c-2b1f-a7d7-61b3-f8f501a4893f@redhat.com>
Date:   Thu, 21 Oct 2021 10:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] mm/page_alloc: use clamp() to simplify code
Content-Language: en-US
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>, akpm@linux-foundation.org
Cc:     weiyongjun1@huawei.com, huawei.libin@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20211021034830.1049150-1-bobo.shaobowang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211021034830.1049150-1-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.21 05:48, Wang ShaoBo wrote:
> This patch uses clamp() to simplify code in init_per_zone_wmark_min().
> 
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  mm/page_alloc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b37435c274cf..d0449212a824 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8460,16 +8460,12 @@ int __meminit init_per_zone_wmark_min(void)
>  	lowmem_kbytes = nr_free_buffer_pages() * (PAGE_SIZE >> 10);
>  	new_min_free_kbytes = int_sqrt(lowmem_kbytes * 16);
>  
> -	if (new_min_free_kbytes > user_min_free_kbytes) {
> -		min_free_kbytes = new_min_free_kbytes;
> -		if (min_free_kbytes < 128)
> -			min_free_kbytes = 128;
> -		if (min_free_kbytes > 262144)
> -			min_free_kbytes = 262144;
> -	} else {
> +	if (new_min_free_kbytes > user_min_free_kbytes)
> +		min_free_kbytes = clamp(new_min_free_kbytes, 128, 262144);
> +	else
>  		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
>  				new_min_free_kbytes, user_min_free_kbytes);
> -	}
> +
>  	setup_per_zone_wmarks();
>  	refresh_zone_stat_thresholds();
>  	setup_per_zone_lowmem_reserve();
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

