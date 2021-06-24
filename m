Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9273B2872
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 09:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhFXHVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 03:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231132AbhFXHVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624519153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6n4tQbCk5yGGBrv9C1IRK1k5LS9c127mX5xrH4taZU=;
        b=cDuPmdBAC+RUvjfaDNP1AkcTF5eAc7L/oRj6/jXoCNtssukNBXMIcNL3OCgTjtWI6nLf6Z
        UgyIPUm/nfc9Q3cqu8R74en5GpTpw/oAT6RwjmvKnW7v4stRe8u6aRBkf14+AY4UzPEqL9
        r7l2EaZ9ajYWqYk7yQqHJ1fG28+6yFk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-C8M04j_6MbGIxl9rduK1Hg-1; Thu, 24 Jun 2021 03:19:12 -0400
X-MC-Unique: C8M04j_6MbGIxl9rduK1Hg-1
Received: by mail-wm1-f72.google.com with SMTP id u17-20020a05600c19d1b02901af4c4deac5so1268965wmq.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 00:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R6n4tQbCk5yGGBrv9C1IRK1k5LS9c127mX5xrH4taZU=;
        b=fbQMDa558eQcZJ/xphweICMDkdgARMqFoIChnJesKvZeVX/huQyVNvVBiVlIq47dvu
         PYUjzGmw8sP1eGUYXpYjBqCnJYCAPD/eA8Zfc70KLDHM6tZSoVrWq5g1bwvyOefJNGrG
         EonVo222JT2IFHdgcYVMNhp1J7L/+oSma6P/dXsy96ORjoxIa2kRLopHBQcFokohcl5y
         3ZKoPGy1SOTrL96r/pSR9mlZXMfarm8JWG0vrlPtWXuqqlT2i15XYfN6o0PP7CQtKcSL
         tbRBRX+rAGuHPV294V6i/Av5wHgT76Z6CMFC2DAvUKqquHm3mcg9iIwc8GBMyaYLnECP
         KH+w==
X-Gm-Message-State: AOAM533VbRfvnBFjJuSayBz+di6+759/lH1hBChgfTdNx53KXbVLa6Dq
        eltxxD0AiNOWj3qBekQu9wyWVam2iEGz0yzYdxiHQw3lY05P5JoHN5iljmupQIr8/6JQAtkjDt8
        2DCuihXr/RMsFQRyXhzPSa4ut
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr2663892wrk.197.1624519150935;
        Thu, 24 Jun 2021 00:19:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGKo51RB8xyk8mP5Z+OGJr8xFyOiKLx8k3DwXs4BHwm1bEoR5CAQaTWbrQw0zA0na7dnAfgQ==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr2663874wrk.197.1624519150798;
        Thu, 24 Jun 2021 00:19:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p15sm1947285wmq.43.2021.06.24.00.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 00:19:10 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: Fix mapping length truncation in
 m{,un}map()
To:     Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com
Cc:     wanghaibin.wang@huawei.com
References: <20210624070931.565-1-yuzenghui@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <836e058c-6bb1-7643-98c2-713b111c9fb8@redhat.com>
Date:   Thu, 24 Jun 2021 09:19:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210624070931.565-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/21 09:09, Zenghui Yu wrote:
> max_mem_slots is now declared as uint32_t. The result of (0x200000 * 32767)
> is unexpectedly truncated to be 0xffe00000, whilst we actually need to
> allocate about, 63GB. Cast max_mem_slots to size_t in both mmap() and
> munmap() to fix the length truncation.
> 
> We'll otherwise see the failure on arm64 thanks to the access_ok() checking
> in __kvm_set_memory_region(), as the unmapped VA happen to go beyond the
> task's allowed address space.
> 
>   # ./set_memory_region_test
> Allowed number of memory slots: 32767
> Adding slots 0..32766, each memory region with 2048K size
> ==== Test Assertion Failure ====
>    set_memory_region_test.c:391: ret == 0
>    pid=94861 tid=94861 errno=22 - Invalid argument
>       1	0x00000000004015a7: test_add_max_memory_regions at set_memory_region_test.c:389
>       2	 (inlined by) main at set_memory_region_test.c:426
>       3	0x0000ffffb8e67bdf: ?? ??:0
>       4	0x00000000004016db: _start at :?
>    KVM_SET_USER_MEMORY_REGION IOCTL failed,
>    rc: -1 errno: 22 slot: 2615
> 
> Fixes: 3bf0fcd75434 ("KVM: selftests: Speed up set_memory_region_test")
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>   tools/testing/selftests/kvm/set_memory_region_test.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index d79d58eada9f..85b18bb8f762 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -376,7 +376,7 @@ static void test_add_max_memory_regions(void)
>   	pr_info("Adding slots 0..%i, each memory region with %dK size\n",
>   		(max_mem_slots - 1), MEM_REGION_SIZE >> 10);
>   
> -	mem = mmap(NULL, MEM_REGION_SIZE * max_mem_slots + alignment,
> +	mem = mmap(NULL, (size_t)max_mem_slots * MEM_REGION_SIZE + alignment,
>   		   PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>   	TEST_ASSERT(mem != MAP_FAILED, "Failed to mmap() host");
>   	mem_aligned = (void *)(((size_t) mem + alignment - 1) & ~(alignment - 1));
> @@ -401,7 +401,7 @@ static void test_add_max_memory_regions(void)
>   	TEST_ASSERT(ret == -1 && errno == EINVAL,
>   		    "Adding one more memory slot should fail with EINVAL");
>   
> -	munmap(mem, MEM_REGION_SIZE * max_mem_slots + alignment);
> +	munmap(mem, (size_t)max_mem_slots * MEM_REGION_SIZE + alignment);
>   	munmap(mem_extra, MEM_REGION_SIZE);
>   	kvm_vm_free(vm);
>   }
> 

Queued, thanks.

Paolo

