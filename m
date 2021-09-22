Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2561E4147C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 13:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbhIVL0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 07:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235422AbhIVL0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632309881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4YmK/BIl3bs73s3JD5l2n9kQfilzXJjmSHFvcg2MUQ=;
        b=A/7u5koLMJTq2hBl/Nza7a+AkW/fEz7I1oTrNAqRvmeTxuqGruwLy8HnbvsZGJu7rA95JD
        LhZLlIXlJ/enTYvi24UZxtjuy9G1/DTAfGxrb2zuTjZd3D1eePbbJvImaXp41D5mEYXySu
        G6sgS6Y8983IIhRZyIUd+vwmOF2CXDA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-6v3_at1BMM2jxXbOWWpPpw-1; Wed, 22 Sep 2021 07:24:40 -0400
X-MC-Unique: 6v3_at1BMM2jxXbOWWpPpw-1
Received: by mail-wr1-f70.google.com with SMTP id s14-20020adff80e000000b001601b124f50so1860459wrp.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 04:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=X4YmK/BIl3bs73s3JD5l2n9kQfilzXJjmSHFvcg2MUQ=;
        b=fra6DvjFuXfdh5EEAJYWFn6bdwbOYo0SflZM/zN0qe2KdGMWVVqGblmqkeWI2uRka7
         9O441m+BD7YLlLWYSqCyYE/f8FcdjS9owrkm2PWPuYwGDmbRCjt365ZiXRq1GzFCLPL/
         wl8TiI3yGBGaZoniLMJ+1yoWcrWRNJx3VhZ/LllQCmfTK3Fi62CT8kg4OllXOR9v9rqv
         uaGnF6jlZox+Yqf+iMWah/wdengSgUev7fwSkVAAhY8VFW0ORnUezjCmdv/VCDwBimKy
         wFHDS9Jvycs6vYEwPOjkrYF5ZILl/aDi2nHrtrff08OhlPPozt19+gjKq580q1/VNz4l
         /G4w==
X-Gm-Message-State: AOAM531/nF63/8KL00mNFKW9USG3izIhbAmh0/iztPFVJCGUDiyFS7BN
        K+RB8izFhlS8bBkZSulZCpYeqjWFtyNa/JNYZJ7uXQmtu6S5K10oI9Jk35AjeIV0hk5fpm/3nHD
        2AmCwE1uol0CgTZXWTWfOLwL9TVEC97sTBZUZiH2vtLvdjSbod3+MGT0i2YytfRD+nJPi+sd5
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr439237wme.94.1632309879132;
        Wed, 22 Sep 2021 04:24:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQMRptnAr+ZRUqQSK+rSyxlh79n7hCXa6kS3Sm0bOlf0UOIAFYvadx70RTDac9sFbqNojS/g==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr439209wme.94.1632309878875;
        Wed, 22 Sep 2021 04:24:38 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64dd.dip0.t-ipconnect.de. [91.12.100.221])
        by smtp.gmail.com with ESMTPSA id z79sm1824154wmc.17.2021.09.22.04.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 04:24:38 -0700 (PDT)
Subject: Re: [PATCH] mm/swapfile: Remove needless request_queue NULL pointer
 check
To:     Xu Wang <vulab@iscas.ac.cn>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210917082111.33923-1-vulab@iscas.ac.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8327ab0b-a6f4-7580-fb79-b079500c26fe@redhat.com>
Date:   Wed, 22 Sep 2021 13:24:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210917082111.33923-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.09.21 10:21, Xu Wang wrote:
> The request_queue pointer returned from bdev_get_queue() shall
> never be NULL, so the null check is unnecessary, just remove it.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>   mm/swapfile.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 22d10f713848..42027d213fd2 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3118,7 +3118,7 @@ static bool swap_discardable(struct swap_info_struct *si)
>   {
>   	struct request_queue *q = bdev_get_queue(si->bdev);
>   
> -	if (!q || !blk_queue_discard(q))
> +	if (!blk_queue_discard(q))
>   		return false;
>   
>   	return true;
> 

Right, there is even a comment in bdev_get_queue "this is never NULL".

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

