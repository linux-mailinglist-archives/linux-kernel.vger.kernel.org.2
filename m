Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1980A3CB7A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbhGPNCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232706AbhGPNCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626440357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/E38vCggOBKVR3p8p3Q4Jef+K2A5RWkpHXZoCknxgoA=;
        b=OKKUwHiDIeYBbc1oFoh6VhPT2/t8rRYqUNYoiuo0zUSoQ2IKmWKnL5jtzfnWg/O1OP+aIU
        7ZKGK2OEeqiLpcdaTbM7Y0g4iW4TRurKbGQJBl0jB60JFyIW/5bMMiHIH6oUXN4gefx7uj
        K+dBQ4KcwsFDM/q0B0bLgk254cBEOL4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-eLGzQPEjOjCorgs3BG0wvw-1; Fri, 16 Jul 2021 08:59:16 -0400
X-MC-Unique: eLGzQPEjOjCorgs3BG0wvw-1
Received: by mail-wr1-f72.google.com with SMTP id r11-20020a5d52cb0000b02901309f5e7298so4841063wrv.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 05:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/E38vCggOBKVR3p8p3Q4Jef+K2A5RWkpHXZoCknxgoA=;
        b=jyFqbJIZTSTZiGJ8fNW+a5vExh+1GTmvsj6YOi53oG9RgqFWLMh86DEWY+hvVJvgI0
         aa79yvD7gZGb8m/6TGn+mAkYFHL8DTrbTJDahGUhO5JOIxUiCr+hjvFIAx53mDMeP7Yb
         WQgObdzCCkuJhx53JawnzolGvDUgK0PvqjnomH/HVsNlwjZCIM17wMNFg6oH53d4kDkj
         qnQoLNhIVY/CrkwIVofjwUlJ/eMM8N6Q+1f1D0Rifq5K002qRmWv52Fekh/Vrz0myFG7
         ezFEjmwwk6oT4+xnFDx9UxUHnV47AUzUPLOFPYWED8eA1jM6g6elJcrk6AGiVDZNVQrl
         9GyQ==
X-Gm-Message-State: AOAM533idazaUgvdD/xo0G2+F1YPTfWiDROpASZCTcw42uF3tR5YOK0j
        4nQ2wUBv6UblsfT+wnFgaZ6++nvOQQ8TQMuw+0BFSizMPF98aEGmQaPXTwXCrAOHpR+0US6MnYL
        GnxTbkdqJeTI8CvqcwudvY9+yx29BCS8hrKt5JrLoPmxSUoJ8uh7InRXD46AZzZlke2C2n6pP
X-Received: by 2002:a05:6000:2a1:: with SMTP id l1mr11962715wry.128.1626440355391;
        Fri, 16 Jul 2021 05:59:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVNVuudcvKFRSJKwazJh7rObTjbVK7ZYCl+TaQuI4AkyJjJMv7QgZhE0mkK3DAA+amKSH1xg==
X-Received: by 2002:a05:6000:2a1:: with SMTP id l1mr11962688wry.128.1626440355105;
        Fri, 16 Jul 2021 05:59:15 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c621f.dip0.t-ipconnect.de. [91.12.98.31])
        by smtp.gmail.com with ESMTPSA id h130sm811710wmh.1.2021.07.16.05.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 05:59:14 -0700 (PDT)
Subject: Re: [PATCH 3/3] mm/vmstat: remove unneeded return value
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210715122911.15700-1-linmiaohe@huawei.com>
 <20210715122911.15700-4-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f9598b11-486f-f047-63ca-ba6a6e1de3e4@redhat.com>
Date:   Fri, 16 Jul 2021 14:59:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715122911.15700-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.21 14:29, Miaohe Lin wrote:
> The return value of pagetypeinfo_showfree and pagetypeinfo_showblockcount
> are unused now. Remove them.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/vmstat.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 76aef9510f6d..6246bab9fae2 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1452,7 +1452,7 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
>   }
>   
>   /* Print out the free pages at each order for each migatetype */
> -static int pagetypeinfo_showfree(struct seq_file *m, void *arg)
> +static void pagetypeinfo_showfree(struct seq_file *m, void *arg)
>   {
>   	int order;
>   	pg_data_t *pgdat = (pg_data_t *)arg;
> @@ -1464,8 +1464,6 @@ static int pagetypeinfo_showfree(struct seq_file *m, void *arg)
>   	seq_putc(m, '\n');
>   
>   	walk_zones_in_node(m, pgdat, true, false, pagetypeinfo_showfree_print);
> -
> -	return 0;
>   }
>   
>   static void pagetypeinfo_showblockcount_print(struct seq_file *m,
> @@ -1501,7 +1499,7 @@ static void pagetypeinfo_showblockcount_print(struct seq_file *m,
>   }
>   
>   /* Print out the number of pageblocks for each migratetype */
> -static int pagetypeinfo_showblockcount(struct seq_file *m, void *arg)
> +static void pagetypeinfo_showblockcount(struct seq_file *m, void *arg)
>   {
>   	int mtype;
>   	pg_data_t *pgdat = (pg_data_t *)arg;
> @@ -1512,8 +1510,6 @@ static int pagetypeinfo_showblockcount(struct seq_file *m, void *arg)
>   	seq_putc(m, '\n');
>   	walk_zones_in_node(m, pgdat, true, false,
>   		pagetypeinfo_showblockcount_print);
> -
> -	return 0;
>   }
>   
>   /*
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

