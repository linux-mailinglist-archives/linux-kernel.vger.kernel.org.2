Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA4E3E40CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 09:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhHIH0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 03:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59214 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233122AbhHIHZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 03:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628493929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNaWugcsqwEhxVIGKp2CI/wz2iOjAFTuqVT1m8pDKbo=;
        b=dMMfCPMcOJ92dqFSBnJMaFS4Pd0PlB8TM+Abjt43v3i+FJMfLQ6SSshNC/ySnnETG6zflK
        SA2nidEtMD1obvNR0nEM+XnEP9BGsTf3n9mBPZH0v16fJB1rgLmRV8nY34MkytaOJdm9Uu
        y1806E+8/aNgXF1gIqOJSncCTJ2SD6A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-qqEpUQM9NhKMArZBYgdahg-1; Mon, 09 Aug 2021 03:25:28 -0400
X-MC-Unique: qqEpUQM9NhKMArZBYgdahg-1
Received: by mail-wm1-f69.google.com with SMTP id g70-20020a1c20490000b02902e6753bf473so2280963wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 00:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JNaWugcsqwEhxVIGKp2CI/wz2iOjAFTuqVT1m8pDKbo=;
        b=DX+5xBAWM1jqEM7uqVd+NKpK6J1WR8cZNL1MuSJysYHBQZ7v97VH07Cy1fiu9el54Q
         3W/7YwmiVD6FKsg+aUlT9y4GRPmNnQFIrsub3sW72mN0OePmJjGMWWHWQWXduM0KCqJs
         LYWyswQOsEy0+P6tYtGIHpylhu01jm2h/eoqo2tKePEgpEnYt3OV5tej+dF49MnixhSi
         58QIYaA9YREj0VsZYH6pR9ejRNtMI+b/wSWgUD8f88e3VEwW3oj4KOEDV2lA3j9owitG
         FTb7PwpTqG2e1ddEBxzifhVc5KeqsTHM48RLzcL6BDgeNqBsAbcRjg3P8jC2in58Dxd2
         NNUA==
X-Gm-Message-State: AOAM532zWXxZ5Vg9I/fkFcKfD3B/vMQXbBu4ES+TLiuurqgk4ZEzNBob
        Ty0ftvbwxcJfnIfOCX0pRj0ZlhgDa0igPRN76p2fAG3CRXdHKn9yli2npkw7a3AsjFod2xREHeD
        yNn270I+qp8zhJKitrJcXJdZnNqxQfz8MvcC/KJU5igFinBU2/vSbhlbIK4T31VkMBR1nmDPh
X-Received: by 2002:a1c:2547:: with SMTP id l68mr5833033wml.23.1628493927580;
        Mon, 09 Aug 2021 00:25:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsNDeS2Y+pJvAumXMRLknJnzonRHwbbWrYqQynr09Sy5T089ASO/i2XYYeqmf3R64rIt02mQ==
X-Received: by 2002:a1c:2547:: with SMTP id l68mr5832998wml.23.1628493927224;
        Mon, 09 Aug 2021 00:25:27 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id 9sm16720849wmf.34.2021.08.09.00.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 00:25:26 -0700 (PDT)
Subject: Re: [RFC PATCH 11/15] mm/page_reporting: report pages at section size
 instead of MAX_ORDER.
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <20210805190253.2795604-12-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c2fa6c99-ac48-bf0b-a8ca-d1c0ffb633b6@redhat.com>
Date:   Mon, 9 Aug 2021 09:25:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805190253.2795604-12-zi.yan@sent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.21 21:02, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> page_reporting_order was set to MAX_ORDER, which is always smaller than
> a memory section size. An upcoming change will make MAX_ORDER larger
> than a memory section size. Set page_reporting_order to
> PFN_SECTION_SHIFT to match existing size assumption.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   mm/page_reporting.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 382958eef8a9..dc4a2d699862 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -11,7 +11,8 @@
>   #include "page_reporting.h"
>   #include "internal.h"
>   
> -unsigned int page_reporting_order = MAX_ORDER;
> +/* Set page_reporting_order at section size */
> +unsigned int page_reporting_order = PFN_SECTION_SHIFT;
>   module_param(page_reporting_order, uint, 0644);
>   MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
>   
> 

If you look closely, this is only a placeholder and will get overwritten 
in page_reporting_register(). I don't recall why we have the module 
parameter at all. Most probably, to adjust the reporting order after we 
already registered a user. Can't we just initialize that to 0 ?

-- 
Thanks,

David / dhildenb

