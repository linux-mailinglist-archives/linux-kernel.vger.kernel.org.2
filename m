Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313FD3D3AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbhGWMOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234988AbhGWMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627044873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtohglzzzr374jKgrWszd7PUWfTWiFAWrR6LAClff6I=;
        b=COLzZ0zgJ1hJnZDjGVnplWERNgR44x4pPVEkHAaSYdFMXEhIaM/FYkm1byI/K0cCBl/Ctq
        1/UouZOfKtnGdgg8KHurgefYeAl/FOqZHrSTt9L4aEE5Hsgo+1YY+i+sEgdtOfjFJYg2v1
        trXSgWJI3ibevYW5Z8FDzjYlogGG+l4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-4wO3MJg4MHWJOJCr7P2dDA-1; Fri, 23 Jul 2021 08:54:31 -0400
X-MC-Unique: 4wO3MJg4MHWJOJCr7P2dDA-1
Received: by mail-wr1-f69.google.com with SMTP id v15-20020a5d4a4f0000b0290141a87409b5so943774wrs.16
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 05:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rtohglzzzr374jKgrWszd7PUWfTWiFAWrR6LAClff6I=;
        b=jzQlAuKE2DRWb1SMj8pEO+QYlN8xMCyk76ORNOiiHx3VfVW+qWCKVDrThTSpuOatfV
         2Z0jv51wvOScuM8WrfKUjtkwZ0r4lT8fTGVUQkpQMxEnaGqvCF3NjPeSoJXEGxsWHZvn
         IFNnHKW0z0YYotOGsVsk9aE/2GVNfObjq43BPLmTewtilhVkqnTdHoO8ayutomEoDCT9
         ABA+KsK4mJenCoTdsUy6K0BAck39S6aVU8qblLvwjazYfGb4ls+bxtOYf8Gn4aFLChGD
         Og0E0Wo1QsdedauQNbfLT1i55CRahQrVP5hZnxdj0iRvpiuOxcbuHDz12m2En6E7150a
         f9kw==
X-Gm-Message-State: AOAM530szAzaiVVJAYekTqlFcp898N0iK3pvMy8gzRWRuTiww0fC47WS
        JKAqHQjGKqlEY3Hpifr25cj2PKMMzRq+u5ny9ufNj3r/Gl2upmopsA4yzalA/AzD4elFK+UCjvy
        dNjcRcDLlBSndhzGMQ6e9klX+
X-Received: by 2002:a5d:488a:: with SMTP id g10mr5048113wrq.327.1627044870618;
        Fri, 23 Jul 2021 05:54:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEeQq9U7yP+rUIm4ZAIm04oUgSz6vh76SLYdZHF2hmw1P2cAukKj/ZsHWRhwgjoSiWwSxylA==
X-Received: by 2002:a5d:488a:: with SMTP id g10mr5048100wrq.327.1627044870401;
        Fri, 23 Jul 2021 05:54:30 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id g3sm32896895wru.95.2021.07.23.05.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 05:54:30 -0700 (PDT)
Subject: Re: [PATCH v3] mm/sparse: clarify pgdat_to_phys
To:     Miles Chen <miles.chen@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
References: <20210723123342.26406-1-miles.chen@mediatek.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <571dcb1d-1f3a-0633-17e1-1ca9856bee5e@redhat.com>
Date:   Fri, 23 Jul 2021 14:54:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723123342.26406-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.21 14:33, Miles Chen wrote:
> Clarify pgdat_to_phys() by testing if
> pgdat == &contig_page_data when CONFIG_NUMA=n.
> 
> We only expect contig_page_data in such case, so we
> use &contig_page_data directly instead of pgdat.
> 
> No functional change intended when CONFIG_BUG_VM=n.
> 
> Comment from Mark [1]:
> "
> ... and I reckon it'd be clearer and more robust to define
> pgdat_to_phys() in the same ifdefs as contig_page_data so
> that these, stay in-sync. e.g. have:
> 
> | #ifdef CONFIG_NUMA
> | #define pgdat_to_phys(x)	virt_to_phys(x)
> | #else /* CONFIG_NUMA */
> |
> | extern struct pglist_data contig_page_data;
> | ...
> | #define pgdat_to_phys(x)	__pa_symbol(&contig_page_data)
> |
> | #endif /* CONIFIG_NUMA */
> "
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20210615131902.GB47121@C02TD0UTHF1T.local/
> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> 
> --
> 
> Change since v1:
> Thanks for Mike's comment, check if pgdat == &contig_page_data,
> so it is clearer that we only expect contig_page_data when
> CONFIG_NUMA=n.
> 
> Change since v2:
> use VM_BUG_ON() to avoid runtime checking when CONFIG_BUG_VM=n
> ---
>   mm/sparse.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 6326cdf36c4f..d13d831f88a5 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -348,7 +348,8 @@ size_t mem_section_usage_size(void)
>   static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
>   {
>   #ifndef CONFIG_NUMA
> -	return __pa_symbol(pgdat);
> +	VM_BUG_ON(pgdat != &contig_page_data);
> +	return __pa_symbol(&contig_page_data);
>   #else
>   	return __pa(pgdat);
>   #endif
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

