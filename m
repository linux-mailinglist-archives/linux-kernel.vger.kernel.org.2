Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9656E3FC960
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhHaOIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhHaOIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630418868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nDuXcChfounB7T9X8U8PIX2ZPisENyimxi/9Pdf7wyQ=;
        b=Rr0H89bMjy4JQG6+7zdyjnXEASN3dwyBX8YWYzrcc8A9em6B6iAX76tgpSpuG6PYX8w7ef
        tTzkSlKbPWKRMB0OJ1tWriBOkJ/my5hqNL2OUF+K28PHBTak7jYdza9VmRGMNAUbj3dGM/
        UeGSoS9zTyf64dUntGAXjb57GAcPyDk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-ZhLPbBvEOT-bWGhc3aWnvQ-1; Tue, 31 Aug 2021 10:07:46 -0400
X-MC-Unique: ZhLPbBvEOT-bWGhc3aWnvQ-1
Received: by mail-wm1-f69.google.com with SMTP id s197-20020a1ca9ce000000b002e72ba822dcso1296857wme.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nDuXcChfounB7T9X8U8PIX2ZPisENyimxi/9Pdf7wyQ=;
        b=fHfh5qCjqMbRCOidshRd0/uItMk/zsKoGUZ63OUmqg1BYztGs2ysEWjylfoirQOJ30
         u//8y/UHNZz4RIPnw1tZrvrVk0X1YFjBAeZW0xST7m2lEz4H1XVoQrNZ+sZL37jsjZG8
         iPpXrampIJuHCXyNKja/x4e9hKUJBFK+C6ZLqyI2/YjiraFNmrF3RmD9xIX+0sfgfjda
         nu02jFRAGYW53wqUC+OKPx9jLHKzx5Qgy/fDm59C5vnMmxk+pAeUp7VTdtkq8CEHPWG3
         KZ1RtPM/5oxQq+Ykz11aA0zl2fOCO20vlqm7fWsNw4GmWwcGVJbomh3OD/SRK2EN1gJo
         U2kg==
X-Gm-Message-State: AOAM530OEvYx3A5YYI19HAyYSwmOH0nQR0JoHkQOrGGaQkp2SS9CzND3
        M5ltWeSFM+of1i/GZpVnhnvVO5Yw4SUszywsgrCuGKcS5CzDZW/t4dzhcPi3vQgBmd2ngf0eWAy
        4+31q84NyW1gJ8/HMrzsUmSEizzz/IdOweiXOs24Nf9klU/J4wfeeXthwW/36KdhGQ25rKEu7
X-Received: by 2002:a05:6000:352:: with SMTP id e18mr12583644wre.238.1630418865590;
        Tue, 31 Aug 2021 07:07:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvyz+5qc+es1kcIXAIEqVAxSEh/gv6RWdRu76hhJL/ovc9pEz+h3whnDxGA4Xjo2CsL0rL9w==
X-Received: by 2002:a05:6000:352:: with SMTP id e18mr12583620wre.238.1630418865365;
        Tue, 31 Aug 2021 07:07:45 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bf5.dip0.t-ipconnect.de. [79.242.59.245])
        by smtp.gmail.com with ESMTPSA id q13sm18325918wrv.79.2021.08.31.07.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 07:07:45 -0700 (PDT)
Subject: Re: [PATCH 2/6] mm/page_alloc.c: simplify the code by using macro K()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     vbabka@suse.cz, sfr@canb.auug.org.au, peterz@infradead.org,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <31f53542-e498-5428-053e-6a24bd23887b@redhat.com>
Date:   Tue, 31 Aug 2021 16:07:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210830141051.64090-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.21 16:10, Miaohe Lin wrote:
> Use helper macro K() to convert the pages to the corresponding size.
> Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index dbb3338d9287..d3983244f56f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8134,8 +8134,7 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
>   	}
>   
>   	if (pages && s)
> -		pr_info("Freeing %s memory: %ldK\n",
> -			s, pages << (PAGE_SHIFT - 10));
> +		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
>   
>   	return pages;
>   }
> @@ -8180,14 +8179,13 @@ void __init mem_init_print_info(void)
>   		", %luK highmem"
>   #endif
>   		")\n",
> -		nr_free_pages() << (PAGE_SHIFT - 10),
> -		physpages << (PAGE_SHIFT - 10),
> +		K(nr_free_pages()), K(physpages),
>   		codesize >> 10, datasize >> 10, rosize >> 10,
>   		(init_data_size + init_code_size) >> 10, bss_size >> 10,
> -		(physpages - totalram_pages() - totalcma_pages) << (PAGE_SHIFT - 10),
> -		totalcma_pages << (PAGE_SHIFT - 10)
> +		K(physpages - totalram_pages() - totalcma_pages),
> +		K(totalcma_pages)
>   #ifdef	CONFIG_HIGHMEM
> -		, totalhigh_pages() << (PAGE_SHIFT - 10)
> +		, K(totalhigh_pages())
>   #endif
>   		);
>   }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

