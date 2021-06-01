Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD8B396EDD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhFAIZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233372AbhFAIZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622535829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19rdlm3aekp78iG0bh4BpLYZ54JID0O0sq66buG23WU=;
        b=MW08KIVV2306Ao8Fn+enydzY7ltFB/Jn1jg1Rgxvt9Q4DFc4dyLJ6sLFV3XHSZYjbhYMbn
        CZPF8wlHp8D44ahXjgpAuQ+EFcLaXm4Jm2Cyx+8nDCkDUIOtv+0eJf/jkwqF9ZfYQvb6i+
        jmkbNZGqhWDox7Z6bpjDYFiWugYFK8k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-ZH4pVhiYOxWhqNK5A1Ck1A-1; Tue, 01 Jun 2021 04:23:48 -0400
X-MC-Unique: ZH4pVhiYOxWhqNK5A1Ck1A-1
Received: by mail-wm1-f70.google.com with SMTP id g9-20020a05600c4ec9b0290198e2707cecso1017146wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=19rdlm3aekp78iG0bh4BpLYZ54JID0O0sq66buG23WU=;
        b=RWgInKS/06Rli0KcobRTBF7X3wjxFARnSTBacA6P3Xw8S7CKuHQQZxB5u3LYLjeM/Z
         OTFvA8nlPdPtXpX3i2lCY3ziJvy7JDkNIF7kF5jfLb86iOa6HPIj/6jAatoo/gi6zO9n
         oDl066hcaIzQIGKvY6oK8GXIieWMyfkiNcwrl+xTVEE7TJC4qa/KYjyjeHuB0pCiua0q
         fklxAqzx+3NSL93lOzp0FiY9CePXNUqkfjWAJx3A/1T79LTuU7aFxasTMn66T7iIO4pH
         gRR7jy9dx4BNzTl8HY97Bs4CR8qh0/NXg0c/DizrPwvw4AGM6xV+axiro2Y2sogmRC67
         Ln8g==
X-Gm-Message-State: AOAM5332plQROSzRsCcAiyP2nYu4ZWIdh3lOcnlKob6CWAG3wYJRyzg8
        K0WWkKR0nzWcnQcJoMx+dX8I7HChFXnjqEUaCrRgi3Zi2eEyEjWwsH74R9wuxbDwJ5Wyh9HthG8
        fvSmayDuaDV+5239Eno+1FzKH
X-Received: by 2002:a5d:50c1:: with SMTP id f1mr26902262wrt.168.1622535827535;
        Tue, 01 Jun 2021 01:23:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuONRAg7ToUff+HnfBB4K6bjg8qM2dP+YiK/aB9hK9nvdNQ5+4tI+WfcuUbmEAmzC3Dbz53A==
X-Received: by 2002:a5d:50c1:: with SMTP id f1mr26902245wrt.168.1622535827341;
        Tue, 01 Jun 2021 01:23:47 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69ce.dip0.t-ipconnect.de. [91.12.105.206])
        by smtp.gmail.com with ESMTPSA id m5sm1806819wmq.6.2021.06.01.01.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:23:47 -0700 (PDT)
Subject: Re: [PATCH V2 5/6] mm/page_alloc: improve memmap_pages dbg msg
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-6-aisheng.dong@nxp.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c2faa32e-1d9b-ae0d-b037-9efcb6ff0022@redhat.com>
Date:   Tue, 1 Jun 2021 10:23:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210531091908.1738465-6-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.21 11:19, Dong Aisheng wrote:
> Make debug message more accurately.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v1->v2:
>   * drop dma_reserve log changing
> ---
>   mm/page_alloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1786a24cdc5a..1bfbe178a9ed 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7347,7 +7347,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>   					pr_debug("  %s zone: %lu pages used for memmap\n",
>   						 zone_names[j], memmap_pages);
>   			} else
> -				pr_warn("  %s zone: %lu pages exceeds freesize %lu\n",
> +				pr_warn("  %s zone: %lu memmap pages exceeds freesize %lu\n",
>   					zone_names[j], memmap_pages, freesize);

I guess it should be s/exceeds/exceed/.

Apart from that

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

