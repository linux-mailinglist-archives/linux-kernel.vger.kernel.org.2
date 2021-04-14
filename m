Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7184D35F779
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350308AbhDNPRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233872AbhDNPQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618413376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wi7Vsx7fsiQc/wyHgFKatT0Y76VokmNc3vRxm+hzn58=;
        b=fEu6G6pCohb57qVIZklaq6LD/rZu9kusgy5MWz391QSDPF+FqdNeM+iqoAUampdf1nzvAi
        ENF4jftCI5Tmfv3i5TtBmQkw3yAWI2eK8wnXcw9uKVQlSazJTiC1w1Ojy+9l19FHgPir4d
        ObdZdKLRsjTrhp6qZ2KSO0GBJciujrQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-Hs1X6Xa4Pq-5YG-OUq2auw-1; Wed, 14 Apr 2021 11:16:14 -0400
X-MC-Unique: Hs1X6Xa4Pq-5YG-OUq2auw-1
Received: by mail-wr1-f71.google.com with SMTP id k1-20020adfd2210000b02901040d1dbcaeso1211625wrh.17
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wi7Vsx7fsiQc/wyHgFKatT0Y76VokmNc3vRxm+hzn58=;
        b=jidQQ1um3SUU9lqzJ8t0v0u/FfTu6lYCq4875eG3Q0srh5s4iodbuOICajCIuvUFVl
         XmX7pmlUYrlpZ6JqVgZViWKKUz2jLylE7Tta17jLAjf9pzPH3JHAaNAF7HPmzCMtkacm
         597vOr6X0vmNJNpHePb23BICwufZInsMHoyLaLWjip9dEB1wyAG2cQpJwNnyvEekfTwn
         NQSvGWaSQhxHRpisvxeLchgUYi/549z7FIWXHuLm2j6lV4XF6bcsk2ym95XQF25gG+K7
         Se4M0UEMs65Q44EXNjivqrG2gyGB7r020OXz1/DF5uVIrmXhOElMfVbtYYzpyqJSkiOR
         ZSXw==
X-Gm-Message-State: AOAM532MAziK0Z1rYURL4gz+Btn4bto4w00nPc0iaxnbxVYw+w0+Bkb4
        GDq1CVqXY/cc9XausylhlHd7EcluTh1KVA7HjX20MVcBE/94+QbVXwvZjzSPDP73Rw2zCBAG/IV
        uCkCeqEqWaySzDyjLhAT7AEl2QjrI63v0GZ5mvepgkyJrPYATt654QL0ynVfvTDd8GzJAIvBn
X-Received: by 2002:a1c:4b13:: with SMTP id y19mr3695859wma.12.1618413372982;
        Wed, 14 Apr 2021 08:16:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy35JMmK9bF2B+eF87l+y5GGmoAQLNqebx4EHnd7JjEV1/GA3x6z5GH9wCqSz0nLPLczE/QXQ==
X-Received: by 2002:a1c:4b13:: with SMTP id y19mr3695830wma.12.1618413372675;
        Wed, 14 Apr 2021 08:16:12 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6470.dip0.t-ipconnect.de. [91.12.100.112])
        by smtp.gmail.com with ESMTPSA id r2sm9575003wrt.79.2021.04.14.08.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:16:12 -0700 (PDT)
Subject: Re: [PATCHv2] mm/mmap.c: lines in __do_munmap repeat logic of inlined
 find_vma_intersection
To:     Gonzalo Matias Juarez Tello <gmjuareztello@gmail.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210408034632.r5nor5akqo5o3aus@monty>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <459c338e-bd9b-fb27-5d6f-f217b684a9e3@redhat.com>
Date:   Wed, 14 Apr 2021 17:16:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210408034632.r5nor5akqo5o3aus@monty>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.21 05:46, Gonzalo Matias Juarez Tello wrote:
> Some lines in __do_munmap used the same logic as find_vma_intersection
> (which is inlined) instead of directly using that function.
> 
> (Can't believe I made a typo in the first one, compiled this one,
> sorry first patch kinda nervous for some reason)
> 
> Signed-off-by: Gonzalo Matias Juarez Tello <gmjuareztello@gmail.com>
> ---
>   mm/mmap.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3f287599a7a3..1b29f8bf8344 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2823,15 +2823,10 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>   	arch_unmap(mm, start, end);
>   
>   	/* Find the first overlapping VMA */
> -	vma = find_vma(mm, start);
> +	vma = find_vma_intersection(mm, start, end);
>   	if (!vma)
>   		return 0;
>   	prev = vma->vm_prev;
> -	/* we have  start < vma->vm_end  */
> -
> -	/* if it doesn't overlap, we have nothing.. */
> -	if (vma->vm_start >= end)
> -		return 0;
>   
>   	/*
>   	 * If we need to split any vma, do it now to save pain later.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

