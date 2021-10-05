Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED174232C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbhJEVWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbhJEVWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:22:12 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E3BC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 14:20:21 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id l20so807774ilk.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kC50MuF3+X16QbRLByewBMz1E35GzjVs9lAfPxIXfYY=;
        b=5gAjizCN0+xg1wqdFirBr2akZtrNHJBUUYuXonWwu9LHMnEb1Nx34amz+UXEg/QmeZ
         u+GmFPDT1tknv1UW4nSxIV7k+sXHKr0cOSpNFaHexwzAnHmncsm98gIRigvW3BIUc2Ev
         rnYo8tn/3F9k0pg3zFai44OOv2zKR45ocJEPF5tLwmPiHjQXfD0DJ35g3jnV46QS8Sl0
         p4aWHW6fTiUl0Poh5fpkDCq5yx10Vsf+4tCAbwBpZyJTiuw7ik+VQmZFy1e+GKJCZA7u
         4sVeIDRAvP4t32aL+FvA5NBftnDwJyoPm5DRCM24eOpTOFLsORRdsMpgFtZ+DFF1lXmD
         wj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kC50MuF3+X16QbRLByewBMz1E35GzjVs9lAfPxIXfYY=;
        b=R2UG5ALsEwNhAlWbgGTdKZB1hy5gJlKqApTgDd8vhaCMihMBjVw0CoWn8AD40VyYbB
         lTDZj/eKGencPHts00xWBO5aM2R4Mn+oFuC8aMDBE5Hjm0/huzzgfAxHloKwMJ+Bc4i7
         AZbCIrwCRQgzk/UQHZ+Ya4CpaCreRzmb9vAgnb3gJ5Dcqmw4P8G5pKEmpnk6Mr8aqqzD
         //gtQcm0/d6FZR2uBSXoKhcnoOucnHB1kX1+yQZWegqHiFaqEDkRfaKCNAKM7fOaBv/G
         c9c6zJHWF1wSAt4udI29G1XtuRu/HZWxjPET9TotXRrPCFoHTyco+gFnQ0gXfc7nifCm
         RYnA==
X-Gm-Message-State: AOAM532WHXlRiFBdB8zoWh3t8pavuSv6zWbnOFIwYxAVTA8ATIJbr2ZS
        2txMpETpy4zJYhpvMlQx5JUVj5/euERf+Q==
X-Google-Smtp-Source: ABdhPJyxDvD4dpKia8kex6Jq5Da7OfkFnRilk6VuiKOkhyP69RgWjQ7LEhDA3tnIHZT/L45BaIJ3/w==
X-Received: by 2002:a92:c012:: with SMTP id q18mr4614971ild.84.1633468820840;
        Tue, 05 Oct 2021 14:20:20 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b11sm6006843ile.12.2021.10.05.14.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 14:20:20 -0700 (PDT)
Subject: Re: [PATCH] mm: don't call should_failslab() for !CONFIG_FAILSLAB
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <e01e5e40-692a-519c-4cba-e3331f173c82@kernel.dk>
 <20211005141832.d6f3d4e06c4ad7a06cd554dd@linux-foundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <316ad54a-67e9-879d-c406-6a4a606924aa@kernel.dk>
Date:   Tue, 5 Oct 2021 15:20:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211005141832.d6f3d4e06c4ad7a06cd554dd@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 3:18 PM, Andrew Morton wrote:
> On Tue, 5 Oct 2021 09:31:43 -0600 Jens Axboe <axboe@kernel.dk> wrote:
> 
>> Allocations can be a very hot path, and this out-of-line function
>> call is noticeable.
>>
>> --- a/include/linux/fault-inject.h
>> +++ b/include/linux/fault-inject.h
>> @@ -64,8 +64,8 @@ static inline struct dentry *fault_create_debugfs_attr(const char *name,
>>  
>>  struct kmem_cache;
>>  
>> -int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
>>  #ifdef CONFIG_FAILSLAB
>> +int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
>>  extern bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags);
>>  #else
>>  static inline bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 58c01a34e5b8..92fd6fe01877 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -491,8 +491,10 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
>>  
>>  	might_alloc(flags);
>>  
>> +#ifdef CONFIG_FAILSLAB
>>  	if (should_failslab(s, flags))
>>  		return NULL;
>> +#endif
> 
> Can we avoid the ifdefs here?
> 
>>  
>>  	if (!memcg_slab_pre_alloc_hook(s, objcgp, size, flags))
>>  		return NULL;
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index ec2bb0beed75..c21bd447f237 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1323,6 +1323,7 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc_node);
>>  EXPORT_TRACEPOINT_SYMBOL(kfree);
>>  EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
>>  
>> +#ifdef CONFIG_FAILSLAB
>>  int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>>  {
>>  	if (__should_failslab(s, gfpflags))
>> @@ -1330,3 +1331,4 @@ int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>>  	return 0;
>>  }
>>  ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
>> +#endif
> 
> Like,
> 
> --- a/include/linux/fault-inject.h~mm-dont-call-should_failslab-for-config_failslab-fix
> +++ a/include/linux/fault-inject.h
> @@ -68,6 +68,10 @@ struct kmem_cache;
>  int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
>  extern bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags);
>  #else
> +static inline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
> +{
> +	return 0;
> +}
>  static inline bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>  {
>  	return false;
> --- a/mm/slab.h~mm-dont-call-should_failslab-for-config_failslab-fix
> +++ a/mm/slab.h
> @@ -491,10 +491,8 @@ static inline struct kmem_cache *slab_pr
>  
>  	might_alloc(flags);
>  
> -#ifdef CONFIG_FAILSLAB
>  	if (should_failslab(s, flags))
>  		return NULL;
> -#endif
>  
>  	if (!memcg_slab_pre_alloc_hook(s, objcgp, size, flags))
>  		return NULL;
> _

Yep, that'll work!

-- 
Jens Axboe

