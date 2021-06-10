Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0403A2A95
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 13:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFJLsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 07:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhFJLsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623325593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/8j+wnWnTfb6LCWk89bGRuT4Gfnv7Lqnj2YgU0Psg0=;
        b=dX8JJzQVpYtYpqUG3Pf9+7/vvMDrpAK6uHcZ89dziw2BjJRSStcCTUonEdazbWvuSPqu79
        bG0IyQBJQhzRYAHKH9jFNfIT41Jo0i+1QZG63GSeQoideqcrgg8e7OW0Y54wACrN5uPYME
        4WQH77TG21g09xPF0lDJrOAqhWqf4f0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-7ubt7w3FM-6sJSO_7Ccl7A-1; Thu, 10 Jun 2021 07:46:30 -0400
X-MC-Unique: 7ubt7w3FM-6sJSO_7Ccl7A-1
Received: by mail-wr1-f70.google.com with SMTP id q15-20020adfc50f0000b0290111f48b865cso784233wrf.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 04:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I/8j+wnWnTfb6LCWk89bGRuT4Gfnv7Lqnj2YgU0Psg0=;
        b=A/+OX8IPjw2boo/ArQq6fbW0R6SxzrqTPFatB6FJwBBBRLDbWvkvBf+7kbNrvwLm+s
         pxM+yIqSbKrQKLNGVy2DykSsMa4RLz3DmSVQr4+wSzUpcsAExLQUVqP86plpXia3wtsu
         vU4UvSZjd+BqaZp9PxIo0ztq2AlR5MDfn9s+553rjunHgwB3ZDL5WdyspwvdyN7Nynt2
         x8wxzyvvB6CNfJNLt0+DDENeMuBnS4ZP7bWsVfYI8yKfW8t+VH1Q9O35Kgctr1Oiv0UZ
         JR56YShCMyEJ6L6/AOyNb73upiYutqifeRxfrL7l3FLzUCBtc7y73AdAlZGYtdBfexYR
         PaHA==
X-Gm-Message-State: AOAM532Ng6VhPtTFZL7unDzLTnLdsgTxOKoWY4Yw75FRPGau7Df3SJ+V
        5xKi8VJL0tOiQYvk4Fp5cxHNgAyW8eUbb5/Y61uJ45HSJWkntG9sKdAS3WycBUYGKjb0jq9PagH
        VBp026HtYi39G3kHjqXslVOf6
X-Received: by 2002:a5d:48c6:: with SMTP id p6mr4963276wrs.45.1623325589182;
        Thu, 10 Jun 2021 04:46:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAY/peyXscV9r/3ZUt4QDtJlFNFailIfzbp8EjaoRTUVSlJrRv2T10doUS2XUyySbuumKZAg==
X-Received: by 2002:a5d:48c6:: with SMTP id p6mr4963260wrs.45.1623325588983;
        Thu, 10 Jun 2021 04:46:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id w23sm9281904wmi.0.2021.06.10.04.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 04:46:28 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: Fix compiling errors when initializing
 the static structure
To:     Yanan Wang <wangyanan55@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ben Gardon <bgardon@google.com>,
        Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com
References: <20210610085418.35544-1-wangyanan55@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <43c197da-0ff7-5b95-0778-e5b19fa4f942@redhat.com>
Date:   Thu, 10 Jun 2021 13:46:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610085418.35544-1-wangyanan55@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/21 10:54, Yanan Wang wrote:
> Errors like below were produced from test_util.c when compiling the KVM
> selftests on my local platform.
> 
> lib/test_util.c: In function 'vm_mem_backing_src_alias':
> lib/test_util.c:177:12: error: initializer element is not constant
>      .flag = anon_flags,
>              ^~~~~~~~~~
> lib/test_util.c:177:12: note: (near initialization for 'aliases[0].flag')
> 
> The reason is that we are using non-const expressions to initialize the
> static structure, which will probably trigger a compiling error/warning
> on stricter GCC versions. Fix it by converting the two const variables
> "anon_flags" and "anon_huge_flags" into more stable macros.
> 
> Fixes: b3784bc28ccc0 ("KVM: selftests: refactor vm_mem_backing_src_type flags")
> Reported-by: Zenghui Yu <yuzenghui@huawei.com>
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>   tools/testing/selftests/kvm/lib/test_util.c | 38 ++++++++++-----------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index 6ad6c8276b2e..af1031fed97f 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -166,75 +166,75 @@ size_t get_def_hugetlb_pagesz(void)
>   	return 0;
>   }
>   
> +#define ANON_FLAGS	(MAP_PRIVATE | MAP_ANONYMOUS)
> +#define ANON_HUGE_FLAGS	(ANON_FLAGS | MAP_HUGETLB)
> +
>   const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
>   {
> -	static const int anon_flags = MAP_PRIVATE | MAP_ANONYMOUS;
> -	static const int anon_huge_flags = anon_flags | MAP_HUGETLB;
> -
>   	static const struct vm_mem_backing_src_alias aliases[] = {
>   		[VM_MEM_SRC_ANONYMOUS] = {
>   			.name = "anonymous",
> -			.flag = anon_flags,
> +			.flag = ANON_FLAGS,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_THP] = {
>   			.name = "anonymous_thp",
> -			.flag = anon_flags,
> +			.flag = ANON_FLAGS,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB] = {
>   			.name = "anonymous_hugetlb",
> -			.flag = anon_huge_flags,
> +			.flag = ANON_HUGE_FLAGS,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_16KB] = {
>   			.name = "anonymous_hugetlb_16kb",
> -			.flag = anon_huge_flags | MAP_HUGE_16KB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_16KB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_64KB] = {
>   			.name = "anonymous_hugetlb_64kb",
> -			.flag = anon_huge_flags | MAP_HUGE_64KB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_64KB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_512KB] = {
>   			.name = "anonymous_hugetlb_512kb",
> -			.flag = anon_huge_flags | MAP_HUGE_512KB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_512KB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_1MB] = {
>   			.name = "anonymous_hugetlb_1mb",
> -			.flag = anon_huge_flags | MAP_HUGE_1MB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_1MB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_2MB] = {
>   			.name = "anonymous_hugetlb_2mb",
> -			.flag = anon_huge_flags | MAP_HUGE_2MB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_2MB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_8MB] = {
>   			.name = "anonymous_hugetlb_8mb",
> -			.flag = anon_huge_flags | MAP_HUGE_8MB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_8MB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_16MB] = {
>   			.name = "anonymous_hugetlb_16mb",
> -			.flag = anon_huge_flags | MAP_HUGE_16MB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_16MB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_32MB] = {
>   			.name = "anonymous_hugetlb_32mb",
> -			.flag = anon_huge_flags | MAP_HUGE_32MB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_32MB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_256MB] = {
>   			.name = "anonymous_hugetlb_256mb",
> -			.flag = anon_huge_flags | MAP_HUGE_256MB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_256MB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_512MB] = {
>   			.name = "anonymous_hugetlb_512mb",
> -			.flag = anon_huge_flags | MAP_HUGE_512MB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_512MB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB] = {
>   			.name = "anonymous_hugetlb_1gb",
> -			.flag = anon_huge_flags | MAP_HUGE_1GB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_1GB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB] = {
>   			.name = "anonymous_hugetlb_2gb",
> -			.flag = anon_huge_flags | MAP_HUGE_2GB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_2GB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB] = {
>   			.name = "anonymous_hugetlb_16gb",
> -			.flag = anon_huge_flags | MAP_HUGE_16GB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_16GB,
>   		},
>   		[VM_MEM_SRC_SHMEM] = {
>   			.name = "shmem",
> 

Queued, thanks.

Paolo

