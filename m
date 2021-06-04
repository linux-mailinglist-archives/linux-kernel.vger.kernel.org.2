Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FA839B7A7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhFDLN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhFDLNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:13:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9616C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 04:11:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a11so13194225ejf.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BQUG9rLBagDE3J7LSSE86X2TmT7SF5szEvUlFFOgXJw=;
        b=AKZLZ9RcuNFtFpU2HlORqN+F0aDDdPOWEF0LmofzDUBzJVQxFuF03Iopw5UfbJo6wj
         dCrODKC6J9QggYjr4fn+5Awk3p7KTQYHQBkcLM1VihBqGR1yRXvQVP6e7d/xU54vcYkB
         Kf1up2JPH+87j0n8Tibjo70vosVzALe5dWICqux0nf6Aezw7orz+x73+DWy4ZrWUyOCY
         2vqQRKvQrlthlG6farlgGqrDkOtJxzsyNp/+xeB8Q8yPAIHC0ZxoJzB//UvhLDZvn3ed
         lVZTcZaSQsWE9rpJ6UmFkZlzCo+di9rjRRMIkkDoIPzI7iQevgYFl5uiNOHowCKBgpQg
         Ng7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BQUG9rLBagDE3J7LSSE86X2TmT7SF5szEvUlFFOgXJw=;
        b=LIq2QU7P3bxHqlASv2PJj92itqU/sOfmgw4Ive/W25KUiRt1+BLb67CjGQnV/NNLZG
         lctWubZOJ1QLTZ8mAzE54P/GQD2VsBwGSrRgbz6G56om+Z9+7dfA28pJzNCKaTPJ9CM6
         gDUrKXKEDWo1Uw6PBmdYYBSpA0hw9LV9Obn96hHiQvmSdY7xpFXaomTn3o0Lga0PfzE/
         JjV7u5MTKVp6qFFAGLaNzGFPn7uZjdlahFYa9EB1qdvzyed3whF5XxfzRWop1HQ9E5w5
         yiqJaROFn5Llz+oiOGebyi5oXz6D/fTUKaognpJhxq04LrXmgWR/hI4JdiPhFLFL8xe+
         l3yg==
X-Gm-Message-State: AOAM530nfoVplvWJC6R4oNElH+sxbws+iHTgLMKcIRDAP/fMIf8ulug8
        xUd9I4kxbh7f7zoE2vVuggEg/g1gGMw=
X-Google-Smtp-Source: ABdhPJxwOi2L/qa3p1KrMVaJKXxi1zF8E7uZF06kEzz3kjvluKA7vA7S+LWJ1SpnGlbw7LFo89zKHg==
X-Received: by 2002:a17:906:5f93:: with SMTP id a19mr3677884eju.18.1622805098334;
        Fri, 04 Jun 2021 04:11:38 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7b4b:873a:17b5:b581? ([2a02:908:1252:fb60:7b4b:873a:17b5:b581])
        by smtp.gmail.com with ESMTPSA id dy19sm3062992edb.68.2021.06.04.04.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 04:11:37 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Use vma_lookup() in
 amdgpu_ttm_tt_get_user_pages()
To:     Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
References: <20210603160928.3854180-1-Liam.Howlett@Oracle.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4d2e62c7-af4c-b977-a05c-97b664b532b3@gmail.com>
Date:   Fri, 4 Jun 2021 13:11:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210603160928.3854180-1-Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.06.21 um 18:09 schrieb Liam Howlett:
> Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
> will return NULL if the address is not within any VMA, the start address
> no longer needs to be validated.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 7cb7ffdd1900..dfb5ca3f8da8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -680,9 +680,9 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>   		return -ESRCH;
>   
>   	mmap_read_lock(mm);
> -	vma = find_vma(mm, start);
> +	vma = vma_lookup(mm, start);
>   	mmap_read_unlock(mm);
> -	if (unlikely(!vma || start < vma->vm_start)) {
> +	if (unlikely(!vma)) {
>   		r = -EFAULT;
>   		goto out_putmm;
>   	}

