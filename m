Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB1F3F275B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 09:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbhHTHNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 03:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233073AbhHTHNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 03:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629443555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2GoNPZi9qrBQcCL3gakdQwO2nPqTgYHaAONgLRbdpqM=;
        b=QbGvuyjHLLWNtbPw98HEoNlmCZnYuFMBez28/ePLiCVdOmu3MK3sPlT7Tdsjt5THFyzvB3
        gShZECibzWSpuBSkqYMpMPI4CG6qWl9OBdc1TaZFrFgIbZoiI1eVYP9hkKoqq9PVzrvqLu
        236aQA3jkYffvF2s+0dd/+b0aucELDk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-3GAPUQp3OOmZJkyUW80zzA-1; Fri, 20 Aug 2021 03:12:31 -0400
X-MC-Unique: 3GAPUQp3OOmZJkyUW80zzA-1
Received: by mail-wm1-f72.google.com with SMTP id w25-20020a1cf6190000b0290252505ddd56so1683749wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 00:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2GoNPZi9qrBQcCL3gakdQwO2nPqTgYHaAONgLRbdpqM=;
        b=LtmZUI6QD/o3/X8XrhYjQZJQly5S+vEcMnTme5CKxQomTM/OqOg2XNvY6kivMfms0N
         ZKtNE+zvj/Mnf1GWATGdEDOczdlphG+Y9Ntpp9SfOdz9fWFR4kEKdPI50cOQci5YA2Tn
         Crv7CZRkWmXMbCPW7JeU2aaojkPygjUapzaQAkHvGoWdIIYmUQTXiVfofyQM0v65EUvs
         k2EKrzwm9yrQaV8ohJJA04Ujul7ER12v9lCPZqhI3tBH4A0hV3PnEI4RfZgW5t4UoNge
         dFHLl8qlngS3Jl6EWHJjEEUANLVddHuuD2de+xKPD4X1Ongh0SXI5Yd6w61kGKwGnf8Y
         mbWg==
X-Gm-Message-State: AOAM530xNmhaclX7l/JQYBTH8VEIDU+NSJb5uj+GcD1/9uHMrruASTzE
        WT6/sL7MbrnI9QjChFnyuKx6h4jVES3AMuXIDFOkOBmdre9c4t+dzTBLywHJ49rt623E+/MQ1KV
        cs7PQB5Piiz8AufuyyLcBxFfF
X-Received: by 2002:a5d:5305:: with SMTP id e5mr8230887wrv.243.1629443550552;
        Fri, 20 Aug 2021 00:12:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1ka/XH/E2ChCX6u+2m7dnx/k73Zseqx1DsN/ARQ+EguZGs7f1VYaoN97NBfkeQmjufl8bcQ==
X-Received: by 2002:a5d:5305:: with SMTP id e5mr8230862wrv.243.1629443550414;
        Fri, 20 Aug 2021 00:12:30 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id r4sm4064242wmq.10.2021.08.20.00.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 00:12:30 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hkallweit1@gmail.com
Subject: Re: [PATCH net-next v2 1/2] page_pool: use relaxed atomic for release
 side accounting
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org
References: <1629442611-61547-1-git-send-email-linyunsheng@huawei.com>
 <1629442611-61547-2-git-send-email-linyunsheng@huawei.com>
Message-ID: <9363880e-4ed2-5acd-87da-d669b68d0134@redhat.com>
Date:   Fri, 20 Aug 2021 09:12:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1629442611-61547-2-git-send-email-linyunsheng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/08/2021 08.56, Yunsheng Lin wrote:
> There is no need to synchronize the account updating, so
> use the relaxed atomic to avoid some memory barrier in the
> data path.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

LGTM

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

> ---
>   net/core/page_pool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index e140905..1a69784 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -370,7 +370,7 @@ void page_pool_release_page(struct page_pool *pool, struct page *page)
>   	/* This may be the last page returned, releasing the pool, so
>   	 * it is not safe to reference pool afterwards.
>   	 */
> -	count = atomic_inc_return(&pool->pages_state_release_cnt);
> +	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
>   	trace_page_pool_state_release(pool, page, count);
>   }
>   EXPORT_SYMBOL(page_pool_release_page);
> 

