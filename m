Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338E43645DA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhDSOTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232452AbhDSOTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618841922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o3UPUs10GkMYgieyL1I900CWEZM98DXwIwU3+JzhSRs=;
        b=PjFo8cNCofBk4nyVLDXH2++RscfcagyBPWEWx8MinSChdj1OfARI6n1lBW8BrAWy9gGUMp
        qfdRNyrLsLsOF+2EWPLiYO6xPtuH8Twf5KGCfhgS/bpBE8SOYKX794dWOFSuyK/DqsabGO
        /pSie2dnXsTxKKxe0t0nw0ZF88aihmk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-AZQ6I1K-PHWlDhrD0hW9uQ-1; Mon, 19 Apr 2021 10:18:40 -0400
X-MC-Unique: AZQ6I1K-PHWlDhrD0hW9uQ-1
Received: by mail-wr1-f72.google.com with SMTP id h60-20020adf90420000b029010418c4cd0cso8273130wrh.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 07:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=o3UPUs10GkMYgieyL1I900CWEZM98DXwIwU3+JzhSRs=;
        b=N+97J99K0P+YgC6x2KqO0I0JNAVQ5Ok5t1PpGLsd8DuRcS2LRAeyXATDTytEtk+JVJ
         5i1qzyQF9IWkBDqN2CI3m6OooPufeMOzJps57p3kzZN3xjQLUdgXYLwDxryv2Xzw6uYw
         xwc1G4Wf/PZD2fKNwdaeLGqIk3/Hz6vVEWhpplnQtw+RLkOk0YvPQ5Zib5pKzWF9st8h
         nR7DexxCA9oX1C92CXBIDTZFojPrC5gjjXh6gCxEHs9HVcxal+sWYs+GG9uruu+bGmyM
         f5S5x7066HrOtgOzxW3xV45ypV/C4dQOQ6raJRwTtQi7bHqaZgL7EcGsc3VPZMNNFjmF
         +YXQ==
X-Gm-Message-State: AOAM532Hy8GdYTYFcypRWj+v+TaFOq6TOD63NobaX6JsIbW1vr/ipb/7
        /cu3pjzeUyMgkjcG+/ENuEwjDboxr4rjstT6O7AwWAe/v9wEkcLeWtEYyU5b3y1+xSmAEdr4JUZ
        9ozbEgS82y/22KKWGb7lbSATV
X-Received: by 2002:adf:d1cc:: with SMTP id b12mr15069243wrd.131.1618841919155;
        Mon, 19 Apr 2021 07:18:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzP2SU3QIp/T87kn+Ro2PJ3N/yPo/rwVzL8ua9LA2gCUdGPt11NDG+C7Ere3+8ExxzUAEt74A==
X-Received: by 2002:adf:d1cc:: with SMTP id b12mr15069226wrd.131.1618841918984;
        Mon, 19 Apr 2021 07:18:38 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69b8.dip0.t-ipconnect.de. [91.12.105.184])
        by smtp.gmail.com with ESMTPSA id x2sm25513946wrg.31.2021.04.19.07.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 07:18:38 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] kernel/resource: Allow region_intersects users to
 hold resource_lock
To:     Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        daniel.vetter@ffwll.ch, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, jhubbard@nvidia.com,
        jglisse@redhat.com, bsingharora@gmail.com, smuchun@gmail.com
References: <20210419070109.4780-1-apopple@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d41d8dc4-3fe7-dba3-1765-4e24652582b9@redhat.com>
Date:   Mon, 19 Apr 2021 16:18:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210419070109.4780-1-apopple@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.21 09:01, Alistair Popple wrote:
> Introduce a version of region_intersects() that can be called with the
> resource_lock already held. This is used in a future fix to
> __request_free_mem_region().
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>   kernel/resource.c | 52 ++++++++++++++++++++++++++++-------------------
>   1 file changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 627e61b0c124..736768587d2d 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -523,6 +523,34 @@ int __weak page_is_ram(unsigned long pfn)
>   }
>   EXPORT_SYMBOL_GPL(page_is_ram);
>   
> +int __region_intersects(resource_size_t start, size_t size, unsigned long flags,
> +			unsigned long desc)
> +{
> +	struct resource res;

I'd do

struct resource res, *p;

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

